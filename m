Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88BE73FBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjF0MOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0MN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:13:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05CC198D;
        Tue, 27 Jun 2023 05:13:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d9695ec29so2490608a12.1;
        Tue, 27 Jun 2023 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687868035; x=1690460035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5JluRheYFSTMbD9G/QvMPc64BdYHqfR2I9ADndd/+5I=;
        b=Rd55CZxfu7gs/4ZVot2QuJRNc8NhdFoaC95yVDbf4SmQZAoVD4SYU7loDD8lB9YBjM
         PiIvOJJk3QWw4RusjFy+D9SjaFxwUuSJZJPVusRjOxR/oqQVX2FF1CAUILgkctD2jHET
         55jk70AMAogZ3urr8cqY/H4sFMjZopV/7cpC2tMJ/jFwRgH19c96h0WfdJJ7reeWfV4F
         Q7UpSu4DJ4h3rw38qldEqOgbcwqextUsa7RKynRaKUrEHPOiWIHPpkWewyS8udqfOkE+
         yjKNFhF9PloTPAIyr6hKRprZSRNFMhTKgGbQNe1hMN4BH5IUkktx7UlPlrRPiX5R8UrB
         KAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687868035; x=1690460035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JluRheYFSTMbD9G/QvMPc64BdYHqfR2I9ADndd/+5I=;
        b=Kq8GdI6rR8p6AftyXh0BjHvSSCcIKKRUqG3zZaKlp1Efr3R1llvOYa8GSQ1J94gLeq
         E7KR478CDCTv5YCmtST52l2ra09CqZjr7nNbKquiPZDSrjkMS9gG27Tn+/SK993BaH3L
         gpKRnpCqtyqGRDRC7dhy3EoVrXIGvgXHy/FuRcptFUT3VLvTSj+Ij+tPKz3hHJmHCNDK
         EKLaueF3PoiSDBRa0ODNYGy0mPGSkAkCyy75SLqvglQsWpAV9M1j35gUzU/tlsX0j3R/
         Y727h9DzEZFaM4JPaqRol8L3m6p5MkVcZlAUi/uAUe9/s7VlbhCOWVxSdC3VUO0AiP7X
         6hXg==
X-Gm-Message-State: AC+VfDw6NJLn+eGf10Xc+pQoheYJUNySjUuwOlhWF/CY51HHDAS7Xak1
        76ELdIPkPzIaC+zWMUSQt9A=
X-Google-Smtp-Source: ACHHUZ7K+8Eqa+/dcc8+SGtIm9wCcgEBcZEEJyhng/bI9SJ5VzYprFMTw21gc6LIq/28+qqEOTeq4w==
X-Received: by 2002:a05:6402:330:b0:51d:988b:d63f with SMTP id q16-20020a056402033000b0051d988bd63fmr3561643edw.22.1687868034825;
        Tue, 27 Jun 2023 05:13:54 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7d90f000000b0051bc5adc942sm3783491edr.47.2023.06.27.05.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:13:54 -0700 (PDT)
Date:   Tue, 27 Jun 2023 15:13:52 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Harini Katakam <harini.katakam@amd.com>
Subject: Re: [PATCH net] net: phy: mscc: fix packet loss due to RGMII delays
Message-ID: <20230627121352.tsqycdvzyqqpdejb@skbuf>
References: <20230627091109.3374701-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627091109.3374701-1-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:11:09PM +0300, Vladimir Oltean wrote:
> Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
> if phy-mode = "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-ps"
> override exists. The negative error code from phy_get_internal_delay()
> does not get overridden with the delay deduced from the phy-mode, and
> later gets committed to hardware. Also, the rx_delay gets overridden by
> what should have been the tx_delay.
> 
> Fixes: dbb050d2bfc8 ("phy: mscc: Add support for RGMII delay configuration")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

I may have mis-targeted this patch towards "net" while the "net-next"
pull request has not been yet sent out. Can patchwork be instructed to
re-run the tests on net-next?
