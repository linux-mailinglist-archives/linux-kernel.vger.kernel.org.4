Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E107476E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGDQiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjGDQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B68CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD06761301
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228A7C433C7;
        Tue,  4 Jul 2023 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688488700;
        bh=SRt5OSq7UcsVoo2ymLntkRLL6RnihDX9GuA6gQcoxW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hCn4l+cvagF7z1989a+b2iGQ7nKLnYNN3obSQ3+2Pb16X0nXchttRXUOH4aGXYRqJ
         OBIrBTZ64N/CaA+xbpsgiU/Kjx0M0iWUXJfFOKitdB643jwRA+G/EZZ4nd5vJJuGDZ
         p6J6r9IA7cNQ0i1LRZY+PFWae32zplgxotUDLMlw=
Date:   Tue, 4 Jul 2023 09:38:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: avoid false page outside zone error
 info
Message-Id: <20230704093819.48443ca7789043a640c8a07a@linux-foundation.org>
In-Reply-To: <feb41501-163a-58d6-1996-8d6ebc9d800e@huawei.com>
References: <20230704111823.940331-1-linmiaohe@huawei.com>
        <ZKQM2lg7524dIAQl@casper.infradead.org>
        <feb41501-163a-58d6-1996-8d6ebc9d800e@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 20:36:00 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2023/7/4 20:13, Matthew Wilcox wrote:
> > On Tue, Jul 04, 2023 at 07:18:23PM +0800, Miaohe Lin wrote:
> >> @@ -470,6 +470,8 @@ static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
> >>  		sp = zone->spanned_pages;
> >>  		if (!zone_spans_pfn(zone, pfn))
> >>  			ret = 1;
> >> +		else
> >> +			ret = 0;
> > 
> > Surely 'ret = zone_spans_pfn(zone, pfn);' ?
> 
> Do you mean 'ret = !zone_spans_pfn(zone, pfn);'?  This format looks fine to me.
> 
> > 
> > Also, did you spot this by inspection or do you have a test-case or bug
> > report?  Should this have a Fixes: tag?
> 
> This is from code inspection. The race window should be really small thus hard to trigger
> in real world. And yes, it seems Fixes tag is a really ancient commit:
> 
> 	Fixes: bdc8cb984576 ("[PATCH] memory hotplug locking: zone span seqlock")
> 

Thanks.  I updated the changelog:

: If pfn is outside zone boundaries in the first round, ret will be set to
: 1.  But if pfn is changed to inside the zone boundaries in zone span
: seqretry path, ret is still set to 1 leading to false page outside zone
: error info.
: 
: This is from code inspection.  The race window should be really small thus
: hard to trigger in real world.
: 
: Link: https://lkml.kernel.org/r/20230704111823.940331-1-linmiaohe@huawei.com
: Fixes: bdc8cb984576 ("[PATCH] memory hotplug locking: zone span seqlock")

and I made the change suggested by Matthew:

--- a/mm/page_alloc.c~mm-page_alloc-avoid-false-page-outside-zone-error-info-fix
+++ a/mm/page_alloc.c
@@ -468,10 +468,7 @@ static int page_outside_zone_boundaries(
 		seq = zone_span_seqbegin(zone);
 		start_pfn = zone->zone_start_pfn;
 		sp = zone->spanned_pages;
-		if (!zone_spans_pfn(zone, pfn))
-			ret = 1;
-		else
-			ret = 0;
+		ret = !zone_spans_pfn(zone, pfn);
 	} while (zone_span_seqretry(zone, seq));
 
 	if (ret)
_

