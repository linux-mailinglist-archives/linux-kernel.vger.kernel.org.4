Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3D64ADA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiLMCgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLMCf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:35:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37586BF40;
        Mon, 12 Dec 2022 18:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E71CCB80DCB;
        Tue, 13 Dec 2022 02:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AAFC433D2;
        Tue, 13 Dec 2022 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670898955;
        bh=MJfbec56Cilr/DNLc0S8FXtEAXdlH2MTjKaFB6ucBmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fmeZFJX+3CpcHfz1KgOGfv35JsRvRB/tTPGDm/55Wi2EdwTHWKg2tn0jpg9cfGCOD
         si1B/TcaCkr1WqWsdHeFAHO0/fKk81LpvaKTXWwCDKIKkconhjgPhygP6QuVNyJcbN
         JaNQnc05SBej+lyWwKyXYiyKd8T8n1XSGA1u+UJI=
Date:   Mon, 12 Dec 2022 18:35:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
Message-Id: <20221212183554.e0a2536e860172282b189ca4@linux-foundation.org>
In-Reply-To: <e7c6b99a-743f-f40a-0b0f-31730964cb36@suse.cz>
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
        <Y5eoS/UfBhovR70j@zx2c4.com>
        <20221212142754.5f699c4ff515fd9d42768fb2@linux-foundation.org>
        <e7c6b99a-743f-f40a-0b0f-31730964cb36@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 00:16:07 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 12/12/22 23:27, Andrew Morton wrote:
> > On Mon, 12 Dec 2022 15:16:43 -0700 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > 
> >> On Mon, Dec 12, 2022 at 01:44:25PM -0800, Andrew Morton wrote:
> >> >       wifi: rt2x00: use explicitly signed or unsigned types
> >> 
> >> Why is this part of your PULL? This was a netdev/wireless tree fix which
> >> was in 6.1-rc5. Kalle wrote that he took it on 21 Oct 2022 in:
> >> https://lore.kernel.org/all/166633563389.6242.13987912613257140089.kvalo@kernel.org/
> >> 
> > 
> > Huh.  I guess git quietly accepts the identical commit, so Stephen
> > never told me and my test-merge-with-Linus-latest also came up clean. 
> > Which leaves it to me to manually handle these things, and that's
> > unreliable.
> > 
> > Is there some way of telling git to complain about identical changes
> > when doing a trial merge?
>  
> Probably not exactly that, but there seems to be a way with "git cherry". Dunno
> how reliable in practice, seems to be based on patch-id so probably can fail
> easily if the commit or context changes slightly?

Well here's a hacky thing - just look for duplicated patch titles after
stripping away the hashes.


$ git log --oneline --no-merges v6.0..HEAD | sed -e "s/[^ ]* //" | sort > /tmp/1        
$ uniq < /tmp/1 > /tmp/2
$ diff -u /tmp/1 /tmp/2 | grep "^-.*"

The above turns up 67 duplicates in Linus's tree and 382 in linux-next.
Maybe this is wrong - I'm just tossing it out there in the hope that
someone will do the work for me :)

