Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0E632275
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiKUMkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiKUMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:39:40 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A53F05B;
        Mon, 21 Nov 2022 04:39:32 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 680CE5FD02;
        Mon, 21 Nov 2022 15:39:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669034369;
        bh=9etgnCNzUKNIqOnqnqZtauA6kfSyecw38Vgt+Iketbs=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=efZxRIxX+nCc/9AkkYYU6uAT+sxJsm6KjaYUfmpaDEBxD1NO5j0e8d9FcF/diJXJk
         BC0Vi2BokU1A1TXPK+OP41bceiVLLN2tp/Rvu+zdpOiIpEHzafBMpGjpJ+1OVZ6UQB
         WrRUYyD1TY6N2Ez3nfEbLz0wxyr4Tp8SUOROvt/nDCvTpVBShjhrm45OxfzpxVVKTE
         rL186GlEwqYWLSlAPA9kf3WbZ7cnwgEHM1+JlMDwcyZvqI7kizpH56N0/A+Wwzs29r
         Z7qMMmoDATKOJdJ82KrSVzao6enbuTj9aNSfHgptlaSp+uMmlsrB3OM0trjiUSHGDR
         HfhDkZrsk71XA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 21 Nov 2022 15:39:28 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v2 0/2] leds: trigger: pattern: notify usespace if pattern finished
Date:   Mon, 21 Nov 2022 15:38:31 +0300
Message-ID: <20221121123833.164614-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/21 03:43:00 #20593185
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current moment, userspace caller can schedule LED pattern with
appropriate parameters, but it doesn't have ability to listen to any
events indicated pattern finished. This patch series add support for a
'is_running' attribute to signal LED pattern state to userspace.

For example of user space code how to use the feature:
https://gist.github.com/m-kurbanov/775408521c436a371c3640d49808d08d

Changes v1 -> v2:
    - code style fixes (Andy Shevchenko)
    - typo fixes (Andy Shevchenko)
    - add ABI documentation (Andy Shevchenko)
    - added example on the gist (Andy Shevchenko)

Martin Kurbanov (2):
  leds: trigger: pattern: minor code style changes
  leds: trigger: pattern: notify usespace if pattern finished

 .../testing/sysfs-class-led-trigger-pattern   | 11 +++
 drivers/leds/trigger/ledtrig-pattern.c        | 92 ++++++++++++++-----
 2 files changed, 80 insertions(+), 23 deletions(-)

--
2.38.1

