Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8346A7880
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 01:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCBAxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 19:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBAxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 19:53:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3412F0A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 16:53:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso2428271pjv.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 16:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GwrMZ5I3T6uRzM3A6umaOXwCbm8OAAi/5ZzWIFWyy2o=;
        b=c0q7KpplWoYrLdb1E4hjrHNFSpijbfkD5k4sqqT0x4LldOcDkUJpwG3TRM+7p1tWTy
         glH165cj6R4HZrDQAvGxHhBjAEutnAdw4S9yow/04ImQ5hd8QKlb4D3JBGtF3er+DAde
         LEn4oJEqbkMbt9WYfN94xXss9xMZjFQb8QK8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwrMZ5I3T6uRzM3A6umaOXwCbm8OAAi/5ZzWIFWyy2o=;
        b=2wGeS41JQgwHxZGODY2i+6l1SzQ16CfnPtyJF1+isLBdegRZYMWlm6q9pmsnfBEnAk
         tQVtx2kaQBV3+UZ9kLMNfR0M0RG1shWRlBX6ajqc1s+VadRm5fkhPqb+UtT6d776F5Tl
         Q4GuYgB6xNh9crdXXjbeXMlegsgCMkE1jo2tXsY12ElfatNZt6+FSdhul1O+kN12AqjF
         4C92ZMDoIB2h5X+tI88yG1Ddqq/dKjAb9kI5ESfY6c7j1lk7uGsJdq6h8IACYEmlO95d
         hY1hJ4OmdztYrxNjWXksONZI0AVqZk/VyI2vuI3sxK/pGL2aJCkE7ny1ge4HKXrrj5rN
         b5IQ==
X-Gm-Message-State: AO0yUKW2dpzRV/ujKnQ7LF/TVq3/8DvoHyNa6ybLWvBVId/tjD3Q4+DN
        aZNoXDy4qqSjaJXUgyINUnDHmHKFqlrlh19b
X-Google-Smtp-Source: AK7set/izjfhBX+baQBD+A+keogk0r5KJ+0emXgJ8WYMdRTSYVl2r0bX24AaK4s6QlLzF6TZw0QMRw==
X-Received: by 2002:a17:902:f7c2:b0:19a:b588:6fe2 with SMTP id h2-20020a170902f7c200b0019ab5886fe2mr309199plw.13.1677718387837;
        Wed, 01 Mar 2023 16:53:07 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d70500b0019d397b0effsm5731347ply.270.2023.03.01.16.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 16:53:07 -0800 (PST)
Date:   Thu, 2 Mar 2023 09:53:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y//zbxEmAmoA69ed@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
 <Y/8TENp78WSQ0UW3@google.com>
 <Y//tqFQgsCeMimg5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y//tqFQgsCeMimg5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/01 16:28), Minchan Kim wrote:
> On Wed, Mar 01, 2023 at 05:55:44PM +0900, Sergey Senozhatsky wrote:
> > On (23/02/28 14:53), Minchan Kim wrote:
> > > BTW, I still prefer the enum instead of 10 define.
> > > 
> > > enum fullness_group {
> > >     ZS_EMPTY,
> > >     ZS_INUSE_RATIO_MIN,
> > >     ZS_INUSE_RATIO_ALMOST_FULL = 7,
> > >     ZS_INUSE_RATIO_MAX = 10,
> > >     ZS_FULL,
> > >     NR_ZS_FULLNESS,
> > > }
> > 
> > For educational purposes, may I ask what do enums give us? We
> > always use integers - int:4 in zspage fullness, int for arrays
> > offsets and we cast to plain integers in get/set stats. So those
> > enums exist only at declaration point, and plain int otherwise.
> > What are the benefits over #defines?
> 
> Well, I just didn't like the 12 hard coded define *list* values
> and never used other places except zs_stats_size_show since

If we have two enums, then we need more lines

enum fullness {
	ZS_INUSE_RATIO_0
	...
	ZS_INUSE_RATIO_100
}

enum stats {
	INUSE_RATIO_0
	...
	INUSE_RATIO_100

	// the rest of stats
}

and then we use int:4 fullness value to access stats.

> I thought we could handle zs_stats_size_show in the loop without
> the specific each ratio definary.

For per inuse ratio zs_stats_size_show() we need to access stats
individually:

	inuse10, inuse20, inuse30, ... inuse99
