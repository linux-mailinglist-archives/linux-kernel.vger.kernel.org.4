Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65943628FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiKOCCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbiKOCCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:02:24 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9346817077
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:02:23 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so11946207pgh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmJ3WVaf971ZjU4+2fbtOTXgV6BCS6K8+zrP1YYCla0=;
        b=EfNzlZr3IsUeGSufFh31qoO4hs34DdGwSob09sGJ/Kx9BTEqneKIgycxZktE0IUBki
         W5t3GzN8Hi/eJSU/LOgCswTBpzGuj6CioC7dn7oYq09phiZX3gXJkH0BK2xDmeaFhPhu
         xbahOmn466w99CE560SZQHnXHabpZLRUw5VC4xMfFjQ2nvUeeaqe2ODjr1DhISs5ITHn
         jFU8Ae+znyuJRorJs0pR5i7H1Iq2waQq+tfLVx54YYGs4PdbQfynYX82/BYPZoNiFUHF
         iABznkPDxhMrefED4JR0TBv6L/A5eeUNydCTVtSHZlOcd4H0umagyIInVt7cGNYgdOoH
         q1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmJ3WVaf971ZjU4+2fbtOTXgV6BCS6K8+zrP1YYCla0=;
        b=vMZ2F+GGeDqYgbkU0UVH+4UcYuByLDphxzhns26eSBpEdIYsGIyk4giBHZSmzLXNcX
         i7GIjjwiw6H6r5IV6OG+r8JmbDA3bz16eFKOn+1QydqMt655v0wSqs3B2TCLCtKLIP97
         6ljNIj7YjZjPJMJv/C1cLt8UU4ogVs+Lwunt7ex0ALZKES5g7E67o0914i2AxSmCHRTb
         Qqc655fVt+608glJiibnz3qmF6jD+tI6FjO80C8WfLNQ3NkRy9uoP+MraqRvCXqryuSI
         44U8uoIwe98tCuRskuobgxFqZ0wbV3lorzxm32qmoJyyHF/IHkzS+k0P6bDF0dH54wRU
         Nl0Q==
X-Gm-Message-State: ANoB5pl3u6wy0UxmpXms5euVKhmb5P2WMOt+vosXkjVUV5+x0VQ3AdtC
        hUWkspKAPFGUNm0tBoW3N2lw7PUPzasClw==
X-Google-Smtp-Source: AA0mqf5qfYh941ljJwblEN4jOl7IZk3RSBx4ODAwqwTr+huvkqndZ6JMjT6kGqecE7gxWZ5m89jP6g==
X-Received: by 2002:aa7:8434:0:b0:56c:12c0:aaf1 with SMTP id q20-20020aa78434000000b0056c12c0aaf1mr16317032pfn.50.1668477742550;
        Mon, 14 Nov 2022 18:02:22 -0800 (PST)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id i187-20020a6287c4000000b0056262811c5fsm7409601pfe.59.2022.11.14.18.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:02:22 -0800 (PST)
Date:   Mon, 14 Nov 2022 18:02:19 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Jamie Bainbridge <jamie.bainbridge@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tcp: Add listening address to SYN flood message
Message-ID: <20221114180219.0a9900f4@hermes.local>
In-Reply-To: <CANn89iK-X6hz0F3g1+J52cxVvm7LNizNa5fmnhpyCMJeYZBbaw@mail.gmail.com>
References: <4fedab7ce54a389aeadbdc639f6b4f4988e9d2d7.1668386107.git.jamie.bainbridge@gmail.com>
        <CANn89iK-X6hz0F3g1+J52cxVvm7LNizNa5fmnhpyCMJeYZBbaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 09:31:38 -0800
Eric Dumazet <edumazet@google.com> wrote:

> On Sun, Nov 13, 2022 at 5:00 PM Jamie Bainbridge
> <jamie.bainbridge@gmail.com> wrote:
> >
> > The SYN flood message prints the listening port number, but with many
> > processes bound to the same port on different IPs, it's impossible to
> > tell which socket is the problem.
> >
> > Add the listen IP address to the SYN flood message.
> >
> > For IPv6 use "[IP]:port" as per RFC-5952 and to provide ease of
> > copy-paste to "ss" filters. For IPv4 use "IP:port" to match.
> >
> > Each protcol's "any" address and a host address now look like:
> >
> >  Possible SYN flooding on port 0.0.0.0:9001.
> >  Possible SYN flooding on port 127.0.0.1:9001.
> >  Possible SYN flooding on port [::]:9001.
> >  Possible SYN flooding on port [fc00::1]:9001.
> >
> > Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> > ---  
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for cleaning this up.
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
