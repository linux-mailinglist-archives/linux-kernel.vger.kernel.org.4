Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82A668CE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBGEfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBGEfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:35:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93456B465;
        Mon,  6 Feb 2023 20:35:30 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m2so14462898plg.4;
        Mon, 06 Feb 2023 20:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlq3BwZT1r+CBPtIhzsyyyhHP6Bc2ldVFtFr/xCTz/w=;
        b=YgAyZ5Op7pcdB6gr5uuFuad+PbPHxUReL5pmOimmZGq5MPS5kiBf090AAizBV+ywm7
         NAqX4IWcZnnhe+aurgO5FsdnnSzEKpr55lr30G+HOwpGg3NfiZstSjZN64lrMfBoMZh9
         QiDT3PruRXes1q2Oq/eS6KCo4SziZJD9MPEbMuBupLaPjEmr21bHcjCx7KK0HErjP96I
         EKCWj0cspQfsHG+Vww2MijgME3d0Rjys0EYMuVMfI8vvuucr38BS6d2hXScyTFOII0oo
         cviRAH4By5xI9Rg55jHH5WSbYOLUMzo5binszPqxaBCwTUhHzeGe+YC6sqTl89jBPD99
         Uhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlq3BwZT1r+CBPtIhzsyyyhHP6Bc2ldVFtFr/xCTz/w=;
        b=pizqS6hxNpFQlPQk78CPkn+OpeDkDr4DJEMxlAirUarFYbzcjoyIahxbHTM1TL/1No
         JcjHgQKN2H2np10hVV7gABSVFC8hhcJLJdN8iWuhSfR+Yu5FIj+qb6W3a/GLvjZ8/mMw
         rxr0g7hBjhF/QXA+IBEzz4TGvArSvZLcNCdVkkHD+CkZFNI0N+PPjYwzp9PXEAgzX5/o
         csnYCv/DBCBTrmA+kFFmrCVCT2Ohf4ljfatKRlZmPv6KVGBg01ed5yB4lQhUxGlNDDkd
         VvBiNbeTFVeH3fKxr9RcV3b9XYX4VZ/b7MpIdSx1GaEDenmHiXyXRgeT54A0XDuLX3iJ
         uZsA==
X-Gm-Message-State: AO0yUKUA3WeMOU7F2dR28HGouW488rj3/iOw6E5FvCfadx0AEjHF2w/q
        4FA9NknC4lMKaVuCnsKpPbY=
X-Google-Smtp-Source: AK7set+ZocSPPOT0/D6S8qRpab++a8O5Y/ioh1+cYdF7MN/CPFM3O0MmB5hFz6yOmax6FdcpDI13nQ==
X-Received: by 2002:a17:903:3011:b0:199:1271:2717 with SMTP id o17-20020a170903301100b0019912712717mr1270181pla.16.1675744530129;
        Mon, 06 Feb 2023 20:35:30 -0800 (PST)
Received: from d.home.yangfl.dn42 ([222.69.200.222])
        by smtp.gmail.com with ESMTPSA id p4-20020a63ab04000000b00499a90cce5bsm6695310pgf.50.2023.02.06.20.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 20:35:28 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] HID: kye: Add support for all kye tablets
Date:   Tue,  7 Feb 2023 12:33:13 +0800
Message-Id: <20230207043318.23842-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
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

This series refactor kye tablet descriptor fixup routine, by using a
template and filling parameters on the fly, and add support for all
possible kye tablets.
---
v2: fix missing rsize assignment
v3: fix geometry
v4: split patches

David Yang (4):
  HID: kye: Rewrite tablet descriptor fixup routine
  HID: kye: Generate tablet fixup descriptors on the fly
  HID: kye: Sort kye devices
  HID: kye: Add support for all kye tablets

 drivers/hid/hid-ids.h    |   9 +-
 drivers/hid/hid-kye.c    | 917 +++++++++++++++++----------------------
 drivers/hid/hid-quirks.c |  14 +-
 3 files changed, 414 insertions(+), 526 deletions(-)

-- 
2.39.1

