Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD716A21E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBXS7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjBXS7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:59:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4C1B2D7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:59:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ck15so1383960edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMnVSOBNjx/bLYJdwnuGcoM5T1w2ljOwTVkJXGhR6M0=;
        b=eWQ6+GCDYq4xlis6g6EYwAVl52jMYKuUTk3zY+p+53ydE3hQ74JQM9gRwxmg6yQ1PG
         I4sYQi4RcndqPaPfC84dr7nGp75cTWH9kg5YGrvgeMaWdI6Oa7D05Bhi5rkvPZd0BgOB
         VQFz/Hi4WG//M2RSv0IAcgVNHZTS2XAMHEaCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMnVSOBNjx/bLYJdwnuGcoM5T1w2ljOwTVkJXGhR6M0=;
        b=eo6uLfQWs35kHS22MgC+8l/MUHwLg+cSxQcNNZmy69455IebRcPQ1G+jiE1BGjLBot
         ESBvODKQrzxbTWkgzBP7Xi6KIXRLUmuAWcndttWru9UtGfjRedUa4kRDx1kX/GsO/jpd
         BTTB7Xj1ywLCNx1TJ1fqtrpOEUTk2opeBBfDA0y0w8Pi4+WMQs/Ctf5AeZ0UpQqqjA3a
         sNRG1WS4Oa2WXCQozaeZD+5891XBADkFqvEKmGByy4KH+S8OfssQEeHNHtskLKE2l/AI
         CVMXRvxgIXnreMO8bylLU3UqMCUZfgv6JmIng8NU/4f7H2nplP0q242BQIkK+CVP2NYM
         5srw==
X-Gm-Message-State: AO0yUKV3NeopS5/EBhe5QRZCKvuDXgO9mTH7vBlPBBTRpzNDtmRkW49/
        X1ZVjEJ3z4i9Ys0EfjRLxIXhvGIDZGt54nKmFbaMog==
X-Google-Smtp-Source: AK7set/9lBXA8CRzVbTavNS2gcMEtbujzoRQlOe48S1HBvjA9VymHqFVmb56UGtwJKh1QJTCdZ30bQ==
X-Received: by 2002:a17:906:71c2:b0:88d:2a41:2a4b with SMTP id i2-20020a17090671c200b0088d2a412a4bmr23258228ejk.60.1677265144211;
        Fri, 24 Feb 2023 10:59:04 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id lg17-20020a170906f89100b008b1797a53b4sm10398992ejb.215.2023.02.24.10.59.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 10:59:03 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id s26so1022420edw.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:59:02 -0800 (PST)
X-Received: by 2002:a17:907:988c:b0:877:747e:f076 with SMTP id
 ja12-20020a170907988c00b00877747ef076mr10995913ejc.0.1677265142065; Fri, 24
 Feb 2023 10:59:02 -0800 (PST)
MIME-Version: 1.0
References: <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2134430.1677240738@warthog.procyon.org.uk> <2213409.1677249075@warthog.procyon.org.uk>
 <CAHk-=whFKL4VuFBWvenG8fAgfvbf36PDgouUSx47rZDWr9BkJw@mail.gmail.com> <2385284.1677259167@warthog.procyon.org.uk>
In-Reply-To: <2385284.1677259167@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 10:58:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiAQZUZCEH1OxFb3Oa_mqz69tagdXHnKuYd_rwRHba5Cw@mail.gmail.com>
Message-ID: <CAHk-=wiAQZUZCEH1OxFb3Oa_mqz69tagdXHnKuYd_rwRHba5Cw@mail.gmail.com>
Subject: Re: [RFC][PATCH] cifs: Fix cifs_writepages_region()
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 9:19 AM David Howells <dhowells@redhat.com> wrote:
>
> The skip thing, in my code, is only used in WB_SYNC_NONE mode.  If we hit 5
> things in progress or rescheduling is required, we return to the caller on the
> basis that conflicting flushes appear to be happening in other threads.

Ahh. *That* is the difference, and I didn't realize.

I made all the skip-write cases the same, and I really meant for that
case to only trigger for WB_SYNC_NONE, but I stupidly didn't notice
that the whole folio_test_dirty() re-test case was done without that
WB_SYNC_NONE case that all the other cases had.

Mea culpa, mea maxima culpa. That was just me being stupid.

So that case isn't actually a "skip write" case at all, it's actually
a "no write needed at all" case.

Your original patch is the right fix, and I was just being silly for
having not realized.

I'll apply that minimal fix for now - I think the right thing to do is
your bigger patch, but that needs more thinking (or at least splitting
up).

Sorry for the confusion, and thanks for setting me straight,

                  Linus
