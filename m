Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C067862F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjAWTVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAWTVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:21:41 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0895BAF;
        Mon, 23 Jan 2023 11:21:38 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h24so6727238qta.12;
        Mon, 23 Jan 2023 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wijSUhW3Tz1ccP5fATStmK4LjElgp1Ero3sombWaftc=;
        b=DPmK8sbXrJLv8A69NIDRdl1OnB9QZ1cbN5Y+qzabgDjCyyOsyIGL8rCrGYCgReUy3e
         AU0g4TZbpWMZws/oCPkc9/RiGPCb94Er5YJfLjmfrm24vWKJXQrFjJ9x7CyoNn+bUkN3
         9zOdjcXQfNwOWPEwXKZkNDz0W3mZG3H7fe8Q9g7sWHBPZ4wUv4yn1WA9w1AMAYI0X640
         dF6Ud/WK0cnPP4MlZFnSzPpmh0MDPcgMmLtYg/k6sFzfMHsJnPQAH4F96GnBRvywAZb/
         MAngaMXARqzSjv5hcKGJCvoHHu5p4kD6W58cFMxjWWB/2kWFaQf2vwFKf4FcyEDpUWWY
         TYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wijSUhW3Tz1ccP5fATStmK4LjElgp1Ero3sombWaftc=;
        b=y/jKtD1bVYfdXTz+enXh+Bcs0Zlv+SNy88MCb3+XccikepPeRHgwqWc3Do4dmfWZUc
         mfL2KaL5sTEjQFXqd9+MEIy/uwmZKYQn/6I4TqTZGverPk75DKnMCoQ8BO+nWJHDb9wl
         w29M6WGnWlY6b75v+ORB3A6rgkIMv1mUU8duKgrVBcWsIHgD5+5tq3nx1e5ZE8pO/9Sf
         vU8lB9WDLEfS0L/Ecq5IXMz7+qhFGcvc1De4BCDaBnUKFj9QXdAKtQfRkGbnaidjKyV9
         /s140oBLt7MbgkbJq+5bKKHayQcg4Tr5DaaNb+q2UXuKN7MgqFCj4AmuC9wzcoQPfMTR
         mi9g==
X-Gm-Message-State: AFqh2kr77z6R/PHVCOhFXFj2znti1VPlR1RgHt1EA4KGSxODjszaZTsY
        3zLHz2bQmwXI5n1B7ElbCfs=
X-Google-Smtp-Source: AMrXdXvQM8Yk0DmKkPMO/qog4YE4pzbVgTTvB5zQzmhY1WBGqPbsLv+3E1SQ9yHe8y9OzRsZugn73A==
X-Received: by 2002:a05:622a:1aa5:b0:3b6:a1fd:19cd with SMTP id s37-20020a05622a1aa500b003b6a1fd19cdmr23679694qtc.46.1674501697586;
        Mon, 23 Jan 2023 11:21:37 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w25-20020ac86b19000000b003b63c08a888sm10486470qts.4.2023.01.23.11.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:21:36 -0800 (PST)
Message-ID: <bae874f1-7f1f-d6e4-47f7-19d90bdb26af@gmail.com>
Date:   Mon, 23 Jan 2023 11:21:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/6] rtc: brcmstb-waketimer: compensate for lack of wktmr
 disable
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230120190147.718976-1-opendmb@gmail.com>
 <20230120190147.718976-4-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230120190147.718976-4-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 11:01, Doug Berger wrote:
> Since the WKTMR hardware block cannot be disabled it is necessary
> for the driver to accommodate for associated timing hazards. This
> commit targets the following possibilities:
> 
> A possible race between clearing a wktmr event and the alarm expiring
> is made one-sided by setting the alarm to its maximum value before
> clearing the event.
> 
> Programming alarm values close to the current time may not trigger
> events if the counter advances while the alarm is being programmed.
> After programming an alarm, a check is made to ensure that it is
> either in the future or an expiration event is pending.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

