Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95096620A28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbiKHH1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKHH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:27:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F112AE11
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 23:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667892440; x=1699428440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Vt3J4Mn7GkFJJO5BFUFxQ3kzvBVb6hwR7aE8anuX8s=;
  b=OencWi271r+yS05fuQeO2VH/QGyA9krznivkhzRSto/JP8VILdUkDIOf
   R1KZwY/k+YsSu9qmjZx2O8xHdHg+cYd6ECV+Ckv4f+sRdMHveQwwfa0PJ
   O6i6RhkdMucKdxv5dHik3O/yhJx4D2ByEBbpyRqvKjFq0b5D4fClXQK+w
   0OWfaaQEfFc0OtUg7zNAmlL6GeagYl1bPghqwvevMXl6bqfqsT6rKPtGQ
   bSvCCX4iXjsKwODt6+o9ofvPG5D30+EnllVz/YHYS44r6fNMWhO048v5r
   rot0oD/BZ6xntTvVjkN7VlSwXbmoWeNsqRz6UeuIvgExpHHs+bt6IaitK
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="198854919"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2022 00:27:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 8 Nov 2022 00:27:19 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 8 Nov 2022 00:27:17 -0700
Date:   Tue, 8 Nov 2022 07:27:01 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evgenii Shatokhin <e.shatokhin@yadro.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Valentina Fernandez" <valentina.fernandezalanis@microchip.com>
Subject: Re: [PATCH v1] riscv: fix reserved memory setup
Message-ID: <Y2oExSUbPoziPyjt@wendy>
References: <20221107151524.3941467-1-conor.dooley@microchip.com>
 <497c057d-4e7d-0dcb-fd4c-2c7ef6efb573@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <497c057d-4e7d-0dcb-fd4c-2c7ef6efb573@yadro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 12:40:19AM +0300, Evgenii Shatokhin wrote:
> Hi,

> Thank you for looking into this!
> 
> As I wrote earlier, I ran into this issue too, while working on a remoteproc
> driver for our RISC-V-based SoC.
> 
> The proposed patch fixes the bug for me and seems to have no problematic
> side-effects. So:
> 
> Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>

Apologies for forgetting to add the T-b tag & thanks for re-sending it.
Conor.
