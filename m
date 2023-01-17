Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434D66E741
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjAQTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjAQTpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:45:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B1B58662
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1dK4kC0gV7LIDY0KS3EQf7ODamXY8Y+Fsqo3hP5lPlI=; b=hRqEKrksojpyAih+9T7IxhDdsc
        aWA1lbNLg9bemkFWL15nNj0FMpqNAqHRezGxtsgoQtZvLeopVktrI1luSvWJjnpkTBReROPJcF9pE
        v1VW5rAuowOibpJ9KBmXXSr2Q/PLqZPCHucSIFBDLe4/iWXmmIV15qRgRNTATDHHLaGE8p8+xfqro
        SUfJAJ2JwRmWQjHTyI3lToHhgxYmOnXialf1eqA2stdzrS+RyQ8FlsKIDeGRbLY9OPVZeYuHE1yo5
        g1ULJJ6Vu0exZCliMFAH1hGEcYXfxA6yTCEuLZ08kl+ounBFIstzr3EAE3t5gJHWWC+L/msVqL52g
        ZVvuXb1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHqxh-009vBL-KS; Tue, 17 Jan 2023 18:45:33 +0000
Date:   Tue, 17 Jan 2023 18:45:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com
Subject: Re: [PATCH] mm/hugetlb: convert get_hwpoison_huge_page() to folios
Message-ID: <Y8bszRk2eG8s0uk5@casper.infradead.org>
References: <20230117182917.73729-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117182917.73729-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:29:17AM -0800, Sidhartha Kumar wrote:
> -	if (get_page_unless_zero(head)) {
> -		if (head == compound_head(page))
> +	if (folio_try_get(folio)) {
> +		if (&folio->page == compound_head(page))

I'd rather express this as:

		if (folio == page_folio(page))

as we do in mm/gup.c

