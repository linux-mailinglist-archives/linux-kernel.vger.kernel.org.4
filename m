Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3808E6FA2F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjEHJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjEHJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:06:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA01E51
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:06:36 -0700 (PDT)
Received: from letrec.thunk.org (h64-141-80-140.bigpipeinc.com [64.141.80.140] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34895uIb003749
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 05:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683536762; bh=CzjnjA4JS2YmjVXUUWsFDtgrLJ4hv+oK7hr5A0flMko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=nb+C0kmvOPwFXf4nW5dkJEWkppBfLmi83wmzz1oRqkoVQa8+pTkTV3UlKPy28kITC
         BeYX6ghpdBfE+QyUnwZepe1oZIziJh+WD0z48HKHY4wePlT4UjEW0sIiDGYiYIb5lQ
         X9/X9g8Cl0qUDy6JDO47CK5IV/BGY/YHxKN05v6op2euHqCubjLQQmc6NSjm20VP88
         zwcEm7HipaNfC2qwfiF4FFX1RSYQ4vXAuEbehA6+Zx7aqOral4ZQtUwHSOoJeviF5r
         69V1aTCPoVIRpVfU2Huk6O9DtLvtnxrn7HMPKC6WxgpRCKiZTmtBvKwezHI6iF78J2
         M2uzBqlAHYL/Q==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id A3B0A8C03A8; Mon,  8 May 2023 04:55:49 -0400 (EDT)
Date:   Mon, 8 May 2023 04:55:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Aleksandr Nogikh <nogikh@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] hwrng: virtio - Fix race on data_avail and actual data
Message-ID: <ZFi5FfjVpxLEk48A@mit.edu>
References: <00000000000050327205f9d993b2@google.com>
 <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
 <ZFI9bHr1o2Cvdebp@gondor.apana.org.au>
 <ede92183-bef3-78a7-abae-335c6c5cca1e@linaro.org>
 <ZFMsvxW+pEZA2EZ7@gondor.apana.org.au>
 <41ddc20d-8675-d8bc-18c6-2a26f0d6b104@linaro.org>
 <20230505040134.GA883142@mit.edu>
 <CACT4Y+ZnTRf5BocMZZCkUva+VddOMXYGu13iWo6+3sopZzh5hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZnTRf5BocMZZCkUva+VddOMXYGu13iWo6+3sopZzh5hQ@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 07:33:39AM +0200, Dmitry Vyukov wrote:
> A link like this may work for syzbot instead of the Reported-by tag
> (may work out of the box, but need to double check if we start to use
> this):
> 
> Link: https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb
> 
> Or similarly this may work:
> 
> Reported-by: https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb
> I think the parsing code mostly looks for the hash.
> 
> This was proposed, but people said that they need links to lore and
> don't want links to syzkaller dashboard. So this was rejected at the
> time.

I think the "Reported-by: " line should continue to contain an e-mail,
since that way "git send-email" will automatically include a Cc: to
the mailing list address so that the syzbot page for the report will
contain a link to the page.

What *would* be useful would be a search box on the top-level
https://syzkaller.appspot.com where you could either enter an e-mail
address like:

	syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com

or the syzbot report title e.g.:

       KCSAN: data-race in random_recv_done / virtio_read (3)

or just a function name:

	sys_quotactl_fd

The search box could just push the text to google.com with
"site:syzkaller.appspot.com", which should mostly do the right thing.

Also, it would also be nice if all of the URL links on the
syzkaller.appspot.com used the id form of the URL.  That is, to use

https://syzkaller.appspot.com/bug?extid=6c73bd34311ee489dbf5

instead of:

https://syzkaller.appspot.com/bug?id=32c54626e170a6b327ca2c8ae4c1aea666a8c20b

The extid form of the URL is shorter, and having a consistency so that
the primary URL is the extid would reduce confusion.  The web site
will need to continue to support the id form of the URL since there
are quite a few of those URL's in mailing list archives and git commit
descriptions.  

It also would be useful if there was a way to translate from the extid
hash to the id hash, so that it's possible to search for the extid and
id forms of the URL --- since the URL aliasing means that for a
developer trying to do code archeology and web searches, that we need
to search for both URL forms for past syzbot reports.  (But if we can
avoid the aliasing confusion moving forward, that would be **really**
nice.)

Cheers,

						- Ted
