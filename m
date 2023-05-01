Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32416F3621
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjEASpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjEASpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:45:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04072710;
        Mon,  1 May 2023 11:45:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b5465fb99so2209776b3a.1;
        Mon, 01 May 2023 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682966723; x=1685558723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPMqzx0tM4YAjR4KEyZrtVllL0FOx+3j3GjXG2bjHSo=;
        b=m0yeF5XDnoSNCwWz8zb/15XvdP85Wq9Wty2g5oK1tWp5bpWl6MJt8GhEaD0cX25F2Q
         3Gv7A//1uVPQKKu7iWp7bPWX61K+M8YbK5pvQ0pg6Ob3cSw7XYdxYhlIVfJDHRmLqdt0
         /J5UV81E9BNJUaJd3HxTFbZTBn4GxMw3zLsWaEqt3uq9dPR4awpWlaH1Q1lSFa539lWT
         msGRv/uFpr9s1XT8zRwVdIAlMSQsbHtogIwLIEdQnhF8j26m2KvK9vKRiA/lUrVWujQt
         L4S0z5C3av2GWfYb2zS8bmVHtoPDPY8vsluNOZltL4W1BQxZxjaUlq545p/UzpUjSOgb
         PcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966723; x=1685558723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPMqzx0tM4YAjR4KEyZrtVllL0FOx+3j3GjXG2bjHSo=;
        b=HGs6D+f8NG6BbXLd1p/ynZKofk9tmXsn1SCDYttU/Gd7ukOvUoNPCApx4uJTP/Jpab
         L+XHTPiEAFKsxDXAh6BTCVX/QkWmUR1BdxFHdg0KbUljHjpbDG4SzWTcnGDhORCKPkAR
         nxE0bQ3Pi30wi5OQPPQMmYPU5YGxa6mvrjQLuwLQPSo4+AL4Tr6Ln283z5TUGaAzr9Sa
         FLR1xplaiDCaemWAeMNmwpdWnnKuP+6Z9HKE21OOltaGJNWvYX0n+7Ac+Mp0arGatKG4
         jhZDixpjBspNlspPtQPp4iyqOXtqacVPa8FMKBSFxsS34OpYjRWEca/Yx+O/7zmHZ+Je
         yM7A==
X-Gm-Message-State: AC+VfDx+z8PnlEuML8AV8/XDb1MDv11ZTK/+UWgW+jg+DbV0/rBf5UEK
        BvWdDa9Iry1Dec7p+e+q6fs=
X-Google-Smtp-Source: ACHHUZ5kWDPbyXZ8IAVsgL324BEDoAigBDLexRlapPgQoDaPBV8uSYJRoanU3EsEU9ZHORHXg+btAA==
X-Received: by 2002:a05:6a00:2d24:b0:63b:2102:a1d4 with SMTP id fa36-20020a056a002d2400b0063b2102a1d4mr22975654pfb.13.1682966723259;
        Mon, 01 May 2023 11:45:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id y72-20020a62644b000000b006372791d708sm20201846pfb.104.2023.05.01.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:45:22 -0700 (PDT)
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
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 7/9] drm/doc: Relax fdinfo string constraints
Date:   Mon,  1 May 2023 11:44:53 -0700
Message-Id: <20230501184502.1620335-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501184502.1620335-1-robdclark@gmail.com>
References: <20230501184502.1620335-1-robdclark@gmail.com>
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
2.39.2

