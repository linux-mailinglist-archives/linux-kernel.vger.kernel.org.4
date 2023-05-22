Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673870C30E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjEVQMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEVQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:12:08 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A510D;
        Mon, 22 May 2023 09:12:06 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso1096457241.3;
        Mon, 22 May 2023 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684771925; x=1687363925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1Kq2pTQzRPtKnP1nHWXlWj/vVcufb0P5WbmZ2JJgU4=;
        b=gR3o4xstXYZQqMVIrRTrV5ICd6gg6cxe8qaElDJZADmQNfQiVs0rXaNapNPzxI0D69
         GxSzwwl8DO9b23+3Pn22f2smLn7GKE4wPKWzyZeCkSjFfC9kjw/l7b0sI/2RMdwTOkPN
         eciOs9jzsvwsCaYXDaFayjCwDFnEFSxh8PB8BrNt7X9+7zdAofqzrDKMeOiblcDHmZ9J
         3LE+sGrrCAXJSm8dvwgk+Ji1qLyPSHv/jRuCvCuS2GRVhjNmR3QT6DN805SdhPmZwSYB
         nzH26lAePUj6vQF4jWIRg0AhxyF7wsElxw2LvO7oloZMe7YzcArElfvcBm1fHu6irR5i
         NpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684771925; x=1687363925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1Kq2pTQzRPtKnP1nHWXlWj/vVcufb0P5WbmZ2JJgU4=;
        b=Bkbug7okkcejyRL/YmBLikTyP+Z7sqECNDQuxfq9nezvum2mrMc5wSYriNC9V7Bj+m
         8V8jJvjCmj13xVm70nE0t7kR6Iaj5JwiHaFW5OF54Ia2vwL8CmTG/QDZn4ycyAN9nBXh
         hRPXmwox5zkuRRbTQLSnuhDGGdkjkV2qN5T//6GHoqga9cnB+A9/3msR9fS18lvSbKQq
         MLRrjZUm06kdP5lwlsGzg2LJYQjr/hqkUtEIhdBFnMh8tTQlnEv6ntpg7GEyjDjknlLE
         M/Hd37VbbDeWH7Sa1+cWG6+mzpoFVtcb+2ju00q8as5dRenldb9omogqDHS80sahE9h4
         Nazw==
X-Gm-Message-State: AC+VfDytiAstR3AVXFjTVcdyOTp3DFvxi4oWn7GIFJovqgkHf8Psth+D
        WYEgN1guu8OopxAWBlYYja5u6GKYYtCZMpOku1I=
X-Google-Smtp-Source: ACHHUZ4TT4FQFXoEJ7KP1GN7aOF/n6thjTDb3gwc8Ze2Z+V3ftIPBbSC0drnY7ett+wQrvhSder9nkPprGcvvfFYSJw=
X-Received: by 2002:a67:e294:0:b0:42c:922e:65dd with SMTP id
 g20-20020a67e294000000b0042c922e65ddmr2718260vsf.23.1684771925014; Mon, 22
 May 2023 09:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230522153020.32422-1-ptyadav@amazon.de> <20230522154554.44836-1-kuniyu@amazon.com>
In-Reply-To: <20230522154554.44836-1-kuniyu@amazon.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 22 May 2023 12:11:28 -0400
Message-ID: <CAF=yD-KWV-Zc4O4OfztBEHwGgEfJsr-usut3ki=nA5mX8sfRpA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix skb leak in __skb_tstamp_tx()
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     ptyadav@amazon.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, nmanthey@amazon.de, pabeni@redhat.com,
        willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:46=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Pratyush Yadav <ptyadav@amazon.de>
> Date: Mon, 22 May 2023 17:30:20 +0200
> > Commit 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs wit=
h
> > TX timestamp.") added a call to skb_orphan_frags_rx() to fix leaks with
> > zerocopy skbs. But it ended up adding a leak of its own. When
> > skb_orphan_frags_rx() fails, the function just returns, leaking the skb
> > it just cloned. Free it before returning.
> >
> > This bug was discovered and resolved using Coverity Static Analysis
> > Security Testing (SAST) by Synopsys, Inc.
> >
> > Fixes: 50749f2dd685 ("tcp/udp: Fix memleaks of sk and zerocopy skbs wit=
h TX timestamp.")
> > Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
