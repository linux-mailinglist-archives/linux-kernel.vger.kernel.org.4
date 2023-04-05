Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69436D8AB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjDEWpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDEWpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:45:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCB4B0;
        Wed,  5 Apr 2023 15:45:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t10so144747306edd.12;
        Wed, 05 Apr 2023 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680734730; x=1683326730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lN2UOf7lGdFl2l+kAYg6tuaUcdYb0pcDJoziF1bC1zc=;
        b=BJF4bVjACD8rv6d1H5BoOtERf7zbyUMOwCPar/nhq75oD9GJn3DeC8tCunIwxtIxeY
         XpCDH1N9xhGrqFuAGmgkRuBYzKgGGXe/A98RIVMqFz748aaqEolqXbLv/DGdWfTw4OLr
         Kvzgdi+HIQdJWj8aBgxRKJAv/YHq5iQwy6xWn6eTIl+nEMU06obsA4mQ2lgodIjy9zjY
         MtdidHROpIUWUfJ0YA8hFqMD9YVkG8h9UyYejwDL5VPaCjGvh9SJ0ULXKEXfbJvcg4MU
         t6jFzb7L0XleKhydZ6I+xWoB2KwSgfGldgrNHDJnMUSN0qRifoCuxD8Gw1Ib9oPAS2pw
         bBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680734730; x=1683326730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN2UOf7lGdFl2l+kAYg6tuaUcdYb0pcDJoziF1bC1zc=;
        b=EkugsCcfQfcq3krJuS/lpwR+O/GdMehXlFuU3YUjJlLqXHIG4J0biUDHd5ZRYCqjjh
         6mW81kmYwrXsr5ZnbKtv+NWHkyI4C5B6q9lEvQxrCrctXrgdxR1gUuKKa9ql8jjUJvsX
         BPPxsuy/5mYZ5A0UFc03bYcERzZTUFrG9WFA+sshTrAlJQ5xcifmYs5jv3Fc8LErVRkE
         q+MK64kzBrXlX7JSYY/jC9NJ4AB/hU1G8OZES/OtMaULLSIAqZwrVupOYJ8i+HorxTzd
         ExW6xDjYogt+pmDGa0QQVZcBhqhhFPJiwN/Tdf++vPut+0FcDfgYxLIo8RMpLlWzYjP9
         R/eA==
X-Gm-Message-State: AAQBX9es0XCrP3Mens6d5p6bV1xTwv052CHRqZq4GUwp+pfTPxf6R/LR
        KdKw+pubYb68cky+yRP0Ewo=
X-Google-Smtp-Source: AKy350bZqYFKKMPkeVsuSgbW9WXxE+WpixlDYiFjMCTx2aNtnJiM0jvfFNLPYOqR8zQy5BHAoy/CLA==
X-Received: by 2002:a17:907:d603:b0:931:af6a:ad08 with SMTP id wd3-20020a170907d60300b00931af6aad08mr4813359ejc.57.1680734729389;
        Wed, 05 Apr 2023 15:45:29 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f2cac00f0c38d0eb7c148d4.dip0.t-ipconnect.de. [2003:cf:9f2c:ac00:f0c3:8d0e:b7c1:48d4])
        by smtp.googlemail.com with ESMTPSA id h3-20020a1709067cc300b0094776b4ef04sm8091868ejp.10.2023.04.05.15.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:45:28 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] (asus-ec-sensors) add two more boards
Date:   Thu,  6 Apr 2023 00:43:37 +0200
Message-Id: <20230405224339.358675-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds sensor definitions for two more boards, provided and tested by
users using this driver or Libre Hardware Monitor.

Eugene Shalygin (1):
  hwmon: (asus-ec-sensors) add ROG STRIX Z390-F GAMING

fireflame90051 (1):
  hwmon: (asus-ec-sensors) add ProArt B550-Creator

 Documentation/hwmon/asus_ec_sensors.rst |  2 ++
 drivers/hwmon/asus-ec-sensors.c         | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.40.0

