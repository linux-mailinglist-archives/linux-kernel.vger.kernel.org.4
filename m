Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1670B582
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEVGzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjEVGyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:54:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0BCE42
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:52:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f607766059so1922205e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738356; x=1687330356;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNJMyDDEicQB+cmGCGBCIz7OeL+s5mdIblAcs/EA/9U=;
        b=UNrm+ZWxST2ug6KwAOSNG50tLbRgVDcXfz8FAkXeD4hZqhJ+c/f1VvU0AdDP2H7VWd
         04OZO5gqQNLO7AlufPMK8curDSypjboH9ixl6FjcWBAlwu1q4n0Q4eFN0AlH3zkbT9FY
         xPYFyh3vbtP2i9ZDNhUowjjmhMUs/LhuH7kKKriEXVrPPXqvqU2MPRM09UyYq1CNYflf
         WmFX0aY/0LcSJCje8wj6bXnIetHzZ/YYRFTv6uAn2SH4fw8067VV6S762HNP+98+ljKP
         LY+WYUxJI4iCfIsi464cbcbMsNvYfc3zseEV16noNJKrcXHtb4iRmSap53UC4R8D9UOn
         gfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738356; x=1687330356;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNJMyDDEicQB+cmGCGBCIz7OeL+s5mdIblAcs/EA/9U=;
        b=BoXYutkUzJjZbrxdFUSJQcZaOGNB7z9Ge+wgzsfQ+FMBbgQQS36AbH85JqHp+i10dI
         bNzcJ4LeOIlKs+6+MKdvzjs1qIV8iDmGMJuBFE2DEnv5ZUE0+SuuV2yzMO1s5CFEIMiE
         6AtrQUEeHuho7ZN4INXBgdRKy/ggVOyXcC3ASyk23/a/Dao5YpKxI5BFX9F63PTTLH3p
         xW9lkjncppH8r+3IZdv/BS5iRQ1O2Z0JA5KUJDa9o+xKJrXFEZysTvQ++JKDA1tse2ac
         XFb3ahQrNp9qbfxOMyzCVtnIL0dXEFmyI2L96ZRIF0gLm0S77qZzZtGuZPGBxYA/UA/l
         fheg==
X-Gm-Message-State: AC+VfDwdCJehFt8K4O3+3d20jySg2U4viAtaqflbJtCfcbYcd6SyzS8c
        k1RlRGn2hMmcgm3gQkZCN4QbpQ==
X-Google-Smtp-Source: ACHHUZ61qsFyxHQ4JK0LOEYgyQey0FPBZ1u5MUxReE1aypIFtyvTvN+C5qRTS/5QQsuUNGiLcCESZw==
X-Received: by 2002:a05:600c:292:b0:3f6:468:79b8 with SMTP id 18-20020a05600c029200b003f6046879b8mr1384601wmk.22.1684738356604;
        Sun, 21 May 2023 23:52:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y21-20020a1c4b15000000b003f60119ee08sm4975547wma.43.2023.05.21.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 23:52:35 -0700 (PDT)
Date:   Mon, 22 May 2023 09:52:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn:
 variable dereferenced before check 'peer_device' (see line 587)
Message-ID: <3510da97-01fe-4313-9208-f2a023c34f59@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0dd2a6fb1e34d6dcb96806bc6b111388ad324722
commit: 0d11f3cf279c5ad20a41f29242f170ba3c02f2da drbd: Pass a peer device to the resync and online verify functions
config: ia64-randconfig-m041-20230519
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305211156.sqY1npas-lkp@intel.com/

smatch warnings:
drivers/block/drbd/drbd_worker.c:588 make_resync_request() warn: variable dereferenced before check 'peer_device' (see line 587)

vim +/peer_device +588 drivers/block/drbd/drbd_worker.c

0d11f3cf279c5a Christoph Böhmwalder 2023-03-30  585  static int make_resync_request(struct drbd_peer_device *const peer_device, int cancel)
b411b3637fa71f Philipp Reisner      2009-09-25  586  {
0d11f3cf279c5a Christoph Böhmwalder 2023-03-30 @587  	struct drbd_device *const device = peer_device->device;
                                                                                           ^^^^^^^^^^^^^^^^^^^^
Dereference

44a4d551846b8c Lars Ellenberg       2013-11-22 @588  	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
                                                                                                   ^^^^^^^^^^^
Checked too late.


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
https://github.com/intel/lkp-tests/wiki

