Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5B6A7205
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCARZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCARZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:25:46 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F803CE2E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:25:46 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id eg37so56731742edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 09:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGpSg9k17aWT56J8ESLMcQ9AizPFi87Eiw+yaS3AOCw=;
        b=n8zWH/MlMMgN27wnO6J2y/HeI0n1+Rmr0p3ClSf5D5f+RJi502iMbPPq7mCwFIbxew
         75m/Z6GIKizq6q3G1Ky0qivM27oMW5BRrRAUFauFSB6MXC4x5FrzVsqrO2qXXwH6v8CF
         P4F1e+SOu3aIkJqh6zJ607IWae8A7fgNYw3bfKo/yII5XFchV70BE6cEy2CB+pEaIF/Y
         yipyrGmZl2ox9D5racFirklUAuAneGOwEzuaJPGp7/n1dGltVbcC1Iu0Qlld/GhKLJtS
         d/Mxj3qxFXvF3RNvQKQ5ZEUiy2i1VFN/CibE50hE+v+YLfbpGdXWQtOR9cJ/DVIebms+
         gntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGpSg9k17aWT56J8ESLMcQ9AizPFi87Eiw+yaS3AOCw=;
        b=yhONcGdjFPggJo6Dwyanl0cuje7jmHTIZRuH79a/V4V0mTA5lYowpQhkMKEbUS6/c7
         KWpZ/25Uo/BxlvOinMhWNxLnmF299xP4dS/c56UeWS3jOGys9t6CoojtwV81yEPuHkiC
         OD58Hhmg5CPn6ZxQFTwZS/5BbH4FLMRp8TucVrOq7s0ja+auhXgh7SmxJ351AFTW/NDi
         1k19I/A2p9DVaWkljWK8d2v2H0lHcZRIwd1ZlFf++4+9s0RB4uolAtTLCpei96EkXH7/
         gD5uj8hkDi6SoRrLHI6crCg3mvMJL1iPTyf8JPfS/WEcMqeRza8YWFde0GUxu7eXPTt0
         8scA==
X-Gm-Message-State: AO0yUKWnkdEFujUR2gvfp6leUkCIpWGh62kqsOlSDuq/e8JsJQqeF5LY
        XK0dbLc0bAnodeiKbnn5+SM=
X-Google-Smtp-Source: AK7set/RdNqzJLsFGCwGBU2hCZ6jT/oewFdddt3HHcP8VqmlvRUBJv04SfeD9uvvD6LZ7BxXIR0o+Q==
X-Received: by 2002:a17:906:69c7:b0:88d:9cf8:2dbb with SMTP id g7-20020a17090669c700b0088d9cf82dbbmr6504821ejs.12.1677691544425;
        Wed, 01 Mar 2023 09:25:44 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id v23-20020a170906489700b008e9ac1ad79dsm5974715ejq.194.2023.03.01.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:25:44 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Wed, 01 Mar 2023 18:25:37 +0100
Subject: [PATCH 1/2] drm/nouveau/device: avoid usage of list iterator after
 loop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230301-drm-nouveau-avoid-iter-after-loop-v1-1-0702ec23f970@gmail.com>
References: <20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com>
In-Reply-To: <20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677691543; l=2000;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=gzlpAicQX0rX29VOXLewaf79YUBgb8hjXaJCe+N3/OU=;
 b=khgQNjBDqCsqPWJJ693j/U1NsNOSGFNW127MUStil+3KrMBgy5uXMTdUjnU4FAqTOG/qWHpwBHNY
 OoSLMt5qAhM77SLXVzpOr9E0u1YvtfCP7kJlDyu7nHOcEZBiTXC1
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If potentially no valid element is found, 'pstate' would contain an
invalid pointer past the iterator loop. To ensure 'pstate' is always
valid, we only set it if the correct element was found. That allows
adding a BUG_ON in case the code works incorrectly, exposing currently
undetectable potential bugs.

Additionally, Linus proposed to avoid any use of the list iterator
variable after the loop, in the attempt to move the list iterator
variable declaration into the marcro to avoid any potential misuse after
the loop [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
index ce774579c89d..7c9dd91e98ee 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
@@ -72,7 +72,7 @@ nvkm_control_mthd_pstate_attr(struct nvkm_control *ctrl, void *data, u32 size)
 	} *args = data;
 	struct nvkm_clk *clk = ctrl->device->clk;
 	const struct nvkm_domain *domain;
-	struct nvkm_pstate *pstate;
+	struct nvkm_pstate *pstate = NULL, *iter;
 	struct nvkm_cstate *cstate;
 	int i = 0, j = -1;
 	u32 lo, hi;
@@ -103,11 +103,14 @@ nvkm_control_mthd_pstate_attr(struct nvkm_control *ctrl, void *data, u32 size)
 		return -EINVAL;
 
 	if (args->v0.state != NVIF_CONTROL_PSTATE_ATTR_V0_STATE_CURRENT) {
-		list_for_each_entry(pstate, &clk->states, head) {
-			if (i++ == args->v0.state)
+		list_for_each_entry(iter, &clk->states, head) {
+			if (i++ == args->v0.state) {
+				pstate = iter;
 				break;
+			}
 		}
 
+		BUG_ON(!pstate);
 		lo = pstate->base.domain[domain->name];
 		hi = lo;
 		list_for_each_entry(cstate, &pstate->list, head) {

-- 
2.34.1

