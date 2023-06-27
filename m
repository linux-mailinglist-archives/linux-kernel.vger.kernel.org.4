Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2857406B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjF0W6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0W6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:58:51 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 15:58:47 PDT
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8926B9;
        Tue, 27 Jun 2023 15:58:46 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 9F9A3100002;
        Wed, 28 Jun 2023 01:40:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9F9A3100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687905626;
        bh=e1cUKFmZg0TXaiRU2tWtXncs27m+jCxjdlCXc/znU2A=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=hHjrbZftTb+sAPRvW49lU2m6Q22wjlLjFVYWuTRoWM0rAqaEX527ySUIM/O3Hf9FK
         7wLAISq4jEwdksx+p25tWkFZ8GXWa9chHdfceqc7/S7LGqGkaYD+rmYAp4+azoo3W/
         3AwyGT/ZSBTIMol6wtgRyAWfrbN2mHFdLy5UgLf0NWft2qGd/xvUMjgTLX64A2S9hj
         9u7VeF93CdsAAu2KAnyGUUgvCY1iR/mDTHTpdUutXsCpAw5OmiQTcepdcBuxYM+6sT
         1MaWay06ZswESyvsZfgSetuX2j111TA6TuARs8gilaNSO3RhMHhOEFpTBZsrM/sL0G
         9rtdduGZseI6Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 01:40:26 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 01:39:30 +0300
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>,
        George Stark <GNStark@sberdevices.ru>
Subject: [PATCH v3 0/5] meson saradc: add iio channels to read channel 7 mux inputs
Date:   Wed, 28 Jun 2023 01:37:13 +0300
Message-ID: <20230627224017.1724097-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178297 [Jun 27 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/06/27 21:22:00
X-KSMG-LinksScanning: Clean, bases: 2023/06/27 21:22:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/27 18:27:00 #21588965
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Stark <GNStark@sberdevices.ru>

Changelog:

v1->v2:
split refactoring patch [1] into 4 smaller patches, fix comment style

[1] https://lore.kernel.org/lkml/20230621062715.455652-2-gnstark@sberdevices.ru/

v2->v3:
remove patch 'meson saradc: unite iio channel array definitions' [1] after discussion

patch 'meson saradc: add enum for iio channel array indexes'
  - change enum items prefix from INDEX_ to NUM_ since name 'channel index' is
  more relevant to channel array index in iio world and with 2 tables our array index is
  not always equal to channel number
  - resolve conflicts after deleting [1]
  - update commit message, previous patch [2]
  - return channel number for temp channel. It wasn't used and isn't used currently
  but may need later

patch meson saradc: support reading from channel 7 mux inputs
  - resolve conflicts after deleting [1]
  - update commit message, previous patch [3]
  - add routine find_channel_by_num to get channel by channel number

[1] https://lore.kernel.org/lkml/20230623022334.791026-4-gnstark@sberdevices.ru/
[2] https://lore.kernel.org/lkml/20230623022334.791026-5-gnstark@sberdevices.ru/
[3] https://lore.kernel.org/lkml/20230623022334.791026-7-gnstark@sberdevices.ru/

George Stark (5):
  meson saradc: move enums declaration before variables declaration
  meson saradc: move meson_sar_adc_set_chan7_mux routine upper
  meson saradc: add enum for iio channel numbers
  meson saradc: add channel labels
  meson saradc: support reading from channel 7 mux inputs

 drivers/iio/adc/meson_saradc.c | 165 +++++++++++++++++++++++++--------
 1 file changed, 126 insertions(+), 39 deletions(-)

-- 
2.38.4

