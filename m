Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4012A73EF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFZXaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFZXaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:30:15 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73DD198C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:30:14 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a0423ea74eso2795489b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687822214; x=1690414214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIFsN2elWZC5RqViV1mbnouEvdYpsztruO1AICvp7AE=;
        b=x62up01QN61j8uRDxz5+FQdVAIz4y5nE7af1TY1P6HUsA8oRbu2KL5BdSvzt4zsimY
         q0xyw5eF/2C4e4Jflz/eOnqHI6nEqIwnvBAJPvAGi0ulO4nAe5EzJrdufGs9TEMsxWvH
         vZs34YLgDNK/0PQmZiOPakarhsOs6gtF1LsMCu8HxHF34dqM1920OHH2zqLFfFuEKsjR
         h6glMEWDE51bc2/JU5JpEKbQVfmu2CTf4s9dwn4ogd7qA4pldpwiivy9X1uyJmkCGvS9
         ro0NeDMgmkuHJ2V0qnJcMlHSeJbdgGNuRwVIkTM2ndk40U1wP8cKBuAAAeWzQw4a1nQZ
         6SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687822214; x=1690414214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIFsN2elWZC5RqViV1mbnouEvdYpsztruO1AICvp7AE=;
        b=OxlfuItHVa/JRnRjJUY8Ch+HHJax9uQMXqCbNohA1IawBlUliI/g2Kq6nLZ/KyXe8l
         R9uGFsdQLqjrHewW4bDT45HhLMphYco0i950F1rpqM0KLB0xRKRv4ceMfLQR5SFcw0ZG
         sYMQZHdi+2d8+nYIjhEOmxyzT84xwaHp/lGt7YkmFLlG5ON/zUerinHbsjRvm2kZZnw+
         lBClNJzAGINbpYVAcksNv+Hav9cdcX73zN+zM5Dg3vntwryJnsvHzwXkrL9cOpYmRPEA
         LotBZSt/hmTi9L54BnQPvHFRZIfauTd8c5PrxT0+IchlaNUXeJOymuy+jdWrGLI3uLUm
         FdQg==
X-Gm-Message-State: AC+VfDy1/gLTzxtU7eVTKlyNwbecYCCRsyIXfeFMvqe4IxHmPesEFjSo
        onzb1KRe20l8oxIymsRhlxObJA==
X-Google-Smtp-Source: ACHHUZ58Ld9NBRiv6cF5YroDnkul8epKv/2ZkL5s7qwM1op4ejFcZXkw7gUcAKrwKUEsgdWbGxULYQ==
X-Received: by 2002:a54:4186:0:b0:3a1:a5a7:ec58 with SMTP id 6-20020a544186000000b003a1a5a7ec58mr8996933oiy.0.1687822214105;
        Mon, 26 Jun 2023 16:30:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id j3-20020a635943000000b00553b546a638sm4563860pgm.67.2023.06.26.16.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 16:30:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qDver-00Gc0G-1Q;
        Tue, 27 Jun 2023 09:30:09 +1000
Date:   Tue, 27 Jun 2023 09:30:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: remove per-CPU buffer_head lookup cache
Message-ID: <ZJofgZ/EHR8kFtth@dread.disaster.area>
References: <ZJnTRfHND0Wi4YcU@tpad>
 <ZJndTjktg17nulcs@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJndTjktg17nulcs@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:47:42PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 26, 2023 at 03:04:53PM -0300, Marcelo Tosatti wrote:
> > Upon closer investigation, it was found that in current codebase, lookup_bh_lru
> > is slower than __find_get_block_slow:
> > 
> >  114 ns per __find_get_block
> >  68 ns per __find_get_block_slow
> > 
> > So remove the per-CPU buffer_head caching.
> 
> LOL.  That's amazing.  I can't even see why it's so expensive.  The
> local_irq_disable(), perhaps?  Your test case is the best possible
> one for lookup_bh_lru() where you're not even doing the copy.

I think it's even simpler than that.

i.e. the lookaside cache is being missed, so it's a pure cost and
the code is always having to call __find_get_block_slow() anyway.
Peeking at 16 buffers to not find a match is just as expensive as
walking 3-4 tree levels in an Xarray to find the buffer in the first
place....

IMO, this is an example of how lookaside caches are only a benefit
if the working set of items largely fits in the lookaside cache and
the cache lookup itself is much, much slower than a lookaside cache
miss.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
