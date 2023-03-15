Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC76BBE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCOVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCOVFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:05:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBEE3B3DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:05:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q6so8413580iot.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678914318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IwGhmwR58ADGQ+ITIo7v6jnjt7oIvun400KU/kpOQR4=;
        b=YzSWvQUxOkJcRTkv1YhAMyONarbx7Wu+HHznXkPA9m54ndq1AiUlL+AhbB/8LXmCAm
         6vf7d1cVNB1CzyCt7T0lqXBRCFFZuNexrCKvXLs/EnXy1m+szYTG8Q3+9NabFzQlUVr1
         c/VThVm63A3IUacpvDyqPgH90lPd/O82UO8n6UUb/lwesL/Qcy4Y2KyOMQz+OJvS8yvS
         tNdNKOjTpRGsA/IIfxTocHxycPqQiDevURIp7UIxm43Kjl1YPtAwwzUCU6d+jICr7dEt
         D+d8viAnkQ0JtW0ZzaVYrdgeY22LR53R1mA2bOcPqN4ki56zHOJCRDrCZQpw4TDhLk/7
         EnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwGhmwR58ADGQ+ITIo7v6jnjt7oIvun400KU/kpOQR4=;
        b=d7EbJyABYLxrACw81A9WXfr86ukp/Cdn5YZYCpOwSr+KOnBlDgG/979LfZVyfUSmcd
         vGB3R68V3RKRBcyAWeF1kCWfx5nOETka6yI0fQ8sN/MCJKTb6b1tS0Z1HmE1H8jWKYYj
         6XaCvXuGbfgKizppwkHHVRk4EvNQD/c1zBGX9pcUndc5zI4jdG/eT+BhijOWPwWb2Mhc
         nAdRf+eZesg6hORD/0PLzhzd3bwsXrBtKzNA2/TH4KdAkdrUs6g9HsOTYH+LEkYjtBLu
         o7zMpPsRriV6/dnTjoZcm3eVgOT1Lis6EVxJjW+99Jweex60m7Qx2/74KhnbvFNLRbNj
         KUGQ==
X-Gm-Message-State: AO0yUKXwswxEPhvLh8N70EocYohLIzSGw0ah2hFJjhaFnYyazvGZl1mX
        C7MkPabwWY2SPvtSrKDSBej5hdQXm9TGhk/Gc7G7aw==
X-Google-Smtp-Source: AK7set/O/C/AmSPYxARwLjtbc8HQkBpIBl2PZeSCG4mpPndRBaBsslTRMqibTUEyoa/Dpk4ISb2xZMwqOaEvshNFNg4=
X-Received: by 2002:a6b:ed02:0:b0:74c:8243:9291 with SMTP id
 n2-20020a6bed02000000b0074c82439291mr19019902iog.1.1678914317895; Wed, 15 Mar
 2023 14:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230315034441.44321-1-songmuchun@bytedance.com>
 <CANpmjNMxDT+AHBZra9ryhm6aw+WqBsdJ_SKdcdZr6CBsh97LyQ@mail.gmail.com> <20230315125425.70a22d32cf46b23d249775ec@linux-foundation.org>
In-Reply-To: <20230315125425.70a22d32cf46b23d249775ec@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Mar 2023 22:04:33 +0100
Message-ID: <CANpmjNO=_Oi++xgywqcnj2W0dyX96zmUd+37BSbmwMd0=c_=Mg@mail.gmail.com>
Subject: Re: [PATCH] mm: kfence: fix using kfence_metadata without
 initialization in show_object()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        dvyukov@google.com, jannh@google.com, sjpark@amazon.de,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
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

On Wed, 15 Mar 2023 at 20:54, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 15 Mar 2023 09:07:40 +0100 Marco Elver <elver@google.com> wrote:
>
> > On Wed, 15 Mar 2023 at 04:45, Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > The variable kfence_metadata is initialized in kfence_init_pool(), then, it is
> > > not initialized if kfence is disabled after booting. In this case, kfence_metadata
> > > will be used (e.g. ->lock and ->state fields) without initialization when reading
> > > /sys/kernel/debug/kfence/objects. There will be a warning if you enable
> > > CONFIG_DEBUG_SPINLOCK. Fix it by creating debugfs files when necessary.
> > >
> > > Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > Tested-by: Marco Elver <elver@google.com>
> > Reviewed-by: Marco Elver <elver@google.com>
>
> Thanks, I'll add cc:stable to this.
>
> I assume the warning is the only known adverse effect of this bug?

For architectures where the initial spinlock state is 0, the warning
is the only issue. For architectures where that's not the case, it
might result in lockup of the task querying the 'objects' file --
which isn't the case for any arch that supports KFENCE by the looks of
it (last I checked 'sh' and 'parisc' don't support KFENCE).

Thanks,
-- Marco
