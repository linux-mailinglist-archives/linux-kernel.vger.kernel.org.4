Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284216C82A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCXQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:52:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A2720A04
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:52:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u10so2352842plz.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679676760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edUBi+/JtE98vJJHN+QtdymSXrKLk8rsnuO8TT7A9Xo=;
        b=n/HedZIpgOGlYHaborhr0HDRe9i6moZN3AGrzUx9fh+SU0olus+VN2YFUOIP4P035U
         txGvFG/sxNSkymNdZkW9x6Jlmnvehpd8RZA9puuB833+6nI1D2+J7XHI/wQJBuwDoO+y
         laiqC+5tjC1ussIxuCX0uDqN8Jx1dcrG/HQRD8m0aFKe6y+ZTEO+gAtis8/gIfqcjoZ0
         fN+dVkguTtZeqFHQEXsq9UxffNcGUpFmr66w+kwNHEbgC1cOWiGt8dLD829zZIF3ZJvS
         /qTUtXJ9jCYAOF4Wy7d4DuKfKVinHznVR86GQz4LmrQixmFmi1lt08v/Yc/8Y6Ywf1sn
         BLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679676760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edUBi+/JtE98vJJHN+QtdymSXrKLk8rsnuO8TT7A9Xo=;
        b=qQqpjk8tn/2oV5orr/ccn8Sxglt4rWe9GS79x/fDrOtL2/5SQIshBk304E1Pr8lLEp
         oFvgyiQMzp32ds9PjtEvTRw9iqCnLXrNHhNZFBMRBdlpEon9LRzI5XS9NEXu1n2IHNB+
         iQug7nXvmmbRhrCgJhxfqlD86xyjaNTuE4/xGT95bsVoz3VE/tM/7ImPhcWykiHcHd6L
         nT8CrhSqQeyERIy4rtbkajX5uIoqYPfNAazYbIsQ6qN6E5Q4cCbmFGIXrUKJpjIhlfVU
         iMqjr3mk0+YUVmfMO+3zc716LaUYRteyxKV8lBO7AoFMrV+gMd1qyMXVpb6KkX7mU3cu
         KVdw==
X-Gm-Message-State: AO0yUKXxQqyUOAwO+VAy9vV3OS/P65r5LOZutx2m3QzLwuL6giZ7fqOF
        ZNMhVn1zfypzLLJbgOq3HW2xa1v6Yh8=
X-Google-Smtp-Source: AK7set9lB40pXTIpZ6/Jvv0U77G3bOXc4jE6LS+FEKk4dc8LgJek0Th1YFTyrPm7/axnF1ywBFT1YA==
X-Received: by 2002:a05:6a20:65b:b0:da:bb5f:41ed with SMTP id 27-20020a056a20065b00b000dabb5f41edmr3117806pzm.61.1679676760160;
        Fri, 24 Mar 2023 09:52:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a5-20020aa780c5000000b0062b5a55835dsm1420289pfn.213.2023.03.24.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 09:52:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 0/3] memory: brcmstb_memc: Report more DDR information
Date:   Fri, 24 Mar 2023 09:52:28 -0700
Message-Id: <20230324165231.3468069-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch series adds support for reporting the DDR size, type, width,
total width and single/dual rank attributes. This is useful for system
inventory and debugging.

Florian Fainelli (3):
  memory: brcmstb_memc: Cache configuration register value
  Documentation: sysfs: brcmstb-memc: Document new attributes
  memory: brcmstb_memc: Add new DDR attributes

 .../ABI/testing/sysfs-platform-brcmstb-memc   | 39 ++++++++
 drivers/memory/brcmstb_memc.c                 | 92 +++++++++++++++++--
 2 files changed, 124 insertions(+), 7 deletions(-)

-- 
2.34.1

