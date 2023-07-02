Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE9A744DAD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGBNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGBNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:05:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB15A1AC;
        Sun,  2 Jul 2023 06:05:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso51132685e9.0;
        Sun, 02 Jul 2023 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688303112; x=1690895112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgdbr/HmtEQw8fSZt1jOsGt71w5fzM6AVixcIzI7qJk=;
        b=BuPmVteApu1zcDJhkUW6FT4U4hP+BmZp0AG67WPeohkAkUaRSYIPGHMQywBPlsSJ0P
         h5qj/+r+48xaHfmRiiNH5c0Gf+3xVPtZpIGeYBRcrq1XmkGHl5mO7hEWe/7sWhgIbD1s
         bHzPJQwPlAs4p4VLR4rYJUJngP9OEFdF6wQKvjyaV+B0pTK2sJqPptr1rr9D41tv8yWU
         SYHetBT2ppr6gclkuXPAH6FZsoAl7QyVI+3G4qC6R2JSzOPZ+73MkU7anseCunQEOTry
         r2JFe6Bo9DHxcrCmZYFQzBbm3DlZ2bARdpO2yS+5IjrzXKjyoIXJeMExt7WRGV8kXhRZ
         UqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688303112; x=1690895112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dgdbr/HmtEQw8fSZt1jOsGt71w5fzM6AVixcIzI7qJk=;
        b=LZZ42FNNYDmK2E3kvH+6xFWVozLqgSQhKbWfZKM0k/zbS1TlSoMkb2cDkz4lIIhhJv
         vc/cTM0RBkO8Mgv6OHb3bOUs05x6hOIf45SUKhYA0MXmVE9yrGBqjl8doQGnbLuI3niY
         Ot5QceYnNLo3nsPRt9zhUWnGmnCfbbqQITSagpNqoq7cf/EpMoCucjfdKprWDsUy+dQ2
         N0HrNpTp+Pu6/XJKhkTdVIPzRDwNz+58GBOYwtFrnlXhxZBdp9uo+SZbwv/djKQRRK9l
         lJ/E08M7z9s358MCfdQXRSR0BZl3dk7qIxLk1X/l2WueVKNw8gPznrdavDeOH4hOQxMy
         HnUQ==
X-Gm-Message-State: AC+VfDy/9fPdy9+Yg2YIV6qURZKT9qrdy3D2zy94slVZzf7RPIjFZlJG
        2mLuv/5SHMTiaFi01gYV4J0=
X-Google-Smtp-Source: ACHHUZ6x9muc0ceSGU0/UqnBfVnTakbxWSM5xC6YsLa4F04Hq/9xgiIO0ebupNDInRMKFkZRBtuxQw==
X-Received: by 2002:a7b:c445:0:b0:3fb:adc0:c37d with SMTP id l5-20020a7bc445000000b003fbadc0c37dmr9207057wmi.38.1688303112007;
        Sun, 02 Jul 2023 06:05:12 -0700 (PDT)
Received: from suse.localnet (host-82-49-237-33.retail.telecomitalia.it. [82.49.237.33])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003fba6709c68sm15014903wmr.47.2023.07.02.06.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 06:05:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Deming Wang <wangdeming@inspur.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] Documentation/mm: Add information about kmap_local_folio()
Date:   Sun, 02 Jul 2023 15:05:09 +0200
Message-ID: <2238844.iZASKD2KPV@suse>
In-Reply-To: <970a881a-cdaf-2568-657a-3b93b0273338@infradead.org>
References: <20230701142041.9992-1-fmdefrancesco@gmail.com>
 <ZKC8uE9fE57PuL91@casper.infradead.org>
 <970a881a-cdaf-2568-657a-3b93b0273338@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 2 luglio 2023 01:59:04 CEST Randy Dunlap wrote:
> On 7/1/23 16:54, Matthew Wilcox wrote:
> > On Sat, Jul 01, 2023 at 08:21:20AM -0700, Randy Dunlap wrote:
> >>> -* kmap_local_page().  This function is used to require short term
> >>> mappings.
> >>> -  It can be invoked from any context (including interrupts) but the
> >>> mappings
> >>> -  can only be used in the context which acquired them.
> >>> -
> >>> -  This function should always be used, whereas kmap_atomic() and kmap()
> >>> have
> >>> +* kmap_local_page(), kmap_local_folio() - These functions are used to
> >>> require
> >>>  
> >> acquire?
> > 
> > "create" might be better?
> 
> Yes, that's good.

Agreed.
However, I can send next version only by week 28th.

Thanks,

Fabio

P.S.: Actually I meant "to request". Unfortunately, "to request" and "to 
require" may have the same translation in Italian, my native language.

I preferred to not use "acquire" because it is re-used few lines below. So I 
thought that "to request short term mappings" was good (although I wrongly 
confused the different meanings between "to require" and "to request").

Matthew's suggestion to use "create" avoids repetition of "acquire(d)".  

> >>> +  short term mappings. They can be invoked from any context (including
> >>> +  interrupts) but the mappings can only be used in the context which
> >>> acquired +  them. The only differences between them consist in the first
> >>> taking a pointer +  to a struct page and the second taking a pointer to
> >>> struct folio and the byte +  offset within the folio which identifies 
the
> >>> page.
> >> 
> >> --
> >> ~Randy
> 
> --
> ~Randy




