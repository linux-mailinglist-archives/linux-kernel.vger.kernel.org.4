Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1525B3C76
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIIP5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIIP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:57:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBDF11B002;
        Fri,  9 Sep 2022 08:56:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t14so3508329wrx.8;
        Fri, 09 Sep 2022 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=G2jlpaqhltglJo8X4ZONxeMLeWiD8GSlqUmUdf817uc=;
        b=GJBLLhiixxZWsyYslMBQLvMTQGpDqmuCItJZkX9ZovccfDzd9Y7M8hKDWURkx8zcX+
         C/OUQu1SH4cz+zSZvVGi0kXOvhdBq/DN3tmRWmWs8ObDPT42kK+/ZJu8/TZ4A2NJzLqC
         hN/XD9SynOh6UMmBTWCx9gywYEOmbTKBKTybpGoFfGK8lXY7gCkwLf3rIV7BIS587hw2
         /AoRYn/KYAvHMTWuwYp3JJTu3sTt06S9EXiG1suUfWdxqLmrO3tetCAyk+6RJF04MZf6
         CXVdorAsgw8jwOwU4CSwe+jU9/PwaF3wZWFjQzLvTNNSc9qYslgYLWAJUarG6xkLHQgx
         arxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=G2jlpaqhltglJo8X4ZONxeMLeWiD8GSlqUmUdf817uc=;
        b=A+8F75yMPwNV8du02V+kk0dIkSxr/jm/8a/oqUdUZ8OmmLxq+Yqei3F8X9ViAMQs9m
         DaKtnTS4l5qhKatBLgjEEGtKkf940lCcSlEdasM58OUviyicteD6/MgsA44Z26+O+Xbr
         fjOua2psXHIbjdCzpnOLF6xZA6LpxoktCtGjGrK3zXgl8koJFuogt50w5DoTLeuEk75c
         NFbPeROFtpXaD+F2QGOpFOKcQty9GJSYnAP3ZgZxb0mBPbJSDcLXmmjZDk2xldiXsJS3
         kFfCE2s2hnuaXIjyzwmYsJg45EU00XzwFtmi0BJknJqUiA+iBf9eZZLtgDZoMj6g3+hU
         sTTQ==
X-Gm-Message-State: ACgBeo1TFkWOMkVVXnYrvsdN+TATMFAF018AhhoGYSqpPj6mWYfKgrJD
        YVtYlExChm6RLMs4xNMDAsY=
X-Google-Smtp-Source: AA6agR4PLqnFJyYnTo1W6HxCxNL5GTEqb2mzYTDc8WdwArGHL0AFqwBA8Y5js/iqaQII9d2EBcHSmg==
X-Received: by 2002:a05:6000:178e:b0:220:635f:eb13 with SMTP id e14-20020a056000178e00b00220635feb13mr8427040wrg.634.1662739017382;
        Fri, 09 Sep 2022 08:56:57 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f3f2f002177673bc12404e5.dip0.t-ipconnect.de. [2003:cf:9f3f:2f00:2177:673b:c124:4e5])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c1c0800b003a319b67f64sm155801wms.0.2022.09.09.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:56:56 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] hwmon: (asus-ec-sensors) autoload module via DMI data
Date:   Fri,  9 Sep 2022 17:56:52 +0200
Message-Id: <20220909155654.123398-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Changes in v3: actually remove the clenaup_device function

Eugene Shalygin (1):
  hwmon: (asus-ec-sensors) autoload module via DMI data

 drivers/hwmon/asus-ec-sensors.c | 408 +++++++++++++++++---------------
 1 file changed, 222 insertions(+), 186 deletions(-)

-- 
2.37.3

