Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C018C70C452
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjEVRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjEVRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:33:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ABFFA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:33:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1209295566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684776829; x=1687368829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slu3gux4GuUHwh68X0h4hh6LgeEzWMQzZomXLQPnCh0=;
        b=Ljg4LOy0fHrVHwQrC6CFPRl2RBlB71H4nfxmtrAN37UAHfFvzivakgEuSCbqDA1N+4
         i9+SneFGnaWeVgwnYb9dbnOzwq8hgg370KB87G8X/9Pg+cm8yutJsa3CPJ4QGUp1mYpD
         A3AKz+Vz4rkoke6nYDDwagdl3BNnF6xBH56y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684776829; x=1687368829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slu3gux4GuUHwh68X0h4hh6LgeEzWMQzZomXLQPnCh0=;
        b=WEXZi+lcKpPca9bD2WkbEcyP7TRT+5uhGoUXssqvoXE3JuT7CuBXTM7CfWI2mVHrpk
         D6IMEcLb936zQmEYiTzblr5g3Dg5wpJae1uxMHHNPXT0XGLCmI9Mg7bG37UO1Yl++TWo
         MseT+R8vqkCiuG6jNEl8SJwApsC6bOI3w4BbhHEXvNNYgZotSXtkH6l1Qwm4drBIAKzV
         on+9fncQxJm18Ifccwjkn/JMWUf3GT84mPl7dfjPtu5cpa72qOfRamD1Vvp/Qlm5J7CP
         /hwhkHTZepmKNoWq6kV22GeFNL/QDP/j65Nn5oqw9hbxOsm+43vyP4elVWBHAS2kkpoM
         dkXA==
X-Gm-Message-State: AC+VfDz6nUNex91yE2bdGz3H6KqoHfnVyMBdktLESlF+wYpGOuu6JAxT
        4eq8y/EKr/ndx9FQhmPKVFXI+jvCnO9m8ngqVWRkCA==
X-Google-Smtp-Source: ACHHUZ7zjUFw1N2RstRukOe18gPtitjabjc7dIZ1z4Srw8hn6tu87K6DsZ9OSf2pR22uzp9Ybx1kQw==
X-Received: by 2002:a17:907:3da8:b0:96a:4ea0:a1e8 with SMTP id he40-20020a1709073da800b0096a4ea0a1e8mr11951690ejc.47.1684776829248;
        Mon, 22 May 2023 10:33:49 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id mb26-20020a170906eb1a00b0096b20c968afsm3352906ejb.124.2023.05.22.10.33.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 10:33:48 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-510e682795fso9109494a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:33:48 -0700 (PDT)
X-Received: by 2002:a17:907:2d23:b0:96a:928c:d382 with SMTP id
 gs35-20020a1709072d2300b0096a928cd382mr11676946ejc.48.1684776828268; Mon, 22
 May 2023 10:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
In-Reply-To: <CAH2r5msVBGuRbv2tEuZWLR6_pSNNaoeihx=CjvgZ7NxwCNqZvA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 10:33:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuNDG-nu6eAv1vwPuZp=6FtRpK_izmH7aBkc4Cic-uGQ@mail.gmail.com>
Message-ID: <CAHk-=wjuNDG-nu6eAv1vwPuZp=6FtRpK_izmH7aBkc4Cic-uGQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 9:33=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> Following up on the email thread suggestion to move fs/ksmbd and
> fs/cifs and fs/smbfs_common all under a common directory fs/smb, here
> is an updated patchset for that (added one small patch).

Looks fine to me.

I wouldn't have noticed the typo that Tom Talpey mentioned (misspelled
"common" in the commit message of the first patch), and that
SMB_CLIENT config variable is odd.

I'm actually surprised that Kconfig didn't complain about the

        select SMB_CLIENT

when there is no actual declaration of that Kconfig variable, just a random=
 use.

That thing seems confusing and confused, and isn't related to the
renaming, so please drop the new random SMB_CLIENT config variable. If
you want to introduce a new Kconfig variable later for some reason,
that's fine, but please don't mix those kinds of changes up with pure
renames..

                Linus
