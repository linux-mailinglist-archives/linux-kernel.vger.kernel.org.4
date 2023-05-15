Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6F5702FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbjEOOaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjEOOau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:30:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF511D;
        Mon, 15 May 2023 07:30:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaea43def7so88151175ad.2;
        Mon, 15 May 2023 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684161048; x=1686753048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKiFi7cchV1/CNWFldN1e7tKyJWR1+z9tt8oV8Nq+So=;
        b=U7v8btQ5/QYmSL94U2iZQqrHenblyfkJ8OvgC5n+sjZ3Yta/A/713ZWWd8pOxSGWgm
         hkW4A6Mqqszo8a7liLUH4loXS6zDTc5SGqD08T8ai5OvB6dpEpWOI+15JII8cSgX2gin
         Q7HBknzSE2y1ohrsHJaj5tvtoCPDpx4nCyqIVVYyKJAPzJBGKcWR7Bezgz1+IBk35Uny
         OR6bCaqsF7szeXVgcJNCZQYU0Oeu977lzX6PidABEwVAPaKNvSvR5yMVrxQQLf9S2tE3
         DzBLIxUaRY/UoBZ/KLEELQQCumpVBy//COL1zL1x/rJ83RYi/aA+6ELUZ10zhChOCogd
         dsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161048; x=1686753048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKiFi7cchV1/CNWFldN1e7tKyJWR1+z9tt8oV8Nq+So=;
        b=LSd0mO/+PyxoLgNqHjke1pbSwfxbCcMpdXPFsgvajgs2zRHZ1YHa4De1iQuzbPryPD
         4fBZz+WRUd9Rb2kP1TQeMFgz5ngEQaJ8dB89YELFpNQFQ/RQFMEAOyVPC3TKi+WCkzgN
         QN6CGC27xnIOMR9WGVxR0HPNjct8PXqXDTphQ6xb16ZCrk9mManckNto6XsdH+jiM9jF
         QDok07q4PhXCIDNe2sQDd2vyNi35Y8AVnHfnwJviZ+OQ9Phs2ub7si4pPcOvDcIvZvTj
         M2UvR2q/YARjO4qPYQvzdSla8kkCE/E4ktyZ+ZNxzSLLRwGu8rKOffE6mwj+0OY9xRDN
         ZXpg==
X-Gm-Message-State: AC+VfDyMX1NNECcz0lR7BxlrYTnTFZ+MKLoLcT9WETXoJMUb2wMK75HP
        3N/GRNVOQLu9/4i+8fWN8aE=
X-Google-Smtp-Source: ACHHUZ4Zknr855Fx+2gL1S41HQi7R9Q/SvWwDE1oi+z6Z/cwmI2uo6gUDx0idW2j3FpMiK58ZLMCjQ==
X-Received: by 2002:a17:902:7481:b0:1a9:7e26:d72 with SMTP id h1-20020a170902748100b001a97e260d72mr33925292pll.9.1684161048587;
        Mon, 15 May 2023 07:30:48 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902704400b001aaf370b1c7sm13552475plt.278.2023.05.15.07.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:30:48 -0700 (PDT)
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
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/9] drm/docs: Fix usage stats typos
Date:   Mon, 15 May 2023 07:30:08 -0700
Message-Id: <20230515143023.801167-2-robdclark@gmail.com>
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
2.40.1

