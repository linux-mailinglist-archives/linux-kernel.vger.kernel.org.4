Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C973FC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjF0NKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjF0NKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2C26BA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687871366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=waR2ddNVaa0bZ59PsKuTu38VAo3ER9tvWWrmghdj6V4=;
        b=RTT6EMQGoExPQ+bKD1m64SpKmzM9hzVKKZuDyQLr/2a2bX5LIqtDNChzD8NIlHGfMLwtNW
        V6vjklBmJDDPu+c8GSGRrv35WC/+nYQns69tv2uYVveeY/zVa2/1IF90Q2Ws3IumGvEodZ
        MBg5EkgtpZig6hf92D/LNwKXbrfrDY8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-QLS9g6EqP-WwxVUbWDdDfQ-1; Tue, 27 Jun 2023 09:09:23 -0400
X-MC-Unique: QLS9g6EqP-WwxVUbWDdDfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4EAC2814245;
        Tue, 27 Jun 2023 13:09:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9E6440C6F5A;
        Tue, 27 Jun 2023 13:09:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b0a0cb0fac4ebdc23f01d183a9de10731dc90093.camel@redhat.com>
References: <b0a0cb0fac4ebdc23f01d183a9de10731dc90093.camel@redhat.com> <3112097.1687814081@warthog.procyon.org.uk> <20230626142257.6e14a801@kernel.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Is ->sendmsg() allowed to change the msghdr struct it is given?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3132609.1687871361.1@warthog.procyon.org.uk>
Date:   Tue, 27 Jun 2023 14:09:21 +0100
Message-ID: <3132610.1687871361@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> wrote:

> udp_sendmsg() can set the MSG_TRUNC bit in msg->msg_flags, so I guess
> that kind of actions are sort of allowed. Still, AFAICS, the kernel
> based msghdr is not copied back to the user-space, so such change
> should be almost a no-op in practice.
> 
> @David: which would be the end goal for such action?

Various places in the kernel use sock_sendmsg() - and I've added a bunch more
with the MSG_SPLICE_PAGES patches.  For some of the things I've added, there's
a loop which used to call ->sendpage() and now calls sock_sendmsg().  In most
of those places, msghdr will get reset each time round the loop - but not in
all cases.

Of particular immediate interest is net/ceph/messenger_v2.c.  If you go to:

	https://lore.kernel.org/r/3111635.1687813501@warthog.procyon.org.uk/

and look at the resultant code:

	static int do_sendmsg(struct socket *sock, struct iov_iter *it)
	{
		struct msghdr msg = { .msg_flags = CEPH_MSG_FLAGS };
		int ret;

		msg.msg_iter = *it;
		while (iov_iter_count(it)) {
			ret = sock_sendmsg(sock, &msg);
			if (ret <= 0) {
				if (ret == -EAGAIN)
					ret = 0;
				return ret;
			}

			iov_iter_advance(it, ret);
		}

		WARN_ON(msg_data_left(&msg));
		return 1;
	}

for example.  It could/would malfunction if sendmsg() is allowed to modify
msghdr - or if it doesn't update msg_iter.  Likewise:

	static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
	{
		struct msghdr msg = { .msg_flags = CEPH_MSG_FLAGS };
		struct bio_vec bv;
		int ret;

		if (WARN_ON(!iov_iter_is_bvec(it)))
			return -EINVAL;

		while (iov_iter_count(it)) {
			/* iov_iter_iovec() for ITER_BVEC */
			bvec_set_page(&bv, it->bvec->bv_page,
				      min(iov_iter_count(it),
					  it->bvec->bv_len - it->iov_offset),
				      it->bvec->bv_offset + it->iov_offset);

			/*
			 * MSG_SPLICE_PAGES cannot properly handle pages with
			 * page_count == 0, we need to fall back to sendmsg if
			 * that's the case.
			 *
			 * Same goes for slab pages: skb_can_coalesce() allows
			 * coalescing neighboring slab objects into a single frag
			 * which triggers one of hardened usercopy checks.
			 */
			if (sendpage_ok(bv.bv_page))
				msg.msg_flags |= MSG_SPLICE_PAGES;
			else
				msg.msg_flags &= ~MSG_SPLICE_PAGES;

			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, bv.bv_len);
			ret = sock_sendmsg(sock, &msg);
			if (ret <= 0) {
				if (ret == -EAGAIN)
					ret = 0;
				return ret;
			}

			iov_iter_advance(it, ret);
		}

		return 1;
	}

could be similarly affected if ->sendmsg() mucks about with msg_flags.

David

