Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D26ADD36
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCGLYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCGLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:23:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52919B9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678188192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DstNONth+FFX6JHcYyIr92NpsXQltnv/qQOet+vdk6w=;
        b=OfVgTErohibTng8vLoUDNGB7Wd9Xx7cl6kvMGXgcFrqJPGFkN+84lB0U7U+bngyrlRJmRS
        knFEciV9N9gBM3RVQ38IwI0ljYetFZJS4jUBhUnIUve6dlnqPbZkk0eJXredd5lHtp9Uvs
        Xrvj8ucVSsqPdj8gMI+NXtxtY2ZhGuI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-qfTE1WuxOwWxAOpNr8HA9A-1; Tue, 07 Mar 2023 06:23:11 -0500
X-MC-Unique: qfTE1WuxOwWxAOpNr8HA9A-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a0564020e8b00b004e59d4722a3so8308633eda.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 03:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678188190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DstNONth+FFX6JHcYyIr92NpsXQltnv/qQOet+vdk6w=;
        b=8Aiat9FBgJHdBuCG9PumuJ9gH+LWthvQS7E4wlQOf262nbzEWvlm9kjiBn4Po3JJs1
         rB+M9TZUdcLdzCp7ElFMKPQGMk05jD8juEiCtLpgWyXWVV90SRzyd8GaSvBn/wZzP0U3
         d2vEebMrT6ny5eVo/Tj9oGN1YboQ1G4ae6onWfi8eo9qZZde7VwbC1OZ5PoTyEgC7xkp
         wYx5FzEXZCifuvT1r+1ybFHXM+Etb2j9GHHFQrbA5hVTqsaIh3XoZInz6kIEa6f4k/l6
         w40Ta4FD+TsqY9r5U9lk/gCLU7TZVB4ktV5eym325cFU3Xq3vhZ6uhpC1H3mZPlncp5l
         KONQ==
X-Gm-Message-State: AO0yUKXdq6+yjmE7wShJE61K5QTfFZrnJYQS54ErM81vqEIenQ5vC93f
        lIsyMsJfKHXSPTTDSLfEKIifmlHqFktyyvKDTVD6AVUhJRiPVUMtj1tW9p6MjJ3czSgg/0dswNd
        qUPT+iqMnCfeC4kIxW8WCwDRC
X-Received: by 2002:a17:907:980b:b0:88c:4f0d:85af with SMTP id ji11-20020a170907980b00b0088c4f0d85afmr18719521ejc.75.1678188190633;
        Tue, 07 Mar 2023 03:23:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8xhnGlMR2ImorCnh8pGuQV+LOFF+hIxBQmUB2VbhBNQlSHNCz7GoWpQh7k/NPgmze7byOBNw==
X-Received: by 2002:a17:907:980b:b0:88c:4f0d:85af with SMTP id ji11-20020a170907980b00b0088c4f0d85afmr18719481ejc.75.1678188190328;
        Tue, 07 Mar 2023 03:23:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c14-20020a50f60e000000b004af720b855fsm6604566edn.82.2023.03.07.03.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 03:23:09 -0800 (PST)
Message-ID: <a4fde380-2fd0-3bfe-3740-ddf8511dc986@redhat.com>
Date:   Tue, 7 Mar 2023 12:23:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 00/29] platform/x86: Convert to platform remove callback
 returning void
Content-Language: en-US, nl
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>,
        Andrea Ho <Andrea.Ho@advantech.com.tw>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Jorge Lopez <jorge.lopez2@hp.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Hung <alexhung@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shravan Sudhakar <s.shravan@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 3/2/23 15:47, Uwe Kleine-König wrote:
> Hello,
> 
> this patch series adapts the platform drivers below drivers/platform/x86
> to use the .remove_new() callback. Compared to the traditional .remove()
> callback .remove_new() returns no value. This is a good thing because
> the driver core doesn't (and cannot) cope for errors during remove. The
> only effect of a non-zero return value in .remove() is that the driver
> core emits a warning. The device is removed anyhow and an early return
> from .remove() usually yields a resource leak.
> 
> By changing the remove callback to return void driver authors cannot
> reasonably assume any more that there is some kind of cleanup later.
> 
> All drivers touched here returned zero unconditionally in their remove
> callback, so they could all be converted trivially to .remove_new().
> 
> Note that this series depends on commit 5c5a7680e67b ("platform: Provide
> a remove callback that returns no value") that is already in Linus' tree
> but not yet included in a tagged version.

Thank you for your patch series, I've applied this series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> Uwe Kleine-König (29):
>   platform/x86: acer-wmi: Convert to platform remove callback returning void
>   platform/x86: adv_swbutton: Convert to platform remove callback returning void
>   platform/x86: amd: hsmp: Convert to platform remove callback returning void
>   platform/x86: amd: pmc: Convert to platform remove callback returning void
>   platform/x86: amd: pmf: core: Convert to platform remove callback returning void
>   platform/x86: amilo-rfkill: Convert to platform remove callback returning void
>   platform/x86: barco-p50-gpio: Convert to platform remove callback returning void
>   platform/x86: compal-laptop: Convert to platform remove callback returning void
>   platform/x86: dell: dcdbas: Convert to platform remove callback returning void
>   platform/x86: dell: dell-smo8800: Convert to platform remove callback returning void
>   platform/x86: hp: hp_accel: Convert to platform remove callback returning void
>   platform/x86: hp: tc1100-wmi: Convert to platform remove callback returning void
>   platform/x86: huawei-wmi: Convert to platform remove callback returning void
>   platform/x86: ideapad-laptop: Convert to platform remove callback returning void
>   platform/x86: intel: bxtwc_tmu: Convert to platform remove callback returning void
>   platform/x86: intel: chtdc_ti_pwrbtn: Convert to platform remove callback returning void
>   platform/x86: intel: chtwc_int33fe: Convert to platform remove callback returning void
>   platform/x86: intel: hid: Convert to platform remove callback returning void
>   platform/x86: intel: int0002_vgpio: Convert to platform remove callback returning void
>   platform/x86: intel: int1092: intel_sar: Convert to platform remove callback returning void
>   platform/x86: intel: int3472: discrete: Convert to platform remove callback returning void
>   platform/x86: intel: mrfld_pwrbtn: Convert to platform remove callback returning void
>   platform/x86: intel: pmc: core: Convert to platform remove callback returning void
>   platform/x86: intel: telemetry: pltdrv: Convert to platform remove callback returning void
>   platform/x86: intel: vbtn: Convert to platform remove callback returning void
>   platform/x86: samsung-q10: Convert to platform remove callback returning void
>   platform/x86: serial-multi-instantiate: Convert to platform remove callback returning void
>   platform/x86: wmi: Convert to platform remove callback returning void
>   platform/x86: xo1-rfkill: Convert to platform remove callback returning void
> 
>  drivers/platform/x86/acer-wmi.c                 |  5 ++---
>  drivers/platform/x86/adv_swbutton.c             |  6 ++----
>  drivers/platform/x86/amd/hsmp.c                 |  6 ++----
>  drivers/platform/x86/amd/pmc.c                  |  5 ++---
>  drivers/platform/x86/amd/pmf/core.c             |  5 ++---
>  drivers/platform/x86/amilo-rfkill.c             |  5 ++---
>  drivers/platform/x86/barco-p50-gpio.c           |  6 ++----
>  drivers/platform/x86/compal-laptop.c            |  8 +++-----
>  drivers/platform/x86/dell/dcdbas.c              |  6 ++----
>  drivers/platform/x86/dell/dell-smo8800.c        |  5 ++---
>  drivers/platform/x86/hp/hp_accel.c              |  5 ++---
>  drivers/platform/x86/hp/tc1100-wmi.c            |  6 ++----
>  drivers/platform/x86/huawei-wmi.c               |  6 ++----
>  drivers/platform/x86/ideapad-laptop.c           |  6 ++----
>  drivers/platform/x86/intel/bxtwc_tmu.c          |  5 ++---
>  drivers/platform/x86/intel/chtdc_ti_pwrbtn.c    |  5 ++---
>  drivers/platform/x86/intel/chtwc_int33fe.c      |  6 ++----
>  drivers/platform/x86/intel/hid.c                | 10 ++--------
>  drivers/platform/x86/intel/int0002_vgpio.c      |  5 ++---
>  drivers/platform/x86/intel/int1092/intel_sar.c  |  5 ++---
>  drivers/platform/x86/intel/int3472/discrete.c   |  6 ++----
>  drivers/platform/x86/intel/mrfld_pwrbtn.c       |  5 ++---
>  drivers/platform/x86/intel/pmc/core.c           |  5 ++---
>  drivers/platform/x86/intel/telemetry/pltdrv.c   |  5 ++---
>  drivers/platform/x86/intel/vbtn.c               | 10 ++--------
>  drivers/platform/x86/samsung-q10.c              |  6 ++----
>  drivers/platform/x86/serial-multi-instantiate.c |  6 ++----
>  drivers/platform/x86/wmi.c                      |  6 ++----
>  drivers/platform/x86/xo1-rfkill.c               |  5 ++---
>  29 files changed, 59 insertions(+), 111 deletions(-)
> 
> base-commit: ee3f96b164688dae21e2466a57f2e806b64e8a37

