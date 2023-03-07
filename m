Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AEA6AE3A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCGPBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCGPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:00:58 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF419A5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:47:32 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id y3so9036336qvn.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 06:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY7eFn4Q8qgMCl47mDyX/pwuMgXfXqOkKnGRS5ZOYfI=;
        b=l6tpHCfGQjwWbN/YsC2GotA18qKwxVT8UgeGOmAItI8oW7iyoWWBo18/AWwz2Fn8T/
         j2YmmgxVHkYLhsF5d7wls/sHIxFltz1Y5EFUEIrO9U6CeKix2xs4Jd6Ax3S9tMl+eYw3
         4/ysUtxTUx6yUXZ1gRW1fMyg7SpuBTB7B+cCP/yBdnsLk64DwIO1ORiCTdfEzNE50XKM
         FftQnwHynF0puLWezBh/D3pDp1fDRzVshT41Yk9VGyqcsgbi1azY5P+5b/XWiiV133AF
         k3pNDVvRqEWflinbPuJAJPQgdFxuhJaEfrY6SbeV3LxwSovw3FyR2QbJQJJI4t4/8iQx
         Kyyg==
X-Gm-Message-State: AO0yUKUCpCoduq70jA9fVlEMxtgiXgJi4HARIpRekauVSK//xKo87Rto
        S/uch+6qDdrpzzrGlY1eRdB0
X-Google-Smtp-Source: AK7set/OnKd4+iM4tpEYcp68JftoiqCoTezpQd8iSBuvpEHUCdOGLTJ16HgT2GvkXb9Ez8q6pVEgmg==
X-Received: by 2002:a05:6214:2681:b0:56e:a9c6:d2c6 with SMTP id gm1-20020a056214268100b0056ea9c6d2c6mr25249935qvb.6.1678200451250;
        Tue, 07 Mar 2023 06:47:31 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a01f500b0071eddd3bebbsm9578852qkn.81.2023.03.07.06.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 06:47:30 -0800 (PST)
Date:   Tue, 7 Mar 2023 09:47:29 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     dm-devel@redhat.com, houtao1@huawei.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>, mpatocka@redhat.com
Subject: Re: dm crypt: initialize tasklet in crypt_io_init()
Message-ID: <ZAdOgUdqwLpUyPlc@redhat.com>
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
 <ZAY/o9ew9AtrCLE5@redhat.com>
 <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06 2023 at  9:12P -0500,
Hou Tao <houtao@huaweicloud.com> wrote:

> Hi,
> 
> On 3/7/2023 3:31 AM, Mike Snitzer wrote:
> > On Mon, Mar 06 2023 at  8:49P -0500,
> > Hou Tao <houtao@huaweicloud.com> wrote:
> >
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> When neither no_read_workqueue nor no_write_workqueue are enabled,
> >> tasklet_trylock() in crypt_dec_pending() may still return false due to
> >> an uninitialized state, and dm-crypt will do io completion in io_queue
> >> instead of current context unnecessarily.
> > Have you actually experienced this?
>
> Yes. I had written a bpftrace script to check the completion context of
> blkdev_bio_end_io_simple() when doing direct io read on dm-crypt device. The
> expected context should be unbound workers of crypt_queue, but sometimes the
> context is the bound worker of io_queue.

OK, thanks for clarifying.  Curious to know the circumstance (I
thought per-bio-data is zero'd -- but it may be I'm mistaken).

I won't be marking this commit for stable@ but if others feel
differently please let me know and I'll do so. (We can always propose
it to stable@, after the fact, even if the commit header doesn't Cc
stable@)

> >> Fix it by initializing io->tasklet in crypt_io_init().
> > Really would rather avoid always calling tasklet_init(). But I can
> > optimize it away with a later patch.
>
> My first though was "io->tasklet.state = 0", but it may be fragile because it
> operated on the internal status of tasklet, so I switch to tasklet_init().

Yes, I looked into it and came up with the same hack.. and I too felt
it was too fragile due to open-coding direct access to the tasklet's
members.

I have a patch I just staged that staged that uses jump_labels to
optimize this code.  If you might review/test/verify it works well for
you that'd be appreciated:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.3&id=ae75a25bd83f7c541240449d2fff3a44433e506b

It builds on your patch, which I added a comment to:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.3&id=d9fe0a98a2e0a1cf585e8a6555afb33be968bd13

From: Mike Snitzer <snitzer@kernel.org>
Date: Mon, 6 Mar 2023 15:58:33 -0500
Subject: [PATCH] dm crypt: conditionally enable code needed for tasklet usecases

Use jump_label to limit the need for branching, and tasklet_init(),
unless either of the optional "no_read_workqueue" and/or
"no_write_workqueue" features are used.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-crypt.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 641457e72603..2d0309ca07f5 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -40,6 +40,7 @@
 #include <keys/user-type.h>
 #include <keys/encrypted-type.h>
 #include <keys/trusted-type.h>
+#include <linux/jump_label.h>
 
 #include <linux/device-mapper.h>
 
@@ -85,6 +86,8 @@ struct dm_crypt_io {
 	struct rb_node rb_node;
 } CRYPTO_MINALIGN_ATTR;
 
+static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
+
 struct dm_crypt_request {
 	struct convert_context *ctx;
 	struct scatterlist sg_in[4];
@@ -1730,12 +1733,15 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
 	io->sector = sector;
 	io->error = 0;
 	io->ctx.r.req = NULL;
-	/*
-	 * tasklet_init() here to ensure crypt_dec_pending()'s
-	 * tasklet_trylock() doesn't incorrectly return false
-	 * even when tasklet isn't in use.
-	 */
-	tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
+	if (static_branch_unlikely(&use_tasklet_enabled)) {
+		/*
+		 * tasklet_init() here to ensure crypt_dec_pending()'s
+		 * tasklet_trylock() doesn't incorrectly return false
+		 * even when tasklet isn't in use.
+		 */
+		tasklet_init(&io->tasklet, kcryptd_crypt_tasklet,
+			     (unsigned long)&io->work);
+	}
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
 	atomic_set(&io->io_pending, 0);
@@ -1775,6 +1781,10 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 		kfree(io->integrity_metadata);
 
 	base_bio->bi_status = error;
+	if (!static_branch_unlikely(&use_tasklet_enabled)) {
+		bio_endio(base_bio);
+		return;
+	}
 
 	/*
 	 * If we are running this function from our tasklet,
@@ -2232,8 +2242,9 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
 
-	if ((bio_data_dir(io->base_bio) == READ && test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)) ||
-	    (bio_data_dir(io->base_bio) == WRITE && test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))) {
+	if (static_branch_unlikely(&use_tasklet_enabled) &&
+	    ((bio_data_dir(io->base_bio) == READ && test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)) ||
+	     (bio_data_dir(io->base_bio) == WRITE && test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags)))) {
 		/*
 		 * in_hardirq(): Crypto API's skcipher_walk_first() refuses to work in hard IRQ context.
 		 * irqs_disabled(): the kernel may run some IO completion from the idle thread, but
@@ -2746,6 +2757,10 @@ static void crypt_dtr(struct dm_target *ti)
 	crypt_calculate_pages_per_client();
 	spin_unlock(&dm_crypt_clients_lock);
 
+	if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags) ||
+	    test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
+		static_branch_dec(&use_tasklet_enabled);
+
 	dm_audit_log_dtr(DM_MSG_PREFIX, ti, 1);
 }
 
@@ -3375,6 +3390,10 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->limit_swap_bios = true;
 	ti->accounts_remapped_io = true;
 
+	if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags) ||
+	    test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
+		static_branch_inc(&use_tasklet_enabled);
+
 	dm_audit_log_ctr(DM_MSG_PREFIX, ti, 1);
 	return 0;
 
-- 
2.37.1 (Apple Git-137.1)

