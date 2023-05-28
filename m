Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A171380A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjE1G36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 02:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1G35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 02:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE04C9
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685255350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1z1TCz2XlwxREEQEluVbhG7+rqICZNvx0IHizhIGLQ=;
        b=IJdVF9WkrsGGGk9je/z7heM6Jk1tLcDMmTE/qTlGN0PSKSMhI5kgQ1Se4PfggruC/8W/gi
        OL+se4RwbEnjIvJFgzq9/WJ6k+lrDBDL4PiTzJnlSHcO8BvfRYtgFVOF97jOkekH+zPIpc
        RsJ9MNCRIRuC7+gkRc5UWwi34GnglXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-sVyNE-6oOlOgwLMWjQ12zA-1; Sun, 28 May 2023 02:29:08 -0400
X-MC-Unique: sVyNE-6oOlOgwLMWjQ12zA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7005d4a85so540115e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685255347; x=1687847347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1z1TCz2XlwxREEQEluVbhG7+rqICZNvx0IHizhIGLQ=;
        b=fCsir0mJmbKrLbj9KQv5MX8KNIun6JtnvLHp1ou4Ur4LGtgiGtO9L6Px9qG9gi0Itp
         ascSIOlhog8mfv6cA5TTU/qr1A1HLUwzhJdLj9qNZWgzosGBMU4Dm+xQNAmR3vqi3DYT
         dun3igOpSGyY28g+2ydLL2gSV5PG/+jptd6pt833UliHjVA/EhNayWg70ONxsPPscszb
         N+LylmA31rNObTNkJ6FEHbT8V4UxTFJ7elIdriU4uZAxH42azGc5m/7yIZc9M9Yn5URZ
         NL9yqnmnSmazItsKoZ7LsX1T9fCyk7SJt0rKp+R1MU1aVwUp119NKNZsGlMjM3oL46o3
         Xa7A==
X-Gm-Message-State: AC+VfDz+U02m/KXyZEf9Kp30G/EGcNq3OjIuUJxgW2YbF3Iq6jgQ82qY
        5IQGfavLipXlteBZTTShbOVSFbQCu/Wpn2KmjsWxHmINQXuS2ePE3gg4ugZZ6uSql4uQXvPrXDd
        mTS3lek5pAaJoQar/AGIXfSkL
X-Received: by 2002:a7b:cc95:0:b0:3f5:1a4:a08d with SMTP id p21-20020a7bcc95000000b003f501a4a08dmr7162223wma.7.1685255347700;
        Sat, 27 May 2023 23:29:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oMIRa2O5snnR2DBaZbn6UNByaPav76lWPUnAJoPlC/LhnJ393xJpdpLpMJQpzMKIgXPhbhw==
X-Received: by 2002:a7b:cc95:0:b0:3f5:1a4:a08d with SMTP id p21-20020a7bcc95000000b003f501a4a08dmr7162208wma.7.1685255347442;
        Sat, 27 May 2023 23:29:07 -0700 (PDT)
Received: from redhat.com ([2.52.146.27])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f602e2b653sm13856777wmk.28.2023.05.27.23.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 23:29:06 -0700 (PDT)
Date:   Sun, 28 May 2023 02:29:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Liang Chen <liangchen.linux@gmail.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        pabeni@redhat.com, alexander.duyck@gmail.com
Subject: Re: [PATCH net-next 1/5] virtio_net: Fix an unsafe reference to the
 page chain
Message-ID: <20230528022737-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuUTNfHXQPg29eUZFnVBRJEmjjKN4Jmr3=Qnkgjj0B9PQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 02:38:54PM +0800, Jason Wang wrote:
> On Fri, May 26, 2023 at 1:46 PM Liang Chen <liangchen.linux@gmail.com> wrote:
> >
> > "private" of buffer page is currently used for big mode to chain pages.
> > But in mergeable mode, that offset of page could mean something else,
> > e.g. when page_pool page is used instead. So excluding mergeable mode to
> > avoid such a problem.
> 
> If this issue happens only in the case of page_pool, it would be
> better to squash it there.
> 
> Thanks


This is a tiny patch so I don't care. Generally it's ok
to first rework code then change functionality.
in this case what Jason says os right especially because
you then do not need to explain that current code is ok.

> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 5a7f7a76b920..c5dca0d92e64 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -497,7 +497,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> >                         return NULL;
> >
> >                 page = (struct page *)page->private;
> > -               if (page)
> > +               if (!vi->mergeable_rx_bufs && page)
> >                         give_pages(rq, page);
> >                 goto ok;
> >         }
> > --
> > 2.31.1
> >

