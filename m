Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FE4691819
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBJFxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBJFxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:53:08 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF146566A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:53:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z1so5424085plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 21:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8a69HEYkh1oQvGxe695mWtJAwhwUUM7wLLsEJAlx1U=;
        b=KqlyxfWjqGDVE/MXDWllO7DsPw2/IY8BO/Ij3Rws+Rrz/ZHtbS2fMRNelKoJ7lfZkg
         VRxI9OauzRrZShnlI9dHI1QOd7+lXwYrKMUS5zqbzRDz315mr0x7jA2yEF56XLpa4vyg
         H7qLD+hgx5kRmwPZtjeMuPDUCXASeGeLbrUwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8a69HEYkh1oQvGxe695mWtJAwhwUUM7wLLsEJAlx1U=;
        b=DmIXoq218xQ/zwY90hyNsCZMBmIYDud9o6pAQSve7HOCtfvGLfBDZeaKdjqQnVUcPw
         vL1nwMQSGqbPXjFp6EMB+fQULlzxUl8ipPiKJwJ49Bo6AdbzcQDFu+dXAMb7s5nAKS2O
         8m1jb9HqK+srr/WGyjmBDgQGC3x4U8mHKh3c/SgRR4cvaZOkFwgUe+GjZ6N96SA19xh7
         cmzhtfxS6k6wJo1qsHQv9w13Co3zlGrdPpuj0MEEhuL+1ED3ExdrbeO28Z8dqRzCITvD
         wkNHfmXzcKwlgRMH9OqgvQ2ehaivfAxxMjtF1iz/0jfziuiP89EHMw93FXLa834JzHNr
         qmQQ==
X-Gm-Message-State: AO0yUKVgEekxOCO/aZ7rLAvcxGfR2fr+mLYBkcHrSKzKQRLU3x1xWR09
        9X4oj+2AsqVp/V2UUYRRzuG6VQ==
X-Google-Smtp-Source: AK7set/Nnbh0tPoL9KSBfOCad7/dCn2+vZN4cSn5tXxNkRawo3thm8lpj1DJfijTa2b+CcSzOxvatQ==
X-Received: by 2002:a05:6a20:3ca0:b0:c1:344c:668f with SMTP id b32-20020a056a203ca000b000c1344c668fmr16020692pzj.12.1676008379916;
        Thu, 09 Feb 2023 21:52:59 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0056be1581126sm2474167pfi.143.2023.02.09.21.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 21:52:59 -0800 (PST)
Date:   Fri, 10 Feb 2023 14:52:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y+Xbt4uJ/214xnR5@google.com>
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org>
 <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
 <Y+GtsM6vJge90LHe@google.com>
 <Y+XG4mWPi4X9/hHZ@google.com>
 <CAJD7tka3s84v9-ZA-OZkBkina6MByCSFnKXwv+hq8o8nZSZoyg@mail.gmail.com>
 <Y+XIR64RyVv0EfTx@google.com>
 <CAJD7tkaLtuNL_=WtcMsZ_orSwRMhN3K7vF8PWcxLRXKc6Z8uGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaLtuNL_=WtcMsZ_orSwRMhN3K7vF8PWcxLRXKc6Z8uGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/09 21:15), Yosry Ahmed wrote:
> > We need to be able to do zs_stat_get(class, CLASS_USAGE_70) or
> > zs_stat_get(class, CLASS_USAGE_10) in zs_stats_size_show() to
> > show class's fullness stats.
> 
> If we use #define FULLNESS_GROUPS 10 for example, we can break down
> struct zs_size_stat from a single array to two arrays, one of the for
> fullness groups and the other one for the rest of the stats (e.g.
> OBJ_USED). We can have different helpers to update each, the former
> taking in a fullness value (0 to FULLNESS_GROUPS-1), and the latter an
> enum. WDYT?

Wouldn't this be more code to review, maintain though? I mean,
what do we gain with this - fewer values in enum?
