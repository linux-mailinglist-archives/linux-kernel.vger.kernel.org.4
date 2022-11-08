Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB63621D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKHTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKHTdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:33:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C634414D24
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:33:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso18767481pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uOJh+ETiQjU+MyD/YUAuXcaoGs4hbJnwWP6YeF46sk=;
        b=RvwYczTMrlGAPuR4YyZLiBWeQEwvPbwG1DaFdFzQTZhUHHA7sVPQ4cLyuqN1xr2sBt
         mRJRu9i2fNCHkQoqfOIyYpPDYsY4dfg4VQsKbJW004+tjNRrVppU7/brhG17KZ4pmPE7
         9BoazGHFSc+vaDPykbp8+zeAt2DOTmCy27NCwXqnRep93+UJez60k/MYVfmYvkn3a+7L
         5lRko0oDAsrsR1vQwS7caAhhOjtYDJYeJy6QK+q/6UDrLKwPiCuUbtW4Rk+OpyJ5KPoV
         rmR0ACqAesVvAqLWPOGzpKqVbOk9L3Q5SagpwtIH5kiGRNj5HnqGd3XP6tpa407jWP/y
         srWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uOJh+ETiQjU+MyD/YUAuXcaoGs4hbJnwWP6YeF46sk=;
        b=S+y/LYfQvCxmtsxUYM4xQBc9Z67HRMPe7Dn8KqFFcS66tURBwAAU9j9q5zU1WM60RX
         uLRnVrcoLFvgJjiCtMmMSTCxX5reW0xd1XRegw/GPmaayFJp+DOsGNvjfe7dKvDcTRiW
         CaYb3H+yomTPmKEaPanoqlAwuhG0q7rkXPpz/YlRj4diNoa+C/sVr3vS2M3eRxitTbYo
         ctawAqhSgyQ+gmXagu1wYngYpkT7MGzW7utBnmz1JXz02/LljrN/5DNknGDIiNZOqO2s
         FdM01AptkTqoQa+xPPniEC0QYOrX4FL5EY8MD8AF5aRhI0+HHK/Nvn53ZQNoZhIt9TVG
         /KKA==
X-Gm-Message-State: ACrzQf0fuopiFvMpohxLijVve4CpKky242d+lj6RffjEJ0nDzFH9eFd+
        tAQVw6ispFSPcZvhsz1kEx8Cgz0GZLrvmwn8beCxhLqZkJM=
X-Google-Smtp-Source: AMsMyM5DL8ZXb4NXOw/w9IUliVrh2tzqutUSjLu6mZp2gXZkrub5nD9kMv8NYEagECuF7qhownvUQak/fK95hJVzSJ8=
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id
 b18-20020a170902d51200b00181f1f4fcb4mr58068329plg.102.1667936023224; Tue, 08
 Nov 2022 11:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20221108184357.55614-1-shy828301@gmail.com> <20221108184357.55614-2-shy828301@gmail.com>
 <20221108112047.38525702a68029769d4a04f7@linux-foundation.org>
In-Reply-To: <20221108112047.38525702a68029769d4a04f7@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 8 Nov 2022 11:33:30 -0800
Message-ID: <CAHbLzkp2ChkMEFDscOMGRtGGYTYGO1xsCTPDZDOsTFc0qfjvBQ@mail.gmail.com>
Subject: Re: [mm-unstable v3 PATCH 2/3] mm: khugepaged: allow page allocation
 fallback to eligible nodes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     zokeefe@google.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com,
        "Zach O'Keefe" <zokeefe@googel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 11:20 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  8 Nov 2022 10:43:56 -0800 Yang Shi <shy828301@gmail.com> wrote:
>
> > Syzbot reported the below splat:
> >
> > ...
> >
>
> "mm: don't warn if the node is offlined" remains in
> mm-hotfixes-unstable, so I'll just drop it.

Yes, please.

>
> >
> > Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> > Suggested-by: Zach O'Keefe <zokeefe@google.com>
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Reviewed-by: Zach O'Keefe <zokeefe@googel.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> I should add cc:stable, yes?

This problem should just happen with MADV_COLLAPSE, which is merged
for 6.1, so we should not cc to stable.

>
> Are we able to identify a Fixes: target?

Please use this target: 7d8faaf15545 mm/madvise: introduce
MADV_COLLAPSE sync hugepage collapse

>
>
