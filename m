Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F75EEC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiI2CwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiI2CwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:52:21 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727EB17AA1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:52:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w20so68529ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VOQpuvLZ0z/uJAR/JakCoFvCPaF9FfRjV7Nht49vP2I=;
        b=PBVutv8VuBbw48h4nskgkFVuAnP5eBT75kv2eLzpZBlee8Lo3Z/3IDv1ioOnu1evDa
         0XpVIJ/A7pI76qLM5IV4aajrcKk/xvLA8gcfmV4uLGp/vscuDRfCV84Fo2Wejfrpnqgv
         8H9mrgVt5bq5KNNoT7wDg3bX3XKsptnDpIiY4sejurxC/d2Lp5Ml17Yxv06NPPg1X5AA
         yq7328fLQMdo7vWurd4Dr2EyjLVgtYOlIKTQ7/xZEBtyz/A40DhvKm5AYDAOwF/KsYQa
         dS9fpnQKnSgDIIEPtpm8ujmL7pQdionOZNVQeXXQJpn6ui277UhaDcmPnMZA+WPfwOkc
         9tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VOQpuvLZ0z/uJAR/JakCoFvCPaF9FfRjV7Nht49vP2I=;
        b=vLaHmkhsh/kyTL2xGvt80YKptvsIGp11o2/4JN6qteabNY1/Rrwh56/8hSmWgyMObY
         buAX7XumXYa0ZVvwJvv5XfghS8i2rM68YoT20kh6GzXm/0mI6X/Y7yMcGzRiHR5y+9h/
         SRYyFpOGSfVCP9/JnmxlfYvDo5rhGOS1S9ZNOxd6ud8G3EBXdHpTCZ9F5t+sN2zLenH4
         FhSSAjFgYFUpjdddkEcw+YZ1y5bH1ncBd321Rt0zzgylmNm2u0GtRvk3IB4ehwrzHSoI
         LQbsZVmnGpwy+cQdWboQHPOzCXQIEGEs0EH6NhFozOO1OtCUuD2kK6onYr0gQ3hpC4sk
         epOQ==
X-Gm-Message-State: ACrzQf0eSv2VvvTQPHH5+edXLas9DboCNdQDA6q4GLEdDPbFAyUus5Gi
        olTTK2p2WOWMsNy/d3nL9DfkMGZtJPcXQfu5
X-Google-Smtp-Source: AMsMyM57m3Juvh+quZOZ0wbrpUDOJ5u9pQWLkWe/nbhTCX3DoREYsd1oR5XsPUxvbffX/xKYrxHpCg==
X-Received: by 2002:a17:903:2286:b0:178:349b:d21c with SMTP id b6-20020a170903228600b00178349bd21cmr1175303plh.71.1664419939950;
        Wed, 28 Sep 2022 19:52:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b001789ee5c821sm4599034plf.61.2022.09.28.19.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 19:52:19 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com,
        imbrenda@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH 0/3] ksm: fix incorrect count of merged pages when enabling use_zero_pages
Date:   Thu, 29 Sep 2022 02:52:06 +0000
Message-Id: <20220929025206.280970-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
after enabling use_zero_pages, all empty pages that are merged with
kernel zero page are not counted in pages_sharing or pages_shared.
That is because the rmap_items of these ksm zero pages are not
appended to The Stable Tree of KSM.

We need to add the count of empty pages to let users know how many empty
pages are merged with kernel zero page(s).

Please see the subsequent patches for details.




*** BLURB HERE ***

xu xin (3):
  ksm: abstract the function try_to_get_old_rmap_item
  ksm: add the accounting of zero pages merged by use_zero_pages
  ksm: add zero_pages_merged in Documentation

 Documentation/admin-guide/mm/ksm.rst |  10 ++-
 mm/ksm.c                             | 122 +++++++++++++++++++++------
 2 files changed, 106 insertions(+), 26 deletions(-)

-- 
2.25.1

