Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0023F6F5280
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjECIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjECIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:01:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF321BEB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hdEbYtS1iRPX3ufit0+uNAIFJ7lCoR0ZmQxqt1yihgI=; b=HS5Y9S3MqENTJyAf/kMk1nj0PD
        xFOss2GETs9WooaMp2m98KNsESsdNVNRVu4upkIAo2s67kxTJxmgE+3AU6AlpissNEgN3s9ndVOS6
        epMjtDOZdhHI/aqmkvosMiTt5DGzNBdsPLYkKDlxKjoMysxEHaPoBRvwfJb26bZpt2aGHwBQg+IdI
        cEfzb9hGhGkXw3Ju6EBVql6YjiA8utMWhLwLDKeJgfCEjEiMIIQEqcOhkczo5Y1GUJOc1+sN97mA3
        E5jHqiVEmmvWt1d+Tr7R4J94KXAfLkUuzi1hfqZLJcR3fNDBWdEJX/EfmkjLz69z2W/EvLf3d3Qpw
        ELL/OExQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pu7QX-0000vk-14;
        Wed, 03 May 2023 08:01:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 487B630062D;
        Wed,  3 May 2023 10:01:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F235128110D0A; Wed,  3 May 2023 10:01:26 +0200 (CEST)
Date:   Wed, 3 May 2023 10:01:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [GIT PULL] x86/mm for 6.4
Message-ID: <20230503080126.GA1676736@hirez.programming.kicks-ass.net>
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name>
 <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 01:14:33PM -0700, Linus Torvalds wrote:
> On Tue, May 2, 2023 at 9:00 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > > I guess it also wouldn't matter as much either if we hid it in a helper
> > > like the attached patch and I didn't have to read it twice. ;)
> >
> > Yeah, I think that's a good solution.
> 
> Hmm. And as I was rebasing the patch to fix up my patch, I realized
> that the current -git top-of-tree state is actually broken.
> 
> That
> 
>   #define access_ok(addr, size)                                           \
>   ({                                                                      \
>           WARN_ON_IN_IRQ();                                               \
>           likely(__access_ok(untagged_addr(addr), size));                 \
>   })
> 
> is actually *wrong* in two ways.
> 
> Now, in my original patch, I added a comment about how that
> "WARN_ON_IN_IRQ()" is bogus and this shouldn't be x86-specific at all.
> 
> I ended up going back in time to see why it was added, and I think it
> was added because we used to access 'current' in access_ok(), due to
> it using that user_addr_max() thing:
> 
>         likely(!__range_not_ok(addr, size, user_addr_max()));
> 
> but that was all removed by the set_fs() removal by Christoph Hellwig.

So I had a poke around, trying to figure out where it came from, and
yes. Commit ae31fe51a3cc ("perf/x86: Restore TASK_SIZE check on frame
pointer") is the reason that WARN_ON_IN_IRQ() thing got added.


