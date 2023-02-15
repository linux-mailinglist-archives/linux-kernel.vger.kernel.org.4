Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB80697F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBOPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBOPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:21:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2544536455
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676474468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfv7Rycn+rNU8ZwT5IAQ8tPoQPJy80nVLPsdVlq6m/k=;
        b=bipCxhie1lLep0tCRJrDAetg96e+AKJFYBcW/vEqmmkwszkOlSlCjoj/k/8dEYgQxPhwTN
        I7yiXzhRGWZylnQ4NWCErJzSz0YdDq9VTmmPcEtqqs+s6WkIrORhGjd+pkv4/h+l8eFfpi
        UtJlmvLUGIgx6Gp1hv+KwOjskKVL0o4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-GH2DK3bSP1-pXj_9oGXBGA-1; Wed, 15 Feb 2023 10:21:04 -0500
X-MC-Unique: GH2DK3bSP1-pXj_9oGXBGA-1
Received: by mail-qt1-f198.google.com with SMTP id cr22-20020a05622a429600b003b694a9f291so11272206qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfv7Rycn+rNU8ZwT5IAQ8tPoQPJy80nVLPsdVlq6m/k=;
        b=4QD6YkL2iQby2GmCGVya+u1qQt+AjAaJMk9VBof2N68PMZxStdm9fzU4X/FSYfsN/H
         hwuCiJSsrkrrCAvRJ7PAjEGrzz8O+2V0YhIR4NKyGfKzIJSgkSRJj+r/OXYSwFsbuc1M
         +ANltzglxmBFxNJM437MPD+Vb9bIGgycNE4LzAvj7bOp5A3vVgaGsyDW07QjPjBQtJY/
         lCNbcglF9lMD0SZigPeH5dWDWdGeDJB6RtZiIcoRriosA+cEKkATOYaHRKgBvf1eKJ+B
         u2XRTEJLp5YkDnOfQr7bBuRRXVOqr47ivvWsvNj0Ii1HfLygk/HYVlOmFqTn0LunCc7V
         zC9Q==
X-Gm-Message-State: AO0yUKXq+hL4QPh/1v0RO+CmmWgpR50HcMpp15lDFZT5nT1Ik+BHpEAw
        8uHEaQPuk4N1rnWO9868nLol/YjR1iPri6GFg9o1C0uyF/8txyMwVWG3HgXLm3khwBRV8mYVBtt
        1iAIYhR1ovyLamvQxsiGRLlHx
X-Received: by 2002:ac8:5f4e:0:b0:3b8:695b:aad1 with SMTP id y14-20020ac85f4e000000b003b8695baad1mr4805416qta.1.1676474464234;
        Wed, 15 Feb 2023 07:21:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/bUBwJRT9nplisX7cCmXea98zUuaNhVa0ZTJCA74agqwEPC+rEotKS3qcPHLZRGk14AYlnHQ==
X-Received: by 2002:ac8:5f4e:0:b0:3b8:695b:aad1 with SMTP id y14-20020ac85f4e000000b003b8695baad1mr4805379qta.1.1676474463947;
        Wed, 15 Feb 2023 07:21:03 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b003b9a4a497a1sm13111453qtp.86.2023.02.15.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:21:03 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:21:02 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1
 (regression)
Message-ID: <Y+z4XlhDzokAMTI1@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n>
 <CADyTPEzsvdRC15+Z5T3oryofwRYqHmHzwqRmJKJoHB3d7Tdayw@mail.gmail.com>
 <91b38494-f296-d01d-3b98-6bc51406cad0@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91b38494-f296-d01d-3b98-6bc51406cad0@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:49:56PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 31.01.23 02:46, Nick Bowler wrote:
> > On 2023-01-29, Peter Xu <peterx@redhat.com> wrote:
> >> On Sat, Jan 28, 2023 at 09:17:31PM -0500, Nick Bowler wrote:
> >>> Starting with Linux 6.1.y, my sparc64 (Sun Ultra 60) system is very
> >>> unstable, with userspace processes randomly crashing with all kinds of
> >>> different weird errors.  The same problem occurs on 6.2-rc5.  Linux
> >>> 6.0.y is OK.
> > [...]
> >> Could you try below patch to see whether it fixes your problem?  It should
> >> cover the last piece of possible issue with dirty bit on sparc after that
> >> patchset.  It's based on latest master branch (commit ab072681eabe1ce0).
> > 
> > Haven't seen any failures yet, so it seems this patch on top of 6.2-rc6
> > makes things much better.
> > 
> > I'll keep running this for a while to see if any other problems come up.
> 
> Nick, I assume no other problems showed up?
> 
> In that case Peter could send the patch in for merging. Or did you do
> that already?

Thanks for raising this again.  Nop, I'm just waiting for a final ack from
Nick to make sure that nothing went wrong after the longer run.

-- 
Peter Xu

