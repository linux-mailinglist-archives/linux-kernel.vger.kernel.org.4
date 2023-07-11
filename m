Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC8174F06F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjGKNlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGKNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49FE6F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FBB8614FC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF89C433C9;
        Tue, 11 Jul 2023 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689082867;
        bh=Bt9oDG1nWUVU70SGgtLyjWqFDPmkWPg2aId2ZSi4znQ=;
        h=From:To:Cc:Subject:Date:From;
        b=PE+keElRYQA9uP4QPujGWqf6/drIHtnka+nWIrfzFQZSxcLxyUGA8r4vMoLQWZ6XY
         QUVO+309XQJneVLOF5laAXy+wOq5RZ19Rcpo5oHDGfvQNEO/KEWziwrX8syzLW8m/e
         scwFHJGDtj6PjpNde7fNpKRyCcUiXtPczYQc+LCZDCLyEXxuARGZ87qvXSXn4kYDHQ
         jKsarGPmWAXdHxtCi2ZCeB8QC+HHNSK6P3S4z3jUi04e/EwITLrVh6Vf2KpGqQQ9bM
         NBISZIxosDcvlSKlehT9ugsQROjnjEhlhOgvWUp9rnQh1Ee7WtutYXYi2Ok0wF6u45
         LlqRTthplaRRg==
From:   Greg Ungerer <gerg@kernel.org>
To:     linux-arm@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, brauner@kernel.org,
        Greg Ungerer <gerg@kernel.org>
Subject: [PATCH] fs: binfmt_elf_efpic: fix personality for fdpic ELF
Date:   Tue, 11 Jul 2023 23:39:55 +1000
Message-Id: <20230711133955.483393-1-gerg@kernel.org>
X-Mailer: git-send-email 2.25.1
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

The elf-fdpic loader hard sets the process personality to either
PER_LINUX_FDPIC for true elf-fdpic binaries or to PER_LINUX for
normal ELF binaries (in this case they would be constant displacement
compiled with -pie for example). The problem with that is that it
will lose any other bits that may be in the ELF header personality
(such as the "bug emulation" bits).

On the ARM architecture the ADDR_LIMIT_32BIT flag is used to signify
a normal 32bit binary - as opposed to a legacy 26bit address binary.
This matters since start_thread() will set the ARM CPSR register as
required based on this flag. If the elf-fdpic loader loses this bit
the process will be mis-configured and crash out pretty quickly.

Modify elf-fdpic loaders personality setting for ELF binaries so that
it preserves the upper three bytes by using the SET_PERSONALITY macro
to set it. This macro in the generic case sets PER_LINUX but and
preserves the upper bytes. Architectures can override this for their
specific use case, and ARM does exactly this.

Signed-off-by: Greg Ungerer <gerg@kernel.org>
---

Is anyone out there using elf-fdpic on ARM?
This seems to break it rather badly due to the loss of that ADDR_LIMIT_32BIT
bit from the process personality.

 fs/binfmt_elf_fdpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a05eafcacfb2..f29ae1d96fd7 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -348,7 +348,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	if (elf_check_fdpic(&exec_params.hdr))
 		set_personality(PER_LINUX_FDPIC);
 	else
-		set_personality(PER_LINUX);
+		SET_PERSONALITY(exec_params.hdr);
 	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-- 
2.25.1

