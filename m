Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94136365D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbiKWQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiKWQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:30:22 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5286221E20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:30:20 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z17so12766935qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vt2TI2s/ONwTSTFJrVl4zFA/mn26DOjDlB7TgOSLANM=;
        b=gelHH9WcdQSeyZW2TipTpvkwMV0+VGmqtodQTG4dG4qWCEMZ0y6SfoZMmBl3+zrMtA
         G363HAcjLxF8bBafLmHrj+o5EFaSR8ugndv1YzyCOG9h8h/aZutl+9Iu1KkfIicqCeTw
         3ibKaXSzagLIYS7cRG0gYCgFmLar08h/dl/q9xNKz0eCjblvOjI4NwN0JvWBdTyMEyss
         0sti78XhZOdFhaBE4JGus6TOalVsifJT0qvMUmOMqAQhxGYsLzOlJGV8RJ//PWOgID+8
         BaafvpBE9mQl4zLXwbaM9JVOIHFSR5iWnBrk4RN+bEimvHWnuAP58PfpjMUBqOrbZ/dj
         6VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vt2TI2s/ONwTSTFJrVl4zFA/mn26DOjDlB7TgOSLANM=;
        b=yI6pQXJSG6JnlnoU5B4qF1QqREztpXzs3td3cqIvvelNmNADGVQTzcewwEtfNXLjPl
         sjiOG3d2/LMG/npem/AEPeqshKkNu4wfpNXDwVH4ykF/hfHMdsk74949UWDAdig4UScy
         RpfWrbIjDzYtja5xTam0F3vV67mXFoDkcebsMtU/34IJv6GxRNEzPmcXwlnTJ2gJxrBn
         NjwgIQ0fNNuhUvhVoRGYpIq9FnfdO1WYI3XC4YIB1UUcveS7KiIgXrSPKokfZyhNz1Wa
         Kh63vyxnKU+NV+kqXVVKTv8G095Jbw0L6l7yL2W6fnwPf/vgVOLpB9dBJcZovsMkK+Mx
         0gmg==
X-Gm-Message-State: ANoB5pm/a487EPfUI7gp/65uwJq1tjOPV1eUD+0LFqhCWrWAF7jLLknS
        S4oyUE89ibf07y6KM78Vejij+g==
X-Google-Smtp-Source: AA0mqf62dokmczKsgWdcoJf2uWNfAwNh6i6+iKFz76k1kXUxub6M2QE9vG8qJF2eIjihESqQ9ABfSA==
X-Received: by 2002:a37:aa81:0:b0:6fa:12a9:b327 with SMTP id t123-20020a37aa81000000b006fa12a9b327mr8788431qke.149.1669221019413;
        Wed, 23 Nov 2022 08:30:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id g10-20020ac8124a000000b00399b73d06f0sm9894595qtj.38.2022.11.23.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 08:30:19 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:30:45 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y35KtVaR/FKNAhKY@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
 <Y3wreqR1IRWFtSUz@google.com>
 <Y30KIbewtg+b5JTq@cmpxchg.org>
 <Y32Yl/Emcw/2a51t@google.com>
 <CAJD7tkZM1KwQpkS5fTaL0A4=VLv=HEWxCc1kd45s49-s4__e1Q@mail.gmail.com>
 <CAJD7tkaWmusZ3V0Jh-zvaW3Ypt5Jn1GvzXryDjy58HSQWW74Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaWmusZ3V0Jh-zvaW3Ypt5Jn1GvzXryDjy58HSQWW74Gg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 12:11:24AM -0800, Yosry Ahmed wrote:
> On Wed, Nov 23, 2022 at 12:02 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > On Tue, Nov 22, 2022 at 7:50 PM Sergey Senozhatsky
> > > There are no accesses to swapped out pages yes, but zspage holds multiple
> > > objects, which are compressed swapped out pages in this particular case.
> > > For example, zspage in class size 176 (bytes) can hold 93 objects per-zspage,
> > > that is 93 compressed swapped out pages. Consider ZS_FULL zspages which
> > > is at the tail of the LRU list. Suppose that we page-faulted 20 times and
> > > read 20 objects from that zspage, IOW zspage has been in use 20 times very
> > > recently, while writeback still considers it to be "not-used" and will
> > > evict it.
> > >
> > > So if this works for you then I'm fine. But we probably, like you suggested,
> > > can document a couple of things here - namely why WRITE access to zspage
> > > counts as "zspage is in use" but READ access to the same zspage does not
> > > count as "zspage is in use".

> Nonetheless, the fact that we refaulted an object in a zspage does not
> necessarily mean that other objects on the same are hotter than
> objects in other zspages IIUC.

Yes.

On allocation, we know that there is at least one hot object in the
page. On refault, the connection between objects in a page is weak.

And it's weaker on zsmalloc than with other backends due to the many
size classes making temporal grouping less likely. So I think you're
quite right, Segey, that a per-class LRU would be more accurate.

It's no-LRU < zspage-LRU < class-LRU < object-LRU.

Like Yosry said, the plan is to implement an object-LRU next as part
of the generalized LRU for zsmalloc, zbud and z3fold.

For now, the zspage LRU is an improvement to no-LRU. Our production
experiments confirmed that.
