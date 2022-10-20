Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2D6063CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJTPHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJTPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:07:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE541BB96F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:06:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85BE22295F;
        Thu, 20 Oct 2022 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666278417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=H9kD/H/leKyl4VkvwRs3GIyaKPOFO8lA1R3qMpLYsVw=;
        b=DHIwMul6gD4J3vnQypXyAniGcYTN5gjoWt2Mxyx0NwJo/BNBaGJnlvbVF1Q3BfAH5x3MjE
        9yAQ7eJ3VUUBVU/xEBv9XSFlmqX1EH4SoaM509fatc/N1JBDQs1hpGkcz6Rf1zik+aVx6f
        PqES4wc1XPZNuM38EUUv920g1QcYPDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666278417;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=H9kD/H/leKyl4VkvwRs3GIyaKPOFO8lA1R3qMpLYsVw=;
        b=iJbkLeb0Ajd59e9D7YTXkqU3TdCkwRriNLnT+ojzZcFPFW8xNM085LlX3BlX3Lc9vvZ+3k
        vjH+gIylyK9PShCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F5C513AF5;
        Thu, 20 Oct 2022 15:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z/wgERFkUWMJegAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 20 Oct 2022 15:06:57 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>
Subject: [PATCH 1/1] kernel/utsname_sysctl.c: Add missing enum uts_proc value
Date:   Thu, 20 Oct 2022 17:06:45 +0200
Message-Id: <20221020150645.11719-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfca3dd3d068 added new struct ctl_table uts_kern_table[], but not new
enum uts_proc value. It broke the notification mechanism between the
sethostname syscall and the pollers of /proc/sys/kernel/hostname.

The table uts_kern_table is addressed within uts_proc_notify by the enum
value, that's why new enum value is needed.

Fixes: bfca3dd3d068 ("kernel/utsname_sysctl.c: print kernel arch")

Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

I'm sorry to introduce a regression.

Torsten Hilbrich reported [1] that hostnamectl set-hostname foo
which does poll() got affected by bfca3dd3d068. He also wrote a
reproducer [2] which does not require systemd, I tested the patch on
dracut initramfs.

Kind regards,
Petr

[1] https://lore.kernel.org/lkml/0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com/
[2] https://lore.kernel.org/lkml/ec9e00b9-8b47-7918-c39b-8b0069003169@secunet.com/2-hostname-poll-test.c

 include/linux/utsname.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 2b1737c9b244..bf7613ba412b 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -10,6 +10,7 @@
 #include <uapi/linux/utsname.h>
 
 enum uts_proc {
+	UTS_PROC_ARCH,
 	UTS_PROC_OSTYPE,
 	UTS_PROC_OSRELEASE,
 	UTS_PROC_VERSION,
-- 
2.38.0

