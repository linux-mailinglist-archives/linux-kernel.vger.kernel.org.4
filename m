Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EC471262C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjEZMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjEZMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:02:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AFA116;
        Fri, 26 May 2023 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685102564; x=1716638564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=niAd+MYPww6pzAj+PuY1sjn6jmYsE0NCxyfY/H+h0AI=;
  b=C7R/2Oc+GfZKEmusvzmq4fwUCtsz0VO+Rr9VSxUoEe+qYqRhIPRibkCd
   +0ngHSmb2Yu8LQ/xeCgxQ1le12iKgs/pv8hprcudnkhy9eiwv37hznlXP
   Gistf6jJwSuwJqyd7PKZlK4vGchZlQz6mYApNKOKQtShQXR511CBE/Fqc
   LrkzLhklQsnM/otGeZfA3Ecg1qXnXFSF7gFoHrWE2sUkN/3vmKtchjl2U
   +86m0hfBLNxpowZLZn0u7sLO1XXt3RK4+Z/KMG97ckdvAjuTqeZxRySYz
   3Dgq0KBRVoUz5Re55lb+4QEJI/6/ooRrZjea6x1aD9TlexHYclMpARlKe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="333812773"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="333812773"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="738231141"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="738231141"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2023 05:02:30 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2W9N-000JJC-1f;
        Fri, 26 May 2023 12:02:29 +0000
Date:   Fri, 26 May 2023 20:01:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sungwoo Kim <iam@sung-woo.kim>
Cc:     oe-kbuild-all@lists.linux.dev, wuruoyu@me.com, benquike@gmail.com,
        daveti@purdue.edu, Sungwoo Kim <iam@sung-woo.kim>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_ready_cb
Message-ID: <202305261912.mKLcy6Fw-lkp@intel.com>
References: <20230526084038.2199788-1-iam@sung-woo.kim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526084038.2199788-1-iam@sung-woo.kim>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sungwoo,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sungwoo-Kim/Bluetooth-L2CAP-Fix-use-after-free-in-l2cap_sock_ready_cb/20230526-164241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20230526084038.2199788-1-iam%40sung-woo.kim
patch subject: [PATCH] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230526/202305261912.mKLcy6Fw-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c0c02b1afbe2667fe21aed47375c4e0d45713f38
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sungwoo-Kim/Bluetooth-L2CAP-Fix-use-after-free-in-l2cap_sock_ready_cb/20230526-164241
        git checkout c0c02b1afbe2667fe21aed47375c4e0d45713f38
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash net/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305261912.mKLcy6Fw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/bluetooth/l2cap_sock.c: In function 'l2cap_sock_release':
>> net/bluetooth/l2cap_sock.c:1418:9: error: implicit declaration of function 'l2cap_sock_cleanup_listen'; did you mean 'l2cap_sock_listen'? [-Werror=implicit-function-declaration]
    1418 |         l2cap_sock_cleanup_listen(sk);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         l2cap_sock_listen
   net/bluetooth/l2cap_sock.c: At top level:
>> net/bluetooth/l2cap_sock.c:1436:13: warning: conflicting types for 'l2cap_sock_cleanup_listen'; have 'void(struct sock *)'
    1436 | static void l2cap_sock_cleanup_listen(struct sock *parent)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bluetooth/l2cap_sock.c:1436:13: error: static declaration of 'l2cap_sock_cleanup_listen' follows non-static declaration
   net/bluetooth/l2cap_sock.c:1418:9: note: previous implicit declaration of 'l2cap_sock_cleanup_listen' with type 'void(struct sock *)'
    1418 |         l2cap_sock_cleanup_listen(sk);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1418 net/bluetooth/l2cap_sock.c

  1406	
  1407	static int l2cap_sock_release(struct socket *sock)
  1408	{
  1409		struct sock *sk = sock->sk;
  1410		int err;
  1411		struct l2cap_chan *chan;
  1412	
  1413		BT_DBG("sock %p, sk %p", sock, sk);
  1414	
  1415		if (!sk)
  1416			return 0;
  1417	
> 1418		l2cap_sock_cleanup_listen(sk);
  1419		bt_sock_unlink(&l2cap_sk_list, sk);
  1420	
  1421		err = l2cap_sock_shutdown(sock, SHUT_RDWR);
  1422		chan = l2cap_pi(sk)->chan;
  1423	
  1424		l2cap_chan_hold(chan);
  1425		l2cap_chan_lock(chan);
  1426	
  1427		sock_orphan(sk);
  1428		l2cap_sock_kill(sk);
  1429	
  1430		l2cap_chan_unlock(chan);
  1431		l2cap_chan_put(chan);
  1432	
  1433		return err;
  1434	}
  1435	
> 1436	static void l2cap_sock_cleanup_listen(struct sock *parent)
  1437	{
  1438		struct sock *sk;
  1439	
  1440		BT_DBG("parent %p state %s", parent,
  1441		       state_to_string(parent->sk_state));
  1442	
  1443		/* Close not yet accepted channels */
  1444		while ((sk = bt_accept_dequeue(parent, NULL))) {
  1445			struct l2cap_chan *chan = l2cap_pi(sk)->chan;
  1446	
  1447			BT_DBG("child chan %p state %s", chan,
  1448			       state_to_string(chan->state));
  1449	
  1450			l2cap_chan_hold(chan);
  1451			l2cap_chan_lock(chan);
  1452	
  1453			__clear_chan_timer(chan);
  1454			l2cap_chan_close(chan, ECONNRESET);
  1455			l2cap_sock_kill(sk);
  1456	
  1457			l2cap_chan_unlock(chan);
  1458			l2cap_chan_put(chan);
  1459		}
  1460	}
  1461	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
