Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23600689343
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjBCJPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjBCJPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF592C1D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675415698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdVLFF4ZVNepL+W9W9AEGXyzGPGEBcVS3tQ9W9CdiMw=;
        b=dBe2fSpqepExXKrINWWXpsDA/eGyNsPwimNRVvhjB0KtcRktsFWBb0Mm+rBR5+NN3sxF7d
        szJDVCVMWZv+z/mctm0R3NNyah2FNy9yWGGnS/EOuFPbQb29Zr9+h3cttMlSkzCkbUhO1k
        onP0dRH0qMnkTVI7wpw6pxbpWA5QtP0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-UVsjYfDSNw6A1TwCrjBfhg-1; Fri, 03 Feb 2023 04:14:56 -0500
X-MC-Unique: UVsjYfDSNw6A1TwCrjBfhg-1
Received: by mail-ej1-f71.google.com with SMTP id z2-20020a1709060be200b0088b579825f9so3497075ejg.18
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdVLFF4ZVNepL+W9W9AEGXyzGPGEBcVS3tQ9W9CdiMw=;
        b=gEIdcQArT7ZxgJjmABHoz/vF8Pv5zzxhkqfsCYTWNBnfBBIoxuZINNxGCMdxc2pXgz
         xY6xvwv2PX8i9IHvKUf4pRxz6iQJ+Cmchhll7feDNyyebXVRL/i+kKCXJKKQhoFHkC9/
         eCuPibkrL2OIaFHWKWfXmCmEBYCZCmw8uLcz/JS3tAuffz0Q4h6V2fMLUYEI9IMVzG5o
         2+kOJpWtTtEzfR+Kb8RuFqlkghB385LU48wJ4P5W/otZeBeF3+jLgCqa4rRBloXFi7Ww
         HZekZEcAo7m1/FWGQP981/QNSJeqQN65Mbe0vpUTvlll8kOp3yWO32mp05ECc3JLFtf5
         kuEw==
X-Gm-Message-State: AO0yUKVSDscj+47/0NrNM1iT6VhgrJr1exJudEFXivedvtGE4zM7gse2
        Zx3DT6OqqU+Wox1Nh3cow+Xyn2q9J7XFUdpqo226bLOcPmwZbmfaCcdKILCYtBRRoaYZo0ZILhX
        r3wQiZ2W4rFF/VWuAKh6gwGPx
X-Received: by 2002:a17:906:3ca1:b0:86f:ae1f:9234 with SMTP id b1-20020a1709063ca100b0086fae1f9234mr8983217ejh.7.1675415695538;
        Fri, 03 Feb 2023 01:14:55 -0800 (PST)
X-Google-Smtp-Source: AK7set/5hSanuDwCjarxsrKff30TcGNnzkXTBbhQnT0T5yC8C6ecYja1xuM381wvNO5JAZ0JsNZUDQ==
X-Received: by 2002:a17:906:3ca1:b0:86f:ae1f:9234 with SMTP id b1-20020a1709063ca100b0086fae1f9234mr8983209ejh.7.1675415695376;
        Fri, 03 Feb 2023 01:14:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906004d00b008512e1379dbsm1092920ejg.171.2023.02.03.01.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:14:54 -0800 (PST)
Message-ID: <7a292539-e3d7-958c-a806-54681a0c79ca@redhat.com>
Date:   Fri, 3 Feb 2023 10:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: duplicate patches in the drivers-x86 tree
Content-Language: en-US, nl
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230203083455.7a8cdee0@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230203083455.7a8cdee0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/23 22:34, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   037d07aeef02 ("platform/x86/amd/pmf: Fix to update SPS default pprof thermals")
>   5cca42fb5578 ("platform/x86/amd/pmf: Fix to update SPS thermals when power supply change")
>   66dc77b5c2a7 ("platform/x86/amd: pmc: add CONFIG_SERIO dependency")
>   8b6ad2361561 ("platform/x86: thinkpad_acpi: Fix thinklight LED brightness returning 255")
>   9f093aff1dda ("platform/x86: touchscreen_dmi: Add Chuwi Vi8 (CWI501) DMI match")
>   a63149e5d662 ("platform/x86/amd/pmf: update to auto-mode limits only after AMT event")
>   b3c37edce7dc ("platform/x86/amd/pmf: Add helper routine to update SPS thermals")
>   c02576762825 ("platform/x86/amd/pmf: Add helper routine to check pprof is balanced")
>   f1db3f08b51d ("platform/x86/amd/pmf: Ensure mutexes are initialized before use")

Hmm, this appears to be a new warning.

This is the result of my workflow for bug-fix patches, I first
merge all patches into the for-next branch and then I cherry-pick
fixes into the fixes branch and send out a pull-req from the fixes
branch for the current cycle.

AFAIK this is a pretty standard workflow ?

Bit I agree that ideally the duplicate commit ids from this workflow
should be avoided, so I'll try to change my workflow to putting fixes
directly on the fixes branch and then merging the fixes branch into
for-next and see how that goes.

I've also fixed the set of above duplicates by rebasing my current
for-next on top of fixes since I needed to do a forced push because
of the missing S-o-b-s anyways.

Regards,

Hans




