Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22497676CFB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjAVMqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjAVMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:46:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B2A1CF4F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CdKr/UFEr7dJdPPUgqI9vUvjW7dN3rwVi2gyKtLfEgQ=; b=pG9PACitoGmNRyTgP5wHmcRXoU
        6di/FFfDlniKNG8UQN0JTdq5llbPcaCZfBpFFpYAkiIfMMPAdniEu7IMSFzq2LBRocXRbo3u7x+nJ
        f+hqWjL+I5jQ15IwuaWF0Qon+YyhOtMn/SO93ut5fERcyUyUntbpf1bdYL6PG0HK1k6akPowZV10w
        Ja8gVuY4Dxn6Ad9P8y37ROYw3Ai+A3Z0r2kU6VoFVDt1BT5Vpsk1U9YhHJ4+oUqN1Jf3+4JRdq45F
        yOQGxkAx+RarD/KXrd6q420U0+ZHCCKH+8qAybWbjJTh9Jp7XFmF6TpKrs+zuttsLkn9pXJdnzy6H
        GOxpBKzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJZk2-003YbK-Uy; Sun, 22 Jan 2023 12:46:34 +0000
Date:   Sun, 22 Jan 2023 12:46:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        sidhartha.kumar@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/migrate: Convert isolate_movable_page() to use
 folios
Message-ID: <Y80wKtc22eHApjEN@casper.infradead.org>
References: <20230121005622.57808-1-vishal.moola@gmail.com>
 <20230121005622.57808-3-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121005622.57808-3-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:56:21PM -0800, Vishal Moola (Oracle) wrote:
>  int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  {
> +	struct folio *folio = page_folio(page);
>  	const struct movable_operations *mops;
>  
>  	/*
> @@ -71,11 +72,11 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	 * the put_page() at the end of this block will take care of
>  	 * release this page, thus avoiding a nasty leakage.
>  	 */
> -	if (unlikely(!get_page_unless_zero(page)))
> +	if (unlikely(!folio_try_get(folio)))

This changes behaviour.  Previously when called on a tail page, the
call failed.  Now it succeeds, getting a ref on something that at
least was the folio head at some point.

If you're going to do this, you need to recheck that the page is still
part of the folio after getting the ref (see gup.c for an example).
But I think we should probably maintain the behaviour of failing on
tail pages.

Maybe something like ...

	if (unlikely(!get_page_unless_zero(page)))
		goto out;
	/* Refcount is zero on tail pages, so we must have a head */
	folio = (struct folio *)page;

