Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A16666C04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbjALICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjALICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:02:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213BEDEAA;
        Thu, 12 Jan 2023 00:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8797B81D93;
        Thu, 12 Jan 2023 08:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D513C433F0;
        Thu, 12 Jan 2023 08:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510509;
        bh=7jyvgoiUqyV5fZmP+U6F8jiyQbC43zHivnClvOwaS84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CI2n9j+8RcxOoT54IEJ0wWhYF+7vAxP8SQL+M4KkPB0Z5JKrZsQHz/mXAhSDqbUoo
         yMqaUwlqkwzK5JB6y5Iab5Mt4Bkd0JxxW5PmyMvelpp7vDwn2myHjetSlokatnLMBL
         IFuuZO7pAcMUeaCdzs7dp2lTFo18GaIzjJfiBMLtjIGcznfiMVi48nuAn5CLSYw1Ka
         4//mO0KJDTXoq991WyoTDASJilHYernTadsBX7qVvgM2uMzXhgXIbB1moEqv4P7NUR
         piLAZdsGLxPBpA6jWQGLxCDQUwZzezjhJJ41M0JCPUZRNaGT8+T897o67d+OtZKB1z
         CzmH5445frQBg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/11] tty: vt: replace BUG_ON() by WARN_ON_ONCE()
Date:   Thu, 12 Jan 2023 09:01:32 +0100
Message-Id: <20230112080136.4929-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112080136.4929-1-jirislaby@kernel.org>
References: <20230112080136.4929-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to panic in vc_uniscr_copy_line(), just warn. This should never
happen though, as vc_uniscr_check() is supposed to be called before
vc_uniscr_copy_line(). And the former checks vc->vc_uni_lines already.

In any case, use _ONCE as vc_uniscr_copy_line() is called repeatedly for
each line. So don't flood the logs, just in case.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 119b3eafef59..db72375141b0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -535,7 +535,8 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 	int offset = row * vc->vc_size_row + col * 2;
 	unsigned long pos;
 
-	BUG_ON(!uni_lines);
+	if (WARN_ON_ONCE(!uni_lines))
+		return;
 
 	pos = (unsigned long)screenpos(vc, offset, viewed);
 	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
-- 
2.39.0

