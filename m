Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6567CAC2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbjAZMSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbjAZMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1872D5DC2F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674735433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmjWDDDaOKoHLyiWRUyi7QZP+P/9RQam7lY9KQxWlvQ=;
        b=U9usGvxANFQ5Dg5M57lkkb3/4FIp1VRW7ed3FEzlt98QknkzXcI2uoWO+mnwjlTmMoCLrR
        cHiaSVhNZ+UNM5pemwdW3a7vLBSR0MOn97jx6ZOmwBPKtDGWXTe4FB9tiy5sXQLXf0qVqm
        R6h9IV7uVNqy1jIh71LWs9hgEeuG3Pg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-StpZteGWPNupwA7THPGiNA-1; Thu, 26 Jan 2023 07:17:07 -0500
X-MC-Unique: StpZteGWPNupwA7THPGiNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC0233C42204;
        Thu, 26 Jan 2023 12:17:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 872EB140EBF5;
        Thu, 26 Jan 2023 12:17:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 57F9B180093F; Thu, 26 Jan 2023 13:17:05 +0100 (CET)
Date:   Thu, 26 Jan 2023 13:17:05 +0100
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
Message-ID: <20230126121705.wsm62yxco7cubwyf@sirius.home.kraxel.org>
References: <20230108210445.3948344-1-dmitry.osipenko@collabora.com>
 <20230108210445.3948344-7-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108210445.3948344-7-dmitry.osipenko@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 12:04:40AM +0300, Dmitry Osipenko wrote:
>  its own refcounting of vmaps, use it instead of drm-shmem
> counting. This change prepares drm-shmem for addition of memory shrinker
> support where drm-shmem will use a single dma-buf reservation lock for
> all operations performed over dma-bufs.

Likewise truncated?

take care,
  Gerd

