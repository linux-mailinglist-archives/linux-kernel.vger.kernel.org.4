Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B416D68FC56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjBIBBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjBIBB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:01:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE6A22780;
        Wed,  8 Feb 2023 17:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cRJurgsy1gaC1lctHFZC/IKRwcYLjz/t3VnD1fiYHJo=; b=ZUdmS+Tj7J2Oi5jQXtmCacgF7o
        Px/Z5vk0mf7TG45dmbeBTDsm4Ni4Te0F4o28sDmUYo39zaCp5/PSh00djQjEOBkGLA0MsMdGzFZh+
        R7fyRsYeoSQrrxEro0wqgkqSLf5qI3rgZq4xbg/tq2Zc4PRLZP7+H5Wpjrqou2zYCkMkKtg7d+L+o
        39HpblME8c7dUV9JeQsGa8ftD4q+qUjJoitjko5vC1o10LfQUtLwVZvkg9lalHE+XP7+s5ItanC9B
        uNfNcUYQ1uhCZ7mBEeXuuw5dQWt+064l21QPWPTkbyJyb8QHikTuv87s3bkRlL4t1rVr0JXOVxGx0
        y+wZXuPQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPvJV-00HMDn-Qa; Thu, 09 Feb 2023 01:01:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-m68k@lists.linux-m68k.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] input/misc: hp_sdc_rtc: mark an unused function as __maybe_unused
Date:   Wed,  8 Feb 2023 17:01:25 -0800
Message-Id: <20230209010125.23690-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS is not set, one procfs-related function is not
used, causing a build error or warning.
Mark this function as __maybe_unused to quieten the build.

../drivers/input/misc/hp_sdc_rtc.c:268:12: warning: 'hp_sdc_rtc_proc_show' defined but not used [-Wunused-function]
  268 | static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
      |            ^~~~~~~~~~~~~~~~~~~~

Fixes: c18bd9a1ff47 ("hp_sdc_rtc: Don't use create_proc_read_entry()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/misc/hp_sdc_rtc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -265,7 +265,7 @@ static inline int hp_sdc_rtc_read_ct(str
 	return 0;
 }
 
-static int hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused hp_sdc_rtc_proc_show(struct seq_file *m, void *v)
 {
 #define YN(bit) ("no")
 #define NY(bit) ("yes")
