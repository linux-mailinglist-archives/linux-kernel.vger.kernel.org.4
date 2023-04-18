Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311376E6860
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDRPgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjDRPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:36:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC2946BA;
        Tue, 18 Apr 2023 08:36:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n43-20020a05600c502b00b003f17466a9c1so58422wmr.2;
        Tue, 18 Apr 2023 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681832169; x=1684424169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LkJVegcK4RPCubdgAGwJFimoe2y53+6saI3D05sGsLI=;
        b=H+69oanFfCKcrI2xj4bC576D35a2NUqQk8XzSkv2ciEMm4d1bBj9fR5+fHThPQpfC6
         +y6DbXC3zQAcFQcFpjL8V76kPv2aiTyyUrh5RlG0UHPBnHQ11hY6Kgy7SfkPJGMK9dB5
         09z5BEFDpc5Mxq1FY6OFaxZKXquZlG3aQN1RLvwK3hLrwcadA697EDBPYs8PUOxL5exj
         eiJu5eSEUPfI69PyD/wsYu3Adjy9jdbDN4wmODLYe1QdaKArJ/MEC5plIs9o74rzb5wX
         Ehw6LGlXsY2F54ZTsgw7yid215g5GgoFq2w1TqqSa/WHC/SqjiNus3RELSzXpoVWT7dS
         4rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832169; x=1684424169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkJVegcK4RPCubdgAGwJFimoe2y53+6saI3D05sGsLI=;
        b=f9/rW7iQtByPhp6xL4zijHiHSmY+6U02cG0U/QVo+yOChmDI7V146JU1OU57sQ8Dxw
         ubC/MdbfPLdRHKXyAQBA/lcKaMKaRAuQFcAb+Vw7BDsQkLziDKWvpV+IXGezYCr9SSEV
         lrlXNl6vLu40NgZjcrdc0BE0QndzcHmpOvFN+hj+F6NB3/QCYT5J2CI4kbBYVh/HvEkL
         iafWtE2FBc61YT7fzsFUGbHeB8bsXIBGV7VL7QhHqEsPAyH2jmDeEt7t5GD3EH53/7rh
         mH5tIwbMxlf7/aXRGnVrxKpVPtXqCuzptiItOCuK07pCohpdSsC+6l5/Bfi+lUIbubDa
         rvyQ==
X-Gm-Message-State: AAQBX9el3pZxmILPjmpJlW4RRtE/evI2d+hVXbPaD45IbuEYEPHaw/UX
        smZJy8mJP2MyX3oe4i+cBW8Wd949cYunRA==
X-Google-Smtp-Source: AKy350ZVp3fSqaY94ZPunCrFUD3kVEZ6PAQGitpq8zuWnC2Mb9fhEsm7VFomjBqsoPCs2KmOqCKj6Q==
X-Received: by 2002:a7b:c44a:0:b0:3eb:42fc:fb30 with SMTP id l10-20020a7bc44a000000b003eb42fcfb30mr14538454wmi.32.1681832168560;
        Tue, 18 Apr 2023 08:36:08 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d16-20020a5d6dd0000000b002d6f285c0a2sm13385333wrz.42.2023.04.18.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:36:07 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: remove redundant initialization to pointer cb_sb_start
Date:   Tue, 18 Apr 2023 16:36:07 +0100
Message-Id: <20230418153607.3125704-1-colin.i.king@gmail.com>
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

The pointer cb_sb_start is being initialized with a value that is never
read, it is being re-assigned the same value later on when it is first
being used. The initialization is redundant and can be removed.

Cleans up clang scan build warning:
fs/ntfs/compress.c:164:6: warning: Value stored to 'cb_sb_start' during its initialization is never read [deadcode.DeadStores]
        u8 *cb_sb_start = cb;   /* Beginning of the current sb in the cb. */

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index f9cb180b6f6b..761aaa0195d6 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -161,7 +161,7 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 	 */
 	u8 *cb_end = cb_start + cb_size; /* End of cb. */
 	u8 *cb = cb_start;	/* Current position in cb. */
-	u8 *cb_sb_start = cb;	/* Beginning of the current sb in the cb. */
+	u8 *cb_sb_start;	/* Beginning of the current sb in the cb. */
 	u8 *cb_sb_end;		/* End of current sb / beginning of next sb. */
 
 	/* Variables for uncompressed data / destination. */
-- 
2.30.2

