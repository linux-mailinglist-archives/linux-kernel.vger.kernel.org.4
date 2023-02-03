Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7AA6897C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBCLa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCLa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:30:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8555A9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:30:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so4340266wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 03:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBQjtoGHHgqblX9RDRub+u5uqU4jup01+5+erIPdZwM=;
        b=dAiyQMjKSt9ndJtDjBZ/ofTPZOTeCfiQH206n5H+iIKpJIPr7siML8X1IphJXWzxtz
         EtUwocmx3nxf+RSn+AFrlxrIXPBXh8p1YAOVnYcRA3pfO5YtWVJ4whOVDwN5lfClOWGZ
         P2FwayBIUkwaVbdue+CoquyA6V8okieTt+Q6wVBboO3l4KcUmNagOQ3Ki89XNXo+ddxw
         v3cHDrLhIIewKQhyhbQ5dEPcSs+okKMpQCZxO7UrWRVrDiKEvgFougXyL560Ox09psoA
         gnSJS7WeylAZ88iZE0mnJWOcT6v0SMJNtL6wCr10euHFYRo8DYh4RXGouXdUI1MVDuGy
         RzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBQjtoGHHgqblX9RDRub+u5uqU4jup01+5+erIPdZwM=;
        b=1kxaALpzoncxe8mXsfBQ6m5x5dmZ8tNW+aZ8Dx9frX20uJ3RLRKE2KaUCJ+xfgJroW
         c/nyZDuqW/b+HlIub301KSfNaYThe1BOd1Qg2iZgNnTKn0tpocGeaNzzCX6DQgR6ScTc
         DQfA68EReKMWCf3mDDG3iF7LZx0s7cQ7uH3J+qjAbNlE+F9MCYBtaGRk+IBGfQLIEIrR
         foJE3i2I9+gUAWgfSsXVK5Mr54MY6huT1YObG5hMeewdZdtfyRkvtOqqBIppABHs7rqF
         xfXlL8XLpi+5cwMpumVUNQjeKOBwE492cgn6u1pU3TdFJPRez3yUXBI2uwbMu1thgcZn
         qBjA==
X-Gm-Message-State: AO0yUKXzsNxYTb2u0aDc9vog5jyJdC4/t3IjAVoMqIMVPNjFzMKMtMzE
        5R//kDtdMWs5Rj4T2CclGF8=
X-Google-Smtp-Source: AK7set+wwtWTop0v2FxlIUbjvMTzk7G71xpzSxEDSgPBIPgQbcRL2JfA+6kUDKGNn2S3L5k+wmMcYg==
X-Received: by 2002:adf:b355:0:b0:2bd:c83a:6e3 with SMTP id k21-20020adfb355000000b002bdc83a06e3mr8123753wrd.7.1675423853355;
        Fri, 03 Feb 2023 03:30:53 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d5989000000b002bc7fcf08ddsm1878761wri.103.2023.02.03.03.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 03:30:52 -0800 (PST)
Date:   Fri, 3 Feb 2023 11:56:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Cong Wang <cong.wang@bytedance.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guillaume Nault <gnault@redhat.com>
Subject: net/l2tp/l2tp_core.c:1481 l2tp_tunnel_register() warn: missing error
 code 'ret'
Message-ID: <202302031144.yY6UaRcD-lkp@intel.com>
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
head:   66a87fff1a87c260452f5a57123891ca5258c449
commit: c4d48a58f32c5972174a1d01c33b296fe378cce0 l2tp: convert l2tp_tunnel_list to idr
config: powerpc-randconfig-m031-20230202 (https://download.01.org/0day-ci/archive/20230203/202302031144.yY6UaRcD-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
net/l2tp/l2tp_core.c:1481 l2tp_tunnel_register() warn: missing error code 'ret'

vim +/ret +1481 net/l2tp/l2tp_core.c

6b9f34239b00e6 Guillaume Nault 2018-04-10  1456  int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
6b9f34239b00e6 Guillaume Nault 2018-04-10  1457  			 struct l2tp_tunnel_cfg *cfg)
6b9f34239b00e6 Guillaume Nault 2018-04-10  1458  {
c4d48a58f32c59 Cong Wang       2023-01-13  1459  	struct l2tp_net *pn = l2tp_pernet(net);
c4d48a58f32c59 Cong Wang       2023-01-13  1460  	u32 tunnel_id = tunnel->tunnel_id;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1461  	struct socket *sock;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1462  	struct sock *sk;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1463  	int ret;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1464  
c4d48a58f32c59 Cong Wang       2023-01-13  1465  	spin_lock_bh(&pn->l2tp_tunnel_idr_lock);
c4d48a58f32c59 Cong Wang       2023-01-13  1466  	ret = idr_alloc_u32(&pn->l2tp_tunnel_idr, NULL, &tunnel_id, tunnel_id,
c4d48a58f32c59 Cong Wang       2023-01-13  1467  			    GFP_ATOMIC);
c4d48a58f32c59 Cong Wang       2023-01-13  1468  	spin_unlock_bh(&pn->l2tp_tunnel_idr_lock);
c4d48a58f32c59 Cong Wang       2023-01-13  1469  	if (ret)
c4d48a58f32c59 Cong Wang       2023-01-13  1470  		return ret == -ENOSPC ? -EEXIST : ret;
c4d48a58f32c59 Cong Wang       2023-01-13  1471  
6b9f34239b00e6 Guillaume Nault 2018-04-10  1472  	if (tunnel->fd < 0) {
6b9f34239b00e6 Guillaume Nault 2018-04-10  1473  		ret = l2tp_tunnel_sock_create(net, tunnel->tunnel_id,
6b9f34239b00e6 Guillaume Nault 2018-04-10  1474  					      tunnel->peer_tunnel_id, cfg,
6b9f34239b00e6 Guillaume Nault 2018-04-10  1475  					      &sock);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1476  		if (ret < 0)
6b9f34239b00e6 Guillaume Nault 2018-04-10  1477  			goto err;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1478  	} else {
6b9f34239b00e6 Guillaume Nault 2018-04-10  1479  		sock = sockfd_lookup(tunnel->fd, &ret);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1480  		if (!sock)
6b9f34239b00e6 Guillaume Nault 2018-04-10 @1481  			goto err;
                                                                        ^^^^^^^^^
I don't know why this is showing up as a 3 week old warning when it
looks like the code is from 2018...  Anyway, should this be an error
path or a success path?

b68777d54fac21 Jakub Sitnicki  2022-11-14  1482  	}
b68777d54fac21 Jakub Sitnicki  2022-11-14  1483  
b68777d54fac21 Jakub Sitnicki  2022-11-14  1484  	sk = sock->sk;
af295e854a4e38 Jakub Sitnicki  2022-11-21  1485  	write_lock_bh(&sk->sk_callback_lock);
b68777d54fac21 Jakub Sitnicki  2022-11-14  1486  	ret = l2tp_validate_socket(sk, net, tunnel->encap);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1487  	if (ret < 0)
af295e854a4e38 Jakub Sitnicki  2022-11-21  1488  		goto err_inval_sock;
af295e854a4e38 Jakub Sitnicki  2022-11-21  1489  	rcu_assign_sk_user_data(sk, tunnel);
af295e854a4e38 Jakub Sitnicki  2022-11-21  1490  	write_unlock_bh(&sk->sk_callback_lock);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1491  
69e16d01d1de4f Gong, Sishuai   2021-04-27  1492  	sock_hold(sk);
69e16d01d1de4f Gong, Sishuai   2021-04-27  1493  	tunnel->sock = sk;
c4d48a58f32c59 Cong Wang       2023-01-13  1494  	tunnel->l2tp_net = net;
69e16d01d1de4f Gong, Sishuai   2021-04-27  1495  
c4d48a58f32c59 Cong Wang       2023-01-13  1496  	spin_lock_bh(&pn->l2tp_tunnel_idr_lock);
c4d48a58f32c59 Cong Wang       2023-01-13  1497  	idr_replace(&pn->l2tp_tunnel_idr, tunnel, tunnel->tunnel_id);
c4d48a58f32c59 Cong Wang       2023-01-13  1498  	spin_unlock_bh(&pn->l2tp_tunnel_idr_lock);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1499  
6b9f34239b00e6 Guillaume Nault 2018-04-10  1500  	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
6b9f34239b00e6 Guillaume Nault 2018-04-10  1501  		struct udp_tunnel_sock_cfg udp_cfg = {
6b9f34239b00e6 Guillaume Nault 2018-04-10  1502  			.sk_user_data = tunnel,
6b9f34239b00e6 Guillaume Nault 2018-04-10  1503  			.encap_type = UDP_ENCAP_L2TPINUDP,
6b9f34239b00e6 Guillaume Nault 2018-04-10  1504  			.encap_rcv = l2tp_udp_encap_recv,
6b9f34239b00e6 Guillaume Nault 2018-04-10  1505  			.encap_destroy = l2tp_udp_encap_destroy,
6b9f34239b00e6 Guillaume Nault 2018-04-10  1506  		};
6b9f34239b00e6 Guillaume Nault 2018-04-10  1507  
6b9f34239b00e6 Guillaume Nault 2018-04-10  1508  		setup_udp_tunnel_sock(net, sock, &udp_cfg);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1509  	}
6b9f34239b00e6 Guillaume Nault 2018-04-10  1510  
6b9f34239b00e6 Guillaume Nault 2018-04-10  1511  	tunnel->old_sk_destruct = sk->sk_destruct;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1512  	sk->sk_destruct = &l2tp_tunnel_destruct;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1513  	lockdep_set_class_and_name(&sk->sk_lock.slock, &l2tp_socket_class,
6b9f34239b00e6 Guillaume Nault 2018-04-10  1514  				   "l2tp_sock");
6b9f34239b00e6 Guillaume Nault 2018-04-10  1515  	sk->sk_allocation = GFP_ATOMIC;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1516  
6b7bdcd7ca01d8 Tom Parkin      2020-08-22  1517  	trace_register_tunnel(tunnel);
6b7bdcd7ca01d8 Tom Parkin      2020-08-22  1518  
6b9f34239b00e6 Guillaume Nault 2018-04-10  1519  	if (tunnel->fd >= 0)
6b9f34239b00e6 Guillaume Nault 2018-04-10  1520  		sockfd_put(sock);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1521  
6b9f34239b00e6 Guillaume Nault 2018-04-10  1522  	return 0;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1523  
af295e854a4e38 Jakub Sitnicki  2022-11-21  1524  err_inval_sock:
af295e854a4e38 Jakub Sitnicki  2022-11-21  1525  	write_unlock_bh(&sk->sk_callback_lock);
af295e854a4e38 Jakub Sitnicki  2022-11-21  1526  
f6cd651b056ffd Guillaume Nault 2018-04-10  1527  	if (tunnel->fd < 0)
f6cd651b056ffd Guillaume Nault 2018-04-10  1528  		sock_release(sock);
f6cd651b056ffd Guillaume Nault 2018-04-10  1529  	else
6b9f34239b00e6 Guillaume Nault 2018-04-10  1530  		sockfd_put(sock);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1531  err:
c4d48a58f32c59 Cong Wang       2023-01-13  1532  	l2tp_tunnel_remove(net, tunnel);
6b9f34239b00e6 Guillaume Nault 2018-04-10  1533  	return ret;
6b9f34239b00e6 Guillaume Nault 2018-04-10  1534  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

