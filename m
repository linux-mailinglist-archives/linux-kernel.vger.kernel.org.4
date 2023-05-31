Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC9C71897E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjEaSlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEaSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:41:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7176B2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:41:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso11215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685558504; x=1688150504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF8VCrAhn66qLdsXW4ERcJHTpMGUMtRWJ1DJabZuEyQ=;
        b=HAE9WEczf7c2MeIZ4h/RbK3Cjb5fN73gTSQSxUlfticM8Wm5+3KYNdCCUJkAMmb50S
         6pYNN9JmiEHfp+puF6Ifg9QugBI77MhyZoDxYOh+QZyFuYfk0nVngkBqh1z+AlThZu7/
         OaeQzy1P2JG30p6ok0sTys8algaPOd773TzibgbHDutaAN9cuIVnG8LlfoaH4u+raKA1
         FH2cBJ9YzyYNDPnMLGEOazoBI1SCAc+cxtZ1DYqwLhsj0ee0rbYaj72Wa+ui8scxdq1f
         XVfOTY7btHIFXAa0XWYdLsGaEn9goEFmfqWQfVdpKVwD5OqyB3FskfFPjBZs3OH+xcbu
         fI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685558504; x=1688150504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF8VCrAhn66qLdsXW4ERcJHTpMGUMtRWJ1DJabZuEyQ=;
        b=f+EQ/1wRXaM0dnIbtG4xaoM6CvNMVT7BrPRiubtzKD8qa87hl5jj2jVl95uSoyCXNO
         eDYKIZ4T23/09sRW+uJ/uEZT1SHhKHwSEKx6lG5Jpxw85FyzmnTZx1nJW5iQBVi8qrcz
         51Iq3BWF5o6hCRL48DKdhwF+2Ms//0KHwypVPQhnBq5E2rygmgs/yI1+VsTnmLITHmGR
         1XREaubbp1SlhiWUOTiwmww/wNsi2pt4d9k2hjmrZupsFnaaoAR8Zo5mbsGNuR2liCT3
         HeRauSoupGYXUn0dRiQu1b98K1BetEdqNgjZLGipaoXZTT2TP+wsnOx9FqRKsCBMvsS5
         jekg==
X-Gm-Message-State: AC+VfDy3aa/IdH2eG0OoVys37RvPyOKaSHDJ0kF+pKemqnCZBTN3Rgzn
        B1AybJx77rA2VZoBNp7oV7p4hjhgo1vM/MEqrMlmvw==
X-Google-Smtp-Source: ACHHUZ51wMBQEWCMC+5c+LGx8B/+gMlo8rk89yJlWD7BM/pwexrhob4l54bbfh0y6WLs45h7XR/TLt7eUJsSOGyXR/I=
X-Received: by 2002:a05:600c:19d3:b0:3f1:70d1:21a6 with SMTP id
 u19-20020a05600c19d300b003f170d121a6mr23664wmq.0.1685558504053; Wed, 31 May
 2023 11:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230531104233.50645-1-dqfext@gmail.com> <20230531111602.7ecf401b@kernel.org>
In-Reply-To: <20230531111602.7ecf401b@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 31 May 2023 20:41:32 +0200
Message-ID: <CANn89iKRX2QTgS44Ky6Jua-+UNrFY3E7RCT_7OfG=GnFvAzdFQ@mail.gmail.com>
Subject: Re: [PATCH net] neighbour: fix unaligned access to pneigh_entry
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Qingfang DENG <dqfext@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
        Ville Nuorvala <vnuorval@tcs.hut.fi>,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qingfang DENG <qingfang.deng@siflower.com.cn>
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

On Wed, May 31, 2023 at 8:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 31 May 2023 18:42:33 +0800 Qingfang DENG wrote:
> > +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >       u8                      key[];
> > +#else
> > +     u8                      key[] __aligned(4);
> > +#endif
>
> I'd appreciate a second opinion, but to me it's very unlikely we'd save
> any memory even with efficient aligned access here. No reasonably key
> will fit into 3 bytes, right? So we can as well avoid the ifdef and
> make the key[] always aligned. Or preferably, if it doesn't cause
> compilation issues, make the type of the key u32?

Same feeling, we could avoid the CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS ifd=
ef.
