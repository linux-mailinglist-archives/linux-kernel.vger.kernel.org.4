Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1727057C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjEPTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjEPTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C600E66
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C723635A1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80EAC433EF;
        Tue, 16 May 2023 19:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266400;
        bh=/xw8L/SqM7J5+dB7LsHWwXKvpp+WooOj5QzCg+QboCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=loFs/j/KwTSIPj1772KxBpDHgWJJ2vaLRapiw5FjTF4PabYT16JDupLW+SSGmRpf1
         wCfewaZ3l0WoTJRovGojaLEA+HxlJ1NW45LcbWix6XzWOmHyPzvBAybAIbjtrhFERg
         WrOFlPQNpCh2GpB+sRNgOKrAqZsmYy31q+0kOkA1uWk2a+Dz63iuOnaI3jcN1M2ChW
         0JN9odgtd1dNcOIlPE2384QQyALu//fAB9uQ+pQG0a9tBG1UjTym2EYq3MRePy4qCZ
         XNWzpQQSX1y3BYj2VVPgldVCKuO/P4BXEl9UEsv8ecAHFhOT/duQ8z6RE7yik7OAvc
         jARhqLL/RZqdw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] atm: hide unused procfs functions
Date:   Tue, 16 May 2023 21:45:34 +0200
Message-Id: <20230516194625.549249-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516194625.549249-1-arnd@kernel.org>
References: <20230516194625.549249-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_PROC_FS is disabled, the function declarations for some
procfs functions are hidden, but the definitions are still build,
as shown by this compiler warning:

net/atm/resources.c:403:7: error: no previous prototype for 'atm_dev_seq_start' [-Werror=missing-prototypes]
net/atm/resources.c:409:6: error: no previous prototype for 'atm_dev_seq_stop' [-Werror=missing-prototypes]
net/atm/resources.c:414:7: error: no previous prototype for 'atm_dev_seq_next' [-Werror=missing-prototypes]

Add another #ifdef to leave these out of the build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/atm/resources.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/atm/resources.c b/net/atm/resources.c
index 2b2d33eeaf20..995d29e7fb13 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -400,6 +400,7 @@ int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
 	return error;
 }
 
+#ifdef CONFIG_PROC_FS
 void *atm_dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	mutex_lock(&atm_dev_mutex);
@@ -415,3 +416,4 @@ void *atm_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	return seq_list_next(v, &atm_devs, pos);
 }
+#endif
-- 
2.39.2

