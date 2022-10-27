Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4649E60ED18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiJ0AlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ0Ak6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:40:58 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DBB6A50B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:40:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id c91-20020a17090a496400b00212eb50e75cso2085631pjh.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r76g/6spv9g1Vx7pGAOQ0mYI/4RxLKyMJDOpWAIVYAQ=;
        b=FhaaIA1zM7cRdqoeYOiGpHimWQQll1lykHNAmN+eOK4dorSUpc7Wtcm9KxhCue6/jw
         cg8IM3bLSysbBbqFNMGjssdIXvIh0tLMw8VQEbyubCe6Zr2fVNy92g2lsIL/H+fPmHVx
         c7CVnW8RyvhOHpfdUcbmFjeU/nUHUg3ONtpNQi15gCT5W3elCsXBOS0BIvNsgrnp+DWw
         LaBsNPprJh5greUGyvekj3wGWPTplnn79/81PqQKCnZShRKOZS/ipNNWLkW6D/sSUFIM
         uBs7WSo/nXEkNexbsEkLQzio9nFlgscv7mwWBrXIK/N85hVgRCCV0v0tWiem2t2ItIF6
         cNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r76g/6spv9g1Vx7pGAOQ0mYI/4RxLKyMJDOpWAIVYAQ=;
        b=ZA2Hd4qhijHzvolIYJWJhHo9r8ishMzu22gytLgPolR9F/kQ4uFtGQe8lEzSRqVhlZ
         i9T6ZmyGV9E0Cp1SG3NXGghUwH2yMFboZj9GSRjN/Guwshx7kFpjaOKlR+1HKfvtDxnV
         JCSa30cEeOFrG3vWkvgUWD1YiC31YNJ/tlGo9/IYOjkHHq8bmW6wsTTXi8eR21O0ns7w
         gFEYiS3mrWfyFeaZjTJdZdIc8td5NFT+Q2LI2VbSWtncvfPAGTOUNzk8oDw6P/ifddPc
         94ox9jcLWvhpmssHTrutHXukHIaWAE27LZJrdDdM2G42v5+P/o14Kd9fGSM9H3D9bDzW
         WEyw==
X-Gm-Message-State: ACrzQf2Y2IGd3xZ2YOBK7w8ixQeW+zzQ2LU/BaoORY6q+lwPzCv6ql8A
        ReKiqoQi/Ideu5//jMByNgS9Kbghhpu7IerRPlg=
X-Google-Smtp-Source: AMsMyM5KXF/tklp2znsSxvk0Lb5YFt64upBIqpZJs+ukW53rNgVEbOh3laq6eqxVy85RaTyJ+U/8fXwMIbQy73NAbHI=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:57bd:c29a:f9b1:f09c])
 (user=albertccwang job=sendgmr) by 2002:a17:90b:4c48:b0:20d:5c55:b8a8 with
 SMTP id np8-20020a17090b4c4800b0020d5c55b8a8mr7175513pjb.207.1666831257131;
 Wed, 26 Oct 2022 17:40:57 -0700 (PDT)
Date:   Thu, 27 Oct 2022 08:40:47 +0800
Message-Id: <20221027004050.4192111-1-albertccwang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH 0/3] add xhci hooks for USB offload
From:   Albert Wang <albertccwang@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Albert Wang <albertccwang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to proviode the USB offload function which allows to
offload some xHCI operations on co-processor.

*** BLURB HERE ***

Albert Wang (1):
  usb: host: add the xhci offload hooks implementations

Howard Yen (2):
  usb: host: add xhci hooks for USB offload
  usb: xhci-plat: add xhci_plat_priv_overwrite

 drivers/usb/host/xhci-mem.c          |  97 +++++-
 drivers/usb/host/xhci-offload-impl.c | 492 +++++++++++++++++++++++++++
 drivers/usb/host/xhci-plat.c         |  43 +++
 drivers/usb/host/xhci-plat.h         |   8 +
 drivers/usb/host/xhci.c              |  21 ++
 drivers/usb/host/xhci.h              |  31 ++
 6 files changed, 679 insertions(+), 13 deletions(-)
 create mode 100644 drivers/usb/host/xhci-offload-impl.c

-- 
2.38.0.135.g90850a2211-goog

