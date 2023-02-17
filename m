Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223769A316
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBQAr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBQAr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:47:27 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6540902F;
        Thu, 16 Feb 2023 16:47:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c11so3180285ple.9;
        Thu, 16 Feb 2023 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlJ6A9cfrJlIO+wGK9KmC3/LFTkLgJOWhgHblqdIQ8E=;
        b=iSEwCJWB4fIpF5H9XopMbzfYnD1poUko/fjLLTx8iI1GsSvX/3/YJYskvsR7iL2IDj
         xY/aWecVdPQCU6o+V/FdF/4wTrHdmQKKFnwDguYWtoT3vFlpNDnZ3UiSXdTolKFmYI37
         KG05lkDrp3arR3xZceRHPCMlyUu5TGEw7YSg9UzgzQMD2Sre86pBrNdWvR9GwYHI3DfU
         ciqjltZRhpwxwQJ5yOM7GfqGsL8RaOAog4UDIqUpTBpVdgDwo1llRA79y6lF9DDXRHQq
         dAyKRJ/mSwMuZTw1O8juIA0m2NCZ35qv4soZhmSkcQAI1iZ4TKJWPwPa1amSWwGyAxNY
         iKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlJ6A9cfrJlIO+wGK9KmC3/LFTkLgJOWhgHblqdIQ8E=;
        b=rMamCAKrD46rwcYkgdS0mgKT9Ip2ll9iZ05TIQe6AFXd7PHO8t5fHoAKwLKLEKA9Ir
         sVy51ddPj5ckhUx6VMR371DoR/4LZAvyic66Cyy6Rgj5L7yzOayO0OTqUloonocEL98b
         mhRI9VOloh2YuqXhmVVUJXmRnhQQUbwNmgR4V28bJFo+MgYkZJzz9YxmpDu9SWkLQVmQ
         2zjt4/mvjrHmtUjGmJMVh0ptyp3GG32oO8+Kl6wTmgwMi/Ms0Dyd+YKCpT1gJsOYL9lX
         ZF3lJQhaqGN1fmVvS3XO9xQk/Iy+tT4OSdjHyh16bkpWTtRKqH+I1M8fVVGSKUJ5e5G7
         Zw8A==
X-Gm-Message-State: AO0yUKVf5+4RV4eA8zRRIZxSIRsaeu4FuAoHWS4KelF1LuK1uynmlAu1
        AyoSDc5lB5dizgVejnTDDPM=
X-Google-Smtp-Source: AK7set9vslSy0EwgTQ09lOwiFJSqydhYYfbMRGVIM1vRak0I1xwQTU6ZzGwvutQq6cWI976DKGyaQw==
X-Received: by 2002:a17:90b:3ecd:b0:230:fe10:25a0 with SMTP id rm13-20020a17090b3ecd00b00230fe1025a0mr9050096pjb.11.1676594846136;
        Thu, 16 Feb 2023 16:47:26 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id h38-20020a631226000000b004fab2ba60adsm1680573pgl.81.2023.02.16.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 16:47:25 -0800 (PST)
Date:   Fri, 17 Feb 2023 11:47:18 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v2 3/5] apple-gmux: Use GMSP acpi method for interrupt
 clear
Message-ID: <20230217114718.7ff65c2f@redecorated-mbp>
In-Reply-To: <87d2068b-2644-0307-d722-5539b1f9fb36@redhat.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
        <20230216122342.5918-4-orlandoch.dev@gmail.com>
        <87d2068b-2644-0307-d722-5539b1f9fb36@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 14:07:53 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi Orlando,
> 
> Thank you for the new version patches 1 + 2 look good,
> one small remark on this one.
> 
> On 2/16/23 13:23, Orlando Chamberlain wrote:
> > This is needed for interrupts to be cleared correctly on MMIO based
> > gmux's. It is untested if this helps/hinders other gmux types, so
> > currently this is only enabled for the MMIO gmux's.
> > 
> > There is also a "GMLV" acpi method, and the "GMSP" method can be
> > called with 1 as its argument, but the purposes of these aren't
> > known and they don't seem to be needed.
> > 
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > ---
> > v1->v2: Only enable this on MMIO gmux's
> >  drivers/platform/x86/apple-gmux.c | 30
> > +++++++++++++++++++++++++++++- 1 file changed, 29 insertions(+), 1
> > deletion(-)
> > 
> > diff --git a/drivers/platform/x86/apple-gmux.c
> > b/drivers/platform/x86/apple-gmux.c index
> > 36208e93d745..12a93fc49c36 100644 ---
> > a/drivers/platform/x86/apple-gmux.c +++
> > b/drivers/platform/x86/apple-gmux.c @@ -76,6 +76,7 @@ struct
> > apple_gmux_config { enum vga_switcheroo_handler_flags_t
> > handler_flags; unsigned long resource_type;
> >  	bool read_version_as_u32;
> > +	bool use_acpi_gmsp;
> >  	char *name;
> >  };
> >  
> > @@ -488,6 +489,7 @@ static const struct apple_gmux_config
> > apple_gmux_pio = { .handler_flags = VGA_SWITCHEROO_CAN_SWITCH_DDC,
> >  	.resource_type = IORESOURCE_IO,
> >  	.read_version_as_u32 = false,
> > +	.use_acpi_gmsp = false,
> >  	.name = "classic"
> >  };
> >  
> > @@ -500,6 +502,7 @@ static const struct apple_gmux_config
> > apple_gmux_index = { .handler_flags =
> > VGA_SWITCHEROO_NEEDS_EDP_CONFIG, .resource_type = IORESOURCE_IO,
> >  	.read_version_as_u32 = true,
> > +	.use_acpi_gmsp = false,
> >  	.name = "indexed"
> >  };
> >  
> > @@ -511,8 +514,29 @@ static const struct apple_gmux_config
> > apple_gmux_index = {
> >   * MCP79, on all following generations it's GPIO pin 6 of the
> > Intel PCH.
> >   * The GPE merely signals that an interrupt occurred, the actual
> > type of event
> >   * is identified by reading a gmux register.
> > + *
> > + * On MMIO gmux's, we also need to call the acpi method GMSP to
> > properly clear
> > + * interrupts.
> >   */
> >  
> > +static int gmux_call_acpi_gmsp(struct apple_gmux_data *gmux_data,
> > int arg) +{
> > +	acpi_status status = AE_OK;
> > +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> > +	struct acpi_object_list arg_list = { 1, &arg0 };
> > +
> > +	arg0.integer.value = arg;
> > +
> > +	status = acpi_evaluate_object(gmux_data->dhandle, "GMSP",
> > &arg_list, NULL);
> > +	if (ACPI_FAILURE(status)) {
> > +		pr_err("GMSP call failed: %s\n",
> > +		       acpi_format_exception(status));
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static inline void gmux_disable_interrupts(struct apple_gmux_data
> > *gmux_data) {
> >  	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_ENABLE,
> > @@ -536,7 +560,11 @@ static void gmux_clear_interrupts(struct
> > apple_gmux_data *gmux_data) 
> >  	/* to clear interrupts write back current status */
> >  	status = gmux_interrupt_get_status(gmux_data);
> > -	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> > +	if (status) {
> > +		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS,
> > status);
> > +		if (gmux_data->config->use_acpi_gmsp)
> > +			gmux_call_acpi_gmsp(gmux_data, 0);
> > +	}  
> 
> This changes the behavior on the existing supported models to
> only write back status when it is non 0. This is likely fine
> but given that we seem to lack testers for the old models
> I would prefer to not change the behavior there.

Oops I didn't realise I had changed that. 

> 
> So how about:
> 
> 	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> 	if (status && gmux_data->config->use_acpi_gmsp)
> 		gmux_call_acpi_gmsp(gmux_data, 0);
> 
> ?
> 
> The 0 write to what presumably is a register with
> write 1 to clear bits should be harmless.
> 
> You can test that it is harmless on the new MMIO models
> and this way we don't change the behavior on the older models.

Your suggested code works fine for me.

I've realised the check for status != 0 probably isn't needed so I'll
take that out too, as using GMSP means we don't get spam of interrupts
with status = 0 on MMIO gmux's.

> 
> Regards,
> 
> Hans
> 

