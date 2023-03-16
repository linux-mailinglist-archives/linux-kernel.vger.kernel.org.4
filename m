Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D536BD9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCPUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCPUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CE86EB9C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678997380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDuRBhoJQRLG1TJECvT2cZ77RYvcvbx4g9GwtkqEBQ8=;
        b=TFeFyhsUuvbXVaaLeYvNHKaVD+77g7UfRBXFM0XWDr8GmBV/xbhjMuxZaF6/H1M8WHytWw
        t4xZti08ZBtlzXbnKFgmFhbcuh7uY5cMbrKjemmrZ3xMLSZytJdWcfVmqy1ymJt/C8P484
        p6+frUnYUcldUGr93qpm77e9f7pmXvo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-rWmeGv64MrGMY_yjIY2abQ-1; Thu, 16 Mar 2023 16:09:39 -0400
X-MC-Unique: rWmeGv64MrGMY_yjIY2abQ-1
Received: by mail-ed1-f71.google.com with SMTP id j21-20020a508a95000000b004fd82403c91so4569455edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678997375;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDuRBhoJQRLG1TJECvT2cZ77RYvcvbx4g9GwtkqEBQ8=;
        b=SLqGxYESAIcVat4Nefd/VT24qK36wtKZQa7FBCggC9AMFkj1n6vKzuZXFVXnKf3zsh
         ngdEHHBfDU6jX28uwj2weFzKz45f72B3GH8fIBeN1U9YXY62g5bEgVfG9+UQMihAWOBJ
         7EYMuwVuu9zRBY9BuN6Cya1yE55+0zp3vVyliXEmlatEUWxNvR6OoSAtIwZ7eD1Ivm5+
         R9mtXXwbDzwolbWxJuwCOicirPa1Mj7uvgraWg+RkHwpz9fgw2VRxm2sl4sYmjsZIiVM
         J+jkKD1wEJmKAGVM+GC1GfmsN0KfTqbMOxGzLhfC9wmfA21H8zxlL8LCQJR0zYRES1f9
         Zhmg==
X-Gm-Message-State: AO0yUKVl71vSKJTx3W9l06Xr3/iJNAKpqmzoQtMnj0jiDMD4g18mTt6i
        +dm9/JGQacGWHpsZkCEGmr6hT+qyoONobfBIxPC5vZ3EzQ31n7y9LJg+TpMOniCPvV4lPPR2Q6h
        mHb6Nnd3h7ieu7s2/Gk8xPj1a
X-Received: by 2002:a17:906:55d5:b0:8ae:fa9f:d58e with SMTP id z21-20020a17090655d500b008aefa9fd58emr13320780ejp.53.1678997374762;
        Thu, 16 Mar 2023 13:09:34 -0700 (PDT)
X-Google-Smtp-Source: AK7set/Zn5noaYYA4yFCj/3pnT/fygcd2BC8c+6A6YLObXRtLZvvopwbtIyuLgm4KaKt1zWXQfiPlg==
X-Received: by 2002:a17:906:55d5:b0:8ae:fa9f:d58e with SMTP id z21-20020a17090655d500b008aefa9fd58emr13320722ejp.53.1678997373956;
        Thu, 16 Mar 2023 13:09:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y6-20020a170906558600b009260634e25asm42582ejp.121.2023.03.16.13.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 13:09:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6E3DE9E30A2; Thu, 16 Mar 2023 21:09:32 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+e1d1b65f7c32f2a86a9f@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: fix crashes due to XDP
 frame overwriting/corruption
In-Reply-To: <20230316175051.922550-2-aleksander.lobakin@intel.com>
References: <20230316175051.922550-1-aleksander.lobakin@intel.com>
 <20230316175051.922550-2-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 16 Mar 2023 21:09:32 +0100
Message-ID: <878rfwa26b.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> syzbot and Ilya faced the splats when %XDP_PASS happens for bpf_test_run
> after skb PP recycling was enabled for {__,}xdp_build_skb_from_frame():
>
> BUG: kernel NULL pointer dereference, address: 0000000000000d28
> RIP: 0010:memset_erms+0xd/0x20 arch/x86/lib/memset_64.S:66
> [...]
> Call Trace:
>  <TASK>
>  __finalize_skb_around net/core/skbuff.c:321 [inline]
>  __build_skb_around+0x232/0x3a0 net/core/skbuff.c:379
>  build_skb_around+0x32/0x290 net/core/skbuff.c:444
>  __xdp_build_skb_from_frame+0x121/0x760 net/core/xdp.c:622
>  xdp_recv_frames net/bpf/test_run.c:248 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:334 [inline]
>  bpf_test_run_xdp_live+0x1289/0x1930 net/bpf/test_run.c:362
>  bpf_prog_test_run_xdp+0xa05/0x14e0 net/bpf/test_run.c:1418
> [...]
>
> This happens due to that it calls xdp_scrub_frame(), which nullifies
> xdpf->data. bpf_test_run code doesn't reinit the frame when the XDP
> program doesn't adjust head or tail. Previously, %XDP_PASS meant the
> page will be released from the pool and returned to the MM layer, but
> now it does return to the Pool with the nullified xdpf->data, which
> doesn't get reinitialized then.
> So, in addition to checking whether the head and/or tail have been
> adjusted, check also for a potential XDP frame corruption. xdpf->data
> is 100% affected and also xdpf->flags is the field closest to the
> metadata / frame start. Checking for these two should be enough for
> non-extreme cases.
>
> Fixes: 9c94bbf9a87b ("xdp: recycle Page Pool backed skbs built from XDP f=
rames")
> Reported-by: syzbot+e1d1b65f7c32f2a86a9f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/bpf/000000000000f1985705f6ef2243@google.com
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Link: https://lore.kernel.org/bpf/e07dd94022ad5731705891b9487cc9ed66328b9=
4.camel@linux.ibm.com
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

