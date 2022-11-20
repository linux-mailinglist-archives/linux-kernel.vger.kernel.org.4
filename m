Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54AE6314EE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKTPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:37:21 -0500
Received: from mailfilter06-out40.webhostingserver.nl (mailfilter06-out40.webhostingserver.nl [195.211.73.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF12CE08
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=MM7EtFn1cUFdBCfhl2e3SLpNu+xSuBzEMD0Psa1R+7g=;
        b=qDcl7VdbBdW+XYWsdOyziONQ4gdJtEJnf/yU6Hl/tR2mZQyCGzh7Yrl/7Wp9P7eNnXxUhBTCD5XVr
         QnT6iz5vq+IgO+ARsPJBQ8I0x9d1kS8nw6mOA9lK3zb3hw2VkqPsxnIgiIBqOhZNaBz1mZGvT6HMQr
         m/z82xsNQ/K3liup4qwdiOdKe2f109DIVbnE5EasI1Jlfwveae3/chDaQJpLiSNXHnV8Qp0dKfWAfw
         g+vK2ahaLoh8v5AOtOA+SikCVmzYeX5v7XCuawQyZBeJMckY6tFpIVu8edQqy/muFxfhmorrYr6ZR9
         SUHDocO2Ad+sPN1o6WUY5Di40jqt8og==
X-Halon-ID: 34f9f756-68e9-11ed-837b-001a4a4cb958
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter06.webhostingserver.nl (Halon) with ESMTPSA
        id 34f9f756-68e9-11ed-837b-001a4a4cb958;
        Sun, 20 Nov 2022 16:37:14 +0100 (CET)
Received: from 2a02-a466-68ed-1-a813-1b80-f6b2-b786.fixed6.kpn.net ([2a02:a466:68ed:1:a813:1b80:f6b2:b786] helo=delfion.fritz.box)
        by s198.webhostingserver.nl with esmtpa (Exim 4.96)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1owmNe-004Y9S-0O;
        Sun, 20 Nov 2022 16:37:14 +0100
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Ferry Toth <fntoth@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v4 0/2] usb: dwc3: core: defer probe on ulpi_read_id timeout
Date:   Sun, 20 Nov 2022 16:37:02 +0100
Message-Id: <20221120153704.9090-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- Sent in correct version (Andy, Thinh)
- Add details on reproducing on Intel Merrifield (Thinh)

v3:
- Correct commit message (Greg)
- Add Fixes: and Cc: stable (Greg)

v2:
- Split into separate commits (Thinh)
- Only defer probe on -ETIMEDOUT (Thinh)
- Loose curly brackets (Heikki)

Ferry Toth (2):
  usb: ulpi: defer ulpi_register on ulpi_read_id timeout
  usb: dwc3: core: defer probe on ulpi_read_id timeout

 drivers/usb/common/ulpi.c | 2 +-
 drivers/usb/dwc3/core.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.37.2

