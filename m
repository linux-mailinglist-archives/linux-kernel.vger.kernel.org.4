Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE906CB42D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjC1CcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjC1CcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:32:14 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007BB19A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:32:12 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id A3EEAC009; Tue, 28 Mar 2023 04:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679970731; bh=81JrcBOQ6HGB6EQY6ONrHs1iEnNy5OL0G/POddTYXyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itRRNX2eB0DQ1gxwFaq2n5GXVmDLpjFHrgcqsjGJ+dOHE7zfcLBcnQYR0yUnIJ3Su
         OdG9BUu+up2wcGMEPp6BQW7uTQKXb68HOtRlDAgzno1FE5gNHt5zBj8tdvSZsoGaUM
         pjM7cIcv26x9FTIeMNggTP+l/g8m/fNsk15CJUPyXjFbeqnBcvMkb3eNvZiStqNb0J
         uiX1Zdl6sK/r37jlFdQFhfbROo9R9GTNRJ8jBLB90B1nLTH7lE0X2sWNshDFwoLpco
         9KoNYifWhvKvQWXuidpVQtQ+zlXypwY6QTIC56L1Jq1wEwO6xVNaQP2s/KT+7FiGH6
         NsjryNW1cZv4g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C7076C009;
        Tue, 28 Mar 2023 04:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679970730; bh=81JrcBOQ6HGB6EQY6ONrHs1iEnNy5OL0G/POddTYXyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MM+pUzpA2WJXaL+n7pKT9cu9WJq2oGsHnA4aIxto+gfAe4pQCj8DClbYFGstZK/tS
         5K+HgHPTKM5ydeKNVYtR3eQA9Vw+bs3fmna7oNRgX683+0i7e5x/6osVDJVbEMeG4R
         X4xX9S7K7DQAwG3HSEVbWzXmwPHjnKHxv+wA4H0rL2+CSInT8NV4jrXS5YYmzg0mZF
         VDoiePvb4CdCJMrNIT/nv5iFbWrU8aRXMvsD571g8hz5MZ5X3QjcCcvdDlR4BMXeeK
         0ADH0U6zYvX97P+EVs257svnbcsN6Q7WTrkHRBczve0eFvsAwqH0mTU5G914g1Tnmj
         5vNSOoQaza7zA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 4a1f5aef;
        Tue, 28 Mar 2023 02:32:05 +0000 (UTC)
Date:   Tue, 28 Mar 2023 11:31:50 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
Message-ID: <ZCJRlqc/epbRhm93@codewreck.org>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
 <CAFkjPTmVbyuA0jEAjYhsOsg-SE99yXgehmjqUZb4_uWS_L-ZTQ@mail.gmail.com>
 <ZBSc1jjYJn6noeMl@bombadil.infradead.org>
 <CAFkjPTmc-OgMEj9kF3y04sRGeOVO_ogEv1fGG=-CfKP-0ZKC_g@mail.gmail.com>
 <ZCHU6k56nF5849xj@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCHU6k56nF5849xj@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Chamberlain wrote on Mon, Mar 27, 2023 at 10:39:54AM -0700:
> > I have fixed what
> > I hope to be my last bug with the new patch series so it should be
> > going into linux-next today.
> 
> Nice, thanks, since kdevops relies on a host kernel though and we strive
> to have stability for that, I personally like to recommend distro
> kernels and so they're a few kernel releases out of date. So debian-testing
> is on 6.1 as of today for example.
> [...]
> -    opts: "ro,trans=virtio,version=9p2000.L,posixacl,cache=loose"
> +    opts: "ro,trans=virtio,version=9p2000.L,posixacl,cache=none"

Yes, if you want something mostly coherent with the host, cache=none (or
cache=mmap if you need mmap, iirc linux build does for linking? if you
want to do that on guest...) is what you'll want to use on current
kernels.


> BTW the qemu wiki seems to suggest cache=loose and its why I used it on
> kdevops as a default. What about the following so to avoid folks running
> into similar issues? I can go and update the wiki too.

I've added Christian in Cc for this point, he's more active on the qemu
side
(thread started here:
https://lkml.kernel.org/r/ZA0FEyOtRBvpIXbi@bombadil.infradead.org
)

I have no opinion on the current wording, the default is there for a
reason and it's a safe default (none), and cache=loose is clearly
described with "no attempts are made at consistency, intended for
exclusive, read-only mounts" which I think ought to be clear enough
(exclusive means not shared with the host), but if you think it's not
clear enough it probably isn't.

A word on the qemu wiki "if you want to share with host..." would
probably be good though.

-- 
Dominique
