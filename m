Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFA6A8ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCCBiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCCBiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:38:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7988FAD20
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:38:10 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so4711017pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677807490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+4wsqONS94BLAD7J2SQKnc2Ly/7mV4AxVfIdl1/JKQ=;
        b=dTBMQZHHs+SLU8GuE3IT8ngOudbRWTTy4M2hi6X+1XNv5bfE+R4GsWClPXFwNK8cUE
         UXa84vZ7q1XFNB4iIJtZMWeEF6HjGF6di4KZW/9TnOWlgUiP+vMIUw/oroe7JB5L0Evd
         4J+6te56t9PamHXF0tz4bpiIVxZ0enZ+8MGO0m2fbn0FxKRE/95ovSXn5KmOh9yIOfzy
         ZShswTWzcNpKlVi8g1QL+o+oAYxvKU7GaufW/MrhBzub+NjwDFeIaUD80lhk1lDZSUeL
         uuFSj5NJ5yD2OG2xecUuYgYHskUyI43SwhmeeZMq65LNM8+IpBf2bNzXFdUygq56S5dO
         jWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677807490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+4wsqONS94BLAD7J2SQKnc2Ly/7mV4AxVfIdl1/JKQ=;
        b=bo+dr+1M1oMIQHsHhQ+qKGqyP5AbpD3F5UxiLMHe46QSCcLUhQIvh3+oCIu7fM20C3
         MaG8lNAxOtkTq5UhZQbuD5OWskgycpWyVuW91UBgyQ880H4CVB/+S3aSXL3PM1HfECCs
         ywGzDJ/BTChyi3AtB54BJ7BmGww4EjwkVthhThYCElxl7zgkSf1QD1PVY5Ks/Y3vvRSk
         HSgW//A0fDN75XaMmkCzpgAeG7S3RlkGYcXMcx1s8nX7oc4N3qD0gBgPLGBsXD/0Sh57
         FCOncbx7BfH4vnynp2vzv/8tm3opplF02Jk1tCDIVPC9kTf6A+7nTb4+7Z+bGV0ZOyrJ
         Ql9A==
X-Gm-Message-State: AO0yUKWgURXPHvGu2JlW3IE2HvqOs4nHpPIEFilWfwbgnKvaLP5oF7+s
        VLHfLamaRn0SIhfBWiFbWic=
X-Google-Smtp-Source: AK7set8qVmO671kkfzWh6BakH4jRefkToDjbz+gnq5AXZrLF+NhcUqebsky0XvFRGUv4kVZDB5r/7A==
X-Received: by 2002:a05:6a20:12c7:b0:cc:e0fb:a83f with SMTP id v7-20020a056a2012c700b000cce0fba83fmr607125pzg.36.1677807489852;
        Thu, 02 Mar 2023 17:38:09 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4036:e990:6bc4:4206])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78494000000b005ae8e94b0d5sm317463pfn.107.2023.03.02.17.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:38:09 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 2 Mar 2023 17:38:07 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <ZAFPf9pv1CTmIgtL@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
 <Y/8TENp78WSQ0UW3@google.com>
 <Y//tqFQgsCeMimg5@google.com>
 <Y//zbxEmAmoA69ed@google.com>
 <ZAE9W5xQmQecUzhj@google.com>
 <20230303010643.GA4022757@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303010643.GA4022757@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 10:06:43AM +0900, Sergey Senozhatsky wrote:
> On (23/03/02 16:20), Minchan Kim wrote:
> > On Thu, Mar 02, 2023 at 09:53:03AM +0900, Sergey Senozhatsky wrote:
> > > On (23/03/01 16:28), Minchan Kim wrote:
> > > > On Wed, Mar 01, 2023 at 05:55:44PM +0900, Sergey Senozhatsky wrote:
> > > > > On (23/02/28 14:53), Minchan Kim wrote:
> > > > > > BTW, I still prefer the enum instead of 10 define.
> > > > > > 
> > > > > > enum fullness_group {
> > > > > >     ZS_EMPTY,
> > > > > >     ZS_INUSE_RATIO_MIN,
> > > > > >     ZS_INUSE_RATIO_ALMOST_FULL = 7,
> > > > > >     ZS_INUSE_RATIO_MAX = 10,
> > > > > >     ZS_FULL,
> > > > > >     NR_ZS_FULLNESS,
> > > > > > }
> > > > > 
> > > > > For educational purposes, may I ask what do enums give us? We
> > > > > always use integers - int:4 in zspage fullness, int for arrays
> > > > > offsets and we cast to plain integers in get/set stats. So those
> > > > > enums exist only at declaration point, and plain int otherwise.
> > > > > What are the benefits over #defines?
> > > > 
> > > > Well, I just didn't like the 12 hard coded define *list* values
> > > > and never used other places except zs_stats_size_show since
> > > 
> > > If we have two enums, then we need more lines
> > > 
> > > enum fullness {
> > > 	ZS_INUSE_RATIO_0
> > > 	...
> > > 	ZS_INUSE_RATIO_100
> > > }
> > > 
> > > enum stats {
> > > 	INUSE_RATIO_0
> > > 	...
> > > 	INUSE_RATIO_100
> > > 
> > > 	// the rest of stats
> > > }
> > > 
> > > and then we use int:4 fullness value to access stats.
> > 
> > Yeah. I don't see any problem unless I miss your point.
> 
> OK. How about having one enum? E.g. "zs_flags" or something which
> will contain all our constants?
> 
> Otherwise I can create two big enums for fullness and stats.

Let's go with two enums at this moment since your great work is not
tied into the problem. If that becomes really maintaince hole,
we could tidy it up at that time.

> What's your preference on inuse_0 and inuse_100 naming? Do we
> keep unified naming or should it be INUSE_MIN/INUSE_MAX or
> EMPTY/FULL?

I don't have strong opinion about it. I will follow your choice. ;-)

> 
> > > For per inuse ratio zs_stats_size_show() we need to access stats
> > > individually:
> > > 
> > > 	inuse10, inuse20, inuse30, ... inuse99
> > 
> > Does it need specific index in the enum list?
> 
> If we report per inuse group then yes:
> 
> 	sprintf("... %lu %lu ..... %lu %lu ...\n",
> 		...
> 		get_stat(ZS_INUSE_RATIO_10),
> 		get_stat(ZS_INUSE_RATIO_20),
> 		get_stat(ZS_INUSE_RATIO_30),
> 		...
> 		get_stat(ZS_INUSE_RATIO_99),
> 		...);

I thought we could handle it with loop

prologue - seq_printf
for (ratio = min, ratio < max; ratio++ )
    seq_printf(s, "%lu", get_stat(ratio)
epilogue - seq_printf
seq_puts(s, "\n");
