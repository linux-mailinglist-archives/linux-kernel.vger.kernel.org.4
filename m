Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B172A3F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFIUAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjFIUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:00:42 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6135AA;
        Fri,  9 Jun 2023 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686340840; x=1717876840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AwzwnMbVO3rl3y00p/gpeO98vFDZVAnUq22KZ6hErmQ=;
  b=jyn13C1ZQ3xxp3pqtqBze7Ha+LvMkFcYL/Za6NNJBFmvXCy1xPwqo9K+
   gY0qt6pcaOhIOCIe4XOBQL16p423n0BklEsh6YUwQCeqqzaz6drhML7++
   qam99DOMOn8HLraLXFAq6zOzcfXFasIb2puOviIs01Sc0QhxGM0fNjMGQ
   k=;
X-IronPort-AV: E=Sophos;i="6.00,230,1681171200"; 
   d="scan'208";a="136187882"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 20:00:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 84D72A11E1;
        Fri,  9 Jun 2023 20:00:28 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 20:00:27 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Fri, 9 Jun 2023 20:00:21 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <leitao@debian.org>
CC:     <alex.aring@gmail.com>, <andrea.righi@canonical.com>,
        <asml.silence@gmail.com>, <ast@kernel.org>, <axboe@kernel.dk>,
        <courmisch@gmail.com>, <davem@davemloft.net>,
        <dccp@vger.kernel.org>, <dsahern@kernel.org>,
        <edumazet@google.com>, <hbh25y@gmail.com>,
        <joannelkoong@gmail.com>, <kernelxing@tencent.com>,
        <kuba@kernel.org>, <kuniyu@amazon.com>, <leit@fb.com>,
        <linux-kernel@vger.kernel.org>, <linux-sctp@vger.kernel.org>,
        <linux-wpan@vger.kernel.org>, <lucien.xin@gmail.com>,
        <marcelo.leitner@gmail.com>, <martin.lau@kernel.org>,
        <martineau@kernel.org>, <matthieu.baerts@tessares.net>,
        <miquel.raynal@bootlin.com>, <mptcp@lists.linux.dev>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <stefan@datenfreihafen.org>, <willemb@google.com>,
        <willemdebruijn.kernel@gmail.com>, <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v7] net: ioctl: Use kernel memory on protocol ioctl callbacks
Date:   Fri, 9 Jun 2023 13:00:10 -0700
Message-ID: <20230609200010.27991-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609152800.830401-1-leitao@debian.org>
References: <20230609152800.830401-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.20]
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>
Date: Fri,  9 Jun 2023 08:27:42 -0700
> Most of the ioctls to net protocols operates directly on userspace
> argument (arg). Usually doing get_user()/put_user() directly in the
> ioctl callback.  This is not flexible, because it is hard to reuse these
> functions without passing userspace buffers.
> 
> Change the "struct proto" ioctls to avoid touching userspace memory and
> operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> adapted to operate on a kernel memory other than on userspace (so, no
> more {put,get}_user() and friends being called in the ioctl callback).
> 
> This changes the "struct proto" ioctl format in the following way:
> 
>     int                     (*ioctl)(struct sock *sk, int cmd,
> -                                        unsigned long arg);
> +                                        int *karg);
> 
> (Important to say that this patch does not touch the "struct proto_ops"
> protocols)
> 
> So, the "karg" argument, which is passed to the ioctl callback, is a
> pointer allocated to kernel space memory (inside a function wrapper).
> This buffer (karg) may contain input argument (copied from userspace in
> a prep function) and it might return a value/buffer, which is copied
> back to userspace if necessary. There is not one-size-fits-all format
> (that is I am using 'may' above), but basically, there are three type of
> ioctls:
> 
> 1) Do not read from userspace, returns a result to userspace
> 2) Read an input parameter from userspace, and does not return anything
>   to userspace
> 3) Read an input from userspace, and return a buffer to userspace.
> 
> The default case (1) (where no input parameter is given, and an "int" is
> returned to userspace) encompasses more than 90% of the cases, but there
> are two other exceptions. Here is a list of exceptions:
> 
> * Protocol RAW:
>    * cmd = SIOCGETVIFCNT:
>      * input and output = struct sioc_vif_req
>    * cmd = SIOCGETSGCNT
>      * input and output = struct sioc_sg_req
>    * Explanation: for the SIOCGETVIFCNT case, userspace passes the input
>      argument, which is struct sioc_vif_req. Then the callback populates
>      the struct, which is copied back to userspace.
> 
> * Protocol RAW6:
>    * cmd = SIOCGETMIFCNT_IN6
>      * input and output = struct sioc_mif_req6
>    * cmd = SIOCGETSGCNT_IN6
>      * input and output = struct sioc_sg_req6
> 
> * Protocol PHONET:
>   * cmd == SIOCPNADDRESOURCE | SIOCPNDELRESOURCE
>      * input int (4 bytes)
>   * Nothing is copied back to userspace.
> 
> For the exception cases, functions sock_sk_ioctl_inout() will
> copy the userspace input, and copy it back to kernel space.
> 
> The wrapper that prepare the buffer and put the buffer back to user is
> sk_ioctl(), so, instead of calling sk->sk_prot->ioctl(), the callee now
> calls sk_ioctl(), which will handle all cases.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!
