Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783F16DA969
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjDGHYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjDGHYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A72AF03
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 00:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD778649FE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4CBC433D2;
        Fri,  7 Apr 2023 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680852267;
        bh=pkE0yg4NEsMuY424B1fUDMze2BcBYrIeATbsW/86JnA=;
        h=Date:From:To:Cc:Subject:From;
        b=LNd969JNzM5FebmOsH14UhkV6Hp5vlAM2+Ll8YCDKvW6AUpJJYYhI3e1XVN3O40WU
         RGDDgSmVPokcztw9uY/Xk/BuJOo/MlgCNeUdihHSK1cvYSNzSmg+DAaf6/xnzCPu+U
         74cqx8RBL9PxWPEhLV8sat9ibwSKnALyEgBLh/Gu5xkaQDz18iEYc1ILEdoDrsQyio
         sumO5Hcvk48snpOHVoMu+koGejKj2zMdwEdVZYJM/MUoRAC1XToUkuYFhQdVplU/G0
         9aHZKB1ZqTxOWnXaaU2eifHV3wjVAfAAk5adtcjUSm/klv5S+RCIcueMi388iokMm6
         /0AJPEqGjb9kw==
Date:   Fri, 7 Apr 2023 00:24:25 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: lkdtm_UNSET_SMEP() with IBT
Message-ID: <20230407072425.zfsy272vk46agno4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I'm seeing the following warning:

  vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xe1: relocation to !ENDBR: native_write_cr4+0x40

The warning seems legit, lkdtm_UNSET_SMEP() is calling to the middle of
native_write_c4() which isn't going to have an ENDBR64.

The 0x40 offset comes from the MOV_CR4_DEPTH bounds check in the for
loop.  The compiler optimized the integer comparison into a pointer
comparison.

Some possible fixes:

- Skip the pinning verification test if cpu_feature_enabled(X86_FEATURE_IBT).

  That prevents the actual IBT violation, but it still doesn't make
  objtool happy.  Maybe there's some way to restructure the code to keep
  the compiler from generating that relocation to the MOV_CR4_DEPTH
  offset.

  I suppose we could add a special case in objtool to silence this
  particular warning, though we try to avoid that type of thing.

- Build-disable the pinning test if CONFIG_X86_KERNEL_IBT.  This may
  be overly broad, CONFIG_X86_KERNEL_IBT is enabled by default but many
  CPUs don't support it.

- Prefix the CR4 write with an ENDBR64 in native_write_c4(), if
  CONFIG_X86_KERNEL_IBT && CONFIG_LKDTM.

Thoughts?

-- 
Josh
