Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914346B7EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCMRDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCMRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:03:01 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF076F4D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:02:03 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id u32so5893413ybi.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678726873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3LTJVQ8I7Md44dC0AzAPJrh+kx0iHH3FkY/zz5mmQk=;
        b=JwLRo2H8LkJNs/lKAF6GdiW8kBrP8YKe0c1h4gZE3oielQ93KgRC1nL6EjJqq129DC
         jfaNiHgX7XdNlGa9VCpA8YKqSS2iG2XCcGwLWzgNXcn9JUqoj1/cEl1l8Ucc0W/JtTFu
         w/+Y4bWJ24PZWIAjZglJYiY5fOGNGqF6nn2CNUq7d076DU6syh6loYSM5ffLemCY0DwV
         +3Gc42Wqb6E5Wy3Vk+OjLJMhw1czabLk+TX65vHhZmt3CmL1xn5glbUpqCKBytxUUKD2
         TQx2XS230JoWCsmh/H1Lsjl6Ri+c7EsDYCerBly880SkmAUGtoRobNhdEWT0CpsoCPBy
         smGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3LTJVQ8I7Md44dC0AzAPJrh+kx0iHH3FkY/zz5mmQk=;
        b=7RMpMpFgGuMPbHGipYKv/MxaKce7VoQztIWdip+H0VbtNGZtec/EiGL3xFcbtaBkrN
         2pqrsdEBu2YupuGFiAKjaltXv4pOwc7iU6FidGlta6YO1DzXE+TUhOb1tCT0Wnr0zWv/
         E+52uLbdpGJuJ680/ofVWT96AcjwvmfVkJckT5f8V6fUT6Xf7QSPdegO61YTWKg7lNLD
         emhM9Cj8ktOXYmNnMg5YJtUJmiAm6bpHqhDR1VCGyVpGGGdjQqHxeopvh+yGS79vrNoy
         z+zb5g/P5HxaY64i7iSGS4SJNkoWt1Y8bw/PyggcfrH0QEHi7OV/b0plIms9j3w28jEK
         Tzdw==
X-Gm-Message-State: AO0yUKU33Glg3cZVq9Op+KP+HtWW4KlgE9EDsik6R8EG9JH/fzbXZ8ts
        QZtIk05SZWLJmVeIQWYJDD1dK7GMPJ7lJicdmzoYjw==
X-Google-Smtp-Source: AK7set9AGI9Yup843jOL+BxMIvnxdJnpdOzdNn1Qgz4OEl6d5d4kvCTnls97Ui1PaHdghV59qsWHM/i0zXaplRzioT0=
X-Received: by 2002:a05:6902:524:b0:ab8:1ed9:cfc5 with SMTP id
 y4-20020a056902052400b00ab81ed9cfc5mr21762528ybs.6.1678726872826; Mon, 13 Mar
 2023 10:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230313162520.GA17199@debian> <20230313162956.GA17242@debian>
In-Reply-To: <20230313162956.GA17242@debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Mar 2023 10:01:01 -0700
Message-ID: <CANn89iJfnK1q51ushoN-H4h8DCZBrbvwLB8JCyS6z3ViQczVVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gro: decrease size of CB
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, alexanderduyck@fb.com, lucien.xin@gmail.com,
        lixiaoyan@google.com, iwienand@redhat.com, leon@kernel.org,
        ye.xingchen@zte.com.cn, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Mar 13, 2023 at 9:30=E2=80=AFAM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> The GRO control block (NAPI_GRO_CB) is currently at its maximum size.  Th=
is
> commit reduces its size by putting two groups of fields that are used onl=
y
> at different times into a union.
>
> Specifically, the fields frag0 and frag0_len are the fields that make up
> the frag0 optimisation mechanism, which is used during the initial parsin=
g
> of the SKB.

Note that these fields could also be stored in some auto variable,
instead of skb.

>
> The fields last and age are used after the initial parsing, while the SKB
> is stored in the GRO list, waiting for other packets to arrive.
>
> There was one location in dev_gro_receive that modified the frag0 fields
> after setting last and age. I changed this accordingly without altering t=
he
> code behaviour.
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>
