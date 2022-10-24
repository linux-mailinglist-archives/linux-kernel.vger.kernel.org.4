Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6560BE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJXXDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJXXDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:03:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E9A32BB0B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:24:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y69so14544630ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQAYa+fLJox/NZH1tjJ+liVfXSJpT0A7dg3CtjYLJqI=;
        b=HhVMJjUWnEX2/bI1fcYlS2gBN4LO5cARc0+K9EyA62L3szY9ESDnBfmlenWCHBxTIG
         9vy5a96kBS86oMQaLFq2PEa81BKgxzaMg8HEKjzO7ZgvdtKLEnUV5RvLGBnvtZ6aEOuz
         ik8XLDXu2o9bv8KWayqeYf3zAWmDghmP1FdyX45mPd/35U0XTYMeTjbX7keIWzpMCjUX
         nNG/Sunew4FwvjZyw8Ql8JKMDOq7Fzs8DruAQ52t1GC/f5ekIjUqdBx3Ho/GlwKn5F1t
         W+l1441yRnA+T7AuovrqQD6zItmfx7sHzwzmdqWw22FLvB5UFyuaw7qQiGbMycTXLhcd
         0ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQAYa+fLJox/NZH1tjJ+liVfXSJpT0A7dg3CtjYLJqI=;
        b=72tkDrwEO9QThdZQhWWcP3jOr6DXBnVjtxUYac2VmxSA/ss9ZfV8wEsb/7xJ7BXNx9
         HLeFAVvNWPaLeKx6/Miw6LdWppcXAmGqm25zuUIUAHhbPZ3bl7kr1j3icZg3VZbpmyJ2
         enOiMf2SFXSqt+gm9T7X2hERwVyVmZpudWCCOtWWtGIbZQ3beN34fc/deadw+wgyET/a
         4IJz3cEZHKWqErTTjNoaMbxqFjqBRfY9JJgz5AJN7JAsGL25Zgq1+pJjGsxNXqzviMp9
         uXdwyi/kOdb3yzenjV/TAVTULTWP0S8Us9oqGLi0jj9G8X29dnBB0pWemNZd+TD9L956
         DlUg==
X-Gm-Message-State: ACrzQf175xzLDT8fPEA+EQ3w4Qo6K11sCugyUsKbQaGD9hBwqJUyKQVv
        aVDPAUwFEOQAbZBsEU+gZEI=
X-Google-Smtp-Source: AMsMyM6/qCmr5spS+W5iEx75xawJB3t7ZI7urvtVo4wnsCnv/FqyPoOcz92/orCA8VKCHXNyjWd/tA==
X-Received: by 2002:a05:6402:406:b0:458:a47:d14c with SMTP id q6-20020a056402040600b004580a47d14cmr32275444edv.41.1666646664353;
        Mon, 24 Oct 2022 14:24:24 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b007a9c3831409sm379354ejg.137.2022.10.24.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 14:24:23 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: rtl8712: clean up dynamic memory management
Date:   Mon, 24 Oct 2022 23:24:05 +0200
Message-Id: <cover.1666645510.git.namcaov@gmail.com>
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

This driver is fine if memory allocation never fails. However it does not
handle allocation failure well. This can either lead to memory leak, or
unallocated buffers being used.

Nam Cao (4):
  Revert "staging: r8712u: Tracking kmemleak false positives."
  staging: rtl8712: check for alloc fail in _r8712_init_recv_priv()
  staging: rtl8712: check for return value of _r8712_init_xmit_priv()
  staging: rtl8712: fix potential memory leak

 drivers/staging/rtl8712/os_intfs.c     | 27 +++++++++++++++++++++-----
 drivers/staging/rtl8712/recv_osdep.h   |  8 ++++----
 drivers/staging/rtl8712/rtl8712_recv.c |  7 ++++---
 drivers/staging/rtl8712/rtl871x_recv.c | 16 ++++++++-------
 4 files changed, 39 insertions(+), 19 deletions(-)

-- 
2.25.1

