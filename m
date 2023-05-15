Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA9703D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbjEOTNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243213AbjEOTNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:13:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AFD84D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:13:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so19433354a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684178016; x=1686770016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF4yk0ERETjvIb26R/MqCsvUn8YCXMMrsGzNSIduxV4=;
        b=PKWLstv9L4X1CAYERxAzx1iVEmvir5hRNPp1+OFJ6eXsOsHoHPoVVz+sZPaUtfCpR7
         49MEGoAexn7sv0atN4XpnNl9jPndB2XisxmAPP4zY/KRQHC23zfFm1CPhcbVwzJEIsTr
         zuljLflX3oCfHt7+JGMvJAJorFesRMKqi3muQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178016; x=1686770016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF4yk0ERETjvIb26R/MqCsvUn8YCXMMrsGzNSIduxV4=;
        b=T/56HbUfKzvGWDep2SLsW1zEEYsEdyXWjWPonKZKPtp123JsxDCqaWx23H777FtD1O
         PahPI9kSkDsyBixXFfS70iS3kggpNJ7kxYCIFHBm+reIxvTZTD/oYvyPFGMCES1Q+809
         IcMdKOK+GZ6/eQ0FbtfWOCMRg6EbaqWOtLOJ3FyYhM+slSSLB3wJW/DmLwjpnfmm0AT0
         1k22Z6Pu9721Hji8vBD2fS/+CCoxJ+28dRKDpi11uESC88I2mZkOmWG5IOngUTxVgHIc
         Xqcu+5rdxjNHny0NrH+f0WA83twzfkzGLWjxJeE1b6tuqSRO0stW88thyFRsA95xa9sG
         HVaw==
X-Gm-Message-State: AC+VfDwptVgZe+mEoQD3Tbuuj6X/vTZmscy6DBogdc4ZGUG0JiEOK9UY
        TBBg0yuhGx0hJRCY+PVROYTF42j86HCX39BT2ZOQh5Kg
X-Google-Smtp-Source: ACHHUZ68htVE9wcrWTUvWezjn5ZW9eCZyDS5wQdH0/BlEOM9Llx6Klis/bovFLQFFh+dC6qRWaQ9MQ==
X-Received: by 2002:a50:ed0b:0:b0:506:943a:6a5f with SMTP id j11-20020a50ed0b000000b00506943a6a5fmr23516961eds.36.1684178016276;
        Mon, 15 May 2023 12:13:36 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id t21-20020aa7d715000000b0050bc041d2a8sm7296490edq.15.2023.05.15.12.13.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 12:13:35 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so19433295a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:13:35 -0700 (PDT)
X-Received: by 2002:a17:907:6d8e:b0:966:5c04:2c61 with SMTP id
 sb14-20020a1709076d8e00b009665c042c61mr26436664ejc.8.1684178015151; Mon, 15
 May 2023 12:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230420120409.602576-1-vsementsov@yandex-team.ru>
 <14af0872-a7c2-0aab-b21d-189af055f528@yandex-team.ru> <20230515-bekochen-ertrinken-ce677c8d9e6e@brauner>
 <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiRmfEmUWTcVPexUk50Ejgy4NCBE6HP84eckraMRrL6gQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 15 May 2023 12:13:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
Message-ID: <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of O_RDWR
To:     Christian Brauner <brauner@kernel.org>
Cc:     Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 11:50=E2=80=AFAM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> It's strange, because the "O_WRONLY" -> "2" change that changes to a
> magic raw number is right next to changing "(unsigned short) 0x10" to
> "KERNEL_DS", so we're getting *rid* of a magic raw number there.

Oh, no, never mind. I see what is going on.

Back then, "open_namei()" didn't actually take O_RDWR style flags AT ALL.

The O_RDONLY flags are broken, because you cannot say "open with no
permissions", which we used internally. You have

 0 - read-only
 1 - write-only
 2 - read-write

but the internal code actually wants to match that up with the
read-write permission bits (FMODE_READ etc).

And then we've long had a special value for "open for special
accesses" (format etc), which (naturally) was 3.

So then the open code would do

        f->f_flags =3D flag =3D flags;
        f->f_mode =3D (flag+1) & O_ACCMODE;
        if (f->f_mode)
                flag++;

which means that "f_mode" now becomes that FMODE_READ | FMODE_WRITE
mask, and "flag" ends up being a translation from that O_RDWR space
(0/1/2/3) into the FMODE_READ/WRITE space (1/2/3/3, where "special"
required read-write permissions, and 0 was only used for symlinks).

We still have that, although the code looks different.

So back then, "open_namei()" took that FMODE_READ/WRITE flag as an
argument, and the  "O_WRONLY" -> "2" change is actually a bugfix and
makes sense. The O_WRONLY thing was wrong, because it was 1, which
actuall ymeant FMODE_READ.

And back then, we didn't *have* FMODE_READ and FMODE_WRITE.

So just writing it as "2" made sense, even if it was horrible. We
added FMODE_WRITE later, but never fixed up those core file writers.

So that 0.99pl10 commit from 1993 is actually correct, and the bug
happened *later*.

I think the real bug may have been in 2.2.4pre4 (February 16, 1999),
when this happened:

-       dentry =3D open_namei(corefile,O_CREAT | 2 | O_TRUNC | O_NOFOLLOW, =
0600);
...
+       file =3D filp_open(corefile,O_CREAT | 2 | O_TRUNC | O_NOFOLLOW, 060=
0);

without realizing that the "2" in open_namei() should have become a
O_WRONLY for filp_open().

So I think this explains it all.

Very understandable mistake after all.

                    Linus
