Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3747D706B86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjEQOrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjEQOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:47:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3AE3C0C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:47:50 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f38a9918d1so151371cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684334869; x=1686926869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjzkiJuPebppL5PHKEHl+YDr/Ar5GjBFc+tmVMn+Lxo=;
        b=E3MoMucUDhkzy7jFyOAvi1v7WnFXxqJfkjaffx8CLeDmKk+IU/CcmjSY3LKgjcX1WR
         4pctTT6ijfEJyG3RfIE/qHMseddKPlnSkSpyLLulm321uf78TSVodY+W6mgCvx/XBVyO
         Cz9QgpayJ71hTca9LBOfJRuihTI6WmccbfgCPQRcywudYebkPBK0L5zIxnCkxWq+s/Ka
         dm9YP/Y4EKR/lOJck1jCtac9siHq7bnDXERKp3ZFKYiJ1z8wZbJaoPQonRAJc72dcDap
         XZaZd2XsyyZ7lcT5NA9s0JMWOZV7OkvZ016HqoRUDqXVXRTjNhq//ldDYMO7Go8GrpkQ
         aMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334869; x=1686926869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjzkiJuPebppL5PHKEHl+YDr/Ar5GjBFc+tmVMn+Lxo=;
        b=Qm3iF5z/mWia/3B3rLOOZdKoDcUBw3U36BTqbQPQJ/Ic36bhvJ7FBSvLeDHJMokkuT
         7DseRS4BTxfmAObrzk3ocglSHiINqLq+XPo/vcPb18yyuqg6GEm/cd1x396RnyxRlgof
         XA0EWxtaRgJdWWsAerHoguJRpEeF4kSwhSk8QZj5R/tsRONj1F7kCfKRUrJQPNn+HQ6/
         3fuRRBmXomj48qEuaLNdDAZ52X0BZrcDwVPBucJWJr4TlUktaZscmxkwBBQ2I2mTXOgQ
         EYb6yNTS2o/aR5SlFhbmttzB6v93au2qG5cQFpdojRU5XLC1COac1GzIZ4MT5jwiI0dM
         9wIQ==
X-Gm-Message-State: AC+VfDw/1TMIT8tjBMZPERwDDOGCS1c1y9uXdq+F/iBW3bG9BAmDwZSg
        OSumgf+isDDriNoso0LUcovOz+q5i/sE2X7LVrt/pT+okQDMdStTYKU=
X-Google-Smtp-Source: ACHHUZ5nyLlmmBGkBSbb7f5BECxhRdBK/M+c+pSjlHRLb9R/Z2HILDZpRoJAwVabaSWO1dA6lrzH3b9qdQZ+84TFa68=
X-Received: by 2002:ac8:5c8c:0:b0:3e0:c2dd:fd29 with SMTP id
 r12-20020ac85c8c000000b003e0c2ddfd29mr435931qta.4.1684334869020; Wed, 17 May
 2023 07:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230517124201.441634-1-imagedong@tencent.com> <20230517124201.441634-4-imagedong@tencent.com>
In-Reply-To: <20230517124201.441634-4-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 17 May 2023 16:47:38 +0200
Message-ID: <CANn89iKLf=V664AsUYC52h_q-xjEq9xC3KqTq8q+t262T91qVQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: handle window shrink properly
To:     menglong8.dong@gmail.com
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
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

On Wed, May 17, 2023 at 2:42=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Window shrink is not allowed and also not handled for now, but it's
> needed in some case.
>
> In the origin logic, 0 probe is triggered only when there is no any
> data in the retrans queue and the receive window can't hold the data
> of the 1th packet in the send queue.
>
> Now, let's change it and trigger the 0 probe in such cases:
>
> - if the retrans queue has data and the 1th packet in it is not within
> the receive window
> - no data in the retrans queue and the 1th packet in the send queue is
> out of the end of the receive window

Sorry, I do not understand.

Please provide packetdrill tests for new behavior like that.

Also, such fundamental change would need IETF discussion first.
We do not want linux to cause network collapses just because billions
of devices send more zero probes.
