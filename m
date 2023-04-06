Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950FE6D9F27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjDFRqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbjDFRqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:46:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E55DE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:46:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-93b8c095335so12476166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680803197;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RAECb/3wNcHEoEDLKDANAykGZzZoDwXPK2wrIHEQ2M4=;
        b=VuuDK66XzIMzwP6ttaCqfnUgY9nG0smMaIRc2nItlYvdgub/p6Y5Aa/2Li187iMw48
         FSSOONefopbdzJ9NJLaAgo+pTjRJ+YPqXb3OGyMqG5pyauXQCCsJvkWAv86EwxejwnHR
         ZRjXXsO6i2UWS8m+V4FYPkXIk+0oncskp5Vgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803197;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAECb/3wNcHEoEDLKDANAykGZzZoDwXPK2wrIHEQ2M4=;
        b=izIrvxu4zbSSx7ZqCkQC/xrJYae+jccKOCYOEw3zSd9gIUifo/jMsuiZfF9jifpgAQ
         cKEDkATWCJ5PgPcFYlU75dnwMJVOaqW2rxuMGJJPh8iNIUHg/b7onR/CpfkNCVA2K+Rt
         phiRN9WG6F0Jlw1iVi1KYuMb1r7ZjkdesQT5yGJ6nnVKW9PK/gQn7DHqJ58h/da5U8BX
         opuVf7QL/kw0y9e2pFeK0xUJWHASHipvxvpD/Md7+QifIwn0DyF29/baMxaJr01dRG7G
         1Aec7BYlAS1pNk6/MsSx3RBjV2lH31CrcO30PzPba1/yFJsrjREwzgw42Ov91kLMckn7
         RhGw==
X-Gm-Message-State: AAQBX9fW3RILICD7dDHjA6XDr92Hp3Yk0uMuS+HSwlAafqmpNjGGBYC5
        5LFS/9I4xC779B6Z0ufDP6KuMA==
X-Google-Smtp-Source: AKy350aYVOBsBs4/QQEvEUySoLjUIJYlbxbRczjqincoI9f4tnDptyR2vR64siqyySZnHr2/QV8hxw==
X-Received: by 2002:a17:906:3f12:b0:947:8734:a058 with SMTP id c18-20020a1709063f1200b009478734a058mr5629604ejj.4.1680803196956;
        Thu, 06 Apr 2023 10:46:36 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id kg13-20020a17090776ed00b008bc8ad41646sm1067618ejc.157.2023.04.06.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 10:46:36 -0700 (PDT)
Date:   Thu, 6 Apr 2023 19:46:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Asahi Lina <lina@asahilina.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        andrey.grodzovsky@amd.com, tvrtko.ursulin@linux.intel.com,
        Matthew Brost <matthew.brost@intel.com>, yuq825@gmail.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Regression] drm/scheduler: track GPU active time per entity
Message-ID: <ZC8FetzkowU4Q59K@phenom.ffwll.local>
Mail-Followup-To: Asahi Lina <lina@asahilina.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, andrey.grodzovsky@amd.com,
        tvrtko.ursulin@linux.intel.com,
        Matthew Brost <matthew.brost@intel.com>, yuq825@gmail.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <28d10733-b217-7ccc-4b8c-54bdc8249234@amd.com>
 <CAKMK7uFeeAaG8+1EutgMtmVANTb-acL0faEkJfUp1_35rSjaEg@mail.gmail.com>
 <24fe6e14-0d0a-f874-766d-e8d045d1e80e@asahilina.net>
 <ZC6ab6LomidehGR3@phenom.ffwll.local>
 <9500edc9-4e9d-9d64-b444-ea9523779700@asahilina.net>
 <ZC7LCi0vqFOw3KL5@phenom.ffwll.local>
 <30534307-24af-b6f8-ea9f-e4264997bf9d@asahilina.net>
 <ZC7lrOHKCbrbgS3R@phenom.ffwll.local>
 <2416c870-d069-defc-d14e-514e7db7d2fd@asahilina.net>
 <ZC8ElEkZEp1TGZJg@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC8ElEkZEp1TGZJg@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:42:44PM +0200, Daniel Vetter wrote:
> But I think there's tools to make sure we don't dig a complete hole with
> these it sounds like. I guess another topic for pestering the rust folks.

Or to put it very bluntly: Could we make Arc<T> at least runtime enforce
(with the usual lockdep annotation trick like fs_reclaim) that and Drop is
the final one?

If that's the rust Arc<T> linux semantics then I think my worries are 100%
covered. And we'll sort out the trickier type based enforcement for
special cases when they hit us.

The downside is that this is substantially stricter than kref on the C
side, but I think that's a Good Thing :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
