Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CA25FA256
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJJRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJJRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C933E63FD2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+c3EQZpIPsURLACPBP9f4RJ+bRE7qS3eRh9PTauwjJ8=;
        b=QwPH3vC6aQL5ENdZwgi97Tu2LXKeeH0KeFFQ18lFYIC8+E0L0T+iEqGYvFa5Lxl5j3cYva
        G5PsqkPEhJK4pyHbYMghvBLzG8SCyTFoAcPWtLHx+yVF8zYyxjoXgxObp56sHawiSKQiCq
        NMLVH7qGldISlg2nfMLLv+AR7lU6OZY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-382-4PHO8jo5OM67kP1smrc1aA-1; Mon, 10 Oct 2022 13:02:13 -0400
X-MC-Unique: 4PHO8jo5OM67kP1smrc1aA-1
Received: by mail-wm1-f72.google.com with SMTP id 2-20020a05600c268200b003c4290989e1so1723291wmt.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c3EQZpIPsURLACPBP9f4RJ+bRE7qS3eRh9PTauwjJ8=;
        b=yX0BO3Q1ef8QgKTNyzVMUg+PqbKk04K6YalVxbBF33tSk9TlzT9fELvT0wjwssIXFj
         sqVUBMKrDvEXPAluaPhLIhsoO32yS4k5dMJhEH78o9sd8GasEU/B64aGTC4SZdHueVqx
         QjzguXb+IUJoWTkWRkYPozBgaKQuIKI1RvXLJuvtwxdK4u7A5ABe0hon7px1q54JVWsc
         dgkHWGscTwLKoKuSjpd9XfhqUjQY9YzOdZR1viyhVaXOzkg1712jMmJmXEtCsIli3wzJ
         MxaGgfqrD0sbvgYhThy32wO1ylHhRD42iv6FnA93DEgh8qDavz4OOCKQUW3LmW5pOzUF
         7MLg==
X-Gm-Message-State: ACrzQf22eWpJTl/PhVtAu3QqGtBOGAzHEzZkfUslz3NKmkJ9naiCGU8u
        M/P0bN6bCI5X4GZMlFcF0alcpCA+enlaPGKWfzjdFpkz/BGqtgmR1vr32xSZfWYriJ1lAGajiwf
        8MgudOnsR/WKXxLLbNzlMxqm1zLZOX1xbZMO8vk4BrWrhtXFNO1sDj9Xfnh/KXTNiHZIseZR0tm
        k=
X-Received: by 2002:a05:6000:551:b0:22e:4499:a478 with SMTP id b17-20020a056000055100b0022e4499a478mr12200559wrf.459.1665421330784;
        Mon, 10 Oct 2022 10:02:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Qgh7vPJ9S+rl4LeW8JqyrNbCa2SFM/S3yVwBP6AfOtVL67cbLaUPV6uIlzV1fKYJjvcIUXg==
X-Received: by 2002:a05:6000:551:b0:22e:4499:a478 with SMTP id b17-20020a056000055100b0022e4499a478mr12200529wrf.459.1665421330447;
        Mon, 10 Oct 2022 10:02:10 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5-20020a056000110500b0022b11a27e39sm9160551wrw.1.2022.10.10.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:02:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/3] Add a drm_crtc_helper_atomic_check() helper
Date:   Mon, 10 Oct 2022 19:02:00 +0200
Message-Id: <20221010170203.274949-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function and make drivers that have the same logic in their
struct drm_crtc_helper_funcs .atomic_check handler to use this instead.

Patch #1 and #2 are just cleanups for the simpledrm and ssd130x drivers
respectively, so that these can be converted to use the helper added by
patch #3. The changes are inspired by a patch from Thomas Zimmermann for
the ast DRM driver:

https://patchwork.kernel.org/project/dri-devel/patch/20221010103625.19958-4-tzimmermann@suse.de/

Best regards,
Javier


Javier Martinez Canillas (3):
  drm/simpledrm: Do not call drm_atomic_add_affected_planes()
  drm/ssd130x: Do not call drm_atomic_add_affected_planes()
  drm/crtc-helper: Add a drm_crtc_helper_atomic_check() helper

 drivers/gpu/drm/drm_crtc_helper.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/solomon/ssd130x.c | 20 ++------------------
 drivers/gpu/drm/tiny/simpledrm.c  | 20 ++------------------
 include/drm/drm_crtc_helper.h     |  2 ++
 4 files changed, 30 insertions(+), 36 deletions(-)

-- 
2.37.3

