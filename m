Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B9649285
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 06:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLKFb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 00:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 00:31:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F9FCC2;
        Sat, 10 Dec 2022 21:31:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so11334348pjb.0;
        Sat, 10 Dec 2022 21:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6vTvGihZUD6ZwLwPgKHPa+GfczIEiPsQ9GWLGBlels=;
        b=mYwjZvO8vfqs/z8B/xTKn8erWEJ1qWiRy8OC3llvni0LA7meFiM74AMfPCOawFKgU9
         XLXISPwZP67SdYUHMSVH0CshgvCkJFTmo+p/+CgoMH4SFVePfQsXbyGwlHc/b9ZIV1Z9
         eIza4KAel+svqQoeeKjau9ttNzPZJ3s6Gu7kGEO2V74zGeHm89bjTTOJk0Hbwu2/Owi4
         bmk94YOub3PhMF4SEq7nBN5VOilQUOWWe+KYrYjgWrLQNsvoWLZ3XZ5vLQRZcoIDHhDD
         CNN9/kaFdE2sMpP3tz8AUU7/qWr5pXge9DqJJXkcTlYSm7yXwLDxweSCTORnDWLvSCKb
         LN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6vTvGihZUD6ZwLwPgKHPa+GfczIEiPsQ9GWLGBlels=;
        b=ShdMNwjoBEmMQxzZNYxmcizhsseky0bzEsmva2/tA5WKuzqrVfE7SbU0cQ+OiUwuSO
         1msDU0rV4h8SFUsBd92FnHC3KeYVPNdvB6qSKh39RLC8ClGiT6d4qkWgXnR408Ss3Yqf
         q1m1BbyKufod3duniJhj7U/L7FgAI22HeEmNHUPbc4lzpuGQohQZ3440JaqX1qe43DCJ
         /iybGSTdr074uSxvwoNoO01DguE4yV8P7BGpvzKw3WoK1tR/OTXRocqSFYDXpx9G3pmK
         Pnq4LrmuljdqzCw/WIuUW095MA8zZdFhRLiOpf+kGQVVVDDL/aEUbAzYnq1ok1N1fMqa
         zDoQ==
X-Gm-Message-State: ANoB5pnpv9dWf5K9fhvmoC0RkX4eVDxiH9NQzA6Fu0M0FOBikbGfdluT
        hvzCV+hGntF/rY9GARVS3cY5k3wVKs4=
X-Google-Smtp-Source: AA0mqf6oalOJMzb3tShfki8wjIKr/gLy4mMu1RvV9fXaLpaV2P7WB5n3RlqGwu2l/dnx9gVZ5L5zHg==
X-Received: by 2002:a17:90a:e2d1:b0:219:4bdb:92f4 with SMTP id fr17-20020a17090ae2d100b002194bdb92f4mr11539081pjb.15.1670736680978;
        Sat, 10 Dec 2022 21:31:20 -0800 (PST)
Received: from debian.me (subs28-116-206-12-36.three.co.id. [116.206.12.36])
        by smtp.gmail.com with ESMTPSA id k30-20020a17090a4ca100b0020a11217682sm3189190pjh.27.2022.12.10.21.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 21:31:20 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 64D7D10452A; Sun, 11 Dec 2022 12:31:15 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] Documentation: gpu: vc4: add blank line separator before KUnit code block
Date:   Sun, 11 Dec 2022 12:30:52 +0700
Message-Id: <20221211053051.18125-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <202212102116.A10vg3jG-lkp@intel.com>
References: <202212102116.A10vg3jG-lkp@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=bagasdotme@gmail.com; h=from:subject; bh=pvBilcpCv4aXZhOeJEGAFfrgfoZtHWn/dmtVyYkJ0t8=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMlTs1n8lXepN9h6b9l4h21q9Y1Zjx9Yb6mZ8pLhU/gMVr8t XRccOkpZGMQ4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCR63aMDJdW+rqEfL7Vv+bRRIOqw8 J8d44t3XbgZdbnAh1+zZQbD54wMkz7LXOxL3ezz0rPg//yz13n/vipkelb+X+553GWquXqLWwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reports htmldocs warning:

Documentation/gpu/vc4.rst:65: WARNING: Unexpected indentation.

The warning is due to missing blank line separator between KUnit mock
driver sentence and its code block.

Add the separator to fix the warning.

Link: https://lore.kernel.org/linux-doc/202212102116.A10vg3jG-lkp@intel.com/
Fixes: 5304c8e6010012 ("Documentation: gpu: vc4: Add KUnit Tests Section")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/gpu/vc4.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/gpu/vc4.rst b/Documentation/gpu/vc4.rst
index a2375f1584e6d9..ec920c4f5bb322 100644
--- a/Documentation/gpu/vc4.rst
+++ b/Documentation/gpu/vc4.rst
@@ -62,6 +62,7 @@ integration tests.
 
 These tests are using a mock driver and can be ran using the
 command::
+
 	./tools/testing/kunit/kunit.py run \
 		--kunitconfig=drivers/gpu/drm/vc4/tests/.kunitconfig \
 		--cross_compile aarch64-linux-gnu- --arch arm64

base-commit: 612e241fb4bcd98d8ff9da7a795abb86b8ccfe38
-- 
An old man doll... just what I always wanted! - Clara

