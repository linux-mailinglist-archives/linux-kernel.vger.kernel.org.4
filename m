Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74B473FD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjF0Nwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0Nwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB6A1FCD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687873912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ta/k6TaotDmcBq3Mo1N0tE9YWNUTNqotl8imK8b3vwY=;
        b=fNlIXJ0JA+wAtiPzgI/whSubH1Jz/Oqsq8FnCdCfjnIazZvcwYs83rdGUmOQl3mPOVe8Fo
        SvZBwIx9lbaRrMlP6zKHPUtgYDc9YelDpF507ac2VkPvmY9N0pqNKJUDsz5U0letfBCOdA
        ZzntHPv6LksAApwKqMNB4SX8XbSpAsk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-uUsDa3JNOeOKfwCCmcz3ew-1; Tue, 27 Jun 2023 09:51:50 -0400
X-MC-Unique: uUsDa3JNOeOKfwCCmcz3ew-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76077669a5aso126887185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873906; x=1690465906;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ta/k6TaotDmcBq3Mo1N0tE9YWNUTNqotl8imK8b3vwY=;
        b=GMH7Zfs/1Qy3lAroIwnMfqImg4dA4OkZivTlxQBY301VmLwcG+N6lmBZVBSP0AZL3X
         bX1e5GeShq4b++H7AySIKKlORzYbjHkjS7tAKXoSjy/ySUnSjaI6JpCPhd7nWBbSS8t9
         FK4JI7UNsZJa/wLL8ih20XxezhTFiegIGMJNLycKNSbSwO21tolhAn2turP8SQZ72ynz
         HD/znD8xXfvYAtx6e8LmilWoUWwIJvDL9vGvWyhs4CHUJmDLCLPv7x5z5AAI8j7e4Gmr
         HPFZD8M9fuTOnB741CWMqnxsbcHYSL4gdRUuX1diTK1lkM71zWKpb3xtm/4succnOd6l
         0iSw==
X-Gm-Message-State: AC+VfDzZG+s8DtYgih/viO62i8SOj9UXI9z5SgF0UyajjhyUDTwfYb4i
        TiI7XTtuz1XpUppS8Rip2FTDFv3+S1n91GOBbIsOGh02Yqf7NE3uLOsBnTsHDf3RQ3pSWfQpGwj
        ZSHeBoiU0vZCLdXyBfgZ1THQdtTo26XLO
X-Received: by 2002:a05:6214:5185:b0:634:cdae:9941 with SMTP id kl5-20020a056214518500b00634cdae9941mr11986655qvb.0.1687873906547;
        Tue, 27 Jun 2023 06:51:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TiZPx86iEnYv5fjmFQlvBx17Uw43aU9XIkdH3HNnpsUCIB9jdeHdTBsTv3eA6WUguqd8Htg==
X-Received: by 2002:a05:6214:5185:b0:634:cdae:9941 with SMTP id kl5-20020a056214518500b00634cdae9941mr11986633qvb.0.1687873906295;
        Tue, 27 Jun 2023 06:51:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id w5-20020a0cc705000000b0062df3d51de3sm4590180qvi.19.2023.06.27.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:51:45 -0700 (PDT)
Message-ID: <01595c2fa5958253f08c07e316435abe9f32e305.camel@redhat.com>
Subject: Re: Is ->sendmsg() allowed to change the msghdr struct it is given?
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 27 Jun 2023 15:51:43 +0200
In-Reply-To: <3132610.1687871361@warthog.procyon.org.uk>
References: <b0a0cb0fac4ebdc23f01d183a9de10731dc90093.camel@redhat.com>
         <3112097.1687814081@warthog.procyon.org.uk>
         <20230626142257.6e14a801@kernel.org>
         <3132610.1687871361@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-27 at 14:09 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > udp_sendmsg() can set the MSG_TRUNC bit in msg->msg_flags, so I guess
> > that kind of actions are sort of allowed. Still, AFAICS, the kernel
> > based msghdr is not copied back to the user-space, so such change
> > should be almost a no-op in practice.
> >=20
> > @David: which would be the end goal for such action?
>=20
> Various places in the kernel use sock_sendmsg() - and I've added a bunch =
more
> with the MSG_SPLICE_PAGES patches.  For some of the things I've added, th=
ere's
> a loop which used to call ->sendpage() and now calls sock_sendmsg().  In =
most
> of those places, msghdr will get reset each time round the loop - but not=
 in
> all cases.
>=20
> Of particular immediate interest is net/ceph/messenger_v2.c.  If you go t=
o:
>=20
> 	https://lore.kernel.org/r/3111635.1687813501@warthog.procyon.org.uk/
>=20
> and look at the resultant code:
>=20
> 	static int do_sendmsg(struct socket *sock, struct iov_iter *it)
> 	{
> 		struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };
> 		int ret;
>=20
> 		msg.msg_iter =3D *it;
> 		while (iov_iter_count(it)) {
> 			ret =3D sock_sendmsg(sock, &msg);
> 			if (ret <=3D 0) {
> 				if (ret =3D=3D -EAGAIN)
> 					ret =3D 0;
> 				return ret;
> 			}
>=20
> 			iov_iter_advance(it, ret);
> 		}
>=20
> 		WARN_ON(msg_data_left(&msg));
> 		return 1;
> 	}
>=20
> for example.  It could/would malfunction if sendmsg() is allowed to modif=
y
> msghdr - or if it doesn't update msg_iter.  Likewise:
>=20
> 	static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
> 	{
> 		struct msghdr msg =3D { .msg_flags =3D CEPH_MSG_FLAGS };
> 		struct bio_vec bv;
> 		int ret;
>=20
> 		if (WARN_ON(!iov_iter_is_bvec(it)))
> 			return -EINVAL;
>=20
> 		while (iov_iter_count(it)) {
> 			/* iov_iter_iovec() for ITER_BVEC */
> 			bvec_set_page(&bv, it->bvec->bv_page,
> 				      min(iov_iter_count(it),
> 					  it->bvec->bv_len - it->iov_offset),
> 				      it->bvec->bv_offset + it->iov_offset);
>=20
> 			/*
> 			 * MSG_SPLICE_PAGES cannot properly handle pages with
> 			 * page_count =3D=3D 0, we need to fall back to sendmsg if
> 			 * that's the case.
> 			 *
> 			 * Same goes for slab pages: skb_can_coalesce() allows
> 			 * coalescing neighboring slab objects into a single frag
> 			 * which triggers one of hardened usercopy checks.
> 			 */
> 			if (sendpage_ok(bv.bv_page))
> 				msg.msg_flags |=3D MSG_SPLICE_PAGES;
> 			else
> 				msg.msg_flags &=3D ~MSG_SPLICE_PAGES;
>=20
> 			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, bv.bv_len);
> 			ret =3D sock_sendmsg(sock, &msg);
> 			if (ret <=3D 0) {
> 				if (ret =3D=3D -EAGAIN)
> 					ret =3D 0;
> 				return ret;
> 			}
>=20
> 			iov_iter_advance(it, ret);
> 		}
>=20
> 		return 1;
> 	}
>=20
> could be similarly affected if ->sendmsg() mucks about with msg_flags.

With some help from the compiler - locally changing the proto_ops and
proto sendmsg definition and handling the fallout - I found the
following:

- mptcp_sendmsg() is clearing unsupported msg_flags=20
  (I should have recalled this one even without much testing ;)

- udpv4_sendmsg() is setting msg_name/msg_namelen
- tls_device_sendmsg() is clearing MSG_SPLICE_PAGE when zerocopy is not
supported
- unix_seqpacket_sendmsg() is clearing msg_namelen

I could have missed something, but the above looks safe for the use-
case you mentioned.

Cheers,

Paolo

