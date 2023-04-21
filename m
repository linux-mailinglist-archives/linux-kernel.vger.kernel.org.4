Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE546EA6A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjDUJNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDUJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:13:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8171E119
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:13:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94f7a0818aeso184430066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682068398; x=1684660398;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GDGviXm56iw0H7024sVpY4RPcdWW661P1mE6dj5J4M=;
        b=e2wH4ZLNbzuwfwD2s6evo30QlJoE3zm41aiOGGQpV1Gw8KK2hfnVJAYFE6r9GQqI0p
         tNkupzQuvbQ9D1my7s6PCwOvlOsMnct+HZaw6tsJba/NDdk8iBBFuPHss1t1UvqsZRyR
         mMu6TAE8MKPgzeg+HexYkKFZxlJD2GuPVlIy84DRhpgJ1PzbrNN1lVFbDGiePqOjw7ov
         xxSJk4adEej07B79rHrFCcbMFZ4agPy1sFQYCZIpeoY+tJnQldMFhr1RdhhTh4S7Zr01
         3FTVG+WjJapdQpo7Xom3THwDGQ8cNJ/EfriE3CdXYxSBVC8PrMd6jbdJD50LwJEzBZeN
         j0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682068398; x=1684660398;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GDGviXm56iw0H7024sVpY4RPcdWW661P1mE6dj5J4M=;
        b=lTaZn1sBZUhCjlj7kJ7BogZxwiHJCqwSSJ+Ukz0MwXJbmIkRPSh6l7ADTAk/vq9IBp
         kf6IdtY9bJjC417HjpCKfvap3PTJ3skfxmNKuIEpuaAPSzE6HLHFujEoicods7dwuBAq
         JPEqzlHwG5JtNrPfg9qgnRKDntBw7jW4cZbT9eKep9xcl1SccZtRsBFzxP/zJy/wAhcM
         /YmtEAiQplixr13iV7CXUeVVxaf2D3G+vjJ1AkCFTz8+ls8wMRcJUkQPPj8z7C8Q0Vw0
         8ptvxpX0WqygRV8gElH7O5v21InxDnLIMx+5X86lvNt5EKRj/H8fCk5XnPzGk30PHxzS
         Wytg==
X-Gm-Message-State: AAQBX9cAB/3CDAYvw0dEHaMJ+4c/O6KFb5moMGwde694PmCfh7xIi0R6
        LHHeePZnvMBMdCHrAdhDA97KgimzFa0m+ouT
X-Google-Smtp-Source: AKy350buCLnS7EQtpHhcjIi/BvVY6ZbSHpOlHHT3R9Dlih0LQ1HIIXJ2L3sbEsDwXZFJTJbajME83w==
X-Received: by 2002:a17:906:b2d7:b0:94a:5a9e:9da0 with SMTP id cf23-20020a170906b2d700b0094a5a9e9da0mr1383067ejb.77.1682068397567;
        Fri, 21 Apr 2023 02:13:17 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id lc21-20020a170906dff500b0094ef10eceb3sm1766775ejc.185.2023.04.21.02.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:13:17 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH RFC v2 0/2] regulator: dynamic voltage monitoring support
Date:   Fri, 21 Apr 2023 11:13:05 +0200
Message-Id: <20230419-dynamic-vmon-v2-0-c303bcc75ebc@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKFTQmQC/22NQQqDMBBFryKzbkqigrGrQqEH6La4GJOxDsWkJ
 BIq4t0bXXf5/ufxVogUmCJcihUCJY7sXYbyVIAZ0b1IsM0MpSwrWatW2MXhxEakyTtBUltEiaZ
 BC1npMZLoAzoz7tKEcaawH59AA3+PzhMe9xt0eRw5zj4sRzup4/qfSUpIMdS6b+pKk27VNb7Z4
 oxn4yfotm37AfGte6HIAAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, support.opensource@diasemi.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series targets the "automatic" state handling of voltage monitors
when the state of the monitored regulator is changed. This is e.g.
necessary for the da9063, which reaches an invalid state (!PWR_OK) if
the voltage monitor is not disabled before the regulator is disabled.
The problem could also be tackled inside of the driver's "state change
ops" (.enable(), .disable(), ...) but I thought it might be a good idea
to have a "common framework" independent of the driver's implementation.

For now, 1/2 adds "disable monitor properties" to the regulator's desc,
which indicate on which actions the monitors should be disabled.
2/2 depends on [1], which implements (static) voltage monitoring for the
da9063. It disables the monitors while the regulator is disabled.

The monitors are only enabled after the ramp-delay, to ensure that the
regulator is already in a valid state.

Possible next step:
"regulators-{uv,ov}-{warn,error,protection}-enable" dt property on chip
level, with either 1 or 0, to en-/disable the dynamic voltage monitoring
for every regulator of the chip. This would require the regulator's
set_{over,under}_voltage_protection() to work with limit = 1.

I added some TODOs (basically about error handling) and still have to do
some testing, but I wanted to share the "direction" of this series,
therefore the v2. Thank you, Mark and Matti, for the input!

Thanks & best regards,
Benjamin

[1] https://lore.kernel.org/all/20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com/

---
Changes in v2:
1/2:
- move from board-specific (machine.h) to driver-specific (driver.h)
- move from own struct to fields/properties in regulator_desc
- handle modes as one "unsupported modes" field
- factor out new monitors_set_state() to handle all (activated) monitors
- move re-enabling of monitor after ramp-delay
- add TODOs for error handling when the action fails (return error from
  actual action instead, return state of monitoring to pre-action).
- reword commit message
2/2:
- adapting change to the properties approach

Link to v1: https://lore.kernel.org/r/20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com

---
Benjamin Bara (2):
      regulator: add properties to disable monitoring on actions
      regulator: da9063: disable monitoring while regulator is off

 drivers/regulator/core.c             | 64 ++++++++++++++++++++++++++++++++----
 drivers/regulator/da9063-regulator.c |  2 ++
 include/linux/regulator/driver.h     | 10 ++++++
 3 files changed, 70 insertions(+), 6 deletions(-)
---
base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
change-id: 20230419-dynamic-vmon-e08daa0ac7ad

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

