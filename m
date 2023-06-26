Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC073DEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFZMRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFZMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:17:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD7E56
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=R4tjfUZZ3ZzgCOG/Djcs2zoeSaqHM5jLeuwOhbQ5exw=; b=vERxQwvE3o7wKKT+TE3cMyGukY
        0Wen//vsB9rcCl+/Nvx5OmSyJl4WYQYH/izrhNOBzMD91XX+3zp1tW4vucFWCLuSNA6k1f9zqMtBV
        BPLJ3yMw9Xbx8hndsmi7UvlvC3SrfZAxVrw4yctl+TuFSTecnSGaVqevmGzqb3aA0Gu8xoZDXiSnY
        1LKj0AVEOyrgX7f6Rq2G2mJGMB1k9R/RXIegO4M5YO3cf+wqT3I58ZFsg10Xj+HI+6kQvyEo/zIcM
        GoMhnVcIGmdNgYHMijFLSpt/ccA1Cmvav9XnUqMWVcSbl1CEENBfd3SNi9amTlV6Iw33gP1aaBxgC
        cAG6aWAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDl8s-001hPT-Ki; Mon, 26 Jun 2023 12:16:26 +0000
Date:   Mon, 26 Jun 2023 13:16:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: f2fs async buffered write patch
Message-ID: <ZJmBmt3WmUpWR3+2@casper.infradead.org>
References: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
 <953510c3-4bcd-1426-3527-09d5cbdcf8cc@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <953510c3-4bcd-1426-3527-09d5cbdcf8cc@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 03:31:57PM +0800, Yangtao Li wrote:
> +cc willy@infradead.org
> 
> 
> On 2023/6/20 4:43, Jens Axboe wrote:
> 
> > Hi,
> > 
> > I came across this patch in a news posting:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d618126911829523e35a61f4a5a4ad159b1b2c8d
> > 
> > which has me a bit worried. As far as I can tell, all that patch does is
> > set FMODE_BUF_WASYNC, and then just hope that the lower layers handle
> > the rest?
> > 
> > What happens if iocb->ki_flags & IOCB_NOWAIT is true, and now we do:
> > 
> > generic_perform_write(iocb, from)
> > 	...
> > 	->write_begin() <- does this block?
> 
> Most file systems have not been changed to the iomap method,

That's what needs to be fixed.

> and the generic_perform_write method is still used. So it seems
> 
>  reasonable to make IOCB_NOWAIT be handled correctly by the
> 
>  generic_perform_write function. This means that we need to modify

No.  Use the modern infrastructure.

>  several places mentioned by Jens in the generic_perform_write function,
> 
>  and need to pass AOP_FLAG_xxx or iocb into write_begin.

Definitely not.

> 
> I noticed that Matthew Wilcox removed the flags parameter in write_begin
> 
> in a previous commit, maybe we can add it back?

No.
