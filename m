Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5926370F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiKXDVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiKXDVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:21:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CCD06FA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:21:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so463526pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHv32wwTpzBjTynX/gdAaEUNtv1wZDAgeTnBSrXjjGI=;
        b=DEygdYza5G8MwNI5sNBZ3XingdLfN4mbDYfS396z5R8GJsj4HGQrtX4QBbJM80BNq0
         aT7XL1m85vcYO1bnbIPByFyqgIVw1USABubQuEsUpJjgpqSw3DusTnvYh65McgqcjP9J
         Wtki4hHNXClWs8RvZ3RljGZAIsoJCY2aoIuKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHv32wwTpzBjTynX/gdAaEUNtv1wZDAgeTnBSrXjjGI=;
        b=Q/howtrbeSkFBam5YHe2cXYV87HcjH1O99l+wWAWg2PTOMDeEewaTxYFtgvUBnKqod
         pi8LTn6nqppy9cE9CkqUB0HCfDgC68MlJAEbuZdL/Daql8i8KJ7pHw5ml4qlG4M3CuOc
         NpoSdxc4yTSyb/QeHQDCocV3f2DDeMoy6bLl4L3kqI3eCEcpjUkEyz52obes2lpjZVOE
         azPcAlM6p7iW4H5UCt5TrldJW7d1YVdIiW3eXgIc/JRyIUQs/lOO6wfgLX6eFVRhQo3J
         ufAGh8o/xgmBvnH+hXDQ6IdGn1o7YrrSDYubOO3dRhGH+8f8vZVUI69KW65qRLBPM3cP
         Q1vQ==
X-Gm-Message-State: ANoB5pmkcjvKJadEwJT6eDSM3rk+1T2t/zG3DILidjX4PEoGiN5qGgtu
        sRMa+FxoN6LGx40Ap4T+oCIilNjkNIVrEg==
X-Google-Smtp-Source: AA0mqf45doR8yCL5Lt/QjpyG5w0fUlinFLijPOIFOgHp6OfcvHjismnlLfmJTmpgbjHSUdWEng3IFg==
X-Received: by 2002:a17:90a:4886:b0:211:42a9:d132 with SMTP id b6-20020a17090a488600b0021142a9d132mr34019411pjh.8.1669260099592;
        Wed, 23 Nov 2022 19:21:39 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:438d:8b02:662d:50b3])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b0018544ad1e8esm15180038plr.238.2022.11.23.19.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:21:39 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:21:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y37jPSuYVT64minI@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
 <Y3wreqR1IRWFtSUz@google.com>
 <Y30KIbewtg+b5JTq@cmpxchg.org>
 <Y32Yl/Emcw/2a51t@google.com>
 <CAJD7tkZM1KwQpkS5fTaL0A4=VLv=HEWxCc1kd45s49-s4__e1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZM1KwQpkS5fTaL0A4=VLv=HEWxCc1kd45s49-s4__e1Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/23 00:02), Yosry Ahmed wrote:
> > There are no accesses to swapped out pages yes, but zspage holds multiple
> > objects, which are compressed swapped out pages in this particular case.
> > For example, zspage in class size 176 (bytes) can hold 93 objects per-zspage,
> > that is 93 compressed swapped out pages. Consider ZS_FULL zspages which
> > is at the tail of the LRU list. Suppose that we page-faulted 20 times and
> > read 20 objects from that zspage, IOW zspage has been in use 20 times very
> > recently, while writeback still considers it to be "not-used" and will
> > evict it.
> >
> > So if this works for you then I'm fine. But we probably, like you suggested,
> > can document a couple of things here - namely why WRITE access to zspage
> > counts as "zspage is in use" but READ access to the same zspage does not
> > count as "zspage is in use".
> >
> 
> I guess the key here is that we have an LRU of zspages, when we really
> want an LRU of compressed objects. In some cases, we may end up
> reclaiming the wrong pages.

Yes, completely agree.

[..]
> Ideally, we would have an LRU of objects instead, but this would be
> very complicated with the current form of writeback.

Right. So we have two writebacks now: one in zram and on in zsmalloc.
And zram writeback works with objects' access patterns, it simply tracks
timestamps per entry and it doesn't know/care about zspages. Writeback
targets in zram are selected by simply looking at timestamps of objects
(compressed normal pages). And that is the right level for LRU, allocator
is too low-level for this.

I'm looking forward to seeing new LRU implementation (at a level higher
than allocator) :)
