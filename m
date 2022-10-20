Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D32D606A00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJTVDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJTVDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:03:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FEB220FBD;
        Thu, 20 Oct 2022 14:03:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e18so1425199edj.3;
        Thu, 20 Oct 2022 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGFCobZRK7q8Le6wQKMOqtMW4v64gOHn4YBe4dY8Rdo=;
        b=XPZK2WYue5gnubN05fUFxAcbiuJgDs85JHmdo5kUvk5/+vh72a9xG7RXtlsyBU3YgL
         xknfLOF9ziAvdpW8IxovNRQGAx1zNxqJqWFbRMPEOcBD1lb3p1tDQQATeGTX2sCIEdSp
         c7uIAp6fjgPfEZIrcDXFK+BxZz/3yuL41NR6Xj5JzZC477GLcdfgjHWjDqsHd212eMDX
         OkvlrL7RyVVDA0W+czNBQHP0KKjBpErc9MTElGozmNrirLeiCA03OtWkrdlpqYKYlyPw
         TAy0dN2LIX5pHEGiKLdrnfvtwEOj9DtmZINKSAyW2qWv9R+QWJ7AdYasFSkDQgctOVGH
         BMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGFCobZRK7q8Le6wQKMOqtMW4v64gOHn4YBe4dY8Rdo=;
        b=zCxJS61M+qfIOyLBek8T0LRa03yWHfm5R4rCThnvHmd6KdOiN2Xni0WrvuwAg3EOgj
         8SogHAMCr2TKFKyNnAnuWtXUBOu4Y2hJtr6vCFUdkaqJBpVPTBj33Q9Q8O6ZquWz/EIh
         Di6JbKYsWWONKKJZ25fDEsWHPuH2lsrLbqRYmRLWwQ6ldg3JHuy7tlKm11SFJtOoT6/A
         quldqosK/fCVXcWyjKq4JjBcaHEa3yrZxCAI9bensNJ00jkROMSz0O7Wdf6lmeqcHPwM
         D5yS9NEhvsI8k+CV3QqllI4nUCG+H+jEWPOxupbAuzTn1EgjsfNttQ8gHhONdPmbSnVg
         EjuQ==
X-Gm-Message-State: ACrzQf3e7wOhee0j/ic/Mc7T7EpmzDlastwKMORgZ2SUBBXyAZnIjvF7
        wADoohqK9tH4hJq+HO64xymCQiCKglw=
X-Google-Smtp-Source: AMsMyM4AqnW8yvTiuC9PRDsF40dDPSAbqFhouYFbO2pvmVivrxp+RftjqWCjSr8xB3BiAwMbYjWKvg==
X-Received: by 2002:a05:6402:350f:b0:45d:1d86:9ec9 with SMTP id b15-20020a056402350f00b0045d1d869ec9mr14264393edd.266.1666299821799;
        Thu, 20 Oct 2022 14:03:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c046-3500-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c046:3500::e63])
        by smtp.googlemail.com with ESMTPSA id 18-20020a170906211200b00779cde476e4sm10748721ejt.62.2022.10.20.14.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:03:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v2 0/4] hwmon: (jc42) regmap conversion and resume fix
Date:   Thu, 20 Oct 2022 23:03:16 +0200
Message-Id: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

Changes since v1 at [0]:
- marked as RFC
- added patches for regmap (patch #1) and regcache (patch #2) conversion
- patch #3 has been updated to use regcache for restoring the register
  values during system resume (this was originally patch 1/1)
- added another patch to remove caching of the temperature register


[0] https://lore.kernel.org/linux-hwmon/20221019214108.220319-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (4):
  hwmon: (jc42) Convert register access to use an I2C regmap
  hwmon: (jc42) Convert to regmap's built-in caching
  hwmon: (jc42) Restore the min/max/critical temperatures on resume
  hwmon: (jc42) Don't cache the temperature register

 drivers/hwmon/Kconfig |   1 +
 drivers/hwmon/jc42.c  | 224 +++++++++++++++++++++++-------------------
 2 files changed, 125 insertions(+), 100 deletions(-)

-- 
2.38.1

