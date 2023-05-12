Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AA6FFDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbjELASW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjELASU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:18:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9E271B;
        Thu, 11 May 2023 17:18:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aafa03f541so90106725ad.0;
        Thu, 11 May 2023 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683850699; x=1686442699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BmuwAOjfLCcRX9ESzyYUHmtPI8orwXkXACX6e4YBEQ=;
        b=JvJ3OH/S8yaPSZe+NJcYbtmIawD4FeDPHEGRiqW2D0VO5T+opsilR8Bg8myVbrrQpy
         ua5A/WXBBKa9YvRjI135PzM3BJ3z/ebDvALE6ftI10OVzhRwH9knvwtRfzUP3EyMgW58
         l5EUl8cUG7Bg1AuS1wg3EDJ+f7m3joINWTsMtQ+2MUmjQmrXEcFa1nsrCXcr1KXYc2v5
         Kxz5x9UEfnvC/nVrXqD1k+3J7a8QfjH6035Edr2r5OxYWSTr4pjPcxiUUv9Mra1tf4OG
         n3Byh8lWiXQhkhY+Je8S4bEca5OB33M7SFK1Mt0o8KS6tMZdkPr9sX1GkV9v1FRiW1no
         yn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850699; x=1686442699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BmuwAOjfLCcRX9ESzyYUHmtPI8orwXkXACX6e4YBEQ=;
        b=MpclHdWA2pmBWL8MO4v47eZTsZVdRsT3vyVBGMH2QE6jwXY1VGwMbgAKvM/vlV3j9Z
         mNFNOf+hs6Y9vB3uEV9bvxEqMf/7j/eSZrJYzjLAJOX12V5JvYk3fEKGPP9KlzAvtbvI
         sFedWd1B4NzvJxj0H4zLWJ9cXk1ANERa8ALC0mmA5VGBNZT+eVN83D66ZbZjj1BRUIYp
         knMe84/cu4uq2IxBYa1NP0RwJwPXQSGUcKyNuTYgXQAcauM3OaFOQCuFGnK8APmBu2T4
         N+L8tms/KXEXPxRCo75sUL5z/ILaj3pzzOb4SoBi+Pp7qnTE5EM0KPXaIncxIhlaQch6
         4i8Q==
X-Gm-Message-State: AC+VfDyEPqpufKdh363CyOOQxvSv9eeWg0i/wKPVzJ99Z959izeVTGcn
        qqqQ6AiLz80hicVqMumfLpw=
X-Google-Smtp-Source: ACHHUZ7hI2+piN2iuzv03zPPsSpCzVVOAtaqPRPnG27/3QG1XF0h/ZYg2MfCevZww4EkUjpXBEaY3A==
X-Received: by 2002:a17:903:1105:b0:1ac:47fe:888 with SMTP id n5-20020a170903110500b001ac47fe0888mr30290379plh.28.1683850699403;
        Thu, 11 May 2023 17:18:19 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:53f7:c9da:338e:6206])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902b11000b001ab016ea3f9sm6537409plr.21.2023.05.11.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:18:18 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] x86-android-tablets: convert to using GPIO references
Date:   Thu, 11 May 2023 17:18:09 -0700
Message-ID: <20230512001815.591817-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

This series came about because now software nodes can be used to
describe GPIOs (via PROPERTY_ENTRY_GPIO() macros) and I would like to
eventually get rid of gpio_keys_platform_data structure.

So while I was doing the conversions from GPIO_LOOKUP() tables for
gpio_keys devices I decided to convert the rest of them as well. Maybe
some time in the future we can drop support for GPIO_LOOKUP() and rely
on device properties exclusively.

This is completely untested.

Thanks.

Dmitry Torokhov (4):
  platform/x86: x86-android-tablets: convert Goodix devices to GPIO references
  platform/x86: x86-android-tablets: convert int3496 devices to GPIO references
  platform/x86: x86-android-tablets: convert wm1502 devices to GPIO references
  platform/x86: x86-android-tablets: convert gpio_keys devices to GPIO references

 drivers/platform/x86/x86-android-tablets.c | 355 ++++++++++++---------
 1 file changed, 201 insertions(+), 154 deletions(-)

-- 
Dmitry

