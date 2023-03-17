Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6816BE1B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCQHBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCQHBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:01:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55B51C9B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:01:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so16739006edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679036482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnD4uVazU5UI/twgsfCrpZTZ1d0CsIZe3nQQw6rvhvA=;
        b=V02mjA1XkhWoG5uNrSgtRxq2W8NsVwcGOHMMBwLlznHRP0IZBUNO2LZiSGJYAUi/OK
         xPAWNu+muzYnhg73kEXy7+akPBaSu1zB1286hIaEOm8xQSbxpPfO5dKJk4srOHPta3Ry
         r1gWyLRVcsiqvkBXT78/rsCuHdSFFGAUEJqX9+AgHB5n+bkM1W+JTYWquPa5baMBAoiH
         iXT2eoZlkNev/yjXHWmLc0q28CXddUMQdt9cn/G5bz8gI7uGk33fMnpCgbYF5WwDwhej
         OrmR0eFrmeOq2daXEXLUbK+Y4yjjRmSTI7omfj87DAVZxUa6+5TGivy3q/eEa2bGCvkF
         kyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679036482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnD4uVazU5UI/twgsfCrpZTZ1d0CsIZe3nQQw6rvhvA=;
        b=NrGFgDSvZHNGsD3J7JRcK95OiFX9+7uWppBcogbP3qqK0jQdVluwns8EP+EBvAm8XZ
         zhVdSA5L1FaS6nPSk4mh10ycdqh2HjoKiQ97QYEaLXmWHURPKRweTDdjDvbZBKr6IhHC
         Y1JKUIOKeMpHo1vDO1dHBmkNYYfX2miug+f+EQ1LvCox90BsZwGzivm37RN+7d2TQerf
         w3g5oYzIif/RuEwtfdcWK5sK0HLGk9xi14vWWqJR9aBI6FLtQjCm6JSRP2OgEeZIWwbh
         v0MqA6UeAkQWkhiF1x8391VkTYeK2qfGv/ewOXIQgoPCDHLVH784t4Ked8bBP6bgNLdW
         XYXQ==
X-Gm-Message-State: AO0yUKVOwOMmVee2ZDyioGARI47bgaEs5bdO2tZGsCYW5kXtg9TCvzVu
        VUbPa1SMnbeU/Gl6NVA/g8ZP9GcGIBNx//ZepKV9wVZef7xz2Bo=
X-Google-Smtp-Source: AK7set+s6t+fxNrqLDFwecdgV7ggGi7lUeTtTn7IdzuhbzDeLiMKX1fWvr9f1xy5DksNOwc8QNiV/T/FsVOTL0O8P34=
X-Received: by 2002:a17:906:fb9a:b0:92a:581:ac49 with SMTP id
 lr26-20020a170906fb9a00b0092a0581ac49mr6700012ejb.3.1679036481988; Fri, 17
 Mar 2023 00:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-10-xieyongji@bytedance.com>
 <CACGkMEsaeAJbTzx0M3DJzt=dwWyWvX79L1tapfZ1O-AKyG73Mw@mail.gmail.com>
In-Reply-To: <CACGkMEsaeAJbTzx0M3DJzt=dwWyWvX79L1tapfZ1O-AKyG73Mw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 17 Mar 2023 15:01:11 +0800
Message-ID: <CACycT3vqdfm2KpF+JD_8oZouGfeK1nPc004isnNBUzXkVwSWww@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] vduse: Signal interrupt's eventfd directly in
 vhost-vdpa case
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 5:31=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Feb 28, 2023 at 5:42=E2=80=AFPM Xie Yongji <xieyongji@bytedance.c=
om> wrote:
> >
> > Now the vdpa callback will associate an eventfd in
> > vhost-vdpa case.
>
> I'd suggest avoiding mentioning drivers since vDPA parents should not
> know which vDPA driver is bound.
>
> We could say "signal vq trigger eventfd directly if possible"?
>

It makes sense to me.

Thanks,
Yongji
