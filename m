Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C877A6333BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiKVDLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKVDLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:11:48 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC1BC0A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:11:47 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id v8so9426523qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHasZ5TNTFIcV1aNmBRElyhro7wai0QgU4JwVxsADWE=;
        b=fNxFFhXMdghSK2qF0UWo1QJ05yD5iNRjEj5tmtEOUsBbFxaj1tXcMaEuvQzYCkAabq
         l/eVSkCAAhOq5Gp1rOesNBaEAW3r6Rm/rDtgQf7kyy4Mmu/+MrkrBfTFEPFkjcHoysnt
         f6Qi7Iz6YxEJKwPB7pp2vYU/3pwC1j5nnb5XTBvfBGYYKvlzYqbx1ie8xQMroZ40zXIn
         80yeJdJJRdRoYoBfnQYV2ilfe6PCw1Hk/Z9e/UjnNpLmGmuZMY3br/z06V+xgaI6TsDj
         pchkgHFP+IVZWhx3Wx/Mn54Td41K3iEQm4NLQCojX+fGuAK5bAPDAbwLOBth21jCZ4XJ
         Aoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHasZ5TNTFIcV1aNmBRElyhro7wai0QgU4JwVxsADWE=;
        b=2o9wvLWYqTFWshk8R6CUVmhc02EIerlnAv8wtGIwDnWVF5g5rAvx/hC+qH/yRBeitC
         f9xL6r4cjMwbcBazr1Gp/9oXsVQ5PgZvkN+wdZ5RZZixWvlqvOiMMg+fud/GfiVOZRtR
         ZWxWOxkYjAOgNIfpVBcN9z/TTtWb0wwQDArfSoDvyjCVxdy21huncTYT3FMbw7WL1sHA
         T+CGaOHPzfAFwP1fBjrj6U1MeCyQDGj1s0xo9whdUOmnwHRaOKBdQfWem7AIK0MYSJyS
         kFm1MJD9w0d0DLr+Gn7mMeZkNXOPi4h//ypf/QCSmByD4sLox6Lyb7WR4iAZ7Aoaf6Rj
         yQVQ==
X-Gm-Message-State: ANoB5pmF7ngL5/Uo9/LKqZuYSAXnFwUWtkhGxByEdvaC2LpRZljHLYc0
        nqNNA7y4Y8Hj99h0XE01jqYL37nJIVVXTQ==
X-Google-Smtp-Source: AA0mqf5Z2Vozl4gOnaKFDsiHthpk/cDNUJ2Q5EzCmvnce66G41XXifggMdqlH7hkJSgqnY9dxVNu0g==
X-Received: by 2002:ae9:e714:0:b0:6fb:60da:96d0 with SMTP id m20-20020ae9e714000000b006fb60da96d0mr7214312qka.273.1669086706227;
        Mon, 21 Nov 2022 19:11:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a284400b006f9e103260dsm9313929qkp.91.2022.11.21.19.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:11:45 -0800 (PST)
Date:   Mon, 21 Nov 2022 22:12:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3w+C8ClzP6VbqrA@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
 <Y3wwuMSy8YC86QAi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3wwuMSy8YC86QAi@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:15:20AM +0900, Sergey Senozhatsky wrote:
> On (22/11/18 16:15), Nhat Pham wrote:
> > +
> > +static int zs_zpool_shrink(void *pool, unsigned int pages,
> > +			unsigned int *reclaimed)
> > +{
> > +	unsigned int total = 0;
> > +	int ret = -EINVAL;
> > +
> > +	while (total < pages) {
> > +		ret = zs_reclaim_page(pool, 8);
> > +		if (ret < 0)
> > +			break;
> > +		total++;
> > +	}
> > +
> > +	if (reclaimed)
> > +		*reclaimed = total;
> > +
> > +	return ret;
> > +}
> 
> A silly question: why do we need a retry loop in zs_reclaim_page()?

Individual objects in a zspage can be busy (swapped in simultaneously
for example), which will prevent the zspage from being freed. Zswap
currently requests reclaim of one backend page at a time (another
project...), so if we don't retry we're not meeting the reclaim goal
and cause rejections for new stores. Rejections are worse than moving
on to the adjacent LRU item, because a rejected page, which should be
at the head of the LRU, bypasses the list and goes straight to swap.

The number 8 is cribbed from zbud and z3fold. It works well in
practice, but is as arbitrary as MAX_RECLAIM_RETRIES used all over MM.
We may want to revisit it at some point, but we should probably do it
for all backends then.
