Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B306A6771
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 06:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCAFvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 00:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCAFvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:51:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF2F3645E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 21:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677649813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ckGumOJdLFih87T5un7JUmXQL9qObNSTxVhiK7Kwu5M=;
        b=WrVVrVvv9RjssjbkUktSBf5cY6c3Qgc8q1fFaGcG4xgIyOzP7gWTeWzPiXBiKQiQs6KQit
        xTEgfCxTbS33zqGgJwk6HSAYvqz2UaZhQe/duGUk/xNybK46UJ9P4o69saAKtKZxDFUTlf
        GGSbunDktIzJxXFN+QwwoyiOll9+yoo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-qUFLjPVjMimadptElzBKVw-1; Wed, 01 Mar 2023 00:50:07 -0500
X-MC-Unique: qUFLjPVjMimadptElzBKVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94DC180D104;
        Wed,  1 Mar 2023 05:50:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B6C62166B26;
        Wed,  1 Mar 2023 05:50:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 50B7C180309B; Wed,  1 Mar 2023 06:50:03 +0100 (CET)
Date:   Wed, 1 Mar 2023 06:50:03 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Chia-I Wu <olvaffe@gmail.com>, Ryan Neph <ryanneph@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] drm/virtio: Add option to disable KMS support
Message-ID: <20230301055003.ondht4o2ojajxt74@sirius.home.kraxel.org>
References: <20230228155406.2881252-1-robdclark@gmail.com>
 <583bf774-5594-5553-f5e2-45ccf7babff7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <583bf774-5594-5553-f5e2-45ccf7babff7@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:37:24AM +0300, Dmitry Osipenko wrote:
> On 2/28/23 18:54, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Add a build option to disable modesetting support.  This is useful in
> > cases where the guest only needs to use the GPU in a headless mode, or
> > (such as in the CrOS usage) window surfaces are proxied to a host
> > compositor.
> > 
> > As the modesetting ioctls are a big surface area for potential security
> > bugs to be found (it's happened in the past, we should assume it will
> > again in the future), it makes sense to have a build option to disable
> > those ioctls in cases where they serve no legitimate purpose.
> > 
> > v2: Use more if (IS_ENABLED(...))
> > v3: Also permit the host to advertise no scanouts
> > v4: Spiff out commit msg
> > 
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> 
> Gerd, to give you some context on the v4.. we've chatted a bit more on
> the #dri-devel and concluded that config option is the most robust way
> of having KMS disabled from a security stand point. We would also want
> to have a per-driver option (and not global) because there are scenarios
> of using passthrough GPU + virtio-gpu in a guest, hence we would only
> want to toggle KMS for a particular driver.

IMHO both ways options to disable the KMS bits should work the same way.
With the current patch modeset_init() runs with num_scanouts == 0 but
doesn't with CONFIG_KMS=n.  There are also two different ways to tweak
driver_features.  Can we get rid of that please, for robustness reasons?

I'd suggest to have a is_kms_enabled() helper function (probably best as
inline so gcc can figure it is constant false for CONFIG_KMS=n and throw
away unreachable code).  Add "if (!is_kms_enabled()) return;" to
modeset_init() and modeset_fini() instead of stubbing them out.  Use the
drm_device->driver_features override in both cases.

Also the edid check can go away.  As already mentioned this is about a
device feature not a edid being present.

take care,
  Gerd

