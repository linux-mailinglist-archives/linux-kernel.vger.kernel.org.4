Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A465658CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiL2MsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiL2Mru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:47:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BF713D5E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 04:47:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m6so16979221lfj.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 04:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HXheRu1dQbpoYyygoUpbH2Rv+D8A+p3lB+rWKexBOo=;
        b=PxKTeQb+UavEDvyMVmHJf2HQSpqc2uu+sfVBpVpoZHd4sfN/POkyPykRSCVD1jkR6o
         fRdMtGHcXyH3D0/Uaa4WtTGArly1jYD3+hYd67Y8hR50EZ0NQ1J2ZgvWhDzupq0KWYTG
         fYAjTBFdrbA0wqQrzmTx6W3JhgkxY6y7R2rQHHYKjXPgZf6vwP0JV+yg6gVFpbTXXXjc
         ZcRIhKWO9oSR2KGhTt4eEp5R6glBZXydQrCWcOYdxWywLHAEqXUzHiqpbXzJSQU1JiAG
         ykmclOSpxQnMfovCswvcuMoYR8AZF3NjHPhsmUbyvKQxbtvG6ouupb4VFyNzMMlOmrv+
         oEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HXheRu1dQbpoYyygoUpbH2Rv+D8A+p3lB+rWKexBOo=;
        b=WZDhDlG/+fWJ86EAFwsOTQ/SEi95ROzk53TvqOnED9Ez9Hm0iJuSj2KpcToPOkkJSz
         vXvk8IpX7NEppozuxZIowtJP0fG3xm/dQTs7nGrb4W4+oel8J1YoNxpHeLij6Ihzo0CE
         ZYRakmZRqTldbI9cPgnHBkwoqegYe4qFY4kBTzDS1KsuXbZoukW6YhENxlQlZnn4UH2e
         y45y4Mw6kplyUd3zA5K8GcK6uxHsUG7M0Wg33/hHmUt2dL4j9DqmcO+Z9cwl/UvEQY3M
         tkQ6ygknAPkvhDwT/hmdfvdnAvpvCcS+zwbh8KBu9gnvRf5xcnqJH8gVq4LiwUHG+Qec
         RsuQ==
X-Gm-Message-State: AFqh2kpYS5auW9ONLY1bk5nJXnBsPGdPBpxIPWlMTeYfVdDXHQ3xMTpb
        80273HuJePcuJE/ZKnuA4kk=
X-Google-Smtp-Source: AMrXdXuIHJFWKzgwr5b7gyRTuZ7rfNwzf68SClV98VMvfHdknq9/nDZk0tV629b5vNuGr518o4+Q9A==
X-Received: by 2002:ac2:5e2f:0:b0:4b5:5a15:8050 with SMTP id o15-20020ac25e2f000000b004b55a158050mr7808148lfg.32.1672318066963;
        Thu, 29 Dec 2022 04:47:46 -0800 (PST)
Received: from pc636 (host-90-233-208-74.mobileonline.telia.com. [90.233.208.74])
        by smtp.gmail.com with ESMTPSA id q13-20020a056512210d00b004b5732080d1sm3040948lfr.150.2022.12.29.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 04:47:46 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 29 Dec 2022 13:47:43 +0100
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/3] mm: vmalloc: Switch to find_unlink_vmap_area() in
 vm_unmap_ram()
Message-ID: <Y62Mb8NtZQkTmlfV@pc636>
References: <20221222190022.134380-1-urezki@gmail.com>
 <20221222190022.134380-2-urezki@gmail.com>
 <Y6VlA8Mbbv7Ug6tW@infradead.org>
 <Y6XaTM+xSlGNjo0e@pc636>
 <20221228154707.432e8900855122712f98037c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228154707.432e8900855122712f98037c@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:47:07PM -0800, Andrew Morton wrote:
> On Fri, 23 Dec 2022 17:41:48 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > > Don't we also need to remove the manual unlink that was done
> > > here previously?   Actually it seems like that manual unlink is missing
> > > after patch 1, creating a bisection hazard.  So either add it there,
> > > or just fold this patch into the previous one.
> > >
> > Right. In terms of bisection it is not so good. I think folding is the
> > best.
> > 
> > Andrew, could you please fold this patch into the:
> 
> which patch ;)
> 
Currently the next-20221226 contains three patches:

<snip>
[1]
commit c83b70c3cc1ecf99897ca0ea6e44aa2125a61ccb
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Dec 21 18:44:54 2022 +0100

    mm: vmalloc: replace BUG_ON() by WARN_ON_ONCE()

[2]
commit 8a85ea97b35924ee39d51e00ecb3f6d07f748a36
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Dec 21 18:44:53 2022 +0100

    mm: vmalloc: switch to find_unlink_vmap_area() in vm_unmap_ram()

[3]
commit a7c84c673c71cdfad20fe25e5d2051ed229859f7
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Dec 21 18:44:52 2022 +0100

    mm: vmalloc: avoid calling __find_vmap_area() twise in __vunmap()
<snip>

It would be good if you could fold [2] into [3] making it as one
patch. The problem is that, if we leave it as it is, the bisection
mechanism would consider [3] as a buggy patch, because it is not
fully accomplished and depends on [2].

Is that OK for you, i mean to squash on your own? Or i just should
resend one more time?

Thank you in advance!

--
Uladzislau Rezki
