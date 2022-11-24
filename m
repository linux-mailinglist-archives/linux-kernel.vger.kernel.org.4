Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DE6372F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiKXHjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKXHjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:39:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF39893CD7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669275586; x=1700811586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5jayOGNCRzmZOnZq94GPZtulttwW/dTDlrUvW+mI14k=;
  b=VrFz4Hf7Qs55hsvIaqZfcQzgpDL4nnyeTFk2+Dc+gNg/j69/qupd8jm9
   TDcbavlX/l03GCUeOF8UgViBulVLzInaSQ1RXpUdWnkNUEqzvBnKBCLO8
   R7a2qkgReElM1tmjSCr5FqUYguVHyw0JHx2eabpMYMNG/FqfZCZ4LMLiV
   ckulBzkv4iTUyRQfEKdNgSWErYzjt03ahro4zcdQY344Hq1NQ8jPRFDWh
   0THz5wqplUndq7hCMzVL289rgO7W/Mc4ce+qcBgruvPxDg16q+Z5FIPgu
   XVXjjL+ZeTKuObK/CLwGnEJQVZWIxFKEfV/JgpUpfeAs2JVVgET0sUQRm
   g==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="190390175"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 00:39:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 00:39:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 24 Nov 2022 00:39:43 -0700
Date:   Thu, 24 Nov 2022 07:39:25 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Deepak Gupta <debug@rivosinc.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <linux-kernel@vger.kernel.org>,
        <paul.walmsley@sifive.com>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <Y38frY5H5mjCMvDR@wendy>
References: <20221124005006.1788315-1-debug@rivosinc.com>
 <A190DD6B-18A3-4DFE-AF8B-D5D50B6B6409@kernel.org>
 <20221124072346.GB1149630@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221124072346.GB1149630@debug.ba.rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:23:46PM -0800, Deepak Gupta wrote:
> On Thu, Nov 24, 2022 at 06:30:35AM +0000, Conor Dooley wrote:
> > On 24 November 2022 00:50:06 GMT, Deepak Gupta <debug@rivosinc.com> wrote:

> > For stack traces, especially long ones, please cut out the timestamps.

> I followed formatting of stack traces in commit 31da94c25ae. Assumed since
> that's merged, that's how test and stack traces should be included in commit
> msg.
> 
> I'll follow your suggestion and remove timestamps.

It's just nice for the reader, since the timestamps are pretty much
noise. But it's not a "you must do this", unlike having correct Fixes:
formatting etc.

HTH,
Conor.

