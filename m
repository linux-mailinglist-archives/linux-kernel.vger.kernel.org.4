Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B89608D47
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJVM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJVM5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:57:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01AC22B38C;
        Sat, 22 Oct 2022 05:57:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z97so15312982ede.8;
        Sat, 22 Oct 2022 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=527bxp9h/jqaP6bCJj6qmuI38uc+kV9+b2ns/HCfZM8=;
        b=G6ngoJy0awMrBKvuw1h47s/rl8H0wPcmh4spCh/kMBZ2e+bHcBagxeNSzrhqVQ/Pjs
         rnuLGgZngqVL3/yMAcsXbNVLv/jbPRxXIbVjhHa7NZvZrjQig3Z+3n8QDqM90QSmxhu9
         4V8PtdORXhxasdAEVTH34Us65ggHldjnH2dntHIJw+22G3urNR6pe9GOz7LlfzTwLTSp
         g7G4jO/w1EtMPExUDLI7RBWZqUW76/FSJTF7KTPll83EqU/oVBhInJb3eULY7340wwpy
         2EWrIJYxfXtivs2mCCCjwtBVbYeSXcO34yw8gPsQc+k9MA2lSjpL19jo54OIUVl1xjPs
         jEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=527bxp9h/jqaP6bCJj6qmuI38uc+kV9+b2ns/HCfZM8=;
        b=kIAg3B50B9+sVFUSMSZXdZClRaOBeB4RCKi9/Z9YOBaJVQUzRlEtmgYc1dCu5YMW2V
         G/90IKu3HvIO+Mf05nMOrx1BEoi4OUpBTbD/mpXb55zQHd9JtiySrCtvyuES3zYP+79W
         e1OsHD+myoMpRjZPM7qJ2U4r2clgrcSF1YcYz6N678KX4o7n0z33BRGrBkavZqpVt4lv
         nmh0ciYkn0n/s78tCeQHMJDIa+rgOiqLpQXae7STvG6+YWhon35axpZl5qtN8W68pxT1
         cpgAXcDgQoQbqrsQKtDi366ZiFxvdgP+ZdDOIzvnYgGEWiM6XvfnWZqLCFlEWEFmHS0Y
         ZH0A==
X-Gm-Message-State: ACrzQf0h7EdfiKovQ742Nlzkh67CuPImuZkecHOY9DUONJGkTAAmGKrx
        aMZvRd6UQspNeyLvruMmGos=
X-Google-Smtp-Source: AMsMyM5+JIbx7OR2f6XLQo3O89li6hBkahzs9EsxHlhWypPUsw87KEtQT2iWwX5CDe1b9La5Fy0otw==
X-Received: by 2002:a05:6402:3223:b0:461:8635:e5c with SMTP id g35-20020a056402322300b0046186350e5cmr1580007eda.303.1666443428117;
        Sat, 22 Oct 2022 05:57:08 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id t29-20020a056402241d00b0045ce419ecffsm15173970eda.58.2022.10.22.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 05:57:07 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 0/3] thermal: qcom: tsens: small fixup for debugfs
Date:   Sat, 22 Oct 2022 14:56:54 +0200
Message-Id: <20221022125657.22530-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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

This is a small series to fixup some bug in how tsens init debufs.

The first patch just handle situation where tsens fails to register and
debugfs are getting registred anyway. When tsens is tried to reprobe
debugs will print a warning as the directory are already there.

The second patch is a fixup for wrong version when the ancient VER_0 is
used.

The third patch is a rework of debugfs structure moving version in the
tsens istance instead of ignoring any other tsens istance if it will
ever be the case in the future of having multiple tsens instance with
different version. It's just futureproof on it's own and also removed
one additional check.

changes v3:
- remove extra space from patch 1
- split patch 2 to 2 different patch
- patch 3 rework wrong debugfs structure
changes v2:
- Changed sob name to new one.

(the resend was actually v2 but i totally forgot that I sent it as v2 with
the sob name fixed... but everything should be good now...)

Christian Marangi (3):
  thermal: qcom: tsens: init debugfs only with successful probe
  thermal: qcom: tsens: fix wrong version id dbg_version_show
  thermal: qcom: tsens: rework debugfs file structure

 drivers/thermal/qcom/tsens.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

-- 
2.37.2

