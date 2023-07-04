Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CE7470A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjGDMOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGDMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:14:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791AF1709
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AeT8U3XbrJM+IpxFqUmrW6am26kBs6TNymHmIaQUPXs=; b=EuDxWAmYbZuisMm6kdnNRQdfAy
        Bt8Qmglfmqzn0VXmuT15QuhZt/G1PgzwTmcglPZAeydtPV5szhEou1GRXfqfK6BGFk3O71eZHHb+5
        eTxipTRjPMlHRR4mEkbZBvZSyJWheBhvfuL6XDUyVpGtzlQdGk6RpGSzpkEwrlEaxY5LTa02vi6aJ
        dWsGA6XYSy150Km/IaEPXwf6fhsQLh4fHXnCm7kuivoF9wYA6DrRLgOvz4OZxS2KaT2ms3qodApVs
        luasXECj6+ZxO6QNzioH4IAzEv+st3/YJGcqwCwxZvkQwaHhD+zwUmaGTlJClp942Tvtfnx/inNR4
        Wx7TPaPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGeuA-0098BO-RB; Tue, 04 Jul 2023 12:13:14 +0000
Date:   Tue, 4 Jul 2023 13:13:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: avoid false page outside zone error info
Message-ID: <ZKQM2lg7524dIAQl@casper.infradead.org>
References: <20230704111823.940331-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704111823.940331-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:18:23PM +0800, Miaohe Lin wrote:
> @@ -470,6 +470,8 @@ static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
>  		sp = zone->spanned_pages;
>  		if (!zone_spans_pfn(zone, pfn))
>  			ret = 1;
> +		else
> +			ret = 0;

Surely 'ret = zone_spans_pfn(zone, pfn);' ?

Also, did you spot this by inspection or do you have a test-case or bug
report?  Should this have a Fixes: tag?

