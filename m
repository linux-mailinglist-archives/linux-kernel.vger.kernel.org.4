Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF16D7FD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbjDEOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjDEOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:44:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5EAFB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:44:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-4fd1f2a0f82so63910a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680705855; x=1683297855;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lLnJ1+P3Iu2mYgt/o+7cyTWl5Q1ydZ9Nz1cnrQ5Nmc=;
        b=UJzXtPPwq73Eu+NmBlgfXI9JxlVitZ4kXrO0pETGtZxMEVTi1y5WaveTdET9Z1qul9
         Rq1swKdnVflb+zz6G7f5yZdKkLbBRw/SLhrRIHaGaQOz0gUUHsYs1b1srMn29K4/4HYD
         j+tBSrvp2UABDduixiEjXDgqUUDvyx/FKcfCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680705855; x=1683297855;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lLnJ1+P3Iu2mYgt/o+7cyTWl5Q1ydZ9Nz1cnrQ5Nmc=;
        b=pfBMiOwtpjy0TDz3UhvyxA2SRsEQ8vdkoJrwZHZ0rB7txhkKvUAGCG5zjZVZ2vgnrP
         33dw9SQsd2ArsAQMtWkDUGjGFAqePl6fvZIkgVo6tVfotcJqIE6yqKsrGhEz6O7ga00I
         eh4UYAwECh1kgaVO5wZD5aKSNTR3XCpf1rZkn9qOSBbgum+ElRDAWqiWw1lc2+ox1aIj
         Ugj+NS4gdJW+OsgArw9WrcKCNienDhz1Y8azL/OWINqr4sfnmXLinXO7qkMUx+yD6J6q
         ihEOr0Yv2ZRE5cWysMOT8OyCeAKMxY14tLtyx4ID44347iQ1IVn4TvQCKFgwrN6P9qOX
         ncxw==
X-Gm-Message-State: AAQBX9cCWizto5cW/mRWuIcWEWeJnnun/2zOIYQBYVQwP1I6FPJtamT0
        etGFQmeuWQfRqzMtkt1wnTR7xQ==
X-Google-Smtp-Source: AKy350bDxZoWmLNeFdkBJ8tM2X67oz1ppfs8T2swdma6bs6jcrru0HiaIH7cchQxIu2ClUv18HSI+A==
X-Received: by 2002:a05:6402:268e:b0:502:ffd:74a1 with SMTP id w14-20020a056402268e00b005020ffd74a1mr2119026edd.2.1680705855694;
        Wed, 05 Apr 2023 07:44:15 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id l2-20020a50c102000000b004fa012332ecsm7403362edf.1.2023.04.05.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:44:15 -0700 (PDT)
Date:   Wed, 5 Apr 2023 16:44:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH RFC 18/18] drm/asahi: Add the Asahi driver for Apple AGX
 GPUs
Message-ID: <ZC2JPR3fGm0uE9yW@phenom.ffwll.local>
Mail-Followup-To: Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-18-917ff5bc80a8@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-rust-drm-v1-18-917ff5bc80a8@asahilina.net>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:25:43PM +0900, Asahi Lina wrote:
> +/// Look up a GEM object handle for a `File` and return an `ObjectRef` for it.
> +pub(crate) fn lookup_handle(file: &DrmFile, handle: u32) -> Result<ObjectRef> {
> +    Ok(ObjectRef::new(shmem::Object::lookup_handle(file, handle)?))
> +}

So maybe my expectations for rust typing is a bit too much, but I kinda
expected this to be fully generic:

- trait Driver (drm_driver) knows the driver's object type
- a generic create_handle function could ensure that for drm_file (which
  is always for a specific drm_device and hence Driver) can ensure at the
  type level that you only put the right objects into the drm_file
- a generic lookup_handle function on the drm_file knows the Driver trait
  and so can give you back the right type right away.

Why the wrapping, what do I miss?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
