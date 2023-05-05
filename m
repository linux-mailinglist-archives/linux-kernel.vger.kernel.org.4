Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365F66F852A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjEEPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjEEPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D6D1636E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683298783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBXNgO7aRryOo3aOK63YAEnZA6K4XoikS9SxHfhUh30=;
        b=QtzCy45IgDZNQZYzb5aAhtsJzpt1w4DRe0w8ogiq4NngibLuFnNAXeOV1jsBRHX/y+r3yO
        QzL6AmhFeAhRsb870mKJErVOWCwzNO9y3iQXl58GFjIfjyUWThm41bRdzK6V+fa6u4yf9p
        g0mBlJX8pXvEGdHlCJWTYcNJOshJxsE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-5pvvdzM3OeOBFLMJnNap8Q-1; Fri, 05 May 2023 10:59:42 -0400
X-MC-Unique: 5pvvdzM3OeOBFLMJnNap8Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50bc6c6b9dbso13148739a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 07:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683298781; x=1685890781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBXNgO7aRryOo3aOK63YAEnZA6K4XoikS9SxHfhUh30=;
        b=K2G5TaP5VYZ1toLjEhBcYqv41j6+zwV6tqoHFHwbu/EwJUbKeZVLj5vyhoLLmBrXFK
         IpnOmf1tY+/pghWhtvLIscMOxACWVaZHaekbqgz9l+J8XqMEsHjmouB9UOWjqfDUjqoa
         i4aL9QkfgZ40eVdanPdb9+Tt/QNlayzBVhpcDaJ26ZoCeOfxUvb+OTYqbJPGDp2pChx/
         nFxrTb6G29sQoAYfbSAPyX5yRSOSpyoYZ3wbySYQBbI2oED3p5BVMvVVNmUR8EeCCA8g
         kQbPBJsZLPqsyHQXiDa5KBkuRRBoIb/czvuLS6hsJYPVrReiArhmRJA8jnaQIHQdLyvR
         H9Tg==
X-Gm-Message-State: AC+VfDw/LkalXlNBPQzyjedMF6BDa4cmuH9BsOdeN0Fi+qqsPNAk0fBs
        eJCfUneK1eLod/jJVut+SJj5XRjBcsP3gVbPdx46kh0x+RuODeBgo31xU8s0YyG8hRIgbZ+NcXJ
        3/szyiTgZ+HcZkwgQeH5jTeDa
X-Received: by 2002:aa7:ccc6:0:b0:50b:dfe2:91 with SMTP id y6-20020aa7ccc6000000b0050bdfe20091mr1904397edt.7.1683298781577;
        Fri, 05 May 2023 07:59:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41nBmpMVnXW7PKFZ8ZB30pUuvlx01dx8IxPbfnWfLUCXzpn0UbIn+XfcKAeqyn2xG3hPxzGw==
X-Received: by 2002:aa7:ccc6:0:b0:50b:dfe2:91 with SMTP id y6-20020aa7ccc6000000b0050bdfe20091mr1904374edt.7.1683298781292;
        Fri, 05 May 2023 07:59:41 -0700 (PDT)
Received: from redhat.com ([77.137.193.128])
        by smtp.gmail.com with ESMTPSA id h20-20020aa7c614000000b00501d73cfc86sm3024677edq.9.2023.05.05.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 07:59:40 -0700 (PDT)
Date:   Fri, 5 May 2023 10:59:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     ye xingchen <yexingchen116@gmail.com>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, ye.xingchen@zte.com.cn
Subject: Re: [PATCH] vhost_net: Use fdget() and fdput()
Message-ID: <20230505105811-mutt-send-email-mst@kernel.org>
References: <CACGkMEsmf3PgxmhgRCsPZe7fRWHDXQ=TtYu5Tgx1=_Ymyvi-pA@mail.gmail.com>
 <20230505084155.63839-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505084155.63839-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 04:41:55PM +0800, ye xingchen wrote:
> >>
> >> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> >>
> >> convert the fget()/fput() uses to fdget()/fdput().
> >What's the advantages of this?
> >
> >Thanks
> >>
> >> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> >> ---
> >>  drivers/vhost/net.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index ae2273196b0c..5b3fe4805182 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -1466,17 +1466,17 @@ static struct ptr_ring *get_tap_ptr_ring(struct file *file)
> >>
> >>  static struct socket *get_tap_socket(int fd)
> >>  {
> >> -       struct file *file = fget(fd);
> >> +       struct fd f = fdget(fd);
> >>         struct socket *sock;
> >>
> >> -       if (!file)
> >> +       if (!f.file)
> >>                 return ERR_PTR(-EBADF);
> >> -       sock = tun_get_socket(file);
> >> +       sock = tun_get_socket(f.file);
> >>         if (!IS_ERR(sock))
> >>                 return sock;
> >> -       sock = tap_get_socket(file);
> >> +       sock = tap_get_socket(f.file);
> >>         if (IS_ERR(sock))
> >> -               fput(file);
> >> +               fdput(f);
> >>         return sock;
> >>  }
> >>
> >> --
> >> 2.25.1
> >>
> fdget requires an integer type file descriptor as its parameter, 
> and fget requires a pointer to the file structure as its parameter.

In which kernel?

include/linux/file.h:extern struct file *fget(unsigned int fd);


> By using the fdget function, the socket object, can be quickly 
> obtained from the process's file descriptor table without 
> the need to obtain the file descriptor first before passing it 
> as a parameter to the fget function. This reduces unnecessary 
> operations, improves system efficiency and performance.
> 
> Best Regards
> Ye

