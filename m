Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0E16DF063
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjDLJ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDLJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:26:20 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0667DAF;
        Wed, 12 Apr 2023 02:26:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PxHQC4g5Vz4f3wgK;
        Wed, 12 Apr 2023 17:26:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHL7MpeTZkL5_1HA--.3769S21;
        Wed, 12 Apr 2023 17:26:13 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 19/19] ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
Date:   Thu, 13 Apr 2023 01:28:33 +0800
Message-Id: <20230412172833.2317696-20-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
References: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHL7MpeTZkL5_1HA--.3769S21
X-Coremail-Antispam: 1UD129KBjvJXoW3CFWftw4rJF4fXFyDJF17trb_yoWDAF1Dpa
        n3AF1Ykr45WFnrWayxK34Fq3WSgw18Zr1Utryfu34rCFyIyryfAFn7tF10yF4FyFWxXFnr
        Xa1Y9ry7CrWxGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are prepared work:
1. Include mballoc-test.c to mballoc.c to be able test static function
in mballoc.c.
2. Implement static stub to avoid read IO to disk.
3. Construct fake super_block. Only partial members are set, more members
will be set when more functions are tested.
Then unit test for ext4_mb_new_blocks_simple is added.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 319 +++++++++++++++++++++++++++++++++++++++++
 fs/ext4/mballoc.c      |   4 +
 2 files changed, 323 insertions(+)
 create mode 100644 fs/ext4/mballoc-test.c

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
new file mode 100644
index 000000000000..2ec3efe45b3f
--- /dev/null
+++ b/fs/ext4/mballoc-test.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test of ext4 multiblocks allocation.
+ */
+
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+
+#include "ext4.h"
+
+struct mb_grp_ctx {
+	struct buffer_head bitmap_bh;
+	struct ext4_group_desc desc;
+	/* one group descriptor for each group descriptor for simplicity */
+	struct buffer_head gd_bh;
+};
+
+struct mb_ctx {
+	struct mb_grp_ctx *grp_ctx;
+};
+
+#define MB_CTX(sb) ((struct mb_ctx *)((struct super_block *)sb + 1))
+#define MB_GRP_CTX(sb, group) (&MB_CTX(sb)->grp_ctx[group])
+
+static struct super_block *alloc_fake_super_block(void)
+{
+	struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
+	struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	struct super_block *sb = kzalloc(sizeof(*sb) +
+					 sizeof(struct mb_ctx),
+					 GFP_KERNEL);
+
+	if (sb == NULL || sbi == NULL || es == NULL)
+		goto out;
+
+	sbi->s_es = es;
+	sb->s_fs_info = sbi;
+	return sb;
+
+out:
+	kfree(sb);
+	kfree(sbi);
+	kfree(es);
+	return NULL;
+}
+
+static void free_fake_super_block(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	kfree(sbi->s_es);
+	kfree(sbi);
+	kfree(sb);
+}
+
+struct ext4_block_layout {
+	unsigned char blocksize_bits;
+	unsigned int cluster_bits;
+	unsigned long blocks_per_group;
+	ext4_group_t group_count;
+	unsigned long desc_size;
+};
+
+static void init_sb_layout(struct super_block *sb,
+			  struct ext4_block_layout *layout)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+
+	sb->s_blocksize = 1UL << layout->blocksize_bits;
+	sb->s_blocksize_bits = layout->blocksize_bits;
+
+	sbi->s_groups_count = layout->group_count;
+	sbi->s_blocks_per_group = layout->blocks_per_group;
+	sbi->s_cluster_bits = layout->cluster_bits;
+	sbi->s_cluster_ratio = 1U << layout->cluster_bits;
+	sbi->s_clusters_per_group = layout->blocks_per_group >>
+				    layout->cluster_bits;
+	sbi->s_desc_size = layout->desc_size;
+
+	es->s_first_data_block = cpu_to_le32(0);
+	es->s_blocks_count_lo = cpu_to_le32(layout->blocks_per_group *
+					    layout->group_count);
+}
+
+static int mb_grp_ctx_init(struct super_block *sb,
+			   struct mb_grp_ctx *grp_ctx)
+{
+	grp_ctx->bitmap_bh.b_data = kzalloc(EXT4_BLOCK_SIZE(sb), GFP_KERNEL);
+	if (grp_ctx->bitmap_bh.b_data == NULL)
+		return -ENOMEM;
+
+	get_bh(&grp_ctx->bitmap_bh);
+	get_bh(&grp_ctx->gd_bh);
+	return 0;
+}
+
+static void mb_grp_ctx_release(struct mb_grp_ctx *grp_ctx)
+{
+	kfree(grp_ctx->bitmap_bh.b_data);
+	grp_ctx->bitmap_bh.b_data = NULL;
+}
+
+static void mb_ctx_mark_used(struct super_block *sb, ext4_group_t group,
+			     unsigned int start, unsigned int len)
+{
+	struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, group);
+
+	mb_set_bits(grp_ctx->bitmap_bh.b_data, start, len);
+}
+
+/* called after init_sb_layout */
+static int mb_ctx_init(struct super_block *sb)
+{
+	struct mb_ctx *ctx = MB_CTX(sb);
+	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
+
+	ctx->grp_ctx = kcalloc(ngroups, sizeof(struct mb_grp_ctx),
+			       GFP_KERNEL);
+	if (ctx->grp_ctx == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < ngroups; i++)
+		if (mb_grp_ctx_init(sb, &ctx->grp_ctx[i]))
+			goto out;
+
+	/*
+	 * first data block(first cluster in first group) is used by
+	 * metadata, mark it used to avoid to alloc data block at first
+	 * block which will fail ext4_sb_block_valid check.
+	 */
+	mb_set_bits(ctx->grp_ctx[0].bitmap_bh.b_data, 0, 1);
+
+	return 0;
+out:
+	while (i-- > 0)
+		mb_grp_ctx_release(&ctx->grp_ctx[i]);
+	kfree(ctx->grp_ctx);
+	return -ENOMEM;
+}
+
+static void mb_ctx_release(struct super_block *sb)
+{
+	struct mb_ctx *ctx = MB_CTX(sb);
+	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
+
+	for (i = 0; i < ngroups; i++)
+		mb_grp_ctx_release(&ctx->grp_ctx[i]);
+	kfree(ctx->grp_ctx);
+}
+
+struct buffer_head *
+ext4_read_block_bitmap_nowait_stub(struct super_block *sb, ext4_group_t block_group,
+				   bool ignore_locked)
+{
+	struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, block_group);
+
+	get_bh(&grp_ctx->bitmap_bh);
+	return &grp_ctx->bitmap_bh;
+}
+
+int ext4_wait_block_bitmap_stub(struct super_block *sb,
+				ext4_group_t block_group,
+				struct buffer_head *bh)
+{
+	return 0;
+}
+
+struct ext4_group_desc *ext4_get_group_desc_stub(struct super_block *sb,
+					     ext4_group_t block_group,
+					     struct buffer_head **bh)
+{
+	struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(sb, block_group);
+
+	if (bh != NULL)
+		*bh = &grp_ctx->gd_bh;
+
+	return &grp_ctx->desc;
+}
+
+int ext4_mb_mark_group_bb_stub(struct ext4_mark_context *mc,
+			       ext4_group_t group, ext4_grpblk_t blkoff,
+			       ext4_grpblk_t len, int flags)
+{
+	struct mb_grp_ctx *grp_ctx = MB_GRP_CTX(mc->sb, group);
+	struct buffer_head *bitmap_bh = &grp_ctx->bitmap_bh;
+
+	if (mc->state)
+		mb_set_bits(bitmap_bh->b_data, blkoff, len);
+	else
+		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
+
+	return 0;
+}
+
+#define TEST_BLOCKSIZE_BITS 10
+#define TEST_CLUSTER_BITS 3
+#define TEST_BLOCKS_PER_GROUP 8192
+#define TEST_GROUP_COUNT 4
+#define TEST_DESC_SIZE 64
+#define TEST_GOAL_GROUP 1
+static int mballoc_test_init(struct kunit *test)
+{
+	struct ext4_block_layout layout = {
+		.blocksize_bits = TEST_BLOCKSIZE_BITS,
+		.cluster_bits = TEST_CLUSTER_BITS,
+		.blocks_per_group = TEST_BLOCKS_PER_GROUP,
+		.group_count = TEST_GROUP_COUNT,
+		.desc_size = TEST_DESC_SIZE,
+	};
+	struct super_block *sb;
+	int ret;
+
+	sb = alloc_fake_super_block();
+	if (sb == NULL)
+		return -ENOMEM;
+
+	init_sb_layout(sb, &layout);
+
+	ret = mb_ctx_init(sb);
+	if (ret != 0) {
+		free_fake_super_block(sb);
+		return ret;
+	}
+
+	test->priv = sb;
+	kunit_activate_static_stub(test,
+				   ext4_read_block_bitmap_nowait,
+				   ext4_read_block_bitmap_nowait_stub);
+	kunit_activate_static_stub(test,
+				   ext4_wait_block_bitmap,
+				   ext4_wait_block_bitmap_stub);
+	kunit_activate_static_stub(test,
+				   ext4_get_group_desc,
+				   ext4_get_group_desc_stub);
+	kunit_activate_static_stub(test,
+				   ext4_mb_mark_group_bb,
+				   ext4_mb_mark_group_bb_stub);
+	return 0;
+}
+
+static void mballoc_test_exit(struct kunit *test)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+
+	mb_ctx_release(sb);
+	free_fake_super_block(sb);
+}
+
+static void test_new_blocks_simple(struct kunit *test)
+{
+	struct super_block *sb = (struct super_block *)test->priv;
+	struct inode inode = { .i_sb = sb, };
+	struct ext4_allocation_request ar;
+	ext4_group_t i, goal_group = TEST_GOAL_GROUP;
+	int err = 0;
+	ext4_fsblk_t found;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	ar.inode = &inode;
+
+	/* get block at goal */
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_EQ_MSG(test, ar.goal, found,
+		"failed to alloc block at goal, expected %llu found %llu",
+		ar.goal, found);
+
+	/* get block after goal in goal group */
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_EQ_MSG(test, ar.goal + EXT4_C2B(sbi, 1), found,
+		"failed to alloc block after goal in goal group, expected %llu found %llu",
+		ar.goal + 1, found);
+
+	/* get block after goal group */
+	mb_ctx_mark_used(sb, goal_group, 0, EXT4_CLUSTERS_PER_GROUP(sb));
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_EQ_MSG(test,
+		ext4_group_first_block_no(sb, goal_group + 1), found,
+		"failed to alloc block after goal group, expected %llu found %llu",
+		ext4_group_first_block_no(sb, goal_group + 1), found);
+
+	/* get block before goal group */
+	for (i = goal_group; i < ext4_get_groups_count(sb); i++)
+		mb_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_EQ_MSG(test,
+		ext4_group_first_block_no(sb, 0) + EXT4_C2B(sbi, 1), found,
+		"failed to alloc block before goal group, expected %llu found %llu",
+		ext4_group_first_block_no(sb, 0 + EXT4_C2B(sbi, 1)), found);
+
+	/* no block available, fail to allocate block */
+	for (i = 0; i < ext4_get_groups_count(sb); i++)
+		mb_ctx_mark_used(sb, i, 0, EXT4_CLUSTERS_PER_GROUP(sb));
+	ar.goal = ext4_group_first_block_no(sb, goal_group);
+	found = ext4_mb_new_blocks_simple(&ar, &err);
+	KUNIT_ASSERT_NE_MSG(test, err, 0,
+		"unexpectedly get block when no block is available");
+}
+
+
+static struct kunit_case ext4_mballoc_test_cases[] = {
+	KUNIT_CASE(test_new_blocks_simple),
+	{}
+};
+
+static struct kunit_suite ext4_mballoc_test_suite = {
+	.name = "ext4_mballoc_test",
+	.init = mballoc_test_init,
+	.exit = mballoc_test_exit,
+	.test_cases = ext4_mballoc_test_cases,
+};
+
+kunit_test_suites(&ext4_mballoc_test_suite);
+
+MODULE_LICENSE("GPL v2");
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f95a48bc8e31..ff1249673233 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6518,3 +6518,7 @@ ext4_mballoc_query_range(
 
 	return error;
 }
+
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+#include "mballoc-test.c"
+#endif
-- 
2.30.0

