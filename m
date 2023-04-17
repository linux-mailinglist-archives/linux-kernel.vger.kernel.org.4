Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32B6E3D02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 02:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDQApd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 20:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDQApb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 20:45:31 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E40211C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 17:45:30 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k39so2337974ybj.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681692329; x=1684284329;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRSWS4CahJKmzHjoYHWbTfAxUOlWiKT6IkxMS+a7Rf8=;
        b=sbBQCkJR1blA3hV96FpkODzI2tgHmoZZfsnImeAQnIAhG79OWScwEEOSM7gZ0tW1zP
         EiFVqszySsbrwI59L7OFeP55CYduW/jOtunH0hxePs7wY85uyAz1iH6Psg+xzgzCTdJP
         0iKpt8nOteMGmwrsWscYZCyPD7u3VlJlygy12rXWVMHcJrTq2W+1vrdcs10Wt6OwCjdE
         M+EdvAlQBCbLcihbX/qL6yLRDRSeNVnfgNOXMliL4e6yduDQYHOIvj2fqlHsdTnTpWXF
         WgNHZPbRajqpfbbBq+Hfue3QT3sz1wqUAeDEzHKSe+xpwUMW+mWmOvKYuOx14RDBvnnl
         wwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681692329; x=1684284329;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRSWS4CahJKmzHjoYHWbTfAxUOlWiKT6IkxMS+a7Rf8=;
        b=ljxiNmOOQDqfHNYjpUOpmIGVorOv/bBb3wg3wuQkUHsr33Ncds1MsJAQAA+uJkxaGK
         84humSnrSHqLQp5U0Jesgrel42V3Ix6VTkNJveaNwaPMhoB814CmdxJLIS0gk/4srVKC
         hOVr2z9fzNA0Hnax6H2o1bahmNgUBALzLJM3LJgUvJZxUa0QiAYFYJfHN5d5Pp8cDa1A
         OHeJsPNAqJuF6HGL4U5mSVTJsvoW9fw8vzLbNp9njDxH/bx5FxpZ+PB8mpVI8e2ij/Hi
         igN3h0a5Q9256k9M4Xj2FIGK4SlBq9uXVY8iLw8omU+avJ094KS9PUkXviaIN+PXSr+3
         pMLQ==
X-Gm-Message-State: AAQBX9f6bkcF6VN+U8bO+vH5SC0oXxLj3M9AcIjVNLhpGgSdPCqlLQGT
        meB87/Nb6DFJGXIke4CXxSVStw==
X-Google-Smtp-Source: AKy350ZNiO/Qqw4kBjaaCtnr795xEsGikp7UxElEWMXA54ObhUZJ121qoa5BUfup+ExOJL25sSjdBQ==
X-Received: by 2002:a05:6902:114d:b0:b6a:9364:1dc8 with SMTP id p13-20020a056902114d00b00b6a93641dc8mr15325573ybu.44.1681692329122;
        Sun, 16 Apr 2023 17:45:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id be18-20020a05690c009200b0054fcbf35b94sm2601627ywb.87.2023.04.16.17.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 17:45:28 -0700 (PDT)
Date:   Sun, 16 Apr 2023 17:45:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Zach O'Keefe <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        himadrispandya@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, linux-mm@kvack.org,
        skhan@linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: khugepaged: Fix kernel BUG in
 hpage_collapse_scan_file
In-Reply-To: <20230416113335.caeafda1328fdd4bfe2406e8@linux-foundation.org>
Message-ID: <f0fa9ad0-5077-e47a-8234-684f5cddcae0@google.com>
References: <20230330155305.423051-1-ivan.orlov0322@gmail.com> <20230331013301.ecgkjymaf3ws6rfb@google.com> <CAHbLzkoJ2zvKZpqd6NqikpCc8rGR02C87f0fPq8qwb1BF3K+9Q@mail.gmail.com> <CAAa6QmTLXSvygQQNk=8C4pB3D2Twy1guzo=+-aXhCqNAE3Q3MA@mail.gmail.com>
 <20230416113335.caeafda1328fdd4bfe2406e8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2023, Andrew Morton wrote:

> 
> Circling back to this fix...
> 
> The BUG() is obviously real.

It's worth remembering that syzbot's reproducer involves artificially
injecting page allocation failures.  So although the bug may be "real",
it is rather in the theoretical category, way down on my own list to
look at, and I'd say not at all urgent to fix.

Hugh

> We're unsure that Ivan's fix is the best
> one.  We haven't identified a Fixes:, and as this report is against the 6.2
> kernel, a cc:stable will be needed.
> 
> According to the sysbot bisection
> (https://syzkaller.appspot.com/bug?id=7d6bb3760e026ece7524500fe44fb024a0e959fc),
> this is present in linux-5.19, so it might predate Zach's
> 58ac9a8993a13ebc changes.  But that bisection claim might be
> misleading.
> 
> And Zach is offline for a few months.  So can people please take a look
> and see if we can get this wrapped up?
> 
> Matthew, the assertion failure is in the
> 
> 	VM_BUG_ON(index != xas.xa_index);
> 
> which was added in 77da9389b9d5f, so perhaps you could take a look?
> 
> Thanks.
