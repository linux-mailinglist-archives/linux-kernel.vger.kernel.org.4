Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0D64365A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiLEVFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiLEVEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:04:46 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC82B253;
        Mon,  5 Dec 2022 13:04:15 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r18so11549025pgr.12;
        Mon, 05 Dec 2022 13:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5Jm5k6LfpuLvqA9lN9xZn31w5E121NW4HZgJoVdqNQ=;
        b=WYw1ISFLdZW3LzB+DW3KAeQ+1LWi2nLXXgYomdqfNC0ZeZgVOlIMaMQVootOf0AHov
         YoUcvz6WrnCfnLBb3OTXRlWykyS7iqMjgoQREu6zc7ik7AIwM0UPUQJOUIcBjUF+XGua
         J84WuImkEXM3x48gL0narYljldnvTorNcy9u9YLSOV9HJdhF03exi1s0a/CbTaWxH0nI
         Qe/bAlcOpqfSMKIb9K16guwNJzGM22LKuvRdVDYIQ79THl+EE2VK4CDHc0gCR9MoaUzn
         J4rR51bcF8cJRUtXL2Y5KLmxL9BRPJJLW5NYM/R+YYYsdCXnxJ9DuptnYho4YCg52cl4
         8jbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5Jm5k6LfpuLvqA9lN9xZn31w5E121NW4HZgJoVdqNQ=;
        b=OvFk86hxO7dUaTi1QUpbmanaJNkFnoGn4Vl6KTTswrB2ICxR3txycbRLEz8+DoqP2S
         1GZlNKIJAlSZvylqtD/rT/7f44zge9VGc7t60T/GTm5/gFGk70wbXUbFVdvziDehobvB
         p5y0Qkv+az1+Ah6mEC60Vy5C23GZIVBkKAarh06h4GWNnhdQ4MSLireIVP22mFcW0qtM
         JjGpAd5v3WUfv2TLFxe4sX/VaK0y3bCvTqtJOrZrRHy5lsW7Ff4EjVJorUBHLi7Y3QAY
         TZwhBHcKFYO7I+osHmmeu4fa+Xd5FDJGL9dygBc8gat7Trx8UNzvoq9zKfRqBXB1Yb1x
         2iAA==
X-Gm-Message-State: ANoB5pnTMzSjdKk7CTFv4rSCa6jwjTca9fJwtj0kya3i9+VYAVLIjrME
        kA8xQl+ZbwTf1cwJGOkpa24+t6hIUwg=
X-Google-Smtp-Source: AA0mqf5k2No38pec4N/pv3oiLA5jZB7GguT7NZxViDiYmlC+p2j/65J9FQoQpeHhVYpz0i8yUHOPug==
X-Received: by 2002:a63:d742:0:b0:478:bc19:a511 with SMTP id w2-20020a63d742000000b00478bc19a511mr5852942pgi.380.1670274254867;
        Mon, 05 Dec 2022 13:04:14 -0800 (PST)
Received: from charizard.lan (c-67-183-167-205.hsd1.wa.comcast.net. [67.183.167.205])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017ec1b1bf9fsm3209863plh.217.2022.12.05.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:04:13 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 0/2] Handling of non-numbered feature reports by hidraw
Date:   Mon,  5 Dec 2022 13:03:52 -0800
Message-Id: <20221205210354.11846-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

I'm working on a firmware of a device that exposes a HID interface via
USB and/or BLE and uses, among other things, non-numbered feature
reports. Included in this series are two paches I had to create in
order for hidraw devices created for aforementioned subsystems to
behave in the same way when exerciesd by the same test tool.

I don't know if the patches are acceptable as-is WRT to not breaking
existing userspace, hence the RFC tag.

Andrey Smirnov (2):
  HID: uhid: Don't send the report ID if it's zero
  HID: usbhid: Don't include report ID zero into returned data

 drivers/hid/uhid.c            | 15 ++++++++++++---
 drivers/hid/usbhid/hid-core.c | 14 --------------
 2 files changed, 12 insertions(+), 17 deletions(-)

--
2.34.1
