Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD837207CB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbjFBQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjFBQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7381B1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02CF96177F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 16:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95E1C433D2;
        Fri,  2 Jun 2023 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685723971;
        bh=8bHNswoYHnSXiwlo70dxM9TzF2xyp76+5Txn9KrkcSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EP2oraAs3QhbPgvUBRn9rQxBwby+mZyogAhpZlMjbPgtVQgzUfSn85GgQNt9QQ7cE
         J6rqiysXHUN+V/NdAGZLcUM9jYpgRlGe4lKDRKMgd6qAkKpNRApYIIKXCiPzVvbbl9
         ecnWbqlQV/DkEX6WUbgxsXxZ1Ogdj4DveBysM9xfVOOczmSaX+OCBvIbxwRC+ZQMKC
         WH5FQuQdl7JaE+UeMiK0hwRK/mqoXS1ebNE+jECkk7XLJcQdpZ6YSr4FMjNbjplfAu
         xxaiju23JPAXST7BkvUu2LfePX9M4nQk70yeNO9XLnGqjWJpvKl6rjXZZRT+q9OVNq
         HWjsvMb/W23tg==
Date:   Fri, 2 Jun 2023 09:39:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Bug in short splice to socket?
Message-ID: <20230602093929.29fd447d@kernel.org>
In-Reply-To: <CAHk-=wgyAGUMHmQM-5Eb556z5xiHZB7cF05qjrtUH4F7P-1rSA@mail.gmail.com>
References: <CAHk-=wji_2UwFMkUYkygsYRek05NwaQkH-vA=yKQtQS9Js+urQ@mail.gmail.com>
        <20230524153311.3625329-1-dhowells@redhat.com>
        <20230524153311.3625329-10-dhowells@redhat.com>
        <20230526180844.73745d78@kernel.org>
        <499791.1685485603@warthog.procyon.org.uk>
        <CAHk-=wgeixW3cc=Ys8eL0_+22FUhqeEru=nzRrSXy1U4YQdE-w@mail.gmail.com>
        <CAHk-=wghhHghtvU_SzXxAzfaX35BkNs-x91-Vj6+6tnVEhPrZg@mail.gmail.com>
        <832277.1685630048@warthog.procyon.org.uk>
        <909595.1685639680@warthog.procyon.org.uk>
        <20230601212043.720f85c2@kernel.org>
        <952877.1685694220@warthog.procyon.org.uk>
        <CAHk-=wjvgL5nyZmpYRWBfab4NKvfQ7NjUvUhE3a3wYTyTEHdfQ@mail.gmail.com>
        <1227123.1685706296@warthog.procyon.org.uk>
        <CAHk-=wgyAGUMHmQM-5Eb556z5xiHZB7cF05qjrtUH4F7P-1rSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023 08:11:47 -0400 Linus Torvalds wrote:
> If then some *real* load ends up showing a regression, we may just be
> screwed. Our current behavior may be buggy, but we have the rule that
> once user space depends on kernel bugs, they become features pretty
> much by definition, however much we might dislike it.
> 
> At that point, we'll have to see what we can do - if anything.

Can we have a provisional plan of how we'll fix it if someone does
complain? We can't just revert David's work, and if none of the
solutions are appealing - socket implementations may be left holding
the bag.

I dislike the magic zero sends, and I think you do, too. In case of TLS
its unclear whether we should generate an empty record (like UDP would).

Can we add an optional splice_end / short_splice / splice_underflow /
splice_I_did_not_mean_to_set_more_on_the_previous_call_sorry callback
to struct file_operations?
