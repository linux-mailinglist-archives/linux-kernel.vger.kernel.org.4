Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7331067DED8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjA0IG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjA0IG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:06:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9822B761ED
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674806770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WQuD4/LhmMQmyGAfci83sbqVYALJwpjalG6/ork/Os=;
        b=b/KbGh009e0N/5Nhs8w6gpxhrHTmqPsu0fqmuq9OZR+3tOyUuq0r2Zindpjua4RDeSKz7s
        PgZBF4hREpt9pWslArJtNs1wzw9Ixn/m7z8CYWBUE80TgxlzYdEsSg73oQBcfzHMxwDODK
        945c2sHCsq6JY3f+mKTmb01l1jt6cds=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-j9-8DRbVNNi1maITv3YBSQ-1; Fri, 27 Jan 2023 03:06:06 -0500
X-MC-Unique: j9-8DRbVNNi1maITv3YBSQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D6503815F67;
        Fri, 27 Jan 2023 08:06:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE848492C14;
        Fri, 27 Jan 2023 08:06:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9E9AC1800606; Fri, 27 Jan 2023 09:06:03 +0100 (CET)
Date:   Fri, 27 Jan 2023 09:06:03 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@gmail.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v10 06/11] drm/shmem-helper: Don't use vmap_use_count for
 dma-bufs
Message-ID: <20230127080603.ioybmevyflhewdxe@sirius.home.kraxel.org>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <20230108210445.3948344-7-dmitry.osipenko@collabora.com>
 <20230126121705.wsm62yxco7cubwyf@sirius.home.kraxel.org>
 <75698ab8-2e0b-8673-2f7d-83ffa37f447b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75698ab8-2e0b-8673-2f7d-83ffa37f447b@collabora.com>
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

On Thu, Jan 26, 2023 at 03:24:30PM +0300, Dmitry Osipenko wrote:
> On 1/26/23 15:17, Gerd Hoffmann wrote:
> > On Mon, Jan 09, 2023 at 12:04:40AM +0300, Dmitry Osipenko wrote:
> >>  its own refcounting of vmaps, use it instead of drm-shmem
> >> counting. This change prepares drm-shmem for addition of memory shrinker
> >> support where drm-shmem will use a single dma-buf reservation lock for
> >> all operations performed over dma-bufs.
> > 
> > Likewise truncated?
> 
> Should be the email problem on yours side, please see [1][2] where the
> messages are okay.

Indeed, scratch the comments then.

take care,
  Gerd

