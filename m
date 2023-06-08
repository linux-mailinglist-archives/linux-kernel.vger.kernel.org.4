Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B17275FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjFHENV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFHENS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:13:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065F2126
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:13:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7359a3b78so42405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 21:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686197596; x=1688789596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/XsvCUj2CGrnP0CPZnWpYzQ9jaGyy1138TlKWc5IUo=;
        b=jkCSDGce0KUakB/kj5ENqEhkCdst3QS2xlq7D77TmnaWH+BBB9wZlRkiB8Bs5gIRky
         CWRXNXxEpcEtmcT5kKmPHLMhdJ0rcCadMzNJwyP908+NpHa5f63LRHXAdVmTRiqeqGkA
         uda1KkWA1OQjhU7CRX4JcehtGqkq6Nd/gND4OBYAKJ0Z7FLZBKdTUuLfE4+2D/MsRN1y
         ktXBhAWBc7AU5TUPfVmlWouTEpWIWwpyjnp4MfIZyrgkf9/uBPR6y2bjFqTyyC6BExEw
         cWUG6dtKobtz0gxX0gmbLj7gC0yYyu392qdy2st3Dl+HQQSG1xXWGi+G1DRZv9NNnVcD
         zV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686197596; x=1688789596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/XsvCUj2CGrnP0CPZnWpYzQ9jaGyy1138TlKWc5IUo=;
        b=Vuah5jbk1cRkvMk9uyzeBSOPVVGYVu7MA8s0zHKhR+F8Ipz6JFi1OGaRdJUbjmp+8q
         ni5EXi0gcVwywTPs9wjqD9iuMYqsa2KsQaUKFTLrDk/vgwwgCVKCf0OAm3hMHZuJdYnI
         JwMtOXWoI8eVeRsMgCanUcXo/DrNesC3EhPrN14mJe2IfvOFFGzDtPWn9/dH0ubY5uek
         X36d6yOYP2DxyNr30Sb2nda/AfODuOA+g2hpIqLOjgXs/gLTmuL54lPfauN2iQ5/0g7V
         dxjVtQ4qh3md1JqdE7Bcga/yBikgNqVu1NOvVio46UdKRNKiKbwL3J5VWlgl4TPNtmAv
         HdzA==
X-Gm-Message-State: AC+VfDx8d21vAqneGYQsZW/TpatqMuG600PkOVqlRajbG7yGQQLBtnOd
        ZFTGe3nJDiblOe/tMNHQBIQZ4pO2UWzrSJeDeIDNWQ==
X-Google-Smtp-Source: ACHHUZ6k8imAYQmKwTPa6Xs32DDV0hLLo0bc60B3U2S0TtnZtIXDaHejOPQ+g+4NMelhPLTHuquY8WFM7uPYJN8c3Q4=
X-Received: by 2002:a7b:ca47:0:b0:3f1:73b8:b5fe with SMTP id
 m7-20020a7bca47000000b003f173b8b5femr94249wml.3.1686197596051; Wed, 07 Jun
 2023 21:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230606064306.9192-1-duanmuquan@baidu.com> <CANn89iKwzEtNWME+1Xb57DcT=xpWaBf59hRT4dYrw-jsTdqeLA@mail.gmail.com>
 <DFBEBE81-34A5-4394-9C5B-1A849A6415F1@baidu.com> <CANn89iLm=UeSLBVjACnqyaLo7oMTrY7Ok8RXP9oGDHVwe8LVng@mail.gmail.com>
 <D8D0327E-CEF0-4DFC-83AB-BC20EE3DFCDE@baidu.com> <CANn89iKXttFLj4WCVjWNeograv=LHta4erhtqm=fpfiEWscJCA@mail.gmail.com>
 <8C32A1F5-1160-4863-9201-CF9346290115@baidu.com>
In-Reply-To: <8C32A1F5-1160-4863-9201-CF9346290115@baidu.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 8 Jun 2023 06:13:04 +0200
Message-ID: <CANn89i+JBhj+g564rfVd9gK7OH48v3N+Ln0vAgJehM5xJh32-g@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: fix connection reset due to tw hashdance race.
To:     "Duan,Muquan" <duanmuquan@baidu.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 5:59=E2=80=AFAM Duan,Muquan <duanmuquan@baidu.com> w=
rote:
>
> Hi, Eric,
>
> Thanks a lot for your explanation!
>
> Even if we add reader lock,  if set the refcnt outside spin_lock()/spin_u=
nlock(), during the interval between spin_unlock() and refcnt_set(),  other=
 cpus will see the tw sock with refcont 0, and validation for refcnt will f=
ail.
>
> A suggestion, before the tw sock is added into ehash table, it has been a=
lready used by tw timer and bhash chain, we can firstly add refcnt to 2 bef=
ore adding two to ehash table,. or add the refcnt one by one for timer, bha=
sh and ehash. This  can avoid the refcont validation failure on other cpus.
>
> This can reduce the frequency of the connection reset issue from 20 min t=
o 180 min for our product,  We may wait quite a long time before the best s=
olution is ready, if this obvious defect is fixed, userland applications ca=
n benefit from it.
>
> Looking forward to your opinions!

Again, my opinion is that we need a proper fix, not work arounds.

I will work on this a bit later.

In the meantime you can apply locally your patch if you feel this is
what you want.
