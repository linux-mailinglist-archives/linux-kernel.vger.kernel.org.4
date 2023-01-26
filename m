Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4867D19D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjAZQ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjAZQ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:28:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48003270B;
        Thu, 26 Jan 2023 08:27:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B2F2B81EAB;
        Thu, 26 Jan 2023 16:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07FEC433EF;
        Thu, 26 Jan 2023 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674750422;
        bh=0B3WByzbvhV82JVnWTI4aBuMjHJDudsWnukTFb5RhdA=;
        h=From:Date:Subject:To:Cc:From;
        b=EDHRithYdgojTuNASPVs2fl0h4UgABXTSYzJ9Lvp85KaWZkzexE2CNyjD/9taaezT
         /+qEY1tNEZq3KoZLFQOPAQwG+Kq3IOYFBkJNItMpYqx9gAKT3kN61gaeAE4dSJJmZR
         uK/0e8Vo/gwq8YAycIt7Kmz5cACJ9SnhvGwSRkUNJf74lVbeFTFRYOyot7H1W33eBy
         BJCKZcdnTcC61OFsTSbGTdTx1onbmPRKAXlRQ3pMpvv3chZ9AWA18vc22sP0QpDNNl
         2bPQDJY1N1PRmIurWKyyaR2eexjoFxUaX++xqz+aF7OFbGrp4FVZY8bOV4afnz7Wt7
         46XEQ3FBIGDcA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Jan 2023 16:26:39 +0000
Subject: [PATCH] of/address: Return an error when no valid dma-ranges are
 found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-synquacer-boot-v1-1-94ed0eb1011f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL6p0mMC/x2NQQ6CMBAAv0L27Ca0EDR+xXjolkX2YIu7YCSEv
 1M8ziST2cBYhQ3u1QbKXzHJqYC7VBDHkF6M0hcGX/umdr5DW9NnCZEVKecZfdtQ7+h2HboWSkT
 BGElDiuOZze/ptJPyIL//5vHc9wPT+2Y+dgAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Luca Di Stefano <luca.distefano@linaro.org>,
        993612@bugs.debian.org, stable@kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0B3WByzbvhV82JVnWTI4aBuMjHJDudsWnukTFb5RhdA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj0qnSX2z5hfYDIvpgA1MmtHtOEYUPZ6tljqI7AjOe
 CI3xYzGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9Kp0gAKCRAk1otyXVSH0PIPB/
 9wqN4V/XYFlVMlFoZQ+WV2Lh3k+oKFGTXfLAzUYQY7Zgfz6KnJZgdwgwx/IRigG1ktQxL6IQQ0t3x0
 kZYu2wy5hQDhib4KGIkozJ6BFrLn14sE43fkg33pi6fKuqsMuisvdASS0awe32qcDdZ847fUum9SYk
 xBkW33qV2YcuZ3ZbisXZY8V5d1vqhyh1KxH64VYOeLLjon5En8DFHq8ezNdpi9SC3vcf14xUT3qqbg
 n+irYoWiKaWerUqBDDEGkAbRb9HhWd73rlahS/jj4zBYTGKeLmxpKK+7N6phhA6VqdaWE9WF/Xk16K
 eh4ALvZK6Fb1tsI48O4d1Iel1M/HIx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
converted the parsing of dma-range properties to use code shared with the
PCI range parser. The intent was to introduce no functional changes however
in the case where we fail to translate the first resource instead of
returning -EINVAL the new code we return 0. Restore the previous behaviour
by returning an error if we find no valid ranges, the original code only
handled the first range but subsequently support for parsing all supplied
ranges was added.

This avoids confusing code using the parsed ranges which doesn't expect to
successfully parse ranges but have only a list terminator returned, this
fixes breakage with so far as I can tell all DMA for on SoC devices on the
Socionext Synquacer platform which has a firmware supplied DT. A bisect
identified the original conversion as triggering the issues there.

Fixes: 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Luca Di Stefano <luca.distefano@linaro.org>
Cc: 993612@bugs.debian.org
Cc: stable@kernel.org
---
 drivers/of/address.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index c34ac33b7338..21342223b8e5 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -975,10 +975,12 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 	}
 
 	/*
-	 * Record all info in the generic DMA ranges array for struct device.
+	 * Record all info in the generic DMA ranges array for struct device,
+	 * returning an error if we don't find any parsable ranges.
 	 */
 	*map = r;
 	of_dma_range_parser_init(&parser, node);
+	ret = -EINVAL;
 	for_each_of_range(&parser, &range) {
 		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
 			 range.bus_addr, range.cpu_addr, range.size);
@@ -992,6 +994,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 		r->size = range.size;
 		r->offset = range.cpu_addr - range.bus_addr;
 		r++;
+		ret = 0;
 	}
 out:
 	of_node_put(node);

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230126-synquacer-boot-243bd1b87f64

Best regards,
-- 
Mark Brown <broonie@kernel.org>

