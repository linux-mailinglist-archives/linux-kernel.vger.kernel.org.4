Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61E7704559
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjEPGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjEPGcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:32:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407C430EE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:32:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f450815d02so45738565e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684218746; x=1686810746;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lBYj8ubshxFZMV2M2dh3Q9GAqRDgdmnrPLpkRcqheE=;
        b=E7lp2/zxyUfWM8mqSnWBx6Gr8T9y0wx04g6j0kApgXCCZGdq+5Cqhc0NbQK8ivHOQQ
         yrHN0xqzSaWjlJI60THjkLSNGD+MGbVsPx9pofbL7K4gMA/PatIBvXwbMi3rIiZ5VAe7
         5OwfEXWu56qIfV27q9jBo6dOoRP1WBsfR13geRY0RMvCQrGb74RALdM5Qqdy6BM3zj/7
         aCbJ5u5r0OLhTyq9YA/bfQUtjG+5/hHjgpMjrt9p87UNP+LVX8mo/TDYZs/a5sEDgpUH
         gSR6fZcFkaTRnqH16wXEJ9jyc4wnCy63Ui7/eXvLv6cvGHWUpK/wBsiFXnMMJlXnK1oz
         iFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218746; x=1686810746;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lBYj8ubshxFZMV2M2dh3Q9GAqRDgdmnrPLpkRcqheE=;
        b=X1ozbciTwLbSDXA3KZ1y5Xl+MnVItXCePG+Zx/BgVu0jO1SrdaAoG4GrzlwWc4cuP0
         +fI4EylxWi0gpZLrTliFye87lTl2oji+AwiaxGt7R1JYET/354YqAbYi9ucxyWHuJ/bW
         3e2690Xb61R4pBetMUohj4LeRMXh/CTwbUJdMjEUox25x/avbTaNPeb7P9Jw8KOBMsAQ
         MgS46ZjDIF3I4TaMVarwJ2gxJJf4lrvY/OZ7s3LZH/GResjk8e/GPx4Hx1RHnOM+a4uC
         UPZe6riK9Di57U0MJpN6nqqXrQihx5mizJ1ZIZ+Gyxk6XtEghEhi8W/txT1/fIt0IdH6
         bW8w==
X-Gm-Message-State: AC+VfDz7pqqynm5HjjaGQo5oxVHuR92P7QddzIwoWXCTWH5icnbkDBUO
        BkovQkeNEVMm/vTxYvZoq0R77g==
X-Google-Smtp-Source: ACHHUZ6eWEwQhXAz42LEWVAzrvtlzhMX2ISlzyfQB+Oi5NjYsZ6Fh6C0/XVxtBWtmHuOEgl00zRU3A==
X-Received: by 2002:adf:ee46:0:b0:306:26d7:3805 with SMTP id w6-20020adfee46000000b0030626d73805mr27228159wro.63.1684218746523;
        Mon, 15 May 2023 23:32:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c214900b003f42158288dsm1151344wml.20.2023.05.15.23.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:32:24 -0700 (PDT)
Date:   Tue, 16 May 2023 09:32:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn:
 variable dereferenced before check 'peer_device' (see line 587)
Message-ID: <4b953dfb-fb5b-4f12-87b2-0ad667581106@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da drbd: Pass a peer device to the resync and online verify functions
config: csky-randconfig-m031-20230515
compiler: csky-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305160126.PAmfRexV-lkp@intel.com/

smatch warnings:
drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn: variable dereferenced before check 'peer_device' (see line 587)

vim +/peer_device +588 drivers/block/drbd/drbd_worker.c

e65f440d474d7d Lars Ellenberg       2010-11-05  584  
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  585  static int make_resync_request(struct drbd_peer_device *const peer_device, int cancel)
b411b3637fa71f Philipp Reisner      2009-09-25  586  {
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30 @587  	struct drbd_device *const device = peer_device->device;
                                                                                           ^^^^^^^^^^^^^^^^^^^
Dereference.

44a4d551846b8c Lars Ellenberg       2013-11-22 @588  	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
                                                                                                   ^^^^^^^^^^^^^
The existing code assumes "peer_device" can be NULL.

b411b3637fa71f Philipp Reisner      2009-09-25  589  	unsigned long bit;
b411b3637fa71f Philipp Reisner      2009-09-25  590  	sector_t sector;
155bd9d1abd604 Christoph Hellwig    2020-09-25  591  	const sector_t capacity = get_capacity(device->vdisk);
1816a2b47afae8 Lars Ellenberg       2010-11-11  592  	int max_bio_size;
e65f440d474d7d Lars Ellenberg       2010-11-05  593  	int number, rollback_i, size;
506afb6248af57 Lars Ellenberg       2014-01-31  594  	int align, requeue = 0;
0f0601f4ea2f53 Lars Ellenberg       2010-08-11  595  	int i = 0;
92d94ae66aebda Philipp Reisner      2016-06-14  596  	int discard_granularity = 0;
b411b3637fa71f Philipp Reisner      2009-09-25  597  
b411b3637fa71f Philipp Reisner      2009-09-25  598  	if (unlikely(cancel))
99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  599  		return 0;
b411b3637fa71f Philipp Reisner      2009-09-25  600  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  601  	if (device->rs_total == 0) {
af85e8e83d160f Lars Ellenberg       2010-10-07  602  		/* empty resync? */
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  603  		drbd_resync_finished(peer_device);

More new unchecked dereferences.

99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  604  		return 0;
af85e8e83d160f Lars Ellenberg       2010-10-07  605  	}
af85e8e83d160f Lars Ellenberg       2010-10-07  606  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  607  	if (!get_ldev(device)) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  608  		/* Since we only need to access device->rsync a
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  609  		   get_ldev_if_state(device,D_FAILED) would be sufficient, but
b411b3637fa71f Philipp Reisner      2009-09-25  610  		   to continue resync with a broken disk makes no sense at
b411b3637fa71f Philipp Reisner      2009-09-25  611  		   all */
d01801710265cf Andreas Gruenbacher  2011-07-03  612  		drbd_err(device, "Disk broke down during resync!\n");
99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  613  		return 0;
b411b3637fa71f Philipp Reisner      2009-09-25  614  	}
b411b3637fa71f Philipp Reisner      2009-09-25  615  
9104d31a759fba Lars Ellenberg       2016-06-14  616  	if (connection->agreed_features & DRBD_FF_THIN_RESYNC) {

But this dereference isn't checked either so hopefully "peer_device"
can't be NULL.

92d94ae66aebda Philipp Reisner      2016-06-14  617  		rcu_read_lock();
92d94ae66aebda Philipp Reisner      2016-06-14  618  		discard_granularity = rcu_dereference(device->ldev->disk_conf)->rs_discard_granularity;
92d94ae66aebda Philipp Reisner      2016-06-14  619  		rcu_read_unlock();
92d94ae66aebda Philipp Reisner      2016-06-14  620  	}
92d94ae66aebda Philipp Reisner      2016-06-14  621  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  622  	max_bio_size = queue_max_hw_sectors(device->rq_queue) << 9;
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  623  	number = drbd_rs_number_requests(peer_device);
0e49d7b014c5d5 Lars Ellenberg       2014-04-28  624  	if (number <= 0)
0f0601f4ea2f53 Lars Ellenberg       2010-08-11  625  		goto requeue;
b411b3637fa71f Philipp Reisner      2009-09-25  626  
b411b3637fa71f Philipp Reisner      2009-09-25  627  	for (i = 0; i < number; i++) {
506afb6248af57 Lars Ellenberg       2014-01-31  628  		/* Stop generating RS requests when half of the send buffer is filled,
506afb6248af57 Lars Ellenberg       2014-01-31  629  		 * but notify TCP that we'd like to have more space. */
44a4d551846b8c Lars Ellenberg       2013-11-22  630  		mutex_lock(&connection->data.mutex);
44a4d551846b8c Lars Ellenberg       2013-11-22  631  		if (connection->data.socket) {
506afb6248af57 Lars Ellenberg       2014-01-31  632  			struct sock *sk = connection->data.socket->sk;
506afb6248af57 Lars Ellenberg       2014-01-31  633  			int queued = sk->sk_wmem_queued;
506afb6248af57 Lars Ellenberg       2014-01-31  634  			int sndbuf = sk->sk_sndbuf;
506afb6248af57 Lars Ellenberg       2014-01-31  635  			if (queued > sndbuf / 2) {
506afb6248af57 Lars Ellenberg       2014-01-31  636  				requeue = 1;
506afb6248af57 Lars Ellenberg       2014-01-31  637  				if (sk->sk_socket)
506afb6248af57 Lars Ellenberg       2014-01-31  638  					set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
b411b3637fa71f Philipp Reisner      2009-09-25  639  			}
506afb6248af57 Lars Ellenberg       2014-01-31  640  		} else
506afb6248af57 Lars Ellenberg       2014-01-31  641  			requeue = 1;
44a4d551846b8c Lars Ellenberg       2013-11-22  642  		mutex_unlock(&connection->data.mutex);
506afb6248af57 Lars Ellenberg       2014-01-31  643  		if (requeue)
b411b3637fa71f Philipp Reisner      2009-09-25  644  			goto requeue;
b411b3637fa71f Philipp Reisner      2009-09-25  645  
b411b3637fa71f Philipp Reisner      2009-09-25  646  next_sector:
b411b3637fa71f Philipp Reisner      2009-09-25  647  		size = BM_BLOCK_SIZE;
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  648  		bit  = drbd_bm_find_next(device, device->bm_resync_fo);
b411b3637fa71f Philipp Reisner      2009-09-25  649  
4b0715f09655e7 Lars Ellenberg       2010-12-14  650  		if (bit == DRBD_END_OF_BITMAP) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  651  			device->bm_resync_fo = drbd_bm_bits(device);
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  652  			put_ldev(device);
99920dc5c5fe52 Andreas Gruenbacher  2011-03-16  653  			return 0;
b411b3637fa71f Philipp Reisner      2009-09-25  654  		}
b411b3637fa71f Philipp Reisner      2009-09-25  655  
b411b3637fa71f Philipp Reisner      2009-09-25  656  		sector = BM_BIT_TO_SECT(bit);
b411b3637fa71f Philipp Reisner      2009-09-25  657  
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  658  		if (drbd_try_rs_begin_io(peer_device, sector)) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  659  			device->bm_resync_fo = bit;
b411b3637fa71f Philipp Reisner      2009-09-25  660  			goto requeue;
b411b3637fa71f Philipp Reisner      2009-09-25  661  		}
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  662  		device->bm_resync_fo = bit + 1;
b411b3637fa71f Philipp Reisner      2009-09-25  663  
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  664  		if (unlikely(drbd_bm_test_bit(device, bit) == 0)) {
b30ab7913b0a7b Andreas Gruenbacher  2011-07-03  665  			drbd_rs_complete_io(device, sector);
b411b3637fa71f Philipp Reisner      2009-09-25  666  			goto next_sector;
b411b3637fa71f Philipp Reisner      2009-09-25  667  		}
b411b3637fa71f Philipp Reisner      2009-09-25  668  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests


