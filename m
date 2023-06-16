Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E68732E95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344961AbjFPKd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344989AbjFPKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87DD558A;
        Fri, 16 Jun 2023 03:28:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F9F6371C;
        Fri, 16 Jun 2023 10:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B306C433C0;
        Fri, 16 Jun 2023 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911281;
        bh=vixycZa0jXtagiMlhPDBWtOLoaPdv3OMpN1lDdPe7/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXzr9E8SXQf5anqREkgTajbzQkb1NHXDzW06YQA9nl+qjHLJ1+hnkPvYYgPcnFnP2
         UStgnjo/8J6Xw7GQpr0UL/5ptK7TOK9siiISXkORVVDXCBVMFVkeRaAI7Yc8MaOeHD
         bs++5A0vGDilOO+3b6ShFFEv7eye8eMoKx4BNyYpEWroZ4NmrsQBUb9GyWlFOjRu8r
         rJ9kLsCOkcy6ZIk8Qq00Vn8OMsGtNQD2DNg0dP7ib9nXo9Zr/dv8gPZtHlKWNIwuos
         1N5TeCCUnezHvnpNejuznDdyLBVn5BUxUuvF2RPZDYddhJu9t/S1KeKzQXdgn5vyni
         s9vA4w1W5tzyg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, spujar@nvidia.com,
        aidanmacdonald.0x0@gmail.com, astrid.rost@axis.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 04/14] ASoC: simple-card: Add missing of_node_put() in case of error
Date:   Fri, 16 Jun 2023 06:27:41 -0400
Message-Id: <20230616102753.673975-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102753.673975-1-sashal@kernel.org>
References: <20230616102753.673975-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.184
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
index d916ec69c24ff..ac97e8b7978c7 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -410,6 +410,7 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 
 			if (ret < 0) {
 				of_node_put(codec);
+				of_node_put(plat);
 				of_node_put(np);
 				goto error;
 			}
-- 
2.39.2

