Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5542066AA6A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjANJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjANJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:27:06 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93BC6EAB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:27:04 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 203so25052608yby.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRWaSL38FmpAF6MPoHC1wRCjc6lWX1x9mpgNKX5zaWg=;
        b=Ya0DpzZCRqbqljug8xIthWmr/m149CoU6y0Jt0icrVrEE3WSmdvgCHTG2HveJO7YrM
         mc26mQlJ+mJPrdeiaIH9L9ei67TjbHAhlV9XH7zeoJ7h2+KMusPQpouQkwTidvqp94sE
         eh2h7ks/goJQvBVQ8baHrnFF4W6pbfkOb6/l6zUFO48JyJ2uEHDoioT5u8A7w4XMMj9Q
         dBlZDGdRcl2nNggZvroChfxwLeIoGqJll187ufZbvSDXPkXBDrQWruVNNvVEw5vG57Hg
         ec+Rqs8LGBKWz915eZ4OVlRut9xptyt87FA9uR2X4MVVtOL7liq7IOH1VjAFYXLyK7MN
         vBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRWaSL38FmpAF6MPoHC1wRCjc6lWX1x9mpgNKX5zaWg=;
        b=F6BU7lnBzY+b1dxbxaAKvFBokAfZ92/WFCzb6SSVDESK9OQYa5u72k3PHkWzzEylF8
         M3W9NZH1BmwXiMgqMoQto5MJrrAlfmP6wXjQdCKRwIEDoS4lQyLfsk6EeKzHRBtkqcD4
         akBswZBC70FYFgH5FklloIlx2WCfN498UyZdaEfKziVF4QR4A1yfJpYL1pN5fxBh6W6b
         RFB1QquDP5lJ4WZ6O+WtN2Syofk9CFoBlV6JymaY5vO7xG6xXUQwWdOLGPNxIM2sirJZ
         gpFA+owF1E0ndrsd9VDuqN2kxcEcb2Uo0FR7ww3GYQcg+UkyUuHo5ltTXEG2ihkaUWbA
         9XPg==
X-Gm-Message-State: AFqh2kpaHZTcsGlyrLa289Mq/CiU84IS1H+b10AnkT7Rfxv/ZMllBpSa
        bB3f2H1y6CNQZ1OTCV25VSmOX9PsxNd76gzW0yV12w==
X-Google-Smtp-Source: AMrXdXuY84iL+h74+AYEZClAYaIUhhzThKZDRFK9FaDJDdeCFEDa7PkmvXO91tTikALOXNnlSb/Crq4Ag31QUij99kA=
X-Received: by 2002:a25:46c6:0:b0:7b8:a0b8:f7ec with SMTP id
 t189-20020a2546c6000000b007b8a0b8f7ecmr3812185yba.36.1673688423236; Sat, 14
 Jan 2023 01:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20230112065336.41034-1-kerneljasonxing@gmail.com> <CAL+tcoB2ZpgM6HM+m=wF2EkQ5caeettcbeUQQBxpLWVuwSSxbw@mail.gmail.com>
In-Reply-To: <CAL+tcoB2ZpgM6HM+m=wF2EkQ5caeettcbeUQQBxpLWVuwSSxbw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 14 Jan 2023 10:26:52 +0100
Message-ID: <CANn89i+W_1ux=5ixjCdf9LoGuDb6LEJ_XgWCNcYztjPQ0R4L1Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: avoid the lookup process failing to get sk in
 ehash table
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 3:15 AM Jason Xing <kerneljasonxing@gmail.com> wrote:

>
> So could someone please take some time to help me review the patch?
> It's not complicated. Thank you from the bottom of my heart in
> advance.


Sure.

Please be patient, and accept the fact that maintainers are
overwhelmed by mixes of patches and company work.

In the meantime, can you double check if the transition from
established to timewait socket is also covered by your patch ?
