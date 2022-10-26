Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCCA60D990
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiJZDG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiJZDFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:05:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03262F663;
        Tue, 25 Oct 2022 20:05:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 770FE1FA15;
        Wed, 26 Oct 2022 03:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666753516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXuHRTM+3pPVGvFWj9th29d+zpf7pxkYh7JjYDkSJOo=;
        b=Jzaq5cEqGZ/pzne9N0Jeby4iWc1mLyw7ZtRwMtgFzmmhOVwrypMqgivbfFv4NPkIShkAcE
        922TPoIGUlfpUEO66NAmpKG/8dDIRu1CqOUc7vYjvXGdIGNuGYI0jpB1IIt+FNd21jX6yO
        PLn2Qc6+gmeFJpjw4sNcTxfwHGzDyXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666753516;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXuHRTM+3pPVGvFWj9th29d+zpf7pxkYh7JjYDkSJOo=;
        b=8LdFFTmNZJVb9vXkdp10tkFKqJ7oupnEVbDmjHdXyCq0UPf1QZZD1G+0Ll+lvoMTE1KZga
        7h+5OlUvLGpCQ7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A59C13A3B;
        Wed, 26 Oct 2022 03:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GSgPNemjWGM4LgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 26 Oct 2022 03:05:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Li zeming" <zeming@nfschina.com>
Cc:     bvanassche@acm.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        song@kernel.org, willy@infradead.org
Subject: Re: [PATCH] reiserfs: journal: Increase jl pointer check
In-reply-to: <20221026014727.3020-1-zeming@nfschina.com>
References: <166673341340.7585.173987927705263434@noble.neil.brown.name>,
 <20221026014727.3020-1-zeming@nfschina.com>
Date:   Wed, 26 Oct 2022 14:05:11 +1100
Message-id: <166675351102.12462.1842756348742191725@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022, Li zeming wrote:
> I'm sorry, I think __GFP_NOFAIL should be like this:
> 
> The __GFP_NOFAIL flag will cause memory to be allocated an infinite
>  number of times until the allocation is successful, but it is best to
>  use it only for very necessary code, and try not to use it.

I agree with that.  But you didn't try not to use it - you left it there
in the code.
Had you removed the flag as well, then your patch would have made a bit
more sense.  However you would then need to explain why it is safe to
return NULL from alloc_journal_list().  Are you sure callers don't try
to dereference the pointer?

> 
> I'm not sure alloc_journal_list function is a very important function
>  here. If it is, this patch ignores it and does not consider it anymore
>  __GFP_NOFAIL allocatiIon problem.
> 
> 

You are correct that the function isn't very important, but that is
because reiserfs itself isn't very important.
You might not have noticed, but in the reiserfs Kconfig file it says:

	  Reiserfs is deprecated and scheduled to be removed from the kernel
	  in 2025. If you are still using it, please migrate to another
	  filesystem or tell us your usecase for reiserfs.

So it will still be around for a few years, but there isn't much point
with small clean-ups like this as hardly anyone uses the code, and in a
few years it won't be in mainline Linux at all.

Thanks,
NeilBrown
