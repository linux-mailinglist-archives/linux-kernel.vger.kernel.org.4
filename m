Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB596FCD9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjEISUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjEISUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:20:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C3F5B81
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:20:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6436e075166so4692082b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683656406; x=1686248406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEDIRdHz9e6l+8TjKkRbmCBTlSMnPPPrLZQHvlvOjxs=;
        b=ric5Qz5yEohLt2qP2BnT/8yWLGEQiVKRvYRPpD+MURmsMyDTGJCisgcoDmgNtmIUrk
         h2BPa2jn5e6/jzM9ESCLNbBKeOvbip1jY0EYP5BftScYG6QrGjdkRnqEtVl2rENJfFA5
         8zWTqT5v9O4GxMiutDM+ROa1RXQiainLXOhFPvn9zIXvGdoiEt1AKIC2bYvjkulbKyGD
         sRRTvQqigIEgU7CK9f3PjdTB2ywFUunPQEn59Y1jKs8nUNQhFl24bcdIm0gMbscCq4RY
         5ACZ1agQsW7/TuOxMrIRItCjal7QuLeLv6AtAGAnRfvweKqtN0CgRdV3J0cX3ep3gBWl
         3fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683656406; x=1686248406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEDIRdHz9e6l+8TjKkRbmCBTlSMnPPPrLZQHvlvOjxs=;
        b=NsEJEMfmEhmr3xaZIh2HzJdzW1L3x/EIWJ/paeoKwW2mX7SvZ2mqirSkS0b/N7buu9
         Y6gHQkGrMQy88PYSNh6XXDNIAEAlvuSrkvcDlIPDxRs9ImJvrPrCjI6wivpGM0n2AC2O
         2wOKp1g5fDZVBGYk5I0ET4uZgwXByNmGged/X8K0VRPpElk1Wd9sbtq0YMRU2Q/bOA4g
         KVpf/ugBRe27NCIefwusRIHB84gYWgsJMHLZJ1cz0asqmkNwtdGpM7VSsBgzeY/GaMYU
         D5jrG2T03bhsUunYlX897pWcd7e79WxmNcqJOyK44tB0nvfHlj5gUxEjrUvlOsNUtSBN
         zoag==
X-Gm-Message-State: AC+VfDwBW+800Z4uE2v1u2qM2SwDL2ElIctG0796b2cltrV5edTu/sat
        HIUzWl9oLt+sJKQOKNM3/ds=
X-Google-Smtp-Source: ACHHUZ65f0Wg+ufT5KKdEi3378XwhvRduo8TpUGC52oRId0a9c73zP+cO09zEQXCZuTlfug93Q/PQA==
X-Received: by 2002:a05:6a20:9192:b0:f4:ac2d:8ea0 with SMTP id v18-20020a056a20919200b000f4ac2d8ea0mr16871956pzd.32.1683656405741;
        Tue, 09 May 2023 11:20:05 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:edee:934e:dd3a:5a4e])
        by smtp.gmail.com with ESMTPSA id 20-20020aa79214000000b00640dbbd7830sm2161403pfo.18.2023.05.09.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:20:04 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 May 2023 11:20:02 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-ID: <ZFqO0i4mWL508P0S@google.com>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
 <20230506030140.GC3281499@google.com>
 <20230508140658.GA3421@cmpxchg.org>
 <CAKEwX=MtunOe6A--SG3ud-gUFg3bXFJgG4csgwHeZFAEqjCgHg@mail.gmail.com>
 <20230509030030.GD11511@google.com>
 <20230509174401.GA18828@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509174401.GA18828@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

On Tue, May 09, 2023 at 01:44:01PM -0400, Johannes Weiner wrote:
> On Tue, May 09, 2023 at 12:00:30PM +0900, Sergey Senozhatsky wrote:
> > On (23/05/08 09:00), Nhat Pham wrote:
> > > > The deeper bug here is that zs_map_object() tries to add the page to
> > > > the LRU list while the shrinker has it isolated for reclaim. This is
> > > > way too sutble and error prone. Even if it worked now, it'll cause
> > > > corruption issues down the line.
> > > >
> > > > For example, Nhat is adding a secondary entry point to reclaim.
> > > > Reclaim expects that a page that's on the LRU is also on the fullness
> > > > list, so this would lead to a double remove_zspage() and BUG_ON().
> > > >
> > > > This patch doesn't just fix the crash, it eliminates the deeper LRU
> > > > isolation issue and makes the code more robust and simple.
> > > 
> > > I agree. IMO, less unnecessary concurrent interaction is always a
> > > win for developers' and maintainers' cognitive load.
> > 
> > Thanks for all the explanations.
> > 
> > > As a side benefit - this also gets rid of the inelegant check
> > > (mm == ZS_MM_WO). The fact that we had to include a
> > > a multi-paragraph explanation for a 3-line piece of code
> > > should have been a red flag.
> > 
> > Minchan had some strong opinion on that, so we need to hear from him
> > before we decide how do we fix it.
> 
> I'd be happy if he could validate the fix. But this fixes a crash, so
> the clock is ticking.
> 
> I will also say, his was a design preference. One we agreed to only
> very reluctantly: https://lore.kernel.org/lkml/Y3f6habiVuV9LMcu@google.com/
> 
> Now we have a crash that is a direct result of it, and which cost us
> (and apparently is still costing us) time and energy to resolve.
> 
> Unless somebody surfaces a real technical problem with the fix, I'd
> say let's do it our way this time.
> 

Sorry for being too late to review. The reason I insisted on it was
I overlookeded the bug and thought it was trivial change but better
semantic since zsmalloc provides separate API between allocation and
access unlike other allocators. Now, Nhat and Johannes provided it's
more error prone, I am totally fine with this fix and will live it
until the LRU writeback will move out of allocator.

Sorry for wasting your time to hunt this bug down and thank you for fix!

Acked-by: Minchan Kim <minchan@kernel.org>
