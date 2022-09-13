Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4FF5B7591
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiIMPuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiIMPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112D98A1C0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663080602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uxenzw8tkNyvX0lkO9yxXwXtOB+riZKdHwT6bqSX9nc=;
        b=WgIOeD5Fomxg6d5RJaHmzDRMFo7vPje+AyUZG328JOMj0EE4f5jBez+Y29VwnvFs8sIaui
        YuWnSVb0srhVfBmNmQ1eH7ZqMhCMgwGrv6iilvAwyl/uMDu8b+LyMYKM6fNt9NOX81RSIw
        menEEjukLPYyv9JOsevVNSe3C7cydd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-4_e8YfL2MJiG6NrYyI_ZiA-1; Tue, 13 Sep 2022 10:46:34 -0400
X-MC-Unique: 4_e8YfL2MJiG6NrYyI_ZiA-1
Received: by mail-wm1-f71.google.com with SMTP id v128-20020a1cac86000000b003b33fab37e8so6580078wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Uxenzw8tkNyvX0lkO9yxXwXtOB+riZKdHwT6bqSX9nc=;
        b=C/Tud7qLVkgMee1octnr8uerRmHJuHUCUWgYrr52bdtGPpCb84Z6kdWAPpZ1tWmMFk
         wb//Itp2cHcpZhq5R2WrILXCnlkSP0FNtpg6sEsoXSpjBRFK3W57YlJwvjNVJgpE4c07
         LdjoDWYymLAtlafr/hkPh93raeDgHPfs+bVxmOzJ6U3iY6qw8KWutPXiNZUUhGRwaq0g
         oaXGuVbfD7KEN2e3Qh1wos10Ntol/tEh8O9WvKuUL5Ucw5BdBeuXyT99uSMxJ0eHrhUU
         nHm3mHwVwxZIIgPWCpgjSNChjaFXouvxEeI5P0V+re+ENhrFh3bF4jKBuLVQmieqTKtB
         RI8g==
X-Gm-Message-State: ACgBeo04mAO+j0qZHC22pYcKemGatyGj5bde1896W5L4XLmV5eeni7C3
        Ic/Q68TL72eNz59PBGRExjijruLJbja39u7lhjenLkVxicwserBdP8x3d7nirgDHgGTK75Cdwwe
        KKoOCB5Ae1dN3aVwSj1BHYtGl
X-Received: by 2002:a5d:4f81:0:b0:21e:2cd7:25df with SMTP id d1-20020a5d4f81000000b0021e2cd725dfmr19467732wru.439.1663080392551;
        Tue, 13 Sep 2022 07:46:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/D8KkrO108ulemub/f9jxm0PwrmE52RV1n2K5U3IcU9nGT7jDSzfR02kc6jUeYukVTDbBsQ==
X-Received: by 2002:a5d:4f81:0:b0:21e:2cd7:25df with SMTP id d1-20020a5d4f81000000b0021e2cd725dfmr19467717wru.439.1663080392333;
        Tue, 13 Sep 2022 07:46:32 -0700 (PDT)
Received: from [172.16.38.252] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c4f5600b003b47581979bsm11556372wmq.33.2022.09.13.07.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:46:31 -0700 (PDT)
Message-ID: <2b67dfcc-9027-6bb5-d42b-7465f2236747@redhat.com>
Date:   Tue, 13 Sep 2022 16:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] drm/plane-helper: Add a
 drm_plane_helper_atomic_check() helper
Content-Language: en-US
To:     Harry Wentland <harry.wentland@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20220913093339.106625-1-javierm@redhat.com>
 <b81591c4-934c-4b70-fbf0-b0f4663a6d1c@amd.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <b81591c4-934c-4b70-fbf0-b0f4663a6d1c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 15:49, Harry Wentland wrote:
> 
> 
> On 2022-09-13 05:33, Javier Martinez Canillas wrote:
>> Provides a default plane state check handler for primary planes that are a
>> fullscreen scanout buffer and whose state scale and position can't change.
>>
> 
> Even though this might be how some drivers are handling the primary
> plane this assumption is not universal. For example, on ChromeOS when
> the (default) underlay strategy is selected the compositor will
> position the video plane as the bottom-most plane and mark it
> as primary, while the desktop plane is marked as overlay and
> will contain an alpha cutout to show the underlying video.
>
> In this case the video plane (primary) won't span the screen
> and is regularly panned and resized.
>

I see. Interesting.

> No objections to this change as it helps share code between drivers,
> but maybe specify that this behavior is a unique requirement of
> these drivers.
> 

I tried to make it clear in the comment by mentioning that this helper
is applicable for drivers whose primary plane is always fullscreen and
can't scale or change position.

Any suggestions of what's missing in the helper kernel-doc comment to be
more clear ?

> Harry
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

