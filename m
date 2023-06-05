Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB4723179
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjFEUd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFEUdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:33:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE2894;
        Mon,  5 Jun 2023 13:33:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3094910b150so5438541f8f.0;
        Mon, 05 Jun 2023 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685997202; x=1688589202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FVlR5c2/WvwJOLQve/zeHEZhnk0qDgV8/Te/9/yeBw=;
        b=hSjCpLQSJ06FlUJhr4lYmJSvPZbqvRBsbaY6eHiuIZJP8vqNEuvA+tvOK4FkvCbm4l
         tmeqK3UoKOrVzI6L+QQDRNPOUqFjBBSZmwG5teqVrsiwFApdC8rYQea1j76c8V2HlOxC
         eIPkXmWNEz7wPrXVPl+SfticNAd1a4IUTVYpj/lT75GTBfiaCn9Md1hZRmM9TWbR6NTj
         zYokURN9fo+dZ+fBdo60mpIfcH4WYXZ0oy3c+kj8To4R1W+WHpetTdVwyNFBBp4EWKEP
         S2KP5Zt1RDvH+xubeTpx6j5EHD27O+LEee4Bx+N4kGXVAuLouKwUM76BE9vnz2pGlEWC
         Rp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685997202; x=1688589202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FVlR5c2/WvwJOLQve/zeHEZhnk0qDgV8/Te/9/yeBw=;
        b=bWPtI5q1TbfoqUuWu24wa4MtLw5Kb1PG8ZERMZ3teMvUVpAHVbs4VuaIiMTlsPpkXD
         9wKmCdmrY/Oc2TJGz0zIXrC94EKUbLlJkbLDcuXnUD+VZAVwsrVIYPpSQFG0Vp7kA1Gz
         tropt8ucgoukZt/qwoXeD8QJuS7bKT5Gg+oCxmb2Z6/V4q2TT6SRSUELR6fiT9KqL05q
         ecasNgYRyKvUH513yG31r6aWupYIuEBFvvqCtcqQzxy3Xyq6+rWg9Zt7mFeMDkc6qHld
         g/MIHzrIrWD4D597UHgbbPAFb9a9uPTm0ufoLvLCfTUhma3qufWySjI1mcFAKQhD/QAQ
         QvHg==
X-Gm-Message-State: AC+VfDyzxblbLK0PB2ueFULmUP6dGMUV8kbuHul4ZOPnJ+fw7i9DTCy5
        dZQWGucoF7GImaRzNG7bORE=
X-Google-Smtp-Source: ACHHUZ76iU5P6O7/YW8mDILgf4kOC0/R/6d5lCrSwmRZhZ6buN6+1sEPvdX/sjUsvqebMIOa+wh5Ow==
X-Received: by 2002:adf:f18c:0:b0:309:4999:7549 with SMTP id h12-20020adff18c000000b0030949997549mr30641wro.46.1685997202207;
        Mon, 05 Jun 2023 13:33:22 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c1fe:b00:f181:5e69:a6b8:882f? (dynamic-2a01-0c23-c1fe-0b00-f181-5e69-a6b8-882f.c23.pool.telefonica.de. [2a01:c23:c1fe:b00:f181:5e69:a6b8:882f])
        by smtp.googlemail.com with ESMTPSA id w17-20020a5d5451000000b0030631f199f9sm10605261wrv.34.2023.06.05.13.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 13:33:21 -0700 (PDT)
Message-ID: <590d4dee-2c72-e25b-af5d-3c2290f03bd4@gmail.com>
Date:   Mon, 5 Jun 2023 22:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 0/3] net: phy: realtek: Support external PHY clock
Content-Language: en-US
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20230605154010.49611-1-detlev.casanova@collabora.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20230605154010.49611-1-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2023 17:40, Detlev Casanova wrote:
> Some PHYs can use an external clock that must be enabled before
> communicating with them.
> 
> Changes since v3:
>  * Do not call genphy_suspend if WoL is enabled.
> Changes since v2:
>  * Reword documentation commit message
> Changes since v1:
>  * Remove the clock name as it is not guaranteed to be identical across
>    different PHYs
>  * Disable/Enable the clock when suspending/resuming
> 
> 
Not a big thing, but if a v5 should be needed:
Please annotate the series properly as net-next (see netdev FAQ).

