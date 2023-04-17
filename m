Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FFE6E5160
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDQUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDQUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:07:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2817649CA;
        Mon, 17 Apr 2023 13:07:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-514156b4976so1857234a12.3;
        Mon, 17 Apr 2023 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681762020; x=1684354020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+deRgXi/6Ad9g6ku11D8GgcUGW5WpzR4IIRqP5WMoRs=;
        b=JcGnCFJj/BBEdA0hbgG5EsNgb3iej6j4oPqs23GAUMRs4lmm9w4RDYVLZDPt0EJTt4
         wlqQ/e7oA+qo3v3dViaATjMd95+LJOHFx/tebhZB+Fg8U5cou6MG5+7rTkGe0Lz8bvyw
         2HvEWJuvnneTw2ZR0tXEtbPhfpknC/P5KXhspzRLswM1DU+2VYL83WoAncV2PFDEKj4U
         wTzbSV9CrAWbER4qg4Fd0hA83F89rHDGKMlWZkXezznlbH8UV53X55KA7ytCvKUZmXq7
         XEp+4LBUlivOCquwGpShgvBeLCbgUkwe4eZr/8dTnwg1lch+E+oJb46WFrDja53dtpsE
         Kywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681762020; x=1684354020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+deRgXi/6Ad9g6ku11D8GgcUGW5WpzR4IIRqP5WMoRs=;
        b=OQniKLiQ143yILsHN0Y94L9JoKcFC4BWznvFEbEjmEuqDq3crmy5u6vKSRgJbuzVRw
         dSjgpfKiWPQ9ZnPmd+enZs5TAz7DlKQio2eE9mD/V9iEjOh6LXdHll/mPaB66aJRtRyc
         17NYCs4V2WLkYUUkm2IjFRYUPwyXtQtQTwBMWT7o2xKtf2yWov7zMZ4dyp+IWkC849Uf
         I21w0AsiF46Sp87wzeks8rr2bKwhxFE5d1amJK4VK0wS++27Kcf/Z1n6wqXzhC4w4Ec4
         05+s0yRyTHQmXDFzig+i7mi5uV7OroEovJAGSMCYI54me8H6SseFHaAvTcpIjxfLA+mA
         RYQw==
X-Gm-Message-State: AAQBX9ciz9pyC4lmMdZq8VWTH5lAdpGxQ/BwwN+4578JaEBhiIbwgaYR
        ggCTqimSLGQNhIIa5MQXJdI=
X-Google-Smtp-Source: AKy350Y7ODBS8FdmIbWFAn8sdaIVRvcEuA/AmjNn1Ewxalqs6GptNrO4Daqa5keisv4BFAbDxr0Dyg==
X-Received: by 2002:a05:6a00:1516:b0:63d:287f:fdf5 with SMTP id q22-20020a056a00151600b0063d287ffdf5mr4607205pfu.27.1681762020532;
        Mon, 17 Apr 2023 13:07:00 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e16-20020a62ee10000000b0063b5776b073sm7338454pfi.117.2023.04.17.13.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:07:00 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/docs: Fix usage stats typos
Date:   Mon, 17 Apr 2023 13:06:56 -0700
Message-Id: <20230417200657.447606-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Fix a couple missing ':'s.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/gpu/drm-usage-stats.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index b46327356e80..72d069e5dacb 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -105,7 +105,7 @@ object belong to this client, in the respective memory region.
 Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
 indicating kibi- or mebi-bytes.
 
-- drm-cycles-<str> <uint>
+- drm-cycles-<str>: <uint>
 
 Engine identifier string must be the same as the one specified in the
 drm-engine-<str> tag and shall contain the number of busy cycles for the given
@@ -117,7 +117,7 @@ larger value within a reasonable period. Upon observing a value lower than what
 was previously read, userspace is expected to stay with that larger previous
 value until a monotonic update is seen.
 
-- drm-maxfreq-<str> <uint> [Hz|MHz|KHz]
+- drm-maxfreq-<str>: <uint> [Hz|MHz|KHz]
 
 Engine identifier string must be the same as the one specified in the
 drm-engine-<str> tag and shall contain the maximum frequency for the given
-- 
2.39.2

