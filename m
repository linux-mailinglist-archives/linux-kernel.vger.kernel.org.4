Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E6D6F1227
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbjD1HNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1HNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:13:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD2F3C01;
        Fri, 28 Apr 2023 00:13:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 428511FFFA;
        Fri, 28 Apr 2023 07:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682665991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJ+TMkCiDgfegvvsz0b3841mXTh3rnZkeHoyCdZ3g2o=;
        b=W9kYRwWGdploRnynCxhQA6nn/OPsw3CdOInic8+pvp7oDcet2eShcDStKef/Ma72D5kMp5
        UZKPdwh88ZSsAnYG5r/die/XpbmsAO+GjZ6/fTaD4HG3bAyUtYN5zzdnI7kaTWpJCLHYXH
        I9BsMVyxKILhHqhDrWtTZ08UPT5OcmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682665991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJ+TMkCiDgfegvvsz0b3841mXTh3rnZkeHoyCdZ3g2o=;
        b=hI0/yIUG0x80oyE863aFGoetKlHqs9fMKCgzSEVLD5N7r6P4oduv/mBvD++Lt7TDCNEvNn
        irMGXGwb/GBARwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F36D138FA;
        Fri, 28 Apr 2023 07:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 60bxAgdyS2SzTQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 28 Apr 2023 07:13:11 +0000
Message-ID: <dbe9d5cc-80ed-7fcf-f0dc-197ed8885676@suse.cz>
Date:   Fri, 28 Apr 2023 09:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <greg@kroah.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
References: <20230427140959.27655-1-vbabka@suse.cz>
 <2023042719-stratus-pavestone-505e@gregkh>
 <3cc6e10c-f054-a30a-bf87-966098ccb7bf@suse.cz>
 <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
 <CAHk-=whwoKFbrCGXW9uwX3SPOezLdOKstuLAju1KTi5Ryq+ZcQ@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=whwoKFbrCGXW9uwX3SPOezLdOKstuLAju1KTi5Ryq+ZcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 04:53, Linus Torvalds wrote:
> Hi Vlastimil,

Hi Linus,

> On Thu, Apr 27, 2023 at 8:12 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Ack. It's in my tree as commit 7e7757876f25 right now (not pushed out
>> yet, will do the usual build tests and look around for other things
>> pending).
> 
> Gaah. I just merged Andrew's MM tree, and while it had a lot of small
> conflicts (and the ext4 ones were annoying semantic ones), the only
> one that was in *confusing* code was the one introduced by this
> one-liner fix.
> 
> I'm pretty sure I did the right thing, particularly given your other
> patch for the mm tree, but please humor me and take a look at it?

Sure, took a look and looks correct to me, thanks!

> That 'vma_merge()' function is the function from hell.

Yeah, unfortunately. But despite the bugs, I believe Liam's changes in 6.3
improved it a lot, as with __vma_adjust() it was much worse (it did e.g.
things like "swap(vma, expand)" in some cases). And hopefully the cleanups
from me and Lorenzo in the mm 6.4 pull request improved readability too,
even though it made the merge tricky.

> I haven't pushed out yet because it's still going through my build
> tests, but it should be out soon.
> 
>                        Linus

