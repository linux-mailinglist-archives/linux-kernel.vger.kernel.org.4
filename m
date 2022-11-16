Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F90162C8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKPTQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPTQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1DA53EF6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668626111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfLRij7l12paP94g1Vl4KJDeYdRaQzDak4ajvEFazKc=;
        b=THjI7SIWzny/P5MhSD1J/Uuz66DnmZ3gfurHSZzNaDuCbAUQjfr8PFA88oKU9OHu9PJsjw
        kdE4hXsKNy2zD21dVuc0oOchCF/N/lD9n/fYvRlYeQOi8bMcVaGAt71UfHD9Ytn9Vjb7i+
        lfOePDomOONDR8KGgH/aRC5gk1AvBlA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-dw6OgLidOLeczJD8-Hrdfg-1; Wed, 16 Nov 2022 14:15:10 -0500
X-MC-Unique: dw6OgLidOLeczJD8-Hrdfg-1
Received: by mail-ot1-f71.google.com with SMTP id 33-20020a9d0124000000b0066adf5218b2so9291605otu.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfLRij7l12paP94g1Vl4KJDeYdRaQzDak4ajvEFazKc=;
        b=65SfmMEowv7mu9WywQyRpBVqOTuzpNspsAPQqMjIahrPnPrk6yFYZOOwZ1Kd7hEPua
         hD4MmbGD2oh2mbu5dudGBFgAUOE66fK3Mzv41Bh3aZFS9jegZj/NWURD+VIod0lr/QQA
         wpInV98cABlhDYN4/F8Mnr2CPM9a0esjduaOt51x4sapdE3knTulp6VQ58L6RRMzRQm8
         L2vQX906e38+zsoPFr1f3yKZxnPklw7vwVii+IxWW9N/VVWwl/ZmFaDVNmSm+lkUcJ2R
         3pP1d4fc975C4r4NfC1Kmv5znQfnF0Fo6kkKolFAkfvGxwiAEXBCzvqIPa4lTMAhxJdf
         TfYg==
X-Gm-Message-State: ANoB5pluYsBkQUMA8dYSGkZZYw6uzo3eMI2KRHROYev74xY+T1ued0jx
        rR/jJWp0grDGkxlxj3UZzVtenXNbff/+WIKVDnLcLCxQPbVfIPvge5Ghf7fGYKniqem7g9nyY6Z
        eJ13Uq+GebVwaN4B4ZKfTaszu
X-Received: by 2002:a05:6808:64e:b0:359:cfaf:7129 with SMTP id z14-20020a056808064e00b00359cfaf7129mr2441145oih.138.1668626109277;
        Wed, 16 Nov 2022 11:15:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6yyHtrKzDkICyQ/GcPC00u0hkYXeMEQ5XeUtPs9o6GweW8SID9IOlDutHJ8Hy/lmi5QZlFvQ==
X-Received: by 2002:a05:6808:64e:b0:359:cfaf:7129 with SMTP id z14-20020a056808064e00b00359cfaf7129mr2441135oih.138.1668626109041;
        Wed, 16 Nov 2022 11:15:09 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id u64-20020a4a2143000000b0049f9731ae1esm1771053oou.41.2022.11.16.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:15:08 -0800 (PST)
Date:   Wed, 16 Nov 2022 13:15:05 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Saravana Kannan <saravanak@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, John Stultz <jstultz@google.com>,
        Peter Robinson <pbrobinson@redhat.com>,
        Steev Klimaszewski <steev@kali.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/4] driver core: Disable driver deferred probe
 timeout by default
Message-ID: <20221116191505.x6ruzruc3yprp7sx@halaney-x13s>
References: <20221116115348.517599-1-javierm@redhat.com>
 <20221116120236.520017-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116120236.520017-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:02:36PM +0100, Javier Martinez Canillas wrote:
> The driver_deferred_probe_timeout value has a long history. It was first
> set to -1 when was introduced by commit 25b4e70dcce9 ("driver core: allow
> stopping deferred probe after init"), meaning that the driver core would
> defer the probe forever unless a subsystem would opt-in by checking if the
> initcalls where done using the driver_deferred_probe_check_state() helper,
> or if a timeout was explicitly set with a "deferred_probe_timeout" param.

This or statement here sounds like you either opt-in, or the timeout
affects you (at least that's how I read it).

A subsystem has to opt-in to get either result by using
driver_deferred_probe_check_state()!

> 
> Only the power domain, IOMMU and MDIO subsystems currently opt-in to check
> if the initcalls have completed with driver_deferred_probe_check_state().
> 
> Commit c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state()
> logic") then changed the driver_deferred_probe_check_state() helper logic,
> to take into account whether modules have been enabled or not and also to
> return -EPROBE_DEFER if the probe deferred timeout work was still running.
> 
> Then in commit e2cec7d68537 ("driver core: Set deferred_probe_timeout to a
> longer default if CONFIG_MODULES is set"), the timeout was increased to 30
> seconds if modules are enabled. Because seems that some of the subsystems
> that were opt-in to not return -EPROBE_DEFER after the initcall where done

s/where/were/

> could still have dependencies whose drivers were built as a module.
> 
> This commit did a fundamental change to how probe deferral worked though,
> since now the default was not to attempt probing for drivers indefinitely
> but instead to timeout after 30 seconds, unless a different timeout is set
> using the "deferred_probe_timeout" command line parameter.
> 
> The behavior was changed even more with commit ce68929f07de ("driver core:
> Revert default driver_deferred_probe_timeout value to 0"), since the value
> was set to 0 by default. Meaning that the probe deferral would be disabled
> after the initcalls where done. Unless a timeout was set in the cmdline.
> 
> Notice that the commit said that it was reverting the default value to 0,
> but this was never 0. The default was -1 at the beginning and then changed
> to 30 in a later commit.
> 
> This default value of 0 was reverted again by commit f516d01b9df2 ("Revert
> "driver core: Set default deferred_probe_timeout back to 0."") and set to
> 10 seconds instead. Which was still less than the 30 seconds that was set
> at some point, to allow systems with drivers built as modules and loaded
> later by user-land to probe drivers that were still in the deferred list.
> 
> The 10 seconds timeout isn't enough in some cases, for example the Fedora
> kernel builds as much drivers as possible as modules. And this leads to an
> Snapdragon SC7180 based HP X2 Chromebook to not have display, due the DRM
> driver failing to probe if CONFIG_ARM_SMMU=y and CONFIG_SC_GPUCC_7180=m.
> 
> So let's change the default again to -1 as it was at the beginning. That's
> how probe deferral always worked. The kernel should try to avoid guessing
> when it should be safe to give up on deferred drivers to be probed.
> 
> The reason why the default "deferred_probe_timeout" was changed from -1 to
> the other values was to allow drivers that have only optional dependencies
> to probe even if the suppliers are not available.
> 
> But now there is a "fw_devlink.timeout" parameter to timeout the links and
> allow drivers to probe even when the dependencies are not present. Let's
> set the default for that timeout to 10 seconds, to give the same behaviour
> as expected by these driver with optional device links.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

This sounds like a reasonable solution to me:

Acked-by: Andrew Halaney <ahalaney@redhat.com>

> ---
> 
> Changes in v2:
> - Mention in the commit messsage the specific machine and drivers that
>   are affected by the issue (Greg).
> - Double check the commit message for accuracy (John).
> - Add a second workqueue to timeout the devlink enforcing and allow
>   drivers to probe even without their optional dependencies available.
> 
>  drivers/base/dd.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index ea448df94d24..5f18cd497850 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -256,12 +256,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(deferred_devs);
>  
> -#ifdef CONFIG_MODULES
> -static int driver_deferred_probe_timeout = 10;
> -#else
> -static int driver_deferred_probe_timeout;
> -#endif
> -static int fw_devlink_timeout = -1;
> +static int driver_deferred_probe_timeout = -1;
> +static int fw_devlink_timeout = 10;
>  
>  static int __init deferred_probe_timeout_setup(char *str)
>  {
> -- 
> 2.38.1
> 

