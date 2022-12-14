Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B645964D21F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLNWHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLNWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:07:35 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470B3D381
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:07:32 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j16so3706606qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2JUpU8XbUBeWziRzLd+hSHISaqkRCe9RKeFMCtB/GcM=;
        b=CNxtocgVdhiouRT/Ri2e/9sxGZ5y98GKUdSFwy5Vmh67zEhK01ktoEHSVMLfecEGAw
         QlekHUHH7+1q0F/a8RnHa+wgKkX3XB+KDyOZkE2EdZVNbSbjuMK5sqJYztiN05X0asl0
         gJHcfoVUdTDVXvPrjGDLoqEbHd4+aON1w120lmLW6jEABWrpQgwkHoplFPZP56dstEAz
         gruoeobxk+rM4SC4mw20G0evu0aVrol+J6YvMuJkWuSXQcAok3YiKCKou95TUm+dZXX2
         NvrnIUP73Ro9zOk1Gpvs9koNKVRMP6wo6s8eApWSlRr+Kvc37fhAk2JzaeN6JU/fKHcC
         ohlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JUpU8XbUBeWziRzLd+hSHISaqkRCe9RKeFMCtB/GcM=;
        b=UjH96lT9idwaln7Wlras9rpbgKOcccxigwHh6gKw50ZDLrxT1d/Y3F+Xn0lSRotYnq
         K3iE0/6MFP10H+79+hw3bBQp8nvdqMHCYAM4ExK+x3jARi67gknW+vkN54Or+QgxBJIe
         z/UF1oxvB0eFalAhqi/BlFjIo75CnjEhSlH7ctYvRZH6EcC+DP8QHIKAArWN5UZGUdB3
         ASSWO7i4iL+Sc3eu/tOINCASi97gMcLqxIX4z1+YWak2ScdvpahmAxMuLv6CIoexHlOB
         4WvWy6TsCsVybg1rpN51imS9nv0InHav2j2Poo6EY8Tn6yDd0AqN3mhCeRYPyeA/7AG6
         aOPA==
X-Gm-Message-State: ANoB5pkVxgo2tPUKP84abwffIa4RsLsomW8T0rVhXdiVzMkF2JaXN7Vh
        5HdZs3awiawu6NMlQL6SZSGKPw==
X-Google-Smtp-Source: AA0mqf5tyPh08++k7PkNxb1TO06Rfoi5LnlPetPnSNCqg2VUBm4yIRhrBhCeakXApAHZqJZoUOeiWw==
X-Received: by 2002:ac8:5756:0:b0:3a6:8700:b471 with SMTP id 22-20020ac85756000000b003a68700b471mr47000110qtx.38.1671055651738;
        Wed, 14 Dec 2022 14:07:31 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id l24-20020ae9f018000000b006fc2b672950sm10623939qkg.37.2022.12.14.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:07:31 -0800 (PST)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     "Cormier, Jonathan" <jcormier@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: [PATCH 0/2] hwmon: ltc2945: Add binding and shunt resistor support
Date:   Wed, 14 Dec 2022 17:07:25 -0500
Message-Id: <20221214220727.1350784-1-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the ability to specify the value of the shunt resistor in the
device tree instead of assuming it is 1 milliOhm.

Would be good to backport as well

Cormier, Jonathan (1):
  dt-bindings: hwmon: adi,ltc2945: Add binding

John Pruitt (1):
  hwmon: ltc2945: Allow setting shunt resistor

 .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++
 drivers/hwmon/ltc2945.c                       | 86 ++++++++++++++-----
 2 files changed, 115 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml

-- 
2.25.1

