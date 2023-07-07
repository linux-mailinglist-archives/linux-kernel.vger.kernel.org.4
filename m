Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9444074AA05
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGGEnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGGEm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:42:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513131BD3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:42:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3094910b150so1457290f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688704975; x=1691296975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI0JfG+2wXbxf1pqPY+7DglyNjX5vnvsMEBj9nCkTfg=;
        b=xdr4df1nrlrnwJ/IzEHovIByEoZcLDulB+wFb9fmhb1SFw5YlUI67MoVQtik8grWaU
         dtoDjWQhI7rHhpIQ/aELZJ/srTEYk3iflwkuszmsCjHyC5kU1q67uqUak47nmn06Hmco
         aYLOKY1fGiiw6j0s6cqse7vvzhvpNjhG/9asU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704975; x=1691296975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI0JfG+2wXbxf1pqPY+7DglyNjX5vnvsMEBj9nCkTfg=;
        b=XipVpN2vWeO6UOtiNAPNRCwjd2nQNufgrOqSyQxL+UtgXTRSfbZuKK3Nz/YBlQodGp
         T4kqANt/iE7QBJk/t9wKIa7et9KQeCeoQjPSiW7GIQMxz6L6p3/BG7rqdmvYc6TxWsP/
         R0V1uG6vLjYzHoXrdrKxKeqjKEkqKtlAt1pD2AedffGNb8Bt0iNr878l51wZcPDsMsIP
         atiJOuHh+Yz/ebGolze73anpznsNuUyoL5wIZv+YbZBX3N+iEwG2Ar0NU0QJOYDWiHaY
         I1QQcao97W+7sMVR6RDgOQK7+bYjA33uXlLRcuUoyX+Ncj7/M6UFIcdgbiYQPPWFbKXz
         d3xg==
X-Gm-Message-State: ABy/qLaF7jxbsq/zGbP6IzBUcLibkeedTKET9qCZxPZT3VOzsOrOdK25
        c///QAiKDwydG4JlVnYpXWgkH2u/ZpcmuGlFZ8pkxhYH4cecTypQ0B41mQ==
X-Google-Smtp-Source: APBJJlF82yoElBEn+sVtWYeqOosGQMBJuWFaWZdcBAjc3tOYYkbwFWLXggng6BqvzZwHzRW/YKlMx46V1JWIqOPc4i8=
X-Received: by 2002:a5d:4e46:0:b0:313:f1c8:a963 with SMTP id
 r6-20020a5d4e46000000b00313f1c8a963mr3242664wrt.2.1688704974750; Thu, 06 Jul
 2023 21:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230706172237.28341-1-ivan@cloudflare.com> <20230706191710.5f071724@kernel.org>
In-Reply-To: <20230706191710.5f071724@kernel.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 6 Jul 2023 21:42:43 -0700
Message-ID: <CABWYdi2H2Z2ugB_0m7Fo=dkfP_TbGqak8mfhL-m5FWMRe+UZpg@mail.gmail.com>
Subject: Re: [PATCH] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Satoru Moriya <satoru.moriya@hds.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 7:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  6 Jul 2023 10:22:36 -0700 Ivan Babrou wrote:
> > The tracepoint has existed for 12 years, but it only covered udp
> > over the legacy IPv4 protocol. Having it enabled for udp6 removes
> > the unnecessary difference in error visibility.
> >
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")
>
> Doesn't build when IPv6=3Dm, you need to export the tp?

Thank you, I just sent v2 with the fix:

* https://lore.kernel.org/netdev/20230707043923.35578-1-ivan@cloudflare.com=
/
