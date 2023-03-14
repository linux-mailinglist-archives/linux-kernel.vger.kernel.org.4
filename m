Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC126B88CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCNC5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCNC5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:57:37 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381478F730
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:57:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p203so6856081ybb.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678762655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAvGox7GmZ47c9P+o7CExrDCvG1ChWStyBz58KXV08M=;
        b=hBtk3G2P/OGc+ZQuHY3srIPgQUGXlr4cUhanFC2bUMFTXzIod08PPEFEInU2rsRJcG
         4Ftmnd4/52gW8GUsYqae7CkJtBy9b12lLFhGFGsHA3xG6eXP/d69VO7dt3QnoUkjNhev
         5h3AkNMRvIkOSknTlckwE+hrNhlwxHlgX3IFidR/TIQaCXmy0qQ5x52dY6IY56r6T5i7
         ep948QDV3KYKd8T9LGuSdbIkzuPDAnAuL+ggsjxc4n8sr8cLIq2UyF3BLjM55JzCC5ZA
         0+zD/WPFPXCN+SUWqMtQL46d7XVOSCuVUkO1bQpO+isNEWHILQmTm4Q9UR7p3gtGXHWn
         dd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678762655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAvGox7GmZ47c9P+o7CExrDCvG1ChWStyBz58KXV08M=;
        b=tAGSh9EfpliQT4FVCD49IlzHd/ZyI/lSkQcQ3Q4oC/2uMcX+fTti5ltmTmkyAr6sXj
         OVF66MS1hMHIDhBTEaE1i53oo6nR2hFhAppp0p5gYvxn7NHY9NhUPFP5Hr+jCBhn1uQn
         jMSc9eEUHaXU2/tD8HAnfT+MnygEkBQbcTbmKeyYFbmOGJpMGbwSNzEClBbe5CyNLObN
         uHkCAVpMutDiLYsPY+yXxcnwraKZJfpSszsQi38Ci9xZSkgLCnl9xbGdaB5uSAenAADX
         tBkPJnmj9/7kG1uI4Jcq0HaW5ZOYN/C21mMYH8Xm9NbD65PT9WehslwQc7kE86cNWgyz
         /Bog==
X-Gm-Message-State: AO0yUKWTgK6RV7Mkj8zzfN33B+BunEThjmQ5zyAGgtNsyuwRzbJ2ye9Z
        rxoMoOs97/feW3Q4xCptGAYlVJ8O9BXuo0ofo5tyeA==
X-Google-Smtp-Source: AK7set9XoB7w0sxv/2dOEHV8DzsSNR0CNiaktPvOCBFqHMvaAph7PAN9vGGaBshCGP+v0N1/aLJlXigSJwzG+/IFeSw=
X-Received: by 2002:a05:6902:4f:b0:b38:461f:daeb with SMTP id
 m15-20020a056902004f00b00b38461fdaebmr4022126ybh.6.1678762655212; Mon, 13 Mar
 2023 19:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230313075107.376898-1-gavinl@nvidia.com> <20230313075107.376898-5-gavinl@nvidia.com>
In-Reply-To: <20230313075107.376898-5-gavinl@nvidia.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Mar 2023 19:57:23 -0700
Message-ID: <CANn89iLDUR_3pmxco47VQkvWweq2g4Og6UhtLN1gQMQiCUy2KQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/5] ip_tunnel: Preserve pointer const in ip_tunnel_info_opts
To:     Gavin Li <gavinl@nvidia.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        roopa@nvidia.com, eng.alaamohamedsoliman.am@gmail.com,
        bigeasy@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gavi@nvidia.com, roid@nvidia.com,
        maord@nvidia.com, saeedm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 12:51=E2=80=AFAM Gavin Li <gavinl@nvidia.com> wrote=
:
>
> Change ip_tunnel_info_opts( ) from static function to macro to cast retur=
n
> value and preserve the const-ness of the pointer.
>
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> ---
>  include/net/ip_tunnels.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
