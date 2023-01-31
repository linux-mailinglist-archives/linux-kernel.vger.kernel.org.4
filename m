Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7575C682E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjAaNtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjAaNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:49:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9464DBCD;
        Tue, 31 Jan 2023 05:49:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10E20B81C95;
        Tue, 31 Jan 2023 13:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC9EEC433D2;
        Tue, 31 Jan 2023 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675172980;
        bh=1Z7cFnIaVZYHOUdHNJcuzkiLztx+3TEdtrF5p6m8WUQ=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=CPa7O6jH1u2doQWEM0n18EidGCsTBtqRT/56VA5vc+MPatJO7XeDy3CbLgdiy8PQC
         Mg2X5necEynfG4FgNjXDlKtI8KAyMs79L4LEBUbkmEh81raF627CrkfymA/v1wB960
         sTkLL8m0TkfbSN3G6rOHvNW1kG3XIlj71Vlq32WQAJo3eMAoqo6o1nD+NeB1rjvLf/
         KiHuIDiD8862rTLE3tKB7AtrEzAjZCvUMMU41C9nz/v6MKgR0qMdw9VpO+m6wsL47l
         gkd+65PtRODBVBxb+DItfF/+QJ/9Ai382/wGyk8JBq+Y8ef3P01hz7Suwcjkpjgi4z
         3vJJl185p1d9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id ABAAAC636D4;
        Tue, 31 Jan 2023 13:49:40 +0000 (UTC)
From:   Niall Leonard via B4 Submission Endpoint 
        <devnull+nl250060.ncr.com@kernel.org>
Subject: [PATCH v2 0/2] Introduce new optional property to mark port as
 write only.
Date:   Tue, 31 Jan 2023 13:49:36 +0000
Message-Id: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAc2WMC/3WNSw6DMAxEr4K8rqskqHy64h4VixBc8CIJchBqh
 bh7A/tuRnpjj94OiYQpwbPYQWjjxDFkMLcC3GzDRMhjZjDKlEqbCqeFI3qf480f1LZqR1WSa6m
 GvBlsIhzEBjefK2/TSnIeFqH8f4lefeaZ0xrle3k3fbb/FJtGhY01ypGixtSPLji5u+ihP47jB
 wXno9nBAAAA
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niall Leonard <nl250060@ncr.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=nl250060@ncr.com;
 h=from:subject:message-id; bh=1Z7cFnIaVZYHOUdHNJcuzkiLztx+3TEdtrF5p6m8WUQ=; 
 =?utf-8?q?b=3DowEBbQKS/ZANAwAKAVGiIrYFD2P/AcsmYgBj2RxylmuT5skkrTH/YOGohMmNJ?=
 =?utf-8?q?8jj5UPwlHDOiDQ2_Schczg6JAjMEAAEKAB0WIQSha1EPjh6hUqdtwZNRoiK2BQ9j/?=
 =?utf-8?q?wUCY9kccgAKCRBRoiK2BQ9j/3B4EA_CDgRlwzS6iaobZ21c4NI7EohDkC3mafEZFU?=
 =?utf-8?q?C8J27JAwqTcq4dJ8TuDFD7WJm0M5a2f4j6QuvDueKpZ_Qr3jXmaTNe+vtWSimB6Fz?=
 =?utf-8?q?I4sl7ZbMyRyzg0w+zlbge3WfMKitPdWVEW5KaXWz89KFs+RctteMWxp5o_Dr8uDcB?=
 =?utf-8?q?QlYPzyC3WIVfFPiZPk2L40BHik9pwUq1qey9pRVIoBFiNBKgF/K6N2SI5Opn4jkpv?=
 =?utf-8?q?8t0n+e_4O3j2BhwbkcWMFoMR8r3Ilob9FXUPgpVWZ3mh3vOBH/6ZeAk9uRIZYuC5L?=
 =?utf-8?q?YsYRo0u25YL2GS8cnm2d_KUSPSfbXch/hE95DF6ynGOuQpxyFMaqeiXn+hT60ipYF?=
 =?utf-8?q?UsDNXivaukdHcLnVRRGRe7Tdh2BQ8FZ1V1_0nUNxEWGOUPP7Uu1xViJByfk00IqLx?=
 =?utf-8?q?9h7plFvFpOow63EiPqV4Ccd2IHA1RZ791V9Gccwi1kUT/c50_5dQU3J5DV5EmPN/8?=
 =?utf-8?q?7s2e15MrZ18LJhFGcwF5FpjsdPEn8+UN9+KXnsAxDbqowKy+WLZM43L/izKci2_pF?=
 =?utf-8?q?TA+0ohdkPiXiQT5Bl6nxQvl4s4xc8gvkSortHZBkxJcqDaje22bgvDbObEavGg5Pc?=
 =?utf-8?q?gmFIFUHpBJq?=
 bAm7AC73+49N7SukOS4spYL6ePPlQxVRMIzbam89BQfq/sScdXKcvYbXaDkA==
X-Developer-Key: i=nl250060@ncr.com; a=openpgp;
 fpr=A16B510F8E1EA152A76DC19351A222B6050F63FF
X-Endpoint-Received: by B4 Submission Endpoint for nl250060@ncr.com/default with auth_id=26
X-Original-From: Niall Leonard <nl250060@ncr.com>
Reply-To: <nl250060@ncr.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some electronics do not allow the data regsister to be read without
corrupting the existing data on the port. It a quirk of the board
design.
e.g. I have a couple of boards where the electronics engineer decided 
to only use the chip select line, so no read/write signal is connected. 
This means that reading the address activates the chip select and drives 
the contents of the data bus to the port.This makes it impossible to 
read the last data written to the port.

This solution is to use the existing shadow data register 'bgpio_data'.
It  can be used to return the last value written to the port by the read 
operation.
 
This is enabled for a particular port using a new flag and a new
device tree property "no-input" to allow it to be selected on a board by 
board basis. This means it will only effect hardware that requests it.

Signed-off-by: Niall Leonard <nl250060@ncr.com>
---
Changes in v2:
- Description of change updated to clarify why it is needed.
- Patches squashed as per request during review.
- wd,mbl-gpio bindings updated to yaml format.
- Link to v1: https://lore.kernel.org/r/20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com

---
Niall Leonard (2):
      dt-bindings: improve wb,mbl-gpio binding documentation.
      gpio: mmio: Use new flag BGPIOF_NO_INPUT.

 .../devicetree/bindings/gpio/wd,mbl-gpio.txt       | 38 -----------
 .../devicetree/bindings/gpio/wd,mbl-gpio.yaml      | 78 ++++++++++++++++++++++
 drivers/gpio/gpio-mmio.c                           | 24 ++++++-
 include/linux/gpio/driver.h                        |  1 +
 4 files changed, 100 insertions(+), 41 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230126-gpio-mmio-fix-1a69d03ec9e7

Best regards,
-- 
Niall Leonard <nl250060@ncr.com>

