Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D063607F50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJUTzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJUTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:55:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E323922E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:55:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n7so3302732plp.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNNveePuU79nefYrCFbbP5s7bln8lfKIunwZmDnn1dM=;
        b=fG5In610GWinQPENKDfT+yrc19r+KQgkQU2frOZZMhOztf7/Gut0E1+otFpFWb4j7W
         s0r18cWB5XjQMCvSYN75GdKTzfoiUdUicKgVsoOrhEfWYC/vQ35Y7q/A/EAGcAl9EABz
         xubyMf78FqUIxQQzXApXYEqXrTxcyEY8TJC9ddQHhfuPXU5a/7X9Ebb03H/fRrDn8PdC
         y1fPyZJ7+IJ/MgtwXa6UYC/o1uvk91mvC2t8KS/G/3YRhT6SjiInqlp6oja2UeG5s3r4
         VMILenvUlOfvJENmvOCPqBLKU38u/NO6vlZGiOubaDf2EupTFYaT+xUc7qdVMr8odxad
         Im0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNNveePuU79nefYrCFbbP5s7bln8lfKIunwZmDnn1dM=;
        b=bu25T7SdYg0WT2l0K5emKo5ChT5Jj2zT0dywgkPewOjtulVC9bXOxX1ojsPf0/DeJl
         uK1NYB7CA4YyotOEpnZhz12bF1Oeqxmd47HM4kYnjMNse5gWe7y3rdU0y9MbQhLieSnY
         DTnhpt1dRWCz6p+f0Yeyub4ZeHSOuhfllamfBuahXwi2yp2LXnLujRUFdlUTeuvUMcph
         olt3hNc+SetiqVcSxgu3VxKhEKAFVuGBbHDsrbKf/ejVkrBU8ju/k/cffzGBsncLc4jn
         AJHEV3E3j43B9hHinaljw75GChRk6iKG5JBaoN9fcet+cCTw03CdhMUhvqw97UFlKc+a
         7udA==
X-Gm-Message-State: ACrzQf2LdLpix7YWy7O1rf/5fudLPsguzWcCoDAgX+3msGUTrs/M73yC
        cGxvoEnec3zLDyixpM2WS4v9n+7cOFranw==
X-Google-Smtp-Source: AMsMyM5WhK7/3r4IUjzGM0n6YIgOiv6OTzsn8JcW2FgpRWLzsRljcMcl40vESfgE8FFVPIf27CWU9w==
X-Received: by 2002:a17:90b:1d8a:b0:20f:95f9:ff34 with SMTP id pf10-20020a17090b1d8a00b0020f95f9ff34mr23810497pjb.227.1666382145556;
        Fri, 21 Oct 2022 12:55:45 -0700 (PDT)
Received: from localhost.localdomain (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id g13-20020aa79dcd000000b005668b26ade0sm15179345pfq.136.2022.10.21.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:55:44 -0700 (PDT)
From:   Emily Peri <eperi1024@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Emily Peri <eperi1024@gmail.com>
Subject: [PATCH v2 0/3] clean up driver code in rtw_ioctl_set
Date:   Fri, 21 Oct 2022 12:54:54 -0700
Message-Id: <cover.1666380274.git.eperi1024@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Created patchset to fix all checkpatch warnings in rtw_ioctl_set

Changes since v1:

* Patch 1: "staging: rtl8723bs: remove tab in variable definition"
  * Split previous white space patch into three separate patches
  (feedback from Gregh). Remove tab instead of space (feedback from
  Michael S and Praveen K)

* Patch 2: "staging: rtl8723bs: add newline after variable declaration"
  * Split previous white space patch into three separate patches
  (feedback from Gregh). 

* Patch 3: "staging: rtl8723bs: use tab instead of spaces for indent"
  * Split previous white space patch into three separate patches
  (feedback from Gregh).

* Merged into Greg's tree "rtl8723bs: align block comment stars" 

* Merged into Greg's tree "staging: rtl8723bs: remove unnecessary parenthesis"

Emily Peri (3):
  staging: rtl8723bs: remove tab in variable definition
  staging: rtl8723bs: add newline after variable declaration
  staging: rtl8723bs: use tab instead of spaces for indent

 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1

