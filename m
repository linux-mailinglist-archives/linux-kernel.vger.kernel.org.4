Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D965664DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjAJVVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjAJVU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:20:56 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B4DC6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:20:53 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 16so13167065ybc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84KT4Y38nuS6AqrFyQ10BjxIC1+dkLajEGpo0qupIB0=;
        b=i/6/56Gy833/2gGx1GeT3ZzLw4GAb2tQtNavrOKj4NlxFTVOWLp78X2Ov2cTpKcVsd
         AhtwTb8zNzs1JHuEhffOCDu9/95KApcUGu3AekwtGQU5lfj9CG3KbESeSgmjAxHkGK2C
         wsWa8sg2APavwS+OnGEbWnUI035DrjGNUjMbGquCiDbMaehKCoCiSvJorbDeX8NHhAu3
         FAa4PrPwhQnXLRp9VARVROA2N5OwVsGi865QW3YX/rEGLyaesZe3078I9PnGdlbFLZxR
         oXcS5AtXHOe8J8ptKKiRRWtMzlKUBsoo/PN4j1C+Emlp+1z/gMmS3LICR+7pfoG4970d
         e1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84KT4Y38nuS6AqrFyQ10BjxIC1+dkLajEGpo0qupIB0=;
        b=nwEGI61vMxk/6cEar6VZzuUm2waoDHp7hP53FRJCEusnyO3Lm6zXG6qQfWB/gJ0Fqq
         7iJJ/xk5JH5357gYH7eYPmbXOZhBzCqhtUesNBC/86wtcbJKL5+O6YeX6sePyAMM0hgI
         KFdopqUZuygb2ZwLTc4qb/BK+/TuHYa8cQ8C20b8pedMT/GA3OAc2Vt8jMYrVA8CAOoT
         zxygcZY3yLz64UYIEHAiBx9ihgmMiXOwTmpD0DiELRcKp7bGfq6uey51VMGNQPVkvK3X
         KSI6kThujcvil6BbVK5Keqcws4G0H4xrDMXAAFYJlm2zRMiXhFc2CMn7uD38aETwPIO9
         zXJA==
X-Gm-Message-State: AFqh2koOo6nTDFK/XFxOzPDXr5GPXF9IzZL8LB7JVPvOe1MCuuCS/xc4
        +fCFVe6OM5Y773SUQXmjHut7JJ1Oi/dKVvX8JE7opMT4/WlsDW3h
X-Google-Smtp-Source: AMrXdXtxQf7auE0xRMOWiMXojs73pb+1H3ND26svrQT5CSOEUgrdcb+PU3bWS05ph908nwkFJn3XixWD2o+uI4W6Tzs=
X-Received: by 2002:a25:ac8e:0:b0:7c0:d1d:3193 with SMTP id
 x14-20020a25ac8e000000b007c00d1d3193mr468341ybi.61.1673385653016; Tue, 10 Jan
 2023 13:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com> <20230109213809.418135-4-tjmercier@google.com>
 <20230110014720.281-1-hdanton@sina.com>
In-Reply-To: <20230110014720.281-1-hdanton@sina.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 10 Jan 2023 13:20:42 -0800
Message-ID: <CABdmKX11WP-ijLbU34Y7GG21NtqsCyMVyhnkxMMnL_hG7+TV6g@mail.gmail.com>
Subject: Re: [PATCH 3/4] binder: Add flags to relinquish ownership of fds
To:     Hillf Danton <hdanton@sina.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, Tejun Heo <tj@kernel.org>,
        linux-media@vger.kernel.org
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

On Mon, Jan 9, 2023 at 6:07 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On 9 Jan 2023 21:38:06 +0000 T.J. Mercier <tjmercier@google.com>
> >
> > @@ -2275,6 +2276,26 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
> >               goto err_security;
> >       }
> >
> > +     if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
> > +             struct dma_buf *dmabuf;
> > +
> > +             if (unlikely(!is_dma_buf_file(file))) {
> > +                     binder_user_error(
> > +                             "%d:%d got transaction with XFER_CHARGE for non-dmabuf fd, %d\n",
> > +                             proc->pid, thread->pid, fd);
> > +                     ret = -EINVAL;
> > +                     goto err_dmabuf;
> > +             }
>
> It barely makes sense to expose is_dma_buf_file() only for this.
> > +
> > +             dmabuf = file->private_data;
> > +             ret = dma_buf_transfer_charge(dmabuf, target_proc->tsk);
> > +             if (ret) {
> > +                     pr_warn("%d:%d Unable to transfer DMA-BUF fd charge to %d\n",
> > +                             proc->pid, thread->pid, target_proc->pid);
> > +                     goto err_xfer;
> > +             }
> > +     }
> > +
>
> This whole hunk should go to dma-buf instead by adding change to
> dma_buf_transfer_charge() for instance.

Fair enough, will change this for v2. I think we'd still want to
distinguish between the two failure modes for logging purposes, so
I'll use the return value of dma_buf_transfer_charge to do that.
