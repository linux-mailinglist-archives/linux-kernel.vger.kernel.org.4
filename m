Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C026CC9BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjC1Ryf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjC1Ryc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:54:32 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DAEAF30
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:54:26 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id n1so6021808ili.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680026065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mhvhLb7D4riffRSL6raFnIME1Z/M2laCEfNPlg61Ao=;
        b=Z2zkqwkq6Y2lOdMPTFGpEhKpmx7qA52CuqtQ6NeUpQRaEH5b1FDlVpdMTFBVkgXKJZ
         1MocbI2g6UFrQqLxjgT3Xj/qEcjtcX6hnWu0RY+N1hj/ht0+TiC4q9zOymBLfJYKN39T
         4yCI3/Aw76k79gv3g/nA6Pg42c0OrpG7CnUYkTgf3xaBvzDWhEaJI+OBphCkhuWmg6cm
         h0drTxHj7Pu+CMVA4PkrnL/42GtWWm02RYCE5mxWHI1FffKthEjdhh9kc44M76q1Jpwt
         kNB/z0Z3t7Ot7kZW4XJ/Hf97CA34jzbfgwqztrC1Gqkqp0rfSxNGnH5WegOyuZMvL2t7
         cnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mhvhLb7D4riffRSL6raFnIME1Z/M2laCEfNPlg61Ao=;
        b=kMpP0jBQ6Dq1n281r+efEdWDuR1jwmwNiILew6V8UsRXSPh7bsXxV8WcqYMsmFH5ki
         IdhOr4l4DnhZGGASi82a0qNNb8y4U7ke8TrsgKjO4PUzI0qZKhgGbjCuaUs2D0jl6ORM
         wnynGvRq0x/CdT4rEap6PjXwEJ4n2T4/d6PsrpdXoShZ5DEabR25I4su9+gRByDL3TbI
         DbGIjvSxfWTq1fQeFO5QNcoiAwP2HSYezrSv1DP9KqOz6ZN6K2tNhAwNKvjQ9KT1P1wk
         PVQ4E0cd70TaPvw2Uar7PgYIx++73jSDpieYVi0xChZkHNkBmZ1dFRvd+Iwqj1ZL+ZKT
         YN8w==
X-Gm-Message-State: AAQBX9f2Tn+inZ7lGaatH16Q2vgQvr8uxznv1xtM8KRMKz84fmZ78qab
        pKtMMUcrPCzGmGK+gTiNk+mklUN9GXkpBxbM2n2S9w==
X-Google-Smtp-Source: AKy350Zb4mUt1zFrnZvoiL7x6WGFpRDkYSe7gQJMODodXCy9tySgTy5p7fzZnY1rbt5Bn0wTZqf/O/4JoWAqNMhwIn0=
X-Received: by 2002:a05:6e02:106d:b0:30f:543d:e52c with SMTP id
 q13-20020a056e02106d00b0030f543de52cmr7803189ilj.2.1680026064971; Tue, 28 Mar
 2023 10:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <b9182b02829b158d55acc53a0bcec1ed667b2668.1680000784.git.stefan@agner.ch>
In-Reply-To: <b9182b02829b158d55acc53a0bcec1ed667b2668.1680000784.git.stefan@agner.ch>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 28 Mar 2023 19:54:13 +0200
Message-ID: <CANn89iKxcqDO3-LyuroUkFUfG2dtZOLE4n2UJQ3y-ft5BRm30g@mail.gmail.com>
Subject: Re: [RFC PATCH] ipv6: add option to explicitly enable reachability test
To:     Stefan Agner <stefan@agner.ch>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        john.carr@unrouted.co.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 5:39=E2=80=AFPM Stefan Agner <stefan@agner.ch> wrot=
e:
>
> Systems which act as host as well as router might prefer the host
> behavior. Currently the kernel does not allow to use IPv6 forwarding
> globally and at the same time use route reachability probing.
>
> Add a compile time flag to enable route reachability probe in any
> case.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> My use case is a OpenThread device which at the same time can also act as=
 a
> client communicating with Thread devices. Thread Border routers use the R=
oute
> Information mechanism to publish routes with a lifetime of up to 1800s. I=
f
> one of the Thread Border router goes offline, the lack of reachability pr=
obing
> currenlty leads to outages of up to 30 minutes.
>
> Not sure if the chosen method is acceptable. Maybe a runtime flag is pref=
erred?

I guess so. Because distros would have to choose a compile option.

Not a new sysfs, only an IFLA_INET6_REACHABILITY_PROBE ?

Thanks.
