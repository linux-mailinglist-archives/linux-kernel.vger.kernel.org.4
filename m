Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2B71158C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbjEYSnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbjEYSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68330E2;
        Thu, 25 May 2023 11:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ACE0648D7;
        Thu, 25 May 2023 18:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892F8C433EF;
        Thu, 25 May 2023 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039844;
        bh=YBOV6kOD7vee+sNC5jOSf0IUd61uv5hmDufyNE8r9Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/IvxlFBjSBbMBpPRRVJMpyk7JSrIxuhf+JSYbzCyGUsGSv5IHRNJEM9Q3qsGRJ/E
         CKpX68mJJI0Hfy922oeAe6A/0FKXEnPWT/vAcpzfzpT8363AzKSAPnB1W5M7Y4kj5Z
         ZDKAI3L1JHQ3q33iJg+85cfxax7/jcdRov5jA+u0VVEP+m8nUnwtQ1/LVDSydvYGak
         z49q5Zc/YEGfyPt2SpXP6/x8zrYqykl6aJJPhBm2cUBCNtgNO61o5iyt708wETujnB
         kC415/P8x6JUTqx6F5r/mw9Vx9CzHqtrmxEVHQiml9WyQXKEGWwDQn30/gFGhnbAX6
         zRUpLJcZqDm6w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hverkuil-cisco@xs4all.nl,
        u.kleine-koenig@pengutronix.de, ojeda@kernel.org,
        sebastian.reichel@collabora.com, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/57] media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table
Date:   Thu, 25 May 2023 14:35:31 -0400
Message-Id: <20230525183607.1793983-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index 452571b380b72..5a024870979de 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -798,7 +798,7 @@ MODULE_DEVICE_TABLE(i2c, mn88443x_i2c_id);
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

