Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DF86AE294
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCGOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCGOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:33:11 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662359FA;
        Tue,  7 Mar 2023 06:28:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E6EB8426E8;
        Tue,  7 Mar 2023 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1678199282;
        bh=mMV3DK/LniFSMGRFdp6WL8dzfr5kUnLaVi0jQqujgO4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=YJhY78Ggk6+W6QBEOqupDX8aw5fWn6A/G56oEd7cyWJWvL0r748JHim/QFX3ga48h
         YlBahQ3QVQCtfglCOCwzF6GQnjnzKV0/4hYvwC31Y0uSRr4V+b3CUQ18zAkJuPAhzS
         ag95heC6renT1r1t7WaaCKqFa+8tqdzSsHCfhzZdGi7T9Kwk/2BnkgTAnLfc6MW1Au
         QQuJCcei56DnsCxfewGchiUhK7mQhwLnKfv3ijhcbx+NBUlpUiX39s0hxPnFjbzUg0
         pFeU78xSX4yDPScrSCDZRGPIo+U0IsltRbUa79WeKf7JcpsOlh5dgZBcvyy0t2tEmP
         6/bMok2XoIg2Q==
From:   Asahi Lina <lina@asahilina.net>
Date:   Tue, 07 Mar 2023 23:25:36 +0900
Subject: [PATCH RFC 11/18] drm/scheduler: Clean up jobs when the scheduler
 is torn down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-rust-drm-v1-11-917ff5bc80a8@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678199191; l=2245;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=mMV3DK/LniFSMGRFdp6WL8dzfr5kUnLaVi0jQqujgO4=;
 b=my5v1HGy930nc+3OP/Xw50JgUtnm2HGl3Rz4cVd2S5YoFUr5PVzWJZx9x3QmCcStWOHa4pvE4
 +sIUSbGMdJ7CD+mn/ehaerq/gWofZP8Suo1RhZdOI9n3Y8dnSIkG167
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

drm_sched_fini() currently leaves any pending jobs dangling, which
causes segfaults and other badness when job completion fences are
signaled after the scheduler is torn down.

Explicitly detach all jobs from their completion callbacks and free
them. This makes it possible to write a sensible safe abstraction for
drm_sched, without having to externally duplicate the tracking of
in-flight jobs.

This shouldn't regress any existing drivers, since calling
drm_sched_fini() with any pending jobs is broken and this change should
be a no-op if there are no pending jobs.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/gpu/drm/scheduler/sched_main.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 5c0add2c7546..0aab1e0aebdd 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1119,10 +1119,33 @@ EXPORT_SYMBOL(drm_sched_init);
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
 	struct drm_sched_entity *s_entity;
+	struct drm_sched_job *s_job, *tmp;
 	int i;
 
-	if (sched->thread)
-		kthread_stop(sched->thread);
+	if (!sched->thread)
+		return;
+
+	/*
+	 * Stop the scheduler, detaching all jobs from their hardware callbacks
+	 * and cleaning up complete jobs.
+	 */
+	drm_sched_stop(sched, NULL);
+
+	/*
+	 * Iterate through the pending job list and free all jobs.
+	 * This assumes the driver has either guaranteed jobs are already stopped, or that
+	 * otherwise it is responsible for keeping any necessary data structures for
+	 * in-progress jobs alive even when the free_job() callback is called early (e.g. by
+	 * putting them in its own queue or doing its own refcounting).
+	 */
+	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
+		spin_lock(&sched->job_list_lock);
+		list_del_init(&s_job->list);
+		spin_unlock(&sched->job_list_lock);
+		sched->ops->free_job(s_job);
+	}
+
+	kthread_stop(sched->thread);
 
 	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
 		struct drm_sched_rq *rq = &sched->sched_rq[i];

-- 
2.35.1

