Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4166F7BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjEEECW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjEEECG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:02:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF1535A0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 21:02:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34541Ykn012843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 00:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683259299; bh=t9ztIRuj4Z9rkaKhBQhhRzpmN07bJoq1+o+WdNUbNy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AjuR9ctkBqBovaMAGoU/5wd8bSwtlSOGNI+Ax4R7tZrTP7WU2i9uRKsk51lDzCub4
         lBiFGpJKe5e8LL8PWhEpC45GAy2J6OCjegtJkhIZzBW4ANhumptwN72zpcBE655Ffa
         ODIW8Ox0yAtO0DBZZR4fDocgTPoCcdrykxedL8HN1cWeIBpoqleT1kwIucKX3H8KZc
         WRzSECaZKDvlRnY6ci+SYJWMmNdfB1L2LkzAeUzDqyWVbM5pzxtm/9ywFH4aVGwz9k
         HuIdhpypa/k/k00QffVCZPOLkb7KLuHKAMMBJuNFIl5VpqTkTxOmjJTI6+6jzpBp33
         9J+5RdQGce1Tg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BF6B915C02E8; Fri,  5 May 2023 00:01:34 -0400 (EDT)
Date:   Fri, 5 May 2023 00:01:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH] hwrng: virtio - Fix race on data_avail and actual data
Message-ID: <20230505040134.GA883142@mit.edu>
References: <00000000000050327205f9d993b2@google.com>
 <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
 <ZFI9bHr1o2Cvdebp@gondor.apana.org.au>
 <ede92183-bef3-78a7-abae-335c6c5cca1e@linaro.org>
 <ZFMsvxW+pEZA2EZ7@gondor.apana.org.au>
 <41ddc20d-8675-d8bc-18c6-2a26f0d6b104@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ddc20d-8675-d8bc-18c6-2a26f0d6b104@linaro.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:10:43AM +0100, Tudor Ambarus wrote:
> > The syzbot ID is already present in the in the Reported-by tag.
> > There is no reason to clutter up the commit message with redundant
> > information.
> 
> As you prefer. Theodore Ts'o encourages to add a dashboard link, here's
> his reasoning:
> https://github.com/google/syzkaller/issues/3393#issuecomment-1347476434

The reason why I've requested having both the Link and Reported-by is
because you don't know the secret incantation:

s;Reported-by: syzbot\+\([0-9a-z]+\)@syzkaller.appspotmail.com;https://syzkaller.appspotmail.com/extid?=\1;

... you can't easily get from a "Reported-by:" e-mail address to a URL
link that will actually get you to the syzkaller page.  What I used to
do was to go to https://groups.google.com/g/syzkaller-bugs and then
enter into the Google Groups searech box:

   Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com

which is a ***super*** clunky way to get to the syzkaller page.  What
would be nice is if there was an easy way that didn't rely on kernel
developers knowing the internal URL structure of Syzbot to be able to
enter the Reported-by link on some convenient web page, perhaps in a
search box found in the front page of https://syzkaller.appspot.com,
and be able to find the syzbot report web page that way.

Since that doesn't exist today, I include both the Reported-by: and
Link: in my commit descriptions, out of consideration to the reviewer
who might want to be able to find the Syzbot page and don't know the
secret trick to calculate the URL from the Reported-by: e-mail
address.


Another gotcha with Syzbot is that there are two id's, the "extid" and
the "id" which makes thing ***super*** confusing.  For example, both
of these URL's go the same Syzbot report:

https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb
https://syzkaller.appspot.com/bug?id=eec08eb3763c9ec749fd565e70cfe6e485af7ed7

The Reported-by e-mail address uses the extid.  So for example, this
case, it would be syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com.

However, all of the links in the Syzbot web pages use the id form of
the URL.  So if you were browsing the syzbot reports assigned to the
crypto subsystem via https://syzkaller.appspot.com/upstream/s/crypto,
you would find the id-style link, and then the commit fixing the bug
might have something like this:

Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=eec08eb3763c9ec749fd565e70cfe6e485af7ed7

In that case, there is no (obvious) relationship between the hex
string found in the Reported-by line and the Link line.


One additional unfortunate fallout from syzbot having an "extid" and
"id", is that depending on how the syzbot entry initially found by the
contributor sending in a patch to address a syzbot report, either URL
can be found in mailing list archives.  So if you search for
"extid=726dc8c62c3536431ceb" you won't find references to
"id=eec08eb3763c9ec749fd565e70cfe6e485af7ed7" even though they are
both referring to same Syzbot report.

<<< sigh >>>>   As they say, the hardest problem to solve in the
C.S. world is naming, and syzbot has two names for every single syzbot
report, and both are exposed to the poor user.   :-(

					- Ted
