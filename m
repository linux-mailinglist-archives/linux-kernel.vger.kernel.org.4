Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F475B53C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiILGH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILGH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:07:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304CB21E31
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:07:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t70so7311561pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=heRnSh/ihPz3+Q+MxSXEW9Y8QcvUAW165V+3AmdWDkE=;
        b=IotzQhJcjicWgQP5XMB/92HGjGlouQVWh7eoE8Bej5xDodZfchNwMswgQ/VZjg+bNJ
         flPZn0Rjbs+CeV65AWIVvLp9lpWJb214z/YM8hZXah9l9E9/CeeEDlJQAjY8ULRQfGKf
         smbZt0e13eKDmTLcO/8lTk2ZzyKc93hD3mqRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=heRnSh/ihPz3+Q+MxSXEW9Y8QcvUAW165V+3AmdWDkE=;
        b=4bMPCPIbEHwD8qiINBrrA/41URP1/16/oA6QRB34PeeiX+Nr8ph3Q9Jq2mghwq5+nD
         6/99LICYi6sa/ZEjlHWFzUi8W3xfhCkKvZ0mKlnIhWddk2RxNsMKWqd/PaA4toWl6pBp
         JGz/ptIun7h4Qg8bC9kYU+TwgT1zaXps0R5AtftWL7JPmKRu15/fGYydE6I94OjhXE7K
         eod3i1ji84Zs9angCpyBWg553WTOzZlWQhEZuYbDiZTDwRqsbkXEwIEVDJoOQ11wlZG/
         j48sA1n2PwgDVgAOgGuvqFGEM9rn2PjLPReFqKwDZn64akTnNdc+zUTTV5suiq5Qsxsb
         99Fg==
X-Gm-Message-State: ACgBeo1yrS0xzjVqir44wT0jgHXoZlJHYwPNzxMLdw7ByDRFGVLp1weV
        4msvsWulZ4QMA5/TZ2GMIGTEgw==
X-Google-Smtp-Source: AA6agR4QuFyNN1qZkl+zW7LinZvUDCkJQmpMsBN8qqIqAmQeTFDLoC8ZLMcOQIzRsjSoKKdumBtiyQ==
X-Received: by 2002:a63:1953:0:b0:438:6e74:92e2 with SMTP id 19-20020a631953000000b004386e7492e2mr15594039pgz.150.1662962874712;
        Sun, 11 Sep 2022 23:07:54 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7b09:9fce:b16b:c111])
        by smtp.gmail.com with ESMTPSA id f16-20020aa79d90000000b005403b8f4bacsm4361429pfq.137.2022.09.11.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:07:53 -0700 (PDT)
Date:   Mon, 12 Sep 2022 15:07:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RESEND RFC] zram: Allow rw_page when page isn't written back.
Message-ID: <Yx7MtWdQ/WVE+EkG@google.com>
References: <20220908125037.1119114-1-bgeffon@google.com>
 <Yxr5oNaCwjn8cdFF@google.com>
 <Yx63e2lxNmEB3UhE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx63e2lxNmEB3UhE@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/12 13:37), Sergey Senozhatsky wrote:
> On (22/09/09 17:30), Sergey Senozhatsky wrote:
> > > +++ b/drivers/block/zram/zram_drv.h
> > > @@ -50,6 +50,7 @@ enum zram_pageflags {
> > >  	ZRAM_UNDER_WB,	/* page is under writeback */
> > >  	ZRAM_HUGE,	/* Incompressible page */
> > >  	ZRAM_IDLE,	/* not accessed page since last idle marking */
> > > +	ZRAM_NO_WB,	/* Do not allow page to be written back */
> > >  
> > >  	__NR_ZRAM_PAGEFLAGS,
> > >  };
> > 
> > Unrelated but somehow related.
> > 
> > I wonder if it's time for us to introduce a dedicated, say u16,
> > flags member to struct zram_table_entry. Unless my calculations
> > are extremely wrong, we are about to run out of spare bits in
> > zram_table_entry::flags on 32-bit systems.
> 
> Looking at it more - I wonder why do we define ZRAM_FLAG_SHIFT
> as 24? This is far more than maximum zram object size. Our max
> size needs PAGE_SHIFT bits (which is normally 12 bits, can be up
> to 16 (for 64k arm64 pages)). So we probably can start defining
> ZRAM_FLAG_SHIFT as (PAGE_SHIFT + 1).
> 
> Or am I missing something?

So I think what happened was that flags used to be a u8 member of
zram_table_entry, commit d2d5e762c8990 merged u16 size (which was
too large for object size) and u8 flags and just kept 8 bits for
flags (and somehow assumed 32-bit long? 32 - 8)

We definitely can store size in PAGE_SHIFT bits and have some
extra spare bits for zram pageflags. Would have been even nicer
if we could change type of flags from unsigned long to unsigned
int, but bit_lock requires "volatile unsigned long *" data type,
so because of bit_lock our zram_table_entriy is 4 extra bytes in
size. Which probably isn't too bad; having extra pageflag bits
on 32-bit systems is good news.
