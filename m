Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75F67C85A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjAZKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjAZKSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:18:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B13434323;
        Thu, 26 Jan 2023 02:18:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 177E661784;
        Thu, 26 Jan 2023 10:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D8D8C433D2;
        Thu, 26 Jan 2023 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674728284;
        bh=pzciJ25whFPqz74uOlgRGDuqRYmNEoQWXoTcFna1QFY=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=hZdxHHaxDaYMkWR4Dsc92+PD4/7yRWaqsMmPZ32h6TDmHzFcbjiVQMcq+w6FDbllr
         VxaXH3m8wmI7aagAs1K2xEL4tpSpAAiyWIzBeHJtLqxIIbUeLrcZU9+BB9540khTdO
         1O61qD2E/0SHBPkjLLsBJR09HAWI2uVqcxdZeqxGogLTAFgiJopEZAAimPT9mhAm6u
         9lgdNvQ4WNDBqvGYBVMt6HVahxhfp1I8Ndsohyt66bx4BD2sQd+aaNxzqi8+hV8jSf
         J36EpgcHpwMH6LA3KQfcKDAkP3kM9a/c8TqGWu3L8iKKJTUcbbW0UXQe94qSyX9Zxh
         zYpNbYs1y3l4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE4BC05027;
        Thu, 26 Jan 2023 10:18:04 +0000 (UTC)
From:   Niall Leonard via B4 Submission Endpoint 
        <devnull+nl250060.ncr.com@kernel.org>
Subject: [PATCH 0/3] Introduce new optional property to mark port as write
 only
Date:   Thu, 26 Jan 2023 10:17:21 +0000
Message-Id: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFT0mMC/x2NwQqDQAxEf0VybmB3BcX+SukhrlFz2FWSUgTx3
 xt7GXjMPOYEYxU2eDYnKH/FZKsO8dFAXqkujDI5QwqpDTF1uOyyYSkesxwYqRum0HIeuAd3RjL
 GUanm9bYK2Yf1LnZl3/+PXu/r+gFGFfWReAAAAA==
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niall Leonard <nl250060@ncr.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=nl250060@ncr.com;
 h=from:subject:message-id; bh=pzciJ25whFPqz74uOlgRGDuqRYmNEoQWXoTcFna1QFY=; 
 =?utf-8?q?b=3DowEBbQKS/ZANAwAKAVGiIrYFD2P/AcsmYgBj0lNaon7z7C7FVt2JLo+UquDFZ?=
 =?utf-8?q?/RQuxnhLYLH9Iop_+vBmomSJAjMEAAEKAB0WIQSha1EPjh6hUqdtwZNRoiK2BQ9j/?=
 =?utf-8?q?wUCY9JTWgAKCRBRoiK2BQ9j/31hD/_9kF/j2e0BCq4ghR3YP23h4YUDmJvks7EPxh?=
 =?utf-8?q?wxUpwTkoC7L8j/o4Yyz4JywsHPgy7IoQVrQTtq4v3N2_iIJsrkLMQ0an2mkLDDJJQ?=
 =?utf-8?q?yTJ+WgCSAapePZ4dwzAUeuEc07dsjQo3ga1Jgk1eAImi4nD3oyr1oPZkK_qdydor1?=
 =?utf-8?q?MGIjT9jz/YxqA84ryy2/fQMR/XImwF+p8nVYMCclpY4EXw/1ZHh0Pbvn46EUjooGU?=
 =?utf-8?q?3fCar6_zrKT4kOeBhq2tN1bfsu8f/r45uUQvd0ayzP5AGewqwsWJ4dEwDTNXS9Zx+?=
 =?utf-8?q?7tTeSaTiCa5y591ynvsx_LreJiLBI/KiYLV51ZSNiZPA2gsBgfx28or7ctXckxZ+l?=
 =?utf-8?q?n+Cdo5PR0/cBj5il3LeGIf3FYOrscF92n6_TUfSf8z0Lm5OFzwnKmzfaJAERhZtxE?=
 =?utf-8?q?kvu6FkNncSDeZyocZKsW8WBvoajuioUpQg68Ffyz6kZqdr9/_nL9CRGXPuyG6p11S?=
 =?utf-8?q?fVdA5FaX5wNg65qtYTFs8WFyh6ZG6dRHSNFR+3Y40Bmv8RiTFHpc4AS9gp6AR/_JR?=
 =?utf-8?q?Yto98Jy7h3WkIZKeFihiJb4gzibEpq3xvucFZXN/iU03yfp89IFY2PfhmRxZlif9i?=
 =?utf-8?q?3ohjqoLpj0B?=
 tRUlpjZCr+lujPwLp1liYMuRbjv5rExOyMxh0uHSGYMY0p0crJFK88ti6dMg==
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

Some electronics do not allow the data regsister to be read.
Reading the register can corrupt the output. This makes it
impossible to read the last data written to the port.
The existing shadow data register 'bgpio_data' can be used to allow
the last written value to be returned by the read operation in this
scenario.
This is enabled for a particular port using a new flag and a new
device tree property.

Signed-off-by: Niall Leonard <nl250060@ncr.com>
---
Niall Leonard (3):
      gpio: dt-bindings: add new property to wd,mbl-gpio bindings
      gpio: Add new flag BGPIOF_NO_INPUT
      gpio: mmio: Use new flag BGPIOF_NO_INPUT

 .../devicetree/bindings/gpio/wd,mbl-gpio.txt          |  1 +
 drivers/gpio/gpio-mmio.c                              | 19 +++++++++++++++++--
 include/linux/gpio/driver.h                           |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230126-gpio-mmio-fix-1a69d03ec9e7

Best regards,
-- 
Niall Leonard <nl250060@ncr.com>

