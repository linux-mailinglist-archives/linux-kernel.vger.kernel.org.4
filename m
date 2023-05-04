Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35956F6D81
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjEDOI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjEDOIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:08:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0B868D;
        Thu,  4 May 2023 07:08:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6436e075166so457634b3a.0;
        Thu, 04 May 2023 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683209301; x=1685801301;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMOcf6cgy3EJL9X777q3uHwol0/+UlxMtzCPEFX8tV8=;
        b=oqNIruYXCumhSceFrFEAT9XYgxpnUN0iDT1Spy0hHcVRH55kSoAhekEaAs+UXByAO3
         1mtXMjJF0DbIfNCBRZnhmkXmFIEfFmpWG546ocqCxAeJ386hldOciUDYxUz7xlDw06oL
         9uKqKnQXhhawWFxHgJ+K8ABRBQeaIjtd+mov0+on3BJuBCJyxf1mnAV/ipLbXLovIivj
         +kHeKB1adOnG2CIttQIspZvahQjjZ9wIoC9g8gLvOg8bsS5xCLEmwMrr29CBtMpy7MNx
         Z5oETK+Rdk5NRpczlBvTj0g3WXKb+OyeY9aWql83LKriZDa/Vt/+tilULMZf6YO4RGyW
         DcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683209301; x=1685801301;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMOcf6cgy3EJL9X777q3uHwol0/+UlxMtzCPEFX8tV8=;
        b=PEMGfpP4lz1FUnm8FnhHZ7poVXdQYoj/WZFS0Uz5wVcAkbYtPddutPVVrBdofSUw89
         eqk5hplZO/4Tu/93gF3sWSQ4+SDuaFaJzLLuOhqQ695ipx2xl2UkhfHIFK8JdX3veNIl
         ympE+DEWtDROV2uYSrBrPLsZ6uRULafjHYoJy6G9TLEJeicrHJgAXil7giTk/8DFOyTy
         LpoJQ/6eiTwrhErhJQnSDs+PITKTjnQlilrap28fjOU6aIRe3tpLDtuiut2+tVomu0fQ
         461vi20WW4SI7NunbaHBI2lbKIiDpXuabKCNNtDaN3MfsTZ0cqTR/beqdywsDdJmmACJ
         yW4A==
X-Gm-Message-State: AC+VfDzm9db5zanW0ZoGrKac5GGyT+iIsYld88ddfs6PABWztXvPFGMn
        CdFoRnu0uplvdPSM/HHZg/s=
X-Google-Smtp-Source: ACHHUZ7D24NuztrzV3Zvnh+jqcQojFXyYsd7Cu0NpledM7r4TVVyTPYbSEQdryu2S3vdrraDBEauFw==
X-Received: by 2002:a05:6a00:158c:b0:63b:5c82:e209 with SMTP id u12-20020a056a00158c00b0063b5c82e209mr3057104pfk.10.1683209301003;
        Thu, 04 May 2023 07:08:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b0063b7c42a070sm2576378pfn.68.2023.05.04.07.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 07:08:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6a894ff0-3232-4ef0-5e26-95471cc33ed9@roeck-us.net>
Date:   Thu, 4 May 2023 07:08:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, andreas@fatal.se,
        jun.li@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-3-3889b1b2050c@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/4] usb: typec: tcpci: clear the fault status bit
In-Reply-To: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-3-3889b1b2050c@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 06:46, Marco Felsch wrote:
> According the "USB Type-C Port Controller Interface Specification v2.0"
> the TCPC sets the fault status register bit-7
> (AllRegistersResetToDefault) once the registers have been reseted to

cleared ? set ?

> their default values.
> 
> This triggers an alert(-irq) on PTN5110 devices albeit we do mask the
> fault-irq. Fix this gernally by writing a one to the correspondig

generically ?

corresponding

> bit-7.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>   drivers/usb/typec/tcpm/tcpci.c | 5 +++++
>   include/linux/usb/tcpci.h      | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 8da23240afbe..15632d023e4c 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -602,6 +602,11 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>   	if (time_after(jiffies, timeout))
>   		return -ETIMEDOUT;
>   
> +	regmap_read(tcpci->regmap, TCPC_FAULT_STATUS, &reg);

Needs error check.

Also, I am not sure if this is the correct place for this code. The alert
status is cleared after vendor initialization. Should the same be done
here ? Also, why not just write the bit unconditionally, similar
to TCPC_ALERT ?

Thanks,
Guenter

> +	if (reg & TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT)
> +		tcpci_write16(tcpci, TCPC_FAULT_STATUS,
> +			      TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
> +
>   	/* Handle vendor init */
>   	if (tcpci->data->init) {
>   		ret = tcpci->data->init(tcpci, tcpci->data);
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 85e95a3251d3..83376473ac76 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -103,6 +103,7 @@
>   #define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
>   
>   #define TCPC_FAULT_STATUS		0x1f
> +#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
>   
>   #define TCPC_ALERT_EXTENDED		0x21
>   
> 

