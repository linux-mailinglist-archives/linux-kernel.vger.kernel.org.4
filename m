Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96B864D216
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLNWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLNWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:04:42 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D129F29CB4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:04:41 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3b48b139b46so16415127b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2JUpU8XbUBeWziRzLd+hSHISaqkRCe9RKeFMCtB/GcM=;
        b=De73Fa1DANEEs3bK9FckNfYXZeJRPOkyuCzS+MVlC4tUgwzA2pBEj7/0/dEW86dNyz
         IlkvxyJ/lZh1rbMCws6xHqVHzWR9ld4fo5pqxKlHgmxRjabk9dl4PmeIlvZ6GMfEtAcT
         jNX7QzL4y5Nx/EwvJsjkCxpVuC4Z04cm+AUyceQdbLaHtCd/BdRXs7UqVHN1K0J23Qr8
         erOEhbqdeZQxeOLucVxqgF3m44/sCnpiHfB5kZhhQcbzB59V50gK/Cz02uZbJgNIdacn
         0uC4be0IIPXCzY1XEzH+n54DCk0tioSBljfRYRc1lmjO5hEogZzPU15O331x9Sc0YDZh
         zXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JUpU8XbUBeWziRzLd+hSHISaqkRCe9RKeFMCtB/GcM=;
        b=NCrWt19sQi+9aBpUQHM1mnngcyAXKPRQWBrjKhSD47A9G2cmV+DmX6xYnvEVKkJNbR
         GDXv3RWG0ILnNy4vyFgBM7gitIJUPCOMqotFLdl7YzVxHFnK8eASdLYMVdTzJP5Yi+2b
         aC7L/P8ZSFE9CO93c928Z8WhZIxy9r9DfQ5kJa0O0rUJiqPod88qKvVqwGvEIXMtC/ib
         TcIjmpU3fK5qGSTG8CPC/igztJxEQpIFfWDFuij7uYVyoWvvIO1d1444f+hYKkuruYeJ
         9SVfLGExaoMvhRkFC2W3Ppmlvbd1iLypRfyInMg5EHDnodAncQArhuFbYVt7n8EB1B6i
         f+yQ==
X-Gm-Message-State: ANoB5pmedLceW63qZEcjjmUdTQUzFJWwOc3EhcREodJsU3Jzs1WR55M3
        W5EdlwaU7dV9b9YL2GOW5lPsuQ==
X-Google-Smtp-Source: AA0mqf4dSLN5xgccP3+4JhfC+7D2n4HMblfj3jWOgZIF7iowR0GVMdjUX/T/vRir/jeM/WsRZ/YQ+Q==
X-Received: by 2002:a05:7500:2315:b0:ea:6516:c423 with SMTP id t21-20020a057500231500b000ea6516c423mr3659135gac.76.1671055480871;
        Wed, 14 Dec 2022 14:04:40 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006cfc01b4461sm10723143qki.118.2022.12.14.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:04:40 -0800 (PST)
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
Date:   Wed, 14 Dec 2022 17:04:21 -0500
Message-Id: <20221214220423.1183748-1-jcormier@criticallink.com>
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

