Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01FA5BE59A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiITMWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiITMWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:22:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC973901
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:22:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so784172wmr.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4SwIaD3vwte9/wOVUhii8jjHUDs7etXJMigmdSdQFz4=;
        b=SLFoLkpR340kKkW0YrWlEfAhG5dD3fKjX3yfiQcJ1RBvRf3qDsOJQmWuFi8It2zGOO
         4xWD+xaLSG2zcyyiiRX1wHCG/QPvLR6pyaxkUQuhrKBIwqqWleODmA3zmBCy2s7jSOpd
         vvFkpw0tqn83ArzebL3ogqtG6JaH24hPhvgb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4SwIaD3vwte9/wOVUhii8jjHUDs7etXJMigmdSdQFz4=;
        b=reYktBKJA1N3KIpOQTEZEuQE9phJ2j8YCugDbG3RNCzdHK9KukeLJmwBcKopx5pJuU
         9ukwuvO8ZcxxBy2KJ7Bs5qzr8LtUxgka0LNYAi3bTCxSasW5itg0wbGkp9BJRr5KsBJR
         01mjI7Yr5IwVqEUSisXypJQQ92b6+xi8jB3WK1p/O9OkiUnygBGKVbDetQN+vki9NLpw
         Bxrn1kGPuWRLQFNwtQv60q4Nwizv98vfZO/XTz48TpiUtxsWCx9DTCAuUDUZh5xTPfiT
         s6TXppygY7lXTKTHJkW/EmgMu29hMI9L1X5gdhuhy8ncxiwcOFwISsG3A5GZcgldE4Tf
         ctew==
X-Gm-Message-State: ACrzQf0Kb6mzoEDA9NHYPQfw3Ia1YrT3gdtTv4fiNteTQTWVb3ImKzJ9
        fftOX/g3ByOP0rFBd+rmq69Arg==
X-Google-Smtp-Source: AMsMyM7KTVO8qT5Kn3gc4wVc7Gf+axGxMqi1Oeo15wjCpSJNRvW5WWXc7u2JmKl2DoEucPmryDsVKg==
X-Received: by 2002:a05:600c:1c19:b0:3b4:c1cb:d46d with SMTP id j25-20020a05600c1c1900b003b4c1cbd46dmr2203248wms.172.1663676541365;
        Tue, 20 Sep 2022 05:22:21 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-56-12.cust.vodafonedsl.it. [188.217.56.12])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003b4cba4ef71sm13124268wmq.41.2022.09.20.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 05:22:20 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        sudipm.mukherjee@gmail.com,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] drm/amdgpu: initialize r variable into amdgpu_cs_submit function
Date:   Tue, 20 Sep 2022 14:22:14 +0200
Message-Id: <20220920122216.346321-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The builds of arm64 allmodconfig with clang failed to build
next-20220920 with the following result:

1190:3: error: variable 'r' is uninitialized when used here [-Werror,-Wuninitialized]
note: initialize the variable 'r' to silence this warning

This fix compilation error

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 58088c663125..efa3dc9b69fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1168,7 +1168,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_job *job;
 	uint64_t seq;
-	int r;
+	int r = 0;
 
 	job = p->job;
 	p->job = NULL;
-- 
2.25.1

