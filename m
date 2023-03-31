Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41C86D13D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCaAHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjCaAHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14CFCDFD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680221188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YRYzYgFniGZhvmi5nnobFxQwki5yQ+bNYK75Yzixkz4=;
        b=T2TGbSO2om5LB5mEgfFDFSTss46RDcaFZ4sotrV22kbHNPeMpV5xs97ST97c3nM9SavLnk
        qI7UB2QMLgaukXV8bdFCwZfuIAneA4r3DuLqjCmzxhGZuts9IvNRTA3KXi1cpoCZBGZup6
        M3+lBUJJREF3xnVXkIpnZFeOzwV+8Yc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-Ydyc2FalNRKTVQrq__8I9Q-1; Thu, 30 Mar 2023 20:06:26 -0400
X-MC-Unique: Ydyc2FalNRKTVQrq__8I9Q-1
Received: by mail-wm1-f72.google.com with SMTP id v7-20020a05600c470700b003ef6ebfa99fso7216856wmo.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680221185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRYzYgFniGZhvmi5nnobFxQwki5yQ+bNYK75Yzixkz4=;
        b=sVD6+YwERZx5Wg6SVOaFxirw+F109tVCqWZyzKLp8YD8O5f663dhwwKwTaX67jZQAK
         m3KrOICldzRnFgiImXMe7AZXNH0PBq80OOjqZgugooQ/CsO7I4AP8ntIBO+1Z2tDJ7Ar
         1hAsufduFJwSgPwwzi7Z6vgvl0UHZfHn1W4tDtQF2NFLGwC9vNKlUV5fmxINrFOaA1lf
         4LVG0vMCznbR5WAkSZh35Xn4wc5SfUlahufY/CUM7z8u5iRsjXBtLNYDlBOeLo2G9uj0
         4CczC3wCyQBvVvF9N2jwMYb4MeNWmwe3kYE5wx6za87feCvFrW5wPitLZUy7Zlxs0B31
         nF+w==
X-Gm-Message-State: AAQBX9dRdG/zGTCTcNkP+l1Ghp2k2NN0ugJuNvNtwIg5MaOr7wljp3lz
        CblF6faqaGDEyPbRQ3dgfZ21rBCFenwjYZws/RnzGxEtU6U1Jid3VyeqFmVaeKosfYMGVRkuHiX
        FTazEB++hJBbbRq15JMS2V5+B
X-Received: by 2002:a5d:5229:0:b0:2c7:1c08:121c with SMTP id i9-20020a5d5229000000b002c71c08121cmr19692649wra.61.1680221185597;
        Thu, 30 Mar 2023 17:06:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350bglDYOowPykLhBMeJiilPpFbF5617zH9by5JhkVIpDXwqrgWjr0LW6yJQAzUG+HeI0ngmnFA==
X-Received: by 2002:a5d:5229:0:b0:2c7:1c08:121c with SMTP id i9-20020a5d5229000000b002c71c08121cmr19692638wra.61.1680221185320;
        Thu, 30 Mar 2023 17:06:25 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id g16-20020a5d5550000000b002c5598c14acsm662655wrw.6.2023.03.30.17.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 17:06:24 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     luben.tuikov@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        l.stach@pengutronix.de, christian.koenig@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] drm/scheduler: set entity to NULL in drm_sched_entity_pop_job()
Date:   Fri, 31 Mar 2023 02:06:22 +0200
Message-Id: <20230331000622.4156-1-dakr@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
I'm aware that drivers could already use job->entity in arbitrary places, since
they in control of when the entity is actually freed. A quick grep didn't give
me any results where this would actually be the case, however maybe I also just
didn't catch it.

If, therefore, we don't want to set job->entity to NULL I think we should at
least add a comment somewhere.
---

 drivers/gpu/drm/scheduler/sched_entity.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
 
-- 
2.39.2

