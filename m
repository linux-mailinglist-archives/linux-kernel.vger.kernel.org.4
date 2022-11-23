Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468BD635EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiKWNBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbiKWNBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:01:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB698BA5A3;
        Wed, 23 Nov 2022 04:47:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n7so1608118wrr.13;
        Wed, 23 Nov 2022 04:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cGwFNflohw9/AH9gHHMd/XYEUPvOcdY9LmEyE90Q3w=;
        b=nXRACSXZAPVuxShkl22zBOsiIjTtyDvki5+hyP7vbyxka74M1gylWF9bgRNuiwAo3H
         qGWgacsY1pU7dgH6tXzzJW6G0wcp179Q79Hq4lKKJLO8V8ABREGDNn25duRzrTka7zk8
         9S5A2r+VGZzYyAhwzuPW7WDwVymjsebMlaJ8AvT8FmBjuAuEuu3mcA5a+LgiSM7NxjXB
         vQIMOrqxtr0uDuXs1qAO8FU0xUYajqZziAkgiSkeEBpZLFpCIYsVV1yXygAiCL8o+t1c
         R0v5cNhFGwMDNtPcl7GJHLq8NtN01FhVb+x8wJz0Y5I6YluGBA13ZWH233mLN+E5mghO
         WnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cGwFNflohw9/AH9gHHMd/XYEUPvOcdY9LmEyE90Q3w=;
        b=gsIdm3hRzTOGld+yyW9LrNdKRBCIIWoMufWFiiDo6TwqjNhEt5ytAbYuiJ6MHqkQwg
         LAdcZBILLridPO4SApARIg2XIrDcrv81zZ3JyGVhrOwFuvyGbHDAPF/fpFUiWmM2OOZt
         9WmkGwXwHSCEnlyXt8RIhr2P9S0EVUzAsdiA5xCyAtUjAl36LCoQLq+XjL7sjnvl+Hxj
         /DHgUO8Ep7lWIxbLHAcObJZCAi1gT5Sv2IhMdUFy8UURj6Aqhlwqu62/EzrxY4VrFhoe
         QjmsuxTKd/YCnUo/fIUbU7SVZrnTasrn1OceTig/gMUQDRmeVMgeFE/Zm3C0i+lloIYt
         opfg==
X-Gm-Message-State: ANoB5pmgxN9hOOyz9TwlyTLNQykU2veC2G4qkBT271StXOUt4ee5nkhE
        3Y7vCI0kyQw4zd+aCa8BZeqMp2TvGPA=
X-Google-Smtp-Source: AA0mqf4tnkg+6/MR02cbthie6YzblRBnB+Eu4D335qxF1E9BwHOK1h+V12w5rl8cU+w2iLPQk1gXmg==
X-Received: by 2002:a5d:6791:0:b0:241:e58c:6cb6 with SMTP id v17-20020a5d6791000000b00241e58c6cb6mr4248031wru.46.1669207624432;
        Wed, 23 Nov 2022 04:47:04 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm2990693wmq.36.2022.11.23.04.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 04:47:04 -0800 (PST)
Message-ID: <42d51c09-d6e4-52db-ce55-0b827341f080@gmail.com>
Date:   Wed, 23 Nov 2022 13:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] serial: atmel: cleanup atmel_start+stop_tx()
Content-Language: fr
To:     Michael Walle <michael@walle.cc>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221123082736.24566-1-jirislaby@kernel.org>
 <4b9c474a0b32ffe3725ed1cf9f084fcb@walle.cc>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <4b9c474a0b32ffe3725ed1cf9f084fcb@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/11/2022 à 09:50, Michael Walle a écrit :
> Am 2022-11-23 09:27, schrieb Jiri Slaby (SUSE):
>> Define local variables holding information about whether pdc or dma is
>> used in the HW. These are retested several times by calls to
>> atmel_use_pdc_tx() and atmel_use_dma_tx(). So to make the code more
>> readable, simply cache the values.
>>
>> This is also a preparatory patch for the next one (where is_pdc is used
>> once more in atmel_stop_tx()).
>>
>> Cc: Richard Genoud <richard.genoud@gmail.com>
>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Reported-by: Michael Walle <michael@walle.cc>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> 
> Already merged, but:
> Tested-by: Michael Walle <michael@walle.cc>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
> 
> Thanks,
> -michael
Thanks !
