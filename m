Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C36F0B85
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244470AbjD0RyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244319AbjD0Rx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:53:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324AABE;
        Thu, 27 Apr 2023 10:53:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso6861875b3a.2;
        Thu, 27 Apr 2023 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682618034; x=1685210034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGjGxmlouVGhi3M6MRZkXvcAVwGS3ye2TGK3XrM7dRI=;
        b=DskqNrsRREOOo5+tJopmLlCj6+GWPbnQOa2+AYvaPYS7fcpG66CcxTCQrmwYXBL3WQ
         +BkdoMC1ullgLuxY+Ds8+4wtsgzFGje4bjzDVek19jcDHjSS1Iwi3kiHP/PPZLRehB5a
         Zp9LmrhckNG6ETFh/+OolV51Jh7+GIC9C2SO6R5FS8jYo9CNKgW9yAbalvrpaQyX2EPq
         eWT+EyJF3gEjxMScpTDYWjmkLghh0ytfAuhZhmGQIQODAZandBUchj8+1gQFeECBQGq8
         REtNK/WAXbsVAO/yv/vqGiymb8vtB7zd/Ta6RHuHWOSSGCwY+wkETaKIIS/jwqU+/MpU
         8Qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682618034; x=1685210034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGjGxmlouVGhi3M6MRZkXvcAVwGS3ye2TGK3XrM7dRI=;
        b=h9ctLnr5RJneK4oujbfcCVOLGU7kN4A8IZ6a0nV02exHsLVe+6g1Dfvw14PO6Lyrl3
         /Ne120KCmTv8P/gBfl32IHEGvSijbb/bx/5BHemAxoHL75pPEmkm5EtU56gUVtzu1WuD
         OfzWoH5bHNVf0xASCSPCSCxpARqAyEEdzIYNWlgbMNlrTwTH3ucWRSF51Q8tablo+StP
         xic2YHWTmtvIOdCDPG4T+66DMovAJaEOE5/gum/dKe17Qsav05KdChCWF3XowmAvHUfr
         kITqhirCVrGYBFGfljgml526LYIUaP6OnT9j8AODoY0ZRqfwNCDxznWF5FF/Y0Zw23r/
         CIwg==
X-Gm-Message-State: AC+VfDwUW3f8tBsLOr6pXZUjqEXZfNQwM/V3THFjz7BB9IQcYDSqtt/Y
        FDN8jKtbS2vu7me7WI0LEBA=
X-Google-Smtp-Source: ACHHUZ6B+aak2ZkUYsB+1ZMUHj9b32Ns03yuVkuacD2JU5/1vQBVbzhVWx7Q599OyF6uLhjfXVdnNQ==
X-Received: by 2002:a05:6a20:7f97:b0:f3:67da:9db5 with SMTP id d23-20020a056a207f9700b000f367da9db5mr3076695pzj.38.1682618034603;
        Thu, 27 Apr 2023 10:53:54 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e27-20020a630f1b000000b00502e7115cbdsm3662034pgl.51.2023.04.27.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:53:54 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/9] drm/docs: Fix usage stats typos
Date:   Thu, 27 Apr 2023 10:53:25 -0700
Message-Id: <20230427175340.1280952-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230427175340.1280952-1-robdclark@gmail.com>
References: <20230427175340.1280952-1-robdclark@gmail.com>
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
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
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

