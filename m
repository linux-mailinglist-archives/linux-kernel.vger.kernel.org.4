Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8255710E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbjEYO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbjEYO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E345189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2602364635
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB6FC433EF;
        Thu, 25 May 2023 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685024790;
        bh=JwGEFsVAytpbnNTBcy9sEez5APaywOmU9QISh6P6Aw4=;
        h=From:Date:Subject:To:Cc:From;
        b=SSYfx3l/xw++zk8yHiFZKMnV7NCo0yZ0o6m+PMrdb4g+bxcEF2Xb8II2nZB5HwnlE
         //N4HEtbd2P90fo6T89Ow23UxAy6hnJWoubiLOsoX6IfBK3FQsxoS5jqm/vEakQj8D
         ucHrj3f8a0AY6755FV6ZY9Unf/tjsJx5xaKlwPlTYfKUDoroiT3U1Hrnnxk7JRNOwf
         Fh2rJZgfLXN7pJYOhJaEn3Lt3br5bnBpWxzy/sk2oTJvLzl6LKIZ7IiXuJWsOossA5
         9WTt7Dkty72DAJPBa0tjU9X3zb87r97sDdEaqv9IltfqOXJmryr5vVcO4PdZCr/Qle
         ybqFL8jhtWflg==
From:   Simon Horman <horms@kernel.org>
Date:   Thu, 25 May 2023 16:26:25 +0200
Subject: [PATCH] kexec: Avoid calculating array size twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-kexec-array_size-v1-1-8b4bf4f7500a@kernel.org>
X-B4-Tracking: v=1; b=H4sIABBwb2QC/x2N0QrCMAwAf2Xk2UCtrQ/+ioikXeaCo0qCMjf27
 ws+3sFxKxirsMGlW0H5Kyav5nA8dFBHag9G6Z0hhngKOWZ88swVSZV+d5OFsT/nGiilkmgAzwo
 ZY1FqdfSwfabJ5Vt5kPn/ud62bQcbFtZsdwAAAA==
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid calculating array size twice in kexec_purgatory_setup_sechdrs().
Once using array_size(), and once open-coded.

Flagged by Coccinelle:

  .../kexec_file.c:881:8-25: WARNING: array_size is already used (line 877) to compute the same size

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 kernel/kexec_file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..3f5677679744 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -867,6 +867,7 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 {
 	unsigned long bss_addr;
 	unsigned long offset;
+	size_t sechdrs_size;
 	Elf_Shdr *sechdrs;
 	int i;
 
@@ -874,11 +875,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	 * The section headers in kexec_purgatory are read-only. In order to
 	 * have them modifiable make a temporary copy.
 	 */
-	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
+	sechdrs_size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
+	sechdrs = vzalloc(sechdrs_size);
 	if (!sechdrs)
 		return -ENOMEM;
-	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
-	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, sechdrs_size);
 	pi->sechdrs = sechdrs;
 
 	offset = 0;

