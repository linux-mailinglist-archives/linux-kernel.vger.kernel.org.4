Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3C6765EE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjAULRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAULRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:17:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B02D48;
        Sat, 21 Jan 2023 03:17:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z5so6897265wrt.6;
        Sat, 21 Jan 2023 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLa4ApFcncnm2fqSaC6+/SpHG+B9HfQscU4QZJ2qqg4=;
        b=KTKsVxxiZfAQ3P6tVJLhgNSBVrrWnXYEMT8tbapPBc+HsG/L14FMuKbZOYuO6k2Wo1
         udoHZGudeDnExZQ4AcYbsD7h85i4ryyyzxB94RalamZ+dxF1ohniFawJf9Q++1I1wgsE
         WdATaIDmMiLxAL3MNpdiKoW0xRLDSc19FH4GJYF8WdUe0vUqLfH0H2RaD9beOrsIK5pI
         0erwhUXaq5uk6LXgbIFcKfAsCGOjuhV8zMbNvsXzTBo71eaZboaPQ0BnOS+MqmFanpu8
         f2TZeJ56ke75SbBIqgqqot1oFaBqP9PYc6fcOCR8l7lS7YISN1EOoWZj7S87KxlQkDTg
         rmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLa4ApFcncnm2fqSaC6+/SpHG+B9HfQscU4QZJ2qqg4=;
        b=KoJU9Qo+EzVxin7u+GdklQhNs+AgOQFJeh44Sq7vzU1qRRShjxmVJdwo7z2ahTdpcm
         Boi6sK/JHF7HPLn7ltPEGEuMF0VyDmbPTPrZqdqR6WgJjEAanAGo+vNCD8uIeG7hP8nY
         Fe35q7HwsZJC34TNsdQhHPZCARP1Z9b5iIyE2cTJ+RHevkioKUIeaByw+O5RVKFWsDIS
         puue1Kvznst+lHgJLM5eXHxrcnwZnO97WYzt0/5rQYyWiP2jpS2mZX7/BXi0N7PMo+3r
         +fKBCrq/lSChpbFj/CNihK2qHzEMFzCI+0spC+zj7xts9j5vq5fLHWauUW/F0RPO3igm
         zJRg==
X-Gm-Message-State: AFqh2kpHSVKZPU5xciJO/pk8d+oXzOGgK7NzTnKsz0iXGeeN6v96zhbo
        ISzZYMOFKH4dfpXDcXK5PA2ST4J03vWeEQ==
X-Google-Smtp-Source: AMrXdXsRk9hwAJ3cStVhwVQqUEATkw0Pj0V9NSNT8+LcsOJ07nNoG4pRDqM+R3Pfe983QUDbpBc4Nw==
X-Received: by 2002:a5d:5d8a:0:b0:2be:3ccd:7f35 with SMTP id ci10-20020a5d5d8a000000b002be3ccd7f35mr9527757wrb.34.1674299865132;
        Sat, 21 Jan 2023 03:17:45 -0800 (PST)
Received: from caracal.museclub.art (p200300cf9f4f4d002fdc57d9d2f68d31.dip0.t-ipconnect.de. [2003:cf:9f4f:4d00:2fdc:57d9:d2f6:8d31])
        by smtp.googlemail.com with ESMTPSA id w8-20020adf8bc8000000b002bdc39849d1sm26139795wra.44.2023.01.21.03.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:17:44 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] hwmon: (asus-ec-sensors) add missing mutex path
Date:   Sat, 21 Jan 2023 12:17:27 +0100
Message-Id: <20230121111728.168514-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.39.0
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

The board definition for ProArt X570-CREATOR WIFI misses the mutex path,
and because ofthe the driver can not be loaded:

asus-ec-sensors asus-ec-sensors: Hardware access guard mutex name is empty
asus-ec-sensors asus-ec-sensors: Failed to setup state/EC locking: -22
asus-ec-sensors: probe of asus-ec-sensors failed with error -22

The issue was pointed out in a comment at GitHub [1]

[1] https://github.com/zeule/asus-ec-sensors/issues/17#issuecomment-1399174059

Eugene Shalygin (1):
  hwmon: (asus-ec-sensors) add missing mutex path

 drivers/hwmon/asus-ec-sensors.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.39.0

