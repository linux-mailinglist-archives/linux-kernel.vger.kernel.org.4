Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0336E4FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjDQRxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjDQRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:53:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1DB76A3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tAQseiBOvTaWYKwBOg/JW/PRr596E4na6qpBjVgO9oM=; b=Z3UolhRnMkYgfJnzKd+YNFqAQw
        EXkALI6DwvdyOG6aOHbcymPWnBar+5oxelgEzJ8Lm05oGwDBCLrQmdr1z/rFeFAaWtiWSi92YyoWW
        xSqcERbHfTZJzneJQe9MaXUWh5onfj6kTmrJq+9O5x5Xct/T2n0LOU0c/xTok5HKQ9dPAkjBBeWVc
        HbwmXGBvi7xjFxrSX75ONtCuAHt6biksi4oSQ+q8VUch7w3iW7zTTQvCGe4Z3Fexea6qdSzggnYPk
        n+LqtzoTJJJjDeoNs2eCi1EpvDP+QymXgsLipkznldG8DYOzP4/SYA5/sBtTJqcBrz1nq7saCeva2
        GZAZ9jgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poT2a-00BYN3-52; Mon, 17 Apr 2023 17:53:24 +0000
Date:   Mon, 17 Apr 2023 18:53:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on
 SLAB_TYPESAFE_BY_RCU example code
Message-ID: <ZD2HlGwNkrrj+Odz@casper.infradead.org>
References: <e2561303-8853-7e16-7eba-001415d34e09@suse.cz>
 <20230417172657.21925-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417172657.21925-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 05:26:57PM +0000, SeongJae Park wrote:
> Hi Vlastimil,
> 
> On Mon, 17 Apr 2023 13:05:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > On 4/15/23 05:31, SeongJae Park wrote:
> > > The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU
> > 
> > Since "tiny RCU" means something quite specific in the RCU world, it can be
> > confusing to read it in this sense. We could say e.g. "... snippet uses a
> > single RCU read-side critical section for retries"?
> 
> Looks much better, thank you for this suggestion!
> 
> > 
> > > read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
> > > similar example code snippet, and commit da82af04352b ("doc: Update and
> > > wordsmith rculist_nulls.rst") has broken it.
> > 
> > "has broken it" has quite different meaning than "has broken it up" :) I
> > guess we could just add the "up", unless someone has an even better wording.
> 
> Good point, thank you for your suggestion!
> 
> I will apply above suggestion on the next spin.

For the last one, perhaps changing the tense would have more clarity:

similar example code snippet, and commit da82af04352b ("doc: Update and
wordsmith rculist_nulls.rst") broke it up.

