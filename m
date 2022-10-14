Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2035FF3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiJNSgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJNSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:35:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E6AC3B8;
        Fri, 14 Oct 2022 11:35:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j16so8887087wrh.5;
        Fri, 14 Oct 2022 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBuenOFJAznaNzn5YDk4yF74Fdz4lVjclL9qQtkiwdo=;
        b=DNvi+XkgFPURgg9h2yvF+OAQjfWCz4Q5bDAPd9AG/WVwO8S7/5tVvK/rOBk7iWahRz
         qNO7hZHQkTw5ABNOn7X+7NhDN3dAO5oKM5+eDMdZHYAEwIwv1WS9UynqxSkgXMPSHm2W
         Me8ySipXpk1kfAkglN9v5y09cNmhCHDCyyUgTN8VNdTPacax1aKqUoxnoJuvJ4TNzBKl
         +Xm//krW7k7zBtkLw5zswNIzJ8mF9c9ToEegAqRtCaWeVw+3Dxt6Zn9561nqdO+KNzrO
         xEi2azNDZldMksDWM3MoZRvnlCyRJ/sCitUeFEpBLGOtHLr7D3Gn0kbB3RrW6GjP4BAE
         Qw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBuenOFJAznaNzn5YDk4yF74Fdz4lVjclL9qQtkiwdo=;
        b=o8lk8Jff6RYlZPNx2t7F82IAmpBuGIbbn5r+tHrGj8mmOm7YpPMYJUW12oa803NJPZ
         kxUIbKp0x9Lpkm0p8Ky/x24uvBNA4E5KDhmKuRwGOAjOtXbUFsqbEFTRwWtvM0J2dOmQ
         JPNZx6tGav/1JS/mrrwZRUKV89bkFW5gIgxQDBAH5RCL4gKrGeowpWG/qlYER8Y7ilAe
         q8k4EiKQUfsLpdTriBLhwq1XKw8qp1BqHaXpQfI0f1BGx1nzZShtT0vkWTLNCyzNttov
         XdmdzMFj6+9enmZ37yCXDz5xS73Ff3n2lGZFMvbJW3z+LBH5hjQAXJT+9Js2j/edH0uQ
         SUeQ==
X-Gm-Message-State: ACrzQf0TNpdaM/9PYSgJoz7G5bdUrrpkYkhDJWYVEO8DGOOiLoqfHBps
        xrXSGI7l9hCAB8TM3GxNWTg=
X-Google-Smtp-Source: AMsMyM7XpPKmXdE5Gd6pPKTU8aXsKQWn7XgcI6nts7AVcaFQvJM1U2k12MZkzZ6Z/ei2RRq229gm4g==
X-Received: by 2002:a5d:428c:0:b0:22e:5d4e:c71e with SMTP id k12-20020a5d428c000000b0022e5d4ec71emr4154030wrq.19.1665772522695;
        Fri, 14 Oct 2022 11:35:22 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc4d:6548:d8bd:5bd])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a403954c3sm2485410wrt.42.2022.10.14.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:35:22 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 5/5] media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering the subdev
Date:   Fri, 14 Oct 2022 19:34:59 +0100
Message-Id: <20221014183459.181567-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Make sure we call ov5645_entity_init_cfg() before registering the subdev
to make sure default formats are set up.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* New patch
---
 drivers/media/i2c/ov5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index b3825294aaf1..14bcc6e42dd2 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1212,6 +1212,8 @@ static int ov5645_probe(struct i2c_client *client)
 		goto err_pm_runtime;
 	}
 
+	ov5645_entity_init_cfg(&ov5645->sd, NULL);
+
 	ret = v4l2_async_register_subdev(&ov5645->sd);
 	if (ret < 0) {
 		dev_err(dev, "could not register v4l2 device\n");
@@ -1224,8 +1226,6 @@ static int ov5645_probe(struct i2c_client *client)
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	ov5645_entity_init_cfg(&ov5645->sd, NULL);
-
 	return 0;
 
 err_pm_runtime:
-- 
2.25.1

