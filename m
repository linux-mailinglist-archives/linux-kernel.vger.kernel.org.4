Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8965B73B42B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjFWJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjFWJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E62C6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687513960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1K8pf+Hfv6KUUo11ZRN0TVVBeFzPwTpw80csEV87fZg=;
        b=AzrKP28UxkapNGeGbmhnwRyFYQdN3MGKEZzFtnp5UTWLxANrgsaubMkmSUoQYTjonOMzKF
        HPLKD5Cyu6Wg2ARxIuOkISdIQzMYnq0JhRvq81bX5a4usi478DM/8dg7ITs2j4Nt2pih6o
        h0Y77hx5YjF69azrWH+qNZbMQCSXTyo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-cvMqDDpZMjqcD6CF-xtYsA-1; Fri, 23 Jun 2023 05:52:37 -0400
X-MC-Unique: cvMqDDpZMjqcD6CF-xtYsA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76077669a5aso11336385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 02:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513957; x=1690105957;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1K8pf+Hfv6KUUo11ZRN0TVVBeFzPwTpw80csEV87fZg=;
        b=Ye/r81V9tY6P0jE/nIX1bMRXt2Gb8wmNCQOSQKmHQUK5uIrKrQV/kHHGuD4kg0t995
         qeJSSIymOjfok+iDiAMpduClD1LbfrFne6Kz2OlwP1jFg5sibDXtF37Puc0047R9rMZk
         hzY21tbYAkSXXD25r4S3GOnB48lidQxWYrAWkw0mJHmqC4H7bSbvrTrVgqyqUZpEsy9O
         y5ddlvPCTD0lGHwlJVImHJU5a0fYTd7Kq18iHiE6SnMzTmYf6YCPoQBCL8m4M6J/dt6G
         ZolTYZtOwXwuqD3Ee3MmyW9d8Mdp2AgFsD1psLr90AC6091Yuyk7pDzqHRFFOcsPgCyi
         cqNA==
X-Gm-Message-State: AC+VfDxdLzMSe+0kb//NGkfnWYWn+FntXXjgIULlVXwzwdEPY6qhcGX3
        LA/o/86imR1mvbO4kGiOMwlGrA76UcLR1KZqvD9YvMiIKqalrcD9iSOfONdHefBmk2cobnHHnic
        fr6doRvq0x7Yy4mzNcxdFa4Ue
X-Received: by 2002:a05:620a:230:b0:763:de4e:2453 with SMTP id u16-20020a05620a023000b00763de4e2453mr6596289qkm.5.1687513957078;
        Fri, 23 Jun 2023 02:52:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5w+vAckkr1xPsoP/O7YpKV26OqjtuOf30RhWVF7lYD6UuLEXVG0LDzinwCuq9Y4qAX/3DXiw==
X-Received: by 2002:a05:620a:230:b0:763:de4e:2453 with SMTP id u16-20020a05620a023000b00763de4e2453mr6596277qkm.5.1687513956793;
        Fri, 23 Jun 2023 02:52:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id v22-20020a05620a123600b0075cc5e34e48sm4300471qkj.131.2023.06.23.02.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:52:36 -0700 (PDT)
Message-ID: <ccf93f92b2539c9dddd1c45fcfa037bb21ccd808.camel@redhat.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Date:   Fri, 23 Jun 2023 11:52:32 +0200
In-Reply-To: <1969749.1687511298@warthog.procyon.org.uk>
References: <20230622191134.54d5cb0b@kernel.org>
         <20230622132835.3c4e38ea@kernel.org> <20230622111234.23aadd87@kernel.org>
         <20230620145338.1300897-1-dhowells@redhat.com>
         <20230620145338.1300897-2-dhowells@redhat.com>
         <1952674.1687462843@warthog.procyon.org.uk>
         <1958077.1687474471@warthog.procyon.org.uk>
         <1969749.1687511298@warthog.procyon.org.uk>
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

On Fri, 2023-06-23 at 10:08 +0100, David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> > If we can't reach instant agreement --
> > can you strategically separate out the minimal set of changes required
> > to just kill MSG_SENDPAGE_NOTLAST. IMHO it's worth getting that into
> > 6.5.
>=20
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > Given all the above, and the late stage of the current devel cycle,
> > would you consider slicing down this series to just kill
> > MSG_SENDPAGE_NOTLAST, as Jakub suggested?
>=20
> I could do that.
>=20
> There is also another alternative.  I could just push the sendpage wrappe=
rs up
> the stack into the higher-level callers.  Basically this:
>=20
> int udp_sendpage(struct sock *sk, struct page *page, int offset,
> 		 size_t size, int flags)
> {
> 	struct bio_vec bvec;
> 	struct msghdr msg =3D { .msg_flags =3D flags | MSG_SPLICE_PAGES };
>=20
> 	if (flags & MSG_SENDPAGE_NOTLAST)
> 		msg.msg_flags |=3D MSG_MORE;
>=20
> 	bvec_set_page(&bvec, page, size, offset);
> 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> 	return udp_sendmsg(sk, &msg, size);
> }
>=20
> and kill off sendpage and MSG_SENDPAGE_NOTLAST.

I'm unsure I follow the above ?!? I *thought* sendpage could be killed
even without patch 1/18 and 2/18, leaving some patches in this series
unmodified, and mangling those explicitly leveraging 1/18 to use
multiple sendmsg()s with different flags?

I haven't tried to code the above, but my wild guess/hope is that the
delta should be doable - ideally less then the other option.

Introducing slab support should still be possible later, with hopefully
less work.

Cheers,

Paolo


