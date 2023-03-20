Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419E6C0A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCTFpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCTFpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:45:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296C15169
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 22:44:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l27so851671wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679291092;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRuUVGSib6JEyEmuvmz5jbeu7IJd8ilenJrI8qajkpk=;
        b=KMEDfqzXbj4j85AgI9jbSWqxqcmuw6A49DM47WxQ+I/3irsTDK05u3z3N+T0GkUh5Q
         WItfluFm5yB/xlzhqaagz+1W8j6OOABczFlEdm9S78BXigJY5kh5PlnVT5a44HKyfHRM
         Oumfx0mpQoDz/5i+cFFiMHDt/Ea/aYBzfqi+c8JBN+ounm7djVtexP/Km/ixGWSTtp3w
         ncUvf3T0WRSkUm/d6bjyk2fvCy0Qhr4REjnRuvcGTMi9HGvcAHj1V3kExYhokLC3ipLF
         UZWiCN4i814Qt1lesrVA8GBdJRCHtoqPYd78wAb/1RkRc5kOVqHbB88PwjmeeYiFeJFm
         TfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679291092;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRuUVGSib6JEyEmuvmz5jbeu7IJd8ilenJrI8qajkpk=;
        b=byzhxdCCOyfzT3MdyXA14xomS65F88VZ+k6biR9Yz5Y1EPyWU0PRBJFQnCV/2vvdTt
         TXkoziT9DGOgUlRmkrwoYffyc3ErlTDA4HC7njhqDzQ8UstyRjRrMS/cwGktRZBgv5OV
         Jn/rHjqUkimfKQgjrn+2qLQCj2S4wRekPo5Pq61Edv4fSTFhUPfRhat9QOf63cD3Y/dG
         B1MqjNDBvGIycC4EAbHymXv8e3q6ZgevW24pW+4Y8famXk0wdFkWfxtFifKQve/0YEuZ
         rl0ejFUfQp1P0NJbHGdKDcDVG1nXjgKKayyVpDXx0o2sZ6G7QF6lr8UHpREmwmOKmQjB
         HnKw==
X-Gm-Message-State: AO0yUKVvlO962ha+XU2YUzbZp1hWHAIG1yheRR72EFedESgDf23hu8v2
        d0cjXPJ8xsAEwt90GCoKzxU=
X-Google-Smtp-Source: AK7set++jZ9k6qrn3I/QaHRxiafuTR9DdvqnuPbYHZzt6IwW7cRcbAR4ZjNU4pFTjcz1c4KBUgRJTA==
X-Received: by 2002:a5d:4ecc:0:b0:2d0:c73d:ef2a with SMTP id s12-20020a5d4ecc000000b002d0c73def2amr11554417wrv.24.1679291091639;
        Sun, 19 Mar 2023 22:44:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b002c5598c14acsm8096854wri.6.2023.03.19.22.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 22:44:51 -0700 (PDT)
Date:   Mon, 20 Mar 2023 08:44:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: fs/zonefs/file.c:441 zonefs_file_dio_append() error: uninitialized
 symbol 'size'.
Message-ID: <30200c4e-21e8-4454-a947-01d228f154a1@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3671bd86a9770e34969522d29bb30a1b66fd88a
commit: 4008e2a0b01aba982356fd15b128a47bf11bd9c7 zonefs: Reorganize code
config: nios2-randconfig-m031-20230319 (https://download.01.org/0day-ci/archive/20230319/202303191227.GL8Dprbi-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303191227.GL8Dprbi-lkp@intel.com/

New smatch warnings:
fs/zonefs/file.c:441 zonefs_file_dio_append() error: uninitialized symbol 'size'.

vim +/size +441 fs/zonefs/file.c

4008e2a0b01aba Damien Le Moal 2022-11-25  378  static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
4008e2a0b01aba Damien Le Moal 2022-11-25  379  {
4008e2a0b01aba Damien Le Moal 2022-11-25  380  	struct inode *inode = file_inode(iocb->ki_filp);
4008e2a0b01aba Damien Le Moal 2022-11-25  381  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
4008e2a0b01aba Damien Le Moal 2022-11-25  382  	struct block_device *bdev = inode->i_sb->s_bdev;
4008e2a0b01aba Damien Le Moal 2022-11-25  383  	unsigned int max = bdev_max_zone_append_sectors(bdev);
4008e2a0b01aba Damien Le Moal 2022-11-25  384  	struct bio *bio;
4008e2a0b01aba Damien Le Moal 2022-11-25  385  	ssize_t size;
4008e2a0b01aba Damien Le Moal 2022-11-25  386  	int nr_pages;
4008e2a0b01aba Damien Le Moal 2022-11-25  387  	ssize_t ret;
4008e2a0b01aba Damien Le Moal 2022-11-25  388  
4008e2a0b01aba Damien Le Moal 2022-11-25  389  	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
4008e2a0b01aba Damien Le Moal 2022-11-25  390  	iov_iter_truncate(from, max);
4008e2a0b01aba Damien Le Moal 2022-11-25  391  
4008e2a0b01aba Damien Le Moal 2022-11-25  392  	nr_pages = iov_iter_npages(from, BIO_MAX_VECS);
4008e2a0b01aba Damien Le Moal 2022-11-25  393  	if (!nr_pages)
4008e2a0b01aba Damien Le Moal 2022-11-25  394  		return 0;
4008e2a0b01aba Damien Le Moal 2022-11-25  395  
4008e2a0b01aba Damien Le Moal 2022-11-25  396  	bio = bio_alloc(bdev, nr_pages,
4008e2a0b01aba Damien Le Moal 2022-11-25  397  			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
4008e2a0b01aba Damien Le Moal 2022-11-25  398  	bio->bi_iter.bi_sector = zi->i_zsector;
4008e2a0b01aba Damien Le Moal 2022-11-25  399  	bio->bi_ioprio = iocb->ki_ioprio;
4008e2a0b01aba Damien Le Moal 2022-11-25  400  	if (iocb_is_dsync(iocb))
4008e2a0b01aba Damien Le Moal 2022-11-25  401  		bio->bi_opf |= REQ_FUA;
4008e2a0b01aba Damien Le Moal 2022-11-25  402  
4008e2a0b01aba Damien Le Moal 2022-11-25  403  	ret = bio_iov_iter_get_pages(bio, from);
4008e2a0b01aba Damien Le Moal 2022-11-25  404  	if (unlikely(ret))
4008e2a0b01aba Damien Le Moal 2022-11-25  405  		goto out_release;

This is a false positive because bio_iov_iter_get_pages() is returning
negatives on this error path.  Building the cross function database
would silence this warning.  Still it's not just Smatch which is going
to complain and GCC extensions are most likely going to initialize size
to zero anyway.

4008e2a0b01aba Damien Le Moal 2022-11-25  406  
4008e2a0b01aba Damien Le Moal 2022-11-25  407  	size = bio->bi_iter.bi_size;
4008e2a0b01aba Damien Le Moal 2022-11-25  408  	task_io_account_write(size);
4008e2a0b01aba Damien Le Moal 2022-11-25  409  
4008e2a0b01aba Damien Le Moal 2022-11-25  410  	if (iocb->ki_flags & IOCB_HIPRI)
4008e2a0b01aba Damien Le Moal 2022-11-25  411  		bio_set_polled(bio, iocb);
4008e2a0b01aba Damien Le Moal 2022-11-25  412  
4008e2a0b01aba Damien Le Moal 2022-11-25  413  	ret = submit_bio_wait(bio);
4008e2a0b01aba Damien Le Moal 2022-11-25  414  
4008e2a0b01aba Damien Le Moal 2022-11-25  415  	/*
4008e2a0b01aba Damien Le Moal 2022-11-25  416  	 * If the file zone was written underneath the file system, the zone
4008e2a0b01aba Damien Le Moal 2022-11-25  417  	 * write pointer may not be where we expect it to be, but the zone
4008e2a0b01aba Damien Le Moal 2022-11-25  418  	 * append write can still succeed. So check manually that we wrote where
4008e2a0b01aba Damien Le Moal 2022-11-25  419  	 * we intended to, that is, at zi->i_wpoffset.
4008e2a0b01aba Damien Le Moal 2022-11-25  420  	 */
4008e2a0b01aba Damien Le Moal 2022-11-25  421  	if (!ret) {
4008e2a0b01aba Damien Le Moal 2022-11-25  422  		sector_t wpsector =
4008e2a0b01aba Damien Le Moal 2022-11-25  423  			zi->i_zsector + (zi->i_wpoffset >> SECTOR_SHIFT);
4008e2a0b01aba Damien Le Moal 2022-11-25  424  
4008e2a0b01aba Damien Le Moal 2022-11-25  425  		if (bio->bi_iter.bi_sector != wpsector) {
4008e2a0b01aba Damien Le Moal 2022-11-25  426  			zonefs_warn(inode->i_sb,
4008e2a0b01aba Damien Le Moal 2022-11-25  427  				"Corrupted write pointer %llu for zone at %llu\n",
4008e2a0b01aba Damien Le Moal 2022-11-25  428  				wpsector, zi->i_zsector);
4008e2a0b01aba Damien Le Moal 2022-11-25  429  			ret = -EIO;
4008e2a0b01aba Damien Le Moal 2022-11-25  430  		}
4008e2a0b01aba Damien Le Moal 2022-11-25  431  	}
4008e2a0b01aba Damien Le Moal 2022-11-25  432  
4008e2a0b01aba Damien Le Moal 2022-11-25  433  	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
4008e2a0b01aba Damien Le Moal 2022-11-25  434  	trace_zonefs_file_dio_append(inode, size, ret);
4008e2a0b01aba Damien Le Moal 2022-11-25  435  
4008e2a0b01aba Damien Le Moal 2022-11-25  436  out_release:
4008e2a0b01aba Damien Le Moal 2022-11-25  437  	bio_release_pages(bio, false);
4008e2a0b01aba Damien Le Moal 2022-11-25  438  	bio_put(bio);
4008e2a0b01aba Damien Le Moal 2022-11-25  439  
4008e2a0b01aba Damien Le Moal 2022-11-25  440  	if (ret >= 0) {
4008e2a0b01aba Damien Le Moal 2022-11-25 @441  		iocb->ki_pos += size;
4008e2a0b01aba Damien Le Moal 2022-11-25  442  		return size;
4008e2a0b01aba Damien Le Moal 2022-11-25  443  	}
4008e2a0b01aba Damien Le Moal 2022-11-25  444  
4008e2a0b01aba Damien Le Moal 2022-11-25  445  	return ret;
4008e2a0b01aba Damien Le Moal 2022-11-25  446  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

