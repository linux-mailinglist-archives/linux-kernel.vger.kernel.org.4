Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3B60C635
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJYIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJYIS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:18:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E542C2CA8;
        Tue, 25 Oct 2022 01:18:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d26so10490966eje.10;
        Tue, 25 Oct 2022 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TbJbxdG5CUFnRGL1K+Jxsme9L/A30/vtCpvY270WFek=;
        b=E8MQCFp1fY4VHscWgf/gq31bCak7taqLKOLkJC5180nxJ+xj9ilsICXockQTnXIVdC
         3k392WCNRuB6Pa5MKW6VHY5lLNTLvSgtTCUnv27//9AceDY5ObEv4rbB5/Sx+DCc+WlU
         +VE+1pKHdC5IbRsvFBCNVOg/KbXtCfAqVjkZD31ISRxhKRScNXiogKcbxXnBWBnG509A
         WzCN48aWmn+2RDSJ978aanNxzcrKj/K4f939dR5SRhmCaTdV/7buVQ6hxUsLb2HnSN17
         Bpcxn2a62LjT+QCYdhkNvkA/udsm6ean8gOQlIoaLH0+wqxsVFnbOSEhV45y3CFkKyNS
         MxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbJbxdG5CUFnRGL1K+Jxsme9L/A30/vtCpvY270WFek=;
        b=00U6AxmiXDCzfZgE1I+Z7RyW+gKxpxxivteW44W21AJwK40H7g169UQXojYwe1PW6g
         mAj8LBpcW8sZIcySIw5TN111C5xfIH3SRVWe48Ji8wwHMFoq9nButu+bwAmu7LwTPC/2
         CAQjKTnuX2VofZCo0qIWcXPGNmvBUn2pPrCLxGyT5IGARPKId2rEZJEGAc1I/LYGOk+k
         i2F3b3/dsniBYtHjGqM3io9ZjIvfZ4g5oohFoPSXPWytW0/dGeWn6jfn060RpRsYlRYW
         vcu1m/1hqjOuEY2ItKy5zvwUzE1SA+r1lxrI0TnB9fj1PBLluYtWbta9TpRBA309K23b
         zZ4A==
X-Gm-Message-State: ACrzQf1Br63NmAZMj9VD0ohQaIF2ZXlKEqppY3Qgx19tLpEi7u2prlEA
        0tlAYXt29TDUS1OMe4/DiYM=
X-Google-Smtp-Source: AMsMyM5Mw4HgGpXO4IP0Xtcj+r5SCe1zFNuB6o9LtwQDnvg1srt2Sms1H6PUKIZYvrj9zeDpVoW2yw==
X-Received: by 2002:a17:907:a40f:b0:790:540c:b6e3 with SMTP id sg15-20020a170907a40f00b00790540cb6e3mr31440039ejc.41.1666685933652;
        Tue, 25 Oct 2022 01:18:53 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060cc100b007822196378asm992898ejh.176.2022.10.25.01.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 01:18:53 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH v3 0/4] Support more parts in LTC2983
Date:   Tue, 25 Oct 2022 11:18:38 +0300
Message-Id: <20221025081842.1896748-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the following parts:
 * LTC2984
 * LTC2986
 * LTM2985

The LTC2984 is a variant of the LTC2983 with EEPROM.
The LTC2986 is a variant of the LTC2983 with only 10 channels,
EEPROM and support for active analog temperature sensors.
The LTM2985 is software-compatible with the LTC2986.

Also, make bulk write buffer DMA-safe.

V1 -> V2:
 * add Fixes tag
 * add patch that fixes the regmap_bulk_write() call with stack allocated
   buffer
 * add patch that refines the binding in preperation for adding new
   parts support to it
 * do not use stack allocated buffer for writing the EEPROM key

V2 -> V3:
 * drop minItems if equal to maxItems
 * drop adi,single-ended conditions because of recent dtschema
   restrictions (even though they're valid in jsonschema and the last
   dtschema tag)
 * drop "allocate iio channels once" patch since it's been picked as a fix

Cosmin Tanislav (4):
  iio: temperature: ltc2983: make bulk write buffer DMA-safe
  dt-bindings: iio: temperature: ltc2983: refine
  dt-bindings: iio: temperature: ltc2983: support more parts
  iio: temperature: ltc2983: support more parts

 .../bindings/iio/temperature/adi,ltc2983.yaml | 329 +++++++++++-------
 drivers/iio/temperature/ltc2983.c             | 193 +++++++++-
 2 files changed, 380 insertions(+), 142 deletions(-)

-- 
2.38.1

