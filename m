Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193136F505B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjECGwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECGw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 02:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D632680
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683096700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAUDt/vzN1VeMkqTdFA804MyRykQ+diCShj5qJ6AEJ4=;
        b=JNoN2wEwPZZ5dK2KZNJYmsxJnfJa3R+k9HrDlhYqhM9WliByDVbJSV0gr20H8OOJ8IQyYZ
        jm6wmQWJ5pS0aRgIQowk618ejn0UgdtUs9IqXI+vGYa0HaSUsQmiHQtuFk0aIr5gBdMOGC
        NVGVpzsnlijgqM4RevVBsJHQz0b8mz8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-gXx-JDx6N4OsBA4ZlslPRw-1; Wed, 03 May 2023 02:51:39 -0400
X-MC-Unique: gXx-JDx6N4OsBA4ZlslPRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78C12185A78B;
        Wed,  3 May 2023 06:51:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0F5740F2D4B;
        Wed,  3 May 2023 06:51:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3E967180093A; Wed,  3 May 2023 08:51:36 +0200 (CEST)
Date:   Wed, 3 May 2023 08:51:36 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
Message-ID: <6g5bonxpnlw7pcyt3pqrcty2exknpesst4i3v24nqxi3fy5gkr@5rej6zbfadta>
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
 <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141b928d-6165-f282-b8e6-f140cb09333d@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 06:38:45PM +0300, Dmitry Osipenko wrote:
> On 4/16/23 14:52, Dmitry Osipenko wrote:
> > We have multiple Vulkan context types that are awaiting for the addition
> > of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:
> > 
> >  1. Venus context
> >  2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)
> > 
> > Mesa core supports DRM sync object UAPI, providing Vulkan drivers with a
> > generic fencing implementation that we want to utilize.
> > 
> > This patch adds initial sync objects support. It creates fundament for a
> > further fencing improvements. Later on we will want to extend the VirtIO-GPU
> > fencing API with passing fence IDs to host for waiting, it will be a new
> > additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU context
> > drivers in works that require VirtIO-GPU to support sync objects UAPI.
> > 
> > The patch is heavily inspired by the sync object UAPI implementation of the
> > MSM driver.
> 
> Gerd, do you have any objections to merging this series?

No objections.  Can't spot any issues, but I also don't follow drm close
enough to be able to review the sync object logic in detail.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

