Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09D6E516F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDQUMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDQUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:12:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C930199A;
        Mon, 17 Apr 2023 13:12:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g6so10146952pjx.4;
        Mon, 17 Apr 2023 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681762341; x=1684354341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej3z4D3WVobAccpvmhuv3Nh2/6punBMVoSfBEUJKgo4=;
        b=bv/4/9J1xBpCyQrQ3rE0vcbUgiVloe5KwAdb9fX8xj9b2UVnnmHuReFmst53NVHhkY
         GPiVAcbTUPSmiXEOrbfgooMSoJscCMpE4h2McxWLJ5HiiSOL/4W9lQ4QdiQ0Vh9+soB6
         6yDIKnSHBVf0Uc6QoKP8ODL4TGVnZoAe9ntP+hoVzeWEmRNe6LHQu6VkssWuC4B74Ucz
         nqN2K0BBqzEJ2h+rJfOyfhIo6H1DEM1crQRahjwDlkviymD91RAv+PK+m0XKLFEpCMtd
         +yk7FKcSuKWvYclnuZ96Ljwjz4Ya3kdSndDGQwLQYtK9Cr6FiGUgaXqoTf+wMsq0UGwH
         mw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681762341; x=1684354341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej3z4D3WVobAccpvmhuv3Nh2/6punBMVoSfBEUJKgo4=;
        b=d4XaHkg6BvdaXSytmzTN5YgvUA4yuog1tkZ6u7FBkGf9OtkPp3LxCTuHYGjNiF79VN
         npd73GvDKCseyZDVr3Fz3y054yGb9WaHltAY/ljijU/KrSD9IrYB0upCEQK01oxaYrXZ
         +AjIA1cFCWbglCQDfZ88/2MEEDw9iMl7Zf9TnBxBtEomfiYT5MIHVgnLTp0PwRXgzKtK
         MDWIErEWBqRNkAu8kmKrasrAE1baTJ33oDwzdLQcu8qlRd3/j7wvRGbGxB9hZCW9iZEf
         JhijQRjsoO/JTt5Eq4tMP5ylffzeyQsGIknDQIRQA54XZl0nTEcB0uWfpF9Gwqjmrntp
         +I3Q==
X-Gm-Message-State: AAQBX9fuIFO4Ii7DqVQWLU5SZOSiaHFE46Rj6PMQSZEjLSlGPNIu/THx
        EF95phUmJpr/5fw9XZTXDAQ=
X-Google-Smtp-Source: AKy350YrO9PkzbeVJN0Q7mkqoCr0Z37rCfFTBog9tkB0ua8p9S/C4LH91r5Vlo7znkRcSR1UUlLUbw==
X-Received: by 2002:a05:6a20:7347:b0:ee:818a:3497 with SMTP id v7-20020a056a20734700b000ee818a3497mr14519687pzc.35.1681762340637;
        Mon, 17 Apr 2023 13:12:20 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id r5-20020a635145000000b005186e562db0sm7337820pgl.82.2023.04.17.13.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:12:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC 1/3] drm/doc: Relax fdinfo string constraints
Date:   Mon, 17 Apr 2023 13:12:10 -0700
Message-Id: <20230417201215.448099-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417201215.448099-1-robdclark@gmail.com>
References: <20230417201215.448099-1-robdclark@gmail.com>
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

The restriction about no whitespace, etc, really only applies to the
usage of strings in keys.  Values can contain anything (other than
newline).

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/gpu/drm-usage-stats.rst | 29 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 258bdcc8fb86..8e00d53231e0 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -24,7 +24,7 @@ File format specification
 - All keys shall be prefixed with `drm-`.
 - Whitespace between the delimiter and first non-whitespace character shall be
   ignored when parsing.
-- Neither keys or values are allowed to contain whitespace characters.
+- Keys are not allowed to contain whitespace characters.
 - Numerical key value pairs can end with optional unit string.
 - Data type of the value is fixed as defined in the specification.
 
@@ -39,12 +39,13 @@ Data types
 ----------
 
 - <uint> - Unsigned integer without defining the maximum value.
-- <str> - String excluding any above defined reserved characters or whitespace.
+- <keystr> - String excluding any above defined reserved characters or whitespace.
+- <valstr> - String.
 
 Mandatory fully standardised keys
 ---------------------------------
 
-- drm-driver: <str>
+- drm-driver: <valstr>
 
 String shall contain the name this driver registered as via the respective
 `struct drm_driver` data structure.
@@ -69,10 +70,10 @@ scope of each device, in which case `drm-pdev` shall be present as well.
 Userspace should make sure to not double account any usage statistics by using
 the above described criteria in order to associate data to individual clients.
 
-- drm-engine-<str>: <uint> ns
+- drm-engine-<keystr>: <uint> ns
 
 GPUs usually contain multiple execution engines. Each shall be given a stable
-and unique name (str), with possible values documented in the driver specific
+and unique name (keystr), with possible values documented in the driver specific
 documentation.
 
 Value shall be in specified time units which the respective GPU engine spent
@@ -84,16 +85,16 @@ larger value within a reasonable period. Upon observing a value lower than what
 was previously read, userspace is expected to stay with that larger previous
 value until a monotonic update is seen.
 
-- drm-engine-capacity-<str>: <uint>
+- drm-engine-capacity-<keystr>: <uint>
 
 Engine identifier string must be the same as the one specified in the
-drm-engine-<str> tag and shall contain a greater than zero number in case the
+drm-engine-<keystr> tag and shall contain a greater than zero number in case the
 exported engine corresponds to a group of identical hardware engines.
 
 In the absence of this tag parser shall assume capacity of one. Zero capacity
 is not allowed.
 
-- drm-memory-<str>: <uint> [KiB|MiB]
+- drm-memory-<keystr>: <uint> [KiB|MiB]
 
 Each possible memory type which can be used to store buffer objects by the
 GPU in question shall be given a stable and unique name to be returned as the
@@ -126,10 +127,10 @@ The total size of buffers that are purgeable.
 
 The total size of buffers that are active on one or more rings.
 
-- drm-cycles-<str>: <uint>
+- drm-cycles-<keystr>: <uint>
 
 Engine identifier string must be the same as the one specified in the
-drm-engine-<str> tag and shall contain the number of busy cycles for the given
+drm-engine-<keystr> tag and shall contain the number of busy cycles for the given
 engine.
 
 Values are not required to be constantly monotonic if it makes the driver
@@ -138,12 +139,12 @@ larger value within a reasonable period. Upon observing a value lower than what
 was previously read, userspace is expected to stay with that larger previous
 value until a monotonic update is seen.
 
-- drm-maxfreq-<str>: <uint> [Hz|MHz|KHz]
+- drm-maxfreq-<keystr>: <uint> [Hz|MHz|KHz]
 
 Engine identifier string must be the same as the one specified in the
-drm-engine-<str> tag and shall contain the maximum frequency for the given
-engine.  Taken together with drm-cycles-<str>, this can be used to calculate
-percentage utilization of the engine, whereas drm-engine-<str> only reflects
+drm-engine-<keystr> tag and shall contain the maximum frequency for the given
+engine.  Taken together with drm-cycles-<keystr>, this can be used to calculate
+percentage utilization of the engine, whereas drm-engine-<keystr> only reflects
 time active without considering what frequency the engine is operating as a
 percentage of it's maximum frequency.
 
-- 
2.39.2

