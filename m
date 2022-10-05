Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2A5F5299
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJEK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJEK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:29:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2DC1571F;
        Wed,  5 Oct 2022 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664965789; x=1696501789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5E4QJjuCCvDQ9v5hxdicxtlW9u5VvqxJSbrtoVqnEOg=;
  b=17p32s08nbQ/0uGDfLKSQ1h8mkKDrKhlQC7NHFnQf8o54GQjK3mmMUcc
   Xra1RT4Yl+53bW9of0xjPjq4BjG0l9RMYv0+dd/ybOrMY4Nb+rbCZL3/1
   iOTxJNLwO4AF42VO6xV7BDsQGVJ/2x97qMZ+Ep3jYo/9rmRsFU/b3fhav
   x7az5gAbB5M/AURfyMtGb2AFNdLJJXUWq8xT4mIyjZg6KYMHdJo9sryRh
   5Mh0Q/lEMDMMKuEb6zEAj7Lc/My32oVSieCcM4iaUY7osFt3oWYWHTLBG
   lG/865rL7NLzrDsSDAEVZfDHmYdC8xByjV/4OLf0QZWw4skoSEVcQwGH2
   A==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="177122166"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2022 03:29:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 5 Oct 2022 03:29:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 5 Oct 2022 03:29:41 -0700
Date:   Wed, 5 Oct 2022 11:29:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     <conor@kernel.org>, <geert+renesas@glider.be>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <magnus.damm@gmail.com>,
        <heiko@sntech.de>, <guoren@kernel.org>, <philipp.tomsich@vrull.eu>,
        <nathan@kernel.org>, <atishp@rivosinc.com>,
        <apatel@ventanamicro.com>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
Message-ID: <Yz1cgDOCdY41ip0y@wendy>
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YzxwoELNBctbhjJb@spud>
 <CA+V-a8tgvF16vduoQ+ZbzTpRJUmCnN-GPQs5G8AqMOXbnznwHA@mail.gmail.com>
 <F0B6C609-6C39-4080-8F07-7FEFFAFEA993@kernel.org>
 <5254a42c-9233-6f9a-eff8-33324a184d20@microchip.com>
 <CA+V-a8tS=vsTW=SvGeAjy_M9C=ZwtaWHYhdBK=XV0M9T_c3b5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+V-a8tS=vsTW=SvGeAjy_M9C=ZwtaWHYhdBK=XV0M9T_c3b5A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 11:20:40AM +0100, Lad, Prabhakar wrote:
> Hi Conor,
> 
> On Wed, Oct 5, 2022 at 10:17 AM <Conor.Dooley@microchip.com> wrote:
> >
> > On 05/10/2022 09:58, Conor Dooley wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > On 5 October 2022 09:44:56 IST, "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > >> Hi Conor,
> > >>
> > >> Thank you for the review.
> > >>
> > >> On Tue, Oct 4, 2022 at 6:43 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > >>>> +static void cpu_dcache_wb_range(unsigned long start,
> > >>>> +                             unsigned long end,
> > >>>> +                             int line_size)
> > >>>> +{
> > >>>> +     bool ucctl_ok = false;
> > >>>> +     unsigned long pa;
> > >>>> +     int mhartid = 0;
> > >>>> +#ifdef CONFIG_SMP
> > >>>> +     mhartid = smp_processor_id();
> > >>>> +#endif
> > >>>
> > >>> Won't this produce complaints from your if you compile with CONFIG_SMP
> > >>> set?
> > >>>
> > >> No I dont see a build issue with SMP enabled, do you see any reason
> > >> why it should fail?
> > >
> > > Not fail but complain about the unused variable.
> > >
> >
> > Not unused variable, sorry but the unused 0 that it was initialised with*
> 
> No, it doesn't complain (I dont think compilers complain of such
> unused assignments, maybe I'm wrong). BTW I am using GCC 9.4.0. Do you
> think I need to update it?

Maybe it's sparse that generates those warnings, I never know which it
is...
