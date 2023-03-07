Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824476AE290
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjCGOdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCGOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:32:11 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB59776;
        Tue,  7 Mar 2023 06:27:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7CD0C4261B;
        Tue,  7 Mar 2023 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678199275;
        bh=HxG6/03qUzMmm6Reqvh7X3TDLICxkEPU4hm2AoOUuLM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=g3xFbOLpqvFL/hWEeMzgFc3LbdSVcVVsMJh/7XdjhA21c4wx1kxrwdRtnbBmxPrrB
         2CGtpUGuIbw1gEu5imAbrxziNlTiqNnrk9HQk6htxBgOV6yuRyAeYQAftV86CAMQyw
         rFeLzqMi0pBOmRpRumEPybDrr5v4ua3EE16+Kga4TDShw9EzMtRDc5h6TWQR4AZqq7
         3g7gcLKGYG8RlArpFBJ0vDqyTFx613T1iY05PGhXC9pjVYp6nnc64K8hGhUGFW22jy
         LTR2hm4pngwLC6oJFdPUBUSRu+WicCyQcDZg4hcZo9sny6I9PNUD4JoUMn1kTrd0Pt
         ZdyZOrGEziyIA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Tue, 07 Mar 2023 23:25:35 +0900
Subject: [PATCH RFC 10/18] drm/scheduler: Add can_run_job callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-rust-drm-v1-10-917ff5bc80a8@asahilina.net>
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
In-Reply-To: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678199191; l=1943;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=HxG6/03qUzMmm6Reqvh7X3TDLICxkEPU4hm2AoOUuLM=;
 b=gWfErbdeUWtPqx2eFx2Rt2xD+1XYyU5Cx/mGxM2DFb9ZT5eqFV3aK1C6shksKCRoFpXgeFx1G
 VYNphDGVo+oCMIwMR6FaFIFL6uXkU2jraVwiGVuBeBb8B9h5YjTCH5I
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some hardware may require more complex resource utilization accounting
than the simple job count supported by drm_sched internally. Add a
can_run_job callback to allow drivers to implement more logic before
deciding whether to run a GPU job.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/gpu/drm/scheduler/sched_main.c | 10 ++++++++++
 include/drm/gpu_scheduler.h            |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 4e6ad6e122bc..5c0add2c7546 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1001,6 +1001,16 @@ static int drm_sched_main(void *param)
 		if (!entity)
 			continue;
 
+		if (sched->ops->can_run_job) {
+			sched_job = to_drm_sched_job(spsc_queue_peek(&entity->job_queue));
+			if (!sched_job) {
+				complete_all(&entity->entity_idle);
+				continue;
+			}
+			if (!sched->ops->can_run_job(sched_job))
+				continue;
+		}
+
 		sched_job = drm_sched_entity_pop_job(entity);
 
 		if (!sched_job) {
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9db9e5e504ee..bd89ea9507b9 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -396,6 +396,14 @@ struct drm_sched_backend_ops {
 	struct dma_fence *(*prepare_job)(struct drm_sched_job *sched_job,
 					 struct drm_sched_entity *s_entity);
 
+	/**
+	 * @can_run_job: Called before job execution to check whether the
+	 * hardware is free enough to run the job.  This can be used to
+	 * implement more complex hardware resource policies than the
+	 * hw_submission limit.
+	 */
+	bool (*can_run_job)(struct drm_sched_job *sched_job);
+
 	/**
          * @run_job: Called to execute the job once all of the dependencies
          * have been resolved.  This may be called multiple times, if

-- 
2.35.1

