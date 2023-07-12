Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D536750D13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjGLPu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjGLPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:50:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4554210A;
        Wed, 12 Jul 2023 08:50:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so11567444e87.2;
        Wed, 12 Jul 2023 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689177010; x=1691769010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTMvrCSeSUDZlPrpdPIgypFGu/BI51rNT6n9Pb5uMI=;
        b=IFH0CJBwpfALVwUUPVcCQbB5H8KL4avks9DpflYKT3m6KpZjJt6Dzoz0QNpm9fnB0K
         V/nVtxcbOOTdHZsX4ay/jdgX24ggj4odm51nZVeXfZyaRlBqe1w2SZTJt8/rhVdnDczp
         l4wu0BYM4bqExERqL45C4vlv4FSP2X8+3luaVcPcu8PD5JR23dsa35TmJc7hazHdVUb2
         iHDRtsM5gJpIyGH/gquoBvqLihJ6Q1nA9jrabmx2cLGE/mkZE30ec7bwF9YXXjh1nW2p
         BGzdLDlkfpUtDNJv9q/FXfKgD5rrABN4Gi2wsIJmKZbcADsUdI4R90rOc4teRAXc5hu8
         mk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177010; x=1691769010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywTMvrCSeSUDZlPrpdPIgypFGu/BI51rNT6n9Pb5uMI=;
        b=AeRkiEGTB8rQs33jjLbbEroJvN0RVkzGmUo56NDRrqWjbZ32J4HLyS32PMDqF738z0
         RcTOF907+ZhqgFZB5PT0UyuLMiQH08dhDzloLdo3a26NLMo7GjHGZ1l5errRK4+9J/15
         +4w4BPrDpXMwAz3zAU54JvmfIAaH+g1bXqV75WXzMtgNZQ9dWIkuzuIg3OifNFcNyI1k
         9lcqkFuHa5YQ4C3+p9LyBzFXxOC9YNcwr9msGex2b4TsCpCYF7MJr0KoQRG9KWK3nL0i
         U5c8hlgSc3wX+sxxGbKPwbfCy9tO5FaDQ7pXcicPqcVrStDJmfnhstONLpWNfgtIqfwM
         NbiA==
X-Gm-Message-State: ABy/qLYtHKGf/S+eilSBDnAiP731dUpDQ63mySxWEddt0N20HP0tROfO
        ChvPWL4PCKlNHvyEh+VU/U4=
X-Google-Smtp-Source: APBJJlHtHhxN5iJSpXaoQUyGr1Fx+5SSUMCYWTxNJkF7sKl+6R/JgipOsjSuX5ZopkcDAGMmAi3g3w==
X-Received: by 2002:a05:6512:1585:b0:4fa:f96c:745f with SMTP id bp5-20020a056512158500b004faf96c745fmr17859273lfb.38.1689177010108;
        Wed, 12 Jul 2023 08:50:10 -0700 (PDT)
Received: from mobilestation ([85.249.22.88])
        by smtp.gmail.com with ESMTPSA id g22-20020ac25396000000b004f85d80ca64sm760367lfh.221.2023.07.12.08.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:50:09 -0700 (PDT)
Date:   Wed, 12 Jul 2023 18:50:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: snps,dw-apb: allow gpio-line-names
Message-ID: <7ik5zbqqveaysyruxpipvzuugabzomu2egr74yfl7avg75qyjk@j2rgeu72s7sy>
References: <20230712074553.35907-1-krzysztof.kozlowski@linaro.org>
 <d25vlma6vefztgggatas7ipn36rumhuodzcalfq7c6apwliy7a@ddgo3fgulv2s>
 <ZK7GqJlXhCIcA/J2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK7GqJlXhCIcA/J2@smile.fi.intel.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 06:28:40PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 12, 2023 at 12:53:00PM +0300, Serge Semin wrote:
> > On Wed, Jul 12, 2023 at 09:45:53AM +0200, Krzysztof Kozlowski wrote:
> > > Allow the GPIO controller subnode to define GPIO names.
> 
> Are we going to do this for each GPIO controller bindings? Can it be done once
> for all please?

AFAIU the DT-binding schemas which have "unevaluatedProperties: false"
property specified won't have such problem since any DT property with
"*-names" is already evaluated by the dt-validate core. Meanwhile in
this case the schema has "additionalProperties: false" property which
prohibits any none-explicitly defined property in the node.

Regarding the "gpio-line-names" DT-property constraints. Alas it can't
be done generically because at least a number of items is device
specific.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
