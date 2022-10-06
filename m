Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF75F6F41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiJFUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJFUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:37:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50104BEFB9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:37:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 2so2849200pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vUTyG6Np/u72Dz/dgBQ4qw28uB5CVEnf9ne0MjdRNXQ=;
        b=l4pzgbjCLfunsDmBM/oJsQgA/6oc2FTqn96xT9kDUHrLVbLcZSnT2054BUsF9BaE4N
         Vp2VyRDx9wEPFP/en9z5piVn4kS17i1eno1WqQYJzbR+iRHgHHWY82eSHog5/x3sSfDw
         wv2xe97OHgpkWIoe8EIm7Z+bM7mahJL49i8ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vUTyG6Np/u72Dz/dgBQ4qw28uB5CVEnf9ne0MjdRNXQ=;
        b=N8/O4w7nV8E1ZRl/J9l8TU6NQuu9NuvB999LCGavRhNgpTu7Uc1ANmoe4UA6kko6TB
         2vjJdC4vC6oJ0GGymwik3oLQ2BI81pHd7pTXoYkDYF9qSYuLzNRDW3Bxed8WFmCslYGw
         oftLL0Zy4/t46v3nzlntfAyACmHyAQ0k4KOz253xwTKnENsgYFHe83xUUiWslyGUmib+
         fTpw2vh3qh1XEmkIeerM7enOHaxbOoanj5u0HgfLUgRj7fD4M1SkOd2RbBnC/WQFb5p3
         KXxigxBLEtvuV7LlVGxx+2GGrTSW1ep2gdNu6gdCkmBmJc/FWH+3lQ+UhPDZRlK6NLMp
         x6Tw==
X-Gm-Message-State: ACrzQf11sIPLKtujesUCggLplem55e0Z3yqKiz/YRHkwT+LAXDdhoR+4
        QvIUPznsB+IPLFA3ELqx2v9TMg==
X-Google-Smtp-Source: AMsMyM6tUrflXlcmIduh6tv4hATbfSVnVFeSJd3pPCVGqgQFpNV5ZCLn3XXM8SrarBxmq5FPsdAdow==
X-Received: by 2002:a05:6a00:230d:b0:53d:c198:6ad7 with SMTP id h13-20020a056a00230d00b0053dc1986ad7mr1277124pfh.67.1665088637855;
        Thu, 06 Oct 2022 13:37:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f33-20020a17090a702400b0020647f279fbsm3284227pjk.29.2022.10.06.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:37:17 -0700 (PDT)
Date:   Thu, 6 Oct 2022 13:37:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display:
 fix array-bounds error in dc_stream_remove_writeback()")
Message-ID: <202210061328.37FCC30@keescook>
References: <Yz6W+j+l0cJbr5dX@debian>
 <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 12:39:40PM -0700, Linus Torvalds wrote:
> What confuses me is that error message ("array subscript [0, 0] is
> outside array bounds of 'struct dc_writeback_info[1]') which seems to
> be aware that the value is actually 0.

I've seen bugs in the tracker where the reporting is broken but the
range checker is working "correctly", which seems to be the case here.

> If somebody cannot come up with a fix, I suspect the solution is "gcc
> array bounds analysis is terminally buggy" and we just need to disable
> it for gcc-11 too.

It does continue to find bugs, so I'd rather keep it on. GCC has fixed
all the issues we've run into so far (though not all have been back
ported to GCC 12 yet, so yes, let's keep -Warray-bounds disabled there).

Specifically, I've been tracking:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679	Fixed 13+
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578	Fixed 12+, 11.3

And it looks like Sudip's proposed fix for this particular code is
additionally fixing unsigned vs signed as well. I think -Warray-bounds
did its job (though, with quite a confusing index range in the report).

-Kees

-- 
Kees Cook
