Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2AF6E5E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDRKFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDRKFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A7448B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681812299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kkPmtUJM/y/8ZMLgmPzrDpSz/aD5s4kTz4AWJ+kwyns=;
        b=FXy+hhuLkrzXT8MprYeWrK1kuYnjpSdY5338FXwFYs/xooNOaGvQryLazxiwwUluyW/dAp
        y8oWFZVbX/ps3mstfeAkPqAT4qEHH8pIEsrKFAIwzvNjDkGW7VwVQy5pIdkHiORDxlmjtD
        nx/a5mTKsc9X847aq/MLvIR5W6okLVw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-a2_MzuasOIy1lf15vIdRRQ-1; Tue, 18 Apr 2023 06:04:58 -0400
X-MC-Unique: a2_MzuasOIy1lf15vIdRRQ-1
Received: by mail-ej1-f70.google.com with SMTP id qk25-20020a170906d9d900b0094f0dd1166dso3026651ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812297; x=1684404297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkPmtUJM/y/8ZMLgmPzrDpSz/aD5s4kTz4AWJ+kwyns=;
        b=AqP7v95T9HGFMfcZeWJbBBy4HOYydO8hpSmrKmww/2h//en/OQ4DQloTbY6+wITNGD
         nd0EgPXBK3v2oC9BZUmQsmnBx7VpdJUZksftZryUP2KdwajIu/jHw8Vgd4db+Hp06o5h
         adBaEDVyjG9zcBdTb69/cygaJQAhREwKB5jihgsnZkaYecPJpssQQgVmPuiH0hUOY6yv
         iyH/Rqrmrdpv6bCcH9TysOOmacoX9g7JFcPjOWdwdUsLplv3VGlywLv2nImaU+jlQkLO
         m92xzlsuoNQFnPhJbijUaIcHLnQKdJJBFmlvBfDxbtXeruzs/se+6sClhdFLbGfGdCEm
         H4Vw==
X-Gm-Message-State: AAQBX9eldRRKASOhe2tA72JHQNWZtjQ8CZX0bk2KhGVh05lzCVaPj7ZI
        fLmbg56TV4biPLnM29zh93g7zeZqlbQF+4v38+Rur/36Ls47PW4YOX9n34PmYhav60LNbYJt453
        WC5jS1QWTe2HJWMpF/pruCgXY
X-Received: by 2002:a17:906:f6cd:b0:94f:3bf7:dacf with SMTP id jo13-20020a170906f6cd00b0094f3bf7dacfmr7523192ejb.71.1681812297377;
        Tue, 18 Apr 2023 03:04:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350a+XHfJpZZVIUYU09ecLUdbAZs0U1PMVcoHiowslaeLzqa8MByKR7gSpV0az5yz9+7T0p4Ipg==
X-Received: by 2002:a17:906:f6cd:b0:94f:3bf7:dacf with SMTP id jo13-20020a170906f6cd00b0094f3bf7dacfmr7523179ejb.71.1681812297083;
        Tue, 18 Apr 2023 03:04:57 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906361200b0094f124a37c4sm5131590ejb.18.2023.04.18.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 03:04:56 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     luben.tuikov@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        l.stach@pengutronix.de, christian.koenig@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2] drm/scheduler: set entity to NULL in drm_sched_entity_pop_job()
Date:   Tue, 18 Apr 2023 12:04:53 +0200
Message-Id: <20230418100453.4433-1-dakr@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It already happend a few times that patches slipped through which
implemented access to an entity through a job that was already removed
from the entities queue. Since jobs and entities might have different
lifecycles, this can potentially cause UAF bugs.

In order to make it obvious that a jobs entity pointer shouldn't be
accessed after drm_sched_entity_pop_job() was called successfully, set
the jobs entity pointer to NULL once the job is removed from the entity
queue.

Moreover, debugging a potential NULL pointer dereference is way easier
than potentially corrupted memory through a UAF.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 6 ++++++
 drivers/gpu/drm/scheduler/sched_main.c   | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 15d04a0ec623..a9c6118e534b 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -448,6 +448,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 			drm_sched_rq_update_fifo(entity, next->submit_ts);
 	}
 
+	/* Jobs and entities might have different lifecycles. Since we're
+	 * removing the job from the entities queue, set the jobs entity pointer
+	 * to NULL to prevent any future access of the entity through this job.
+	 */
+	sched_job->entity = NULL;
+
 	return sched_job;
 }
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 9b16480686f6..e89a3e469cd5 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -42,6 +42,10 @@
  *    the hardware.
  *
  * The jobs in a entity are always scheduled in the order that they were pushed.
+ *
+ * Note that once a job was taken from the entities queue and pushed to the
+ * hardware, i.e. the pending queue, the entity must not be referenced anymore
+ * through the jobs entity pointer.
  */
 
 #include <linux/kthread.h>
-- 
2.39.2

