Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF503691790
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBJEYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBJEYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:24:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F7658D6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:24:07 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r18so2929078pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 20:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROzvlU3xKIlsDrIvQBCFILPBUqpYkd1d+ibfENwn1RM=;
        b=jAsN1BhIAS2GZVQlEo4rba9kRWM6lUnYMsR0FGTj+nJufqqKQc5oEGXbiuTRZSbZ4p
         PmsoS57Fjw1PXy7jJvgdxEr3qzFm+gsioE6aj0PWqh40DTVkiMMiuOKR/Z0mPsJCeLop
         qgZ8PbKIe/xISKDP3YIf594PH18WaLsuEf7pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROzvlU3xKIlsDrIvQBCFILPBUqpYkd1d+ibfENwn1RM=;
        b=iUDvGsYxXbbUg21E7h/NUWvRv81IY5r3Vhew9o2Vsetg/OIgNZKFmw8vMgm5Ox/lNY
         c1r1FeMHOmhKAANr87wf3gBH6VPPTEe3la+YH9pWzmH9Xj9+ZJW57YzZNHbdxgiZKDi2
         j7c38TFMMBrI7RAJX5Y/N7OYeHEpJ5rQG2E73kfz2zWIoPiymnTXOLKSyikqsbLBf5h6
         uUsATktOwZAt+wjKdKSYiHz5QukTf4X+ijQ4R8qpO4qV+3cgy0o/GjfVaCNhfu4WHRkq
         zg6LIQpR7maak5he81nsLayp5+amdXEOsxJcUY7x+QdnRR9DjN3mRtE09UvOoCI/A9Fo
         PQAQ==
X-Gm-Message-State: AO0yUKV7ROnfr/cAmzHv9CHT9HrF0rXVpf9whY8ruw7J8LMkg+VpvZYH
        LynIml+rtSVQIE5Mk6hqSQSY1ZKfHpr/woh2
X-Google-Smtp-Source: AK7set+mfzWx3mxCfqbVfdwwFUpePlSYefplh4FXnZ5ATccmMriRtYim0RuXuYksfloxNhK80PKjfQ==
X-Received: by 2002:a05:6a00:1d0a:b0:5a8:473e:2fdc with SMTP id a10-20020a056a001d0a00b005a8473e2fdcmr5579704pfx.12.1676003047015;
        Thu, 09 Feb 2023 20:24:07 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id h11-20020aa786cb000000b005941bb94491sm2250946pfo.4.2023.02.09.20.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:24:06 -0800 (PST)
Date:   Fri, 10 Feb 2023 13:24:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y+XG4mWPi4X9/hHZ@google.com>
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org>
 <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
 <Y+GtsM6vJge90LHe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+GtsM6vJge90LHe@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/07 10:47), Sergey Senozhatsky wrote:
> > >  enum fullness_group {
> > > -       ZS_EMPTY,
> > > -       ZS_ALMOST_EMPTY,
> > > -       ZS_ALMOST_FULL,
> > > -       ZS_FULL,
> > > +       ZS_USAGE_0,
> > > +       ZS_USAGE_10,
> > > +       ZS_USAGE_20,
> > > +       ZS_USAGE_30,
> > > +       ZS_USAGE_40,
> > > +       ZS_USAGE_50,
> > > +       ZS_USAGE_60,
> > > +       ZS_USAGE_70,
> > > +       ZS_USAGE_80,
> > > +       ZS_USAGE_90,
> > > +       ZS_USAGE_99,
> > > +       ZS_USAGE_100,
> > >         NR_ZS_FULLNESS,
> > >  };
> > >
> > 
> > Is there a reason why this can't be done with something like #define
> > FULLNESS_GROUPS 10? We can make sure during build that (100 %
> > FULLNESS_GROUPS == 0) to make our lives easier. I feel like the code
> > will be much more concise and easier to navigate, instead of multiple
> > enums and static arrays.
> 
> I wanted to keep things the way they are to make reviews simpler.
> We probably can do something more "disruptive" in a separate patch.

Forgot to mention, I was also thinking about extending zsmalloc stats
file and providing values for each fullness group per class, as opposed
to current ALMOST_EMPTY and ALMOST_FULL stats, which don't tell much.

I can get rid of static const arrays and pass "begin / end" group IDs to
functions that iterate fullness lists and pick the first head page, but
I think that enum values will stay.
