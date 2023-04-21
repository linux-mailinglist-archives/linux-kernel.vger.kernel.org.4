Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D36EAF3D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjDUQfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjDUQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CEE1FFE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3DC861090
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 16:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF72C433EF;
        Fri, 21 Apr 2023 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682094952;
        bh=nnUrL2/uCxS1kaZARBS1+/ZTmFCyuJT0YgKCTa+rc1g=;
        h=From:Date:Subject:To:Cc:From;
        b=Oa81Pmy3R2FzPb3k/KG/nWj6IlSwMJ7NpIjZdt1utIKibjgjnTzUHUV1gAKlxmQL/
         CgQ6IJwt3sxQdUMkz7dW++gGosGQQ1I6igW/9R98B2jPLDZ7sJnL+AdfryeANEZWE3
         hDDvrLh35ESpbmSn5xof/ETumu3bZpxSlBTESGw9UiIox/bjDZf8JIkg2VZcx5n3xk
         bRyV2I3HivhYPjDFCRS7TwrOXBLGn9Obban7QRufTu3DM9JCvf7nCp5zVjAfSX7nJK
         u7DBg69vu6uTlkfJlJAEt0ych7FmnUfi6cm6eyIM8ZvPrMt76F3wvbo7xao2BCiUvq
         9K/kjvZzIQMIw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 21 Apr 2023 17:35:46 +0100
Subject: [PATCH] ASoC: rt715: Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-asoc-rt715-maple-v1-1-200a84835fde@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGG7QmQC/x2NQQrCMBAAv1L27EKSNq34FfGwjRsb1KTsihZK/
 97U4wwMs4KyJFa4NCsIf5OmkivYUwNhovxgTPfK4IxrTWcdkpaA8hmsxzfNL0Z79rH3g+nb2EH
 NRlLGUSiH6Qh/RZ6HnoVjWv6n623bdks+sW95AAAA
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00e42
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nnUrL2/uCxS1kaZARBS1+/ZTmFCyuJT0YgKCTa+rc1g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkQrtltH1fl6yvBPtXjhXRlZ1zgP5vCxhZcVu6cD56
 RfcmX/SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZEK7ZQAKCRAk1otyXVSH0KlrB/
 49Gq1y9hogSCIsLazNSRxQbxeJYozgzfG7fANMEvvEEfGwvVjVnmwPBmtCp6++gdwCgKM37WesTggA
 Va3K2bbARKdoiMg3RAfbn7vryLJ77BsgTz+7S+wQTmHhCOpSvE8h8bmngxWmgrjZxMhGyRjulKyglX
 IHwD/woeBOy0Ca3n8HsBbhlpDIowhkPP+spxtB2uYJmKwjb+/4j5B3SqxJKK0+2gR3FmRq1QnLQKlH
 nwzagIYK9LGkEenmK3cT4qoM86f5/QbFZFFQkC1ABxDuHqfa4p3JnvtsxCkUkL1EbEGVaR8Fi7030s
 0HuPbvvvECWiU+5sjLkNjyUr1YhYj4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap has introduced a maple tree based register cache which makes use of
this more advanced data structure which has been added to the kernel
recently. Maple trees are much flatter than rbtrees, meaning that they do
not grow to such depths when the register map is sparse which makes access
a bit more efficient. The maple tree cache type is still a bit of a work
in progress but should be effective for some devices already.

RT715 seems like a good candidate for maple tree. It is a SoundWire MBQ
device and therefore supports only single register read/write operations
which do not use raw I/O and will therefore save the cost of converting
to and from device native format when accessing the cache while not having
a negative impact from the current lack of bulk operations in maple tree
cache sync. It has a moderately large and quite sparse register map which
is a good fit for storing in a maple tree.

Convert to use maple tree. There should be little if any visible difference
at runtime.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt715-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 4e61e16470ed..5ffe9a00dfd8 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -354,7 +354,7 @@ static const struct regmap_config rt715_regmap = {
 	.max_register = 0x752039, /* Maximum number of register */
 	.reg_defaults = rt715_reg_defaults, /* Defaults */
 	.num_reg_defaults = ARRAY_SIZE(rt715_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 	.reg_read = rt715_sdw_read,

---
base-commit: f033c26de5a5734625d2dd1dc196745fae186f1b
change-id: 20230412-asoc-rt715-maple-185f657063f4

Best regards,
-- 
Mark Brown <broonie@kernel.org>

