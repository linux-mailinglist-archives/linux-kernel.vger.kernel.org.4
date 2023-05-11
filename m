Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BE6FF993
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbjEKSxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbjEKSw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:52:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4EC19A6;
        Thu, 11 May 2023 11:52:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab14cb3aaeso64199455ad.2;
        Thu, 11 May 2023 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831177; x=1686423177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1OGVtXVQvPChs/XxOnJ0aZQSf8cpL9VPdh6V0PVqy4=;
        b=oFrGP2iZUfP6VrTA6ErH0DZL6UpbGeRNvakvfinXX45LiBrni8o2l/AHkZSnz7zSdL
         oTreJMaVFXe5YOJpfbX+wyx+1sesCcWB+5ke86Whzgz3T8JdSWI6at8ZoWECzkHO8G/f
         3Ypts86TthLpr+5p0Q0T9ZS9loL9+fdsJKgsq6I32vht/RB8HSTw8Vb23eWHECYeOES/
         tIizU68uQoxq8JjCkpalJFOie0uRfGOa6d1kwPN24pMGFHNW/do2YH/UznQqiZvGbkCk
         FwuZSsi9CYN6rNpHKWWpdWNWAOdf7RNDS4E9QR3+4S7BzVP81WeiW10JyD3zMTo2XOPW
         sv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831177; x=1686423177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1OGVtXVQvPChs/XxOnJ0aZQSf8cpL9VPdh6V0PVqy4=;
        b=ZaP8/kXzlPcdrESJE1qVI8RMHRpzUdlSsTffardEihWlX6Q1Cece10dM2C/aH1z0Tk
         LFVUlS58/xYlp3jnxdqV0wIXdNFlWcrdClWoV2D0u1vR+HZgU2q6qavIUjWQUyas+Rze
         K5UJjwx9foLxol9jtndKTKwmuyICsSlk0zOCYlfEWybDEd5eK1Q79OzvN8UmEjbQlznv
         j5iouZiaKEDN1W8CU1OOmSwl8O6aSKxTHNY2y1lPrtVlgxwCCZK7S2rCtbtxkMqbHQyI
         Tw2XWN42YnFGJfUUBhJUuhG2mHIK2UvnsIvWMUDVqxShE8MgomTR8n0Yf5En6oZIghy5
         MD0g==
X-Gm-Message-State: AC+VfDwnqjv6IaxJG6q100NctJ14bCDPgWUbzkzCOakA4VVTW+CwrV+o
        igL7GfdydABM8IogHGAsguAEML2is+c=
X-Google-Smtp-Source: ACHHUZ513krqIZyyS4cXJCjR38+o7ToSF/JOoNDKGVmsB75AzQuCvIwqYQr4onXb1kyjyQj3M1gGWw==
X-Received: by 2002:a17:902:e549:b0:1a6:bb04:a020 with SMTP id n9-20020a170902e54900b001a6bb04a020mr30592656plf.46.1683831176659;
        Thu, 11 May 2023 11:52:56 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a980a23804sm6288995pll.4.2023.05.11.11.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:52:56 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] libps2: be more tolerant when processing commands
Date:   Thu, 11 May 2023 11:52:40 -0700
Message-ID: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
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

Hi,

The main reason for this patch series is to deal with the case when
EC/keyboard controller has already latched a scancode in the output
buffer at the same time the host (kernel) is sending a PS/2 command to
the controller/device. The device should stop scanning (keyboard) or
sending coordinate data (mouse), and instead send acknowledge (0xfa) and
then potentially command response, but if the output buffer already
contains scancode byte it can not be substituted with an ACK byte.

The typical scenario for this is user activating a CapsLock function,
with host sending command to toggle CapsLock LED. If at the same time
the keyboard transmitting break code for the key the kernel may mistake
it for garbage command response and get confused.

To work around this scenario, instead of simply dropping the non-ACK/NAK
byte we will pass it on to atkbd/psmouse for normal processing.

In addition to the above there a couple more assorted cleanups and
fixes.

Thanks.

Dmitry Torokhov (7):
  Input: libps2 - attach ps2dev instances as serio port's drvdata
  Input: libps2 - remove special handling of ACK for command byte
  Input: libps2 - rework handling of command response
  Input: libps2 - fix NAK handling
  Input: libps2 - fix aborting PS/2 commands
  Input: libps2 - introduce common interrupt handler
  Input: libps2 - do not discard non-ack bytes when controlling LEDs

 drivers/input/keyboard/atkbd.c     |  94 ++++-----
 drivers/input/mouse/psmouse-base.c |  86 +++++----
 drivers/input/mouse/psmouse.h      |   2 +
 drivers/input/mouse/synaptics.c    |  10 +-
 drivers/input/mouse/trackpoint.c   |   2 +-
 drivers/input/serio/libps2.c       | 293 +++++++++++++++++++++--------
 include/linux/libps2.h             |  62 +++---
 7 files changed, 350 insertions(+), 199 deletions(-)

-- 
Dmitry

