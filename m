Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3286722BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjFEPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjFEPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:46:10 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A847187
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:45:43 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b280319df5so532866a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685979869; x=1688571869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A90Mk0zhGtoGmxJxaQafKo6YzBEDqEFCob4w8O1kVaw=;
        b=zuuikebe6licttv8Tse/5e+gzZZ4D4z2gmA3z8mMAX2SdXkArSL4TUDb45v6l9IvZm
         b6obQZQle3xp/hYInx2KWqpyQimwN/Zvin1udaN/o69/8313VKYotWXdbfUbz35UEKSz
         2l+BkCjqdSvM9Sw+7OpfSR7iaJ8L+gpE///pmBMS5iX82JUaP0KajO2hFaFAD5BAA0fm
         CKO4vHpAzRbeqfq+FhBbKhFOfcmIyCPYp33PFMGhgmoB60APrXrx/XIPVWVTRWZTnwEi
         n78sZ3QHSwLwLTkFCoHIC7aqzfCR99mAzaU+vvCvm5LfLGdxzZIRWJUFMo+8EV4w/Ae6
         Q/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979869; x=1688571869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A90Mk0zhGtoGmxJxaQafKo6YzBEDqEFCob4w8O1kVaw=;
        b=FY1MwRCtWJ+bVw3ZnSCAGzNl49Uu3Ow9gq3kHtjMKGSd67ry3fftZDGeZyd3pHoLfJ
         Ijy6u2tsc/bI/KsCDL4SHwMRkrTHyMNt2xLrHGpeoE0yY3+xmXlTr7/t7Tw1jh1Wvxf7
         /55tbPXJNzxi/E/XDm+LAeIq43deUa83gzmKBbwLvFT4/oVdNKK9a4+GPCCHGokcV2L3
         BE9SNRwQZMA984w8mrRS+tpttnA6Fxuwg67XPl2ZJvjM+ni0nxpvYEgGfVtWae//wQtN
         JHRyq0QODPQX/SAilPksBrqB31TKT3a0G8pOqeIgzTx5xg8UnmzpHgPqSVfCG87XkVAa
         lh4Q==
X-Gm-Message-State: AC+VfDymVeDq7z1R/4XCxn1pYjpzb5bEXlvwNNCpvWyPfzxRJDKcI+s2
        yikt142xT1OVhxtCsN+TBXn1dTk01uoh/GIGBL4/dw==
X-Google-Smtp-Source: ACHHUZ4Tfjk8gbHFmBO99ECiDhiiGggbXGg15OtrRRxs+VRwIA/aSz9fY0Br9IG0xAYSxlcMfU2eCUAgu9MaGurWj+k=
X-Received: by 2002:a05:6358:c4a9:b0:129:d026:e9f2 with SMTP id
 fg41-20020a056358c4a900b00129d026e9f2mr188619rwb.11.1685979868907; Mon, 05
 Jun 2023 08:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230602103750.2290132-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230602103750.2290132-1-vladimir.oltean@nxp.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Mon, 5 Jun 2023 11:44:17 -0400
Message-ID: <CAM0EoMnqscw=OfWzyEKV10qFW5+EFMd5JWZxPSPCod3TvqpnuQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next 0/5] Improve the taprio qdisc's
 relationship with its children
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 6:38=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> [ Original patch set was lost due to an apparent transient problem with
> kernel.org's DNSBL setup. This is an identical resend. ]
>
> Prompted by Vinicius' request to consolidate some child Qdisc
> dereferences in taprio:
> https://lore.kernel.org/netdev/87edmxv7x2.fsf@intel.com/
>
> I remembered that I had left some unfinished work in this Qdisc, namely
> commit af7b29b1deaa ("Revert "net/sched: taprio: make qdisc_leaf() see
> the per-netdev-queue pfifo child qdiscs"").
>
> This patch set represents another stab at, essentially, what's in the
> title. Not only does taprio not properly detect when it's grafted as a
> non-root qdisc, but it also returns incorrect per-class stats.
> Eventually, Vinicius' request is addressed too, although in a different
> form than the one he requested (which was purely cosmetic).
>
> Review from people more experienced with Qdiscs than me would be
> appreciated. I tried my best to explain what I consider to be problems.

I havent been following - but if you show me sample intended tc
configs for both s/w and hardware offloads i can comment.

In my cursory look i assumed you wanted to go along the path of mqprio
where nothing much happens in the s/w datapath other than requeues
when the tx hardware path is busy (notice it is missing an
enqueue/deque ops). In that case the hardware selection is essentially
of a DMA ring based on skb tags. It seems you took it up a notch by
infact having a choice of whether to have pure s/w or offload path.

cheers,
jamal
> I am deliberately targeting net-next because the changes are too
> invasive for net - they were reverted from stable once already.
>
> Vladimir Oltean (5):
>   net/sched: taprio: don't access q->qdiscs[] in unoffloaded mode during
>     attach()
>   net/sched: taprio: keep child Qdisc refcount elevated at 2 in offload
>     mode
>   net/sched: taprio: try again to report q->qdiscs[] to qdisc_leaf()
>   net/sched: taprio: delete misleading comment about preallocating child
>     qdiscs
>   net/sched: taprio: dump class stats for the actual q->qdiscs[]
>
>  net/sched/sch_taprio.c | 60 ++++++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>
> --
> 2.34.1
>
