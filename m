Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1558174B150
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGGMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGGMww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:52:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06B1FEB;
        Fri,  7 Jul 2023 05:52:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFB866606FCA;
        Fri,  7 Jul 2023 13:52:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688734365;
        bh=qDwANLQ61icK21USCiych8PHXsbfyaAg3fQVfsTFR0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=boT51Xa27cuR67WqrDMmww5kmVhzhlbknsmSumNKNe2IMGQNPOAPwayNQiMid4Arm
         PCTi9I1uDsmSeinZi5hJgv1iZVciUExuTV8atQOoC/yizk9RwVG6MyE3ruNem4HUBk
         3FX5ogGMBHTxJBk92bd3zAhDwPTeLWhIBsTO1nUnmEjs4eDm2K5Xldn/ave9FEr57N
         vUukeiXBD0H9dTTUeWBRS38RYnx6MPjdWayiXBGCVurLNPe3gPAm8C/jtCWbTuPVnW
         53rsS7H9wLon79o5Pk63NH0cw74yWoqIISnsT1HUnJiwOlOkS0w5SGQzStyPMmjjZv
         Oth6cqLZl2npw==
Date:   Fri, 7 Jul 2023 14:52:41 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, alexdeucher@gmail.com, ogabbay@kernel.org,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH drm-next v6 02/13] drm: manager to keep track of GPUs VA
 mappings
Message-ID: <20230707145241.6ea73643@collabora.com>
In-Reply-To: <e92219d7-77f7-a40a-39d9-ea7afc5f3687@redhat.com>
References: <20230629222651.3196-1-dakr@redhat.com>
        <20230629222651.3196-3-dakr@redhat.com>
        <20230707130010.1bd5d41b@collabora.com>
        <e92219d7-77f7-a40a-39d9-ea7afc5f3687@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 14:41:23 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> >> +	     va__ && (va__->va.addr < (end__)) && \
> >> +	     !list_entry_is_head(va__, &(mgr__)->rb.list, rb.entry); \
> >> +	     va__ = list_next_entry(va__, rb.entry))  
> > 
> > If you define:
> > 
> > static inline struct drm_gpuva *
> > drm_gpuva_next(struct drm_gpuva *va)
> > {
> > 	if (va && !list_is_last(&va->rb.entry, &va->mgr->rb.list))
> > 		return list_next_entry(va, rb.entry);
> > 
> > 	return NULL;
> > } >
> > the for loop becomes a bit more readable:  
> 
> Yes, it would. However, I don't want it to be confused with 
> drm_gpuva_find_next(). Maybe I should rename the latter to something 
> like drm_gpuva_find_next_neighbor() then.

If you want to keep drm_gpuva_find_next(), feel free to rename/prefix
the drm_gpuva_next() function. I was just posting it as a reference.

> 
> > 
> > 	for (va__ = drm_gpuva_find_first((mgr__), (start__), (end__) - (start__)); \
> > 	     va__ && (va__->va.addr < (end__)); \
> > 	     va__ = drm_gpuva_next(va__))
> >   
> >> +
> >> +/**
> >> + * drm_gpuva_for_each_va_range_safe - iternator to safely walk over a range of
> >> + * &drm_gpuvas
> >> + * @va__: &drm_gpuva to assign to in each iteration step
> >> + * @next__: another &drm_gpuva to use as temporary storage
> >> + * @mgr__: &drm_gpuva_manager to walk over
> >> + * @start__: starting offset, the first gpuva will overlap this
> >> + * @end__: ending offset, the last gpuva will start before this (but may
> >> + * overlap)
> >> + *
> >> + * This iterator walks over all &drm_gpuvas in the &drm_gpuva_manager that lie
> >> + * between @start__ and @end__. It is implemented similarly to
> >> + * list_for_each_safe(), but is using the &drm_gpuva_manager's internal interval
> >> + * tree to accelerate the search for the starting &drm_gpuva, and hence is safe
> >> + * against removal of elements. It assumes that @end__ is within (or is the
> >> + * upper limit of) the &drm_gpuva_manager. This iterator does not skip over the
> >> + * &drm_gpuva_manager's @kernel_alloc_node.
> >> + */
> >> +#define drm_gpuva_for_each_va_range_safe(va__, next__, mgr__, start__, end__) \
> >> +	for (va__ = drm_gpuva_find_first((mgr__), (start__), (end__)), \
> >> +	     next__ = va ? list_next_entry(va__, rb.entry) : NULL; \
> >> +	     va__ && (va__->va.addr < (end__)) && \
> >> +	     !list_entry_is_head(va__, &(mgr__)->rb.list, rb.entry); \
> >> +	     va__ = next__, next__ = list_next_entry(va__, rb.entry))  
> > 
> > And this is the safe version using the drm_gpuva_next() helper:
> > 
> > 	for (va__ = drm_gpuva_find_first((mgr__), (start__), (end__) - (start__)), \
> > 	     next__ = drm_gpuva_next(va__); \
> > 	     va__ && (va__->va.addr < (end__)); \
> > 	     va__ = next__, next__ = drm_gpuva_next(va__))
> > 
> > Those changes fixed an invalid pointer access I had in the sm_unmap()
> > path.
> >   
> 
> Sorry you did run into this bug.

No worries, that's what testing/debugging/reviewing is for. And I'm glad
someone decided to work on this gpuva stuff so I don't have to code it
myself, so that's the least I can do.
