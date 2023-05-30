Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4127157A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjE3Hxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjE3Hxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:53:32 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF28118;
        Tue, 30 May 2023 00:53:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso42741195e9.3;
        Tue, 30 May 2023 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685433205; x=1688025205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iN1gw0mwm7WmvYXFIrcXk8pdCkRKPm8Ajl3S6Jy5MwI=;
        b=ZrDagKrme3a6Hd3dwAsyc58nI93cJrUXLIBdL+tbD06gbNArOM7cJHn0IKhRdjXgX6
         t9LUKxyWy/ySTqil0Ytjp7OyWIrGx/Mde1aNMbaBiY6uIKDg7nxH3xbEoG3sjNjIqfgH
         BO/nNFRzjk9B1bkO84yjbOJg01t0xRpjJeqt+ymrsmIfVVpjtVOHkIgjmQrl3MnrPymj
         DsEMdvtRXCEwoFSkSWpnT/TiyziFuhWUZ4Df77msnZ3mx1sXKrXMUYHJUM3Iim42H+nQ
         +JYnmt2S7n8h48ILWkHU++/bmUjaRiHKqtmr5B4b6fNIpIzo8WgyBuYucxT5V3gNUCSU
         nNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433205; x=1688025205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iN1gw0mwm7WmvYXFIrcXk8pdCkRKPm8Ajl3S6Jy5MwI=;
        b=MkP8FcmClvbURcDmbY03Mu/deHtD6Z724zJyjT6GR8fVBml4N9lbCOrjm11YtRBcqo
         6hkuNsI3IXDkR0Z2anQCZoQUvdCcUxOcgiHPXAw+SlEYQYSqznAHbonC5oxLe6V80Rew
         MMGqIpJFPFZdmYzI8qdG9vAXdD5yic4hFIGIBQXPpC49qWTHiWgTw8hWMjJFO1Kmxh9J
         EmYl/plz/50luBu8yN3LI83vmTlw3d3CON/XUcV+zZ2ghGX//shmlVK6vLz8VgG0CjXl
         +3LEbCmzYK18CSWiTfBQwD1dsbJy26zjsgLLLdYNeMg24r8qFBAPE6XmiLGgw/N8cKtN
         Ldyg==
X-Gm-Message-State: AC+VfDzb3pF+IRnWPMmm0qTpZbCTQ+BX4iUDh6aqR+i92LxBCQkWWeSf
        8QofiyKHekttLNgJsQZaGoZG8waMGKM=
X-Google-Smtp-Source: ACHHUZ4IjHvxlNexzSJNUo0Ylft54bbV9bWzAgAp7tWi+uZLe5jkO6oJs/6XXcAjggoqHX48XH74LQ==
X-Received: by 2002:a05:600c:b44:b0:3f2:48dc:5e02 with SMTP id k4-20020a05600c0b4400b003f248dc5e02mr811929wmr.27.1685433204598;
        Tue, 30 May 2023 00:53:24 -0700 (PDT)
Received: from PC-UT2.ad.ennebielettronica.com ([78.152.97.130])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003f6041f5a6csm16561275wmj.12.2023.05.30.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:53:24 -0700 (PDT)
From:   fl.scratchpad@gmail.com
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>
Subject: [PATCH v3 0/5] Fix ad7192 driver issues
Date:   Tue, 30 May 2023 09:53:06 +0200
Message-Id: <20230530075311.400686-1-fl.scratchpad@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabrizio Lamarque <fl.scratchpad@gmail.com>

Here is a patch set to overcome a number of issues in current ad7192
adc driver implementation prevending the driver to be loaded and
behave correctly:

 - null pointer dereference causing kernel panic on driver probe;
 - wrong internal clock selection;
 - use of "avdd" regulator name in place of vref (reference voltage);
 - missing clock options in bindings docs only (already implemented).

The first two issues are regressions.

Backported patches have been tested on a platform with an ARM Cortex-A7
CPU from NXP with kernel 5.15.

As a side note, on the tested platform there is still an issue with a
pending interrupt that I worked around by setting the DRDY IRQ
to LEVEL in place of EDGE sensing. Also, setting IRQ_DISABLE_UNLAZY
flag does not help in my case.

You may find further information here:
https://lore.kernel.org/all/CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com/

Version log:


v2->v3
 - Reworded commit messages
 - Split binding fixes

v1->v2
 - Obtained ad7192_state from iio_dev pointer
 - Added patch on bindings documentation


Fabrizio Lamarque (5):
  iio: adc: ad7192: Fix null ad7192_state pointer access
  iio: adc: ad7192: Fix internal/external clock selection
  iio: adc: ad7192: Use VRef instead of AVdd as reference voltage source
  dt-bindings: iio: ad7192: Add mandatory reference voltage source
  dt-bindings: iio: ad7192: Allow selection of clock modes

 .../bindings/iio/adc/adi,ad7192.yaml          | 32 +++++++++++++++++--
 drivers/iio/adc/ad7192.c                      | 31 +++++++++++++++---
 2 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.34.1

