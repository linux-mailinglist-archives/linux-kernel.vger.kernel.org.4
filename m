Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700EC728793
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjFHTDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFHTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:03:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9654C2D40;
        Thu,  8 Jun 2023 12:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 254686507B;
        Thu,  8 Jun 2023 19:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F27C4339B;
        Thu,  8 Jun 2023 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686251013;
        bh=fC0K5XEsiAEtCYe6c/b+fAKdV1mDbn4jxwJGLimbRjA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=hZcTUAf5R6C1sSEJXXnXaIKTPLjyoHTCeSddhBpG8K2adUc7ad2Jl21kLO6Pq7QmB
         YJg5zZmKst3c6KRC9CXmLjOkhp7P1LEr/cGVznT8YxQg+CKgD/y9hUWcABb/Ujz9K0
         Y4liPSJuonKXgra9EnRbD8P/IB8dOyAmuaX7UYMglg7P9uLb7TJj+15E2S4HM45bIA
         A4bTeN95B8n3gHl+F7AR+31x/Hmf4mM6uq0ZS97Rbj7nbj2ylP38eUxTv7cTLHd5J1
         KERlOSEolYzCMlBsurWJYyowmoyyKA7r5jL689+BU7zWdPdVpAE2hhXiEHmbCCl0pJ
         U1fKG0GXcQ7/Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 08 Jun 2023 22:03:30 +0300
Message-Id: <CT7I3FSMNR0V.8DOJ8GZ6LPDK@suppilovahvero>
Cc:     <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] keys: Fix linking a duplicate key to a keyring's
 assoc_array
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "David Howells" <dhowells@redhat.com>,
        "Petr Pavlu" <petr.pavlu@suse.com>
X-Mailer: aerc 0.14.0
References: <20230323130412.32097-1-petr.pavlu@suse.com>
 <2413881.1686233574@warthog.procyon.org.uk>
In-Reply-To: <2413881.1686233574@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jun 8, 2023 at 5:12 PM EEST, David Howells wrote:
> Apologies for missing this patch.
>
> Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> > * Back on the first task, function construct_alloc_key() first runs
> >   __key_link_begin() to determine an assoc_array_edit operation to
> >   insert a new key. Index keys in the array are compared exactly as-is,
> >   using keyring_compare_object(). The operation finds that "abcdef" is
> >   not yet present in the destination keyring.
>
> Good catch, but I think it's probably the wrong solution.
>
> keyring_compare_object() needs to use the ->cmp() function from the key t=
ype.
>
> It's not just request_key() that might have a problem, but also key_link(=
).
>
> There are also asymmetric keys which match against multiple criteria - th=
ough
> I'm fine with just matching the main description there (the important bit
> being to maintain the integrity of the tree inside assoc_array).
>
> I wonder, should I scrap the assoc_array approach and go to each keyring =
being
> a linked-list?  It's slower, but a lot easier to manage - and more forgiv=
ing
> of problems.
>
> 	struct key_ptr {
> 		struct list_head	link;
> 		struct key		*key;
> 		unsigned long		key_hash;
> 	};
>
> I'm also wondering if I should remove the key type from the matching crit=
eria
> - i.e. there can only be one key with any particular description in a rin=
g at
> once, regardless of type.  Unfortunately, this is may be a UAPI breaker
> somewhere.
>
> Any thoughts?

If the amount of items stays at most in hundreds (or actually even like
few thousand items), there's very little gain of having the complexity
of associative array. In most cases it probably shoots back in many
ways.

I've been thinking this for a long time but have thought that since it
has been there, there must be good reasons to have it.

So yeah, definitely +1 for scraping assoc array.

BR, Jarkko
