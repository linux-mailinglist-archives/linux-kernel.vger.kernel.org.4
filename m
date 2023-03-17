Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030326BEFEE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCQRkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCQRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827F37F18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679074736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5igOX9Uv7sYkEvQwXODf9CZvRxNpFSAdyMQhy74jlc=;
        b=NsoZliJvJFLp0uvrDF+kH3FyPlZmx/3eeG5rwD/UbfMs4APIOlWi5NUHLatRQgrqXxzddv
        9OKF6cu9tBznBZrhcfrSGJp5ntICyTpJ9X7SgNszahM9Qhx+OmXXWZIkXCPwhQtvvtqSZi
        uUgZSiy5psAukX9/7fCObMni8owe59Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-Vdt0SAViNFeUjlOKg1kOMw-1; Fri, 17 Mar 2023 13:38:47 -0400
X-MC-Unique: Vdt0SAViNFeUjlOKg1kOMw-1
Received: by mail-wm1-f69.google.com with SMTP id s18-20020a7bc392000000b003deaf780ab6so2177294wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074726;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5igOX9Uv7sYkEvQwXODf9CZvRxNpFSAdyMQhy74jlc=;
        b=m6q/asdClLwmrkjAD7BmGclT1/BbG9pPs22TMKUFyap7ovIvgq3XDW78eCb/tsV7Oa
         bQbtPdG+/6Bx7GAyyrkc7kHSiToWnAfVKslMvX+bAODfpaN+E+8jEePnL1oq4gJ6nPLG
         vWlEHuUWEhctghDm5pEsQXAaII3dhFUy5lK96mKJ3zuL0ijIjunSNlZoC2sgzchjp1ba
         eqNxvAin3KCODuUBbBbVaeFx3kNri2DRTvqZomjJNm9GUKSLMCKbKZiEPONVRWAbXxrM
         sJsbC+dTaDrhXip6EJ8gMDl+sd2q/SAblILwU4DQag8q8xJ5oufcfBxfsog86gk2bXrs
         jehA==
X-Gm-Message-State: AO0yUKWdo8w82JCw5ZYi690ID8npSBDVBrXyIyyLtELxH65xh2hB6K4B
        0bisJtBF97j/H+YuUpq97/1I6fORnghsIGbiu7PZMb7Q8U75YNjzKIubjemBXqPHf7Tu/dHunIQ
        7o9XFwlDqPC4yHV2LXiPhN+kQ
X-Received: by 2002:adf:f605:0:b0:2cf:e449:1a9e with SMTP id t5-20020adff605000000b002cfe4491a9emr3202830wrp.30.1679074726452;
        Fri, 17 Mar 2023 10:38:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set/+ae3GwRd47AXIKw0cf03azn2wiPwxPLPHv3vayi16W0DR57E4TsNrw9o1MvTAss5UWm0uLw==
X-Received: by 2002:adf:f605:0:b0:2cf:e449:1a9e with SMTP id t5-20020adff605000000b002cfe4491a9emr3202812wrp.30.1679074726127;
        Fri, 17 Mar 2023 10:38:46 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b002cfea3c49d5sm2451189wrt.52.2023.03.17.10.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:38:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Gow <davidgow@google.com>,
        =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Arthur Grillo <arthurgrillo@riseup.net>
Subject: Re: [PATCH] drm/format-helper: Use drm_format_info_min_pitch() in
 tests helper
In-Reply-To: <0a1a0765-8f9c-90f5-b848-2931904269a7@suse.de>
References: <20230316223404.102806-1-javierm@redhat.com>
 <0a1a0765-8f9c-90f5-b848-2931904269a7@suse.de>
Date:   Fri, 17 Mar 2023 18:38:43 +0100
Message-ID: <87jzzfp9b0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Am 16.03.23 um 23:34 schrieb Javier Martinez Canillas:
>> There's a nice macro to calculate the destination pitch that already takes
>> into account sub-byte pixel formats. Use that instead of open coding it.
>> 
>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

