Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6917442BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjF3T2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjF3T2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBC53C38
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D829617F5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE726C433C0;
        Fri, 30 Jun 2023 19:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688153308;
        bh=zX7DtgKaXqa8tSnrkMuQTXY6UheSPHRSG4DhhcbKq+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryup1iNS7cnCw2wiYI3YEs2N7PeCMaMxWV1gkQER97KVMF9lUTjIK9fzk3DQSkk6q
         M+MqgMxaw01mt5CQJkyVoO9FEbADys+v/GY8cYOOAo8cGz0mR5z1t2Z2jbWiWBHe3a
         2SUPqi1E9SO46ZJpEI6KSX8OMAPW2qgfncFFfHniX5QNV9jHuH2YBR0CH4Oe9KVhoC
         Mi4/QItY+2LBUukkmIeMd8s+nPBYMevX7Wwbj1GsdziHcoAtWeZDF/tFvAn8Ar88eI
         RjrS0eVk052IzxtszvnH8y3/MNlfF+v+hiJeG9qiwYwudNCWMxPTjEBAgyj6rmJdq9
         JLEUuTBhVG9vA==
Date:   Fri, 30 Jun 2023 12:28:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org,
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
Message-ID: <20230630192825.GA2745548@dev-arch.thelio-3990X>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <58466.1688074499@warthog.procyon.org.uk>
 <20230629164318.44f45caf@kernel.org>
 <20230630161043.GA2902645@dev-arch.thelio-3990X>
 <20230630091442.172ec67f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630091442.172ec67f@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:14:42AM -0700, Jakub Kicinski wrote:
> On Fri, 30 Jun 2023 09:10:43 -0700 Nathan Chancellor wrote:
> > > Let me CC llvm@ in case someone's there is willing to make 
> > > the compiler warn about this.
> > 
> > Turns out clang already has a warning for this, -Wcomma:
> > 
> >   drivers/nvme/host/tcp.c:1017:38: error: possible misuse of comma operator here [-Werror,-Wcomma]
> >    1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
> >         |                                                           ^
> >   drivers/nvme/host/tcp.c:1017:4: note: cast expression to void to silence warning
> >    1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
> >         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         |                         (void)(                           )
> >   1 error generated.
> > 
> > Let me do some wider build testing to see if it is viable to turn this
> > on for the whole kernel because it seems worth it, at least in this
> > case. There are a lot of cases where a warning won't be emitted (see the
> > original upstream review for a list: https://reviews.llvm.org/D3976) but
> > something is better than nothing, right? :)

Well, that was a pipe dream :/ In ARCH=arm multi_v7_defconfig alone,
there are 289 unique instances of the warning (although a good number
have multiple instances per line, so it is not quite as bad as it seems,
but still bad):

$ rg -- -Wcomma arm-multi_v7_defconfig.log | sort | uniq -c | wc -l
289

https://gist.github.com/nathanchance/907867e0a7adffc877fd39fd08853801

Probably not a good sign of the signal to noise ratio, I looked through
a good handful and all the cases I saw were not interesting... Perhaps
the warning could be tuned further to become useful for the kernel but
in its current form, it is definitely a no-go :/

> Ah, neat. Misleading indentation is another possible angle, I reckon,
> but not sure if that's enabled/possible to enable for the entire kernel

Yeah, I was surprised there was no warning for misleading indentation...
it is a part of -Wall for both clang and GCC, so it is on for the
kernel, it just appears not to trigger in this case.

> either :( We test-build with W=1 in networking, FWIW, so W=1 would be
> enough for us.

Unfortunately, even in its current form, it is way too noisy for W=1, as
the qualifier for W=1 is "do not occur too often". Probably could be
placed under W=2 but it still has the problem of wading through every
instance and it is basically a no-op because nobody tests with W=2.

Cheers,
Nathan
