Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB67005E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbjELKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbjELKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:46:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E3E702;
        Fri, 12 May 2023 03:46:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64359d9c531so7352775b3a.3;
        Fri, 12 May 2023 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683888367; x=1686480367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqLevf4AjN2a0K/H+1qEs30e2mq42/RzKJvI23SxnJo=;
        b=Y+pSMAZX5keuQoChF4hgkcLDMVFZOaN+5HS7f5qoVEhI1jCyoy47IRNu+cnJE4M4hm
         N6wXDel4vjtwVgk/z068kimCcPS5kMVBT0VPNYkCZrOMavluBc1eDHfDFU0B5d2zuYba
         s/p6AWaZsS8Xt19lv7jwNBcAlmAD0dJqwcH7J7txvNbwL6HhviIPujDtbdHo3c8nCgXh
         szXGNgCseRyercNsD5t5xtyza68ao266SfiEHmn7sztjq0bkOvUwU0gW/vCITQyB1ScC
         R721BJNCv1aO2f1LPZoSZef7BQU7t0516UDB02/b9x11KurmKNMfED/7UAW98nzykaQJ
         gKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888367; x=1686480367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqLevf4AjN2a0K/H+1qEs30e2mq42/RzKJvI23SxnJo=;
        b=JySuT/8jtZ6Vp+h3qYGz+d8Tis3yq4osvz2DFFlRb6e44DE+5dOkHnKvGb54nWa9x4
         4pyojSHjCN07AsR20B73KV9GIMfAXki5nyGwiwT0pHkgx/7lEw2U9pSAwIxSmuy1rD8o
         TIHkqJA5AgwuB6FKSCDzUNcTf8Dd2Dil9PB1bgKZ49TycpgOXJ0DGVfKLuICVRFm1Lub
         knLzFYolTE9QwFCE8f9IJpNSOKZd1JKGowZ1rI552Em2BwLmHcPK9be/x7pv39y86MYn
         VdydhUOJGGHqYgjeS5d7vd9ISJDpIU28nknNSGxVmRthCF6Rs4KSm8kqMx05fCYOPNZW
         096g==
X-Gm-Message-State: AC+VfDxcMJHD/e6sLGoHVu2fGpZmNR0Yv3OucRyX+CnFdEVA4aAKrYtj
        LKiUS1QIXZ+DYhL3vol8RJ8=
X-Google-Smtp-Source: ACHHUZ6WCIVFy3tSgFmUc3KdSCzVUK6z3aTmWFk3JTZ4ZvJNQdkT2Qn07K1YnZ6xDshIQwDS4DPXwQ==
X-Received: by 2002:a05:6a00:2396:b0:646:6c71:ee13 with SMTP id f22-20020a056a00239600b006466c71ee13mr20807240pfc.24.1683888367371;
        Fri, 12 May 2023 03:46:07 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2ae-0f1d-f6c2-46f4-c62f-3944.emome-ip6.hinet.net. [2001:b400:e2ae:f1d:f6c2:46f4:c62f:3944])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b0064358d032a4sm7019268pfo.145.2023.05.12.03.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:46:07 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1 0/3] Add Genesys Logic GL9767 support
Date:   Fri, 12 May 2023 18:45:56 +0800
Message-Id: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
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

These patches support for the GL9767 chipset and add support SD3/SD Express
mode for the GL9767.

Changes in v1 (May. 12, 2023)
* rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
* enable MSI interrupt for the GL9767.
* add support SDR mode for the GL9767.
* export sdhci_check_ro() function.
* add support SD Express mode for the GL9767.

Victor Shih (3):
  mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
  mmc: sdhci: Export sdhci_check_ro function symbol
  mmc: sdhci-pci-gli: Add support SD Express card for GL9767

 drivers/mmc/host/sdhci-pci-core.c |   1 +
 drivers/mmc/host/sdhci-pci-gli.c  | 247 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   2 +
 drivers/mmc/host/sdhci.c          |   3 +-
 drivers/mmc/host/sdhci.h          |   1 +
 5 files changed, 253 insertions(+), 1 deletion(-)

-- 
2.25.1

