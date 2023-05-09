Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB58D6FCCF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjEIRoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEIRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:44:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3940C0
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:44:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3ef32014101so63624801cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683654243; x=1686246243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0fIZgngQ9KHUBi5LfmXg+eaALuyGPQn+Ww+ZIcPQ0U=;
        b=kxFqD539zFnEkgBZCYyu7NnPFgh0kPFxYhBgiNDcdQ1+OA/nVtDxlzETKFEbeVZqzp
         EwJLxSPF6INV07BIfVc6eR+nO4TtYvRj+ieIwKUVc3TXytgXqf6MHQVw/0tUP7D/m/kT
         7qLBu+YynZ5mDWd9WNgORyRNnY+SucsJ1ND/bsy2zWWCmX5/FFr+cQIK5MLaNIN9il1I
         ATICBudLSSbANJGlOLiL9+j9S50UBkCjWRxOceUrlsuYph/lRISpphJS9TTIP+730otz
         ZEJ9Bv2BGpmvaoeLyl+rCE0ZtqA5QLVyQlls0NTs/o6S3nME6ivIraebaBP6oyPI3NYJ
         +H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654243; x=1686246243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0fIZgngQ9KHUBi5LfmXg+eaALuyGPQn+Ww+ZIcPQ0U=;
        b=RJ3r0Fc1GKghQ3ca3N5ObRuAnx+QWbW3SyUKvk0u4tX9fyPdjjIPkqP2mKIxwiBcHa
         nsUJ1iJc2v9yW3ZM+y4Nc6GUKpzqfJjINd8f9jOUy9D1Fe0zHbap+WOL4T2l8xQ76UbF
         7bTYT+bB1ATG8riniqG3UXV9Bk4CKdv27DJrZ+rrxIn4N3mmFHlhtmO5NLnF3lPlcTuf
         6g+zevm/vyrj+FcpGz3ikJ22dGe5LyxJMdJxm8EZvkA0rrL0aTupYRuWF9YaYjRHdw/C
         7rToPDp4HQE45Sk0qDlcHqqkG9r2uF3fMdDNmVtToLHL2IipX+KQWZPLjj2LXQX00ZsZ
         o1Fw==
X-Gm-Message-State: AC+VfDzKZt5Adw3Rv19X4sc+nMbgpAuiMCklPxt3+YWClk8B0qQxCfiB
        j0oXEue+oNu6VO0jUYbBA/Fybg==
X-Google-Smtp-Source: ACHHUZ47Lbl6FfgJE40t18HSn8iYgyFQWNIQwLznrwRRe0FDVvz79xSAK23cUlDdep0hmbYXDi9uTw==
X-Received: by 2002:ac8:7f89:0:b0:3f3:9564:1135 with SMTP id z9-20020ac87f89000000b003f395641135mr6539548qtj.8.1683654242784;
        Tue, 09 May 2023 10:44:02 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id f5-20020ac840c5000000b003e0945575dasm373105qtm.1.2023.05.09.10.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 10:44:02 -0700 (PDT)
Date:   Tue, 9 May 2023 13:44:01 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, Minchan Kim <minchan@kernel.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-ID: <20230509174401.GA18828@cmpxchg.org>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
 <20230506030140.GC3281499@google.com>
 <20230508140658.GA3421@cmpxchg.org>
 <CAKEwX=MtunOe6A--SG3ud-gUFg3bXFJgG4csgwHeZFAEqjCgHg@mail.gmail.com>
 <20230509030030.GD11511@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030030.GD11511@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 12:00:30PM +0900, Sergey Senozhatsky wrote:
> On (23/05/08 09:00), Nhat Pham wrote:
> > > The deeper bug here is that zs_map_object() tries to add the page to
> > > the LRU list while the shrinker has it isolated for reclaim. This is
> > > way too sutble and error prone. Even if it worked now, it'll cause
> > > corruption issues down the line.
> > >
> > > For example, Nhat is adding a secondary entry point to reclaim.
> > > Reclaim expects that a page that's on the LRU is also on the fullness
> > > list, so this would lead to a double remove_zspage() and BUG_ON().
> > >
> > > This patch doesn't just fix the crash, it eliminates the deeper LRU
> > > isolation issue and makes the code more robust and simple.
> > 
> > I agree. IMO, less unnecessary concurrent interaction is always a
> > win for developers' and maintainers' cognitive load.
> 
> Thanks for all the explanations.
> 
> > As a side benefit - this also gets rid of the inelegant check
> > (mm == ZS_MM_WO). The fact that we had to include a
> > a multi-paragraph explanation for a 3-line piece of code
> > should have been a red flag.
> 
> Minchan had some strong opinion on that, so we need to hear from him
> before we decide how do we fix it.

I'd be happy if he could validate the fix. But this fixes a crash, so
the clock is ticking.

I will also say, his was a design preference. One we agreed to only
very reluctantly: https://lore.kernel.org/lkml/Y3f6habiVuV9LMcu@google.com/

Now we have a crash that is a direct result of it, and which cost us
(and apparently is still costing us) time and energy to resolve.

Unless somebody surfaces a real technical problem with the fix, I'd
say let's do it our way this time.
