Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB17346BD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFRO7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjFRO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 10:59:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A7F137;
        Sun, 18 Jun 2023 07:59:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3113da5260dso212882f8f.2;
        Sun, 18 Jun 2023 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687100376; x=1689692376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3UET0shp1xmJOw5iR68Ak8a2LnJN1Rr1uwDC5VIx7JM=;
        b=lrCsehFlyBYPH+CaKmou+2CavPOTXznzITfs2HlJeWAF8p0eue9cQ9HnigRJ8DtmIB
         F992uuvrQh8fcFbdKreH61iXTqqtvX/My/uQimAToujdrCWNnLc3WCiaBURh6LNd74Bc
         E4fUeytXCxuAgqHmJQzrio7v7IxkNltD88ULyvZhQU89BGufigQkRWHxEDDm5qy65vsg
         ULS8xojElqwuwyqAqxEs03i0fNIvv8o59ZCvY9sLYtBLnJIO34oUxBGFnCFLmY3J+Q/u
         xi5lcPI7BJPy0dw969FraAKUV3FgiRbkUnQpY/uxv2Q1iCb+h0kr0TIqwqVJ4fD50ucp
         Tp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687100376; x=1689692376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UET0shp1xmJOw5iR68Ak8a2LnJN1Rr1uwDC5VIx7JM=;
        b=MXJQxcVHKP7ceEtcsB8kTkk0WDbeJVB6C7VbtVG7+tI2b3kETCYiDPcFM4la91qCKk
         v6b3VNl4sZcoIwsPxZvuy8CDFPZeq6PdPd+e/qmf5/qwFRX8xt9xRgJ1PWKp7NpId6cb
         JJ0eTNGRiJ9hWN2Z18aqpF/D37bXG3sqGQLlzBjFjGH1uDQ/6ROGzePsThEwsYKFC14+
         WoIN0utMuqnMtS0PSWYY9Fo818/MF+Uo6u2XztA2d+QpRifSg47dHg8whVw3L5A0hMiS
         7IWJntso0ozbZqzIOHq5H6gvsSnT9+dC31hUWdCAF51/1mpR+/0EpLFNZA4vlXy22LvY
         IWng==
X-Gm-Message-State: AC+VfDy3BKiRKgxssGACUXu8xpZYhOpaHKejIBaM7YTgzz8k7rrIFtU4
        2DEEU8Q5wyhSMfJJBemihhM=
X-Google-Smtp-Source: ACHHUZ5NBZP9xA0hZtkS2wpHlFztw8A1yMf9A3FaHC/6Fdzj35doYsNwA0obQSJqASYDtIuFq66rdQ==
X-Received: by 2002:a5d:5005:0:b0:309:5122:10a3 with SMTP id e5-20020a5d5005000000b00309512210a3mr4730044wrt.48.1687100375961;
        Sun, 18 Jun 2023 07:59:35 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b00311334c7fabsm2984223wrn.16.2023.06.18.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 07:59:35 -0700 (PDT)
Date:   Sun, 18 Jun 2023 16:59:33 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ARM: dts: bcm28155-ap: use node labels
Message-ID: <20230618145933.GA22291@standask-GA-A55M-S2HP>
References: <cover.1685127525.git.stano.jakubek@gmail.com>
 <cb52d36db90fa24e40fccc69724a685344f2c2f3.1685127525.git.stano.jakubek@gmail.com>
 <20230608221107.2982587-1-florian.fainelli@broadcom.com>
 <e7b68810-e886-c0ca-0a5e-4fa6ac3cd7cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b68810-e886-c0ca-0a5e-4fa6ac3cd7cd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:31:28PM -0700, Florian Fainelli wrote:
> On 6/8/23 15:11, Florian Fainelli wrote:
> > From: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > On Fri, 26 May 2023 21:30:50 +0200, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
> > > Use node labels instead of nodename@address for BCM28155 AP board
> > > to simplify its DTS file.
> > > 
> > > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > > ---
> > 
> > Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
> 
> Dropped that one since the kernel test robot reported build failures, please
> fix and resubmit Stanislav, thanks!
> -- 
> Florian
> 

I'm not actually sure how to fix that. The interaction with the bcm59056.dtsi
seems pretty weird to me. Though I could just be missing some obvious step,
I'm still pretty new at this.

Any hints would be appreciated.

Stanislav
