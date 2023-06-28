Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792BC741B13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjF1Vov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjF1Vos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:44:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF51E9F;
        Wed, 28 Jun 2023 14:44:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3113dabc549so12665f8f.1;
        Wed, 28 Jun 2023 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687988685; x=1690580685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKzFZfaCpIoHAU5rSccfZbDpsuCI+g7GveCYDJ1hj0o=;
        b=W6dPC3eK7fUY3GpiM0Jyugi5l2Mioi7QOOvGIeasVOq+1ObrJ8q5P3TC4IkwMMTBi9
         rRnYYX7Jf/kxwm27Mf571kylJxLaTAk0By130ihnyE2Q6+Hd3mudVzWuBaXkbFPphpZP
         nuUeyvKtK6yi/LIxo0tKoTiaqBMDxGj8hmg26hj5IOBSyAiuUOg/mWhyBaMmEE3/w0IK
         Ofpm0cPSXzs8iaWyN5oQfvhZRMToPLw2OvnJd/L9tCc2HNY3HxlHIacXQKGtWm+QHZ4K
         j3ckThviq0Fot9JPX8zY4sctPntlWIvKb02aPKXcJLGvA4MJw9Dphj6c5F21DCFQkqQ1
         8n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687988685; x=1690580685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKzFZfaCpIoHAU5rSccfZbDpsuCI+g7GveCYDJ1hj0o=;
        b=SMHPj3zQDWbHoqLzTdByvBmoIZ4OZc7ayEYhSm0RT7gKbUkcS/fBjk3Sc1mTdJhw+J
         rUFdfK0WzUSCfNha77w2NLQq422xCQH+nkEQWqVBGRm5s6ZEjp5O8PnAjOuW1ER4+Pk4
         I0oSUIduxQ38Nwph01GsRpsVjjvZQYVi1RyAwqlp4AYQipZAGlmimGGykIWoI/NCNf00
         xq6giUjZV3gc/dXzfUd5nEv5gkJPpxHh0VwJhMPq9S754z1s7RObil+Rqrj8UKeruIJP
         D37AphWlU2sVWhl4iBywxitLeag4WI9qTZElUePfk0FV22yCVYSDEc/xHkyM7jZPnWKG
         cjnA==
X-Gm-Message-State: AC+VfDziCIIzfW4tagvqwDAbStYlTrM+T6ogLq6QzCSNS5TeOt0ofTmu
        yRA4ntcGDHXYm9X9spBX8gI=
X-Google-Smtp-Source: ACHHUZ5t5ivp1MYSN2+SF4n9QuvhQTqNCVa9Oqryzx+g6lCeu6T10FRsZV+vD/CDlu0pny2ytzX5Yg==
X-Received: by 2002:a5d:4a42:0:b0:313:f366:2c68 with SMTP id v2-20020a5d4a42000000b00313f3662c68mr10556457wrs.26.1687988685001;
        Wed, 28 Jun 2023 14:44:45 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d45cf000000b003140c8aa4fdsm2566541wrs.35.2023.06.28.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:44:44 -0700 (PDT)
Date:   Thu, 29 Jun 2023 00:44:42 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: vsc73xx: fix MTU configuration
Message-ID: <20230628214442.5wucuusl6pqudllk@skbuf>
References: <20230628194327.1765644-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628194327.1765644-1-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:43:27PM +0200, Pawel Dembicki wrote:
> Switch in MAXLEN register stores the maximum size of a data frame.
> The MTU size is 18 bytes smaller than the frame size.
> 
> The current settings are causing problems with packet forwarding.
> This patch fixes the MTU settings to proper values.
> 
> Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> ---
> In my first attempt, I sent it to net-next [0], but I was asked to resend
> it to net.
> 
> [0]https://lore.kernel.org/netdev/20230625115343.1603330-7-paweldembicki@gmail.com/

Just like you had marked those earlier patches as "[PATCH net-next]",
this should have also been marked as "[PATCH v2 net]". Patchwork does
complain about that and deduced the wrong tree, but accepted it anyway
and otherwise ran its tests.
https://patchwork.kernel.org/project/netdevbpf/patch/20230628194327.1765644-1-paweldembicki@gmail.com/

I don't believe there is any reason to resend this patch.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
