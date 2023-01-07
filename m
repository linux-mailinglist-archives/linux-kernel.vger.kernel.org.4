Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95D766108F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjAGRhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAGRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:37:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6901563D5
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673113017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gCpV0dGtCCGp1jPgBtNFnuKxWWQi0wqnd//45zEPmE=;
        b=ZHUfroq7g+bPPFzWwKWlCqaHzRv/WvNbvAKp6/IcPVtOhIkwTmrpLVPjBIQ98kd1SdhcGC
        l85EijLgmMoK+M9M4XU16eiq7128HeegIZZ5oBnyqOuMzTbJReYtntFVL27KOh+PLl0VG5
        gpkdtS+mNR5RSHxyWnba4qM7IBCpbOw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-sYH-oZuXMZqQg-d10IgMfg-1; Sat, 07 Jan 2023 12:36:55 -0500
X-MC-Unique: sYH-oZuXMZqQg-d10IgMfg-1
Received: by mail-wm1-f71.google.com with SMTP id fm17-20020a05600c0c1100b003d96f0a7f2eso4528770wmb.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 09:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gCpV0dGtCCGp1jPgBtNFnuKxWWQi0wqnd//45zEPmE=;
        b=3MTgwcRXPQQQmY9jvABN2FOpxLrQupaynsWacnRvT/c1E/OXCR47vQ2J/E0gUmDzK0
         jzCNpB+ZauF0BWsKhUzCC96yxkLF56AUMYN+JzHiXuyHWwdLPQjST4oki+2cV5kuwYpk
         txqtUngl3J+4Z7yCxdkXwocj2ZzaN/QMKvCZDgKyEY9ndKjp6kdINCx2/FHc2whIiiwZ
         3HQY35V5t6YSVeB2gj6T/CcyyAs/BYWb8v4T7cEeq7kldBJRCL4yVp1uRs1EOwmfuiMq
         ow4X5hoX6bGbV+FfIlA3C1eLmN2dYmRD8pX0zqexqId2yz6k/4W7FDY85z+6shYuGFYS
         oidw==
X-Gm-Message-State: AFqh2koeJKRPGSiLa/cpM+0EdzbR9gr9P7Mm0HRhYqirUWbavl62/92i
        7+UZSOO1dSd8ksZ1SxNNl7THYffAhxQapbwn77TagJ1+BFRgJKtVYULX1DBBUrpNKhkCi3hjePw
        i98cfCVowEi7Y7xTXs45lAlJZ
X-Received: by 2002:a7b:cd99:0:b0:3d3:5506:1bac with SMTP id y25-20020a7bcd99000000b003d355061bacmr42940023wmj.30.1673113014605;
        Sat, 07 Jan 2023 09:36:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtq5O2gMQwBFZYJBuaPTxiyhl5nYlsXlZhAewhas7TQGY9Hr/5ja8BEgFOpLT7ZHXkopoF13A==
X-Received: by 2002:a7b:cd99:0:b0:3d3:5506:1bac with SMTP id y25-20020a7bcd99000000b003d355061bacmr42940017wmj.30.1673113014449;
        Sat, 07 Jan 2023 09:36:54 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d6a08000000b002a1ae285bfasm4291978wru.77.2023.01.07.09.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 09:36:53 -0800 (PST)
Message-ID: <8110a6b7-dacb-57d3-a9fd-b2caf9899ab9@redhat.com>
Date:   Sat, 7 Jan 2023 18:36:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: Fix mipi_dsi_dcs_write_seq() macro
 definition format
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        llvm@lists.linux.dev
References: <20230102202542.3494677-1-javierm@redhat.com>
 <Y7M+6gdQM/4DhQsP@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y7M+6gdQM/4DhQsP@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/23 21:30, Sam Ravnborg wrote:
> On Mon, Jan 02, 2023 at 09:25:41PM +0100, Javier Martinez Canillas wrote:
>> Change made using a `clang-format -i include/drm/drm_mipi_dsi.h` command.
>>
>> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Thanks,
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>> ---

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

