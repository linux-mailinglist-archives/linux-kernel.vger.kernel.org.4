Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6D6A8DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCCAUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCCAUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:20:47 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0924A43456
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 16:20:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so670101pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 16:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677802846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d09pCOgXcgV83C5wemsdhBVk0296NBI8B2AYqKA+7dU=;
        b=MrvVWeacOGbHYAss+0b0UfKFXAgWPUAjaSE3KrOxbvQTyXppP3i9vNMcr5+oSVq9P/
         ZywpC6Z9ycWmjoGGMsHRKs8tH8muNIP8Huy6GkjYF95XZ3lHDaCZOOJ3IwyiTyG7qYa1
         4OJluaibGhUA1U3lIRA+9NYvr54VMzQdojt2Yx44sK9fNgIKEw67O2tXZR05M/0aSP1J
         LTGl5JlcqPBGDvpCo4VGQ8j6puZp5AdnMpWbTmf1irJNE7lmIBClRKGb2g7npqGPJHZk
         Gn/9ZcwjtMdiyhaLdNIs3BUlDvBqxRHno9YVr5LrXBUUWupZEfk0qq0yN6KoBWdbmCC+
         yTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677802846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d09pCOgXcgV83C5wemsdhBVk0296NBI8B2AYqKA+7dU=;
        b=FRlY7yfOh6IANiyDh/IRnqEPGFqPn9NYIdzUk7nPwNK+yFPB6Fej3KxkN8ycxLFXtm
         3Ad5e0kDYVJrnYdHrLID5oEqAWtNjKadUo7x/h5cTtAgpQUsd8seL1HnoFJd/+UzCSEn
         aIXitES3IBjn8U5DGphRhlXYs4MNGHiiDvuNpazXCSnikIJuCqlQTRQk5n+w7wM1dX94
         CcJ6lkIhL7SSzUc3ptb9jxAGiDPUA55fEvrhV8ER6g1NtR5zdjoJkvHBXqFLN8c3uR9n
         wlkzVKDxrrUjCd3S2UuONCtdNOutxe6xcfNnqMCGKgK/y82JZ/96SklpHJaysNDbvSen
         /UCw==
X-Gm-Message-State: AO0yUKV+yPBd4QrqIO0eKJhf5cfBiOpixZ9LnxGzwPltWYSbbSLCTvG3
        kO7SVfKjDiXRd+nyQAGnTvE=
X-Google-Smtp-Source: AK7set8vX00BwuBZA80O/1JUZspBj7SyOlV5bp212BRM7TU1Sun75OVJm6gc/CRv2RFc8HxAHSh53A==
X-Received: by 2002:a05:6a20:6a1c:b0:c3:2bef:bd62 with SMTP id p28-20020a056a206a1c00b000c32befbd62mr363394pzk.1.1677802846323;
        Thu, 02 Mar 2023 16:20:46 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4036:e990:6bc4:4206])
        by smtp.gmail.com with ESMTPSA id r7-20020a634407000000b005038291e5cbsm248330pga.35.2023.03.02.16.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:20:45 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 2 Mar 2023 16:20:43 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <ZAE9W5xQmQecUzhj@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
 <Y/8TENp78WSQ0UW3@google.com>
 <Y//tqFQgsCeMimg5@google.com>
 <Y//zbxEmAmoA69ed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y//zbxEmAmoA69ed@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:53:03AM +0900, Sergey Senozhatsky wrote:
> On (23/03/01 16:28), Minchan Kim wrote:
> > On Wed, Mar 01, 2023 at 05:55:44PM +0900, Sergey Senozhatsky wrote:
> > > On (23/02/28 14:53), Minchan Kim wrote:
> > > > BTW, I still prefer the enum instead of 10 define.
> > > > 
> > > > enum fullness_group {
> > > >     ZS_EMPTY,
> > > >     ZS_INUSE_RATIO_MIN,
> > > >     ZS_INUSE_RATIO_ALMOST_FULL = 7,
> > > >     ZS_INUSE_RATIO_MAX = 10,
> > > >     ZS_FULL,
> > > >     NR_ZS_FULLNESS,
> > > > }
> > > 
> > > For educational purposes, may I ask what do enums give us? We
> > > always use integers - int:4 in zspage fullness, int for arrays
> > > offsets and we cast to plain integers in get/set stats. So those
> > > enums exist only at declaration point, and plain int otherwise.
> > > What are the benefits over #defines?
> > 
> > Well, I just didn't like the 12 hard coded define *list* values
> > and never used other places except zs_stats_size_show since
> 
> If we have two enums, then we need more lines
> 
> enum fullness {
> 	ZS_INUSE_RATIO_0
> 	...
> 	ZS_INUSE_RATIO_100
> }
> 
> enum stats {
> 	INUSE_RATIO_0
> 	...
> 	INUSE_RATIO_100
> 
> 	// the rest of stats
> }
> 
> and then we use int:4 fullness value to access stats.

Yeah. I don't see any problem unless I miss your point.

> 
> > I thought we could handle zs_stats_size_show in the loop without
> > the specific each ratio definary.
> 
> For per inuse ratio zs_stats_size_show() we need to access stats
> individually:
> 
> 	inuse10, inuse20, inuse30, ... inuse99

Does it need specific index in the enum list?

I don't mind having all the hard coded index if it's *necessary*
but wanted to try we could make the index with base + index
on demand in the loop via simple arithmetic.
