Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B94728C99
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjFIAug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFIAue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD130DD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA6C26519C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CC3C433EF;
        Fri,  9 Jun 2023 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686271832;
        bh=87EB8I2ht9Y+kEq5/TYmOKwCXNNl7S/E+DgNT6aNAw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EcmJE2zUJx0QdT/MAxGJmLaUKyEQ1DhulADibs1DCIKVZM6KSqe0VbHT7feN3MS0L
         21/6V3scYHcyJyuojPUmrLgx4XJ4cX6TyyDrmkm9X3kFw9fjLTKvAuDSmTYRQDKRmH
         XZkddce8Cnk8QFk+0AdMngWI2h/80Rc928HUXZGQ=
Date:   Thu, 8 Jun 2023 17:50:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [PATCH] afs: Fix waiting for writeback then skipping folio
Message-Id: <20230608175031.9c534e7f554de89e3d972ab2@linux-foundation.org>
In-Reply-To: <20230607204120.89416-2-vishal.moola@gmail.com>
References: <20230607204120.89416-1-vishal.moola@gmail.com>
        <20230607204120.89416-2-vishal.moola@gmail.com>
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

On Wed,  7 Jun 2023 13:41:20 -0700 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:

> Commit acc8d8588cb7 converted afs_writepages_region() to write back a
> folio batch. The function waits for writeback to a folio, but then
> proceeds to the rest of the batch without trying to write that folio
> again. This patch fixes has it attempt to write the folio again.
> 
> This has only been compile tested.

This seems fairly serious?

> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -731,6 +731,7 @@ static int afs_writepages_region(struct address_space *mapping,
>  			 * (changing page->mapping to NULL), or even swizzled
>  			 * back from swapper_space to tmpfs file mapping
>  			 */
> +try_again:
>  			if (wbc->sync_mode != WB_SYNC_NONE) {
>  				ret = folio_lock_killable(folio);
>  				if (ret < 0) {
> @@ -757,6 +758,7 @@ static int afs_writepages_region(struct address_space *mapping,
>  #ifdef CONFIG_AFS_FSCACHE
>  					folio_wait_fscache(folio);
>  #endif
> +					goto try_again;
>  				} else {
>  					start += folio_size(folio);
>  				}

From my reading, we'll fail to write out the dirty data.  Presumably
not easily observable, as it will get written out again later on.  But
we're also calling afs_write_back_from_locked_folio() with an unlocked
folio, which might cause mayhem.

So I'm suspecting that a cc:stable is needed.  David, could you please
take a look and perhaps retest?

Thanks.
