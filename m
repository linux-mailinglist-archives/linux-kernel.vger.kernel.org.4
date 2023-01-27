Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDA867EEB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjA0TqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjA0ToV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61FE7909A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:14 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s67so3885461pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmDDVckbP60b67QFuvxzlip37K6XOtYFQo26wANXj3g=;
        b=S3HghOQMbc29kLHG8ZRVGX9752gyA6Spa3lcoxP2nFGgb+A6ulZSpBTVyNzvy4mWh7
         7hYMn00JdM8fcR8oL+RuSe7aBBeIW/iSOZUArPwW5U7WiVDXo/5zc9msUSJ/lWCslPNZ
         l1uAvJSv7N26TgifuWGmqc2abV311vQKZrbW9kawMsVb/vLUmMnUnp97ePljtUVLz8uP
         hlqBTKX7dT+E8JMuLlzDY3nRUDC2gGNT/WscJOIFP6LF7oW04myl/7gHeHfAusz3f7ED
         yK6vfvOQMgr1EKJaIQrRZugv8Kzew+JnBs1aWx4p54cbPuU7gyRv/uSyxMaybUkdRFZk
         V+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmDDVckbP60b67QFuvxzlip37K6XOtYFQo26wANXj3g=;
        b=7Nzn3KO9FLN9Kh44KEGPRYJIIL6W65x0QULFii4V2FJv7bMd5ksSXii48NWfua692g
         ug3+kbUAfpnrHjyhbGTMcZvMHglYBnKzbKvSuQCpnuESBGHSyb2ZTavXKl8R7m2kts5H
         WNIktzBdsE5xdNhN4lfzF77OPxcW2DpHJpGznYrE/lff7adfjU+oLEJ4Kx4uHXTliqIx
         ia6z1T76z7iGZNpDdbXdLaccCZSojNUqal8NOi6mP+Na0/2SfvZd9aSs4gS2O6aStYzS
         33XT3F5mNvpDcxjSy2BvNv2jOg8mxRHqQ01KirSexqoseT3unjIRFcRv9Qr5AtjHfbJf
         6i1w==
X-Gm-Message-State: AO0yUKVK0GN1vpH2rv+ausdEo9S3jwQd93Addg0029Jaqz/GNWbVdqQv
        6lbuewG1VgWPINcWnqTGQD5Vf2Zm5huVp9EDTWxq
X-Google-Smtp-Source: AK7set/EhaMGlKO8EQNDwR2mglpOAt1yI0o594u65BpZ2HPfyXB4F31hvK5EMUvVABTiD6vdFZYnbGsRfqP9gGXCn7k=
X-Received: by 2002:a62:8e0a:0:b0:592:a8af:4ffc with SMTP id
 k10-20020a628e0a000000b00592a8af4ffcmr479150pfe.52.1674848551078; Fri, 27 Jan
 2023 11:42:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674682056.git.rgb@redhat.com> <da695bf4-bd9b-a03d-3fbc-686724a7b602@kernel.dk>
In-Reply-To: <da695bf4-bd9b-a03d-3fbc-686724a7b602@kernel.dk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Jan 2023 14:42:19 -0500
Message-ID: <CAHC9VhSRbay5bEUMJngpj+6Ss=WLeRoyJaNNMip+TyTkTJ6=Lg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] two suggested iouring op audit updates
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Stefan Roesch <shr@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 12:40 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 1/27/23 10:23=E2=80=AFAM, Richard Guy Briggs wrote:
> > A couple of updates to the iouring ops audit bypass selections suggeste=
d in
> > consultation with Steve Grubb.
> >
> > Richard Guy Briggs (2):
> >   io_uring,audit: audit IORING_OP_FADVISE but not IORING_OP_MADVISE
> >   io_uring,audit: do not log IORING_OP_*GETXATTR
> >
> >  io_uring/opdef.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Look fine to me - we should probably add stable to both of them, just
> to keep things consistent across releases. I can queue them up for 6.3.

Please hold off until I've had a chance to look them over ...

--=20
paul-moore.com
