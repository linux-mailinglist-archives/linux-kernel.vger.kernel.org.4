Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB9675533
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjATNEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjATNEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:04:00 -0500
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8486BCE06
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:03:58 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IqmFpgGfF6DTZIqmGpKx8U; Fri, 20 Jan 2023 13:45:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674218753; bh=1sc2y4jxVCh0WUgnSXRFKIOmNAPld3JSUDEuemnxSIQ=;
        h=From:To:Subject:Date:MIME-Version;
        b=Ik/vWtDhTMcmLgXyQ5ygxS8Q1DLrIu8hP2zrf49fBqpwrRDll9/bAtDTeoBP9mfv6
         LRok3mzAr6EYeMcjLeuAmgO9o4/RT+/KcOTGDznG/yfMR/PQ8iuW9qejt/tFgCmTZ8
         pwTgW69pwi4qvS6Z0W03Z5J/2Yp/qrVz0LLRad+S5OoCVQ6Rmd3lAJbKA16X2UuJKD
         LsVrD0P5pHXNWS9/YiUcI0yPX5Y10NofreZQ1IbyDzHPCI/dMWelpU0t59TK6ks9BL
         TMk3ewrz+RHmwJ0Ze8t1wehids94iw9c6g6tMoKc5dv3HtDEyJmilK1lKy6M9r98mU
         EqNfvuUTvG/5A==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v4 0/3] Input: ads7846 - fix support for ADS7845
Date:   Fri, 20 Jan 2023 13:45:41 +0100
Message-Id: <20230120124544.5993-1-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK2qd5ybJjSlFzMo1WI/f3wDWVy5WneCrHr71Nf/B3YUnHffxHyFi9z3KqQzpupYLWgIouwW3aEoCbSCe8zsK9Q25eUpkrFLJ2s3Xknde7bjUyHuAV0P
 v7mVpqc+L7yTEoG8/XPiyAY4lUmvIbCL6paoc9KvMHIHP2CYRCtjx3d7V9rMtnGo8wdD56Uuo5Utm3/VTA7x9Jn/O9U1EDKS44FqZzE5tZrUiu1ilDp/5Ipw
 UcLms1v3ip9YLE+Fz9cXM0a0bBt6rOIsiOMHfV+cZCivgw+uZcy8/D/QPwT/KfNSFsM/KEFjvah8rNjtsUMs29tiqbyGg8eHymCGxWGDNbL/CkUmbZO3cRCp
 y91ETwhMEMCHnBHfqHKA5GMQAHFx856KHym2NhWYLWsXLB3hi6YA7iT4KeuODzwSifPgE/E1jdeKZa0AvaxmAY02Rnrp/FE0cnU9GsZ4QGuwTs0MY2YDVePu
 3MkmybyjKaR3tGu2k7AcPV1x1tODWZfefDKbmy7x2rpfG9tyBG9OQPfa5f1wDaH9XFyetUlPz6hjkujCnrlWTJVORapoo+tzmoEDgz8W5UK+MLNGwlsAFdN3
 SVipPIGZdc9nWwohcf0RS66j
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
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

Luca Ellero (3):
  Input: ads7846 - don't report pressure for ads7845
  Input: ads7846 - always set last command to PWRDOWN
  Input: ads7846 - don't check penirq immediately for 7845

 drivers/input/touchscreen/ads7846.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.25.1

