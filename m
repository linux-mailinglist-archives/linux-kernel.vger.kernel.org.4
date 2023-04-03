Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC18F6D4CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjDCPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjDCPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:52:49 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B0448B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:52:21 -0700 (PDT)
Date:   Mon, 3 Apr 2023 11:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680537095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g2gJhk2EudPdDf1rhN0+Yqo19FdGtI3AE5kQt4njseU=;
        b=xvC3EoZpCjRIKJSK/hMwRQRQLoIWADFK/Lxj5KYc3TL23GHTWhquFpjxEiiIy/Ch8MjEuw
        MwwFvPIR7ofTcOYm5vwb8vNmt1FJzlw8x3sfWJD8pdQaZ9Y6G6yDyGciA0PezYCox2paBw
        EflYNGdHo2WjJQYRlkhAE5h/kg318tU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 2/2] block: Rework bio_for_each_folio_all()
Message-ID: <ZCr1/K03uGF3neCY@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-3-kent.overstreet@linux.dev>
 <ZCrtEWEYGdGN++wX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCrtEWEYGdGN++wX@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 08:13:21AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 27, 2023 at 01:44:02PM -0400, Kent Overstreet wrote:
> > +	bio_for_each_folio_all(fv, bio, iter)
> > +		iomap_finish_folio_read(fv.fv_folio, fv.fv_offset, fv.fv_len, error);
> 
> Please avoid the overly long lines.  Also if we pass all arguments
> of the folio_vec we might as ell just pass that folio_vec anyway.
> 
> > -	BUG_ON(iter->idx > bio->bi_vcnt || (iter->idx == bio->bi_vcnt && iter->done));
> > +	BUG_ON(iter->idx > bio->bi_vcnt ||
> > +	       (iter->idx == bio->bi_vcnt && iter->done));
> 
> Seems like this should be folded into the previous patch.  Also I
> generally prefer to avoid top-level || in asserts and just do multiple
> asserts, as that shows which condition triggered.

It should be folded in, but it's logically the same assert (advance
past the end of the iter) so not worth the increased code size.
