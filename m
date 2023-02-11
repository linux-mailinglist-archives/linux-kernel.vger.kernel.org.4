Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B4E692F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBKIrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBKIrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:47:52 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C509F974E
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=jGE2RgQsU7h1/v4M/O803N5y1s7
        nrcKlQODyN9uwt/Q=; b=rGiasa7ydrxZvQakIBYKltb64J4K0tAO40kwqA4WBaG
        6xCc5nAj3z/lYBYzsnrRuPe4cG3PkQwwM+0+u5Wz9HaT6iB79uAyTssySf5OtWhB
        kqvnzlaOzE2qTMukaQPLdaYyMjrz9ejA1ob2NGD6EBjtQfTxE+pMVHTRzHHXeZRY
        =
Received: (qmail 2337503 invoked from network); 11 Feb 2023 09:47:29 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Feb 2023 09:47:29 +0100
X-UD-Smtp-Session: l3s3148p1@4q4Aqmj0Bpcujntl
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH RFT 0/3] drivers/thermal/rcar_gen3_thermal: add Gen4 fuse support
Date:   Sat, 11 Feb 2023 09:47:24 +0100
Message-Id: <20230211084728.27832-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car Gen4 has the fuse registers at different locations and with
different names, but with the same purpose. So, first refactor IP core
differences into a 'info' struct, then add the fuse_read callback to it.

Patches are based on top of:

[PATCH v2 0/3] drivers/thermal/rcar_gen3_thermal: Fix device initialization
[PATCH 0/2] thermal: Add support for R-Car V4H

They have been tested on R-Car H3 ES2.0 and M3-N against regressions.
Actual testing of the new fuses on S4-8 still needs to be done because I
don't have access to such HW.

@Shimoda-san: maybe the BSP team or Test team can test these patches?

Looking forward to other review comments, too, of course.

Happy hacking,

   Wolfram


Wolfram Sang (3):
  drivers/thermal/rcar_gen3_thermal: introduce 'info' structure
  drivers/thermal/rcar_gen3_thermal: refactor reading fuses into
    seprarate function
  drivers/thermal/rcar_gen3_thermal: add reading fuses for Gen4

 drivers/thermal/rcar_gen3_thermal.c | 141 ++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 39 deletions(-)

-- 
2.30.2

