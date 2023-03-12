Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B8E6B63DA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCLIbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 04:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCLIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 04:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF7C4FA94
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 00:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678609820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTJUAFMiKw9YXPlS9lywYBNgOfv1YiKLGXLNoVp00UQ=;
        b=bgDzcsI60TIDbJ0Y3Gbw4FyR17xVSmXjgOn7F61iA5kI2GlF0OYPWdp0W8IS52oj9r+9vs
        loP7ttvl+B3xfm1kHo4FlByPFOhNVC/A+HFW6Snzv/7+eji/Va+eLRXgcXagOWxCQSPiem
        WiuaaQCrMEUFLhJlL+qECdyPtSAo0uI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-p4gt3dtSOKyNLtd0XRrs6A-1; Sun, 12 Mar 2023 04:30:18 -0400
X-MC-Unique: p4gt3dtSOKyNLtd0XRrs6A-1
Received: by mail-ua1-f70.google.com with SMTP id n17-20020ab06031000000b0074a59cbc523so843580ual.22
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678609818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTJUAFMiKw9YXPlS9lywYBNgOfv1YiKLGXLNoVp00UQ=;
        b=p45uvt9Dl2wqlzNcH3s9L85wMgs8+VBjXlFFanU5bGJHLpiakT+3yJ/o5dCkjVHcJF
         HXp0wTwemQJNs4PmRusYaWOh7fXUaCrz10Q3rOSGtcXk9rVNeo2Ks3KKGoJwUdldauke
         jL1tFUV5d8Ii+rn52zYKpM2BaQJjGAx8VQjuHfowq/Cq1RQLlMVF/LJgyTw1knnCHV18
         PzUBEvYB1/t//LkOlU8WY4i0jW571esgdsTs+uhZuM2aV60gIGz+vwXBLuGS+mrIvSlN
         XuB44UIgSrwlNCb5ZKCUyakFRrb9J8XBfGO1ZmHsif/pp9i98eddJenL52hNGm5766Gh
         gTrw==
X-Gm-Message-State: AO0yUKWeNY99EWhb+N2ffmVXNvG4k6HuhpsXJLQ3XiW7WQa5anzPx8rX
        Ob+rp0DA+Nb1sA0z1wkvT6w87Yz8OwXxjuVF5i+LEzIEhRfSSU3rOFzGYOs+2BvndE9cNUfZ0P9
        fdT+xfp1AJYrkkfoGlbV27GkHYi7zRhWBv4aDimgT
X-Received: by 2002:a1f:5081:0:b0:418:4529:a308 with SMTP id e123-20020a1f5081000000b004184529a308mr18819941vkb.3.1678609818161;
        Sun, 12 Mar 2023 00:30:18 -0800 (PST)
X-Google-Smtp-Source: AK7set/XxiUHqj7uZm7+uQmpQQmAFDztF4XwTwbAWzfBXxoaAKYWNuNGHKx1WneKNKQ2hYsmxYfu0s630gn5HA+5VLg=
X-Received: by 2002:a1f:5081:0:b0:418:4529:a308 with SMTP id
 e123-20020a1f5081000000b004184529a308mr18819935vkb.3.1678609817771; Sun, 12
 Mar 2023 00:30:17 -0800 (PST)
MIME-Version: 1.0
References: <Y8lSYBU9q5fjs7jS@T590> <ZAyAdwWdw0I034IZ@pc220518.home.grep.be>
In-Reply-To: <ZAyAdwWdw0I034IZ@pc220518.home.grep.be>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Sun, 12 Mar 2023 16:30:06 +0800
Message-ID: <CAFj5m9KM1xbwPobvEYBmgotrU8s2jBQGcSQafJVJM+iQMS0pjA@mail.gmail.com>
Subject: Re: ublk-nbd: ublk-nbd is avaialbe
To:     Wouter Verhelst <w@uter.be>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 9:58=E2=80=AFPM Wouter Verhelst <w@uter.be> wrote:
>
> Hi,
>
> On Thu, Jan 19, 2023 at 10:23:28PM +0800, Ming Lei wrote:
> > The handshake implementation is borrowed from nbd project[2], so
> > basically ublk-nbd just adds new code for implementing transmission
> > phase, and it can be thought as moving linux block nbd driver into
> > userspace.
> [...]
> > Any comments are welcome!
>
> I see you copied nbd-client.c and modified it, but removed all the
> author information from it (including mine).
>
> Please don't do that. nbd-client is not public domain, it is GPLv2,
> which means you need to keep copyright statements around somewhere. You
> can move them into an AUTHORS file or some such if you prefer, but you
> can't just remove them blindly.

Thanks for finding it, and it must be one accident, and I will add the
author info
back soon.

thanks,

