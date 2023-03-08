Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25B66B130B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCHU2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:28:09 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF111EAE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:27:26 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id l13so19537254qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678307245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/20KFgVaCbhWkWSenGGB1/+L4QwyO4onHWnKBRgUBYg=;
        b=LRqiPUonVIiG55nr5+wuxyYuFb4E8m3C9M4bT8Mrw5iPy14EMwc6EDfdn6XfH9rvdK
         AbajKUcX+EqbpJ0jYjUL10gtUd010UAMXOyvUa4dGQuUnpVy/UpYU2+t4ZB0H2Ey3vhA
         jnm4yWTYa+bdNclF0FkA+XI3ZYxPIn/0A5efKJBFoyI17wSch8U40g/SuMGP5owGA1C6
         qaY2WWX690JfogTTitXfyaSOkxkvlmd5SKEhun53hsro1mFjmLKgB/cf3sd69EFq6VzM
         KiTYwFKn790ICkZSUaIlFXWwU+wzTePGRoUNRo1ih9OcLLGHChC1WB3Rw3tdQnpZw3rv
         Kbzg==
X-Gm-Message-State: AO0yUKXtg09/w/axWzhSERZ2OuFMGMyd0tIIvQuZQed8YP3qPT+fe7P+
        tHCKa/jXtZmztGMs0tEC28oa
X-Google-Smtp-Source: AK7set8dvB/4qMr6vHsWzlPUWYLio3NToqIGBeL1emVliBR6VVv4EP/mehECjD/DgA1nrifWFI+ZZA==
X-Received: by 2002:ac8:57cd:0:b0:3bf:be20:544c with SMTP id w13-20020ac857cd000000b003bfbe20544cmr32142596qta.39.1678307245376;
        Wed, 08 Mar 2023 12:27:25 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b6-20020ac801c6000000b003bd1a798f76sm12123795qtg.37.2023.03.08.12.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:27:24 -0800 (PST)
Date:   Wed, 8 Mar 2023 15:27:23 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Ignat Korchagin <ignat@cloudflare.com>,
        Hou Tao <houtao@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        mpatocka@redhat.com, houtao1@huawei.com,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: dm crypt: initialize tasklet in crypt_io_init()
Message-ID: <ZAjvqz5pWf8aSkJ7@redhat.com>
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
 <ZAY/o9ew9AtrCLE5@redhat.com>
 <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
 <ZAdOgUdqwLpUyPlc@redhat.com>
 <6c2d07bf-828e-3aeb-3c02-6cdfd6e36ff3@huaweicloud.com>
 <CALrw=nFrbWF2ZhQtK9gx5ZFHK4Cd9outwEQqByJgmb7ryOoCgA@mail.gmail.com>
 <ZAjfu0R7rv45J3Dr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAjfu0R7rv45J3Dr@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08 2023 at  2:19P -0500,
Mike Snitzer <snitzer@kernel.org> wrote:

> On Wed, Mar 08 2023 at  8:55P -0500,
> Ignat Korchagin <ignat@cloudflare.com> wrote:
> 
> > Perhaps instead we can just pass an additional flag from
> > tasklet_schedule to indicate to the function that we're running in a
> > tasklet. I originally have chosen the tasklet_trylock/unlock hack to
> > avoid passing an extra flag. But unitialized memory makes sense as
> > well as the desire to avoid calling tasklet_init unconditionally. So
> > an extra member in dm_crypt_io might be the most straightforward here.
> 
> ... I think we should certainly evaluate the use of an extra flag.
> 
> Ignat: I'll have a look at implementing it but if you have a patch
> already developed please do share.

I've staged the following in linux-next for 6.3 via the linux-dm.git,
but if you see anything wrong with it I can obviously fix:

From: Mike Snitzer <snitzer@kernel.org>
Date: Wed, 8 Mar 2023 14:39:54 -0500
Subject: [PATCH] dm crypt: avoid accessing uninitialized tasklet

When neither "no_read_workqueue" nor "no_write_workqueue" are enabled,
tasklet_trylock() in crypt_dec_pending() may still return false due to
an uninitialized state, and dm-crypt will unnecessarily do io completion
in io_queue workqueue instead of current context.

Fix this by adding an 'in_tasklet' flag to dm_crypt_io struct and
initialize it to false in crypt_io_init(). Set this flag to true in
kcryptd_queue_crypt() before calling tasklet_schedule(). If set
crypt_dec_pending() will punt io completion to a workqueue.

This also nicely avoids the tasklet_trylock/unlock hack when tasklets
aren't in use.

Fixes: 8e14f610159d ("dm crypt: do not call bio_endio() from the dm-crypt tasklet")
Cc: stable@vger.kernel.org
Reported-by: Hou Tao <houtao1@huawei.com>
Suggested-by: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-crypt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index faba1be572f9..de08ff4f7c98 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -72,7 +72,9 @@ struct dm_crypt_io {
 	struct crypt_config *cc;
 	struct bio *base_bio;
 	u8 *integrity_metadata;
-	bool integrity_metadata_from_pool;
+	bool integrity_metadata_from_pool:1;
+	bool in_tasklet:1;
+
 	struct work_struct work;
 	struct tasklet_struct tasklet;
 
@@ -1731,6 +1733,7 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
 	io->ctx.r.req = NULL;
 	io->integrity_metadata = NULL;
 	io->integrity_metadata_from_pool = false;
+	io->in_tasklet = false;
 	atomic_set(&io->io_pending, 0);
 }
 
@@ -1777,8 +1780,7 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 	 * our tasklet. In this case we need to delay bio_endio()
 	 * execution to after the tasklet is done and dequeued.
 	 */
-	if (tasklet_trylock(&io->tasklet)) {
-		tasklet_unlock(&io->tasklet);
+	if (!io->in_tasklet) {
 		bio_endio(base_bio);
 		return;
 	}
@@ -2233,6 +2235,7 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 		 * it is being executed with irqs disabled.
 		 */
 		if (in_hardirq() || irqs_disabled()) {
+			io->in_tasklet = true;
 			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
 			tasklet_schedule(&io->tasklet);
 			return;
-- 
2.37.1 (Apple Git-137.1)

