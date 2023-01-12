Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A54667A94
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjALQRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjALQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:16:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D3B1F9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:13:38 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id jo4so45995438ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzF22PPdIreEIa7ztIOqQnw7vLi6LeZv6ab1mRLDnWc=;
        b=bqsVUJSaXBPpY6v20ecbgsIOho5U3Sj/Z1S91znjlXB1Jsg3nPX3qyf4IobkkjDEXO
         P3HynJbeQkXvir18R3ruJ1/i/jnoXhflHApX/P0aTIL1MP5rKG3XqvZub3m5JfIrSFpq
         mCCHtChSke2M5qtptELzlXxmT13PrRj/8Usjp7CTlVfOvjYTkWsgnPX86dQ3sfkMsiY9
         ONaMNdDkWdZCPbKHtfoj9X261ciUJJ4UagcJlKqy+8P8LaHhUISKztP5uTCepq8+ecgM
         bQliMYX/oE7v95JMxSpySHocLg44juUa4n71Nq0/1aXQuMTLJRZmD3NE1ZGrtUKbXzzx
         q28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzF22PPdIreEIa7ztIOqQnw7vLi6LeZv6ab1mRLDnWc=;
        b=HbGDbp5v2+FVxvsPXvpFy/77A4hYeoPGtnnE85imkexNlnEdUzC8TcPO3jAlmqLuYb
         GtSuRy4GnwqDYsO1w9vTDMnI/GdqDS0AAyVUqCY1sXxwF7l4utU6QKjN1bx6QOfNRTBj
         t+ulMlUvDHulMqbz9bzaC2wqhoabIikxYVrM2WpBfdDEtxrb1riSlxKDMZIBMaEEWhDS
         UTBnJlPGwSvYAgfRE/Hqjc+RuyrQvtyIGk1Ke/Z854IT+YkPzi876iIoCIRjZm8/Hxaq
         8mYe8h5qm+QyUYms3n2zIj/Dy3jIjlzW6uT4DqwspuJY+BRwXH6yG4sa3neVGvRj6ftc
         jTWw==
X-Gm-Message-State: AFqh2kqfSBtJr7IJ5f77ybNH7brLXvna/fsp2duaXThkpHmrqM+6hIaf
        ipfsqIuiteWy7fk1ud/TZcjDmw==
X-Google-Smtp-Source: AMrXdXtYZCHpdQvKQqzV4lS/OMAsuYmj6f65+gzDCKvJSN6Zw32OfQ0O0wyHcgs6+c5Yaj9jqIQAcA==
X-Received: by 2002:a17:907:7f04:b0:7c1:36:9002 with SMTP id qf4-20020a1709077f0400b007c100369002mr83786838ejc.67.1673540017416;
        Thu, 12 Jan 2023 08:13:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906311600b0082535e2da13sm7551792ejx.6.2023.01.12.08.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:13:36 -0800 (PST)
Message-ID: <894ffc14-41dc-9abc-4b13-a1f74212ae44@linaro.org>
Date:   Thu, 12 Jan 2023 17:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Fix driver shutdown on closed
 serdev
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Zijun Hu <zijuhu@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20221229102829.403917-1-krzysztof.kozlowski@linaro.org>
 <397c61e8-d928-4e07-9616-afb315d356dd@linaro.org>
 <CABBYNZJYTfVfBMBvfxx6D9a4T5gbqZZcb7BP5LBa28fOEKuoFw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABBYNZJYTfVfBMBvfxx6D9a4T5gbqZZcb7BP5LBa28fOEKuoFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 17:07, Luiz Augusto von Dentz wrote:
>>> Fixes: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure after warm reboot")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>
>> Any comments on this? Patchwork tools complain on longer line, but
>> without it checkpatch would complain as well, so I assume you do not
>> expect to fix it?
> 
> I did apply it already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=a18fca670e14f0c09c2ed332cf2c6d77a4ae05f9
> 
> Not sure why the bot hasn't responded to you.


Ah, thank you then. I looked at Patchwork and it was still in state "New".

Best regards,
Krzysztof

