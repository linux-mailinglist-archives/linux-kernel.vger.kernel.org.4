Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93D6F306C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjEALat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 07:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEALar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 07:30:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E852110CF;
        Mon,  1 May 2023 04:30:45 -0700 (PDT)
Received: from koko.localdomain ([213.196.213.13]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTznO-1pk8413qi2-00QzR0; Mon, 01 May 2023 13:30:35 +0200
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 0/6] Small fixes to the cyttsp5 touchscreen driver
Date:   Mon,  1 May 2023 13:30:04 +0200
Message-Id: <20230501113010.891786-1-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hhCh5XIZmWtb4XiSrpMakf0mUm/ygV+KUnpZyFSmz7QcyW4POj7
 PL1KWcmwaC8TsH+DIafJQD6dKmscC6tAhpRtVhE1OunJHeR62hdShrLugqfzzX5+1cXR09H
 kso1Ovytw9wo2f4Is91x4sKk7/D8QgaHl//iBZW1+XSQMA5kVz6V1553vEnn7Rz57+90KIH
 QhQy9NDqXs5ZlBP8rQXuw==
UI-OutboundReport: notjunk:1;M01:P0:kb9LNCKiJ38=;27SZ2Iv5hjyRAc/oQaUN1uTA7Xl
 hfBVStLldcbl6voT1ugKRSdmVK0HyWDEsGPKuJFa2aR4MITUnfARjhk06I0POzVy3UpAi4maV
 Vri9J72mMTpLhwKip9YaHvP4Dn4SgBK4GoZsJQcNj6zwJFVpEzWkLjUjpwB3EKv8Kfbu2E9vF
 g+ve6kN+u6XB50VY+3lydf42/QsEJXME8B11ahnC7CfZbe/2H25uQQLvyN1H75XjHewUXLzMd
 kCL0WjWWXUnxSw5QuV5Ohs+ddLiVkU1Ou5WUjEWDBwDwpW7911jHeyGNImy1AiaPXNeZIBaif
 Lt+kLmM/3Qk7aqoTDjfvnSckEV9MvkeIQrnwl7G6pQ7ITzqtnTj0LkTinqgejI4MYna6nWdzO
 GQwE3fua7k13Jwh3hqU0gt/1kK1sNfMvHV9cXNCBXGYDjcizflLIxHOTpU35+tYBnpe0ddAwg
 bOwZ69+5d64fe69RB5FIJ+08m6wV6WHS81d2XsQEcaofAbkE/y6ivPDvGKgId7+JW/MFqPqGn
 f7mUidzBKJaELgKnU2sq3oTVFiX7t2FdBgEVHHzbOQ2nTZK1vPpTsSLm376I0Achr5t4lGwzI
 tnkaB8sd9euZlj7bnQJV7BSbWQeaRXp+u6f+GOsX4XXPh6JVrFYt8wMpmjivpMKEfsnYyXZKy
 vQMqLfOyXnBeKqt21d09uG71NIO07JY2iPfbGfNDdA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on some intermittent module-loading problems of the
cyttsp5 module on the Pine64 PineNote it was found that the device tree
example of the cypress,tt21000 was in error regarding the interrupt
type (IRQ_TYPE_EDGE_FALLING should be used instead of IRQ_TYPE_LEVEL_LOW).

This lead to the proper implementation of device sleep states, which is
required to ensure proper functioning of the touchscreen after resume
when the correct interrupt type IRQ_TYPE_FALLING_EDGE is used. Sleep and
wakeup commands to the touchscreen were derived from the GPL-2 android
driver by Cypress Semiconductor (copyright note for Cypress
Semiconductor is already in the current driver).

The first two patches fix small issues with the code found during
development of the suspend functionality.

Changes in v2:
- fix subject lines
- fix 'unused variable' errors reported by the kernel test robot
- clean up commit message of patch 2

Maximilian Weigand (6):
  Input: cyttsp5 - fix array length
  Input: cyttsp5 - remove unused code
  dt-bindings: input: cypress,tt21000 - fix interrupt type in dts
    example
  Input: cyttsp5 - properly initialize the device as a pm wakeup device
  dt-bindings: input: cypress,tt21000 - add wakeup-source entry to
    documentation
  Input: cyttsp5 - implement proper sleep and wakeup procedures

 .../input/touchscreen/cypress,tt21000.yaml    |   4 +-
 drivers/input/touchscreen/cyttsp5.c           | 133 +++++++++++++++++-
 2 files changed, 130 insertions(+), 7 deletions(-)


base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
--
2.39.2

