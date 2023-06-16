Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94100732EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbjFPKea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbjFPKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A859EA;
        Fri, 16 Jun 2023 03:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18595636E9;
        Fri, 16 Jun 2023 10:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327A5C433A9;
        Fri, 16 Jun 2023 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911307;
        bh=gXQNjNoCFoi3qRgG5JfUdAujGHNYzIpHAOKgEMcQnss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAlteZCGupm7HOhB8ROQmqbQ/jl56jP6dimHUCaDHUJ38S5Y0R6VsO2W/A7JU8A1Y
         25e/x79H5jYh4ReImnYPg0GzFVvnM+xLvhlRki1p99bXLL6FirTjwM6xS7zzgZhsxJ
         fIYEr3+CIcPBNbeYxGhDEA3WW2yI7x8p3VNHS2EdtcfZ1Vu4KdQsW0pjdDEjBQ3LNk
         bVuouFw7d/BF+TflrkYeZJsSaLjmf17eC8RMgQ7NlMwbau0CUrQj4PsTIYyl6NDvzU
         /ZeAx376zPkyEpa38vUKWSpgqkDw69sl48RZ1QSOWu/DzDpzV/4SSviY2kC3fuNZKW
         2ag4+P1hMbHJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, astrid.rost@axis.com,
        aidanmacdonald.0x0@gmail.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 2/8] ASoC: simple-card: Add missing of_node_put() in case of error
Date:   Fri, 16 Jun 2023 06:28:15 -0400
Message-Id: <20230616102821.674153-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102821.674153-1-sashal@kernel.org>
References: <20230616102821.674153-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.247
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herve Codina <herve.codina@bootlin.com>

[ Upstream commit 8938f75a5e35c597a647c28984a0304da7a33d63 ]

In the error path, a of_node_put() for platform is missing.
Just add it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20230523151223.109551-9-herve.codina@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 4484c40c7a39c..653181d7eaa34 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -404,6 +404,7 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 
 			if (ret < 0) {
 				of_node_put(codec);
+				of_node_put(plat);
 				of_node_put(np);
 				goto error;
 			}
-- 
2.39.2

