Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610FF6A5A74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjB1N4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjB1N4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:56:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C0303E9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:55:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Ru-0007wl-GP; Tue, 28 Feb 2023 14:55:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rr-000sd0-3M; Tue, 28 Feb 2023 14:55:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rq-0011da-Ek; Tue, 28 Feb 2023 14:55:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        yuanjian <yuanjian12@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH 0/4] pwm: Ensure .polarity is set in .get_state()
Date:   Tue, 28 Feb 2023 14:55:04 +0100
Message-Id: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=D5QXT4W23QqOn36/ZsmmKkgICyUb+XEuSuIpME7YNSA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj/geoh4S9hZy9giHcQcIyD/zLdxLraMWzPpL6E YG3wJ6L6PuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/4HqAAKCRDB/BR4rcrs Cd76CACaU4bAx0aQM2bGGugTAnm862V66SgIYGZoUVcr+n7ygwtZJ1hr88DRnH9vAUL8Cydh6WE 9Tcp/KSpbJX+sC4YoxnNYQ4ytu2/dNq+gXimRqH6+hxiT77B/rT0zk3yXdzgW9p8Y1+U+Si4/OK rQTjYYXwLhiR1CGLMtgDc/VTgqxl7UlS37lgwvCU2XbPUNOUoVLuJOyTHlYOWwSTSHAR6T4lCrr 90Arcd9gAdYUnbqc3oBGa3mGUigSlZZ3RVEOZxclZe5snE/aVa8thl2LI8IuPBPsG7zvosNps96 9UV4fR5ro9aUq4DZJrKokd1kkzLntxk0q/7wLxwrkf9UxaMj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in the context of the discussion with Munehisa Kamata about the meson driver
not setting .polarity in .get_state() I checked the other drivers for the same
issue. The identified drivers are fixed here. For three of them
zero-initializing *state would be good enough, still I think setting the
polarity explicitly is a good idea. For the hibvt driver (that supports
both polarities) the change is a real improvement.

Note I didn't touch the meson driver here that requires some non-trivial
updates that I don't want to tackle without hardware to test.

Best regards
Uwe

Uwe Kleine-König (4):
  pwm: hibvt: Explicitly set .polarity in .get_state()
  pwm: cros-ec: Explicitly set .polarity in .get_state()
  pwm: iqs620a: Explicitly set .polarity in .get_state()
  pwm: sprd: Explicitly set .polarity in .get_state()

 drivers/pwm/pwm-cros-ec.c | 1 +
 drivers/pwm/pwm-hibvt.c   | 1 +
 drivers/pwm/pwm-iqs620a.c | 1 +
 drivers/pwm/pwm-sprd.c    | 1 +
 4 files changed, 4 insertions(+)


base-commit: 7a77daf8223e772a225d6aa6202a5b1ae2392caf
-- 
2.39.1

