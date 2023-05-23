Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C8A70E2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbjEWRfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjEWRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:35:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66741A7
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:35:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so206768a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684863306; x=1687455306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgE8ji/h7CMcJNn0UAt7kbxemzWw21WFjqqu1Nqn77o=;
        b=Vw7AS+AaFz/dbCV0lwHrLUjLV6JjQuZhqzF9BMNaNNjX6Zcflxx+AjQe3+paqQJtxR
         U0AHB5n4d398LhALQubCoAudNTHGd4tDGZ+hWZwuf+vVHZt2kdApH85vUqGhasNFnydw
         U4kljGqf63frbBV5XP9K6nh7prfXd7VOJBaNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863306; x=1687455306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgE8ji/h7CMcJNn0UAt7kbxemzWw21WFjqqu1Nqn77o=;
        b=aA7oUQRvoCdIYrVvdtS9I/wN2zDMMArw9toihJa1U1UEQhi+Wti93OKm7SAtrlnz0e
         OQdjAXqEtj8C5fqhvmdli0ZKF96sITF3wkQ9hAwtmIREQu4oiUMN+aMSsFuPfBnEGxhq
         fvOaW780SlwXjp7E/6zXYARadYVguqM/6i6OkZzjq7xaOKC+3A/hNQJvY/4vwMAs6dyF
         cTsXR7z92HC8cYn0mIFVzmasx+6eMtRZ1k9n0GXT/3Z1GqWEiS/X+uxlvX/WpVeY4NLe
         3bAtUuhMLGxrXxEjQGdANLzantVB/cHsmPpH2C2kzy1cID8p05H8AL89dDp2ZBNTu0gz
         mW4g==
X-Gm-Message-State: AC+VfDzRH4W3mvkAt1+E7x7n3eIU0X7K/B0jALrh9K7gaxfsTy+2eAI9
        cN0aoX9uQ8GT2nA0+XbTizcX/FBBllbjCUVi76jNoemU
X-Google-Smtp-Source: ACHHUZ60wfcaLDuaOwjT319nZmpubsxZGGaFxVyMDZrKc+nfOcJSHiSb4S0QnLSb7H8kfZhnNB90VQ==
X-Received: by 2002:a17:907:843:b0:94e:1764:b09b with SMTP id ww3-20020a170907084300b0094e1764b09bmr13049780ejb.45.1684863305927;
        Tue, 23 May 2023 10:35:05 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067a0100b0096f738bc2f7sm4739689ejo.60.2023.05.23.10.35.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 10:35:05 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-96ff9c0a103so366483666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:35:05 -0700 (PDT)
X-Received: by 2002:a17:907:9443:b0:94f:3b07:a708 with SMTP id
 dl3-20020a170907944300b0094f3b07a708mr15767293ejc.29.1684863304990; Tue, 23
 May 2023 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
 <CAHk-=wjuNDG-nu6eAv1vwPuZp=6FtRpK_izmH7aBkc4Cic-uGQ@mail.gmail.com> <CAH2r5msZ_8q1b4FHKGZVm_gbiMWuYyaF=_Mz1-gsfJPS0ryRsg@mail.gmail.com>
In-Reply-To: <CAH2r5msZ_8q1b4FHKGZVm_gbiMWuYyaF=_Mz1-gsfJPS0ryRsg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 May 2023 10:34:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYTAK4PSK23bDm_urZ49Q=5m=ScYcmK27ZJNKSBPdbgA@mail.gmail.com>
Message-ID: <CAHk-=wjYTAK4PSK23bDm_urZ49Q=5m=ScYcmK27ZJNKSBPdbgA@mail.gmail.com>
Subject: Re: patches to move ksmbd and cifs under new subdirectory
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:39=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> My reason for adding CONFIG_SMB_CLIENT, enabling CONFIG_SMB_CLIENT
> when CONFIG_CIFS was enabled, I was trying to make the Makefile more clea=
r
> (without changing any behavior):

That sounds ok, but I think it should be done separately from the
move. Keep the move as a pure move/rename, not "new things".

Also, when you actually do this cleanup, I think you really should just do

  config SMB
        tristate

  config SMB_CLIENT
        tristate

to declare them, but *not* have that

        default y if CIFS=3Dy || SMB_SERVER=3Dy
        default m if CIFS=3Dm || SMB_SERVER=3Dm

kind of noise anywhere. Not for SMBFS, not for SMB_CLIENT.

Just do

        select SMBFS
        select SMB_CLIENT

in the current CIFS Kconfig entry. And then SMB_SERVER can likewise do

        select SMBFS

and I think it will all automatically do what those much more complex
"default" expressions currently do.

But again - I think this kind of "clean things up" should be entirely
separate from the pure code movement. Don't do new functionality when
moving things, just do the minimal required infrastructure changes to
make things work with the movement.

              Linus
