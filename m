Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952536F2DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjEADRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjEADPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDF34EC5;
        Sun, 30 Apr 2023 20:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B63C61628;
        Mon,  1 May 2023 03:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC62C433EF;
        Mon,  1 May 2023 03:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910324;
        bh=Zc+iC+SHIjKuKxZqR0EF4TjMLy+et+SB8QxWLeHUGa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WG1dmiM2ujrQUH/pLfHa0ufkqIQEp3IKr1bSK23NJNjuQiEymGoZ+ZOf1elQ2qUws
         XnIhTRTdL2LJx3aPZtnue5AiAZHmlzGg/IzRTzHa5zMp6ggLBs1J6WdN7+sImXR2jU
         wnHVJ7fkrHOi7OvwOswqesHU5VrxBKnvLkcP0CJLZObdkhIar/A+WbYp8+5pFROJeZ
         voBeVrvdapAneBTHBpCDeJ2bUb634IlYFVbnFyfEr1EAVOgMIaRrQjJ1xpj8/xPqMl
         LWBsMgRwx5LHZR8WP/FKyczh1BS54wRbxNiPEGntj/mdx7E73xca5nNJXVv5W1L4TP
         YzT6c6qpeMGEg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        erhard_f@mailbox.org, Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Charlene.Liu@amd.com, chiahsuan.chung@amd.com,
        tony.tascioglu@amd.com, sancchen@amd.com, george.shen@amd.com,
        aurabindo.pillai@amd.com, tales.aparecida@gmail.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 16/17] drm/amd: Fix an out of bounds error in BIOS parser
Date:   Sun, 30 Apr 2023 23:04:33 -0400
Message-Id: <20230501030435.3254695-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030435.3254695-1-sashal@kernel.org>
References: <20230501030435.3254695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 1d86fd5610c03..228f098e5d88f 100644
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

