Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E343665265
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjAKD37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjAKD3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:29:24 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2671E0EE;
        Tue, 10 Jan 2023 19:29:23 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so8162476oto.6;
        Tue, 10 Jan 2023 19:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=h0nyoR/pePv8lb7AbIl1M+zu+JOCA53u13ysae92ni0=;
        b=DwCph2MoJfPPFXtYCrrPSHEgwMHw07NYr6kJxhPzF5aOv9rXzqT8sUdAdnOYnGFRJT
         WNsoSRqcybv54Qc40/HMlxtgyNuA4zoxe98XefJhF3JeDI8QIGKRV5BJf0jEwchbI1BN
         oBPft9m5Nyq3EIZ0tQGOF2RLma2Ddkwkk5e+Zgun5EfCTB7tRVkqWW6wosCikrzcAqrW
         OJaqkkroCrFFfhcbDNxKfiSA+UkfeSP3+4kGAyyagbDN40ndBBPUYzyRbvwYgrWyzUf5
         k0oj+jj4hER8d+e8NwSBv9gHy2sucwywS29cYOH2xMI8G+uTx5VIxMDthKKFC5sWukFb
         ZDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0nyoR/pePv8lb7AbIl1M+zu+JOCA53u13ysae92ni0=;
        b=i10QKtKxzrCeAfGv1i/L5SMUBr0nVgYO2Z8r46d4k0qWr0iZRn6Td571SW7PHMz6P9
         LKdw7z4lkRlwfZcvbWP1FgpBS/+ZFE08AdD4eQHCm4HROCr/L0o6vw0qqNAurXTFvhU5
         /Ag8Y6VaBuDgbyvM0LBe/kWsmk4QrFyCOH5xEH7jQI1QXGs20emMqBODo3p8mUqpYkAr
         jXAQd/Oz2/kaXGi+GkS3GgvkpMWk0gsiBtll28sJa24W4yq3XNU3U2A5sL3ChcBwV8/h
         ZtFJVPXyA+R/ZsX/Z6c7+B+rIbUtuiQd7IL2fKx6zUewm3PXcbxFrbylgwUP7y/GcC/w
         niww==
X-Gm-Message-State: AFqh2koH+nhi7MghUpyCAkPxT7xqhk/jvzdNNgSfrDFq9+Zws2VmNbYn
        kuoTKbA6Q/t2ok99Nb19iU56APE/uRc=
X-Google-Smtp-Source: AMrXdXvL2U3r1PK4AV7A72qmHVGCVmkhhlHmqDPmFJQyX8tRw0tYFU1C3V9tzchg11NdTvUy+Qs8ww==
X-Received: by 2002:a9d:7a49:0:b0:670:73fc:fa3c with SMTP id z9-20020a9d7a49000000b0067073fcfa3cmr34162469otm.36.1673407763202;
        Tue, 10 Jan 2023 19:29:23 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k13-20020a9d7dcd000000b00684a7b9ee66sm1005926otn.14.2023.01.10.19.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 19:29:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <db4276db-bbec-142a-d306-928421eb49fc@roeck-us.net>
Date:   Tue, 10 Jan 2023 19:29:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] hwmon: remove unnecessary (void*) conversions
Content-Language: en-US
To:     XU pengfei <xupengfei@nfschina.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230111020723.3194-1-xupengfei@nfschina.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230111020723.3194-1-xupengfei@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 18:07, XU pengfei wrote:
> Pointer variables of void * type do not require type cast.
> 

One patch per driver, and include the driver name (ibmpex, powr1220)
in the subject.

Guenter

> Signed-off-by: XU pengfei <xupengfei@nfschina.com>
> ---
>   drivers/hwmon/ibmpex.c   | 2 +-
>   drivers/hwmon/powr1220.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
> index 1837cccd993c..db066b368918 100644
> --- a/drivers/hwmon/ibmpex.c
> +++ b/drivers/hwmon/ibmpex.c
> @@ -546,7 +546,7 @@ static void ibmpex_bmc_gone(int iface)
>   
>   static void ibmpex_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
>   {
> -	struct ibmpex_bmc_data *data = (struct ibmpex_bmc_data *)user_msg_data;
> +	struct ibmpex_bmc_data *data = user_msg_data;
>   
>   	if (msg->msgid != data->tx_msgid) {
>   		dev_err(data->bmc_device,
> diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
> index f77dc6db31ac..501337ee5aa3 100644
> --- a/drivers/hwmon/powr1220.c
> +++ b/drivers/hwmon/powr1220.c
> @@ -174,7 +174,7 @@ static umode_t
>   powr1220_is_visible(const void *data, enum hwmon_sensor_types type, u32
>   		    attr, int channel)
>   {
> -	struct powr1220_data *chip_data = (struct powr1220_data *)data;
> +	struct powr1220_data *chip_data = data;
>   
>   	if (channel >= chip_data->max_channels)
>   		return 0;

