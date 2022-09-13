Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE95B7D95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiIMXh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIMXhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:37:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521B71BDB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:37:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j15-20020a056902020f00b006aea95548b0so9122031ybs.19
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=NwGQODpxaIQjq2Q9i7xww6BX9L+zJmLaZqsIG4X4HwQ=;
        b=o4kOxYovTq8PJdbtLFHNsCuRZnYOxfFbUklDCum1if7Egy/oOVrLZccjBiHzq5BXuR
         HQFB4ufGVJe1EForw5n8XYdu13KQ21Jwpy0r8gcfLeBszXy1Phx3faimJZyxO37aXLOp
         YUYAH3/1WvyO3nP8fCCVDCpiVONvC+o2oLf+5sLG/VvnPA8UotxYhrM4nCJ4+/Z1GEz7
         XkEDwRlsiGrs8TsCQbv0cdQm8Oz6ibzUN3tKMehKP02NX/iFzuc8K6BUYYwhuF/pOyKD
         xwc/6jQHuSnUGzzuBLKblrDN9Xv0hArYEZKA2TvN7tKApcijJ5Fd2qwZO6MBZy6cuSMN
         nggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=NwGQODpxaIQjq2Q9i7xww6BX9L+zJmLaZqsIG4X4HwQ=;
        b=Z5CncuMY+xVT+BKwMsxyx5JR2YRJCKkY2iKdNZS9tzw3TX/KrlDWrmkDdnmMYvoY0r
         dfX9JXki0MLa46Ov3xyJXiiwli5vtZG0GQbyM/8nCJaiQxE/n53aaHt2JzBMC2+PGJ4s
         Ub/OYMxxNaS/J7SYFBA6UIka5hgYIQI+4fIacCR0fK8VNVv/Brf01CeeqSO3xvSy1bBb
         iV+UsGAbFDjQkisdsKu1IpaDJK6EdN59kJH6YVIMGFX+fsOsC2B47KeXKyjGSbtPjt1s
         5eeb8YDq4RE6qK2VrZ5Izz2YH50Bhmnw0zQQFAoVcOhdBE5yZvX8mos0IVBt1PmRasq1
         bVCg==
X-Gm-Message-State: ACgBeo1dJiow1kUKSrSg0MwzOBNm1iGRdv+P6qgMnjCO8UUwZFO5C/oI
        r6jZdIA/6OhheuFgkMj4N8c+d2v/ZJC8
X-Google-Smtp-Source: AA6agR4nHY/ALASaB6ML9Y/8f2p0m5sk2i47fc6sZmQCuiYN/l2jdLI3fj8Icd8/Bz5NvCRsPfMkWvqD2Yoj
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a81:1353:0:b0:345:34b5:ad29 with SMTP id
 80-20020a811353000000b0034534b5ad29mr27724101ywt.17.1663112238498; Tue, 13
 Sep 2022 16:37:18 -0700 (PDT)
Date:   Tue, 13 Sep 2022 16:37:14 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913233715.3323089-1-jiangzp@google.com>
Subject: [kernel PATCH v2 0/1] Bluetooth: hci_sync: allow advertise when scan
 without RPA
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch allows the device to keep advertising during active scan when
ll privacy is enabled, if the device is not using privacy mode.

Changes in v2:
- Modify title to reduce length within limit

Changes in v1:
- Check privacy flag when disable advertising

Zhengping Jiang (1):
  Bluetooth: hci_sync: allow advertise when scan without RPA

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.37.2.789.g6183377224-goog

