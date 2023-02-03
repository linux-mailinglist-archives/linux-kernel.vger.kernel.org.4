Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387F7689874
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjBCMWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjBCMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:22:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DD9DCB4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675426914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iWvwr9L2DmJ1MAQBDrXjwhR/OpMGxajLpmUomtu16k=;
        b=YPtfuI2UnnKaCKVDCUo4tnncdJAycODogz9PQrhN6RkucUwx2iMGeDZtR7BeWMSh2JWdP6
        BqWAy7bNqh1XzIoYYsHlBLmRczD8scPuLvxQmOurIRUKjA/+diMoFLCT9DW561wJ3ISZ2p
        hJq1VmPaMm9fV1pDOawvcXHMkneRmL8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-78--79jvbiqNHiY273CL8gSsA-1; Fri, 03 Feb 2023 07:21:53 -0500
X-MC-Unique: -79jvbiqNHiY273CL8gSsA-1
Received: by mail-qk1-f200.google.com with SMTP id s7-20020a05620a0bc700b006e08208eb31so3191163qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 04:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iWvwr9L2DmJ1MAQBDrXjwhR/OpMGxajLpmUomtu16k=;
        b=X7jRUrmTnXMNcjqT0n+rjBV4UaiD0/cfJiUGehrn3ELlTSM1FsCyhS6PgCD14qvEW3
         GOP4fdM9Ac6EwVvQuarO0IMWgKTBXQs2IXdRUIZHSdl+38nT9UE5WQixCNy81Efid98L
         Dx1Fp7yo+bw411vv2oh2reBVh14DOurAtNuDkj3bRsjp78fjav8eqEuIRo+09apT0r5t
         7K5gfHxN+IzCIeMterx5/3ABcw2ncmYtsNty4cICKGn1BudQFLdt0OL6trs3zogEAl1u
         NH7zwPavOb+dvc4GvYU2OnMPoaHKnRM0Rblxzl0qjNDEGfNnatjJbkXherW72JhrNknN
         q44w==
X-Gm-Message-State: AO0yUKUf4pEDpdKpxZ61d1V6PJrQ43o7Oep/J1Yzjol/4EnV/4X7jvNy
        PEuCyrGy1InYWrbhtHPQdrBkXTLayNHwH7lSxKYsrRFGONbsd8LEGgg67OPUWMU3jxyWfBk3NvT
        Pj53A4FvWAhABDuPz1FFnHkYN
X-Received: by 2002:ad4:4ea9:0:b0:569:ca4a:f43a with SMTP id ed9-20020ad44ea9000000b00569ca4af43amr2068045qvb.17.1675426912748;
        Fri, 03 Feb 2023 04:21:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8twCog3F1I1XaD90c7D1NEz0cVPNiyWLY81koaeGmUA3SfTejDiOh0CnX2PpEpPWkURyvyiQ==
X-Received: by 2002:ad4:4ea9:0:b0:569:ca4a:f43a with SMTP id ed9-20020ad44ea9000000b00569ca4af43amr2068011qvb.17.1675426912479;
        Fri, 03 Feb 2023 04:21:52 -0800 (PST)
Received: from debian (2a01cb058918ce0086895da7f8f951ef.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:8689:5da7:f8f9:51ef])
        by smtp.gmail.com with ESMTPSA id 3-20020ac856e3000000b003b86c0046a0sm1462861qtu.20.2023.02.03.04.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:21:51 -0800 (PST)
Date:   Fri, 3 Feb 2023 13:21:48 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Cong Wang <cong.wang@bytedance.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: net/l2tp/l2tp_core.c:1481 l2tp_tunnel_register() warn: missing
 error code 'ret'
Message-ID: <Y9z8XPvcv5Wn2J8n@debian>
References: <202302031144.yY6UaRcD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302031144.yY6UaRcD-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:56:01AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   66a87fff1a87c260452f5a57123891ca5258c449
> commit: c4d48a58f32c5972174a1d01c33b296fe378cce0 l2tp: convert l2tp_tunnel_list to idr
> config: powerpc-randconfig-m031-20230202 (https://download.01.org/0day-ci/archive/20230203/202302031144.yY6UaRcD-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> smatch warnings:
> net/l2tp/l2tp_core.c:1481 l2tp_tunnel_register() warn: missing error code 'ret'
> 
> vim +/ret +1481 net/l2tp/l2tp_core.c
> 
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1456  int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1457  			 struct l2tp_tunnel_cfg *cfg)
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1458  {
> c4d48a58f32c59 Cong Wang       2023-01-13  1459  	struct l2tp_net *pn = l2tp_pernet(net);
> c4d48a58f32c59 Cong Wang       2023-01-13  1460  	u32 tunnel_id = tunnel->tunnel_id;
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1461  	struct socket *sock;
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1462  	struct sock *sk;
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1463  	int ret;
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1464  
> c4d48a58f32c59 Cong Wang       2023-01-13  1465  	spin_lock_bh(&pn->l2tp_tunnel_idr_lock);
> c4d48a58f32c59 Cong Wang       2023-01-13  1466  	ret = idr_alloc_u32(&pn->l2tp_tunnel_idr, NULL, &tunnel_id, tunnel_id,
> c4d48a58f32c59 Cong Wang       2023-01-13  1467  			    GFP_ATOMIC);
> c4d48a58f32c59 Cong Wang       2023-01-13  1468  	spin_unlock_bh(&pn->l2tp_tunnel_idr_lock);
> c4d48a58f32c59 Cong Wang       2023-01-13  1469  	if (ret)
> c4d48a58f32c59 Cong Wang       2023-01-13  1470  		return ret == -ENOSPC ? -EEXIST : ret;
> c4d48a58f32c59 Cong Wang       2023-01-13  1471  
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1472  	if (tunnel->fd < 0) {
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1473  		ret = l2tp_tunnel_sock_create(net, tunnel->tunnel_id,
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1474  					      tunnel->peer_tunnel_id, cfg,
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1475  					      &sock);
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1476  		if (ret < 0)
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1477  			goto err;
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1478  	} else {
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1479  		sock = sockfd_lookup(tunnel->fd, &ret);
> 6b9f34239b00e6 Guillaume Nault 2018-04-10  1480  		if (!sock)
> 6b9f34239b00e6 Guillaume Nault 2018-04-10 @1481  			goto err;
>                                                                         ^^^^^^^^^
> I don't know why this is showing up as a 3 week old warning when it
> looks like the code is from 2018...  Anyway, should this be an error
> path or a success path?

This is an error path.
But I don't understand this warning. Does it complain that 'ret' isn't
initialised before the 'goto err;' jump? (this is done by
sockfd_lookup() in case of error).

