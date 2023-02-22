Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F2C69F8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBVQZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjBVQZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29A360AD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677083099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLhtXBcdn1xpAegjTPnSxn7PzROariqCocZMwH9dRzI=;
        b=gG6sNQhWSAYKR7Be4JXCC6OZA+ikzhMWOVDDGiJemyFqROrMi8uYXaMtcTueVPIi1IfRIg
        IYnm8ylOKxrekYxqN/bFZFWhdT2o6hhF3DGAwyPP0JM36Vapn87b+ZuFImI5jbznWaZjoe
        e0kWivSYv2RhM8jIYgdrgvr6C6kLNHE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-YKJ-2KTbMPWD8nyJk0-q_g-1; Wed, 22 Feb 2023 11:24:58 -0500
X-MC-Unique: YKJ-2KTbMPWD8nyJk0-q_g-1
Received: by mail-qk1-f200.google.com with SMTP id z23-20020a05620a101700b0073b328e7d17so3933116qkj.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLhtXBcdn1xpAegjTPnSxn7PzROariqCocZMwH9dRzI=;
        b=M4tyaRLIIPMcGk6AkV3HdegGafykt0dhqDtf5+PadmByYoykC6OKPwCZeoUU+NeL93
         AZdU6GrL/1UDhUwbaMs3iTZRtxlidncHW28R1NCweng3JDlxSpMUAjmw4wxp7zah4VRz
         yDxp2APK2htIX9gnLARPeg4J40Gc0QEXT2KjPiDvbmfOwZF7q/Sjy9qwEJTxWtXYgMpD
         9Evc2Yp8QxYgXxGYci/bUgtMTi6CG6NO1s+e6jCgSI1vQB0DoL94trgip35b5OIjLdmy
         bW0JA6XV8R9k9g571Lvw0qAgwIUDV11ihLrZzQPybD/eEv5Rek85VD2avStnnogstOAV
         uaaw==
X-Gm-Message-State: AO0yUKU7+6uYFnOr1vSHCHGe/f4NgcXVbzwIcVPhJhoQFKCGqvGSOBHk
        xpsjLqkbNY12K4Nd/rVCYRlQnAyemgnWovw9A2GBqbYIDq7EDHu7xmneSdcm4wt19RZ/zem6/EO
        TkT8Pt2+x5HzO/J2zTys5spgS73f0lw==
X-Received: by 2002:ac8:59c1:0:b0:3ba:1ace:8bae with SMTP id f1-20020ac859c1000000b003ba1ace8baemr17912275qtf.0.1677083097090;
        Wed, 22 Feb 2023 08:24:57 -0800 (PST)
X-Google-Smtp-Source: AK7set/5A0AmUDYT7IJUzSZ8nTb4vYF9+tWExtnRCHblwtLs4Hz9K4xqgIR+UaLkb0m2JzTB3GkoaQ==
X-Received: by 2002:ac8:59c1:0:b0:3ba:1ace:8bae with SMTP id f1-20020ac859c1000000b003ba1ace8baemr17912228qtf.0.1677083096769;
        Wed, 22 Feb 2023 08:24:56 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 13-20020a37070d000000b007419eb86df0sm3405091qkh.127.2023.02.22.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:24:55 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:24:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm/khugepaged: refactor collapse_file control flow
Message-ID: <Y/ZB1tB2Dc/uvJ9S@x1n>
References: <20230217085439.2826375-1-stevensd@google.com>
 <20230217085439.2826375-2-stevensd@google.com>
 <Y/U9fBxVJdhxiZ1v@x1n>
 <CAD=HUj5DwoFHsC8TpN6PU3ThypVq=jhJST5vs0d17U9d7EX8+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=HUj5DwoFHsC8TpN6PU3ThypVq=jhJST5vs0d17U9d7EX8+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 01:08:19PM +0900, David Stevens wrote:
> > >  out:
> > >       VM_BUG_ON(!list_empty(&pagelist));
> > > -     if (hpage) {
> > > -             mem_cgroup_uncharge(page_folio(hpage));
> > > -             put_page(hpage);
> > > -     }
> >
> > Moving this chunk seems wrong, as it can leak the huge page if
> > alloc_charge_hpage() failed on mem charging, iiuc.
> >
> > And I found that keeping it seems wrong either, because if mem charge
> > failed we'll uncharge even without charging it before.  But that's nothing
> > about this patch alone.
> >
> > Posted a patch for this:
> >
> > https://lore.kernel.org/all/20230221214344.609226-1-peterx@redhat.com/

[1]

> >
> > I _think_ this patch will make sense after rebasing to that fix if that's
> > correct, but please review it and double check.
> >
> 
> Ah, good catch. I didn't notice that alloc_charge_hpage could allocate
> *hpage even on failure. The failure path should work properly with
> your fix.

Thanks for confirming.

If we can merge above [1] before this patch, then I think this patch is
correct.  Only if so:

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

