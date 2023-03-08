Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A626B01D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCHIok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCHIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:44:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00868FBDF;
        Wed,  8 Mar 2023 00:44:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u9so62713483edd.2;
        Wed, 08 Mar 2023 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfRb5S56BPBA0+cLXTQV+70i2hjJgSw3qjK6yqkpQmA=;
        b=T+uYE2LzhkooSS7rrRfLJM9pWFxZwabb26+AHUd6qrHyOnbgZYXgUc0ADMS8nCXfl9
         3Bammt8siYoiuycqzAgrEiYPXiRjPIl/+YH/A9OoTfddJg5wklJXWXZ9j++45rtEiP6L
         YyBgK5XelJ8yBvmTs8KxiEC9YN6GI/weGpfV2bio8eYv0pdi0bpHFaZnZP2oePi6pGHd
         UXdBBbTyqU4sgR/CGvHODaYxkQJef+DuoH3d3laT/Vl8gZgygKlCWw3DxA2mQ30SICmD
         58jJlTOYwOfV+Di32Jvx4v9S5Apci9Gq/AKMv1CxqOt0ko8gEtDt+r/hmifxQGFWOJmi
         K7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfRb5S56BPBA0+cLXTQV+70i2hjJgSw3qjK6yqkpQmA=;
        b=1gbxHcOpRH5ZxbCiVKbvIGZa8FiVlbT+R17aFDgEk4oKM6yvULC6FJXjaWP9yyDclv
         XW4pIMq1GPlsrGeUWaVO1c1KBmZ+7U8sSH2jWsS/ZEqHFkVXEhO02CubuW7u+1IOGjdo
         EXXb42qy/w5CGUzuTLgTaAB8U0xm7b4RgkKMPrrdEYq2GBRstPPAaqaPUgRXJ8RoLxja
         0gDzP7iMNiVccpZROg/EcU2SRMzVhH9cBpjk1Q21ItW3mQio3cAV9GChq9L1pDMnua1a
         6sM+GtUnk1e/6Note6XkFHDlIL6QxjHC+TtEl6lWvoT/5lvY4D0XcaS+g9eikMYe6DF2
         8IDQ==
X-Gm-Message-State: AO0yUKXyBk5wseS3svFIgqSXRea0cO6kvECcZrizfIO+TPlAU4GV5aut
        8/0ZUwzjvzCMuwdTGY+XxSs7PFuZCPs=
X-Google-Smtp-Source: AK7set/s0xsnZw0bMDdW87f8QuGjZXhn+kDZ0PQ/l58nOv/yYpmY39+MpUlRUORbOu7xl8Q2KC3xmg==
X-Received: by 2002:a17:906:4c8e:b0:8af:447a:ff8e with SMTP id q14-20020a1709064c8e00b008af447aff8emr15131068eju.20.1678265074178;
        Wed, 08 Mar 2023 00:44:34 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906838800b008ee95ccfe06sm7163891ejx.119.2023.03.08.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:44:33 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Add optional properties to MAX17040
Date:   Wed,  8 Mar 2023 10:44:15 +0200
Message-Id: <20230308084419.11934-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend properties supported by max17040 fuel gauge with static
simple battery cell properties, some supplier properties (like
health and status) and thermal data from external sensor.

Svyatoslav Ryhel (4):
  dt-bindings: power: supply: maxim,max17040: update properties
  power: max17040: add simple battery cell support
  power: max17040: add passing props from supplier
  power: max17040: get thermal data from adc if available

 .../bindings/power/supply/maxim,max17040.yaml | 37 +++++++++++
 drivers/power/supply/max17040_battery.c       | 66 +++++++++++++++++++
 2 files changed, 103 insertions(+)

-- 
2.37.2

