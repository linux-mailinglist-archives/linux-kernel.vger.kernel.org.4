Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDF665BCCB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjACJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbjACJGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:06:38 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE8311;
        Tue,  3 Jan 2023 01:06:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NmRgC25LNz4f3v6m;
        Tue,  3 Jan 2023 17:06:31 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP4 (Coremail) with SMTP id gCh0CgAn3bAV8LNj9H0UBA--.54080S2;
        Tue, 03 Jan 2023 17:06:30 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [RFC PATCH bpf-next v2 0/4] Support bpf trampoline for RV64
Date:   Tue,  3 Jan 2023 17:07:52 +0800
Message-Id: <20230103090756.1993820-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAn3bAV8LNj9H0UBA--.54080S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw17GrWfJw4xAF4fArWDurg_yoW8GFyDpa
        yFkry3CFyDXF9rJwnIqa1UZa1Fvw4kX3W5Gw13J3yrCanxXry7Ar1Yga15t3s5CFyfZw1U
        twn0qF4jkas8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UQvtAUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF trampoline is the critical infrastructure of the bpf
subsystem, acting as a mediator between kernel functions
and BPF programs. Numerous important features, such as
using ebpf program for zero overhead kernel introspection,
rely on this key component. We can't wait to support bpf
trampoline on RV64. The implementation of bpf trampoline
was closely to x86 and arm64 for future development.

As most of riscv cpu support unaligned memory accesses,
we temporarily use patch [1] to facilitate testing. The
test results are as follow, and test_verifier with no
new failure ceses.

- fexit_test:OK
- fentry_test:OK
- fentry_fexit:OK
- fexit_stress:OK
- fexit_bpf2bpf:OK
- xdp_bpf2bpf:OK
- dummy_st_ops:OK
- modify_return:OK
- trampoline_count:OK
- get_func_ip_test:OK
- get_func_args_test:OK

[1] https://lore.kernel.org/linux-riscv/20210916130855.4054926-2-chenhuang5@huawei.com/

v2:
- rebase for bpf-next tree.

Pu Lehui (4):
  bpf: Rollback to text_poke when arch not supported ftrace direct call
  riscv, bpf: Factor out emit_call for kernel and bpf context
  riscv, bpf: Add bpf_arch_text_poke support for RV64
  riscv, bpf: Add bpf trampoline support for RV64

 arch/riscv/net/bpf_jit.h        |   5 +
 arch/riscv/net/bpf_jit_comp64.c | 483 ++++++++++++++++++++++++++++++--
 kernel/bpf/trampoline.c         |   8 +-
 3 files changed, 471 insertions(+), 25 deletions(-)

-- 
2.25.1

