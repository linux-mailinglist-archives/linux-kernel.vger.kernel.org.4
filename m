Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8264DFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiLORc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLORcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:32:51 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1520726574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:32:50 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id cg5so63081qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05Zf0NXTHVXgPzdAvU0TFZksx81/kcsaCFl0GGhVfUw=;
        b=MTuKufN9w0DfqGZAe1WDG8a8fOcvVIfTm6N/TKaqAVSHmYhMd2pehgZKXZk6kyZf3O
         vZsCaOLOvQIr8X6p1FKK62Rhx564LH5SKMMypIIr0tpxQjt8KiuwzHMuiisSXOjO72vX
         AnJFc8pqupn92BVj6g3R0VKBVz11R2I8DXkC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05Zf0NXTHVXgPzdAvU0TFZksx81/kcsaCFl0GGhVfUw=;
        b=3eQ4nk/NM1ubz5phXoMGKE2R81Gc7THerjoA1Bz79voD+iZkukAp45JFuDj7W+uHv5
         YJuS/WVhJsyc6B8wBQcRAG727J25a1LnKL1y6nklpZI3Uo3HcE/0MYtuclM00POps1G1
         zu/HBhwJ1K7z1gUlieuwGRlaia5R03IoLyp0jP978GjQwusDh6a7BSxOwmwqlOpb7yiW
         uCdr59bpcjEcMb7XFnxkpDwEhREnb2FwlIgWfoZmiBKEJtj/wPFoUrBxMkE/4fWYhXeW
         VXn1j/XKgqkkjv/LGtfL0mZOLI/K/JtYSmZf1zLtjaWq2X1MsvTCg0+VEMwvBgnbGZh7
         BgOw==
X-Gm-Message-State: ANoB5pnTK8BwaXYK9BfWa800DyLmIafyS3/sG3OZIw0STdNti5YtckGT
        w7C+9EsY4xeJhKnK9HUAlddVeMIWrFsCQkYZ
X-Google-Smtp-Source: AA0mqf5E4e6y9VejoGSJ+PbaCqqqXOxZkbCc03xKeDSiwzlICT2CdT7lwiN+jqvtWN283rZMciWpLw==
X-Received: by 2002:ac8:4983:0:b0:3a5:4a20:3096 with SMTP id f3-20020ac84983000000b003a54a203096mr32632736qtq.6.1671125568684;
        Thu, 15 Dec 2022 09:32:48 -0800 (PST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a449600b006fc2f74ad12sm12650301qkp.92.2022.12.15.09.32.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 09:32:47 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id pp21so2275999qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:32:47 -0800 (PST)
X-Received: by 2002:a05:6214:a45:b0:4c7:20e7:a580 with SMTP id
 ee5-20020a0562140a4500b004c720e7a580mr32788565qvb.43.1671125567413; Thu, 15
 Dec 2022 09:32:47 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mvfH2Kn_h2z+NsCoOdN8eBNw9_6=fFmgPvFOejwnCJMuA@mail.gmail.com>
In-Reply-To: <CAH2r5mvfH2Kn_h2z+NsCoOdN8eBNw9_6=fFmgPvFOejwnCJMuA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Dec 2022 09:32:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wikDs8v=Zk=Tdr7xRO3=9RWRa+2k068Upsk45uSx8r9nw@mail.gmail.com>
Message-ID: <CAHk-=wikDs8v=Zk=Tdr7xRO3=9RWRa+2k068Upsk45uSx8r9nw@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd server fixes
To:     Steve French <smfrench@gmail.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 7:18 PM Steve French <smfrench@gmail.com> wrote:
>
> I can also send the client (cifs.ko) P/R tomorrow if it is easier but
> have been working on testing some important fixes which are not in
> linux-next yet, so not sure if it is easier to send the client fixes
> as two P/Rs, or wait and send the client fixes all together as one
> P/R later in the merge window.

I'd like to get the bulk early.

I'm traveling tomorrow (and to make this merge window *extra* fun,
Xfinity was messing with my home network yesterday), so if you have
the first batch that has been in linux-next ready to go, please get
that to me asap.

The less I have to look at while traveling, the better. I'm only on
the road for a couple of days, but then it's xmas week, so...

           Linus
