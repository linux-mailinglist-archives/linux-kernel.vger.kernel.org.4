Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF48706C13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjEQPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjEQPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:04:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A20A26E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684335852; x=1715871852;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N1BSP4Ia8BM8HI0rdakyWqbYxRwvAQiEFATJFkkYIKE=;
  b=adqyOYn2Hpv2Qq2WHHmz9g7PGUqLsyufNuvRsmScQc6Mw7dwPX0B971H
   TDB48/dkCRK/0fazpUHsxrYo3PE1uzOf05asKGCKsezfQSrhM1vGBW0hM
   bs8hK73oiAHX2jN8gJFxQ5gThudTUawJFjvpuAvks2aHr7BA4Zxi0zvxv
   GK6AuY9+kQo7PCxVkLB45e0iGJu1B132JbyzlmvxE0HbYFsa9oIH4YNb3
   64xHBsOtSnOFAMKTJokHfu61uFHgQOjRn79AHvoTck6PfuKBwtyZo5hoj
   XEK932Wmok6Y+y2MyEIxwUpNKEbz3KBwGEiY6OGdDkK2g6FrTmBMpt4ai
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="354081700"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="354081700"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 08:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652277172"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="652277172"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 08:03:23 -0700
Message-ID: <38bf4bce7961c674b7ac798a8413cb1256eea8f4.camel@linux.intel.com>
Subject: Re: [PATCH] MTD SPI-NOR: BUG FIX of divide by zero in new n_banks
 value
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Todd Brandt <todd.e.brandt@intel.com>,
        miquel.raynal@bootlin.com, linux-kernel@vger.kernel.org
Cc:     pratyush@kernel.org,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 17 May 2023 08:03:23 -0700
In-Reply-To: <3ab922a4-255a-5aef-86ba-d906819f0f3a@linaro.org>
References: <20230516225108.29194-1-todd.e.brandt@intel.com>
         <3ab922a4-255a-5aef-86ba-d906819f0f3a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-17 at 08:10 +0100, Tudor Ambarus wrote:
> Hi, Todd,
> 
> On 5/16/23 23:51, Todd Brandt wrote:
> > While testing 6.4-rc1 on our Lenovo Thinkpad X1 I discovered
> > that freeze, suspend, and shutdown, all hang the system. I bisected
> > it to an addition made to the MTD spi-nor code.
> > 
> > The new "n_banks" value is being divided into without a proper
> > check..
> > Thus on certain systems this causes a divide by zero hang.
> > 
> > Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217448
> > Fixes: 9d6c5d64f028 ("mtd: spi-nor: Introduce the concept of bank")
> > Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-
> > nor/core.c
> > index 0bb0ad14a2fc..084117959be4 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2921,7 +2921,10 @@ static void spi_nor_late_init_params(struct
> > spi_nor *nor)
> >  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
> >  		spi_nor_init_default_locking_ops(nor);
> >  
> > -	nor->params->bank_size = div64_u64(nor->params->size, nor-
> > >info->n_banks);
> > +	if (nor->info->n_banks > 0)
> > +		nor->params->bank_size = div64_u64(nor->params->size,
> > nor->info->n_banks);
> > +	else
> > +		nor->params->bank_size = 0;
> >  }
> >  
> >  /**
> 
> Indeed, thanks for the report and patch. You probably use the
> spi-nor-generic driver, don't you?
> 
> Can you try the following change instead?

Yes, this also seems to fix things on the Lenovo Thinkpad X1, but the
solution should be this AND the "if (nor->info->n_banks > 0)" patch. It
doesn't hurt to check even if it's a very unlikely border case. It
guarantees that the issue won't occur again even if somehow a struct
instance is created uninitialized.

You could probably just slim it down to a single if line instead of
if/else since the default bank_size is zero by default:

+   if (nor->info->n_banks > 0)
+       nor->params->bank_size = div64_u64(nor->params->size, nor-
>info->n_banks);

> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>                       index 0bb0ad14a2fc..37f750bd7bfb 100644
> --- a/drivers/mtd/spi-nor/core.cdrivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.cdrivers/mtd/spi-nor/core.c
> @@ -2018,6 +2018,7 @@ static const struct spi_nor_manufacturer
> *manufacturers[] = {
> 
>  static const struct flash_info spi_nor_generic_flash = {
>         .name = "spi-nor-generic",
> +       .n_banks = 1,
>         /*
>          * JESD216 rev A doesn't specify the page size, therefore we
> need a
>          * sane default.

