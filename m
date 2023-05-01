Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0B6F2E03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjEADS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjEADQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533C96198;
        Sun, 30 Apr 2023 20:06:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2500961781;
        Mon,  1 May 2023 03:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1E0C433D2;
        Mon,  1 May 2023 03:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910368;
        bh=IGfIzOT7oHVhB9sFos7UW2q2/INaAcipA+hvzY46HZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TlVN0oes0KFHxNwbEsc7St/KpgtsYMPb8u7KpSqsWE0h3bxwM0kElu5i67WP5nG6u
         JoakbKukZORRA48mYgjauSivaDH/eio1ASO7GRskq3qUMKqticSgBXLbjJOs6v+U3z
         7ZyDoavRaT39J/ETkZ15vNxeynfS1xzLEjEfAaslW907io4KNNkEK+b0+SdDRfnGRC
         7uSNakHWr49du8Zx2hgoRJyunFKKvFvYyh7hkrVybwp9ZJ6N53xYa94TD5M+kJVjKX
         6yJyvsHGKj4hgZRjKLAX4B4pjBHwOTR1+W7Zt3iITo0mlcRVFXfiPmuc0zByEiVCcC
         IZpqXdfhHYJ0A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        erhard_f@mailbox.org, Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Charlene.Liu@amd.com, chiahsuan.chung@amd.com,
        tony.tascioglu@amd.com, aurabindo.pillai@amd.com, sancchen@amd.com,
        george.shen@amd.com, tales.aparecida@gmail.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 12/12] drm/amd: Fix an out of bounds error in BIOS parser
Date:   Sun, 30 Apr 2023 23:05:38 -0400
Message-Id: <20230501030540.3254928-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030540.3254928-1-sashal@kernel.org>
References: <20230501030540.3254928-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit d116db180decec1b21bba31d2ff495ac4d8e1b83 ]

The array is hardcoded to 8 in atomfirmware.h, but firmware provides
a bigger one sometimes. Deferencing the larger array causes an out
of bounds error.

commit 4fc1ba4aa589 ("drm/amd/display: fix array index out of bound error
in bios parser") fixed some of this, but there are two other cases
not covered by it.  Fix those as well.

Reported-by: erhard_f@mailbox.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=214853
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2473
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 930d2b7d34489..9dd41eaf32cb5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -406,11 +406,8 @@ static enum bp_result get_gpio_i2c_info(
 	info->i2c_slave_address = record->i2c_slave_addr;
 
 	/* TODO: check how to get register offset for en, Y, etc. */
-	info->gpio_info.clk_a_register_index =
-			le16_to_cpu(
-			header->gpio_pin[table_index].data_a_reg_index);
-	info->gpio_info.clk_a_shift =
-			header->gpio_pin[table_index].gpio_bitshift;
+	info->gpio_info.clk_a_register_index = le16_to_cpu(pin->data_a_reg_index);
+	info->gpio_info.clk_a_shift = pin->gpio_bitshift;
 
 	return BP_RESULT_OK;
 }
-- 
2.39.2

