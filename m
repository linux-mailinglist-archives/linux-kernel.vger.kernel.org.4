Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305DF73FD44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjF0Nz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjF0NzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:55:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42A2129
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:55:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401d1d967beso274931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687874123; x=1690466123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGOH63jgnVEs2f+80uEeHRGpcn2owuUaHFI+XI/Lwro=;
        b=4jpRsGb+eEeMvdz049rnzuwxgDroNMoFwnA24xUhw8wYNtRIr6lxsWdA/P/rFb0HkR
         lDMop5UXZhkkHrT2PhbP0SKfe09XFulHDdDX7kkilQf397tCis5Gm4Ywd+bYh4ZmbyFe
         jrMCqd+JLCEHFz9pIpK7fUCljELdHdGRI74Ie6SO3a44srbGtPWzvAA5qD8MLuuVvuYO
         4Ak7S0APJbZNLpYXYwifpTCaM6htT0oZSZ1YSeh1TbD0iUMTTAEb+1vvq3HGMEXyOz5r
         wcFAhd+BLPd3Cvh8SBMl56DYXOoNFsknCSE53CCdmANx6sZcdJkXuUe1gJC3leihqpqG
         ao6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687874123; x=1690466123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGOH63jgnVEs2f+80uEeHRGpcn2owuUaHFI+XI/Lwro=;
        b=U3xlrsQ+4GBsJAz5YIVIHxjQdauyNr5YMsqTEVScS7ORqlWkBQyybUvJR8auccS5uT
         It/Xex2kb6+9cHvQc5Qo4ipmdYmQdUMq9mgf5z83gSikeia/xcXvPELtWGFxw0O2jTX3
         9StxosEJZaCQGKioh1WRk5zwIhESe883xr2t4Zse7C/U/ol1SWHSHiL6ZEEnnxeD1bmo
         a/3q11vcwfK6eNmTxfiIMYPrVuev72p7A+SnQc3FSYptc3dPBXfYzkjNgdfL8Lnsz9d5
         I1kEHY03u/Vnt90pi8sPuBM1H26Vi0trvAepyHFS/7YXOo6o25tbegGCl5LSkEjOFOHr
         Tt8A==
X-Gm-Message-State: AC+VfDwr9Ytu7Lt7MoDJDaYRtjOrapSB0lZS+4GJueH5TXgThvj+/09s
        g7lQywEGb4TA+rxcmhHU/qHSMSIl9b4jeruyOJow3g==
X-Google-Smtp-Source: ACHHUZ5GPkxVhmJt7C7Zmwoh0e7IvTuPuxE1QBH9E9t9bnIcJaaMSg5SFknMlx4nZK8GGimQ2eJFlpxzPfLF6K79RdI=
X-Received: by 2002:ac8:5708:0:b0:3f3:75c2:7466 with SMTP id
 8-20020ac85708000000b003f375c27466mr182910qtw.8.1687874122873; Tue, 27 Jun
 2023 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230627105209.15163-1-dg573847474@gmail.com>
In-Reply-To: <20230627105209.15163-1-dg573847474@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 27 Jun 2023 15:55:11 +0200
Message-ID: <CANn89iJRaT1B=HwWDsEdcAUZzYERzeR8iwGYHZuLcy+G4G39Lw@mail.gmail.com>
Subject: Re: [PATCH] net/802/garp: fix potential deadlock on &app->lock
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
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

On Tue, Jun 27, 2023 at 12:52=E2=80=AFPM Chengfeng Ye <dg573847474@gmail.co=
m> wrote:
>
> As &app->lock is also acquired by the timer garp_join_timer() which
> which executes under soft-irq context, code executing under process
> context should disable irq before acquiring the lock, otherwise
> deadlock could happen if the process context hold the lock then
> preempt by the interruption.
>
> garp_pdu_rcv() is one such function that acquires &app->lock, but I
> am not sure whether it is called with irq disable outside thus the
> patch could be false.
>
> Possible deadlock scenario:
> garp_pdu_rcv()
>     -> spin_lock(&app->lock)
>         <timer interrupt>

This can not happen.

RX handlers are called from BH context, and rcu_read_lock()

See net/core/dev.c,  deliver_skb() and netif_receive_skb()


>         -> garp_join_timer()
>         -> spin_lock(&app->lock)
>
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
>
> The tentative patch fix the potential deadlock by spin_lock_irqsave(),
> or it should be fixed with spin_lock_bh() if it is a real bug? I am
> not very sure.

I guess more work is needed at your side :)
