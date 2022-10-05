Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9DA5F5BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJEVa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJEVaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:30:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3026AE2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:30:24 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h6so1683987qkl.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Umc2AzBtVa0Yu+kyLVbzBuuq520pxoL3Zl06uSBOSsM=;
        b=e15TtvG4z6JHDqwRQTlJNmX9vatjzkGVYADyHnfOmobt7iqNwe5vTBG8egWnRnwwTl
         6IN6qNHeT7TTA7HmOrJ5+FRcI+3hm1dKo43Y+ePzzVPP8ywJJsojLkkqSkQiiRzRq7zS
         Q/nDNQptK6upowa6JBr2lXw1l9GGjGDojVbssOq8MN8nhovYSiazmp6Q0HkIK7U9YQ2S
         Jdlb2OADxAlbUlbU54mLARYu9m2ZPJH7Gc429dv3TC2GGpt0Z5uwh4RQp3aEjRf5AJYV
         ZCoEx4YQWuHEXTWF7Q7kTgGoTNpz0phy+4dabTOdi9vUSa+Rjz/OQ9E4ilSgL4IwwHIe
         Pbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Umc2AzBtVa0Yu+kyLVbzBuuq520pxoL3Zl06uSBOSsM=;
        b=dSzWN2fHFwmWnWyvxShSdb2GIzKmKQAz1dpGnvP+aqQB5styt9vqoCzRyB1WRdEwl+
         B9o6ONxcB2hciozLIu8IuvDtFgQUpz9h2OiWM7SzCAPckOo80sgvtpDsi01mnnY1ERQl
         y8jdNNywFiOtadfQRd9tCEjgpQ8X2ymgXBPNiYS4RDEjyLhdGFm4aSBtRmushQkAliHa
         NoCWkA+o5y+SrR7xmSte0v6MJTIaq+BGjf9iXbb4U83Ipvd93NFELDCXNtc2Vri48Sg9
         3QNblW0ruxPNXy3ezdxkpRc1h4MzHvMdP59nkVBtoWpyXd82oVpSzx7a2KHWVXGWngXm
         Qkpg==
X-Gm-Message-State: ACrzQf2mPLV1GKkvVR7Dkg5Mu3wdNfbS3lOkBxxc2NFf3eSGcMFb2kMg
        PDZ8/NGqxKess8Xc5dfeS60=
X-Google-Smtp-Source: AMsMyM7NTILp6/nyofRQs79VcscIWIBMYQfT86evZTY4FRzNuROCYdWeOlow4HQXtAWpwzpssoN2rw==
X-Received: by 2002:a37:58f:0:b0:6e0:d52f:175c with SMTP id 137-20020a37058f000000b006e0d52f175cmr1110786qkf.13.1665005423338;
        Wed, 05 Oct 2022 14:30:23 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a255600b006b929a56a2bsm20058566qko.3.2022.10.05.14.30.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:30:22 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     alcooperx@gmail.com, kishon@ti.com, vkoul@kernel.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH 0/6] Various bug fixes/improvements for phy-brcm-usb driver
Date:   Wed,  5 Oct 2022 14:30:12 -0700
Message-Id: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justin.chen@broadcom.com>

A few suspend/resume bug fixes with clocks and wake counter. Also improve
port mode selection.

Al Cooper (1):
  phy: usb: s2 WoL wakeup_count not incremented for USB->Eth devices

Justin Chen (5):
  phy: usb: Improve port mode selection
  phy: usb: Migrate to BIT and BITMASK macros
  phy: usb: Disable phy auto-suspend
  phy: usb: Use slow clock for wake enabled suspend
  phy: usb: Fix clock imbalance for suspend/resume

 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 95 ++++++++++++-----------
 drivers/phy/broadcom/phy-brcm-usb-init.c          | 90 ++++++++++-----------
 drivers/phy/broadcom/phy-brcm-usb-init.h          | 11 ++-
 drivers/phy/broadcom/phy-brcm-usb.c               | 28 ++++---
 4 files changed, 116 insertions(+), 108 deletions(-)

-- 
2.7.4

