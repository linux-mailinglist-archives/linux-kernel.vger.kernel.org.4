Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0137C7329E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbjFPIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245581AbjFPId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:33:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A16D30E4;
        Fri, 16 Jun 2023 01:33:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b3be39e666so4165345ad.0;
        Fri, 16 Jun 2023 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686904432; x=1689496432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=r7W2YpiCgw7oCQ3PCXW/fc0lvN+XnDETz4eXDeHajPk=;
        b=QBJDcX12ahEDU3oiRXfENkwYtpK2H41lfLNbf5z4n8fAx0GbHhTHQeTMOPmQJOQ5o/
         v7o8KTdwIZ338wTpTtNspXxI7Ss1m/w80pcuy0nI1emMF4RN/YQ/3AQNM4C+bQoTYZky
         5ubuEv2PBXdndvb69o5a6WfmhMuKVkadAe77zVFmf3oblwNI92wqXrugLR1nM2wC8UNm
         mVYorbvsubd+cbyhToHv6sXz8z1Mk5Ifw7RfxGSEEk1AouVZ4Ir3byN87dZIwsd472O4
         qU6LcivUTWvUqKZfvuq00wCs8kNpsjOvPeGR8DwEO2sfwNN5fQUQzDN3+dEl/M0eWTpB
         2v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904432; x=1689496432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7W2YpiCgw7oCQ3PCXW/fc0lvN+XnDETz4eXDeHajPk=;
        b=LLDOWXOnBix/qbH5U3HXXk+dBgs50Tnz988nxOiNfz9aGVXEUZXecuepUkm6CwvIu0
         HT3uQYoJfkwA/MQy8ZNpmORpjrxnjcNeSdIUPuOib9hws7NcBmOjQjcD8CbcqTQK7Ec6
         k5Z/DEjcUxwi2P67h++AoJOaCvhfUcn6FaeDc8JydrRa8xlbtOoiElWCMWbxwGtM7rUp
         d/I2z2REru0dxqAkOG876182gG+8Qu4gMLmmDR4zro7qjwCoRQUWtajdMSRYpocnq23q
         02lsHwHXfsEZjktl/Soy/WRBD6zOrD7PfDKXr4rAdB/srC46QGfotDJHlFuRP+2oqskQ
         G7JA==
X-Gm-Message-State: AC+VfDxNu8vpkVTgQA+gcQo7N0zPSDWO/yD2g6qt+fbLjQqNGVEbWrfd
        UpExoXTFuzcxxtSiruHC37o=
X-Google-Smtp-Source: ACHHUZ6yofeCZMkq0H9Y2b1OS2wkY+A5CbNG2Lnz4QU7gP9mrnYimT8A3DEGmtJef4zs1Tm4UTLRdg==
X-Received: by 2002:a17:902:f90d:b0:1b5:b28:2ff1 with SMTP id kw13-20020a170902f90d00b001b50b282ff1mr7130875plb.10.1686904431733;
        Fri, 16 Jun 2023 01:33:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001ab12ccc2a7sm15411335plk.98.2023.06.16.01.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:33:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b11a278d-8098-a1f0-7aae-9dc882ab48c4@roeck-us.net>
Date:   Fri, 16 Jun 2023 01:33:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [v4,1/2] usb: typec: tcpm: fix cc role at port reset
Content-Language: en-US
To:     Frank Wang <frank.wang@rock-chips.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230616075241.27690-1-frank.wang@rock-chips.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230616075241.27690-1-frank.wang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 00:52, Frank Wang wrote:
> In the current implementation, the tcpm set CC1/CC2 role to open when
> it do port reset would cause the VBUS removed by the Type-C partner.
> 
> This sets CC1/CC2 according to the default state of port to fix it.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changelog:
> (no changes since v3)
> 
> v2:
>   - Make some tweaking based on the default state of port, commented by Guenter Roeck.
> 
Specifically: Do not set the state to TYPEC_CC_RD unconditionally
but make it dependent on the port's default state.

Guenter

> v1:
>   - https://patchwork.kernel.org/project/linux-usb/patch/20230313025843.17162-2-frank.wang@rock-chips.com/
> 
>   drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3c6b0c8e2d3ae..9f6aaa3e70ca8 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4885,7 +4885,8 @@ static void run_state_machine(struct tcpm_port *port)
>   		break;
>   	case PORT_RESET:
>   		tcpm_reset_port(port);
> -		tcpm_set_cc(port, TYPEC_CC_OPEN);
> +		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
> +			    TYPEC_CC_RD : tcpm_rp_cc(port));
>   		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>   			       PD_T_ERROR_RECOVERY);
>   		break;

