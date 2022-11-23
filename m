Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3659963674F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiKWRdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbiKWRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:33:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F66885162
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:33:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so2738687pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMav1MoLnlovR7wauioRwnzBkg6agxKz0diAzOaiymY=;
        b=uQk48qc8RxNQ3vdF2jt//Dx6Y6u15ctAKMSb43mWo/sbHtZm7Hb8i80uMZGxIJrEgg
         i/teLSbsfsw6TkjsHYXU+ZiH33Yxtn811y0YZx1If+3OdPF2l3XMEJxHA8qwGcJ6Pog0
         wv4G1fajI+kvV93KU8//hgn8rhFI5vzJcpCDiPZxmoDGp6opxmeEL5TAHsjESHmkfTqi
         IKJmj+ZY+hMeQYRKzEvjejSKPNnU0tnDrzWibCQk1oV9cvkExuol/JK8ccfr+gSWu5t6
         g+7A9fwOCozqxrQoRGrsnjbIZtoq6rQ25MIMU8t/fdueECofcNQuPsBMS87gypYrkSHf
         2QcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMav1MoLnlovR7wauioRwnzBkg6agxKz0diAzOaiymY=;
        b=Rq4Yx5RotCSZUql+0nMvQ/t+5vsZQtNQlZx8BdenjByTqlUCzI5HLpcEx+BT4SgNjQ
         iI8IJvKycknLPwarNY5GMcoz8GCd/Sou/SO4TPiKaJAHvBxNHj8vdSatJLMX9N7nBYLv
         Bo+XSBXTM0IdCy0yzK+o0PsJbYCkqXSX0euC3vTTzhQS15LepUYtgRD2r5iKSquVLr97
         Xk34P546hAzG7R575/OwHzV5p2lgrQWva9L2GaxZnHO4qdAz9/bchKM1L+5yrMBDDhoS
         +oAhz0Z7xtouq7pJ8hTFVD/IgNOSB6KzF4PLB3pPAJrn2EvgHe/3COHCAho/jvxK8Sta
         86LA==
X-Gm-Message-State: ANoB5pkQpt7yGHNkSP4LOV74+SC8jlKbZwjOdJFrdA+IOYZKCu66pdmV
        0JwoxQ4+Xhp/PrRvnWBhcze+qQ==
X-Google-Smtp-Source: AA0mqf4WqLxxdXhfKDPLxWyUcqM26bK2hgFSm1DPmYLJL1nGrkggO31sxqSMLdpb+g5jh57m36xZQg==
X-Received: by 2002:a17:902:f643:b0:188:9ae7:bb81 with SMTP id m3-20020a170902f64300b001889ae7bb81mr22748148plg.66.1669224814860;
        Wed, 23 Nov 2022 09:33:34 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id l125-20020a622583000000b0056baca45977sm12925932pfl.21.2022.11.23.09.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:33:34 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Frayer <nfrayer@baylibre.com>, nm@ti.com,
        ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peter.ujfalusi@gmail.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        grygorii.strashko@ti.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     glaroque@baylibre.com
Subject: Re: [PATCH v4 4/4] net: ethernet: ti: davinci_mdio: Deferring probe
 when soc_device_match() returns NULL
In-Reply-To: <c3ded2b8-cf99-36ac-7152-5a23245a2e9c@ti.com>
References: <20221108181144.433087-1-nfrayer@baylibre.com>
 <20221108181144.433087-5-nfrayer@baylibre.com>
 <c3ded2b8-cf99-36ac-7152-5a23245a2e9c@ti.com>
Date:   Wed, 23 Nov 2022 09:33:33 -0800
Message-ID: <7ho7sx8tjm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

Vignesh Raghavendra <vigneshr@ti.com> writes:

> Hi Nicolas,
>
> On 08/11/22 11:41 pm, Nicolas Frayer wrote:
>> When the k3 socinfo driver is built as a module, there is a possibility
>> that it will probe after the davinci mdio driver. By deferring the mdio
>> probe we allow the k3 socinfo to probe and register the
>> soc_device_attribute structure needed by the mdio driver.
>> 
>> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
>> ---
>>  drivers/net/ethernet/ti/davinci_mdio.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
>> index 946b9753ccfb..095198b6b7be 100644
>> --- a/drivers/net/ethernet/ti/davinci_mdio.c
>> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
>> @@ -533,6 +533,10 @@ static int davinci_mdio_probe(struct platform_device *pdev)
>>  		const struct soc_device_attribute *soc_match_data;
>>  
>>  		soc_match_data = soc_device_match(k3_mdio_socinfo);
>> +
>> +		if (!soc_match_data)
>> +			return -EPROBE_DEFER;
>
> I dont think this is right way to detect if socinfo driver is probed.
> Per documentation of soc_device_match() , function will return NULL if
> it does not match any of the entries in k3_mdio_socinfo (ie if we are
> running on any platforms other that ones in the list)
>
> Note that this driver is used on TI's 32 bit SoCs too that dont even
> have a k3-socinfo driver equivalent. In such case, this code will end up
> probe deferring indefinitely.

Yes, you're right.  This is not the right solution and this patch should
be dropped. We'll need to have a deeper look at socinfo to figure out
if/how it could be configured to support a fully modular kernel.

Kevin
