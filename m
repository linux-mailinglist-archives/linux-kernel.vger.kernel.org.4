Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03032705FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjEQGX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjEQGX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:23:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1BB40DA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:23:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso2077095e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684304599; x=1686896599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NS9MMOeGbk46KEukFDZfhL0rwBxUJBfRVrmkoFj2ZF4=;
        b=mYqdXP8J9kEaCTfDD7GUZxQFJSqPwzz7ecfonARTNk9LHk+2ba7eNClMd/ujaR/Tmd
         uN48x9UpqckKUkZNW0R6kAwhFM641KB2yHZa6D1y9pEkB9SA26CNDs7GTe3Ji6xLSGk9
         eVAyjTB9gFYh3chvTv5RMRtZmMg3jdooU5jvMfRX37U7ExSNgwCranU/+J7UFmB2USj6
         9yzjSKj/W3bp35pX6hrizwjftEpvnt4HhUc7aEy9k0YCHgopRqhgeQxEIzn/bZnjdXxK
         yGHSyXGT2oAOwUgNnGwdPusK5EYBDPIfXSfA7NL3wjveDEP1+AgLOPbjDk7KdETbJ7ZH
         kfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304599; x=1686896599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS9MMOeGbk46KEukFDZfhL0rwBxUJBfRVrmkoFj2ZF4=;
        b=M3pF7mwQL/o9R9yAT7Jep5QpLq4hDfXDTY9EbV1ah5GbN2QM23WnnTjNDJkhfiDG42
         mk4cxMoaK/96saPjAjUDRzkqoriTBeUOphgdFmK2H3jhDnnetArZMSyEvJZWFAm9QAwA
         Fq0uQfUUfQ2w4b8oQnRz8y7jzxt5gNalLiz1I/JEYzTmQUUEqHIdSqEeGRPFc1ESaTsD
         mjN3doTv27Pw1D/hMalEj7wvc5jsxIotcr5IDlIEqB7AgBON4y6UHTYn54nRewkKuhKA
         c4sg/CaBF1h6gsFOEfXxTssFM1THHVisGfBgAg2ySdqIwCQTGtAUX4TaEVlc6rLbQX6W
         +LKQ==
X-Gm-Message-State: AC+VfDxBsSgRKSjC/dqh7R4xOsQ7US1obwpuLHk+RoWZUlzJzVlatdsy
        NbPrfMSGwQW9uQrmg99ncmY=
X-Google-Smtp-Source: ACHHUZ7r5LzCQMVpC3FGu3ITQsbJLJoRLsPva50TRn0LrydoALbhAoruaWc9q873rKtnnkgWSQUN2w==
X-Received: by 2002:adf:dd91:0:b0:2dd:11b8:8aa9 with SMTP id x17-20020adfdd91000000b002dd11b88aa9mr29020622wrl.15.1684304599232;
        Tue, 16 May 2023 23:23:19 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id j11-20020adff54b000000b003062c609115sm1643188wrp.21.2023.05.16.23.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:23:18 -0700 (PDT)
Date:   Wed, 17 May 2023 07:23:17 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Message-ID: <029289f2-1300-422a-8771-1d6b83470aad@lucifer.local>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
 <db1b8b8f-c3ac-4dbb-8b15-125c0929856a@lucifer.local>
 <ZGRyF1nL20wUK2et@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGRyF1nL20wUK2et@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:20:07PM -0700, Christoph Hellwig wrote:
> On Sat, May 13, 2023 at 02:14:18PM +0100, Lorenzo Stoakes wrote:
> > > Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> >
> > Not sure if this is really 'fixing' anything, I mean ostensibly, but not
> > sure if the tag is relevant here, that is more so for a bug being
> > introduced, and unless an issue has arisen not sure if it's
> > appropriate. But this might be a nit, again!
>
> vmap_pfn was factored out of i915-specific code, which probably never
> ran on anything but x86 at that time.  Now that intel builds plug in
> GPUs is probably could.  But independent of that core mm code should use
> the proper APIs.
>

Yeah indeed, I just wondered if the tag was quite right for this but it's not a
big deal, fine to leave in.

I agree the approach is correct, just wanted your ok so also adding my:-

Acked-by: Lorenzo Stoakes <lstoakes@gmail.com>
