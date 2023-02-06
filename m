Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1499668B485
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBFDgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFDgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:36:01 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822DD16323;
        Sun,  5 Feb 2023 19:36:00 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g2so12446110ybk.8;
        Sun, 05 Feb 2023 19:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LGGtA4PNstDo2ZtU+3JdzkWj0NhK3SlJ22hiQduzGTs=;
        b=ddphka7bOXwqefz5YmH4mO90m3oLNPZEjaDZL0p9U+qNVyha4q4GruGlmAevP41Mlk
         ZyxPfP+M0tfhheJ4A5wT6D/mdIyFIc6rYW1J2j1FxoFhlxiXj9ZnjcMIb1xbJu60ntfJ
         Z0spMI/YMK847YUGnCamtsM3acWN3IxtOc1HcYJwHDG/zNJvdEWYd7pEuO8+giZCXTuA
         jvoazFhkpvb51B9/g071zzjdJQUdHK5csj+jZGY+BC2d5yP13vJZNmO3/7r8cKzKn9/h
         L9T9gka8NYgw2twjC7KRWWTxsX2o7PMymarQhfexL8LGh3hZgaT6LUSPiYtZoGbHn6QP
         zhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGGtA4PNstDo2ZtU+3JdzkWj0NhK3SlJ22hiQduzGTs=;
        b=OPkxIP3XGQVSHb7sTa0xOBPUs/Q8vrzqwel3Qz8cvXQ4n4f6JMLqGXdu4mCHCJzCI4
         ywcxFP/dVIWpCV49ECz+xsG+n/oipYkH3+yNSmpGiUb6F5SkYtQKaJUHo+kgjSAb1F3o
         jf9LMsyq/6HKxRYhDkjbgrDDFP06OtfHxifSZ3lpNFyg04ZimpJNzoresnVC4jIoRm9G
         iF0gAFfRE2urJieIdPELG87b97QtENwNYSAh6z5Wj0D7xzekFlnDxrSwvtXQNSRFBHF/
         lWKifcYS73df+v2oPhioZtfUx9IoR9hDYczRNc9U5mmb2LM6oLAKS0taMuzyJqlRaxeN
         jOBg==
X-Gm-Message-State: AO0yUKWu627S4pL400eGJbl99KtRbtjj8B93TRSaQgg9j5BN2DDtqwIK
        R+ImMYKylvUIi5uk7gF71Nv6VbIEBmRb2RvB4Ace0Ny3qpQ=
X-Google-Smtp-Source: AK7set8DrFRnQWTMMC2pkTZ9Dj3WJa94VbSPG24zG+ZoDNiMQW5UInj2b7rsMmmeFeh0TlgvBg+cViyRmDI5oDWE52s=
X-Received: by 2002:a25:8c8a:0:b0:882:4616:654a with SMTP id
 m10-20020a258c8a000000b008824616654amr378587ybl.589.1675654559752; Sun, 05
 Feb 2023 19:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20230203072819.3408-1-zhongjiezhu1@gmail.com> <Y90egBL6HSoEdz2P@rowland.harvard.edu>
In-Reply-To: <Y90egBL6HSoEdz2P@rowland.harvard.edu>
From:   =?UTF-8?B?5pyx5b+g5p2w?= <zhongjiezhu1@gmail.com>
Date:   Mon, 6 Feb 2023 11:33:15 +0800
Message-ID: <CAJnoMhNYDXjfttiio+P7k6W1fDU3N=jbjmZe+ZRVON=bqm0yvw@mail.gmail.com>
Subject: Re: [PATCH] USB: core: hub: fix usb_hub worker blocking
 drain_all_pages() worker issue
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

Yes, this is a very special case.

It will happen only when disconnecting the mass storage if there are
too many files in the storage, and the scanning operation is running,
and the file system is not unmounted.
It looks like this issue should be fixed in the usb mass storage
driver, but I don't find an appropriate place.

On Fri, Feb 3, 2023 at 10:47 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Feb 03, 2023 at 03:28:19PM +0800, Zhu Zhongjie wrote:
> > From: Zhongjie Zhu <zhongjiezhu1@gmail.com>
> >
> > When disconnecting a usb mass storege, if there are a lot of inodes
> > like 10 thousands files need to be freed, the invalidate_inodes() will
> > run for a loog time to freeing all inodes, this will block other worker
> > to run in the cpu, so mark the usb_hub workqueue to WQ_CPU_INTENSIVE to
> > avoid this situation.
>
> Very infrequently this will happen.  In the vast majority of cases, the
> usb_hub workqueue uses very little CPU time.  Marking it
> WQ_CPU_INTENSIVE seems inappropriate.
>
> Alan Stern
