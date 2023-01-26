Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7B67CC73
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjAZNmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjAZNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:42:21 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA6457FE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:42:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P2hWC2Nsmz9v7Y4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:33:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
        by APP2 (Coremail) with SMTP id GxC2BwBnOWAOg9JjSrPJAA--.522S2;
        Thu, 26 Jan 2023 14:41:44 +0100 (CET)
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH v2 0/2] Streamlining treatment of smp_mb__after_unlock_lock
Date:   Thu, 26 Jan 2023 14:46:02 +0100
Message-Id: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GxC2BwBnOWAOg9JjSrPJAA--.522S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kCr17KryDKF17JryrJFb_yoW8Cw4rpF
        WYg39xKw4kAr93Z34fZr1UXr1jyw1rG3y5Jry3Cw1ru345Ww1vgry8t3y5X34fJFZ3Ca4U
        ZF1q9an8uwn8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UAxhLUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset first makes smp_mb__after_unlock_lock use po-unlock-lock-po
to express its ordering property on UNLOCK+LOCK pairs in a more uniform
way with the rest of the model.  This does not affect the guarantees
provided by it, but if the solution proposed here is unsatisfactory, there
are two alternatives that spring to mind:

1)	one could think about rephrasing the guarantee of this fence to
	more obviously match the code

2)	one could redefine po-unlock-lock-po to more obviously match the
	definition of UNLOCK+LOCK pair in rcupdate.h (note: I haven't
	yet checked every use of po-unlock-lock-po, so that would need to
	be checked)

It then makes ppo a subset of po by moving the extended fence behaviors of
this fence (which covers events of two threads) out of ppo.


I'm also not sure how to correctly credit the helpful comments of the
reviewers on the first iteration of the patch.

Changes since the last patch proposal:

1)	As suggested by Andrea Parri, the patches no longer introduce a new
	relation and instead rely purely on strong-fence.  Unlike his
	suggestion these patches do not redefine strong-fence but instead
	use mb | gp directly in the case where the extended fence is to be
	excluded.

2)	Following another suggestion by Andrea Parri, the patches no longer
	update any documentation since there are no new relations.

3)	We split the patch logically into two steps as mentioned above.

4)	As suggested by Alan Stern, we explain in the model why the
	mismatch between the UNLOCK+LOCK definition in rcupdate.h and the
	definition of the semantics of the fence in the model is not
	causing any difference in behavior.


Jonas Oberhauser (2):
  tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-po
  tools/memory-model: Make ppo a subrelation of po

 tools/memory-model/linux-kernel.cat | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.17.1

