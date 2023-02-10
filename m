Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581EE69285B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjBJUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjBJUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:33:46 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA83A09F;
        Fri, 10 Feb 2023 12:33:43 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D19A2CD5E0;
        Fri, 10 Feb 2023 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1676061222; bh=J+hP2D5DvKXBlQ7o3a6vrwvdg/KQ9OdP2BfjQ977q5s=;
        h=From:Subject:Date:To:Cc;
        b=dtNVv8XUDQDoNO5V+WZLoMuVtn+p/er3PTBgv39236EUtEPOEiQfwzvliHa7Rjbs0
         2DTHXZTF+KZ2BMWijcIXSpWdrk+EadSLMsM5au5Nrh8n9wgxnkX6YCR5T5KuOFSgKX
         qsc65ESQAu7T2q+iVxxWEvktVzixACPny3YYDcSo=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Single-lane CSI-2 operation on OmniVision OV5670
Date:   Fri, 10 Feb 2023 21:33:16 +0100
Message-Id: <20230210-ov5670-single-lane-v1-0-71835d39c1ce@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAyq5mMC/x2OQQrCMBAAv1L27JYkmrT1K+JhE9c20KSahaKU/
 t3U48AMzAbCJbLAtdmg8BolLrmCPjUQJsojY3xUBqPMWRmtcFmt6xRKzOPMOFNmNHawTntNvVF
 QQ0/C6AvlMB3pOywJk6R+6C7oWt1+MVDiQuaQX4Wf8fM/uN33/QcSZrnVkQAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=710; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=J+hP2D5DvKXBlQ7o3a6vrwvdg/KQ9OdP2BfjQ977q5s=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj5qogkBU38fHnB5aUG1acia91XNT1ZvclaK4xc
 KP1L3ZUTRmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+aqIAAKCRBy2EO4nU3X
 VrEyD/0VDFpMhCjXHYChLMrwsaXB3efwOg+LuIlyMiIyvJ8vs1b5/Q/Fcl8HtJafKf7qHea5WNc
 4CB7EcJjIT3qxqp3CeLQtgEVVIPSSySfgQPH8IawpWnH6o6kAG0Cv3TwJ8bgRyERKHLb3ywMLbH
 2jODifDX8Kd77b7butVWSl0UHTyluB2GVYCi97p8Q5eB9Q/nPufu3kM1HoCJbVJ85qw+nZN42gy
 bgc+O89r3XVeH13Anthah/QdyYwsISrkXgu+5N+c7c7bagmwyjJa4+WaGXUYVOy+w0whz2gjD9F
 Cm49DbIZjGDw7YPXcBLwvZKUZMIk9eDlzICJqnYJuMb/b+S6x1e1XJqSjTl+/ltsiIdBzwohZss
 sYW+bwOAgKs0cphylQN7Vv9TwYeKMLeuuLJ/N6UUPOWw4CNchYFHUO+V9fakUmCwveD0+okZSQx
 +JsUmvGLOhvOXryMRWNoe650GHpx0pkBATkiG63jP9rkqDYs2mCTlQUunhdPh9MvavGIuL1jozB
 l94YTGBjrKiFptAiG6DxxCue5VtHH7bci/rZGIkES8U42K7L4MF6alPGoyzLyKer+db5vYc92D2
 ZxHtGMbodApyiMu0Z0y4xLMceENqyxaxf4Q0a4W6zd2ZID46aE7GVh6tGWW3QlHDR8m0EoomLdD
 k/58qB8RQIatLiA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for single-lane configuration of OV5670 sensor.

While I believe this series shouldn't break anything on ACPI systems I
don't not have one to test. Verified on DT/OF only using a single-lane
configuration.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      media: i2c: ov5670: Use dev_err_probe in probe function
      media: i2c: ov5670: Support single-lane operation

 drivers/media/i2c/ov5670.c | 112 +++++++++++++++++++++++++++++++--------------
 1 file changed, 77 insertions(+), 35 deletions(-)
---
base-commit: 6ba8a227fd19d19779005fb66ad7562608e1df83
change-id: 20230210-ov5670-single-lane-259561b1a820

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

