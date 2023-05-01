Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1DD6F361E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjEASpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjEASpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:45:11 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8ECD;
        Mon,  1 May 2023 11:45:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24ddf274039so1469453a91.1;
        Mon, 01 May 2023 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682966709; x=1685558709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlQgRgGnpnzTcnGyVtUcqaEHfPcu6dc+i5pcShGQrxo=;
        b=kRsbc8tlfk/H/cv097InCtoRduh0Q2peT/+ICEGVsdCySxLpPGs6lZFcQW1isxOIYv
         DpToN+aOtwZamMBWgLnntS32ZADvrFqAyvGYF81UPuDErrqXkAno9sehM9HAx5baUPUf
         AOT+20t3+OTA5Ac/yr1GPsSGcAY0J0l++i6HzhDW5ddBC8m5v07Lz0GY/p1WDHBuf37Q
         +BvoNNvuotTtkrvhp2v3sFlXUjuvmHW76vC7FYpyNoETJzENXbXPVSQJDOyX6py19UdS
         RkeJ0wQ3O139P4qNytKjJJ0zFi1AKI2RO5bdE6ukPAaPgZEBOFJ/VTvmTeGd/WygQPwG
         k1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966709; x=1685558709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlQgRgGnpnzTcnGyVtUcqaEHfPcu6dc+i5pcShGQrxo=;
        b=gROfrvEcBdRvUDX8E5EhVGQKoBsX0J/KTRp/ceQSGscoNMe6iBOH+Gzm35bZQC8lGp
         dD7T8mcvIdBVWBj2QOeLas6SCusiSboM52EAkw241FKrHp+PSwYz1PjE+tsWRzM7MMjG
         lleeVSchNT+t1qrNOQy9Qf3ddZihinncNZs78p+8yDl3S/j8ApsiZLwQ0IUsLm4LviP4
         jbpsqw2lDJBrghcVRex9uSn2aQj9Pd5X8u4KGi/UdTnUz3ojfP5jjzFP5dlgHZIwPEeS
         CFzjuNCM30jpcgk/dVRLfnKzg93dlCucjsjAYGO7Dih0K1CPRgx8lFQ0MiCa+8WuY7I4
         dWGQ==
X-Gm-Message-State: AC+VfDx7Eer27mXdQ4by2m2jYDhQ86AZU9jwrAHBoV+CyHkU/2YGK5U8
        O7qaRoBa9fzpofXogAFSddA=
X-Google-Smtp-Source: ACHHUZ4b+PxnvHuPTzQ0/tFd2w6+1Uyn0n4UKDVf+1oB8hgnSSkutccemZUA4kOfxhR3khAf5A59ew==
X-Received: by 2002:a17:90b:954:b0:24d:fb2c:1ae0 with SMTP id dw20-20020a17090b095400b0024dfb2c1ae0mr4322102pjb.17.1682966709532;
        Mon, 01 May 2023 11:45:09 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id hg4-20020a17090b300400b0024decfb1ec2sm3032473pjb.30.2023.05.01.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:45:09 -0700 (PDT)
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
Subject: [PATCH v3 1/9] drm/docs: Fix usage stats typos
Date:   Mon,  1 May 2023 11:44:47 -0700
Message-Id: <20230501184502.1620335-2-robdclark@gmail.com>
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
@@ -98,33 +98,33 @@ is not allowed.
 Each possible memory type which can be used to store buffer objects by the
 GPU in question shall be given a stable and unique name to be returned as the
 string here.
 
 Value shall reflect the amount of storage currently consumed by the buffer
 object belong to this client, in the respective memory region.
 
 Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
 indicating kibi- or mebi-bytes.
 
-- drm-cycles-<str> <uint>
+- drm-cycles-<str>: <uint>
 
 Engine identifier string must be the same as the one specified in the
 drm-engine-<str> tag and shall contain the number of busy cycles for the given
 engine.
 
 Values are not required to be constantly monotonic if it makes the driver
 implementation easier, but are required to catch up with the previously reported
 larger value within a reasonable period. Upon observing a value lower than what
 was previously read, userspace is expected to stay with that larger previous
 value until a monotonic update is seen.
 
-- drm-maxfreq-<str> <uint> [Hz|MHz|KHz]
+- drm-maxfreq-<str>: <uint> [Hz|MHz|KHz]
 
 Engine identifier string must be the same as the one specified in the
 drm-engine-<str> tag and shall contain the maximum frequency for the given
 engine.  Taken together with drm-cycles-<str>, this can be used to calculate
 percentage utilization of the engine, whereas drm-engine-<str> only reflects
 time active without considering what frequency the engine is operating as a
 percentage of it's maximum frequency.
 
 Driver specific implementations
 ===============================
-- 
2.39.2

