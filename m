Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4C65F093
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjAEPyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjAEPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:53:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED78113F58
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:53:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8162361AF9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72696C433EF;
        Thu,  5 Jan 2023 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672934017;
        bh=vHZs9OjJ6KXg+S9h06OTafkkgxBlrbQRQXCR8C8oFts=;
        h=From:Date:Subject:To:Cc:From;
        b=EaRmeDs94KgukTL3nj7VhltrGLOj5INt3wMoL9fll6WRAybCmCwkBrdrJLi/YMAOi
         G38A/xeGwXHS48/pb0wJ0aABHaE4g0CVNok4NTd+TUixmGFbhlyHUjnTCE9Jp8MEqX
         UUJyy1YEV6GPjEiTqDcVd/tICh8IjxlNNqFEL00O51pqRUSR27N72hH1Ti+v43aQ+7
         uRrPTEyhv1rba5cfIott1kTA0DQZtYlM2/hE3euHrkwJvCgMgtmpnHVDI4fmFrm9MV
         k1f9ernVSQ4yZknxLab+uP6u68l1p3ug6jH+9Wr8wGiL/BGVQEni0uZWiL8EkeBXH1
         lYAZFnOrhwlww==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Thu, 05 Jan 2023 08:53:32 -0700
Subject: [PATCH] ASoC: amd: ps: Fix uninitialized ret in create_acp64_platform_devs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHzytmMC/x2NSQoCMRAAvzL02YYsRMGviIcsrdNgMiEdFxzm7
 2Y8FgVVKwg1JoHztEKjFwsvZYA+TBBnX+6EnAaDUcYqrRy+ZcnUOZPgs3Dhzv7BX0pYI2MVjGiD
 OxkXj5SshtEJXghD8yXOeyl76dR2URvd+POfX67b9gN/dwFjjAAAAA==
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     Vijendar.Mukunda@amd.com, Syed.SabaKareem@amd.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=nathan@kernel.org;
 h=from:subject:message-id; bh=vHZs9OjJ6KXg+S9h06OTafkkgxBlrbQRQXCR8C8oFts=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMnbPjU6rCu0ly2bHu2wMyhmn4Li2T8xM3YKSjq/td54xUcq
 sFWqo5SFQYyDQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEzkjSwjw9QHEZEczY8je97eenThk6
 aeQyMrz4JNomHJfEeyF+kf4mVkWNOb1FfPFlP0om+uyEZFjV1i2zpKhW5NfcF/7+K9C/E/2QA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
          default:
          ^~~~~~~
  sound/soc/amd/ps/pci-ps.c:239:9: note: uninitialized use occurs here
          return ret;
                 ^~~
  sound/soc/amd/ps/pci-ps.c:190:9: note: initialize the variable 'ret' to silence this warning
          int ret;
                 ^
                  = 0
  1 error generated.

Return -ENODEV, which matches the debug message's description of this block.

Fixes: 1d325cdaf7a2 ("ASoC: amd: ps: refactor platform device creation logic")
Link: https://github.com/ClangBuiltLinux/linux/issues/1779
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/amd/ps/pci-ps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 401cfd0036be..f54b9fd9c3ce 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -217,6 +217,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 		break;
 	default:
 		dev_dbg(&pci->dev, "No PDM devices found\n");
+		ret = -ENODEV;
 		goto de_init;
 	}
 

---
base-commit: 03178b4f7e2c59ead102e5ab5acb82ce1eaefe46
change-id: 20230105-wsometimes-uninitialized-pci-ps-c-3b5725c6ed31

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>
