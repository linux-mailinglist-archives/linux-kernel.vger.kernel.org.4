Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFC6FE1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbjEJPi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjEJPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:38:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222E719B4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:38:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso38338965e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683733100; x=1686325100;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FAQoNbre0FsDXKzpUgqTNuLSD+XLqPxWH+hYHe3dIQ=;
        b=Xb7wK3tPCgTn92pn2iFaqW9dREWyeCq5B9aVjXqcjc1UjRLdt8us5Ew9xQVy/vY/4P
         vcmbPC7HU5N6bhfRG+bLwaLrALL2w3lIJxdwe163JbchdVhtjWQQbYEDui9km65S/OfS
         HzMWYou8pPQdd/rlv/972r7MnGzHE1aJXhVBirTSavwnwoS21Empbxo/1K4iohkIYAMd
         FmgxbXyU38YuL9T3OEz4JPys/qjBYuobytm7yF5UmGoNenMybdv4bvsCrBt4Z7N7Z6MS
         5KPoczVoCy8szy+Cv5esahdQtXdwWDQqpshnwDPCEaDrYfXhSPhTL6nEa19RuMDlqOuu
         6yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683733100; x=1686325100;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FAQoNbre0FsDXKzpUgqTNuLSD+XLqPxWH+hYHe3dIQ=;
        b=GsISg+Rq3Hy5GAVzuMbaf8wl765ZrPfQF9oPDhQAsXfZ3PahcNCJfun7c0qrT22Mnt
         0NB7uylUNGWt3KCQZ7JYjAv93iRr3RAVI8EyLfpJcJHXvGAbkH+TOG8dLqFt3XIkd8hK
         elaEnffeAHerJsqwsiLdNsYWiGFtkE55zE7HbtPdQ5U0STR6bCGThY9WlbG96eisw18A
         YPuCOHBApdTdj+NO7eQDPN3DRADNeN/MukeGnixJiGd2T8NMzCDXGBCUosMZpI6jXjwd
         q3x3GlySxvVTPPQcqSLYt/N7vs/kyVuEyFsCc370O9OAnhq1oeoRgLsR+Uu1uLrftQN+
         8IEw==
X-Gm-Message-State: AC+VfDxEfoNIZwE+djTV2U8FExiHR2i72T5PqtSJV3Vp2IUbP6B3vlQV
        WISid9CNs/QVwxxOpdochXAChQ==
X-Google-Smtp-Source: ACHHUZ7rY3ZwXCWbT7a6XTw9vvs4ouHN/edMh3i+1gRTvOPkefoTDCNKnCpLC1laYYpKyl0WYMVapQ==
X-Received: by 2002:a05:600c:2056:b0:3f4:2bbf:40a with SMTP id p22-20020a05600c205600b003f42bbf040amr4392894wmg.37.1683733100492;
        Wed, 10 May 2023 08:38:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l11-20020a7bc34b000000b003f195d2f1a9sm23022460wmj.15.2023.05.10.08.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:38:18 -0700 (PDT)
Date:   Wed, 10 May 2023 18:38:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        George Kennedy <george.kennedy@oracle.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        george.kennedy@oracle.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux@weissschuh.net,
        regressions@lists.linux.dev
Subject: Re: [PATCH] vc_screen: reload load of struct vc_data pointer in
 vcs_write() to avoid UAF
Message-ID: <ad36d0ab-e81f-4f21-a5a4-8a72c88e61bd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683659319-29701-1-git-send-email-george.kennedy@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Kennedy/vc_screen-reload-load-of-struct-vc_data-pointer-in-vcs_write-to-avoid-UAF/20230510-031202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/1683659319-29701-1-git-send-email-george.kennedy%40oracle.com
patch subject: [PATCH] vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF
config: ia64-randconfig-m031-20230509 (https://download.01.org/0day-ci/archive/20230510/202305101936.1ROFaVa9-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305101936.1ROFaVa9-lkp@intel.com/

smatch warnings:
drivers/tty/vt/vc_screen.c:707 vcs_write() warn: maybe return -EFAULT instead of the bytes remaining?

vim +707 drivers/tty/vt/vc_screen.c

^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  589  static ssize_t
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  590  vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  591  {
496ad9aa8ef448 drivers/tty/vt/vc_screen.c Al Viro        2013-01-23  592  	struct inode *inode = file_inode(file);
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  593  	struct vc_data *vc;
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  594  	char *con_buf;
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  595  	u16 *org0, *org;
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  596  	unsigned int written;
2665bef49f96df drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  597  	int size;
2665bef49f96df drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  598  	ssize_t ret;
2665bef49f96df drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  599  	loff_t pos;
2665bef49f96df drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  600  	bool viewed, attr;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  601  
0c9acb1af77a3c drivers/tty/vt/vc_screen.c Nicolas Pitre  2019-11-05  602  	if (use_unicode(inode))
0c9acb1af77a3c drivers/tty/vt/vc_screen.c Nicolas Pitre  2019-11-05  603  		return -EOPNOTSUPP;
0c9acb1af77a3c drivers/tty/vt/vc_screen.c Nicolas Pitre  2019-11-05  604  
fcdba07ee390d9 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  605  	con_buf = (char *) __get_free_page(GFP_KERNEL);
fcdba07ee390d9 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  606  	if (!con_buf)
fcdba07ee390d9 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  607  		return -ENOMEM;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  608  
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  609  	pos = *ppos;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  610  
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  611  	/* Select the proper current console and verify
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  612  	 * sanity of the situation under the console lock.
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  613  	 */
ac751efa6a0d70 drivers/tty/vt/vc_screen.c Torben Hohn    2011-01-25  614  	console_lock();
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  615  
d21b0be246bf3b drivers/tty/vt/vc_screen.c Nicolas Pitre  2018-06-26  616  	attr = use_attributes(inode);
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  617  	ret = -ENXIO;
fcdba07ee390d9 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  618  	vc = vcs_vc(inode, &viewed);
fcdba07ee390d9 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  619  	if (!vc)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  620  		goto unlock_out;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  621  
71d4abfab322e8 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  622  	size = vcs_size(vc, attr, false);
71d4abfab322e8 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  623  	if (size < 0) {
71d4abfab322e8 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  624  		ret = size;
71d4abfab322e8 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  625  		goto unlock_out;
71d4abfab322e8 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  626  	}
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  627  	ret = -EINVAL;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  628  	if (pos < 0 || pos > size)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  629  		goto unlock_out;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  630  	if (count > size - pos)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  631  		count = size - pos;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  632  	written = 0;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  633  	while (count) {
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  634  		unsigned int this_round = count;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  635  
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  636  		if (this_round > CON_BUF_SIZE)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  637  			this_round = CON_BUF_SIZE;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  638  
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  639  		/* Temporarily drop the console lock so that we can read
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  640  		 * in the write data from userspace safely.
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  641  		 */
ac751efa6a0d70 drivers/tty/vt/vc_screen.c Torben Hohn    2011-01-25  642  		console_unlock();
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  643  		ret = copy_from_user(con_buf, buf, this_round);
ac751efa6a0d70 drivers/tty/vt/vc_screen.c Torben Hohn    2011-01-25  644  		console_lock();
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  645  
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  646  		if (ret) {
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  647  			this_round -= ret;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  648  			if (!this_round) {
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  649  				/* Abort loop if no data were copied. Otherwise
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  650  				 * fail with -EFAULT.
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  651  				 */
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  652  				if (written)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  653  					break;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  654  				ret = -EFAULT;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  655  				goto unlock_out;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  656  			}
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  657  		}
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  658  
50f4095ab8ede7 drivers/tty/vt/vc_screen.c George Kennedy 2023-05-09  659  		/* The vc might have been freed or vcs_size might have changed
50f4095ab8ede7 drivers/tty/vt/vc_screen.c George Kennedy 2023-05-09  660  		 * while we slept to grab the user buffer, so recheck.
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  661  		 * Return data written up to now on failure.
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  662  		 */
50f4095ab8ede7 drivers/tty/vt/vc_screen.c George Kennedy 2023-05-09  663  		vc = vcs_vc(inode, &viewed);
50f4095ab8ede7 drivers/tty/vt/vc_screen.c George Kennedy 2023-05-09  664  		if (!vc) {
50f4095ab8ede7 drivers/tty/vt/vc_screen.c George Kennedy 2023-05-09  665  			if (written)
50f4095ab8ede7 drivers/tty/vt/vc_screen.c George Kennedy 2023-05-09  666  				break;
50f4095ab8ede7 drivers/tty/vt/vc_screen.c George Kennedy 2023-05-09  667  			goto unlock_out;

The warning message is wrong, but there does need to be a
"ret = something" here.  Either an error code or ret = size on success.

50f4095ab8ede7 drivers/tty/vt/vc_screen.c George Kennedy 2023-05-09  668  		}
71d4abfab322e8 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  669  		size = vcs_size(vc, attr, false);
dc1892c4bc6960 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  670  		if (size < 0) {
dc1892c4bc6960 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  671  			if (written)
dc1892c4bc6960 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  672  				break;
dc1892c4bc6960 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  673  			ret = size;
dc1892c4bc6960 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  674  			goto unlock_out;
dc1892c4bc6960 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  675  		}
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  676  		if (pos >= size)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  677  			break;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  678  		if (this_round > size - pos)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  679  			this_round = size - pos;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  680  
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  681  		/* OK, now actually push the write to the console
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  682  		 * under the lock using the local kernel buffer.
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  683  		 */
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  684  
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  685  		if (attr)
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  686  			org = vcs_write_buf(vc, con_buf, pos, this_round,
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  687  					viewed, &org0);
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  688  		else
9e6363784e3f1e drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  689  			org = vcs_write_buf_noattr(vc, con_buf, pos, this_round,
9e6363784e3f1e drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  690  					viewed, &org0);
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  691  
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  692  		count -= this_round;
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  693  		written += this_round;
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  694  		buf += this_round;
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  695  		pos += this_round;
95e0d57fd49780 drivers/tty/vt/vc_screen.c Jiri Slaby     2020-08-18  696  		if (org)
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  697  			update_region(vc, (unsigned long)(org0), org - org0);
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  698  	}
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  699  	*ppos += written;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  700  	ret = written;
432c9ed22aff64 drivers/char/vc_screen.c   Nicolas Pitre  2010-10-01  701  	if (written)
432c9ed22aff64 drivers/char/vc_screen.c   Nicolas Pitre  2010-10-01  702  		vcs_scr_updated(vc);
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  703  
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  704  unlock_out:
ac751efa6a0d70 drivers/tty/vt/vc_screen.c Torben Hohn    2011-01-25  705  	console_unlock();
fcdba07ee390d9 drivers/tty/vt/vc_screen.c Jiri Olsa      2011-02-07  706  	free_page((unsigned long) con_buf);
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16 @707  	return ret;
^1da177e4c3f41 drivers/char/vc_screen.c   Linus Torvalds 2005-04-16  708  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

