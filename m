Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED815B3C71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiIIPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiIIPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:54:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745F3D5A3;
        Fri,  9 Sep 2022 08:54:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j26so1687983wms.0;
        Fri, 09 Sep 2022 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uyMjfznNOpNPxWagrUNcrwqKII8tmK8TKoBawS5U084=;
        b=jmc6McaEP1oCCq61s4ws5JNmsyICorcvr8GDT+FYEJQz9xWPrGgjIgCRbHqLh/tIQt
         /o2u4+QcH2xeoSHVQW6a1ewtkHv1b6CHOjifYlfNeCARp8W0g7URUHC9obgvqXYfdeC4
         lo6hNV87bOiiGu25Hy5Jp4YFw/p1KX/WntFZxapzDToslPYBpS9ayLQv66zMY9T8ZUw0
         3NtPhXJNN2Kop8ayjb+e7WT1iBXFMglwWHLuAkBMOsyutbwLZPcE2o0GtMitYmJAgamU
         e80OcITxpO5NcnV3KWMITy8kIqt+3OMtDUy8K0aDT1tTTH47NoUPyyv0IyAeOf1Tapnv
         LFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uyMjfznNOpNPxWagrUNcrwqKII8tmK8TKoBawS5U084=;
        b=k/AgIDwVPtqR+XGpD5S87S4AVH5hXgNmvpiWXI4tivLnk//722CBu1X/6/z7Nsgtdi
         gpjap3wPk9OWS3VFIgO6pbNvWtiWhnDrp3hVSJpelYigONuLCbsQQvIFuFPhYE9XCU58
         e+W9wyictcIKIjUQeQe9OOMxqOXyAS9+ClZPN6uCXg9VniYLPuf/3NLXIYg6RUVkUXFF
         SoIcVz33WiGuF2UVpupO2fCFSVqARci3DCX7JoGlnQhk0HQPf5HtsnM1YDwiJgBXbRvU
         /DhIIO69plbmlzWLiIELdm4Hsb1b83QDX5VfSZeLPRsYUtLgX4mWPWh45Bytup90cS8u
         9jow==
X-Gm-Message-State: ACgBeo3u9mAB3q1efTiBljyk3LLB+QBlLw1sAvGt5QjMNU0EJYmoTCbN
        7fOuPesOaU+dbzvE8ujA23bFJ9ptnIG/fw==
X-Google-Smtp-Source: AA6agR6DzmYyVQN8CRqgSAPIXNCX+vblUXfMDedZ5Mswl45An9UPSrvplR8AlTDyrMOzOgOQfPVjuQ==
X-Received: by 2002:a05:600c:a4d:b0:3a6:6dd3:1857 with SMTP id c13-20020a05600c0a4d00b003a66dd31857mr6101353wmq.110.1662738891825;
        Fri, 09 Sep 2022 08:54:51 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f3f2f002177673bc12404e5.dip0.t-ipconnect.de. [2003:cf:9f3f:2f00:2177:673b:c124:4e5])
        by smtp.googlemail.com with ESMTPSA id i13-20020a05600c354d00b003a5c1e916c8sm173652wmq.1.2022.09.09.08.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:54:51 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] hwmon: (asus-ec-sensors) autoload module via DMI data
Date:   Fri,  9 Sep 2022 17:54:45 +0200
Message-Id: <20220909155446.122937-1-eugene.shalygin@gmail.com>
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

Changes in v2: remove the clenaup_device function

Eugene Shalygin (1):
  hwmon: (asus-ec-sensors) autoload module via DMI data

 drivers/hwmon/asus-ec-sensors.c | 413 ++++++++++++++++++--------------
 1 file changed, 227 insertions(+), 186 deletions(-)

-- 
2.37.3

