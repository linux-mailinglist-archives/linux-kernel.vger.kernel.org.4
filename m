Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04169CA74
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjBTMCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjBTMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:02:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE8E1B552;
        Mon, 20 Feb 2023 04:02:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n5so605123pfv.11;
        Mon, 20 Feb 2023 04:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5iTKuc9ZIC8mfFFhdSEI0ZAf2KXUFXWVVjhvYosUIM=;
        b=VROnHFREqd0Ltlg2g61dgYOzAojH4Mxf1RuLQvJAFmKW2iYt3juFREwpMZipmt66nd
         wg7ntQePS/wGq2kFfxiiU+yhzDxIbv5ZXftPrHvpyrTITOPji9yXg9tu2HWIqFV5kR1/
         wLuB7rMCTWTNX4KuGiGPVH5+SkpPrdZBmok3GA6FhvKXWGSthZRX6D1bKStNT/pCJXeY
         E99rHLgw08pmPRoxFzgnbocdeNDIHe/m1DMA6O4ME2tyfSBl2ezZ574rZguMgu5FhM1T
         lLB5tGVJyiXU4v3B6i5ytPOnHnzVcJqRlOSsppmtv51XO4sAFHyBXDJmnIZ4l1guVv1n
         cOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5iTKuc9ZIC8mfFFhdSEI0ZAf2KXUFXWVVjhvYosUIM=;
        b=HNGm25ZqNs8OVk3LzpwNNHRF4IoT0bOeNQhOBS1DN4K9qXVKEcXB4LDSed8ppT3xUC
         q8DIc+hIWtsXlM2mUaiyreJBZFE7SSAhPp3Mpq22lj9O5b8hCKLbN/aOo7Q3esM8VPhB
         HcZIfGZS8h7mQOmeQgHUWWgeEBytfyZe5I6sBATl8QJnYl86rVl7s2uB55jN8ez0Xm32
         oDqGnuxK37JbVknPtgxCvQX24DfCaOD/GQYUbuds2f43iTKdrc1nFZT7ifFBmMVptx/g
         TSLOUVxM0DfVbS/woisDIk4bOpwVJV0zb6rPszEqg57mAf/h4RSdWC4y1pKnjUdXE4gl
         oFMg==
X-Gm-Message-State: AO0yUKXx3ArQf1/a/SZ9QWfJm4omKvetANf7SQIq3dbRlKuj3GnC7VoW
        DtH8lj+c+8XsT/ALHQDg3yM=
X-Google-Smtp-Source: AK7set8kTF4hiTtmXprSPQHMYdRdUzgTAJko9Ruc6cBzxpZuc8E3a/TnKnY/qKANfN8ynIoa3gc4Eg==
X-Received: by 2002:aa7:955c:0:b0:593:91e4:99e2 with SMTP id w28-20020aa7955c000000b0059391e499e2mr2670957pfq.34.1676894544401;
        Mon, 20 Feb 2023 04:02:24 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id i16-20020aa78b50000000b0058b9c9def36sm1276361pfd.139.2023.02.20.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:02:24 -0800 (PST)
Date:   Mon, 20 Feb 2023 23:02:15 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v3 3/5] apple-gmux: Use GMSP acpi method for interrupt
 clear
Message-ID: <20230220230215.6e7e09cf@redecorated-mbp>
In-Reply-To: <20230219221737.GA17355@wunner.de>
References: <20230218132007.3350-1-orlandoch.dev@gmail.com>
        <20230218132007.3350-4-orlandoch.dev@gmail.com>
        <20230219221737.GA17355@wunner.de>
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

On Sun, 19 Feb 2023 23:17:37 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Sun, Feb 19, 2023 at 12:20:05AM +1100, Orlando Chamberlain wrote:
> > This is needed for interrupts to be cleared correctly on MMIO based
> > gmux's. It is untested if this helps/hinders other gmux types, so
> > currently this is only enabled for the MMIO gmux's.
> > 
> > There is also a "GMLV" acpi method, and the "GMSP" method can be
> > called with 1 as its argument, but the purposes of these aren't
> > known and they don't seem to be needed.  
> 
> GMLV and GMSP access a GPIO on the PCH which is connected to the
> GMUX_INT pin of the gmux microcontroller.  I've just verified that
> in the schematics of my MBP9,1.
> 
> GMLV reads the value of the GPIO ("level").
> GMSP likely sets the value ("set polarity").
> 
> On my MBP9,1 (indexed gmux), if the gmux controller signals an
> interrupt, the platform signals a notification:
> 
>   Scope (\_GPE)
>   {
>       Method (_L16, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
>       {
>           Notify (\_SB.PCI0.LPCB.GMUX, 0x80) // Status Change
>       }
>   }
> 
> Comparing this to the MBP13,3 and MBP16,1, the GPE method
> differentiates between the OS type:  On Darwin, only a notification
> is signaled, whereas on other OSes, the GPIO's value is read and then
> inverted:
> 
>   Scope (\_GPE)
>   {
>       Method (_L15, 0, NotSerialized)  // _Lxx: Level-Triggered GPE,
> xx=0x00-0xFF {
>           If (OSDW ())
>           {
>               Notify (\_SB.PCI0.LPCB.GPUC, 0x80) // Status Change
>           }
>           ElseIf ((\_SB.GGII (0x03000015) == One))
>           {
>               \_SB.SGII (0x03000015, Zero)
>           }
>           Else
>           {
>               \_SB.SGII (0x03000015, One)
>           }
>       }
>   }
> 
> Linux masquerades as Darwin, so ends up in the notification-only
> code path.
> 
> Does macOS execute the GMSP method as well?  Have you disassembled
> the gmux driver?  All vital information that belongs in the commit
> message and/or a code comment.

I think it does, if certain based bits in "HWFeatureMask" (which shows
up in `ioreg -l`) are set, but I'm not very good at RE so I don't know
exactly how macOS uses it. The kext is AppleMuxControl2.kext.

> 
> 
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
> 
> Can this be simplified by using acpi_execute_simple_method() or
> one of the other helpers provided by drivers/acpi/utils.c?
> 

Yes it can thanks!

> 
> > @@ -537,6 +561,8 @@ static void gmux_clear_interrupts(struct
> > apple_gmux_data *gmux_data) /* to clear interrupts write back
> > current status */ status = gmux_interrupt_get_status(gmux_data);
> >  	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> > +	if (gmux_data->config->use_acpi_gmsp)
> > +		gmux_call_acpi_gmsp(gmux_data, 0);
> >  }  
> 
> I think it would be clearer to check the gmux type directly here,
> so that a casual reader understands that invoking the method is
> necessary on MMIO-accessed GMUXes, but not any of the other types.
> By contrast, with the use_acpi_gmsp one has to look up first which
> of the gmux types sets this to true.

I can do it like that next version.

> 
> What happens if GMSP is not executed?  Needs to be documented in the
> commit message and/or a code comment!
> 

It gets a flood of status=0 interrupts, I'll add that as a comment.

> Thanks,
> 
> Lukas

