Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AABB74E985
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjGKIyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjGKIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:54:37 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2A71FD7;
        Tue, 11 Jul 2023 01:54:11 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-577497ec6c6so58462137b3.2;
        Tue, 11 Jul 2023 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689065651; x=1691657651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NMyJSrXr/UF/wHZuTRsTrpqjvTUJ9zAnuA38jm6aC0=;
        b=NR5Zil1Ut51vJjbGpeM7hQpCxXMNddGz+wEm0nehiE7189z6LR8A7zDNYqWbGpHO7S
         p9vkd8+NZJ71RR3NjCItwdjSin1MNB/xjy6FKCWPM4zaP0K//BbhbkcrUoivsA1v/nX8
         v0XavUEBKL8XSOkJZfC+fjFAEqiDWiG3E1c6MppayGHbXvc8LSXq+M2hIun0UXR6jH8w
         6/EAekCnP6MMi8hz0wNPBQmdwn9pzugm8RVM6Z/+39NKcKgmYBToAdbcAxPPSh1hI60+
         5HLxxsfs3bceRoc2WqeI8NivG2Na0XxSFgG/De2SGnz0sE7WP55hVy06TlB3a1tPuFO5
         3tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689065651; x=1691657651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NMyJSrXr/UF/wHZuTRsTrpqjvTUJ9zAnuA38jm6aC0=;
        b=Z9ZIjJXq3Rbu5Ro0hkiC07J4l8KxByPHALcZ5qgxPSKkre5Xx+qFO8XPiRpVe4/ZiD
         am9T/iIw/cxkW2rtoWaYwwL9Upabz0rdkYJXz3PK+eelVsQuTwD5gnYYhaavRMHvNaM6
         T5NyRXmQ4xREIxeMS+RV4AosURROWX16bhASn5MZ/Cg14GnepAPDyFcXcLehNDJI4ONW
         pE5D3SocX69DDeVtGM/D2yE4iXyw0HMyhqW9bts1g85Gxjjbq92CK4/zW9fH72NMAt5w
         G/K2hXX0A4b9rLTnRrUApmbXklr5WfU0ll8Wjl9xYImZRkdIj2sRqt2BfcojhluzFbgo
         9CmA==
X-Gm-Message-State: ABy/qLaITNnAvl0sGnEdQE/MnaSk2DClOybgGHlmnkC194MZHeu3uv8t
        LQtilSiF3//d46B5/GFXH5wcS9ra+oBpB2hf/Ug=
X-Google-Smtp-Source: APBJJlGKfjsYALosVBg9j0HXxd5FSGneVtTbIkqSExMAGBD1PGWF9szRPXhizWpgt7aYvkVVAzKRE27H36FANlcMR8s=
X-Received: by 2002:a81:e94e:0:b0:577:3ad5:54de with SMTP id
 e14-20020a81e94e000000b005773ad554demr14516198ywm.38.1689065650689; Tue, 11
 Jul 2023 01:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230710094747.943782-1-imagedong@tencent.com> <20230711063125.GA41919@unreal>
In-Reply-To: <20230711063125.GA41919@unreal>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 11 Jul 2023 16:53:59 +0800
Message-ID: <CADxym3YHmKOQ+pL+s6vuyTwE1FZ8D4uaYVcF13OjGrzgrFK=Pw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
To:     Leon Romanovsky <leon@kernel.org>
Cc:     michael.chan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 2:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Jul 10, 2023 at 05:47:47PM +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
> > to clear the unnecessary noise of "kfree_skb" event.
>
> Can you please be more specific in the commit message what "unnecessary
> noise" you reduced?

OK! How about the description like this:

In bnxt_tx_int(), the skb in the tx ring buffer will be freed after the
transmission completes with dev_kfree_skb_any(), which will produce
noise on the tracepoint "skb:kfree_skb":

$ perf record -e skb:kfree_skb -a
$ perf script
         swapper     0 [006]  5072.553459: skb:kfree_skb:
skbaddr=3D0xffff88810ec47700 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [006]  5072.554796: skb:kfree_skb:
skbaddr=3D0xffff8881370348e0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [006]  5072.554806: skb:kfree_skb:
skbaddr=3D0xffff888137035ae0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [010]  5072.605012: skb:kfree_skb:
skbaddr=3D0xffff8881372926e0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [010]  5072.648249: skb:kfree_skb:
skbaddr=3D0xffff8881372916e0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [010]  5072.655732: skb:kfree_skb:
skbaddr=3D0xffff8881372928e0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [010]  5072.697115: skb:kfree_skb:
skbaddr=3D0xffff8881372916e0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [010]  5072.744718: skb:kfree_skb:
skbaddr=3D0xffff8881372928e0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [010]  5072.786947: skb:kfree_skb:
skbaddr=3D0xffff8881372916e0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [010]  5072.838535: skb:kfree_skb:
skbaddr=3D0xffff8881372928e0 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
         swapper     0 [003]  5072.853599: skb:kfree_skb:
skbaddr=3D0xffff888108380500 protocol=3D2048
location=3Ddev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED

Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
to reduce the noise.


Thanks!
Menglong Dong


>
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
