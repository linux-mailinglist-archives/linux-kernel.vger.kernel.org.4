Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC65EE2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiI1RX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiI1RXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:23:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FE87C1E8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x92so5018327ede.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=l7u6sxjGd4Up3n2EXEn7w9kG6KJBfmCH4ZVKabih4Ew=;
        b=C89c5692ohREy/7/FUOPApXHUtVSRPnO5sFmt3ft7MSAkvaKl76Vo2bgYkXdYgqtvP
         y2Dr2BSmjjxUCkYD451sEAnK0vxq5ysRpnih3PmadsdFcCTktMRRHwlFdCHraQbY0hWT
         apF12bmB3vS3T+/I9tp0DpjN16gEncbJhwGX/6fFqI4coOuFww24Cay0NyyxICEQZAYw
         sIyJqx0ln5Zr1HPGU4hP1WbtOIUaimLpefxv21zyYxS7vNDRFGvAi7ZsHTbXmEKpM0E3
         SMDfNkrKPqAfKb9ad4u6cGKUoh2CgldA5KSjOFiiuyIkesxOnsYQDY/v5HxlHH4D3sFg
         0vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=l7u6sxjGd4Up3n2EXEn7w9kG6KJBfmCH4ZVKabih4Ew=;
        b=mC3vw82bEE/SdfOFwwRSiAWpuVPCbfu480qSsGvSnEBSX5u1PvrPbw0Krswod5paju
         PES06AqSSqzVYxktGrtJV0sxBx9FQsd0qYcEPG4C8GVLRgnKJXmykgFXAM1gB6RXVF0a
         F46sOXbUQpDcv8SdKqtSd7F15aGNh7eA9fVY65GQ+78Pia9MFuYxXjyvfU+JAQaw6BrT
         svZdIXw99ld5hmHDyr65XaDGybjpWLjP8FsxW4ZzC6QP/gr34NYfbaLUNU2vDRgfzpZh
         tpxL3GVBDXtXvCkrbnKBMXaqdynAejazN/IUqA2QrV+rebp7WpSJMeHX8HvfrtJl9G3Y
         SPMg==
X-Gm-Message-State: ACrzQf0i0P0WDXxp97ZW7DpiUHLIECOtVRoT+bUWwbOTeBwY+u8/yx0M
        Qat7PHfDsafim0hKETBhKlV+9OAta+4=
X-Google-Smtp-Source: AMsMyM5d6RiOwXpEaubR6tBVWznwUhpZzM+IErIZv9qy7j+dLzajQ6bYEqyepTS9aWZI5w8RLR+WRg==
X-Received: by 2002:a05:6402:b0f:b0:458:1b:fc9a with SMTP id bm15-20020a0564020b0f00b00458001bfc9amr2183786edb.365.1664385799812;
        Wed, 28 Sep 2022 10:23:19 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b007306a4ecc9dsm2725063ejc.18.2022.09.28.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:23:19 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH v2 0/4] staging: vt6655: Implement allocation failure handling
Date:   Wed, 28 Sep 2022 19:21:46 +0200
Message-Id: <cover.1664384503.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This driver does not handle allocation failure when receiving data very
well. This patchset implements better handling in the case of allocation
failure.

Also do some necessary clean-up to implement this.

v2:
  - squash 3 commits that were doing a single thing
  - add new commit which removes a redundant assignment
  - take device_init_rx_desc() out of unnecessary else condition.
  - remove return statement at the end of void function
  - add a missing rd = rd->next statement in device_rx_srv(): because
    we already drop the current buffer, we should move on to the next
    buffer in the ring where new data will be written to.

Nam Cao (4):
  staging: vt6655: remove redundant if condition
  staging: vt6655: change vnt_receive_frame return type to void
  staging: vt6655: remove redundant assignment
  staging: vt6655: implement allocation failure handling

 drivers/staging/vt6655/device_main.c | 40 +++++++++++++++++-----------
 drivers/staging/vt6655/dpc.c         |  8 +++---
 drivers/staging/vt6655/dpc.h         |  2 +-
 3 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.25.1

