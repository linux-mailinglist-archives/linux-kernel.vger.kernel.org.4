Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283766DD5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDKIvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDKIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:51:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01A5136
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:51:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o2-20020a17090a0a0200b00246da660bd2so1304137pjo.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681203105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdqgMzgy29XXK8Oo8n24SJIKxZklUx84N8hmAQJ/vnc=;
        b=tmUlzxqXmx/YVqqgISsH/icdHCOwy8JTrHS+ySmGyJRbF1Y01pJhCNmMrcN0dPzryp
         FbcfMyyRLAijo/IGH5ZFW/eEioEVo0Red5ep7acVM5XMuOoLZyBiZaA0JPQY9je4LgmG
         FoKl7kHmj49urqyIAGO2gwkeU+nzUxLkX7+41Wp8SfEJn/0eR1uTtgMTBzzljzyoWMeD
         Z0d2I03mkcz8vOsiMigfnMOPhaEAChVe19NbIW+eIt1wz1f488yBpBYuH0jw2CJZTJq4
         pTJCARMZxV1ebsLBq3PYEjY6ubVy/MyeIMxH6FExXu6piUH0DWjigS8cPkwA3g/+KgKN
         UX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdqgMzgy29XXK8Oo8n24SJIKxZklUx84N8hmAQJ/vnc=;
        b=y9JUM5icA6GEHb1VHfRUun6XtE5fHxAhB3TxU814WhFiV1YhisSd46vzAQAiyOh3Kh
         JIU/62IX2ZZaDk8DOlu8Px0oRn4yGeZi6hU+y8dr2nWWP8AQn54a70VhD0ED/j6Z+shn
         HFAFr0m9R98gfcdQwaURWoo+hMDSandXIVRDm/4qQ7mPGwGKbbk5TOJCvDj6tJSucLD2
         LvIOfKxXM/6IFY3f5SjmvOU2AOe9YbVXZ7NLmbRckthOs4II4NdrrivXPE+MdWRUCT2s
         N33GFYzKAEJX4T8esjNkfZGRueYmVQcpot4jNdb/gFANFA3PFnjVjIecOj/VbYzqVEfy
         nC1g==
X-Gm-Message-State: AAQBX9eVQlPi7FitSjKzedZe2Wu0o7O7PaRvyi02JVpERccpFIoktshj
        7jDrF9O7EUevPfzIBNGaV/8D2Q==
X-Google-Smtp-Source: AKy350ZNlvXlO/AQRbNWdJ7U2sLqaqtUK9axZA3Ylo6bngRGCng5E0VZ4IR0UMTPMA72aRQ7KbsW7g==
X-Received: by 2002:a05:6a20:3aa2:b0:dd:f44a:2717 with SMTP id d34-20020a056a203aa200b000ddf44a2717mr2102225pzh.8.1681203105247;
        Tue, 11 Apr 2023 01:51:45 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b0059085684b54sm9573579pfd.140.2023.04.11.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 01:51:44 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        Stefano Garzarella <sgarzare@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 1/2] virtio_ring: add a struct device forward declaration
Date:   Tue, 11 Apr 2023 17:51:38 +0900
Message-Id: <20230411085139.375393-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio_ring header file uses the struct device without a forward
declaration.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes from v2:
- Fix a typo of commit title

 include/linux/virtio_ring.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8b95b69ef694..77a9c2f52919 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -58,6 +58,7 @@ do { \
 
 struct virtio_device;
 struct virtqueue;
+struct device;
 
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
-- 
2.25.1

