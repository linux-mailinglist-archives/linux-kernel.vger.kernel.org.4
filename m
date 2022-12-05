Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5422B643568
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiLEUPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiLEUPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:15:38 -0500
Received: from mailfilter02-out40.webhostingserver.nl (mailfilter02-out40.webhostingserver.nl [195.211.72.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A11B26AEF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=ZlYUR3PbRpjAK/I0nwV7gXPJw+2rK1/JUG79YjFwvwk=;
        b=UGtWw6EXA8gX2pkVBC4OvDFiafMQ9RnSWuLmhFZ0+ZXLj5XZtcD7cR2Aes1rkmVwJIIxqF+6C8mnu
         xTbgiTFf1PatMaRHbed5JYH9XXTZVIOg9wa5syhmICdFYm8DHQlhwkiroS+DVBWHxVHqxsH1p/AmQY
         ZDQEqE4Iv8tSPUxY2NUjbylrQdEE/IOKsNS/I3UBiLSZ3QR3RNLWyWIWNuXQmtKm4Ao9W+750+WLFL
         zgc6p3fLJ/egzzs8QL1aq+hJKluPJNYlx60G1OU29RiqDPtr/Z2JtEMiABzEcUpjgyBVXgtUHqkqN3
         1xNvhSVfn+pZSYV0HFoSG06dSbHFr1w==
X-Halon-ID: 91c869d7-74d9-11ed-aeca-001a4a4cb922
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter02.webhostingserver.nl (Halon) with ESMTPSA
        id 91c869d7-74d9-11ed-aeca-001a4a4cb922;
        Mon, 05 Dec 2022 21:15:32 +0100 (CET)
Received: from 2a02-a466-68ed-1-f633-1bb8-92a6-ba5d.fixed6.kpn.net ([2a02:a466:68ed:1:f633:1bb8:92a6:ba5d] helo=delfion.fritz.box)
        by s198.webhostingserver.nl with esmtpa (Exim 4.96)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1p2HsB-001b54-1B;
        Mon, 05 Dec 2022 21:15:31 +0100
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
Subject: [PATCH v5 0/2] usb: dwc3: core: defer probe on ulpi_read_id timeout
Date:   Mon,  5 Dec 2022 21:15:25 +0100
Message-Id: <20221205201527.13525-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
- Fix the tag block (Andy)
- Rephrasing, typo's (Andy, Thinh)

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

