Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD95631DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiKUKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiKUKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:12:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0322F036
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669025574; x=1700561574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pVdeoOFj7fYuCIS5ieay2j91M7ujDPFCdZJ8zE193G8=;
  b=VwnJg3yrVBLCqqPCJxRSDN1CLc+6vOV/akMNDuKj5eCUPXMxtBoUmq33
   1/0YK26L5YgmU7iAiSkWTryyShySzEa+qb/Xx9oqKa2o+kadLQRp4VYQg
   7UDbAGQkBuKGRRVbj+Kv+GT3tlczYd0qxVfipKo4DIpHewg5Bo3j1Gf1Z
   m8TJAlw7x7TnpCgC+ISEtAxNm/AkvE7odNgp6RnFqkZMeIJlf0HrwbicN
   JZ1xyqlV24TXFIZCX2VClIixquiBilxQLKX0Tfr6dM5rkbOGt8ScVs8dT
   zqqaMDRAchQp+YokaaRG7VNRXivB95ZEypElBHBdhGahdBaM/FPruvSAt
   g==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="189821766"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 03:12:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 03:12:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 21 Nov 2022 03:12:50 -0700
Date:   Mon, 21 Nov 2022 10:12:32 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <guoren@kernel.org>
CC:     <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <mhiramat@kernel.org>,
        <changbin.du@intel.com>, <zong.li@sifive.com>,
        <rostedt@goodmis.org>, <boqun.feng@gmail.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH V2] riscv: patch: Fixup lockdep warning in stop_machine
Message-ID: <Y3tPEDvM3aVJmVxF@wendy>
References: <20221120101049.2078117-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221120101049.2078117-1-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 05:10:49AM -0500, guoren@kernel.org wrote:
> From: Changbin Du <changbin.du@gmail.com>

> Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
> Cc: Changbin Du <changbin.du@gmail.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Zong Li <zong.li@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---

Hey Guo Ren,

FYI you're missing a SoB from Chanbin on this patch. They gave one in
their v1 though so you should be able to re-use that?

Thanks,
Conor.

> Changes in v2:
>  - Rewrite commit log with lockdep explanation [Guo Ren]
>  - Rebase on v6.1 [Guo Ren]
> 
> v1:
> https://lore.kernel.org/linux-riscv/20210417023532.354714-1-changbin.du@gmail.com/

