Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8A623D00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiKJIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiKJIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:00:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946E20981
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:00:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x18-20020a170902ec9200b001869f20da7eso899331plg.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ra6xv4EwBUlp+/+o0IyX2+LKj8mBup5fBpvBRS5zZok=;
        b=VUWwElpXRlILV2Efpj7hFU2vGpaSavpX+8Q1d2yFC82xC8HUVErZC8XPVHHzPox94f
         +Kegl9at6hxuVKYffF67ybMX1aB4kUOpNK34uWvUXza5Vyr/hZgzhPtq76kQRjXpS35A
         QLGbXBqQIcV0KBe/dT7tCYQLLrPmu85cXnKu9HUwO0atedAggCJDKV/Weo85lLiQImFq
         jGKmFmWcUCZAqcz2TuzeRg4pfsoFkL/OqxCTqbjxQ5nA+Nxqvk5Q29om1o5y8gEtNbcB
         2W24pgeVYpqDO8oDW5V5OcRc8a6gDB2c9/y77D80qm1ROnFwHg6pzdXARjhDZ8qEDTxx
         SW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ra6xv4EwBUlp+/+o0IyX2+LKj8mBup5fBpvBRS5zZok=;
        b=n6UGWYnN9NWkFuMFjC7d8yGfVjpWzZvP1/q7jMlcULQ32fHnkMYGaU/X+72sSJ88XQ
         KZ1zEzkmosVdaLuEBYD4/0ypRYI/+D6DtlLV7CpJvYpXaMAimayFHIVFzz/S6H0gDzIx
         kgFpezdeNkcLTAJwgQsHLIeXcOZgexHXgzUAtbTC3hQdX2IOX23E0lUc8exgKTN8PLSR
         sZmUrsrJrl3qDeSMDosoTGt1TDVFbs51ocaP0858x2isQr0XpIN2Y8EITgfy/QECeqEv
         oHxPAHqtYpFSo4SBoIoLeJiugQro9P3pYBwMZId9NWqOpgg2nX0PqxjYudS5IBrTNE+0
         yHmw==
X-Gm-Message-State: ACrzQf3My8CYR9VDcjD245HZ3oqt+2U1+dTd6XWnqAwSsg0i0QztPGH2
        UsWIXmm/08j+mNyOyJyNyuc/85m6w5L0mDYIMzg=
X-Google-Smtp-Source: AMsMyM6C9jVbPmpjXYqL4D+qAXptiX47BI1Cw4ZRuuzcuzmWjPvLyfXShnlZjnmeywzXYB6C5lcFvIvioRz1zIR30Ls=
X-Received: from albertccwang.ntc.corp.google.com ([2401:fa00:fc:202:2c6f:5c28:5579:9e27])
 (user=albertccwang job=sendgmr) by 2002:a17:90b:374a:b0:212:8f7:acf with SMTP
 id ne10-20020a17090b374a00b0021208f70acfmr1248125pjb.13.1668067213306; Thu,
 10 Nov 2022 00:00:13 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:00:03 +0800
Message-Id: <20221110080006.3563429-1-albertccwang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 0/3] add xhci hooks for USB offload
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

This serial patches enable the xhci driver to support USB offload, add
hooks for vendor to have customized behavior for the initialization,
memory allocation. Details are in each patch commit message. Meanwhile,
the offload function implementations is uploaded as well.

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

---
Changes in v2:
- Optimize the code change
- Add the offload implementation file
  
-- 
2.38.1.431.g37b22c650d-goog

