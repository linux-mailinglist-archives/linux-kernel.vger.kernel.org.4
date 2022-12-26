Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08676562BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiLZM4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiLZM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:56:08 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149F20F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 04:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1672059343; x=1703595343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nGPV+dVLZeBC/w0lA6JVr4tplCAJavJwgNHjYdO+wl4=;
  b=uFbocRnt/CGtPoIhPL/CZ2czNIgweq9DWjz2+jbqX7gdPHTt/xy6/OqN
   FQroGuZf4IgwkQ+7n7fR/P+ww2I2VX20CXlSIjMvjBke3oYGYxdwjt9WE
   I3c9GZEvEPJYG9k+9ONHXDmoYjDTIZl/DpW+UFukXtNE27gw8ggjZ5obM
   Q=;
X-IronPort-AV: E=Sophos;i="5.96,275,1665446400"; 
   d="scan'208";a="165249425"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 12:55:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 3540F41727;
        Mon, 26 Dec 2022 12:55:42 +0000 (UTC)
Received: from EX19D004ANA004.ant.amazon.com (10.37.240.146) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Mon, 26 Dec 2022 12:55:41 +0000
Received: from 147ddab5055b.ant.amazon.com.com (10.43.162.221) by
 EX19D004ANA004.ant.amazon.com (10.37.240.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20;
 Mon, 26 Dec 2022 12:55:38 +0000
From:   Hayato Kiwata <haytok@amazon.co.jp>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
CC:     <linux-kernel@vger.kernel.org>,
        Hayato Kiwata <haytok@amazon.co.jp>,
        Hayato Kiwata <simplelpmis6@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v1] seccomp: Fix the comment for seccomp_check_filter().
Date:   Mon, 26 Dec 2022 21:53:18 +0900
Message-ID: <20221226125317.14465-1-haytok@amazon.co.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.221]
X-ClientProxiedBy: EX13D39UWA002.ant.amazon.com (10.43.160.20) To
 EX19D004ANA004.ant.amazon.com (10.37.240.146)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment of the seccomp_check_filter() contains a removed function,
seccomp_bpf_load(). This comment needs to be corrected as it may be
misleading to future readers.

seccomp_bpf_load() was removed in the commit bd4cf0ed331a ("net: filter:
rework/optimize internal BPF interpreter's instruction set"). Previously,
seccomp_bpf_load() was used to create an object of struct seccomp_data.
However, this is done inside populate_seccomp_data() now.

Signed-off-by: Hayato Kiwata <haytok@amazon.co.jp>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d653d8426de9..3a93595f4989 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -167,7 +167,7 @@ static void populate_seccomp_data(struct seccomp_data *sd)
  *
  * Takes a previously checked filter (by bpf_check_classic) and
  * redirects all filter code that loads struct sk_buff data
- * and related data through seccomp_bpf_load.  It also
+ * and related data through populate_seccomp_data().  It also
  * enforces length and alignment checking of those loads.
  *
  * Returns 0 if the rule set is legal or -EINVAL if not.
-- 
2.35.1

