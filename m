Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BB7613DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJaTCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJaTCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:02:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E79589;
        Mon, 31 Oct 2022 12:02:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so2420513wmg.2;
        Mon, 31 Oct 2022 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAKY7AptcCVQIhtmA9wqKe7QLZb3fkZHYHjCZEkjfqI=;
        b=eBYn5yVs3gG4F0A2V+BGvTOlxeDyXHO7zxEKqyxQzgq0MRpwiVlymwpZVQsOpyWjGj
         2NfEagpA+IG5N0tWUz9phvK46FAKiPHrQKUFrjtnQGDEtjwMZffZcSTBpcSB7M3Xfhtp
         Y11i7ZqwOpMwNbJl/TD0JnJ2NnZO/1H0/6+tLZjl2mfRlZQLHpvzXNoPQ/K9UXoIXPNy
         ylg676C2UDbxJZFgEl3zmI/Ug6VihVYv+6uEDwun5raEVjT+8gSO13UukiaaQ+WQr89c
         GzdhAApmFOP32ukb2kPk1B3b8bfirxlZyFgPXZDlPFZmcpOcqDzfmgfTgxFc8Poyuj48
         JZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAKY7AptcCVQIhtmA9wqKe7QLZb3fkZHYHjCZEkjfqI=;
        b=hoZ67oNf4M58UC1QLyk6WhNpkeCqrTvXE27rkts+83wQQnNLh3jNqVhPt3LyuC3dwc
         2YXnf/yUtkFJtbobl02+oGrqRDTOBgHWxtBrAXzUq6UI55HlQuUNawbqm2V4JlZ50MxM
         HEK6hoSZgxs2CFLA3N3OGklQeBQh/mQks5ndB/RrZHkboI3hpCCGWpgC1r10YmlFSx78
         +BKTJ3PVILr/8WGwfymEHYNPKGcQjGveMA97h1XFJLu8aZCBXk2hmoGOxX+4R4voOfil
         7hMPT3TSwQJ2TV8J4mSE0SiniubjNDrdwm7lnWrd3DOiMAjNC0JVYMZG8V3pPE//TtXu
         td9A==
X-Gm-Message-State: ACrzQf2ZFnGQEICG/sFvHkaNStM0JqCuBCWg57a8l1n/nESal7wNpA40
        AKE0I6Gko1GG+HsbraORE3o/nIWYm4Naj48b
X-Google-Smtp-Source: AMsMyM7+5plAp3z1yti3XUxEnR/4Pb7z3zLSdjihTsF2sW/Z1Vcc2yePj8G1yJw4I7bSnFL9ZSzwWw==
X-Received: by 2002:a05:600c:3b82:b0:3cf:6cc7:5b7b with SMTP id n2-20020a05600c3b8200b003cf6cc75b7bmr5721776wms.126.1667242950941;
        Mon, 31 Oct 2022 12:02:30 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003a2f2bb72d5sm9141750wmc.45.2022.10.31.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:02:30 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Siarhei Volkau <lis8215@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Input: adc-joystick: add detachable devices support
Date:   Mon, 31 Oct 2022 22:01:57 +0300
Message-Id: <20221031190159.1341027-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For detachable or lock-able joysticks the ADC lanes might
be biased to GND or AVDD when the joystick is detached/locked.

One such kind of joystick is found in the Ritmix RZX-50 handheld.
The joystick is non-detachable, although ADC lane biased to power
supply when the "Hold" switch is activated.

To avoid reporting old/broken measurements valid-range is introduced.
When measured value is outside valid-range the driver reports
safe center position for corresponding axis.

Siarhei Volkau (2):
  dt-bindings: adc-joystick: add valid-range
  Input: adc-joystick - add detachable devices support

 .../bindings/input/adc-joystick.yaml          | 62 +++++++++++++++++++
 drivers/input/joystick/adc-joystick.c         | 58 ++++++++++++++++-
 2 files changed, 119 insertions(+), 1 deletion(-)

-- 
2.36.1

