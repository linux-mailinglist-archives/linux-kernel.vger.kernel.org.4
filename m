Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1230E6FCE7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjEITYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEITYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:24:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D819D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:24:03 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f3a287ecceso3307131cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683660242; x=1686252242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+bt29R0emODDcrX+m6X0axLc75RE5wWtz5YBIQloRJE=;
        b=legh+RLHVRlEJGk4YX5eD6Wfyy+I8dXIqpy7+jcKqddZz4Y7QzfoGiAWbOP+xXSBkF
         IkEkEAW4HEOg9wwbwuMXwjHROSmfxzenr9+ex6yA97e84jXR2R9jGzVJ6UjfQ6Qoeo5G
         0JJ5O0bEYjHYQw08njP5ge8zujYLKVlEnxtI9Me7y09m4L21np7hmyqXGVSnOMdQg7+g
         az0WE+LGCPGCa3DSVT/sSVUM+aAM+tX0P9M6LCf+2tdQEPHdNozECaLnBckQ48t9NjX5
         GarumBLerCa1YelkJbEhQqRKTIRS3Q2gQgPe0A52X1AynE6AGZPbquKIOx1Q3c7/8wRh
         VDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660242; x=1686252242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bt29R0emODDcrX+m6X0axLc75RE5wWtz5YBIQloRJE=;
        b=Kgd1u11LpMeG7asJV/ugyupHjGzL/xYiJ49NB58b0uvi3mIFPXwE2ULwfsmG7sBShB
         NMv5UTKBJJH8kFFpKKJLBli10yFLdzOIMDjhbmmH9sW7DGdcyVp+nH658d01KJZtK75V
         YZYWTuuxiCLiu/KBLWn/DwUVQTiZbqpT/6hsdZ5wQ+CbGoKWJ8fRsPk8dZoPhSNFOsP5
         3XMW/15TOV/hCffevYh3CrtgCo6zkdWoU7w7cL5CNUl6zUwuUdgkHdOlRacDHOyMConj
         ZvGLieWbmfKnhNY8R08MefWGSrSdw5HSce5Gax9isNhcGfhEqiwYtcs7ZRNcJh7WCjfD
         ovKw==
X-Gm-Message-State: AC+VfDzANvdi9QMZ9UTcsS+dJ2+gAQ5ME7SNKFoSGO1f4+iGGzAg/FRO
        lKwIKlQ7Y3ht7fF31h2621xRCQ==
X-Google-Smtp-Source: ACHHUZ6Qh8xl9aZWQDgNJesbKNtoZJwvFElUj56yG3HNcuLM35HG7mif5nUmYciKnsSy/ZdQUYzypA==
X-Received: by 2002:ac8:4e8b:0:b0:3f3:8cf1:629c with SMTP id 11-20020ac84e8b000000b003f38cf1629cmr13989131qtp.46.1683660242726;
        Tue, 09 May 2023 12:24:02 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id p22-20020a05620a113600b0074db94ed42fsm3443283qkk.116.2023.05.09.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:24:02 -0700 (PDT)
Date:   Tue, 9 May 2023 15:24:01 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-ID: <20230509192401.GC18828@cmpxchg.org>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
 <20230506030140.GC3281499@google.com>
 <20230508140658.GA3421@cmpxchg.org>
 <CAKEwX=MtunOe6A--SG3ud-gUFg3bXFJgG4csgwHeZFAEqjCgHg@mail.gmail.com>
 <20230509030030.GD11511@google.com>
 <20230509174401.GA18828@cmpxchg.org>
 <ZFqO0i4mWL508P0S@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFqO0i4mWL508P0S@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 11:20:02AM -0700, Minchan Kim wrote:
> Hi Folks,
> 
> On Tue, May 09, 2023 at 01:44:01PM -0400, Johannes Weiner wrote:
> > On Tue, May 09, 2023 at 12:00:30PM +0900, Sergey Senozhatsky wrote:
> > > On (23/05/08 09:00), Nhat Pham wrote:
> > > > > The deeper bug here is that zs_map_object() tries to add the page to
> > > > > the LRU list while the shrinker has it isolated for reclaim. This is
> > > > > way too sutble and error prone. Even if it worked now, it'll cause
> > > > > corruption issues down the line.
> > > > >
> > > > > For example, Nhat is adding a secondary entry point to reclaim.
> > > > > Reclaim expects that a page that's on the LRU is also on the fullness
> > > > > list, so this would lead to a double remove_zspage() and BUG_ON().
> > > > >
> > > > > This patch doesn't just fix the crash, it eliminates the deeper LRU
> > > > > isolation issue and makes the code more robust and simple.
> > > > 
> > > > I agree. IMO, less unnecessary concurrent interaction is always a
> > > > win for developers' and maintainers' cognitive load.
> > > 
> > > Thanks for all the explanations.
> > > 
> > > > As a side benefit - this also gets rid of the inelegant check
> > > > (mm == ZS_MM_WO). The fact that we had to include a
> > > > a multi-paragraph explanation for a 3-line piece of code
> > > > should have been a red flag.
> > > 
> > > Minchan had some strong opinion on that, so we need to hear from him
> > > before we decide how do we fix it.
> > 
> > I'd be happy if he could validate the fix. But this fixes a crash, so
> > the clock is ticking.
> > 
> > I will also say, his was a design preference. One we agreed to only
> > very reluctantly: https://lore.kernel.org/lkml/Y3f6habiVuV9LMcu@google.com/
> > 
> > Now we have a crash that is a direct result of it, and which cost us
> > (and apparently is still costing us) time and energy to resolve.
> > 
> > Unless somebody surfaces a real technical problem with the fix, I'd
> > say let's do it our way this time.
> > 
> 
> Sorry for being too late to review. The reason I insisted on it was
> I overlookeded the bug and thought it was trivial change but better
> semantic since zsmalloc provides separate API between allocation and
> access unlike other allocators. Now, Nhat and Johannes provided it's
> more error prone, I am totally fine with this fix and will live it
> until the LRU writeback will move out of allocator.
> 
> Sorry for wasting your time to hunt this bug down and thank you for fix!
> 
> Acked-by: Minchan Kim <minchan@kernel.org>

Thanks Minchan!

Domenico is working on the LRU refactor right now, and should have
patches for review soon. This will indeed get rid of all the zsmalloc
warts and make our lives much easier going forward!
