Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BF867C984
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbjAZLLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbjAZLLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:11:51 -0500
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA04C6227A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:11:16 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id KzrppyQ5bn7VrKzrppdllO; Thu, 26 Jan 2023 11:52:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674730350; bh=myInPor8rXD94G+3tUeiroxKrE1C2KWb3OnnwfjinhA=;
        h=From:To:Subject:Date:MIME-Version;
        b=CSlm4Ne5Mb7qPqBQ1h2sqUWFAg3GKQm56u+nnJNs2v27dt41dYTbG/BTAXQp2IhJ5
         8/8aX6j38gYM7Rz8x6TyilfThostTCD8KwQO8y3de8KwKssai6jPRRKInnsxmVA31q
         e9M35Y/81cYEHPT/y31/9Hw7lLVI/pM188xZW19gHCFnlTtcRXxdbZOklVQR7FItnG
         HskcIPfcpqlZ50v+FZegmRGHGQID3y+97luI7s/MJ7o20o16wxd1v68P7g8oI3tQYJ
         AH61vWXmrkCVhO0+bVwl1o/KqYguiwOX3Jy4OBMe4twMR26uMqXv+Z4weKZ5vtkCQb
         m6D38ppZTcHKg==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v5 0/3] Input: ads7846 - fix support for ADS7845
Date:   Thu, 26 Jan 2023 11:52:24 +0100
Message-Id: <20230126105227.47648-1-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIu6JE6lrlg69W2PGstc+dCcpOBkH3x02U+eegLCJcagpghlKiuFSbKQMYhzy7Mdx8v0uxA9DyWJp7ZxIeWa323e8q2OSPmR1xRGNJKDI+Z+GThonD0a
 H01Ru1pV8y0s+M7r6HaCgdoQwWXvqzd+av9NQggckNVYrBOqQPqjv5pzUfpJasN+GMn7YX32iADNHsLzTTSydjKmweOi/65nLn7KHhfTJfGu511TWurZjnCH
 2yf0kieiMs5svxLk8Fug7Av+pOpXdo53qluf0pr/Dft6rW4qq2EfkeK4+O9qtuQ8/JkZr9rVHh1HUKAJKIjJJ46hW6EO9NtGgeOU9jBqCPPj15rTRkcffy9K
 j8PIu3I5C/cJXX7d21LK4OUSDE8LsxSTGXOTRiJAMdqBZV05inMK+A64umtfh4LEIEFtj2h1h6yDjE9QfQGVC5zEQrjg5HLGa1n+lmHrMANZUkYEYjk7YHKx
 5NzzAikWkdHaEp23U4Vj4RQELGLvi5+5ShYAzUHzU0Wvh1LaiR5VbMTvrU3LMvbYLtmTYtGFJNLRwNaWukHyQcK1iTE5HSWW72Jw1rap7ePZ7aP26kHOEgCt
 sn4XfXO+sbUPfpnBcIVdNu0u
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADS7845 support is buggy in this driver.
These patches fix various issues to get it work properly.

Changes for v2:
 - add missing period in patch 0001 message
 - elaborate comment in patch 0002
 
Changes for v3:
 - send from the same email address of "Signed-off"

Changes for v4:
 - fix tag
 - fix comment in patch 0002

Changes for v5:
 - add Fixes: tag
 - fix comment in patch 0001

Luca Ellero (3):
  Input: ads7846 - don't report pressure for ads7845
  Input: ads7846 - always set last command to PWRDOWN
  Input: ads7846 - don't check penirq immediately for 7845

 drivers/input/touchscreen/ads7846.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.25.1

