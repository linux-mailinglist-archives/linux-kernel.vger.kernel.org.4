Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11E464D21D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiLNWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLNWGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:06:40 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D62CE20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:06:39 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-381662c78a9so16824147b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JUpU8XbUBeWziRzLd+hSHISaqkRCe9RKeFMCtB/GcM=;
        b=NDPFzJ9fbND686sGh8mSqpVBsUYGoGThHXm95cc7zr0hT+7Cwt6ZsWADoXQPw6AS6J
         geVLz3AHZZrEbtCyRW9HZuxhwWapDuczb+425AWcvHDXGm2tm6UHwF8QBDec8fQB6ISO
         Ztk0gksV8z6xWSrW7jCgl+yU+lgteuRUXLg68TCyW9MPM3Crdhze8sD3k0bmNBKIxOU8
         TrZHNRE0gFQM3SWrheRnMyGmBI7N2TmWHUDAGqBrL8y/COOp4a80cqivvOYBnUePqdyN
         AHOXaxMT97lmDhx7mUanlsLtDnJ906tjhKUspjhOAbphYpdAiBbDyX3d8aJ2Bjx51m0J
         FZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JUpU8XbUBeWziRzLd+hSHISaqkRCe9RKeFMCtB/GcM=;
        b=jEenVzh/iHzp4eKOez5L0Y3FdR8//kv9pnlblh5KoJeS5fPYjz3SO84ImYHjoULj0j
         fS53aVJd9juRGN4qytlXRRy/+oIxygeI4gAPUNBD/nB68DXGMB7XiZa7+8ryYYYLd2ao
         9THKLIEA2QzzAXvB0lWdTf1l+zBWME+fsZiw+eorBlEZIJQjDyQt0hciO4XwkgaoC1Qg
         WcgtC+dNn6JU2YNf6H1G47EAvHX0d/cFqta6bUbvgt8VXlDTxd/l18INyZ0fUwmUwlar
         C1LmyE/HOSNOBty/v+0yp5OfFRRkV+vbilhcqeXebchuAtVqvkiuOFqfxDd2Og00d6Od
         v/lA==
X-Gm-Message-State: ANoB5pmo1oY0EuNRzxArwB1YAfXNdY3ZPMGCnA7EDBcyoaN+zSaIfjf6
        gVNhi5iwPuMWLQulLYGdsL24/Q==
X-Google-Smtp-Source: AA0mqf4UiHF0MHMqFrLKvrXq3ETo8PhgdlzM1DGiZHfu2Z/DEl8NuHTSQ7vZX9TXXp+nBVT2mBK8FA==
X-Received: by 2002:a05:7500:3cf:b0:ea:730e:6007 with SMTP id p15-20020a05750003cf00b000ea730e6007mr2874719gab.28.1671055598158;
        Wed, 14 Dec 2022 14:06:38 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id bj17-20020a05620a191100b006b95b0a714esm10783173qkb.17.2022.12.14.14.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:06:37 -0800 (PST)
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
Date:   Wed, 14 Dec 2022 17:06:30 -0500
Message-Id: <20221214220632.1309739-1-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221214220423.1183748-1-jcormier@criticallink.com>
References: <20221214220423.1183748-1-jcormier@criticallink.com>
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

