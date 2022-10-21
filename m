Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2E26074D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJUKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiJUKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:16:23 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE41AC1DA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666347378; x=1697883378;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QBX4hSlRrxdOe0inWx54vndnjQzIqXHZ8xalA318gcI=;
  b=JBNnofD5HrLxuYI177sfkvlCBVyoroFVwfpER4frGBWhpUQ6KYwB4dzm
   ijxMDweAPC2nuMWoxBao6in9Lvk056+xxGW0gK+ZWjlwXAKADF11ubazC
   Vu42DeiPl+AZS8sXoIigH0NhcS0yzeGVgl9XLbKnwTyQJqOCKVNNcfiJn
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Oct 2022 03:16:17 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 03:16:17 -0700
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 21 Oct 2022 03:16:15 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <mike.kravetz@oracle.com>,
        <opendmb@gmail.com>
Subject: [PATCH v3 0/1] mm/page_isolation: fix clang deadcode warning
Date:   Fri, 21 Oct 2022 18:15:54 +0800
Message-ID: <20221021101555.7992-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When !CONFIG_VM_BUG_ON, there is warning of
clang-analyzer-deadcode.DeadStores:
Value stored to 'mt' during its initialization
is never read.

Changelog
===
V3
---

Difference with previous patch is use __maybe_unused
suggested by David.

V2
---
Difference with previous patch is just to make it
new lines as it is too long for single line.

Feel free to give comments and suggestions. Thanks.

previous discussion here:
[1] https://lore.kernel.org/linux-mm/20221021030953.34925-1-quic_aiquny@quicinc.com/
[2] https://lore.kernel.org/linux-mm/20221021051936.15346-1-quic_aiquny@quicinc.com/

Maria Yu (1):
  mm/page_isolation: fix clang deadcode warning

 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1

