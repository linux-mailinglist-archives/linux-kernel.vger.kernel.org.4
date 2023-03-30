Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423386CF7FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjC3AKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC3AKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:10:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFAD4202
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05AD5B8235B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43325C433D2;
        Thu, 30 Mar 2023 00:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680135031;
        bh=6OPjRtreFodTiugCaVKFhgY12JIHQ2V9CaXtnSdw8Rc=;
        h=From:Subject:Date:To:Cc:From;
        b=bsquifgRZ0k+oUcruQ1HwsXXh0uScmGwCV57uNW4GD9j9daZ8IGrmoZxgqUSg8k96
         yYLV+l2+a96YOMPovoxp2sNfgxiODTIRBvWSQ3Fq4GvzZllLsSTF2dDQ5EiRb+4LYe
         PprUTdEi1cW6j/28b89OwJzve31fTxHsrDFElHOsSopfXl706Od9qGp3ontZKOorbf
         YwO+KKYNOZ6dLT/gQ2tSRBx3bkM6ARbmSTlD2BW6x/Ush+Nkv13ScJ+tMUJ2uqwoU4
         rY1luC3XWjZZR1iN4ectqUa/62Xhjt28wjqo7+JzSsBCZrlFabI2xrtRBLcFeGv8m1
         Z5iZm0K56TFiQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/2] regmap: Add basic maple tree register cache
Date:   Thu, 30 Mar 2023 01:10:22 +0100
Message-Id: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7TJGQC/32Nyw6CMBBFf4V0bU0fAuLK/zAu2mGgDdqSqUEN4
 d8t7Fzo8tzk3DOzhOQxsVMxM8LJJx9DBr0rGDgTeuS+zcyUUFpoVXLCHgw45Hcz3pDr6oB1eZT
 QCWBZsiYht2QCuFV7RhrWeSTs/GvrXK6ZnU+PSO8tO8l1/VmYJBdcQl01stJl09nzgBTwto/Us
 /VrUv99lf26aVowViNY+eUvy/IBY0jyYwQBAAA=
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6OPjRtreFodTiugCaVKFhgY12JIHQ2V9CaXtnSdw8Rc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkJNNzzr+9LxrwDPG5XfGItP6QTjQ/mBYELIWGvCbc
 s2743/CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZCTTcwAKCRAk1otyXVSH0GGqB/
 4wtxI82fzlEQJF/rlWcRT3jvziNKNPRD5sm5oN4TKPAp4PZWcleeTsucGk7IU/9wBNQGjLGMWu3ti/
 lq48jW1Bij0L06A0gxzaRJPu5aMs5my5J2MN4yFus2S0iB3otdV4kMo22WzBVx3RfCy9VEOjismb/1
 ibPtZPZ/OqVaWpGCNlH4WIhaCG9+/xxIelNQWmjy+3hO2wh5oq9fjyWRTok4bmFI+t+RRm6wtkaMY0
 69eB7wD798JCBXgjBVgszoBvxUE3mkbqnKXdHNde7aXA3vv7dKHIf/oWLssXtWeV2RkfUYUQJ9lyYK
 f/mY+skqc8qtF7L2O2bu5wbJU/6d1K
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

Changes in v3:
- Rework locking so we don't allocate with the Maple lock.
- Link to v2: https://lore.kernel.org/r/20230325-regcache-maple-v2-0-799dcab3ecb1@kernel.org
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
 drivers/base/regmap/regcache-maple.c | 278 +++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regcache.c       |  41 ++++--
 drivers/base/regmap/regmap-kunit.c   |   3 +
 include/linux/regmap.h               |   1 +
 6 files changed, 312 insertions(+), 15 deletions(-)
---
base-commit: c20bc1c03695287bd19922a32052f2bc7d4a462d
change-id: 20230325-regcache-maple-364e7581cf0c

Best regards,
-- 
Mark Brown <broonie@kernel.org>

