Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F26E7943
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjDSMCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjDSMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:02:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4522313F9C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:02:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7606d44dbb5so358514539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681905751; x=1684497751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONZamODJRvqy6J+Av+dlMRhEznkk1tECG+7GkAg/23g=;
        b=aNwJnRdtpU2MnQDs5CltTBsXPymg3YHVorjZGgndE0NtBGuN7i4h23vJK9oAf+G4zc
         L1IUCsVsLVNvebnFytjgLszYQc9lIloy7m+9aOInBDN5gPW1eRq7SMriwpyGVZaR8NDD
         YTlq4U62YDxF9StoaL8rls0FQfHHrtMb9EhYa86NF1U5tPptfPvFE/zoifgS6D6cmsTC
         m/BiaVlDDKiiKlql4iW3FBIUNRauV/0ICWlMILzVuBIBTz3fgdZt2vlZUN9UxsOZjH9R
         g1gtMtuaLGcp5aj8kW1mrUsEk0AiTm85bguQMziWbipmMPLuXH0dt+9qA75UJgbfPHAC
         Pdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681905751; x=1684497751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONZamODJRvqy6J+Av+dlMRhEznkk1tECG+7GkAg/23g=;
        b=d1BOiJCBja7Bz7UTWk9dSf3LyD3RH0trCUMaDi+PjKEEP2SHfTx7ktynEk0oYaJtKh
         aoshWsbFCu2WZ+CfENBz4XUn6ZC82zwxINqWxDy9oUIDQBzgznKPIOUcNI3EcX9fiubl
         yHz5g3pfiBXm1liwRZ4xpx2TjW8fDjxG615+EWGmcBDsNsGptqSluTMmeYFIVwv+xD13
         owlpNsazVzYBX/qA2MlULMjtnynmu4vtuBFpjpDREyWC+wZfwEeWB8fbWBzJKauOJtQf
         2lJq2sUr15thVvgk4oPXyGyxreoQLSrY7TbmNhJmpC7zm7+h2mzYXj0LR3d5ee/B2ztl
         0FRw==
X-Gm-Message-State: AAQBX9fsdpvril3sNakmSD6Anj2vFnATyQrgSRchoDGF7e4N1uBWRtcm
        YqN0PILMGAcBuDQYu0cl3v8l6mP1zLqv6f+Q6pG/oQ==
X-Google-Smtp-Source: AKy350Youq/QZOpV/eNAeibJcUDQATVB+UiHKdjWRdu+l0h1Mf6PHUv365Gj5h4UkoT2VrergEgwBaMmtJ9KU80ZibQ=
X-Received: by 2002:a6b:d911:0:b0:745:70d7:4962 with SMTP id
 r17-20020a6bd911000000b0074570d74962mr3741723ioc.0.1681905751412; Wed, 19 Apr
 2023 05:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230419115632.738730-1-yajun.deng@linux.dev>
In-Reply-To: <20230419115632.738730-1-yajun.deng@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 19 Apr 2023 14:02:20 +0200
Message-ID: <CANn89iJeiEk_Rcoh0odfjK2ocP23HQfOPDhJJ7p_=Q--A2jHJg@mail.gmail.com>
Subject: Re: [PATCH] net: sched: print jiffies when transmit queue time out
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 1:56=E2=80=AFPM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
> Although there is watchdog_timeo to let users know when the transmit queu=
e
> begin stall, but dev_watchdog() is called with an interval. The jiffies
> will always be greater than watchdog_timeo.
>
> To let users know the exact time the stall started, print jiffies when
> the transmit queue time out.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---


>                                         atomic_long_inc(&txq->trans_timeo=
ut);
>                                         break;
>                                 }
> @@ -522,8 +522,9 @@ static void dev_watchdog(struct timer_list *t)
>
>                         if (unlikely(some_queue_timedout)) {
>                                 trace_net_dev_xmit_timeout(dev, i);
> -                               WARN_ONCE(1, KERN_INFO "NETDEV WATCHDOG: =
%s (%s): transmit queue %u timed out\n",
> -                                      dev->name, netdev_drivername(dev),=
 i);
> +                               WARN_ONCE(1, KERN_INFO "NETDEV WATCHDOG: =
%s (%s): \
> +                                         transmit queue %u timed out %lu=
 jiffies\n",
> +                                         dev->name, netdev_drivername(de=
v), i, some_queue_timedout);

If we really want this, I suggest we export a time in ms units, using
jiffies_to_msecs()
