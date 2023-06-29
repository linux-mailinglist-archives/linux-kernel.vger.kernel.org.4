Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5ED743139
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjF2Xo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjF2XoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7843AAB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB1E86167A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DA5C433C9;
        Thu, 29 Jun 2023 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688082200;
        bh=KIYW1lUTJeQEkbIElm6us4axZkg9EmgFSwq92AAsf6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FAwxhF/sxTGaYZAjCNqCnXzM7+1IK6BDzDB725t8iS0GHPDcS1bhTM8BwwZl6JeVx
         61w93PxTHNhifhYhOawcWoYmxCqnzubKSubp9DLbQgU5P8G5Z/IdzpHEVRCTKsikYr
         I7EkcgcYNjVcKq2Id/oC2GgeGbmBqOPfYQqZC7PtYzGfRG+4O34EytEQW0oF0aqKAQ
         803uYRUYut+Nfy4yz0+l6nAZLT68yUufkg5pNe0mCuD15bJ0+Q2Vj1FQ3H5TtaMdTm
         SmurcO0ub7iNkhFWFvhRR4LvPCC0uoam7AqUJfZjdPBphlYAfCZynAHlsqyoRcpell
         xnaG0uRIZVnag==
Date:   Thu, 29 Jun 2023 16:43:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Message-ID: <20230629164318.44f45caf@kernel.org>
In-Reply-To: <58466.1688074499@warthog.procyon.org.uk>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
        <20230620145338.1300897-1-dhowells@redhat.com>
        <20230620145338.1300897-11-dhowells@redhat.com>
        <58466.1688074499@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 22:34:59 +0100 David Howells wrote:
>                 if (!sendpage_ok(page))
> -                       msg.msg_flags &=3D ~MSG_SPLICE_PAGES,
> +                       msg.msg_flags &=3D ~MSG_SPLICE_PAGES;

=F0=9F=98=B5=EF=B8=8F

Let me CC llvm@ in case someone's there is willing to make=20
the compiler warn about this.
