Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4FD6E2196
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDNLCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDNLCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:02:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14AF1BEA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:02:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s2so13809108wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681470119; x=1684062119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeJCYGs+8La/1o3ZqjKRV5pTgpfcjiX/o0DJ7GFuiuU=;
        b=PWc0IvFGYYGPTZGIa5NPb7I7MzO0EKcbxWzupVtDZ382Zapr79SQYJvcsu3G+dsE5q
         0bl/d9/dxdqh8fvO3rfVbvX1nsPoRQkoBQPxPrdH+XyXzNSvxSxWxzZSk+gVH4JXyuu/
         Ug0k0674fKSSOGR3gzOrst+En++kn/4SAVtUdx9w08Q29yDsHM5PBHp2MUI5jmTb7L9M
         UIgU8cvLDJXUtQeUf1nAOU/B6GnCf4FWa5XKS+l3SP87Hwu4S/TXFua1GymlHl9zoCZi
         Fo7kbdoPAETNPDXjt7wxMmJ+zI7NcJB3EGrE4cAmHq+5+G0INpzaQMABXA9CrZWZWjip
         MnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470119; x=1684062119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeJCYGs+8La/1o3ZqjKRV5pTgpfcjiX/o0DJ7GFuiuU=;
        b=KUGaScUsujNPUdau4Hrbq3KgLr6WBvUgfMSuzIrvWPHF4nK+/QhdGR+CpWlyP33dQO
         I/YrPbwTqhja6CmN7CwO3zhyJcdgPLXXcbIsi0zaNKiDUsLSqGCNtZpqrxH88IlABdUt
         y7pr9Jr9TpedusFlLJppuTNkeqsmzUuZAnQUbiEn/mW5y3LpOuqUIZab/ab94YeMndj/
         SBw89t/Y7Fp+xHrkpIoBdLWPoprKB2jrOoRBIFOhZeIQVz/m/R4sSXIFWOkLEY1Ne1c6
         nqf/GhnBoNpqIEADJffGuBtyUGT92QiO9T7Olf8lWsjinzGGsYf5r9TslHdyfCHV97G1
         4SFQ==
X-Gm-Message-State: AAQBX9fhxmlWPUJPVo8KJEf1r+deVfvcxAqQdN8Uv+N+qNySkwddIw/A
        qP0cnWa81SRYZ1qus1S5JqHu5ACH7M2YtGSCYtc=
X-Google-Smtp-Source: AKy350a0KwJMxkVKbsKzEwGPtVRbXGyK2bcXoAJdqkRYJcxn56kwqE9NX1DQHV47EomBTER0KhkCEA==
X-Received: by 2002:a05:6000:18cd:b0:2f2:86cd:3e11 with SMTP id w13-20020a05600018cd00b002f286cd3e11mr4119974wrq.36.1681470119516;
        Fri, 14 Apr 2023 04:01:59 -0700 (PDT)
Received: from fedora.. (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d6ac6000000b002f2789d1bcfsm3328830wrw.21.2023.04.14.04.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:01:58 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v11 0/3] Add support for Maxim MAX735x/MAX736x variants 
Date:   Fri, 14 Apr 2023 13:01:33 +0200
Message-Id: <20230414110137.401356-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v11:
- Fix dt-binding example

v10:
- Small updates to dt-bindings
- Make vdd-supply optional
- Drop MAX7357 enhanced mode configuration

v9:
- Fix 'then' not aligned with 'if' in dt-bindings
- Split enhanced mode configuration into separate patch
- Add MAX7357/MAX7358 register definitions
- Rename config register defines
- Update comments and explain non default config being applied on MAX7357
- Check for I2C_FUNC_SMBUS_WRITE_BYTE_DATA functionality

v8:
- Move allOf in dt-binding and use double negation

v7:
- Reworked the commit message, comments and renamed a struct
  field. No functional change.

v6:
- Fix typo in dt-bindings

v5:
- Remove optional and make vdd-supply mandatory

v4:
- Add missing maxitems dt-bindings property

v3:
- Merge dt-bindings into i2c-mux-pca954x.yaml

v2:
- Move dt-bindings to separate file
- Added support for MAX736x as they are very similar
- Fixed an issue found by kernel test robot
- Dropped max735x property and custom IRQ check
- Added MAX7357 config register defines instead of magic values
- Renamed vcc-supply to vdd-supply

Patrick Rudolph (3):
  dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
  i2c: muxes: pca954x: Add MAX735x/MAX736x support
  i2c: muxes: pca954x: Add regulator support

 .../bindings/i2c/i2c-mux-pca954x.yaml         | 45 +++++++--
 drivers/i2c/muxes/Kconfig                     |  6 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 95 +++++++++++++++++--
 3 files changed, 131 insertions(+), 15 deletions(-)

-- 
2.39.2

