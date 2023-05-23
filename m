Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81A70E715
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbjEWVEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjEWVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:04:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BB1BB;
        Tue, 23 May 2023 14:04:40 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae4baa77b2so983265ad.2;
        Tue, 23 May 2023 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684875880; x=1687467880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvAzM662WfwoCqxWB7XwbZQ7Hy5ZsmxEV7s6tgqcJgU=;
        b=iV1kS8j5NgB93qouHiEPJG0ROYLaj4M+z3seWANsAs0ZL/w8G4tidGwVbVoiOjG4OZ
         MUudyBzHhsjjAU+3Hz6833RJi9DWNdnEadlEBPmOXE8tc+zdlDzyNJkuphKoUYOVS9/b
         cjRn+2nLBIrCse0RBZSg6aCnKy0eersesSvD8ZKfLSah7MaNxXAPYJlXnY7PU87oTAcM
         Y5tMXW8hIdCIXqNPnfNiQMsXrxz/0VfnlaJpIrFkoP/A0jPlhpXGXfM2ogx1XNngzjkb
         rv0C2+JwrprsM8bivyg3yZzqmHFKblB1ttLYCR0rE/8suUkZdzlqs6klV6mrUz6xedz3
         AzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875880; x=1687467880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvAzM662WfwoCqxWB7XwbZQ7Hy5ZsmxEV7s6tgqcJgU=;
        b=CTm4ehCYH8A8/lTyoYgqqra3BTT2scQtelz9AwXFVFV2ObuSVRPCZkgNrmgo2A1g4Z
         doR88K5dAjr2yk9M8fEzWnh3bVNwyS3/1tThP03emwoyd3FIGhSwtjnoNSMZ82bWTlVM
         3tME5PfgzkP4PiqURyxxrU4g15TnoeC5yFOZQO0Np5Fmop4TA23R4Gqiu6nY6+JtdiX7
         4Cs+ozqpv4uU0lvgIE12XTeH+wJ4GVFsPqU1VuFgd1hxMoIcwPJPwlKbm/49amxHpSIY
         czbezj/oLUPtqxDvcquqG7UXoBu6REAs6iQGdetVsj+lZz8pWamFIA/LAeFY2L27HLOQ
         b5/w==
X-Gm-Message-State: AC+VfDwVUzILBGalUYhRQWttgME4NA4yjn+sgXhTF2r9aWnzbqUFGt6E
        pgZxZ0U0dPbp8MWhKBflt/t6DuoC4lA=
X-Google-Smtp-Source: ACHHUZ4Nv43hVL7DPvAjqSj/Nryd1wRsypbU+aOe4NP7CQPvQWSMYf4X6cysjmfl/6JV0KMDBeihFQ==
X-Received: by 2002:a17:902:dac1:b0:1af:cbdf:8e73 with SMTP id q1-20020a170902dac100b001afcbdf8e73mr3819997plx.8.1684875879528;
        Tue, 23 May 2023 14:04:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001ab01b909c9sm7216892plg.120.2023.05.23.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:04:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2 0/2] HID: ensure timely release of driver resources
Date:   Tue, 23 May 2023 14:04:30 -0700
Message-ID: <20230523-hid-devres-v2-0-5220211a428c@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-2eb1a
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

These 2 patches address an issue in HID subsystem where cleanup code in
the bus code runs before releasing devres-managed resources by the
driver core.

This is a V2 of the patch, which was split in 2 parts - generic cleanup
and the actualy change addressing the issue.

Link: https://lore.kernel.org/r/20230505232417.1377393-1-swboyd@chromium.org
Link: https://lore.kernel.org/r/ZFWarGkRAfPOmI6E@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (2):
      HID: split apart hid_device_probe to make logic more apparent
      HID: ensure timely release of driver-allocated resources

 drivers/hid/hid-core.c | 118 +++++++++++++++++++++++++++++--------------------
 include/linux/hid.h    |   1 +
 2 files changed, 72 insertions(+), 47 deletions(-)
---
base-commit: 9f925874281f7e8855855d6210d6e29d844e4307
change-id: 20230523-hid-devres-b0edd05de354

Best regards,
-- 
Dmitry

