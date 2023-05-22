Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C789B70B85D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjEVJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjEVJC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:02:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84112103;
        Mon, 22 May 2023 02:02:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d58b3efbso3669028f8f.0;
        Mon, 22 May 2023 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684746174; x=1687338174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTDKY6/9ENFcphD0A+7aTVSdeQLL9fouAnjj5/0OnPQ=;
        b=MYUZN/wCmh9X1fSvCh9oPN4J7b/z7BMV8a8MHZAR4o5JE9ezVNXoveoammn0QIjS6k
         5X+Kh2/p3CdPl0EwhHai2i6+utokA0V/Whm621SQ8Okns8SAA+fOxk/Z06hRC/39zcYY
         RUxQHYc9Fy3/Wrrosptw78yruNxeHZyTwcMSOJF4Nb6yYJHfbf+uOIE0WSLTgO9wSBuz
         BE/JfU1GbKvhwWKgnPfeR2inHkmfcty1jNGyL/Kka4imbo8ujxJVd6r9Pnft8hEVMK00
         BDLe4FKE7aGTMVsZVGPpKtyjJO24qbjoOdQlakX9xbVzkjU+9hLHo1NxO9ainsOdcplo
         wLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684746174; x=1687338174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTDKY6/9ENFcphD0A+7aTVSdeQLL9fouAnjj5/0OnPQ=;
        b=FicWoHa+ALy9JhfdWS1Evenjzu9FWGRepl5vtHp/c8uVwm9S+zn+F7Qjde00zezuRX
         bJVBxwfczSALFS/KYNgj7kLpJGmk5Co3D2k9si9rkcntFCC3U7/lumHAAUwHx/lC0oHb
         lK3Y8y1x/j9j3l0Xa4hUqqE+aLefPrBWmQBYcu2M2BD7zwqeBvl84Q2lzX/KJec58qd0
         0xJZPuBlz7SQwwoeE3XaeUW6t5eCBEZIk1tfqgdzg2h6dqXOUCTN0G04yhL4rHIXug/W
         WKOp8uwh5MMr3O3SSfBs5uKTM8g6bKhETwg+c9Fc+F8IZDmMs5Tp9dmxISokcpVcDDIo
         7zWg==
X-Gm-Message-State: AC+VfDzIFyPLFMfANQ+k+wkx1j2K/BUgVeDb79bBEQZhMUbLDiOKaWNQ
        +SiGefAZZA2Jlwf5Vi3SaH680UmmmRknFw==
X-Google-Smtp-Source: ACHHUZ5gZYD/yXE4cCwhckJvb9r3xORQCbJOvZ38Bpu5Pe5i5C13W84yXqg9CPy7CUhXhpAZPYjFwg==
X-Received: by 2002:a5d:4e84:0:b0:309:3ce9:d7a7 with SMTP id e4-20020a5d4e84000000b003093ce9d7a7mr6564810wru.28.1684746173824;
        Mon, 22 May 2023 02:02:53 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f50e29bce3sm7547427wml.48.2023.05.22.02.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 02:02:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: Fix a couple of spelling mistakes in info and debug messages
Date:   Mon, 22 May 2023 10:02:52 +0100
Message-Id: <20230522090252.913910-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
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

There are a couple of spelling mistakes, one in a dev_info message
and the other in a dev_debug message. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 59b8b26e2caf..789cc16e1be7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1007,7 +1007,7 @@ int psp_spatial_partition(struct psp_context *psp, int mode)
 	cmd->cmd_id = GFX_CMD_ID_SRIOV_SPATIAL_PART;
 	cmd->cmd.cmd_spatial_part.mode = mode;
 
-	dev_info(psp->adev->dev, "Requesting %d paritions through PSP", mode);
+	dev_info(psp->adev->dev, "Requesting %d partitions through PSP", mode);
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
 	release_psp_cmd_buf(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index daeb6bcc9245..e9586a0dc335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -359,7 +359,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 						file_priv->minor->index, i);
 				return -ENOENT;
 			}
-			dev_dbg(adev->dev, "renderD%d partition %d openned!",
+			dev_dbg(adev->dev, "renderD%d partition %d opened!",
 					file_priv->minor->index, i);
 			fpriv->xcp_id = i;
 			break;
-- 
2.30.2

