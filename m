Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C927060B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjEQHFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjEQHFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:05:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D69272C;
        Wed, 17 May 2023 00:04:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-966400ee79aso67832266b.0;
        Wed, 17 May 2023 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684307081; x=1686899081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z7Esw8IunM8cZhsfLcsY4KMd9PtL0pvZaKLywfblNc=;
        b=iDJ0olQPPY0V9Gr0WWmfPlZLcYhXCyupu+V1f6SvEKR4xxA3pFlRAaaFd8lH/ISt34
         pIY3JX2gGFlAuAJ4yEXx7VuRURf+deollo0fI5ypXV2VRDbbl36Jb+mMRQQdOoD/JPVg
         mzERLa9r7VQY8EvWwzQhyciNnEY82G0FzG0S5ZBfrRan52DStw/PTDCZGEaJsUGsJBhf
         s1PZ1WNndFXhq1qO45biB71bzfdY5P8OZ2fuWLdxk5PlO0q3JzvsmKX9jZu1LE3n3jSE
         q3TlYRT3h0OBaccD3YU2SBbsa4WCZwrmk/P8CWPVkVFuH7DefPiMIrHaa5tXmjzWrnzP
         7LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307081; x=1686899081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Z7Esw8IunM8cZhsfLcsY4KMd9PtL0pvZaKLywfblNc=;
        b=aSvfKXEv9BDIa9z9afTrA4rZyvpS+sYZdHpZjwdkM4gVLa40kgv2TEJJHxKa5JHOCb
         1kFEgbTvvpBS4KM39Cjnnjfd2Exo1A9e29g0zQczr1iu+bMXodPvMtjMdJAgwSYbwU3Q
         425x2LLlr7ebMOP9jG74CQ9A43uQM/Q3EmprFA+1q5aUzqipjZnLmprw96ID6eB6isui
         UXw/9PAB1Bbk/Vb8sE3Z7c2g6oLi26UWseooosptI7SET0MWUQu9hzO271fovtFOP88m
         pw+G9awltxL0b0OElTmZxyWYxZadFz8//NBLOwhRfzc4WU7ZUyxcXQpUBN/vlU9uGcmr
         SM4A==
X-Gm-Message-State: AC+VfDx6iVPnLDnn6KrLA5a8ENFGK1xWgahtvsY3K9bcQ+VGkZDsD5iW
        UuTvOnzzIK3bP9RxRuh3X4I=
X-Google-Smtp-Source: ACHHUZ4GCKJ8NGzIEKgVU5XJpLyDXV+CjFOFnzJBOdPV80cbHn7UHnxDzIwplN6K1EFYfgv9qxoErw==
X-Received: by 2002:a17:907:940c:b0:960:ddba:e5bb with SMTP id dk12-20020a170907940c00b00960ddbae5bbmr37886879ejc.43.1684307080624;
        Wed, 17 May 2023 00:04:40 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709066b8200b00966447c76f3sm11892600ejr.39.2023.05.17.00.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:04:40 -0700 (PDT)
Date:   Wed, 17 May 2023 10:04:37 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
Message-ID: <20230517070437.ixgvnru4a2wjgele@skbuf>
References: <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
 <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
 <20230515105035.kzmygf2ru2jhusek@skbuf>
 <20230516201000.49216ca0@kernel.org>
 <124a5697-9bcf-38ec-ca0e-5fbcae069646@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124a5697-9bcf-38ec-ca0e-5fbcae069646@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 09:01:38AM +0200, Krzysztof Kozlowski wrote:
> Yes, apologies, I usually forget the net-next tag.
> 
> Shall I resend?

Probably not.
