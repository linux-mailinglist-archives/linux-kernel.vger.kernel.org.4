Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C54713A59
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjE1PNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 11:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1PNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 11:13:06 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01077A7;
        Sun, 28 May 2023 08:13:04 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6261a8bbe5fso5352646d6.0;
        Sun, 28 May 2023 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685286784; x=1687878784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YvgNUPTdKFpPQ5giDMpHNmpnkLWBibax0OWyz2QXbcA=;
        b=rWNef71eljSgJNTpHZZvr/0PITs0py2BIsbJu8tDe1yuH49P/VMQvvrKoBPHerk7Qy
         XAc9xMfd7SloXxSYHN4hEgsrXMhv8XftqohBfQSCjmqkF7rAuzgxV9go3oawo5IscCtl
         RoTWqzjnkolv/NxsulfRK+/hdd988kIZ+fkdM6ux5squD9Wp+gxNQMJlmGW0deOST2w0
         WNh07oMtoKtuyNTtdVHGZJm4Tku7ME7uqDHVVUe/NeE4t4Gx1aF9taNihL2BzplcM4R+
         PZT/gbVMcs+D3lbZyIA50K0c1CG+aVyLvN4GUzlSfNAkK/eaR4YTNak0xJ13bJE12kQP
         VkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685286784; x=1687878784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvgNUPTdKFpPQ5giDMpHNmpnkLWBibax0OWyz2QXbcA=;
        b=Pglcl0Ql1sNGoRMtqjrBnjJmXVfzPplGB0OUdimCT5iEs2l1bm9m+A1bgteDAXqLpw
         JmBL+XPwtIhDAbyKSz/vmE6kJnr2LkkIWrwfCMH2VCcu7eqj1HA8ElUyjgIvp6qzsQdA
         hYT0yNMP6jpg2FClZ4LB0T6rlROoxwXpmQFzd8GanE7sVSYwVS57JMAL46aGqh6DfJSY
         7pVOyDuo9a0nPGATe54FGyBfxgdkVWkmDvZbCC9K8g2aRvoTf2SWfXw+KuBunOyDPnuj
         vYmMBWu69U41CQ3iJnB6OxFvl0H7HEREILXqcad87ztvPmXRVVE5qVKkzPzESV9NHJP2
         ispw==
X-Gm-Message-State: AC+VfDyKKk2us2HI6d+zz45hfAAF6U7evyA99ZUSgVdLq7FcHhGfePbs
        D1V7PwXYxGBR5/lS4BEMrL2y1tsxKJdpad3c1BJt6IK5
X-Google-Smtp-Source: ACHHUZ5BDFMR6zRPvR9sdy0ZOJBW8kO+xtM5hS9sIzPBR/TNcGYPGI9XI6+bRVES7IKU07nNnNeWRcbGc8KREcF02dA=
X-Received: by 2002:a05:6214:2487:b0:621:83d:3a47 with SMTP id
 gi7-20020a056214248700b00621083d3a47mr9282949qvb.39.1685286783534; Sun, 28
 May 2023 08:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230524164210.20567-1-osmtendev@gmail.com> <20230526115340.295b1122@sal.lan>
In-Reply-To: <20230526115340.295b1122@sal.lan>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Sun, 28 May 2023 20:12:52 +0500
Message-ID: <CAK6rUAO5PfprdShe3=6gnsUQ2rStpKxYvHcOek7A-CEJvaWO7A@mail.gmail.com>
Subject: Re: [PATCH] smsdvb-debugfs.c: Fix error checking for debugfs_create_file
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After researching more into it I have come to know that the debugfs
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



On Fri, 26 May 2023 at 15:53, Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> Em Wed, 24 May 2023 21:42:10 +0500
> Osama Muhammad <osmtendev@gmail.com> escreveu:
>
> > This patch fixes the error checking in smsdvb-debugfs.c in
> > debugfs_create_file. The correct way to check if an error occurred
> > is using 'IS_ERR_OR_NULL' inline function.
> >
> > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> > ---
> >  drivers/media/common/siano/smsdvb-debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/common/siano/smsdvb-debugfs.c b/drivers/media/common/siano/smsdvb-debugfs.c
> > index 8916bb644756..0f8750d7993c 100644
> > --- a/drivers/media/common/siano/smsdvb-debugfs.c
> > +++ b/drivers/media/common/siano/smsdvb-debugfs.c
> > @@ -469,7 +469,7 @@ int smsdvb_debugfs_create(struct smsdvb_client_t *client)
> >
> >       d = debugfs_create_file("stats", S_IRUGO | S_IWUSR, client->debugfs,
> >                               client, &debugfs_stats_ops);
> > -     if (!d) {
> > +     if (IS_ERR_OR_NULL(d)) {
> >               debugfs_remove(client->debugfs);
> >               return -ENOMEM;
>
> if IS_ERR, it is probably better to return PTR_ERR(d).
>
> So, please change it accordingly, returning -ENOMEM only on NULL, e. g.
> something like (untested):
>
>         if (IS_ERR_OR_NULL(d)) {
>                 debugfs_remove(client->debugfs);
>                 if (!d)
>                         return -ENOMEM;
>                 return PTR_ERR(d);
>         }
>
> Regards,
> Mauro
