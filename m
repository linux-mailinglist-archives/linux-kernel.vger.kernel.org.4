Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7155B8DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiINRPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiINRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:15:10 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016D27CC9;
        Wed, 14 Sep 2022 10:15:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v185-20020a1cacc2000000b003b42e4f278cso12933494wme.5;
        Wed, 14 Sep 2022 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MUUM7KwzU+2KZkzhKF9P1/j81tXXvszfc0LUASC7ZGA=;
        b=bRGqzBulJ+h3aIK0GSYu1WGuD5E1GKrDaNVoqbN9x6qq2eM6+4zcGuC3IqvXqCsmPp
         AtaoY84k3Ba73psWci1jKHZi4UD4ctih2nShAjtbpBzh37b3J3S2F/KWUwlM2374Au4g
         lWValPIYyouOXq0gAzbd4QfdJ5DgZjShNZKtccpQzNXKrvk00h5OmDW0+S0gVgTwKvxB
         6UBpM+Rnm4BjYMl28L2qBzq3PB4XZ7SxSMPyMo5nzU/ZgTk/EHqJ3WO/Yj75gbm7sNaz
         4+b1lL7DBdAQTon+NMFP5Tu82E+FXIoq0oR8oW3s0mo6dYKluDTtxTsduHZTd9NuwN6K
         w3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MUUM7KwzU+2KZkzhKF9P1/j81tXXvszfc0LUASC7ZGA=;
        b=JtjtKn66sCLWsRf2n7inzGBh7xcN3Ki7xST0Sp1HTvFRScoU5HhUGYozleTvsctshb
         tgAgHzRwM9GW+V2++M8KcE8VI4GIG1fh/TyLjLFXS5tw60hlQ93aUBb8iCERM2BkdjZ1
         94M+jfz8+vbG4ZjtZFplDl/jzQPGtv5SvQ5yH/E5WGyr6qFfcl3eX3p3dFMKQ+e/NZ3G
         s4qKo68kjdyCyQZQOtUTN/yfIi3YVaMF3KzEamlOPk5/1NPclgaJqQT9tEqlTtoSgnaU
         9LQtHi9+NkVFP7kA0vrTZr09l5HOuPYJdTJ57T2WryW5UYhBu2cEXUEaUcQ82YIIazmB
         H7IQ==
X-Gm-Message-State: ACgBeo0jmpanKyU0obzfMfJMsu8vr8GT17OzRDy3XCmEy0Qhv5BcEbqG
        +ESNYu6NxGFdEL/mwsGsX/k=
X-Google-Smtp-Source: AA6agR6Rc0CCCWkOiOfheIsc8ANCtg+0ygZPaJ3PLf9IFqpYv7zMPhIFVAi0bPlzLhkr2GM/6vsOOw==
X-Received: by 2002:a05:600c:1546:b0:3a6:a99:aa7 with SMTP id f6-20020a05600c154600b003a60a990aa7mr3738358wmg.109.1663175707237;
        Wed, 14 Sep 2022 10:15:07 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bv7-20020a0560001f0700b0022a53fe201fsm11769459wrb.68.2022.09.14.10.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:15:06 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdkfd: Fix spelling mistake "detroyed" -> "destroyed"
Date:   Wed, 14 Sep 2022 18:15:05 +0100
Message-Id: <20220914171505.54154-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7522bf2d2f57..c70c026c9a93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -898,7 +898,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}
 	if (!mmget_not_zero(svm_bo->eviction_fence->mm)) {
-		pr_debug("addr 0x%lx of process mm is detroyed\n", addr);
+		pr_debug("addr 0x%lx of process mm is destroyed\n", addr);
 		return VM_FAULT_SIGBUS;
 	}
 
-- 
2.37.1

