Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC7669B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjAMO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAMO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:57:48 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE992349
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:44:40 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v19so16702247ybv.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OHw3k7LrErv7fYTTvWXg9NIs8GnGGGZAXtd7K+9HpQU=;
        b=Rp/Ifn8dxC3xWcv7T/XAUSYC3w6fwjT7YZBN1n8xB8xc35lZXvJY8wiXxPs/E4lonQ
         AS0UF5r2S6NAJ7CIkUHFbEI6PRapCsqSaZP8VbmGpNMhQ3K/5vgmzUsWTgbIxnXqIcYl
         5HMibKhwjEpXyi8gMC4tbDjNvpn0E6ksclTRl1XTVUnJT3RjnD2Q9zdF54XH7N1ISKhJ
         u8+US36xvpOzgb55RMzrfs8Kr4CLEQBpvvlHImCoDB2z7hcTSiIq1C6qAATmT2a5QQur
         GRtn2wbLmDg871HQh2yLsEUL0NAEM9M0HErF2SMKXCNI1UtNI/dRUAb2zGeOQw/NNrfG
         IrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHw3k7LrErv7fYTTvWXg9NIs8GnGGGZAXtd7K+9HpQU=;
        b=SnF9lheEhrc/1jqz/PeZQ0Wr1yLjdzIVbcCVUhlemWsSSJ5M1wResC1Q9MvG1THxB0
         yUHO/iKWQQCKOELN7PriuAWZFskBqbT5deQRQGSJw9MTIxx+MkIn5+zn4Yo96aDeZ+Sc
         I7s0DDCQWkPL90wvWMJQEQYlBXbCwS6ba3T9JqqDHExy97/2VH7VW3Ur7wtKGK4Cz++F
         HP9YKIvFhIEZm3QB6IDBU7pO5qmBB5vzUKUsWcCW5fEugckz+j2x6qQi1g1TGMQcClTT
         QybYEl8GXNVYL92aM1iToWJI6PqRClEty9+LbM6JLU1IkH2y0AgO+OfZULTk+hCY7mW/
         Sjwg==
X-Gm-Message-State: AFqh2ko6eQd/3vYI1l41ZXLMJXJlyFoEnCa0XpcU9UkMfe5TNjjz6xCE
        G5Zh+3ACDOMZbBYX8H24dCXm/MoatCYUjitF64zxxw==
X-Google-Smtp-Source: AMrXdXs665I27NS//jndHFdQEwk95kthSZVJdVhRJXzUHYLy+us2ns+UsPdUj637qQNawIbhigf/dGpBqGrDFDbjDe8=
X-Received: by 2002:a25:2d3:0:b0:7c2:d9f1:3b06 with SMTP id
 202-20020a2502d3000000b007c2d9f13b06mr1037342ybc.571.1673621079856; Fri, 13
 Jan 2023 06:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20230112153348.3202173-1-pasha.tatashin@soleen.com> <20230112132957.6cb97c2afad17cdeb06fcd10@linux-foundation.org>
In-Reply-To: <20230112132957.6cb97c2afad17cdeb06fcd10@linux-foundation.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 13 Jan 2023 09:44:02 -0500
Message-ID: <CA+CK2bB1TqWnafpfio6QQo5ifx54vyk+RVMxsVJr6pD+KAOVqA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/page_ext: Do not allocate space for page_ext->flags
 if not needed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, vbabka@suse.cz, david@redhat.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 4:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 12 Jan 2023 15:33:48 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > There is 8 byte page_ext->flags field allocated per page whenever
> > CONFIG_PAGE_EXTENSION is enabled. However, not every user of page_ext
> > uses flags. Therefore, check whether flags is needed at least by one
> > user and if so allocate space for it.
> >
> > For example when page_table_check is enabled, on a machine with 128G
> > of memory before the fix:
> >
> > [    2.244288] allocated 536870912 bytes of page_ext
> > after the fix:
> > [    2.160154] allocated 268435456 bytes of page_ext
> >
>
> Looks nice.

Hi Andrew,

Thanks for looking at this patch.

>
> Does it work correctly with early_page_ext=1?

Yes, early_page_ext=1 moves page_ext_init() earlier, and disables
deferred page initialization, but that is not an issue for the changes
in this patch.

>
> > --- a/include/linux/page_ext.h
> > +++ b/include/linux/page_ext.h
> > @@ -12,10 +12,14 @@ struct page_ext_operations {
> >       size_t size;
> >       bool (*need)(void);
> >       void (*init)(void);
> > +     bool using_shared_ext_flags;
> >  };
>
> Seems overly complicated.  Can we change the three early-init
> functions such as setup_early_page_ext() to simply set some global bool
> flag?

We can't because , in the following loop:

       for (i = 0; i < entries; i++) {
               if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {
                       page_ext_ops[i]->offset = page_ext_size;

page_ext_size must already either include or not the space for the
shared flag field.

>
> >  #endif
> >  };
> >
> > -unsigned long page_ext_size = sizeof(struct page_ext);
> > +unsigned long page_ext_size;
> >
> >  static unsigned long total_usage;
> >  static struct page_ext *lookup_page_ext(const struct page *page);
> > @@ -105,6 +106,15 @@ static bool __init invoke_need_callbacks(void)
> >       int entries = ARRAY_SIZE(page_ext_ops);
> >       bool need = false;
> >
> > +     for (i = 0; i < entries; i++) {
> > +             if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {
>
> I don't think this (or the below) need to check for ->need==NULL?

Good point, I will remove the check, and also update the comment that
the "need" function must be defined for every item in the page_ext_ops
array.

Thanks,
Pasha
