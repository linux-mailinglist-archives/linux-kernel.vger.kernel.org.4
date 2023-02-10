Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB49691853
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjBJGIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjBJGIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:08:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2204E55E45
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 22:08:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u21so3926925edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 22:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VvQcVILqY953RqqG1gck7Ie05+OeOYGRzCPy0aoHlPQ=;
        b=IlAmMNNBXy3RPbuh5sjLKCDIhlj8JGxsV70UrAqu5BbIvdtLv1Ip/GbOVKvOWy3eXN
         UkhMfjmhNpa6Te/u1+HOzYmB20l/Iru0D1qOpyfGti6yjeILaE2GUWgvQvYLpa1nhS0d
         wRb6amlMU73lBRS6e0tDys/kQpmbloO0JYkzn3bNp9EVqfbmblgsxtQAdCV5aXCtG2WN
         oc39MEIbr7fhjFD8918G1cSJcIc3ZbjZK4XfjqBFUIPu3TRWJjXrODMsdtVQf8eD8AgP
         YBxfWHMEVYv/T+UYsKfK9olYZ50T9ysdE7cM5T5kCTI5YlQIJHk4IQHnXcS6aeJRHP1I
         pDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvQcVILqY953RqqG1gck7Ie05+OeOYGRzCPy0aoHlPQ=;
        b=u+DJbp/camarzUT+oLASXzsMIqrcx8LJ3HIFzG3RQCdOw6OIJAdRx3JmIqR1kVxiKg
         MasCP8Yy9nETP7Y2O16dYSUMJpa8L0CthaSYcNfrgpqxFsHSq7uSDOrtqifpjesvj2Bh
         rbDrxaiw3dee/XrwgRddAXMJu0i7QXT7ILdghKglhRI4GsONsw4co/L1Qfuf4HytTeuG
         xlRr9so0molLD6kidK249nR4etgB15hPWLaEW0A0rMzFhR/9xonfcL0kvGOLMgMm+qBx
         +A2qeDFO0jO64QFHiHF5sfK7fLnZDE3UrqeUio2FGzIuwdV5aHASfXQAXkzfft1rHU1J
         JSGw==
X-Gm-Message-State: AO0yUKUUR9iDOV7U6PffZ0nWeb8/qPHM31KxTMzEb1XLx2bnOTR+J0Rw
        V8fmtBWUw4cnS82uc8gvd/FBUR656gSF795hzEMr1A==
X-Google-Smtp-Source: AK7set9TsAH5358r5nqBViR8GZn2DKVlkkHlNvP6o90OYzyy9WGs7FgHYXqU/3+gHy3Hnk3Qg+cs9sFuAD6wxQK6CMA=
X-Received: by 2002:a05:6402:f11:b0:4ab:4cf5:591 with SMTP id
 i17-20020a0564020f1100b004ab4cf50591mr66129eda.3.1676009293422; Thu, 09 Feb
 2023 22:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org> <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
 <Y+GtsM6vJge90LHe@google.com> <Y+XG4mWPi4X9/hHZ@google.com>
 <CAJD7tka3s84v9-ZA-OZkBkina6MByCSFnKXwv+hq8o8nZSZoyg@mail.gmail.com>
 <Y+XIR64RyVv0EfTx@google.com> <CAJD7tkaLtuNL_=WtcMsZ_orSwRMhN3K7vF8PWcxLRXKc6Z8uGQ@mail.gmail.com>
 <Y+Xbt4uJ/214xnR5@google.com> <CAJD7tka73PT8ka78rJBnd0JMtfjLY7SAr953MKNbZy5+icHD8g@mail.gmail.com>
In-Reply-To: <CAJD7tka73PT8ka78rJBnd0JMtfjLY7SAr953MKNbZy5+icHD8g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 9 Feb 2023 22:07:37 -0800
Message-ID: <CAJD7tkb=Fj7xPQUZ8XOQKG0QXQTd+UcEKMDQSLdU7vs3Wjqg0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness grouping
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 10:04 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Feb 9, 2023 at 9:53 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (23/02/09 21:15), Yosry Ahmed wrote:
> > > > We need to be able to do zs_stat_get(class, CLASS_USAGE_70) or
> > > > zs_stat_get(class, CLASS_USAGE_10) in zs_stats_size_show() to
> > > > show class's fullness stats.
> > >
> > > If we use #define FULLNESS_GROUPS 10 for example, we can break down
> > > struct zs_size_stat from a single array to two arrays, one of the for
> > > fullness groups and the other one for the rest of the stats (e.g.
> > > OBJ_USED). We can have different helpers to update each, the former
> > > taking in a fullness value (0 to FULLNESS_GROUPS-1), and the latter an
> > > enum. WDYT?
> >
> > Wouldn't this be more code to review, maintain though? I mean,
> > what do we gain with this - fewer values in enum?
>
> I don't feel very strongly, but the patch above has a lot of hardcoded
> values, multiple enums & static arrays. If we want to change the
> number of fullness groups to 5 or 20, we modify all of them. Just
> trying to make the code cleaner. If you think it will add a lot more
> code to review/maintain, then maybe it's not worth it. I didn't really
> give it a lot of thought.

We can also do something like:

#define NR_FULLNESS_GROUPS 10

enum class_stat_type {
        OBJ_ALLOCATED = NR_FULLNESS_GROUPS,
        OBJ_USED,
        NR_ZS_STAT_TYPE,
 };

and get rid of enum fullness_group, I think the current stats inc/dec
helpers will work out of the box.
