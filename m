Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7D6A2209
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBXTGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBXTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:06:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BCB2310E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:06:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cq23so1313022edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOnW98lyJGpYbD3eJjqqzz7gc3Ub1QIGFkaXHUv4Ygw=;
        b=QgJzE1UXmKimaRQyvLPX5eOzT51cg/7f32m8GMjg3xQqoxdyxololhdOn94vv4mfJZ
         mNXn+/IMq2NgXpZq0dV9JUbm82Tv+OpUNyfJDu6dpCaBqQQlbZTu21GCYsC9+zVH0n42
         DBThtYurcSf7Bo98gVQ42RJLZrWoPKpK6t+u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOnW98lyJGpYbD3eJjqqzz7gc3Ub1QIGFkaXHUv4Ygw=;
        b=I19DQkMGUyUImBCLr1LoLVxZB4n4dkjV2I6uwmP7hIAQsnlncgAjp1bQ6PjXr9zhWI
         32DNffuxeEu3dHiNTWgzaIuEvX+X2nRnydH96T2PMTg6R5u7oLphkslcAxM6sbsxpDcP
         ASuNXHtNN9D5LIuSIlx/5jOQk/2vqA5Fy1faZO85B1roLL3dBTj2Zgx9JB6SanJchTtk
         MoU8Lc7Faqb1LRyu89EkhBWtcdaYd+/bRUl6vdhHzV55nI2CYikyw4LYs0k4TEX0tbEZ
         QPR2NYR4pAa8QC4k46PI7DmlKCCKVyr6625CuD7X8KCctNk9l9C9YT1KPMAxdCv3opYf
         wKvA==
X-Gm-Message-State: AO0yUKVYG6wPAa/ieZ3t+JJHBT4svI8mr/WMTe0J1cXCEJRqSEthdG46
        F8KM+a0CcGYbQ+d/2aMOYGPRm+JzLklMgySH6/1I4A==
X-Google-Smtp-Source: AK7set9YgPlzKbK+A6YgryTBT+wpExy5W9+LOwALbxc5QoPtYbFQ4gZoWAh3lhbssCnVSpQAYHdd7A==
X-Received: by 2002:a17:906:7e06:b0:7c4:fa17:7203 with SMTP id e6-20020a1709067e0600b007c4fa177203mr25490830ejr.63.1677265560775;
        Fri, 24 Feb 2023 11:06:00 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id w25-20020a50d799000000b004aef4f32edesm23021edi.88.2023.02.24.11.05.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 11:05:59 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id da10so1268324edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:05:59 -0800 (PST)
X-Received: by 2002:a50:baa7:0:b0:4ae:e5f1:7c50 with SMTP id
 x36-20020a50baa7000000b004aee5f17c50mr7747187ede.5.1677265559017; Fri, 24 Feb
 2023 11:05:59 -0800 (PST)
MIME-Version: 1.0
References: <2009825.1677229488@warthog.procyon.org.uk> <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2134430.1677240738@warthog.procyon.org.uk> <2213409.1677249075@warthog.procyon.org.uk>
 <CAHk-=whFKL4VuFBWvenG8fAgfvbf36PDgouUSx47rZDWr9BkJw@mail.gmail.com>
 <2385284.1677259167@warthog.procyon.org.uk> <CAHk-=wiAQZUZCEH1OxFb3Oa_mqz69tagdXHnKuYd_rwRHba5Cw@mail.gmail.com>
In-Reply-To: <CAHk-=wiAQZUZCEH1OxFb3Oa_mqz69tagdXHnKuYd_rwRHba5Cw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 11:05:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizKeB-EAsFgvUUfL2OaO3+W2OHr2L8Y4cGBBheYeJdtw@mail.gmail.com>
Message-ID: <CAHk-=wizKeB-EAsFgvUUfL2OaO3+W2OHr2L8Y4cGBBheYeJdtw@mail.gmail.com>
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

On Fri, Feb 24, 2023 at 10:58 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll apply that minimal fix for now - I think the right thing to do is
> your bigger patch, but that needs more thinking (or at least splitting
> up).

Minimal fix applied - that way I can drop this for now, and we can
discuss the whole "maybe we can just use write_cache_pages()" instead.

Because that _would_ be lovely, even if it's possible that the generic
helper might need some extra love to work better for cifs/afs.

             Linus
