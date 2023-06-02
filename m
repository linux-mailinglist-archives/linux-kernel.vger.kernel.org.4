Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197A17208A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbjFBRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjFBRy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D2123;
        Fri,  2 Jun 2023 10:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 173CD61120;
        Fri,  2 Jun 2023 17:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AD8C433D2;
        Fri,  2 Jun 2023 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685728495;
        bh=/Fha51BP3sm6ndA/PVNCmNHln36UDvTlLxwLX1uUDlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xq99a37N4aPyn3Ql9vrjO7E55WnEO+EeZXMiIjGLgPTMAuK0k0rxdT9L7veCohXXS
         pWmluk0mkA6TCRFcB43Zt+7uaoD45BUj9kDdCr9CFuaIZPM4/0j78bh/V2GcvpAodp
         PuCQV77RIdi5Nz+nuTgs3LVTOoVmyKGm3LPRY+VyKAe7/Gc253weOjM6ToMeKoZOWY
         igtriA+1OiTU5A92uBJM7dAcIrAjS5GS5Lzkc652amXeJHcoTqQTA0nA/rBOahlU71
         ppkGDswLLkIJIkTykQkaOhEN5AG88tXFyR3hcnrG2QKCx5fWSZK2ZygohuDYVW+UBw
         jsS5HOjIrpQ7A==
Date:   Fri, 2 Jun 2023 10:54:53 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] objtool: Add __kunit_abort() to noreturns
Message-ID: <20230602175453.swsn3ehyochtwkhy@treble>
References: <20230602131229.3589f3bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602131229.3589f3bf@canb.auug.org.au>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a bunch of warnings like:

  drivers/input/tests/input_test.o: warning: objtool: input_test_init+0x1cb: stack state mismatch: cfa1=4+64 cfa2=4+56
  lib/kunit/kunit-test.o: warning: objtool: kunit_log_newline_test+0xfb: return with modified stack frame
  ...

Fixes: 260755184cbd ("kunit: Move kunit_abort() call out of kunit_do_failed_assertion()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/noreturns.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index cede6068ddf6..1514e84d5cc4 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -7,6 +7,7 @@
  * Yes, this is unfortunate.  A better solution is in the works.
  */
 NORETURN(__invalid_creds)
+NORETURN(__kunit_abort)
 NORETURN(__module_put_and_kthread_exit)
 NORETURN(__reiserfs_panic)
 NORETURN(__stack_chk_fail)
-- 
2.40.1

