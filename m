Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47A06A2F76
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 13:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBZMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 07:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:50:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA8BDC8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:50:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C549160C22
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51897C4339B;
        Sun, 26 Feb 2023 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677415812;
        bh=tXoBBwH1mWvTjMnK88lV0o+/UEzJ2oHsXRNStxiv+/A=;
        h=From:Subject:Date:To:Cc:From;
        b=cY7wxPIkOJ9Su0CV/be3QlhZE0V3hA8nA3WxZNg5qSszdqcxG+bA2ylvtrMtt5Dn9
         qpaI/FQuYJnSL2z99R17v9VNyWn1z9Ak5M5ELm9k5O89KCyS4u2b5bHWiFF8ojxfxq
         MaKp5FDULs033FP2OF2w1CYqNhxmayozQN8SoNXYySl5WzNt5c4xxp7Mp/kP8G/U4a
         r73cFb4fGtZXWjfXqQjzUO1FG3iWk2fU6gR6C3HDz7xVK6BhkLj6dYWTmvItlNhe7D
         kmr412gVcDJ4/HgrCIQEFvSYMFqwiZPIlcItbL2T6504iAtQ//m2AjQ0OTWr+NoNFV
         R7VlotBjMAtVg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] ASoC: mt8183: Fixes from an initial glance at a
 kselftest run
Date:   Sun, 26 Feb 2023 12:49:55 +0000
Message-Id: <20230224-asoc-mt8183-quick-fixes-v1-0-041f29419ed5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHNV+2MC/x2LSQ7CMAwAv1L5jKU2JaTiK6iHxBhqVSRgs0lV/
 07KcUYzCxirsMGxWUD5LSYlV+h2DdAU85VRzpXBta5vndtjtEJ4ew7d0OPjJTTjRb5sSJQC+UO
 g4D3UO0VjTBozTdv/KTpv+q7876s7jev6A0QTTneAAAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=721; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tXoBBwH1mWvTjMnK88lV0o+/UEzJ2oHsXRNStxiv+/A=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhuTfoXXxNR2nlmlIJVTdS7pxMuNHXu8nl8XdL0paBfV+N/6N
 vryjk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYiKES+z/j2lY/pz4gvGuTOD/F6C
 eD0Dxp46TWpL/7GXIOFz3z1nsZmPyRsSh5AffHHieD3vCeACv9TL00/ayrCacOlKYs6pBYvfTNUw+b
 6z4r/zgt39K0WujIkfeuPCd3/7i1vH5Z5eaDGo++lM/c6Dvn3+Ku74UXDr6dd2lNamzw/gsHDilnb2
 BJTrqRqlvYZyDxKPv05CfvrLivWQb+fZ2vFF3omLVfvXLnmzxv0xLzeUYrZUxsRW9+LpH/99lpwa3i
 pqnneeri34l5L+n0WxW9+M7JGfs4fArXsRz6tdV1eY7bG6Ytu0OzgoLOnlmlcyL56J9IFV6hmgmaL1
 Y16/Iqz2R68XJdsM/epQqdpYLfAQ==
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

This is a collection of fixes I came up after glancing through an
initial test run with the snappily named Kukui Jacuzzi SKU16 Chromebook
on KernelCI.  There are more issues flagged, this is just what I fixed
thus far.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      ASoC: mt8183: Remove spammy logging from I2S DAI driver
      ASoC: mt8183: Fix event generation for I2S DAI operations

 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)
---
base-commit: d2980d8d826554fa6981d621e569a453787472f8
change-id: 20230224-asoc-mt8183-quick-fixes-ccb7c567c755

Best regards,
-- 
Mark Brown <broonie@kernel.org>

