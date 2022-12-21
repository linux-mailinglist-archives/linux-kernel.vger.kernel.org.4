Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43B653054
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiLULj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLULjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:39:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B198A1DF0A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:39:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 1so23093608lfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcOAZ1b4V0JHDlFi6vemRpWBd7E+1UkjfBLEbbTl/Do=;
        b=mTbZppwnJqQvWr8Uf7k9OT9/r7KlCF+MteCB2q+/e/36aQ7yjH+o1zZie0jW8LeTP4
         C1N8ysoJm6Gb1+k9Xnpt+bN5F54aJE/ZYQ8Fzza9hwV8pKFNoErNfTJP6neEGPgpJpXW
         xpl+SMFAdk7yES6SXS15EzVbWcFD93Wxj+bifpne8F3V2WhdbpCGfQu0gtzFczIGfTGZ
         +aBa4n3brk0BVX2UZFSH9V0Ag8zfm7hkNCgHo0W3AeLzkWOwyHUhh5kYPjCYZ0G038R6
         77m/u9MBQyNONFT1DQ6QrtM+MCkKRe3hdibLWzcOgpuRbrNmnOpi2hwVfNTFtXS6xy63
         nGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcOAZ1b4V0JHDlFi6vemRpWBd7E+1UkjfBLEbbTl/Do=;
        b=fAa+yApH95iFP6LZrBSZk6DZN4jHk4j6O6MBH60OpZILJ+6VOgw2eAzz4ZJIqniICL
         dTiN2DGWFNrDjDiyPPnfxPQ7e53QHxrzj4ULTCQ9eyGv/ZctVQBeHih4iMe4VcaQNSwU
         5I3yrCMZ03H7nzZKLuSwF4xNmXRtSL7P9nkF0xd7h+z0JEFL5AcoJH00FhdWshh8sPn2
         IPMsCKl8jXVZeIMB+BrTRi8Sz/OH8jNshm+D25udPUp0Ib75W9qNBvD2Zq2nEYN+uepq
         uP88tbX2yE4+9ttlhTs0zt0yOPNP5OZVMLeJNPeZNUDfsUsxZhRgWluAF6kIzwKktPQO
         WW9w==
X-Gm-Message-State: AFqh2kok/3jDcVBqq4vtrGlxcgQmIo+uzyKqDoGFt85KHfJTrsC75U3J
        EnE2K/ToY2f6nu1CqhrPKUI=
X-Google-Smtp-Source: AMrXdXsL6XBIJLCnp+GoORbmld1Yl1OUfL2YJX95BH5pgOWqHgtmlAv55mITc8Slv4YjKH6Xh7fjKw==
X-Received: by 2002:ac2:5231:0:b0:4a6:c596:6ff7 with SMTP id i17-20020ac25231000000b004a6c5966ff7mr445761lfl.2.1671622789882;
        Wed, 21 Dec 2022 03:39:49 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id o15-20020a05651205cf00b004b15bc0ff63sm1801594lfo.277.2022.12.21.03.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 03:39:49 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 21 Dec 2022 12:39:46 +0100
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] mm: vmalloc: Replace BUG_ON() by WARN_ON_ONCE()
Message-ID: <Y6Lwgot7idEv5OTx@pc636>
References: <20221220182704.181657-1-urezki@gmail.com>
 <20221220182704.181657-2-urezki@gmail.com>
 <Y6IEnojgQtQcUgDe@lucifer>
 <Y6IFZozJxCkMTorA@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6IFZozJxCkMTorA@lucifer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 06:56:38PM +0000, Lorenzo Stoakes wrote:
> On Tue, Dec 20, 2022 at 06:53:18PM +0000, Lorenzo Stoakes wrote:
> [snip
> > Absolutely in favour of this in principle (BUG_ON() is something we should
> > resort to in only the direst of circumstances), one small nit - perhaps it'd be
> > neater to simply make this a guard clause? E.g.:-
> >
> > 	if (!WARN_ON_ONCE(!va))
> > 		return;
> >
> > 	...
> 
> Made a mistake here, meant to say
> 
>  	if (WARN_ON_ONCE(!va))
>  		return;
> 
Agree. This looks better. Less confusing :)

I will post a v2.

--
Uladzislau Rezki
