Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F279659BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiL3TuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 14:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiL3TuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 14:50:07 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Dec 2022 11:50:05 PST
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADA42A1;
        Fri, 30 Dec 2022 11:50:05 -0800 (PST)
From:   Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1672429402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d8V7YmZwWJpm8TzWMitR9ZGRxdywLzRjThlY+/tGnc8=;
        b=nBBkXSFdnCavEO16vCwMBve9ViRiXreXlB2xHJF6mWU3v2ImVYz43oMQTNqOcJI4s+DFht
        ko4fX1zKTeiiWcnvE8mJLH3B6Yw96Tj75/XS1d+m4kTlzD46zW3L3Yx/VW6qUInsV4SwFd
        +UaRPmhX5VeKc+w+sBTmozvZNbOem5XsgGjslb1GaMq4t3fdPTn6qMZAd7ct4O6AYz+qRo
        xf396sG4wxYJK5i3UTc3AQAZpEkX/a9PADQZyfKso8bf9NCgBY40uUVIRO4INOFVPZ7B/U
        d5LHgtBgutbeAhABB92eaXHwCyUL/hqlN59LJkP/5Vzx6LVlu9ITsNPBYt5UOw==
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 0/1] Fix race between stop command and start of next command in atmel-mci
Date:   Fri, 30 Dec 2022 20:43:14 +0100
Message-Id: <20221230194315.809903-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

while using both slots on controller version 0x210 I noticed a race
condition in atmel-mci. When sending a stop command the command ready
interrupt is enabled before writing to the command register. This causes
the associated interrupt to fire immediately, making the state machine
believe that the stop command has completed already.
Usually this does not seem to cause a problem. I suspect the roudtrip of
mmc command completion through the kernel simply takes long enough that
the stop command has usually completed once a new command is queued.
However when using both slots a command might be queued for the other
slot already, causing immediate dispatch of that command to the
controller. This then interrupts the stop command still being sent and
also corrupts the new command.

I have only tested this patch with controller version 0x210, but from
documentation it seems like this should be a correct fix also for other
controller versions.

Cheers,
Tobias

Tobias Schramm (1):
  mmc: atmel-mci: fix race between stop command and start of next
    command

 drivers/mmc/host/atmel-mci.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.30.2

