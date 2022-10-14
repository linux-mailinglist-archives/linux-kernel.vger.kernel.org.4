Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6514B5FF3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiJNSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiJNSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:35:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D17D88A31;
        Fri, 14 Oct 2022 11:35:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so8896558wrr.3;
        Fri, 14 Oct 2022 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qOL/iKcZGPLu/1YRxFH9hlgpWjHigg9iXBISYd9lB4=;
        b=e025hcg0iYOrxQAl774n7xh8vRKmd9KfsoEuOsmX3LDK9MQueog38aWf2dKEvYhUn2
         Fk3PrYQDiH3xINDqo5RML+K9OERlJe7ksaHW92oZLjyh/7GeNX47+ajZ9aQfDy3qj7Ud
         uqKXOWuOpIXL9Es/3LXhb1fNiILo97cgmeYPK/eqx17iQ/jKysE1VWlX/hagQb2HUmTj
         ehwCn/nVqHpZoxC2Xws8JgjJHdwtVoJ6+H1waxTbQlHWIx1bxfdpztG8GuMseQdKrQ25
         SVIB4GYHqkuCLRsdvlAiuSYKo4mlmjgezBWrxxw+H3r1FRDj2B9hmih/YdkCW3jzGe/H
         JZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qOL/iKcZGPLu/1YRxFH9hlgpWjHigg9iXBISYd9lB4=;
        b=7YZBkkDmoqg5vQRV1Kxd56Bt0T5s0AQ4/U9AaevElTlbQodtIGewvLdryrEbXUn4KF
         xeLReCViyH093838CvxK/JOml57/xMxll/5GCVjl1NhUbAZ0thqR36WmKRoZyZnva5Xl
         zKHcUWygU9rCgcUkrMNiBHi8cUJE++eFLUT6WWyBlCdOutBRaOdEJdzh0RDw6TPBTgW2
         gG1EeiszuKHzIfoBL5JkGvTlVRTtUYb3LgRCJS7mIt3joTZKDAkiWPIN3q4VGOlAQjwx
         Bv6fMvYyjPR9OeGlIF3LD96IcTQdJxpnoEYRXP+TSRRA5gVFjIu2kAywRRUc3wCIfpMO
         CnQg==
X-Gm-Message-State: ACrzQf1L96YXDRoI1XR+pg46Yp37djed29XjImHnXYsoxzYIUIehqf39
        2ZfN1Jf8OfTz8hPwJohQ0Uc=
X-Google-Smtp-Source: AMsMyM6ZkTlq8cTLUDQguxpCM4KrLKdSs6H4upsg/TMc6Uv8hH1iz45uaLbdZpQxjxt5Xa3nEXtwqg==
X-Received: by 2002:adf:f5c5:0:b0:22e:264b:2179 with SMTP id k5-20020adff5c5000000b0022e264b2179mr4191486wrp.386.1665772516880;
        Fri, 14 Oct 2022 11:35:16 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc4d:6548:d8bd:5bd])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a403954c3sm2485410wrt.42.2022.10.14.11.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:35:15 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/5] media: i2c: ov5645 driver enhancements 
Date:   Fri, 14 Oct 2022 19:34:54 +0100
Message-Id: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

The main aim of this series is to add PM support to the sensor driver.

I had two more patches [0] and [1] which were for ov5645, so instead
sending them separately I have clubbed them as series.

v1-> v2
- patch #1 is infact a v3 [1] no changes
- patch #2 fixed review comments pointed by Sakari
- patch #3 [0] no changes 
- patches #4 and #5 are new

[0] https://patchwork.linuxtv.org/project/linux-media/patch/20220927202005.750621-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://patchwork.linuxtv.org/project/linux-media/patch/20220919153540.178732-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (5):
  media: dt-bindings: ov5645: Convert OV5645 binding to a schema
  media: i2c: ov5645: Use runtime PM
  media: i2c: ov5645: Drop empty comment
  media: i2c: ov5645: Return zero for s_stream(0)
  media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering
    the subdev

 .../devicetree/bindings/media/i2c/ov5645.txt  |  54 -------
 .../bindings/media/i2c/ovti,ov5645.yaml       | 104 ++++++++++++
 drivers/media/i2c/Kconfig                     |   2 +-
 drivers/media/i2c/ov5645.c                    | 151 +++++++++---------
 4 files changed, 178 insertions(+), 133 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645.yaml

-- 
2.25.1

