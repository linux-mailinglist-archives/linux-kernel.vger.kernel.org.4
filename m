Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B4F72CEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjFLSvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjFLSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:51:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66EF184;
        Mon, 12 Jun 2023 11:51:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977e7d6945aso829521566b.2;
        Mon, 12 Jun 2023 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686595873; x=1689187873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hM2bcW1LFJ85TQw0TjBRJcRn+H5yaOsbrGxlp/leb9I=;
        b=VMSwAL45vFsVVj8p7peRFkBaI6gSYrmDq87jds5qA+lCMNVJOC1REo+++nzWEpRBYu
         9DDmWmSaJpCOAnXoW/Mx9N+6thP/Qc9j4tIs8timUmlTstzev/IncMnsLcwt+lDGfOba
         zkELTMcZ3R8b8+oSQ8bP85iyZBGF9JRqhLrOY0xQkOy4EX8jj3w4gjJgyzVkJw58PeUb
         TiNpGBlHyQ09hJjcgB4EERzNRjnPPpBEobQv54Cn6jMiywACEV6h4Op8EyVpZqdCiWi/
         wVhuuns9VCtzhiLg+KL7JEbap82DormDNZj4VJewAhAScyvuchaej/gd/wl+57BYn+js
         qvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595873; x=1689187873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hM2bcW1LFJ85TQw0TjBRJcRn+H5yaOsbrGxlp/leb9I=;
        b=SJ50+F9bnNJaj1nvsDoF4hV5yM6koTvsnyc2j2jYBYS78uVzkstVfpju8mdDmV2BO0
         hWH3xT+JBpB78ZTQlT2PXP7Oe4NsotA8KUUwnLkdhFVeX0Rq8LVsYQFk8bDYnyJIuy8l
         4poCW9e8v5TrlPnUZSkGIHVuRFLD3LqgECVTz5OexnvWqBlqsUXO/utdLXcSFK0M0hWH
         BAYumqvY1RrkK7sOM4zq+28cV52ABQ+Xx0ygwFUdG+Fr/bT34lo1JQJ6mz+J9iWN9OsO
         MfW9bq0rqdOzKr4/7tlwaS3T/T9f7gClNUjbfRXCFjLAYu0MU8SIBnfTUwBnerZYdq0Y
         l+xg==
X-Gm-Message-State: AC+VfDy+ivGIcgt3qMppcmjy1fEzyzPjL8tVvm82VVxnWIaaTG768pCH
        LwWbIskD3usH/4mWJZh8M7o=
X-Google-Smtp-Source: ACHHUZ5Y7dSfCYK2WBlnOA7CjvQw7wU+Bi+lLhXU89HZaR++HSJ9twQY7g5PlxTIYuJR7OR4LGobdw==
X-Received: by 2002:a17:906:d555:b0:978:b1fe:99b8 with SMTP id cr21-20020a170906d55500b00978b1fe99b8mr11068382ejc.56.1686595872979;
        Mon, 12 Jun 2023 11:51:12 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709061b4600b00977e4c1727esm5524760ejg.29.2023.06.12.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:51:12 -0700 (PDT)
Date:   Mon, 12 Jun 2023 21:51:10 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: implement egress tbf
 qdisc for 6393x family
Message-ID: <20230612185110.bppazw2mgbyoj6nz@skbuf>
References: <20230609141812.297521-1-alexis.lothore@bootlin.com>
 <20230609141812.297521-3-alexis.lothore@bootlin.com>
 <d196f8c7-19f7-4a7c-9024-e97001c21b90@lunn.ch>
 <dbec77de-ee34-e281-3dd4-2332116a0910@bootlin.com>
 <176f073a-b5ab-4d8a-8850-fcd8eff65aa7@lunn.ch>
 <bb799b06-8ca8-8a29-3873-af09c859ae88@bootlin.com>
 <CA+sq2CcG4pQDLcw+fTkcEfTZv6zPY3pcGCKeOy8owiaRF2HELA@mail.gmail.com>
 <20230612094321.vjvj3jnyw7bcnjmw@skbuf>
 <CA+sq2CdkfuMWE4jf0QEQc4w-2Nb45nER64BV8EbSroJcYi=__Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sq2CdkfuMWE4jf0QEQc4w-2Nb45nER64BV8EbSroJcYi=__Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:53:06PM +0530, Sunil Kovvuri wrote:
> On Mon, Jun 12, 2023 at 3:13 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > Hi Sunil,
> >
> > On Mon, Jun 12, 2023 at 12:04:56PM +0530, Sunil Kovvuri wrote:
> > > For setting up simple per-port ratelimit, instead of TBF isn't "egress
> > > matchall" suitable here ?
> >
> > "matchall" is a filter. What would be the associated action for a
> > port-level shaper?
> 
> As Alexis mentioned I was referring to "matchall + policer".

The idea would be to pick a software representation which matches the
hardware behavior. A policer drops excess packets, a shaper queues them.
This hardware supports some sort of egress rate shaping.
