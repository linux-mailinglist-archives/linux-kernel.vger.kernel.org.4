Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6481635432
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbiKWJFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiKWJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:04:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694541025D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669194274; x=1700730274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gAQRuYWg/Tk+lKUpTo8FpAd2y7tRkY04gj36jj3Nf30=;
  b=OsGcQ1aPFfFPtpt1SXXZc73o2kuDvbv2FrL1lULw3ADZHS2ubwljYYYW
   4ePdYRA4agRZowz49zzLu7SVHboOtKnInwZcZEKPUG4TXlTmtB98Yykfz
   mVZRh6L3Ijzg0DTzh9KFC84FGsqKjycjsRjOeN3jwsrnITIsVCH8qKILf
   yFgzRFEUUasZuS6njcHqsj4CduY3IPTZnwScR1CmNyLUKGz8x0/7EhMHk
   kc+sHJj3MaDEnoRJ0AX186uLslZ9O4wXQRyPVTC6MiqiexABwWjNr6HAU
   c98fyCF0t/a9b39fETYB+zNUfFUfcXvzdZNebTNQ7gvbLGlYD54XMmKy8
   w==;
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="124738248"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Nov 2022 02:04:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 23 Nov 2022 02:04:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 23 Nov 2022 02:04:31 -0700
Date:   Wed, 23 Nov 2022 09:04:13 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel@sholland.org>
CC:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <dmitriy@oss-tech.org>,
        <paul.walmsley@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] Revert "clocksource/drivers/riscv: Events are stopped
 during CPU suspend"
Message-ID: <Y33iDVTuSglaN0O4@wendy>
References: <20221122121620.3522431-1-conor.dooley@microchip.com>
 <a218ebf8-0fba-168d-6598-c970bbff5faf@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a218ebf8-0fba-168d-6598-c970bbff5faf@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Samuel,

On Tue, Nov 22, 2022 at 11:49:49PM -0600, Samuel Holland wrote:
> On 11/22/22 06:16, Conor Dooley wrote:
> > This reverts commit 232ccac1bd9b5bfe73895f527c08623e7fa0752d.

> > To fix this, the x86 C3STOP feature was enabled for the timer driver -
> 
> C3STOP isn't inherently x86-specific.

I think I originally had feature with "s around it & meant this as a
tongue-in-cheek reference to the header, which describes it as an "x86
(mis)feature" or something like that. Think I decided against that but
forgot to drop the x86 bit..
Could easily do s/x86// and it'd still make sense.

> > Fortunately, the D1 has a second timer, which is "currently used in
> > preference to the RISC-V/SBI timer driver" so a revert here does not
> > hurt operation of D1 in it's current form.
> 
> typo: its

Good spot :)

> Acked-by: Samuel Holland <samuel@sholland.org>

Thanks!

Perhaps the two minor commit message bits could be fixed on application?
Otherwise, I will send a reworded one in a few days.

Conor.

