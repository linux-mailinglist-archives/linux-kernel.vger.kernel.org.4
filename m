Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47C697F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjBOPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBOPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:32:45 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F543645C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:32:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id fi26so22655537edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MgMa6EJ46w+TjF/u1gN/gW9+ztz/QXzmUwMpKJQYIyo=;
        b=pyNfe8Xn4nvIZUJPkKZ3EaDZhM1x8wWbetMkTtOH0evncRwi4yKGLjXRdzWjQL+CGR
         zUU0rFXSeptYAzExzFvW5+hXf/mgKS+dwLmZL5MjnyEJlezTk5F+xWRqKbGGbiqg9+q9
         EouNtTLiuyHyjSqyEs9gJGIWlHCjyVFL6bBpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgMa6EJ46w+TjF/u1gN/gW9+ztz/QXzmUwMpKJQYIyo=;
        b=CwBH7QbbY0z2NRygZFQnSg/qO1akLz+gy5Nfdrx3hEp+xwnqDb1l1IX4H/2lZGo1gu
         JJlD8VE8Fr2XJgO4zZWgIQ0fTHxnCTLOiPXSBm4DfeSJ1/Rra4C8oZz0d88WOCvMjivc
         h2TtAlrElsKyDmZ4C2yPLG79cUccqCZxhatBk2PpYc7Hog2nM1bOWp3hi2Fc2FPKELcN
         9/iGfjRedfvouM0nClpSp6dgT+J0+/zBTxuhtLNSDn3IkgLCna2z1cUOS54/2aYnjXdH
         eMk3X+iQ3T2fQu2t5DpkOw7fKIuRq8UHAsGEvkOQCsnjMdcYjG/jDEJU6NLy2zAeQ/CV
         sLrQ==
X-Gm-Message-State: AO0yUKVNF+G6WDgKQcwTilZmrHhrggWQEHpGLMQcC5ZXAKD0OJ08XhwF
        tQGIU6TuJuWnIbFV9XUIRzrdhs7TRbdlS8nV/rHvsw==
X-Google-Smtp-Source: AK7set+rq8teOzHKNYBPin6GVDaWwGDfSkNDQLU44vMY19ftzX6MLaAK4DBXIxvqGc9E5ohBKkFVnJp40DgTuL1DMUc=
X-Received: by 2002:a50:ab5a:0:b0:4ac:c453:6d5f with SMTP id
 t26-20020a50ab5a000000b004acc4536d5fmr1332039edc.8.1676475160544; Wed, 15 Feb
 2023 07:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-6-dhowells@redhat.com>
 <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com> <3367219.1676473410@warthog.procyon.org.uk>
In-Reply-To: <3367219.1676473410@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 15 Feb 2023 16:32:29 +0100
Message-ID: <CAJfpegtZXM7mOLbmc+si42iux+7E313QnRryztwT=U3g5Lqirw@mail.gmail.com>
Subject: Re: [PATCH v14 05/17] overlayfs: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 16:04, David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > +       ret = -EINVAL;
> > > +       if (in->f_flags & O_DIRECT &&
> > > +           !(real.file->f_mode & FMODE_CAN_ODIRECT))
> > > +               goto out_fdput;
> >
> > This is unnecessary, as it was already done in ovl_real_fdget() ->
> > ovl_real_fdget_meta() -> ovl_change_flags().
>
> Does that mean ovl_read_iter() and ovl_write_iter() shouldn't be doing it,
> then?

That's a different thing, because ovl_*_iter() are checking on
ki->flags, not f_flags.

Thanks,
Miklos
