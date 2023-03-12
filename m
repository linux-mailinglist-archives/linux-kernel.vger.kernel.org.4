Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F216B6B6B00
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCLUVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCLUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:21:18 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAB12FCED
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:21:15 -0700 (PDT)
Received: from fpc (unknown [10.10.165.3])
        by mail.ispras.ru (Postfix) with ESMTPSA id DBBB344C100D;
        Sun, 12 Mar 2023 20:21:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DBBB344C100D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678652473;
        bh=Ei8cks0l2doe1Luabti7c15W0QtF8ehyk0c/q4lB10M=;
        h=Date:From:To:Cc:From;
        b=gKYgYVtaLgBhqffRVHk/FKpSVTbpdXG37d1gy7u9FjRxj8o+sGvWvjjWKYN6AENBZ
         xKy4Yyp6Hq1tU1qtkNs4TzbKdiaAivljgF6p9tZu66EG5UrQiby0IZjpwi+vOi2mbk
         1cXvXWTmvatxvcYSxlhEnFx6mQXvBNkxw7See2cs=
Date:   Sun, 12 Mar 2023 23:21:07 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Message-ID: <20230312202027.46brae36wrbypwge@fpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/google/kmsan.git master

--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -308,8 +308,11 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	unsigned long time_left;
 	int ret = 0;
 
-	if (ah->ah_flags & AH_UNPLUGGED)
-		return 0;
+	if (ah->ah_flags & AH_UNPLUGGED) {
+		ath_dbg(common, WMI, "Device unplugged for WMI command: %s\n",
+			wmi_cmd_to_name(cmd_id));
+		return -ENODEV;
+	}
 
 	skb = alloc_skb(headroom + cmd_len, GFP_ATOMIC);
 	if (!skb)
-- 
