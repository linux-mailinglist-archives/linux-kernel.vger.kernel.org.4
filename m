Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9090174DD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGJSG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:06:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DDDAB;
        Mon, 10 Jul 2023 11:06:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579de633419so54733997b3.3;
        Mon, 10 Jul 2023 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689012416; x=1691604416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dThlKftpvb1E4fm1zDxlvj7BacTYHr5aY/low3oUN7s=;
        b=h4r2LsVLGXGvJLgAVbXBSZx6sxAfUNEQUFHN6gb3Tm9FYLDCLT0LPJAZx8OvP/UrL6
         bYrhk8iIX8SIaYVdFbeDCOXVPOfLC590huH4ZvKULlMi2fUXAb+I1gUdkhRrzryK63yU
         qpjJBAMm9gNCBb0uKXKj492XG7b5k1l9bnjsfNYY9id9XudCpkVgn4QI7u0Fbm2VcaMh
         zm3xD3J2+EbJaJ5olgi2vAc1Z15HMNROcPLm2eQ+jJi4FEiMOv/0poxXgFrC3nDBcsGC
         sLAjYK2qEZK5XzZcY8MKEYmmKJRU8dUsyAciozzxhpWDPHqSfO0KJ5c8liwucy7Us1cS
         IEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012416; x=1691604416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dThlKftpvb1E4fm1zDxlvj7BacTYHr5aY/low3oUN7s=;
        b=mAPrHFAEOU4l5oFOMAWTxS7ASyPuANQCattdQoeoQNEy64N+FZH0hhVmBlllzfvKqW
         9Wq6gGvIQsG6p+ofUeWOXYxnkAYcU1NH0ZKtxDBtbOFMJHkxc6P667nWVQk1VWZnt65r
         4p1lwJ+Er4F1yNZutBNmsi25Aj8bwzqaTC4nDol7ynjCJHp1ck+BtRr1qcGnOLYIpEYg
         z2jYXjwAUZ0T2EsB9dCIgYWi1qX2M6OfQiQAKWq3jDE3CUrkuaN7b+GoXeMHqG1cRlGv
         HYW56yZ09YFzZRv8kDFjEQQ2rkIvWmPBFMqCKETXeEt21JCY5goe7p4i2KKy5j3Gm6YZ
         hynw==
X-Gm-Message-State: ABy/qLb3KAB00J9EVwxsOysWYJI355IU/ZwGna/+2sKLsgtrU4tGnyrH
        TLHj9rkYuTOXsFKCMmhSuWNOGHCX15ZIfb7CuL4=
X-Google-Smtp-Source: APBJJlFGJ5dZVRcq9niZYmjvnH3Oc0k/JrqHNwcDPUNYkWASYZhPrQEKIKCLju2F3cOaIpM99PAJ2FMxYyii7DmD0lI=
X-Received: by 2002:a81:4e0b:0:b0:577:373b:b18c with SMTP id
 c11-20020a814e0b000000b00577373bb18cmr12334205ywb.38.1689012416282; Mon, 10
 Jul 2023 11:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230703180528.3709258-1-azeemshaikh38@gmail.com> <ad25bb8552704028860cf7a419c54fa3@AcuMS.aculab.com>
In-Reply-To: <ad25bb8552704028860cf7a419c54fa3@AcuMS.aculab.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Mon, 10 Jul 2023 14:06:44 -0400
Message-ID: <CADmuW3XOcGDBszYw80Dy03DXk3T25k8FNUrJWLKU9tL2znzanw@mail.gmail.com>
Subject: Re: [PATCH] kobject: Replace strlcpy with strscpy
To:     David Laight <David.Laight@aculab.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 9:13=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> >       int len;
> >
> > -     len =3D strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
> > -     if (len >=3D buffer_size) {
> > +     len =3D strscpy(&env->buf[env->buflen], subsystem, buffer_size);
> > +     if (len < 0) {
> >               pr_warn("init_uevent_argv: buffer size of %d too small, n=
eeded %d\n",
> >                       buffer_size, len);
> >               return -ENOMEM;
>
> The size in the error message is now wrong.

Thanks for catching this.

> It has to be said that mostly all the strings that get copied
> in the kernel are '\0' terminated - so maybe it is all moot.
> OTOH printing (at least some of) the string that didn't fit
> is a lot more useful than its length.

How about printing out strlen(subsystem) along with the entire value
of @subsystem? So that the warn reads:

pr_warn("init_uevent_argv: buffer size of %d too small for %s, needed
%d\n", buffer_size, subsystem, strlen(subsystem));

Does that seem better?
