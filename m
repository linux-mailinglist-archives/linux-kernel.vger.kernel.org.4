Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCFB70C403
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEVRIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEVRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DCEFA;
        Mon, 22 May 2023 10:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A38761AE1;
        Mon, 22 May 2023 17:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBB3C433D2;
        Mon, 22 May 2023 17:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684775305;
        bh=j6fRu1rODBhFFMabejuYKbw6ODpKa3E9i0hI3fijSwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUkGslzDWWURjKyZmAj8QCL8ejEnGvHSRpJE0epFEj7C7fbmpVkDjTHHKuI3NnrFc
         DI8+Qo8W5twvtXYWgM2ectzhQ3DWVXy0Q2oO5GXGy9Ubnh0hNHyHEIOPI60MaorCWg
         fvZR6Wl3fBwlQAoZhKI5QEOAGDYoHQVysfK/9qAc=
Date:   Mon, 22 May 2023 18:08:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     SeongJae Park <sj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Willem de Bruijn <willemb@google.com>,
        Norbert Manthey <nmanthey@amazon.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: fix skb leak in __skb_tstamp_tx()
Message-ID: <2023052208-squad-viper-b244@gregkh>
References: <20230522165505.90105-1-sj@kernel.org>
 <mafs0cz2sxpq8.fsf@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0cz2sxpq8.fsf@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 07:03:59PM +0200, Pratyush Yadav wrote:
> On Mon, May 22 2023, SeongJae Park wrote:
> 
> > Hi Pratyush,
> >
> > On Mon, 22 May 2023 17:30:20 +0200 Pratyush Yadav <ptyadav@amazon.de> wrote:
> >
> >> Commit 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with
> >> TX timestamp.") added a call to skb_orphan_frags_rx() to fix leaks with
> >> zerocopy skbs. But it ended up adding a leak of its own. When
> >> skb_orphan_frags_rx() fails, the function just returns, leaking the skb
> >> it just cloned. Free it before returning.
> >>
> >> This bug was discovered and resolved using Coverity Static Analysis
> >> Security Testing (SAST) by Synopsys, Inc.
> >>
> >> Fixes: 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.")
> >
> > Seems the commit has merged in several stable kernels.  Is the bug also
> > affecting those?  If so, would it be better to Cc stable@vger.kernel.org?
> >
> 
> It affects v5.4.243 at least, since that is where I first saw this. But
> I would expect it to affect other stable kernels it has been backported
> to as well. I thought using the Fixes tag pointing to the bad upstream
> commit would be enough for the stable maintainers' tooling/bots to pick
> this patch up.
> 
> In either case, +Cc stable. Link to the patch this thread is talking
> about [0].


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
