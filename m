Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71066E8309
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDSVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjDSVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:08:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E11961BE;
        Wed, 19 Apr 2023 14:08:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso2769649wmo.0;
        Wed, 19 Apr 2023 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681938494; x=1684530494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hKavX6galpUw3m8pjNHJAGofqqTil5bnA94vuO7DqA=;
        b=NDFyOEJPl/51+YYFqyOkBgZKjTCR3wPUDyaVN/Ru9RzFucqvwRc9HKxNXsP/EIYZfI
         fQqnUeiuJ15yHuNghA0OllKU33BbPqV5po5S+8/xKLi0RbO6gzV/AysijkCFpxPuwnsQ
         sY17N9n4TV3vfFYGwNYEuVGkSBrxHNaeXbTsstSYfaj6TXksmb++rw7+jT2IhPE796bF
         fWGesTnLTsM6lPTyMO23+TJKzqJ/Wrm0igYDfjV7X6uB5eDoREDQ3Div50JkusM7uStS
         h1iq5DCKlVo5PEbDWyBGHuJRst78vvk0rvDfW7dBIOIfRUS5R3xYmXbKDb6mKc1qVsuM
         0zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938494; x=1684530494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hKavX6galpUw3m8pjNHJAGofqqTil5bnA94vuO7DqA=;
        b=Jh6TjEzDPwEfg6BpBzIkFxvgVsekzJsWnZigk1ipncVFkQZk7G/gUJingOq3621EO5
         9TP/tRPjzuy/XjQPaRK5ElOcRVeuEGMEV6Zwo8aw5IblbwDtlMBAjxk1ocRwAtGCpDXQ
         /ySpFI0agEHipr4gHos1ZFHUHeE4Jl8ds6hnUunsTxFqitLY09MqIcMxAXQvWLY+If94
         7ZPHQP5WeUg96Jcshc9ubZZ/lCqFCoKIDrri8vyNlkaBJd1dcq/lgYc8Hw+/Ezx02LI8
         iZ/q0X0E0q4DSFvysB9zqqiCrg1sPEpVSmu9/qPZVNzgV6uKSynoEjkuSilbJeY1L62I
         dXqg==
X-Gm-Message-State: AAQBX9dlXveHZgxvUEnwQFq3+iSS4Xbi5YifvQCPtQQ0v9hzGa22OB5b
        bjuD/0yjw777Uj0QVcz7U6A=
X-Google-Smtp-Source: AKy350aXzBzXaBqYHErmjat8ng5mULX8rNlKT+FVMAxugo7/Jbj11yWOl/A2C3Zsh6kJmbLmb7cJhQ==
X-Received: by 2002:a1c:7207:0:b0:3f1:72fb:461a with SMTP id n7-20020a1c7207000000b003f172fb461amr10046696wmc.2.1681938494445;
        Wed, 19 Apr 2023 14:08:14 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id g3-20020a5d5543000000b002fe254f6c33sm81295wrw.92.2023.04.19.14.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:08:14 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 0/5] leds: trigger: netdev: fixup preparation for LEDs hw control
Date:   Wed, 19 Apr 2023 23:07:38 +0200
Message-Id: <20230419210743.3594-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This is a continue of [1]. It was decided to take a more gradual
approach to implement LEDs support for switch and phy starting with
basic support and then implementing the hw control part when we have all
the prereq done.

This is a small series in preparation for a bigger change adding support
for LEDs hw control.

Some minor fixup and improvements are required to add support for LEDs hw
control for the netdev trigger.

The main fixes are switching to mutex from spinlocks and adding namespace
to netdev trigger enum modes. These will be exposed in the future in the
generic linux include folder so LEDs driver may supports these specific
modes.

While working on htis it was also discovered a bug addressed in the first
patch of this series.

Changes from the old v8 series:
- Reword some commits and add more info on why the changes is needed
- Add fixup patch on dev rename

Christian Marangi (5):
  leds: trigger: netdev: recheck NETDEV_LED_MODE_LINKUP on dev rename
  leds: trigger: netdev: drop NETDEV_LED_MODE_LINKUP from mode
  leds: trigger: netdev: rename add namespace to netdev trigger enum
    modes
  leds: trigger: netdev: convert device attr to macro
  leds: trigger: netdev: use mutex instead of spinlocks

 drivers/leds/trigger/ledtrig-netdev.c | 151 ++++++++++----------------
 1 file changed, 59 insertions(+), 92 deletions(-)

-- 
2.39.2

