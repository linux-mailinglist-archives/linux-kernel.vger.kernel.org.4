Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E34D711569
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbjEYSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbjEYSow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28B26B6;
        Thu, 25 May 2023 11:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5DC760F7A;
        Thu, 25 May 2023 18:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD8CC4339B;
        Thu, 25 May 2023 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040001;
        bh=AEgLpSXR2JytEFrd0+1cvpNsE8QXoxiVVhkuzKyF3J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoUFMrrGEKjQEiJAf+FATI7mhZ5xmt01IzUfg5hz/I7sdkQmUra+ieo8Wt+5i9RbX
         4+x7gikosMMGp5isztECa6wI/UrpWmGWCDXjHiNahnoKWCeIFFOdG1aqcaQk/gAjb9
         7XWrziXeiQlWmt9A2T8OVyGGwrawbNLeHuSzCGDQ+lFuZW/K7+iTkoKtjbCw9cmd48
         5ybIX2QaqXAQ0pLkawVBbkNvliBULF7+XngAkocYsz8kXj/3/80W2nLKhuRIVdKdWo
         a6MEOAVu3sxCRMoGm1fDFjNDC2QAXkWcRMAeHpVOEENegfdeE3BlBIGKk3f0ZOtB+R
         GvtEe2Wjzfiwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        u.kleine-koenig@pengutronix.de, hverkuil-cisco@xs4all.nl,
        cminyard@mvista.com, khalasa@piap.pl, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 19/43] media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table
Date:   Thu, 25 May 2023 14:38:30 -0400
Message-Id: <20230525183854.1855431-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit ae11c0efaec32fb45130ee9886689f467232eebc ]

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).
This also fixes !CONFIG_OF error:

  drivers/media/dvb-frontends/mn88443x.c:782:34: error: ‘mn88443x_of_match’ defined but not used [-Werror=unused-const-variable=]

Link: https://lore.kernel.org/linux-media/20230312131318.351173-28-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/mn88443x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/mn88443x.c b/drivers/media/dvb-frontends/mn88443x.c
index fff212c0bf3b5..05894deb8a19a 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -800,7 +800,7 @@ MODULE_DEVICE_TABLE(i2c, mn88443x_i2c_id);
 static struct i2c_driver mn88443x_driver = {
 	.driver = {
 		.name = "mn88443x",
-		.of_match_table = of_match_ptr(mn88443x_of_match),
+		.of_match_table = mn88443x_of_match,
 	},
 	.probe    = mn88443x_probe,
 	.remove   = mn88443x_remove,
-- 
2.39.2

