Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54F715C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjE3LCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjE3LCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:02:40 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D6993;
        Tue, 30 May 2023 04:02:39 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6237faa8677so22225806d6.1;
        Tue, 30 May 2023 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685444558; x=1688036558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qKJRw70btDvw6dzoRPZe1V0n3W0ShFothndLD85zokQ=;
        b=ddbwUXkiE48vFE2zz7Fh1VMI2SkkBKiWtS23kb1YI4nSv4xUWs+Sg5xz0/ycdXsjEp
         oDENZSNXp5erZRt6f2KyTXTxvHMrKcNjdXaKHrZKzQMTP3EN6ZqhJP+vsY8PFHg9ZFlt
         PVJiuE50WxSwHfeprajWksMW0MTA/psTVfTeynP/GufAWpcfH/B+Y726AcHvzTG5jw28
         9Dc08fAC4vXudjSv6+aLOEdHLaJeDcwSvJTV0L20WFENfPnjGxoTFE/xi+WlYylVUxDk
         wVhJ3zjBf564+7o9sdAWXw6YxZ69wGlS0qcSFZ9NQ89s9tHIm5tR2/7KpOdEhqTvHaAj
         yiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444558; x=1688036558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKJRw70btDvw6dzoRPZe1V0n3W0ShFothndLD85zokQ=;
        b=WkFA4ZZqGJ3RuIUxGHgysKCGuU6+Kq3zNrnDo29TYNcjYDf8+vh37DQRFbAKb1FqrF
         aD73xIMZ9Fiy7PsA9BZvbI2XKPsbeyYSiIv2ybTcfUhUbrgSu1Co5BS+3ZTaAC6vr+jP
         AiHzO2xbxf6sAZO24iUGK9GiMDf2TEtLfZEg5eyiaS5KDMGbiP71hip1UNzA6purm26T
         tlmhy9NZklyGhFT7xkHYBqcelKG+7syyalGYdMYmGvFK8UVHwoj74Ou7rBzjIbjc3jFo
         5TGkC1eNtr8AlNJZy9RqlyhPR+n0NlMSRu/qnW6qAEED38tYpikYh+CVH+s0ubVsaM7z
         H6bQ==
X-Gm-Message-State: AC+VfDxjMgaJFSpKM6Lj6kKWDi2HOoy3sWB96b6hsTuIlqad+hypt8th
        LUm+pGOBagDb2VImHWgvXVGj0WFkKniXEvOUXYXH5y95s1BnFA==
X-Google-Smtp-Source: ACHHUZ6V2oyzYSC9B8OgIPn2MIpfB098Yw//lpK0uP02DNwlKin+3aIcnmVspzn0674k6LFbXQu1RHfDfYo4IpheSfk=
X-Received: by 2002:ad4:5baa:0:b0:626:1be5:1777 with SMTP id
 10-20020ad45baa000000b006261be51777mr1296836qvq.52.1685444558153; Tue, 30 May
 2023 04:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160352.19704-1-osmtendev@gmail.com> <87v8gajeni.fsf@kernel.org>
In-Reply-To: <87v8gajeni.fsf@kernel.org>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Tue, 30 May 2023 16:02:27 +0500
Message-ID: <CAK6rUAPUKNREyYL-d5Y23SOV__-zPY8KJL+MMzWX8ShOhDGWLA@mail.gmail.com>
Subject: Re: [PATCH] debugfs.c: Fix error checking for debugfs_create_dir
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, ryder.lee@mediatek.com, lorenzo@kernel.org,
        shayne.chen@mediatek.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I will keep that in mind and send with the right subject while
submitting a revision of the patch.

Regarding the patch after researching more into it I have come to know
that the debugfs
API will not return null on error but an ERR_PTR. The modern wisdom
about it is to ignore the errors returned by the function as stated in
the comment  above the function debugfs_create_file.

> * NOTE: it's expected that most callers should _ignore_ the errors returned
 >* by this function. Other debugfs functions handle the fact that the "dentry"
 >* passed to them could be an error and they don't crash in that case.
> * Drivers should generally work fine even if debugfs fails to init anyway.
Here is the link to comment :-
https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L451

Considering this, I will send the revision of the patch by removing
error checks. Please correct me if  there are any concerns with this.

Thanks,
Osmten

On Tue, 30 May 2023 at 15:29, Kalle Valo <kvalo@kernel.org> wrote:
>
> Osama Muhammad <osmtendev@gmail.com> writes:
>
> > This patch fixes the error checking in debugfs.c in
> > debugfs_create_dir. The correct way to check if an error occurred
> > is using 'IS_ERR' inline function.
> >
> > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
>
> The title is wrong, please see the wiki page below how to create titles.
>
> Also no need to say "This patch fixes..", saying "Fix..." is enough.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
