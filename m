Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3015E7962
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiIWLWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiIWLV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:21:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403F127576;
        Fri, 23 Sep 2022 04:21:53 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYqP022JYzMpQF;
        Fri, 23 Sep 2022 19:17:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 19:21:51 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 19:21:50 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v5 00/10] kallsyms: Optimizes the performance of lookup symbols
Date:   Fri, 23 Sep 2022 19:20:23 +0800
Message-ID: <20220923112033.1958-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 --> v5:
1. In scripts/kallsyms.c, we use an extra field to hold type and eventually
   put it together with name in write_src().
2. Generate a new table kallsyms_best_token_table[], so that we compress a
   symbol in the kernel using a process similar to compress_symbol().
3. Remove helper sym_name(), and rename field 'sym[]' to 'name[]' in
   scripts/kallsyms.c
4. Add helper __kallsyms_lookup_compressed_name() to avoid duplicate code in
   functions kallsyms_lookup_name() and kallsyms_on_each_match_symbol().
5. Add a new parameter "const char *modname" to module_kallsyms_on_each_symbol(),
   this makes the code logic clearer.
6. Delete the parameter 'struct module *' in the hook function associated with
   kallsyms_on_each_symbol(), it's unused now.


v3 --> v4:
1. Move the declaration of function kallsyms_sym_address() to linux/kallsyms.h,
   fix a build warning.

v2 --> v3:
1. Improve test cases, perform complete functional tests on functions
   kallsyms_lookup_name(), kallsyms_on_each_symbol() and
   kallsyms_on_each_match_symbol().
2. Add patch [PATCH v3 2/8] scripts/kallsyms: ensure that all possible
   combinations are compressed.
3. The symbol type is not compressed regardless of whether
   CONFIG_KALLSYMS_ALL is set or not. The memory overhead is increased
   by less than 20KiB if CONFIG_KALLSYMS_ALL=n.
4. Discard [PATCH v2 3/8] kallsyms: Adjust the types of some local variables

v1 --> v2:
Add self-test facility

v1:
Currently, to search for a symbol, we need to expand the symbols in
'kallsyms_names' one by one, and then use the expanded string for
comparison. This is very slow.

In fact, we can first compress the name being looked up and then use
it for comparison when traversing 'kallsyms_names'.

This patch series optimizes the performance of function kallsyms_lookup_name(),
and function klp_find_object_symbol() in the livepatch module. Based on the
test results, the performance overhead is reduced to 5%. That is, the
performance of these functions is improved by 20 times.

To avoid increasing the kernel size in non-debug mode, the optimization is only
for the case CONFIG_KALLSYMS_ALL=y.


Zhen Lei (10):
  scripts/kallsyms: rename build_initial_tok_table()
  scripts/kallsyms: don't compress symbol types
  scripts/kallsyms: remove helper sym_name() and cleanup
  scripts/kallsyms: generate kallsyms_best_token_table[]
  kallsyms: Improve the performance of kallsyms_lookup_name()
  kallsyms: Add helper kallsyms_on_each_match_symbol()
  livepatch: Use kallsyms_on_each_match_symbol() to improve performance
  livepatch: Improve the search performance of
    module_kallsyms_on_each_symbol()
  kallsyms: Delete an unused parameter related to
    kallsyms_on_each_symbol()
  kallsyms: Add self-test facility

 include/linux/kallsyms.h   |  12 +-
 include/linux/module.h     |   4 +-
 init/Kconfig               |  13 ++
 kernel/Makefile            |   1 +
 kernel/kallsyms.c          | 167 ++++++++++++++-
 kernel/kallsyms_internal.h |   1 +
 kernel/kallsyms_selftest.c | 421 +++++++++++++++++++++++++++++++++++++
 kernel/livepatch/core.c    |  31 ++-
 kernel/module/kallsyms.c   |  15 +-
 kernel/trace/ftrace.c      |   3 +-
 scripts/kallsyms.c         |  88 +++++---
 11 files changed, 694 insertions(+), 62 deletions(-)
 create mode 100644 kernel/kallsyms_selftest.c

-- 
2.25.1

