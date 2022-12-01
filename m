Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A063F758
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiLASQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiLASPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:15:48 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC9C06
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:15:44 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id h10so1880523qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPoSscocgW7JDIUXs9rfd3TYBr11h3l8OCCMgzWgJRY=;
        b=TZDj2d8tvXXmDQK/6vnsdgY24qoKuUwAVkOzLCVy2qs/nTid9C8wcnXc6X3qxqsilT
         aikVp+L05JEUnK/W0P7kOsWcpVj+FlcsKko3ovSj5o5G8tsma/PPXAKPVqjdUcYhbfw8
         wSNnm3CudEXCiEf7rt0ktJHRGKq3BToB4tAxjpJ8QKWMf/f0FiQIlbRJK/1NzbcAUUjm
         11EAd//5LdRoMI5IstMm0pNPL+ecGLnZ19kXq0aiwjKXlhVhVyW20VM5YY8iHk4v++O5
         mgEkhHTzGLHf9oSIa7sGvwC5WU9PETQvxA6MIHcj1T4GE5GTpaqIqQFxFBCn/lELTIUS
         1EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPoSscocgW7JDIUXs9rfd3TYBr11h3l8OCCMgzWgJRY=;
        b=Aoo1CxXoX6iihV90O/zK/ZCDtuZ7CWzyrahOd99hyC9LU8pR8sL+PuexI+2yauIAFR
         4KnxERxCLW1hQFQNfr/VFonmH3G5lck5eMhwtc/jFvf9pD+GQHbJyk1sK5hB7Vqgffv4
         WgrbnAZ00O9bBiTTBPb0Gmepxx8DyE2OyNsFe1+Hoi7rLX3q0/50hdM4JuwFiUcxRU8n
         HB6q9+b35jdkneWQrrTWEw1/g/2rlTW45lSJCv5wMNcBV7tpaQA3kcLcJOGAxtMiKiEg
         JEtquPVdHju6Fsh26F8VzmIQ2h3eDGRUrhnBje7L55KDWEzDVv9UfNgcwmGDxTnDw8Su
         MTqA==
X-Gm-Message-State: ANoB5pkJQMFV0FjcPGoZXkyGjy4GYQyOIVGxG0OcJfjNamANPQOdFL/n
        RI48xdjzIWZ+iWpQgvSgDIuo6g==
X-Google-Smtp-Source: AA0mqf7S9uF2secA2rtBk3MmlmF6Eyn41U5P0o1gc0zdV5JrdzrMofYWNlaru2vpeImzlpsm0QT/DA==
X-Received: by 2002:ad4:5768:0:b0:4bb:728e:b232 with SMTP id r8-20020ad45768000000b004bb728eb232mr24843734qvx.27.1669918543443;
        Thu, 01 Dec 2022 10:15:43 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id f12-20020ac8464c000000b003a55fe9f352sm2908912qto.64.2022.12.01.10.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:15:43 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/3] mtd: spi-nor: Extend SFDP to support additional octal modes as per latest JEDEC standard
Date:   Thu,  1 Dec 2022 13:15:29 -0500
Message-Id: <20221201181532.255449-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest JEDEC standard (JESD216F), there are now bitfields in the
4 byte address instruction table for 1S-1S-8S and 1S-8S-8S modes

This patchset adds support for checking the 4BAIT for these modes,
along with additional NO_SFDP_FLAGS to support enabling these new modes

Nathan Barrett-Morrison (3):
  mtd: spi-nor: Extend SFDP 4byte address instruction lookup table with
    new octal modes as per JEDEC JESD216F
  mtd: spi-nor: Add additional octal-mode flags to be checked during
    SFDP
  mtd: spi-nor: Add support for IS25LX256 operating in 1S-1S-8S mode

 drivers/mtd/spi-nor/core.c | 21 ++++++++++++++++++++-
 drivers/mtd/spi-nor/core.h |  9 ++++++---
 drivers/mtd/spi-nor/issi.c |  3 +++
 drivers/mtd/spi-nor/sfdp.c |  5 +++++
 4 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.30.2

