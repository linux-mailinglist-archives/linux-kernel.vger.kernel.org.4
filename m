Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484374E996
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGKI6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjGKI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:58:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD91A2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:58:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7bbbfa95so1608200e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1689065880; x=1689670680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vU/q9F+j7T29Ov8VGxEBf0ga2x1TW8QqZSc1uPgejXw=;
        b=ZAYLsHz1srKC6rodvE90k3M2axRg9MqOhBHiSomPBA3k80qu6tnzcZLed105eqB3mB
         3jfffCy/8VP9kCx5f9oP9AeHHmIFOK4jenCBSFQXP3/mWEwmJRjABLQiok/pxYTeqkpr
         8ssAfAR+eXCL1meiVj6KmFQ8M6F4/m2s6q2CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689065880; x=1689670680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vU/q9F+j7T29Ov8VGxEBf0ga2x1TW8QqZSc1uPgejXw=;
        b=BxXAXWD+G6y5bxku/wy1hOcpNPGH1NMvMNHFtRfPdcUKnKKRC5FFTfat2QWtc5fOJe
         wZI4v3sySyNlprDL/2DPUUKXF77DKrdau5oCUANC0LfgH7N01eMKzoFRPMOQ8lDnBZPb
         3UUzC7SiQ1zvMH8lekmR8iCYY9F+Z037ao4EEi+zrRpkHqAdZXaeBZcD8XWv4AlvrjN7
         VhHiRomb4PR530LU6DRXnhxxkyr8vHx2RjKMnRBe3Q/xHKWQ1sMiScruCyZSzqcY4xMD
         81TYmgaqPj0pMLn+g43+cMYg+vjTAl48C6kdncLY5DCFVhJ8aGst9xTUxbypI4CHePzm
         abUw==
X-Gm-Message-State: ABy/qLbshIX8tTJd9bJv+lAc9aankuSw7A6ZzGO4MDNCbS0snyCuW7+i
        bFfQ534UttLnTgbo/P09SD96hQ==
X-Google-Smtp-Source: APBJJlFG4pTsS/5OU08doNJkGnPN/YPs+LTOaHjyktlkkHHgWCUC0uJHQGeiOEg+95dWXGz0oSUrhw==
X-Received: by 2002:a19:a414:0:b0:4fb:8341:43d3 with SMTP id q20-20020a19a414000000b004fb834143d3mr9326203lfc.5.1689065880058;
        Tue, 11 Jul 2023 01:58:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v6-20020aa7cd46000000b0051e3385a395sm949732edw.3.2023.07.11.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 01:57:59 -0700 (PDT)
Date:   Tue, 11 Jul 2023 10:57:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v5 6/6] drm/doc: Define KMS atomic state set
Message-ID: <ZK0ZlciR66oTO+Td@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>, Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20230707224059.305474-1-andrealmeid@igalia.com>
 <20230707224059.305474-7-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230707224059.305474-7-andrealmeid@igalia.com>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:40:59PM -0300, André Almeida wrote:
> From: Pekka Paalanen <pekka.paalanen@collabora.com>
> 
> Specify how the atomic state is maintained between userspace and
> kernel, plus the special case for async flips.
> 
> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> v4: total rework by Pekka
> ---
>  Documentation/gpu/drm-uapi.rst | 41 ++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 65fb3036a580..6a1662c08901 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -486,3 +486,44 @@ and the CRTC index is its position in this array.
>  
>  .. kernel-doc:: include/uapi/drm/drm_mode.h
>     :internal:
> +
> +KMS atomic state
> +================
> +
> +An atomic commit can change multiple KMS properties in an atomic fashion,
> +without ever applying intermediate or partial state changes.  Either the whole
> +commit succeeds or fails, and it will never be applied partially. This is the
> +fundamental improvement of the atomic API over the older non-atomic API which is
> +referred to as the "legacy API".  Applying intermediate state could unexpectedly
> +fail, cause visible glitches, or delay reaching the final state.
> +
> +An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, which means the
> +complete state change is validated but not applied.  Userspace should use this
> +flag to validate any state change before asking to apply it. If validation fails
> +for any reason, userspace should attempt to fall back to another, perhaps
> +simpler, final state.  This allows userspace to probe for various configurations
> +without causing visible glitches on screen and without the need to undo a
> +probing change.
> +
> +The changes recorded in an atomic commit apply on top the current KMS state in
> +the kernel. Hence, the complete new KMS state is the complete old KMS state with
> +the committed property settings done on top. The kernel will automatically avoid
> +no-operation changes, so it is safe and even expected for userspace to send
> +redundant property settings.  No-operation changes do not count towards actually
> +needed changes, e.g.  setting MODE_ID to a different blob with identical
> +contents as the current KMS state shall not be a modeset on its own.

Small clarification: The kernel indeed tries very hard to make redundant
changes a no-op, and I think we should consider any issues here bugs. But
it still has to check, which means it needs to acquire the right locks and
put in the right (cross-crtc) synchronization points, and due to
implmentation challenges it's very hard to try to avoid that in all cases.
So adding redundant changes especially across crtc (and their connected
planes/connectors) might result in some oversynchronization issues, and
userspace should therefore avoid them if feasible.

With some sentences added to clarify this:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
> +A "modeset" is a change in KMS state that might enable, disable, or temporarily
> +disrupt the emitted video signal, possibly causing visible glitches on screen. A
> +modeset may also take considerably more time to complete than other kinds of
> +changes, and the video sink might also need time to adapt to the new signal
> +properties. Therefore a modeset must be explicitly allowed with the flag
> +DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
> +DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state change is
> +likely to cause visible disruption on screen and avoid such changes when end
> +users do not expect them.
> +
> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
> +effectively change only the FB_ID property on any planes. No-operation changes
> +are ignored as always. Changing any other property will cause the commit to be
> +rejected.
> -- 
> 2.41.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
