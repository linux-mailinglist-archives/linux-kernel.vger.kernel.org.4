Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB546DE1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDKRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDKRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:11:11 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97F449C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:11:00 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=lyre@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33BH9DX4005030-33BH9DX5005030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Apr 2023 01:09:30 +0800
From:   Ying Liu <lyre@hust.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        Ying Liu <lyre@hust.edu.cn>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tas5720: add missing unwind goto in tas5720_codec_probe
Date:   Wed, 12 Apr 2023 01:09:12 +0800
Message-Id: <20230411170912.1939906-1-lyre@hust.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lyre@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that missing unwind goto in tas5720_codec_probe.

When tas5720 has an invalid devtype, it is expected to invoke
regulator_bulk_disable to handle the failure. But the default
option return an error code directly. Fix it by reusing the
probe_fail label.

Signed-off-by: Ying Liu <lyre@hust.edu.cn>
---
The issue is found by static analysis and the patch remains untested.
---
 sound/soc/codecs/tas5720.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index de6d01c8fdd3..4d27b60bd804 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -339,7 +339,8 @@ static int tas5720_codec_probe(struct snd_soc_component *component)
 		break;
 	default:
 		dev_err(component->dev, "unexpected private driver data\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto probe_fail;
 	}
 
 	if (device_id != expected_device_id)
-- 
2.40.0

