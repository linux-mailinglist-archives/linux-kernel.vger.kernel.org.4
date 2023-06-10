Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6005F72ABFE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjFJOAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjFJOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05C3A95
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A745861795
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663B7C433EF;
        Sat, 10 Jun 2023 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405602;
        bh=jUWhSGuqBSRj7GbjAn8L3UzmH1Na6fgFtTn9Vx8oOE8=;
        h=From:Subject:Date:To:Cc:From;
        b=pXdQ4XuOZqJy4x9BykNp5xkGSnbV9MFUbnbL8ZqlbJRcMcJSGoDoBjxve/WlVOeUm
         3YChQHg3P93ueCr/OQU/U4TASrzZe9XMpjQRzj6MGBDKdCziaAlr9DQbmv1WKbdgQj
         2LLnoNng5VnZtLC8dCNjq6TllV9GLSUFh3OWF94j9yW82a6UcrWzAIYUtFEsOKL6Yc
         GkGXALMJpXZg9zvQE2XitYc6qp4SGpkVc9mP3RbLFqyDzFGRl100MUHCCgNXZDbqhK
         f98q2U9jW7ABgb7n6Of6ixFzOqKxV54RbeDeAt+nurKOYFr+KD2l6K/pwvgAUh393h
         jgopRw9lVt0uw==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] regulator: Convert Linear Technologies driver to maple
 tree cache
Date:   Sat, 10 Jun 2023 14:59:52 +0100
Message-Id: <20230609-regulator-ltc-maple-v1-0-08c15181f8b2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANmBhGQC/x2NQQ6CMBAAv0L27CalxoJ+xXho6xY21pZsUUgIf
 7d4nEkms0EhYSpwazYQ+nLhnCq0pwb8aNNAyM/KoJU+K6OuKDR8op2zYJw9vu0UCUPXtZegXW9
 6A7V0thA6scmPR7tkeR16Egq8/mf3x77/AKA+gw58AAAA
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=718; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jUWhSGuqBSRj7GbjAn8L3UzmH1Na6fgFtTn9Vx8oOE8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIHegoHoMERFx5rn4lJw5U6Ygx8GYCA/U6f36qOC
 4yPlkBSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISB3gAKCRAk1otyXVSH0MGzB/
 0e9+xUpoF/pP1jyadkJ0gX5Z/sq2AJXkcp6x88gYlCxUUy1xBXe/++2IR8hkDwcWa7P9IBSBzQbpC0
 13XYYqjHH2WsNF6V7UPxzxnqC0SI4Rr+Y91mE9go84gWCHJUIRfmWRYiNTjm+pBszpMf+fmmcFzedj
 joFogDlm9YJFrXvLySk21PD/f6xeS2sJ67EqyrvmGpQBJnYBcFAOQNzpd1aOc5mxEifl9BYGm2Twmu
 EX7xOw2MhrB+hbcMyhEubJ4QtHT3MUPOGj/N93e6P5EI82aSKnVU5r5GfOIhVxp3ij89maxh1Y+hne
 SWDT71+IlQ1gGWmUaPfOZ3EFc9pgjF
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

There are a couple of Linear Technologies devices which can only do
single register reads and writes so don't benefit from using the rbtree
register cache rather than the more modern maple tree cache, update them
to use maple tree.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      regulator: ltc3589: Use maple tree register cache
      regulator: ltc3676: Use maple tree register cache

 drivers/regulator/ltc3589.c | 2 +-
 drivers/regulator/ltc3676.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
change-id: 20230609-regulator-ltc-maple-f7715f2b8686

Best regards,
-- 
Mark Brown <broonie@kernel.org>

