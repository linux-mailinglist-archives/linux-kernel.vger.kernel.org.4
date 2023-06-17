Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39452733EBA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjFQGjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjFQGjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:39:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601CB2721
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686983962; x=1718519962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a/GcUO5RmZuj/9Xe5/8mvDW2JA/dFr1+oCRjc+bAqEc=;
  b=Ce7vAATNc1HjgabPt2nCnCYZyXPKDVsDrMYtawDItN9NRfZsQEbM04Li
   Y83nR+axA10T/f6ZN8O4Dn12yZAeWzqEvIZy36yNIrmdt4oPJ4ZbtUoO7
   Gl0t7D6U3pKedb95dhghWBZAbp9hCNrRzVZMqM6WojKPF2gVzZu4MSg2b
   PkjrUP/VxWyPZ4oR+VkI14NjiZDTSReEFdcjdhZk74FyAlLahDH+L9uv6
   lAL1wyV/VI7hKcSkGzN7Iq5kQMeJK+d99B3tiv5df6eLtR3sd0Gnxw9/+
   JO3pYSGHfkReI60JaHL79vcrireZO17azgfZ7W4ad5Eb0KTH5jfwEuhke
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="361902066"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="361902066"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 23:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="716287833"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="716287833"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2023 23:39:20 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAPah-0002OW-18;
        Sat, 17 Jun 2023 06:39:19 +0000
Date:   Sat, 17 Jun 2023 14:38:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: net/bluetooth/bnep/core.c:478:12: warning: stack frame size (2112)
 exceeds limit (2048) in 'bnep_session'
Message-ID: <202306171406.rQWGJPpr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1639fae5132bc8a904af28d97cea0bedb3af802e
commit: 03f61041c17914355dde7261be9ccdc821ddd454 skbuff: Switch structure bounds to struct_group()
date:   1 year, 7 months ago
config: riscv-randconfig-r006-20230616 (https://download.01.org/0day-ci/archive/20230617/202306171406.rQWGJPpr-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306171406.rQWGJPpr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306171406.rQWGJPpr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bluetooth/bnep/core.c:478:12: warning: stack frame size (2112) exceeds limit (2048) in 'bnep_session' [-Wframe-larger-than]
   static int bnep_session(void *arg)
              ^
   2008/2112 (95.08%) spills, 104/2112 (4.92%) variables
   1 warning generated.


vim +/bnep_session +478 net/bluetooth/bnep/core.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  477  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @478  static int bnep_session(void *arg)
^1da177e4c3f41 Linus Torvalds  2005-04-16  479  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  480  	struct bnep_session *s = arg;
^1da177e4c3f41 Linus Torvalds  2005-04-16  481  	struct net_device *dev = s->dev;
^1da177e4c3f41 Linus Torvalds  2005-04-16  482  	struct sock *sk = s->sock->sk;
^1da177e4c3f41 Linus Torvalds  2005-04-16  483  	struct sk_buff *skb;
25717382c1dd0d Jeffy Chen      2017-06-27  484  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
^1da177e4c3f41 Linus Torvalds  2005-04-16  485  
^1da177e4c3f41 Linus Torvalds  2005-04-16  486  	BT_DBG("");
^1da177e4c3f41 Linus Torvalds  2005-04-16  487  
^1da177e4c3f41 Linus Torvalds  2005-04-16  488  	set_user_nice(current, -15);
^1da177e4c3f41 Linus Torvalds  2005-04-16  489  
aa395145165cb0 Eric Dumazet    2010-04-20  490  	add_wait_queue(sk_sleep(sk), &wait);
38d57555616afc Peter Hurley    2011-07-24  491  	while (1) {
751c10a5680251 Peter Hurley    2011-08-05  492  		if (atomic_read(&s->terminate))
38d57555616afc Peter Hurley    2011-07-24  493  			break;
3aad75a128e2f2 Szymon Janc     2011-03-21  494  		/* RX */
^1da177e4c3f41 Linus Torvalds  2005-04-16  495  		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  496  			skb_orphan(skb);
449357200c5d73 Mat Martineau   2011-07-22  497  			if (!skb_linearize(skb))
^1da177e4c3f41 Linus Torvalds  2005-04-16  498  				bnep_rx_frame(s, skb);
449357200c5d73 Mat Martineau   2011-07-22  499  			else
449357200c5d73 Mat Martineau   2011-07-22  500  				kfree_skb(skb);
^1da177e4c3f41 Linus Torvalds  2005-04-16  501  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  502  
^1da177e4c3f41 Linus Torvalds  2005-04-16  503  		if (sk->sk_state != BT_CONNECTED)
^1da177e4c3f41 Linus Torvalds  2005-04-16  504  			break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  505  
3aad75a128e2f2 Szymon Janc     2011-03-21  506  		/* TX */
^1da177e4c3f41 Linus Torvalds  2005-04-16  507  		while ((skb = skb_dequeue(&sk->sk_write_queue)))
^1da177e4c3f41 Linus Torvalds  2005-04-16  508  			if (bnep_tx_frame(s, skb))
^1da177e4c3f41 Linus Torvalds  2005-04-16  509  				break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  510  		netif_wake_queue(dev);
^1da177e4c3f41 Linus Torvalds  2005-04-16  511  
5aac49378742a5 Andrea Parri    2018-08-14  512  		/*
5aac49378742a5 Andrea Parri    2018-08-14  513  		 * wait_woken() performs the necessary memory barriers
5aac49378742a5 Andrea Parri    2018-08-14  514  		 * for us; see the header comment for this primitive.
5aac49378742a5 Andrea Parri    2018-08-14  515  		 */
25717382c1dd0d Jeffy Chen      2017-06-27  516  		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
^1da177e4c3f41 Linus Torvalds  2005-04-16  517  	}
aa395145165cb0 Eric Dumazet    2010-04-20  518  	remove_wait_queue(sk_sleep(sk), &wait);
^1da177e4c3f41 Linus Torvalds  2005-04-16  519  
^1da177e4c3f41 Linus Torvalds  2005-04-16  520  	/* Cleanup session */
^1da177e4c3f41 Linus Torvalds  2005-04-16  521  	down_write(&bnep_session_sem);
^1da177e4c3f41 Linus Torvalds  2005-04-16  522  
^1da177e4c3f41 Linus Torvalds  2005-04-16  523  	/* Delete network device */
^1da177e4c3f41 Linus Torvalds  2005-04-16  524  	unregister_netdev(dev);
^1da177e4c3f41 Linus Torvalds  2005-04-16  525  
ec8dab36e0738d Marcel Holtmann 2008-07-14  526  	/* Wakeup user-space polling for socket errors */
ec8dab36e0738d Marcel Holtmann 2008-07-14  527  	s->sock->sk->sk_err = EUNATCH;
ec8dab36e0738d Marcel Holtmann 2008-07-14  528  
aa395145165cb0 Eric Dumazet    2010-04-20  529  	wake_up_interruptible(sk_sleep(s->sock->sk));
ec8dab36e0738d Marcel Holtmann 2008-07-14  530  
^1da177e4c3f41 Linus Torvalds  2005-04-16  531  	/* Release the socket */
^1da177e4c3f41 Linus Torvalds  2005-04-16  532  	fput(s->sock->file);
^1da177e4c3f41 Linus Torvalds  2005-04-16  533  
^1da177e4c3f41 Linus Torvalds  2005-04-16  534  	__bnep_unlink_session(s);
^1da177e4c3f41 Linus Torvalds  2005-04-16  535  
^1da177e4c3f41 Linus Torvalds  2005-04-16  536  	up_write(&bnep_session_sem);
^1da177e4c3f41 Linus Torvalds  2005-04-16  537  	free_netdev(dev);
9b338c3dd12918 David Herrmann  2011-11-19  538  	module_put_and_exit(0);
^1da177e4c3f41 Linus Torvalds  2005-04-16  539  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  540  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  541  

:::::: The code at line 478 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
