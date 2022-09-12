Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F225B6178
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiILTIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiILTIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:08:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC14C40E14;
        Mon, 12 Sep 2022 12:07:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 9so9456870plj.11;
        Mon, 12 Sep 2022 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FYc5EwH0KQpfNQpM5d+qJ8z1AkyVy1Re6j4wAitrwAQ=;
        b=ltfuiJO9BuHLekRBx3DmD7S111RX/Cw9kLukv3el2W3WwIME9q6Q6EzjdtvjVc0KUP
         poryHmCnU+syf9RPAicglI5xtYp67ZfY7bCxrgDLRclHrU2VtD7j1s0sdgvZkQwu2UBF
         ahMi2tvDMw0WNcEUgpxrNcNcH03L2j/+dRSd+WF5rmBX1pNZUdwHn9h33FKcjS4OAsae
         lV+CVSBVmHsT/H3WUFz8g+V+4N29OQbWRG63rOBAEJ8bdjlpxiG7zdAAUaUXqqPBFCMJ
         gj6gg7r3ClcWNUSoYQIAzLtb/HG6Ynw/G6czrBSRMl3IRFVPNsr28pfmgldg4lP4jHs0
         Eunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FYc5EwH0KQpfNQpM5d+qJ8z1AkyVy1Re6j4wAitrwAQ=;
        b=nLXJuEe6kPq/Kb8G0E1Hjct+2KKmUNf1mLj59+PWxX0EP8UPzFkzr48u21L5vTXOka
         GMKfuOETnAsT9bVAsnaYMM09Un2s6Rx14oJG3OeDQASW97RzwvYy28pz8pNxSgidGToW
         wKh6DhM5i56edMQzwKF3eXrzcH4tWOVPJ3eb62idO6eeRXw5DNA981R4C4uBwlBk2M7l
         +9pov4aIy1jZVGXIqb/trwJCaxDxl2+Fz3ttIU1weXdcdClEX/zTbvY1szjCnmdPaBC9
         rDMJOG2sQVr6nAlcK9sgKTiyNoXbaPxeY1syIENaUrwK+NlqcWfJ84b+ytxA23GDt2y7
         1Rqg==
X-Gm-Message-State: ACgBeo0P5lVD37R+64DFQDFG//oAi+ow6I0zKf91zkCrEAxkKQ4zJiPg
        47UozM/J2s8SmkwBg1P1MPzld727k6c=
X-Google-Smtp-Source: AA6agR56TUx4JeDfOWVoKwc6pvTmFqGTKDfm0TapcOckbl39FwCOPSxLuv6RTr9KuyntHTPEXknxFw==
X-Received: by 2002:a17:90b:17c3:b0:202:bc13:e4e7 with SMTP id me3-20020a17090b17c300b00202bc13e4e7mr10730056pjb.125.1663009679138;
        Mon, 12 Sep 2022 12:07:59 -0700 (PDT)
Received: from localhost.localdomain ([116.73.241.66])
        by smtp.gmail.com with ESMTPSA id 68-20020a630547000000b00434272fe870sm1091889pgf.88.2022.09.12.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:07:58 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jagathjog1996@gmail.com
Subject: [PATCH v2 0/2] rtc: maxim: add support for Maxim max31329 RTC
Date:   Tue, 13 Sep 2022 00:37:51 +0530
Message-Id: <20220912190753.10158-1-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver and device tree bindings support for Maxim max31329 real
time clock.

Changes since v1.
1. Move 'allOf' after 'maintainers' in DT.
2. Add 'wakeup-source' into device tree bindings.
3. Add wakeup support depending on the 'wakeup-source' parameter from DT. 
4. Remove unused 'dev' member from device private data structure.
5. Use '__maybe_unused' attribute for of_device_id table.
6. Initialize local variable 'events' to 0 in interrupt handler.
Reported-by: kernel test robot <lkp@intel.com>
7. Add Reviewed-by tag for device tree bindings.

Jagath Jog J (2):
  dt-bindings: rtc: add Maxim max31329 rtc device tree bindings
  rtc: maxim: Add Maxim max31329 real time clock

 .../bindings/rtc/maxim,max31329.yaml          |  61 ++
 MAINTAINERS                                   |   7 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-max31329.c                    | 535 ++++++++++++++++++
 5 files changed, 614 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
 create mode 100644 drivers/rtc/rtc-max31329.c

-- 
2.17.1

