Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8428D70FB37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEXQBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbjEXQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:00:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BB10C8;
        Wed, 24 May 2023 09:00:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so880298b3a.0;
        Wed, 24 May 2023 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684944011; x=1687536011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSswnMLwwEGQnN2xlrnUru6iM+0TXo2/wbtbw8wTOo0=;
        b=B+Bsw1NUnpKejAiuRxs86EcWG/xC9B2nB98H9nqq+mvMU2qeXTEIzfpT40bDW4kzZI
         u3GG4tS+dL+RvZBM46eFDEu6To+siU2UEFVnq9Bujpx92iJe+n+uA/IY45jlFjMtjE6H
         UJsf9+3XGmpuM4rFzC8REjnC2Umj4okDLEFBYelLZObja7FuoIUCEpkvIz2DAppfXZa3
         68gdUsJhcWKUZ30KLvw5you3T0dIt93E+bVv2hac/q3ga0plJP1eEcYYuBHzwl5Ag3/q
         kSZZCx3wv+YvGhO+3p/S8wzKUK9RlU8Io1cwT+nP3Ss7IGdLZjNCXIQi5Tb+hoOk5u9P
         7mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944011; x=1687536011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSswnMLwwEGQnN2xlrnUru6iM+0TXo2/wbtbw8wTOo0=;
        b=LcxNfvS02mYDDK1Lo7dg5+z4BbCz0jk50xpMHja8Xjyia9eexofgyfAuab3A9WrmUp
         iCxM7/WyXi5yFAdnFgNBvIxt49i9axS9hHs5GIeFnzQjG1/nGaw2bbkVozSTZfsZeo4C
         4llFAeaqE6W+tkT+cGYGGdvC56CDWbi3Ocf56hWejXiHcX5RY60Sxe9SYGd8zDcZWeun
         SogMjz/Q/4BmvGJluZZau0xpVHyelC92hqErgmus3t0NwRdq02nl2L5OCYNNyjvoOx+L
         BYeseqs054aEvyThHcLtroIJQHw9GrTWnA3w9Y8HrzaYo5+oj0aNq5Ao3TPhjO03ABNK
         qHAg==
X-Gm-Message-State: AC+VfDxZ1+8hfUfEl1+vW6I+m6olUC4qT/UG1s/Uj0/VRbN7dfNM+l0o
        SjZiQ25+KNiHbfInD4d/eP8=
X-Google-Smtp-Source: ACHHUZ4B7uPtJ7sN4k/tvRDpTXNjWvoZAnRI7XqCVYOuMgRJiNLAZbt9+ZqdTUOnaHPAUA2M6EXipQ==
X-Received: by 2002:a17:902:c402:b0:1ac:b259:87ea with SMTP id k2-20020a170902c40200b001acb25987eamr25487162plk.0.1684944011561;
        Wed, 24 May 2023 09:00:11 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001ab1d23c44bsm8979421plb.181.2023.05.24.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:00:11 -0700 (PDT)
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
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/7] drm/docs: Fix usage stats typos
Date:   Wed, 24 May 2023 08:59:31 -0700
Message-Id: <20230524155956.382440-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524155956.382440-1-robdclark@gmail.com>
References: <20230524155956.382440-1-robdclark@gmail.com>
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
Acked-by: Dave Airlie <airlied@redhat.com>
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
2.40.1

