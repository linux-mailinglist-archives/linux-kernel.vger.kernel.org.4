Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8C072B20F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjFKNZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjFKNZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E4B1B6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 06:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C47806125D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 13:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE29C4339B;
        Sun, 11 Jun 2023 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686489916;
        bh=DQeYkSloSzpPBdUaChSN8yc/bMD0y6doKlE5qMK/4r8=;
        h=From:Subject:Date:To:From;
        b=Igqs7ycj6sQNC5IP4H515MOXVe60M/6gVsU+DoPGfFBcRtrt4fITJsnIGLEUHsMmA
         gJ6roiJjWbFtnf/t8Gto3OAfDny+6KKFfnTSTm1cQGxYEdfNE0+5ngFz5+d3/QdkUn
         qkcqqKp14mX+fAKasSt90Q0m857iuGNHwx1xrctakU/Hw9RCwKZ5fTarcNqTn0Vxx2
         nYPzVJxknbCiWYL3p0BLSZcvud1ONUsQxvJX06sT5Sr7EHXl/PQHyMothp35tVk0Oy
         /IkmZ/VTv9Ym3dDQqZ4KO5wRBth6mbFZVNlCxX9yK5e/jfZjnGnmTmRHtuNP2O2fSo
         BApL6gCAdv1gg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] regmap: Provide basic test coverage for raw I/O
Date:   Sun, 11 Jun 2023 14:25:01 +0100
Message-Id: <20230610-regcache-raw-kunit-v1-0-583112cd28ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3LhWQC/x2NywrCMBAAf6Xs2YU01RD8FfGwSbfNIkbZrQ8o/
 XdTj8MwzArGKmxw7lZQfovJozboDx3kQnVmlLExeOcHF3qHynOmXBiVPnh7VVlwGGMIU4r+GE/
 QwkTGmJRqLnt6J1tYd/FUnuT7v12u2/YDpxHoSn0AAAA=
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DQeYkSloSzpPBdUaChSN8yc/bMD0y6doKlE5qMK/4r8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhcs5C5CRm5h+9HNSx5qG4VTO6zIOYYGD4qil5zYc
 3mZWHnqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIXLOQAKCRAk1otyXVSH0K06B/
 9tbwu1oVs7+z7deWzZ3H+nnXUsjpUzoIgVlX0Bs3FfirTjkttCVOZ/aHaYYMylvILSPeKsn5TfYaQ0
 RmncZPmPIPujpX14iB6mtFwWyLb17uE/MaZPzA+EivxKWAZXTLtDOCLVzVQkD+TDIdk2NDKtRL/BS6
 5f1M+JjisKPPwLGl59+nBqMNS1Dt2XLj1mDBu5m2bY7x3IAoTk3F1FH7QeRebuwdygthVEYFGWZrtP
 cugzkdGeGZU/mTcKTIJGkQVLYs3SaHzpc4YLEmpW01XU7GU63nf+HUcSMJh7ZcJ1NJmlumX7+aszdl
 CejLhtf95bLZQkoKQBGzoGhHt60hD9
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

Our existing coverage only deals with buses that provide single register
read and write operations, extend it to cover raw buses using a similar
approach with a RAM backed register map that the tests can inspect to
check operations.  This coverage could be more complete but provides a
good start.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      regmap: Provide a ram backed regmap with raw support
      regmap: Provide basic KUnit coverage for the raw register I/O

 drivers/base/regmap/Makefile         |   2 +-
 drivers/base/regmap/internal.h       |   8 +
 drivers/base/regmap/regmap-kunit.c   | 327 +++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-raw-ram.c | 133 ++++++++++++++
 4 files changed, 469 insertions(+), 1 deletion(-)
---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230610-regcache-raw-kunit-3d866fb82485

Best regards,
-- 
Mark Brown <broonie@kernel.org>

