Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237A60968A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 23:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJWVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 17:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJWVc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 17:32:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672AB6686F;
        Sun, 23 Oct 2022 14:32:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i21so3745458edj.10;
        Sun, 23 Oct 2022 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWNT4BOOGAWE7uVudEYwnTe3rpuhF6dOOchvfrQLy74=;
        b=Q7kPkfdGXrGONHTdzye4zo66GjMfUh8yci08WliPZtByfTBpW7sb/X1xNd+JE4BrTH
         5X8clDt87K6hLaAjlZN7mPDO/3jt5rkDYFYDXKkkrGhW5VCRJe9eU+FXFo6tpmGVbYEY
         WlXCpE9srIVbQi8ccr3xnsRCC6a39CqLzInWf5Pldiu5t8Sbkh1rex+XqRnVY4sgSPT3
         wIlNSZsWFqKouhvBses0/SJYCyAvx0nizFz56cWzn4dQEzroyQIfNnyq3lWGTkslXEcj
         IiaF5bl21LD0CcW/XyUp0AAjnNj96pwKI3rjlvuwpGSpjIKM4my9Gt+sWK+lZIm/iCLY
         B6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWNT4BOOGAWE7uVudEYwnTe3rpuhF6dOOchvfrQLy74=;
        b=VoeXCVQxq3/+qHdq+TCYYLJlQzgDgteBnnc+sNiLEO3WZMia4FbfHKj79ltqstA1Z9
         Wzn1lvJ8AxdaWuUM4JY72sOV8229EJl6MQqEX65iK5TQpbINc5D2T8ymTA9aJlVCniMf
         YjCI4kuZaDkmBI+6hD/COcyyLwizm2FvUxXtgdhq3E0TneRZV+ApPFaki3ky5nwoXXpl
         LwvNIvdtVRCR8M+JVdF+VUkhdFvh4/dXrTgckbDScV8Kk3Xd8Ks4jm06txV5KLmih5oG
         4uP+om6Ye/Ml5UV/28KNY7x1xn2oSxcKSULpZMt4a6GRYLBguYSj9nmjtypboAAryqWc
         YFgw==
X-Gm-Message-State: ACrzQf0HXD7fqPV8xgcB5yOZRtNlZhrGpLOzkvN4Ih05HIN6uBULbZGx
        P9AacEWJIE4fsvqSoVc4rTGCt7JmICE=
X-Google-Smtp-Source: AMsMyM5k6bWCNbrI/K3ztKP63tQJCBnlYJzDFbYWC6hOuVJSlBTbwGotTrajIzBIGKzDgxLg4jiUjQ==
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr25139110ejb.438.1666560743780;
        Sun, 23 Oct 2022 14:32:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c10a-8500-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c10a:8500:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id p22-20020a056402045600b0044e01e2533asm17287454edw.43.2022.10.23.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 14:32:23 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 0/2] hwmon: (jc42) regmap conversion and resume fix
Date:   Sun, 23 Oct 2022 23:31:55 +0200
Message-Id: <20221023213157.11078-1-martin.blumenstingl@googlemail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a follow-up to the comments I got from Guenter on v1 of my patch
from [0] titled:
  "hwmon: (jc42) Restore the min/max/critical temperatures on resume"
There Guenter suggested: "The best solution would probably be to convert
the driver to use regmap and let regmap handle the caching". That's the
goal of this series - in addition to fixing the original resume issue
(see patch #3 - which was the reason for v1 of this series).

Guenter suggested:
> Make sure that the alarm bits are not dropped after reading the
> temperature (running the 'sensors' command with alarms active should
> do)
I configured the limits to be below the case temperature on my system
(as the jc42 sensor - a ST Microelectronics STTS2004 - is part of the
DIMMs) and ran sensors three times in a row. The output is the same for
all runs:
  temp1:       +35.0°C  (low  =  +0.0°C)            ALARM (HIGH, CRIT)
                        (high = +25.0°C, hyst = +25.0°C)
                        (crit = +30.0°C, hyst = +30.0°C)
My conclusion is that the alarm bit is not dropped after reading the
temperature.


Changes since v3 at [2]:
- re-add the update_lock mutex as Guenter spotted that it's still
  needed in jc42_write() - and later on we found out that jc42_read()
  also requires it (previously it was part of the now removed
  jc42_update_device()). This affects patch #1
- added Guenter's Reviewed-by to patch #2 (thank you!)

Changes since v2 at [1]:
- squashed patches #1, #2 and #4 into the new patch #1 (without any
  other changes to content in jc42.c)
- patch #3 has no changes other than it's numbering (see previous
  change)
- dropped RFC prefix

Changes since v1 at [0]:
- marked as RFC
- added patches for regmap (patch #1) and regcache (patch #2) conversion
- patch #3 has been updated to use regcache for restoring the register
  values during system resume (this was originally patch 1/1)
- added another patch to remove caching of the temperature register


[0] https://lore.kernel.org/linux-hwmon/20221019214108.220319-1-martin.blumenstingl@googlemail.com/
[1] https://lore.kernel.org/linux-hwmon/20221020210320.1624617-1-martin.blumenstingl@googlemail.com/
[2] https://lore.kernel.org/linux-hwmon/20221021165000.1865615-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (2):
  hwmon: (jc42) Convert register access and caching to regmap/regcache
  hwmon: (jc42) Restore the min/max/critical temperatures on resume

 drivers/hwmon/Kconfig |   1 +
 drivers/hwmon/jc42.c  | 243 ++++++++++++++++++++++++------------------
 2 files changed, 141 insertions(+), 103 deletions(-)

-- 
2.38.1

