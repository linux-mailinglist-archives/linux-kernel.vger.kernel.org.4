Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5255ECCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiI0TI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiI0TIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:08:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951B1CDB59;
        Tue, 27 Sep 2022 12:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFD46B81D31;
        Tue, 27 Sep 2022 19:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858B0C433C1;
        Tue, 27 Sep 2022 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664305700;
        bh=cpFun7PV4yOAi/XYvfmGgsS3jnA3S2FJPFFNhYVbJGs=;
        h=From:To:Cc:Subject:Date:From;
        b=DERmri9s50L00blRES7fBQ6TJ3PQ/QMP28KZC88Qc7fBSNP2vKroyPQxDxcdSmkh/
         S7cSfvxizq0Wy4xFfgIebsY8dH2WQY+46YjfcbRqACjNYICUddsUoyAJvtbMYr+7uv
         9NvjLC2edaalR06mitroSrSPpyuLFIwDWnKs2gaW1jJy7msAZ1qk2VBa5TEKj9ATJV
         1ahIa3b7iVYTr/vSaQSXeAnaZBimKAEMNitSkvDefVCmV5fGcsnNVQnFGwWp+oWl29
         15zPy1Roj9krA8yg1m05Nd7kzfTX9JUJlOhiUi+m3Ns5IJLHwwIDB5w8ebdTM7fLF7
         9XSFJdU/C633A==
From:   broonie@kernel.org
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: linux-next: manual merge of the kspp tree with the bpf-next tree
Date:   Tue, 27 Sep 2022 20:08:11 +0100
Message-Id: <20220927190811.514527-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  tools/objtool/check.c

between commit:

  9440155ccb948 ("ftrace: Add HAVE_DYNAMIC_FTRACE_NO_PATCHABLE")

from the bpf-next tree and commit:

  3c68a92d17add ("objtool: Disable CFI warnings")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/objtool/check.c
index fcc4d8ea8cec3,48e18737a2d18..0000000000000
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@@ -4124,7 -4118,7 +4128,8 @@@ static int validate_ibt(struct objtool_
  		    !strcmp(sec->name, "__ex_table")			||
  		    !strcmp(sec->name, "__jump_table")			||
  		    !strcmp(sec->name, "__mcount_loc")			||
 -		    !strcmp(sec->name, ".kcfi_traps"))
++		    !strcmp(sec->name, ".kcfi_traps"))			||
 +		    strstr(sec->name, "__patchable_function_entries"))
  			continue;
  
  		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
