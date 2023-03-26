Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97F16C9493
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCZNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCZNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F972AA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 06:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 421CD60C09
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B79C433D2;
        Sun, 26 Mar 2023 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679838168;
        bh=x+elaEjNBGrw81mnE6F3RWtDHADRa8KpDJx2MLvF+68=;
        h=From:Subject:Date:To:Cc:From;
        b=eZ02xYuAFO8BHQcq5wBrsTWOROoC1psdx7Zlo1qBJVADy7vf5K7sYEsQ7Dl+Ue8xa
         MKLLFyQ5k98pIJTv0a2dkzeLBPrKsjxaB8+7FubDbH5VIwZkQpLPWwHTzHIgn0WO10
         pid06sLruwUrROAet5ObBbcpOd/4V5ndquDDyXUQ0ydFsCHnsFNDnMekNCGF/bNv6A
         KO/ZXBsORenk1JDdSR4fIjVKuUiI/HmusKVoG1dqZzm/y2Mpy0TPZoyUXCeqOW+3N5
         1oBQ1pmGthZxrS0WucIdlG6ymWvg30I9H6b9Y5Nr9CPiZBayr8E0qtngf+XczpoxVw
         jeYx4F0NDs2PA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] regmap: Add basic maple tree register cache
Date:   Sun, 26 Mar 2023 14:42:37 +0100
Message-Id: <20230325-regcache-maple-v2-0-799dcab3ecb1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1LIGQC/3WNyw6CMBAAf4X07Jo+BNST/2E4lHWhDdiSrUEN4
 d8t3D3OJJNZRCL2lMS1WATT7JOPIYM+FAKdDT2Bf2QWWmojjS6BqUeLjuBpp5HAVCeqy7PCTqL
 IUWsTQcs2oNuyd+Rh0xNT5z/7595kdj69In/37aw2+/cwK5CgsK4uqjLlpWtvA3Gg8Ri5F826r
 j+fcv0FxAAAAA==
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=broonie@kernel.org;
 h=from:subject:message-id; bh=x+elaEjNBGrw81mnE6F3RWtDHADRa8KpDJx2MLvF+68=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkIEvUrRLjFjSATPOgbSsaPDGv7FcK/Sg2c2iZ0au8
 8y5yp/WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZCBL1AAKCRAk1otyXVSH0IK1B/
 4wMIlkYEA7C04mN1cu+A3y5NLYTDyyBtkoN3pWcqGjgYC7pq0jM+RRY/OanBCEOZomJ3Ulwk7JmYPe
 xC2BZI2Gi4HpQGod24jXNlbxlLlNba1wGZq7EJNVzDmsxSDlrhYpNG9Fmx4J7+6E/zKmtPrtTIhnOP
 A2Ns0W61a6tUwnqLaXLxLdwIplVflOxVATdugvUlNBr/7YHoUX8YEM7iLeLwk7YGdOC3BrySbdXQyb
 ctI1c5KeAzBf5lVMLLnKnWmnqfKZCP8a+LxyRICTVWC8Y6AKrSi6iclmMVfGQtYtSokFJs6y1LnXHD
 76szIVvDvCHf1GS3fQ3cbxWTgEmoBA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current state of the art for sparse register maps is the
rbtree cache.  This works well for most applications but isn't
always ideal for sparser register maps since the rbtree can get
deep, requiring a lot of walking.  Fortunately the kernel has a
data structure intended to address this very problem, the maple
tree.  Provide an initial implementation of a register cache
based on the maple tree to start taking advantage of it.

The entries stored in the maple tree are arrays of register
values, with the maple tree keys holding the register addresses.
We store data in host native format rather than device native
format as we do for rbtree, this will be a benefit for devices
where we don't marshal data within regmap and simplifies the code
but will result in additional CPU overhead when syncing the cache
on devices where we do marshal data in regmap.

This should work well for a lot of devices, though there's some
additional areas that could be looked at such as caching the
last accessed entry like we do for rbtree and trying to minimise
the maple tree level locking.  We should also use bulk writes
rather than single register writes when syncing the cache where
possible, even if we don't store in device native format, and
there is room for improvement in how we load register defaults
into the cache.

Very small register maps may continue to to better with rbtree
longer term, though the difference should become marginal
especially in the context of the cost of register I/O.

Changes in v2:
- Rework to store multiple values per maple tree node with
  coalescing, bringing us much closer to the state of the art
  with rbtree.
- Add locking required for maple tree usage.
- Use more efficent code suggested by Liam to free the register
  map.
- Link to v1: https://lore.kernel.org/r/20230325-regcache-maple-v1-0-1c76916359fb@kernel.org

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      regmap: Factor out single value register syncing
      regmap: Add maple tree based register cache

 drivers/base/regmap/Makefile         |   2 +-
 drivers/base/regmap/internal.h       |   2 +
 drivers/base/regmap/regcache-maple.c | 265 +++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regcache.c       |  41 ++++--
 drivers/base/regmap/regmap-kunit.c   |   3 +
 include/linux/regmap.h               |   1 +
 6 files changed, 299 insertions(+), 15 deletions(-)
---
base-commit: c20bc1c03695287bd19922a32052f2bc7d4a462d
change-id: 20230325-regcache-maple-364e7581cf0c

Best regards,
-- 
Mark Brown <broonie@kernel.org>

