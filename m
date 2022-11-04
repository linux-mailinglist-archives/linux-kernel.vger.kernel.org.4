Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD81618ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKDDSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiKDDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:17:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B9A2611E;
        Thu,  3 Nov 2022 20:17:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l2so3709049pld.13;
        Thu, 03 Nov 2022 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqxToHgUhXx5zVzMpfDkvTdc32yI7QdTCdmYmbj1mWo=;
        b=j1eELCK3rXz3s3bVoQnv3Vu0BMdZY+jObv7KwIQDVrR/E4D0UEyFceL4GQlw1xzjy7
         vR2S08jcyzZtY/FzzMOPNKL/mC6V5S/GDhUPCemBf/0pIl5V7bpIUoChLzdo5Psuh0em
         j6+SBf0d2qJgAfDSlw+wEoaYR/gQptqt6n+L9+o6IcfgkO40Qw3gvLemyJlbT5q5jCRX
         22D+sHrmOok5bNY3Cd50+Phy4Tleu4e2HwFMk5mcpaOKOHgs7MXiLCyF26TbMxjZRPDF
         evKOy7Ibuht885xVqnYRnUzL3tequdDqUUXVsJIbb6M7tlHz4dWFMT/KzEhrJNoDWsLr
         EHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqxToHgUhXx5zVzMpfDkvTdc32yI7QdTCdmYmbj1mWo=;
        b=0r+8AD2GP2OA/7zqdtpo22VwTqNMy6+5kMRYnflnzEq7du3oD2S3mNzm62bMEiwlmj
         d6KmkFsXSFVis5Vt19y7BjrMlx8DSGJRxrQ2kObQgfsMJPJ8Mu2hUwK49p+0E5eAIx18
         J5j0EfCMaOe2lCC95IC2TYPiNHkXvB6TCtZT7rfzxjDVew8O5c85kMinEvLzJW9FVEHn
         6mQ/o2vcRSRylRJPr1J3MUY80kgACGdxzglmZc1YFj6v9KSs2pYXWdghuKFTXxtT1Wvz
         GMgmbdy4vr9278OSsfWwUTxLmAk7spjdBRxTvP8gr0URfB+VKlnRN+AAVQfqLKYxYccs
         h65A==
X-Gm-Message-State: ACrzQf1qSnQY4oNqGKe2fG3+S2YJ8celz8ZkBfV3evZikbb4/ihhMCmK
        K3ckTImRKotbKzHsTLl3AiI=
X-Google-Smtp-Source: AMsMyM4PVCPU2yHDYVCuNekAeB+5DTpKg+DXH2Jw0NlIlDE7xSaEuoTpI1qXSN4RrNFJ8SJoMNzKvw==
X-Received: by 2002:a17:90a:8c7:b0:214:e1:cad0 with SMTP id 7-20020a17090a08c700b0021400e1cad0mr20381543pjn.3.1667531828266;
        Thu, 03 Nov 2022 20:17:08 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b004702eca61fcsm1078655pgk.36.2022.11.03.20.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:17:07 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH RESEND 12/13] omapfb: panel-tpo-td028ttec1: stop including gpio.h
Date:   Thu,  3 Nov 2022 20:16:41 -0700
Message-Id: <20221103-omapfb-gpiod-v1-12-cba1fae5a77c@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
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

The driver does not use gpios, so there is no need to include gpio.h.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 3c0f887d3092..c18d290693c1 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
 #include <video/omapfb_dss.h>
 
 struct panel_drv_data {

-- 
b4 0.11.0-dev-28747
