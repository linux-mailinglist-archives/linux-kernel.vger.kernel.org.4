Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864F66A3B52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB0GjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0GjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9FA5CA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 22:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677479907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+UG2oWxtK4UHFvkDOIm8sJ8ImrluBqKEzcmgsSAFFPA=;
        b=G7SeUCbgL+9nhejCWp9o6RfxSh3UufrJmYqIEgObanV/u2kSAbS0WCgKhfg/dacOkyIJXW
        lv3fHvIdy5x5V5piXROReYia1edeBZURZiAsHCEsgSnUpE3/fdXDVrkfe1oZqBIbo7yv/7
        Yv4A4a2xgT73cLm8zqFopGYyDhksoM4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-8ceeMC1mP9mgVdcbxYFawQ-1; Mon, 27 Feb 2023 01:38:23 -0500
X-MC-Unique: 8ceeMC1mP9mgVdcbxYFawQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E53395D605;
        Mon, 27 Feb 2023 06:38:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 134CDC15BAD;
        Mon, 27 Feb 2023 06:38:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8BCF61800393; Mon, 27 Feb 2023 07:38:21 +0100 (CET)
Date:   Mon, 27 Feb 2023 07:38:21 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
        Ryan Neph <ryanneph@chromium.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: Add option to disable KMS support
Message-ID: <20230227063821.dg2gbjjwcekbxyzw@sirius.home.kraxel.org>
References: <20230224180225.2477641-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224180225.2477641-1-robdclark@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:02:24AM -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a build option to disable modesetting support.  This is useful in
> cases where the guest only needs to use the GPU in a headless mode, or
> (such as in the CrOS usage) window surfaces are proxied to a host
> compositor.

Why make that a compile time option?  There is a config option for the
number of scanouts (aka virtual displays) a device has.  Just set that
to zero (and fix the driver to not consider that configuration an
error).

take care,
  Gerd

