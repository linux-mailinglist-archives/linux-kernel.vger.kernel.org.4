Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABE72ECBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjFMUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjFMUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFC41BE5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319E363AA4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160EDC433D9;
        Tue, 13 Jun 2023 20:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686687480;
        bh=4NVIeFSdf1rRgiU1Qv3QSKfV/9bYeQ/t9TlbhHX/tZs=;
        h=From:Subject:Date:To:From;
        b=Zvxj9EqLq6IHrNdMtKFcL4Dg5t92N3SIX7FkeIQjeLNHGv2ivxP1p38mon+pEE517
         xQQTX44l3WEEHUwlGNjIYx1Wrs3PnZam7YK/yXyvRdL+7uwlsfLU4hmCW4bHkcZEAL
         qyZnrKxuW6f7aRyvME6autgdBA0Rbv4TAXU1dBAa7zKHUc92XgYWTY7YmI+O80RAqH
         Wtaj9vchLWxFS8y80Ihce4l/wzfpn636Ar8NsOmsP8IPwH+3Bs0C5YOb3HEXusXV9d
         4LR428fPy6TwlsMln6VFslfs+sMZ+v6G/JtTBo3uKyb1PT9JmlKOHgH4jDc3iPH6j+
         MDkYHcdiM+6KA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] regmap: Add KUnit tests for read/write checking
Date:   Tue, 13 Jun 2023 21:17:41 +0100
Message-Id: <20230613-regmap-kunit-read-write-v1-0-2db337c52827@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOXOiGQC/x3NywqDMBCF4VeRWXcgJqVgX6V0MUlGHcQoE28gv
 ntjl9+Bn3NCZhXO8K5OUN4ky5QK6kcFoafUMUosBmusM6/aoXI30ozDmmQpoIi7ysJo7NM1LkT
 PrYFSe8qMXimF/u73SYd7npVbOf6Hn+91/QCqhAW9gAAAAA==
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4NVIeFSdf1rRgiU1Qv3QSKfV/9bYeQ/t9TlbhHX/tZs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkiM70jmbSIepy4vBULd35cD3X2oQGJ6i+nkn47hKA
 aCd5A2OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIjO9AAKCRAk1otyXVSH0GtEB/
 9lTFH7vSZfMJG5tSGAHJzfN4GykNni4mJ+QhEEk7JPUW8cvcKrSGKfjxtLy/E8h4up36CdMjP/GALZ
 7E0Bvebyc0tCNGHmdfs9K85aNnx30Z7ibl7/zxVVqxPx752pnXTUAZ4Y4xJutm5vbt9OH27ZEb5bAv
 byXhHwNBqOZa6uVXajjDQ/Jb0Lgwz9dGLpVsQco8Uvhz/xHQ5jb62mOXCfCh/07xpiq0K6Jq4YyY4I
 12CuNMxdS+KtAK4IrY6wfOfkaLlc9OBJpvgIyPdEThf/kqtvaGwnqCE7Adj2XKQteRl05cifESPko6
 igveAvXT3tNXNKFUPJKfS6FsPykA5d
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Takashi found an issue with maple tree syncing registers it
shouldn't do add some test cases that catch that case and some more
potential issues, ideally we'd run through the combination of
readability with all possible I/O calls but that's lifting for another
day.  We did find one issue with missing readability checks which will 
be fixed separately.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      regmap: Add test that writes to write only registers are prevented
      regmap: Add a test case for write only registers
      regmap: Add test to make sure we don't sync to read only registers

 drivers/base/regmap/regmap-kunit.c | 115 +++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
---
base-commit: ecfb8ce26d02ec136b4e1ae8c5a77d22d335057b
change-id: 20230613-regmap-kunit-read-write-024393cdbef0

Best regards,
-- 
Mark Brown <broonie@kernel.org>

