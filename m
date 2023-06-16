Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BD3732F99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbjFPLPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbjFPLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:15:09 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A413E;
        Fri, 16 Jun 2023 04:15:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QjGlp5Fk4z4f48vB;
        Fri, 16 Jun 2023 19:15:02 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP1 (Coremail) with SMTP id cCh0CgDHLCcnRIxkwOG9LA--.4088S2;
        Fri, 16 Jun 2023 19:15:01 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: [PATCH v3 0/1] Randomized slab caches for kmalloc()
Date:   Fri, 16 Jun 2023 19:18:42 +0800
Message-Id: <20230616111843.3677378-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHLCcnRIxkwOG9LA--.4088S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13WrWfZr1DCFW3XF1DWrg_yoW8GrWkpF
        y8Gw45uF4rJryfCw4fCw1jqry5Xan5GFyxW342g345Cr45tF10grn7Kr109FyUGF97K3Wf
        WrZIyr1qgryqv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I adapted the v2 patch to the latest linux-next tree and made the v3
patch without "RFC", since this idea seems to be acceptable in general
based on previous dicussion with mm and hardening folks. Please check
the link specified below for more details of the discussion, and further
suggestions are welcome.

v3:
  - Replace SLAB_RANDOMSLAB with the new existing SLAB_NO_MERGE flag.
  - Shorten long code lines by wrapping and renaming.
  - Update commit message with latest perf benchmark and additional
    theorectical explanation.

v2:
  - Use hash_64() and a per-boot random seed to select kmalloc() caches.
  - Change acceptable # of caches from [4,16] to {2,4,8,16}, which is
    more compatible with hashing.
  - Supplement results of performance and memory overhead tests.
  - Link: https://lore.kernel.org/all/20230508075507.1720950-1-gongruiqi1@huawei.com/

v1:
  - Link: https://lore.kernel.org/all/20230315095459.186113-1-gongruiqi1@huawei.com/

GONG, Ruiqi (1):
  Randomized slab caches for kmalloc()

 include/linux/percpu.h  | 12 ++++++---
 include/linux/slab.h    | 20 ++++++++++++---
 mm/Kconfig              | 49 ++++++++++++++++++++++++++++++++++++
 mm/kfence/kfence_test.c |  6 +++--
 mm/slab.c               |  2 +-
 mm/slab.h               |  2 +-
 mm/slab_common.c        | 55 +++++++++++++++++++++++++++++++++++++----
 7 files changed, 130 insertions(+), 16 deletions(-)

-- 
2.25.1

