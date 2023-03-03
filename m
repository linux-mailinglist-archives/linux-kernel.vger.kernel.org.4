Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0FA6A9EEE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjCCShb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCCSh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:37:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46B60D4F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:37:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29ACA61864
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1375EC433EF;
        Fri,  3 Mar 2023 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677868644;
        bh=5VS5XD3aopCKWM9JTeZDCTyMBWVPcB+DkyyfJ8MlSXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDsxeXbEpmzOFkAE0D7aQfG+IpmIJt9cqHZzJYXvK54CZ80JIipc9IeCzA618Cxeo
         1Vl0LGnSiOFgTK1FlzNZKSXTsbztN3MBX0NYE+OQmC4ZeiLI7EQGfK/8Ek8hjTMAW/
         KjqE64xMvoE8pv91cvzPPURq0d7TEQG1vRXoUn2je/m5scx+X+JpOf7HQoKp4IKJSg
         rbIMtjW1XAtGQwgGqneY0zsjBdEaaec8m0fxM3Bb5z4ezKOPSeqKuWzSj6ZzY+tjiH
         aU3Svqc1nFwitx7jHTGaC3bdkM4aXzhanrP1OnjCh5u/BG6dg1FejcPBRLwiNRVwXI
         SwQQvGAIYh5Rg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mm/damon/paddr: minor refactor of damon_pa_mark_accessed_or_deactivate()
Date:   Fri,  3 Mar 2023 18:37:22 +0000
Message-Id: <20230303183722.113464-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303182633.113353-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 18:26:33 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 3 Mar 2023 16:43:43 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
> > Omit one line by unified folio_put(), and make code more clear.
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  mm/damon/paddr.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 2ef9db0189ca..6930ebf3667c 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -266,17 +266,16 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
> >  		if (!folio)
> >  			continue;
> >  
> > -		if (damos_pa_filter_out(s, folio)) {
> > -			folio_put(folio);
> > -			continue;
> > -		}
> > +		if (damos_pa_filter_out(s, folio))
> > +			goto put_folio;
> >  
> >  		if (mark_accessed)
> >  			folio_mark_accessed(folio);
> >  		else
> >  			folio_deactivate(folio);
> > -		folio_put(folio);
> >  		applied += folio_nr_pages(folio);
> > +put_folio:
> > +		folio_put(folio);
> 
> I think this change is ok, but shouldn't the 'folio_put()' have called before

s/before/after/

> 'folio_nr_pages()' anyway?  If so, could we make the change as a separate fix
> first, and then make this change, so that it can be easily applied to relevant
> stable kernels?
> 
> 
> Thanks,
> SJ
> 
> >  	}
> >  	return applied * PAGE_SIZE;
> >  }
> > -- 
> > 2.35.3
> > 
> > 
