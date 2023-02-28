Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774946A595B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjB1MrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB1MrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:47:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D432FCF1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677588385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AR9g0+21GGmCwkSUOYa0isQeV+cYWFL+wM4f9rZ618=;
        b=d4c8qUn3tm0VjowvFS7Q+G8mAHjVDepSs/8m579yQKiCCC/fTG8SYl+hfyWf3+HYFEPESu
        dBFVG4EayQs6jeHBaGH0pqHAht0K2Apj+56AXYES8Q9/TNkNwBAcjT3ytNWrjcUah2F4Pv
        uYYDiapKrPWePbrpYad4wA46C5nlLkM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-q4eF9EK2NU6fW6LtVkickg-1; Tue, 28 Feb 2023 07:46:22 -0500
X-MC-Unique: q4eF9EK2NU6fW6LtVkickg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC83838221C3;
        Tue, 28 Feb 2023 12:46:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EE90492B0E;
        Tue, 28 Feb 2023 12:46:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3C10E180099A; Tue, 28 Feb 2023 13:46:20 +0100 (CET)
Date:   Tue, 28 Feb 2023 13:46:20 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/virtio: Add option to disable KMS support
Message-ID: <20230228124620.pfjvj372rifiljew@sirius.home.kraxel.org>
References: <20230227173800.2809727-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227173800.2809727-1-robdclark@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> +		if (!vgdev->num_scanouts) {
> +			/*
> +			 * Having an EDID but no scanouts is non-sensical,
> +			 * but it is permitted to have no scanouts and no
> +			 * EDID (in which case DRIVER_MODESET and
> +			 * DRIVER_ATOMIC are not advertised)
> +			 */
> +			if (vgdev->has_edid) {
> +				DRM_ERROR("num_scanouts is zero\n");

That error message isn't very clear.

Also I'd suggest to just drop the edid check.  It's about commands
being supported by the device, not about the actual presence of an EDID
blob, so the check doesn't look very useful to me.

take care,
  Gerd

