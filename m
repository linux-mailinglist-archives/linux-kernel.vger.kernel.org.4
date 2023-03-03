Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81006A8E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCCBGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCCBGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:06:49 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA95551A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:06:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso759275pjs.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwwXsWMJrnirAh+/Y2JC4tS8+2STW/C39tOpLj/kUk8=;
        b=FFoM7AZffas7rYnHcuBVGhC6QQzJaz41qkhKHUGlQyaZWY8FZ0UWf2mvf+e+nLJp5S
         1+193lnt6XrZtaGiE6ydZGkvAjzd6+S4dXUJIayf9SrrpELU1+/Eq9vViRfpcmHwM9Wz
         uCCJvwB5IZWP1O5VGhDYzHeDeJ48mULJR8CRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwwXsWMJrnirAh+/Y2JC4tS8+2STW/C39tOpLj/kUk8=;
        b=Fc215ik0GtmcMKgqrqRJRvA644WZ7Zf7A1PVrVqoWhyFTV06H1veHt4I5wjkR+oFPQ
         F/J6jWeP2YSoaM88pQbqolYqkXmLXD5BTLqhgJ4pH3x1lwJhzPFFcPpJKRPVhZUD2skH
         xg/6x5WQfC6DehW/+XibpK1ld6j7ez6URfkTx80bp5rAntOLul0/vLwCPBDlB4X+S5vt
         c0dZddR3dotLPwQh+I6ROVmI1ZIx8mjFOF5YGbX1M0qpZb41aE/SMlvRbDEjTY8W8VzP
         dWHKENJhUq3wk8sYuIkLRnfW81CCjRlFPBRVIHG6fiPvMlUwe1GgrH/orMDdQvftg0Zi
         PD1Q==
X-Gm-Message-State: AO0yUKXGCkjZ4Zd35UqEMhjMMTrCV0DcW+6o1yImDsfFM/RtyG85QR+9
        HEjve+ELsQg/BTAfgs80spFIpg==
X-Google-Smtp-Source: AK7set8SRihRZc46G0YoZTU/j4Ue/C0DSlTqqvPMGPRayXqA+AtQLj4M95qxwZ0ZXyEktQnMFJxA2A==
X-Received: by 2002:a05:6a20:8c0f:b0:bc:f336:98ed with SMTP id j15-20020a056a208c0f00b000bcf33698edmr307252pzh.45.1677805608072;
        Thu, 02 Mar 2023 17:06:48 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id x24-20020aa793b8000000b00593adee79efsm307077pff.55.2023.03.02.17.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:06:47 -0800 (PST)
Date:   Fri, 3 Mar 2023 10:06:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <20230303010643.GA4022757@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
 <Y/8TENp78WSQ0UW3@google.com>
 <Y//tqFQgsCeMimg5@google.com>
 <Y//zbxEmAmoA69ed@google.com>
 <ZAE9W5xQmQecUzhj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAE9W5xQmQecUzhj@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/02 16:20), Minchan Kim wrote:
> On Thu, Mar 02, 2023 at 09:53:03AM +0900, Sergey Senozhatsky wrote:
> > On (23/03/01 16:28), Minchan Kim wrote:
> > > On Wed, Mar 01, 2023 at 05:55:44PM +0900, Sergey Senozhatsky wrote:
> > > > On (23/02/28 14:53), Minchan Kim wrote:
> > > > > BTW, I still prefer the enum instead of 10 define.
> > > > > 
> > > > > enum fullness_group {
> > > > >     ZS_EMPTY,
> > > > >     ZS_INUSE_RATIO_MIN,
> > > > >     ZS_INUSE_RATIO_ALMOST_FULL = 7,
> > > > >     ZS_INUSE_RATIO_MAX = 10,
> > > > >     ZS_FULL,
> > > > >     NR_ZS_FULLNESS,
> > > > > }
> > > > 
> > > > For educational purposes, may I ask what do enums give us? We
> > > > always use integers - int:4 in zspage fullness, int for arrays
> > > > offsets and we cast to plain integers in get/set stats. So those
> > > > enums exist only at declaration point, and plain int otherwise.
> > > > What are the benefits over #defines?
> > > 
> > > Well, I just didn't like the 12 hard coded define *list* values
> > > and never used other places except zs_stats_size_show since
> > 
> > If we have two enums, then we need more lines
> > 
> > enum fullness {
> > 	ZS_INUSE_RATIO_0
> > 	...
> > 	ZS_INUSE_RATIO_100
> > }
> > 
> > enum stats {
> > 	INUSE_RATIO_0
> > 	...
> > 	INUSE_RATIO_100
> > 
> > 	// the rest of stats
> > }
> > 
> > and then we use int:4 fullness value to access stats.
> 
> Yeah. I don't see any problem unless I miss your point.

OK. How about having one enum? E.g. "zs_flags" or something which
will contain all our constants?

Otherwise I can create two big enums for fullness and stats.
What's your preference on inuse_0 and inuse_100 naming? Do we
keep unified naming or should it be INUSE_MIN/INUSE_MAX or
EMPTY/FULL?

> > For per inuse ratio zs_stats_size_show() we need to access stats
> > individually:
> > 
> > 	inuse10, inuse20, inuse30, ... inuse99
> 
> Does it need specific index in the enum list?

If we report per inuse group then yes:

	sprintf("... %lu %lu ..... %lu %lu ...\n",
		...
		get_stat(ZS_INUSE_RATIO_10),
		get_stat(ZS_INUSE_RATIO_20),
		get_stat(ZS_INUSE_RATIO_30),
		...
		get_stat(ZS_INUSE_RATIO_99),
		...);
