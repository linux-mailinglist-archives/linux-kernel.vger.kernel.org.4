Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A162A5B7C63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIMU4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIMU4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:56:14 -0400
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5582074342
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:56:03 -0700 (PDT)
Received: by mail-vk1-xa49.google.com with SMTP id t204-20020a1f2dd5000000b0039e8fb8258cso2879054vkt.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=pCfRO3751PIceEFZobkVS7s+2QyKwW6/+h1LD3cCIeQ=;
        b=ZeVfR8Tnh5hBzCUV1+CS8+Iy1lLHRA/k5WbydQvejPxhARt8JYQuZEKNPKlx0P6GVg
         yS3MHFnOdeg2h6R2IoY/R5kf5QFzevs7rUHzS+y/eTO2MFlEPFSZAPH0d6AiPWeEEbkG
         P8yv/iZAbdsPOPomC15hdY9X8Cdkt9oBG8dVJYoUQd/wQYrVjWRYCDu9hUlrAbSWb8sI
         4MkZuUL4ANwsnuUqTzJVq6CA5qkgBDyKNfPRJHNlV+OJp8RbhrrgpNXkwdr3YRqhsqz9
         Npjq1zQ67uMxgk6qwpGWxv5ASBroZ28r1RSSts4jAHaN32pCKG+osEKJzn2sy9Tir86b
         pzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=pCfRO3751PIceEFZobkVS7s+2QyKwW6/+h1LD3cCIeQ=;
        b=gcxYvZpONrMG+mE5w5ta8QrVUZXRZuKMzbCo+jW1TDT5qdKQgrs0num4Ag4vk0HfqO
         hBuRGkFeQB/CJErLt34FZ/8ePc1VvSAeGy4vnje8vUCLXInUSP33CvokHBUhd9F60HW+
         RVQT/wwTNXAXIoadocHJXocY3GmXJXsLjGYIPKvIuQy1+X9vrkTC/nlUl05pKUlDXCEN
         HZPYdPFdmUMsKteJtPaMaRov1eQJKfUYV0WTTGd3PcIf6FPgB1TpH07OyVgaSs1FVSZz
         gLgGCEgjeaAAjWoyf0AQV/cfErLnHPteXUGFUtofRBVj87HTFoSF95EU6ZY7dpQWK+E/
         YWeQ==
X-Gm-Message-State: ACgBeo38yWTQdFDIRBJAMLYH47z322GvhURSk0v2s1SYkFVSoXcea2Ql
        cXG9EfTx3+LG/7JhqDsuswS5OEhZTQ==
X-Google-Smtp-Source: AA6agR56+CRX4Jw5oLwN56hGQ9u1QOvQ42gdvdnD0+27lrgrALWWvOvWch3l4gfgBdyZy9SYZgradcpnhQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a1f:2ed8:0:b0:3a2:a7f:3e9e with SMTP id
 u207-20020a1f2ed8000000b003a20a7f3e9emr6201265vku.7.1663102563103; Tue, 13
 Sep 2022 13:56:03 -0700 (PDT)
Date:   Tue, 13 Sep 2022 13:56:00 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913205600.155172-1-nhuck@google.com>
Subject: [PATCH] drm: xlnx: Fix return type of zynqmp_dp_connector_mode_valid
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_valid field in drm_connector_helper_funcs is expected to be of
type
enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
                                     struct drm_display_mode *mode);

The mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

The return type of zynqmp_dp_connector_mode_valid should be changed from
int to enum drm_mode_status.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index d14612b34796..f571b08d23d3 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1352,8 +1352,9 @@ zynqmp_dp_connector_best_encoder(struct drm_connector *connector)
 	return &dp->encoder;
 }
 
-static int zynqmp_dp_connector_mode_valid(struct drm_connector *connector,
-					  struct drm_display_mode *mode)
+static enum drm_mode_status
+zynqmp_dp_connector_mode_valid(struct drm_connector *connector,
+			       struct drm_display_mode *mode)
 {
 	struct zynqmp_dp *dp = connector_to_dp(connector);
 	u8 max_lanes = dp->link_config.max_lanes;
-- 
2.37.2.789.g6183377224-goog

