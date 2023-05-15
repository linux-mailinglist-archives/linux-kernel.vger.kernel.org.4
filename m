Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C7702FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbjEOObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbjEOObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:31:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07DF358A;
        Mon, 15 May 2023 07:31:03 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-52079a12451so9206807a12.3;
        Mon, 15 May 2023 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684161062; x=1686753062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVq/kpJ/70Wv68RjMJaNqydvleLpT2XbW0a2c5YuHeA=;
        b=bW2MaVBFgRr7231m/l4hHFIy4hGb46iF869j3WLa15qqsNJTd3j/N258uPhokNlg0Z
         rrmWgnxqqLtNEnWfgdkGTiUcTqo3Awy2ruCYzoEDs6A45fHEwgw/rrM9udtBi3Hn4ka4
         FT/fNwayPHyYJ9sjXpy11xlpQl65r2fXoxHH4xt9d3DLEIW/dpzcu6SEAOyzDN4qM3Qo
         xCkWzGocLjM0ZlVPxAzk5umC6Jhms1ajOXEXTwvKFWmBTkKXE8GzlFZCwskWcix0m6DQ
         B1myHlr1KIP9Sf4r07RPDdTfBNRWi6fv77waWOaTzDmIyfy/6EEaXA8I/02tSBHMORxK
         WSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161062; x=1686753062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVq/kpJ/70Wv68RjMJaNqydvleLpT2XbW0a2c5YuHeA=;
        b=WP4qC4O3y/4G8GCFyLW3xX2EvHFvTHx/t86z4/oCJG8l8EwR8rdd24vMYFcZszjc10
         6xh2UugK/39MHQFHHOwmh2KHgo/PvaNmJO+BrGJyRRXpe/gXK6y8u59Ls0DL2U4t5B4G
         S+77JWB9Z1QBXGypaOprYbyfcVGaT8uyQVqkCu64BV3xAmPCyNZ00EQ8qOlqRX+s70Vr
         9CVJF+imLkMFgGmkWo/CB4Dl6uFaSRcxkzDi/QX+jODCMdVVebpFE8VTWOkG7sph/XLL
         uN1E/O3IndHOtHurX8ISw8Qsv1KJar2yHDzBF/37aRw2gdT3VolFzaGOi6GWDxvy1W4g
         gF6g==
X-Gm-Message-State: AC+VfDyimcQgtIjNTa0m4oosMcpNxx5T12zKmwqzx20YThjOHgaRfLpO
        JZl+uMe5xdGniEKwai7IEcY=
X-Google-Smtp-Source: ACHHUZ71l41Y3wgpKhvpJKf0oM96ttVQjDila4pNl6cUuMG11fTboomzRXCM+U5ceRWquu8RZWWeuw==
X-Received: by 2002:a17:90a:8004:b0:24e:5245:6383 with SMTP id b4-20020a17090a800400b0024e52456383mr33282021pjn.23.1684161062193;
        Mon, 15 May 2023 07:31:02 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id g22-20020a17090adb1600b00250bf8495b3sm10747609pjv.39.2023.05.15.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:31:01 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 7/9] drm/doc: Relax fdinfo string constraints
Date:   Mon, 15 May 2023 07:30:14 -0700
Message-Id: <20230515143023.801167-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515143023.801167-1-robdclark@gmail.com>
References: <20230515143023.801167-1-robdclark@gmail.com>
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
Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 Documentation/gpu/drm-usage-stats.rst | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index d012eb56885e..fe35a291ff3e 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -17,41 +17,42 @@ wherever possible effort should still be made to standardise as much as
 possible.
 
 File format specification
 =========================
 
 - File shall contain one key value pair per one line of text.
 - Colon character (`:`) must be used to delimit keys and values.
 - All keys shall be prefixed with `drm-`.
 - Whitespace between the delimiter and first non-whitespace character shall be
   ignored when parsing.
-- Neither keys or values are allowed to contain whitespace characters.
+- Keys are not allowed to contain whitespace characters.
 - Numerical key value pairs can end with optional unit string.
 - Data type of the value is fixed as defined in the specification.
 
 Key types
 ---------
 
 1. Mandatory, fully standardised.
 2. Optional, fully standardised.
 3. Driver specific.
 
 Data types
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
 
 Optional fully standardised keys
 --------------------------------
 
 Identification
 ^^^^^^^^^^^^^^
 
@@ -68,62 +69,62 @@ to the in kernel representation of `struct drm_file` instances.
 
 Uniqueness of the value shall be either globally unique, or unique within the
 scope of each device, in which case `drm-pdev` shall be present as well.
 
 Userspace should make sure to not double account any usage statistics by using
 the above described criteria in order to associate data to individual clients.
 
 Utilization
 ^^^^^^^^^^^
 
-- drm-engine-<str>: <uint> ns
+- drm-engine-<keystr>: <uint> ns
 
 GPUs usually contain multiple execution engines. Each shall be given a stable
-and unique name (str), with possible values documented in the driver specific
+and unique name (keystr), with possible values documented in the driver specific
 documentation.
 
 Value shall be in specified time units which the respective GPU engine spent
 busy executing workloads belonging to this client.
 
 Values are not required to be constantly monotonic if it makes the driver
 implementation easier, but are required to catch up with the previously reported
 larger value within a reasonable period. Upon observing a value lower than what
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
 
-- drm-cycles-<str>: <uint>
+- drm-cycles-<keystr>: <uint>
 
 Engine identifier string must be the same as the one specified in the
-drm-engine-<str> tag and shall contain the number of busy cycles for the given
+drm-engine-<keystr> tag and shall contain the number of busy cycles for the given
 engine.
 
 Values are not required to be constantly monotonic if it makes the driver
 implementation easier, but are required to catch up with the previously reported
 larger value within a reasonable period. Upon observing a value lower than what
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
 
 Memory
 ^^^^^^
 
 - drm-memory-<region>: <uint> [KiB|MiB]
 
 Each possible memory type which can be used to store buffer objects by the
 GPU in question shall be given a stable and unique name to be returned as the
-- 
2.40.1

