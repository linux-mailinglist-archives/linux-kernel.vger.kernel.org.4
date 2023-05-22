Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCB70C594
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjEVS5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEVS5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:57:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D1DB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:57:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f5dbd8f677so10005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684781849; x=1687373849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K2vQzMv9RNitauKRDQ5JPQe/7PjWZsdmCRNjoMZRJg=;
        b=SXJRNOYPjzr9Ao5h26jhABB5UH2RlO9zeCrZbkYsqlfWRTd1E5vELd4VYgm71YlYyo
         5pgpR0GH6ccC9IRxq+4ruCAmPQX/yLJnka4hD5KAPgAl+tP5fXUBQtRp3ARHgPpMEFJq
         6RptLOauChgR8ovFIS9J0rs12cLFnRxblqH3z068hAsOxs1Exr1rZ/c9YAtTwUaQMzcW
         gQjxwN8Ctnun+miyMIsA85gj8zgjUt2nsvP1k+q9aSQ4Qm0wk3Ux3vaJjOdKcDzrB2wF
         Db24ZCr7BL2rPnlYQDNl8x4yUIjIQM6YAFxIap92Hzwfua8e9iQWZKupSU4ftFQTI4pi
         bnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684781849; x=1687373849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K2vQzMv9RNitauKRDQ5JPQe/7PjWZsdmCRNjoMZRJg=;
        b=gKN67pj40+drxdir/WEGkxe1uPFsjj75+MgpZ61TJ7xZ5om99TU8wzgRD6GOM1ngfi
         CawMzm2v/HKhLRmWuhLYwnIUTfJWmhW65CYPKAMePZCbZnQGBm6H4GdZdcxH6Hk+SfPy
         7//fECPKHb00tsJotAgrwFswACoHeepTa6Ebativ9K/hB+Zw0QZvEgrsN7l222ZSzChY
         GNkiXoDNsw23Srb5Vr/P+aTsAhy1Ttv5ZTUH3MV1saKrrNacFez9SSiaAP3LrRtZ66mR
         yg95ilgxjoVV2gUu4hS9u0EEK0cNBVSy1Ig0eCiNnXk/NVu5yaztutkBfJ8au3kRDxfG
         fAgQ==
X-Gm-Message-State: AC+VfDzJUR0DV9fpe/IU3WPA93o46rWlvKqUCuXn4897yGLgMw8AMQ6F
        qO9aISKCiyoJ+icLeT6k0387hZ/UGk/0F46bmjyXpg==
X-Google-Smtp-Source: ACHHUZ4b5kqNOwcZl03+RjJg0TP/fVR93h6Y+uu9Tv9TAjDKByd/wIHDDcoG8eaFRD9UtdmVPsA2LhR0U3rMlwebSgU=
X-Received: by 2002:a05:600c:4e02:b0:3f4:2594:118a with SMTP id
 b2-20020a05600c4e0200b003f42594118amr27609wmq.2.1684781848555; Mon, 22 May
 2023 11:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230522172302.90235-1-sj@kernel.org> <20230522173351.90497-1-sj@kernel.org>
In-Reply-To: <20230522173351.90497-1-sj@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 22 May 2023 20:57:16 +0200
Message-ID: <CANn89iJ7JZp2mtcL912SGzq90wKH0rR=X+2vPuinTnMdTsMvQA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix skb leak in __skb_tstamp_tx()
To:     SeongJae Park <sj@kernel.org>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, nmanthey@amazon.de, pabeni@redhat.com,
        ptyadav@amazon.de, willemb@google.com
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

On Mon, May 22, 2023 at 7:33=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:

> Sorry for continuing adding noises, but seems the process is, or will be,
> changed by to the mainline commit dbbe7c962c3a8 ("docs: networking: drop
> special stable handling").

Whoever backported the patch because it had a Fixes: tag will do the
same if another patch also has a Fixes: tag.

I personally prefer Fixes: very precise tags to weak ones.
