Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5F27329FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245364AbjFPIhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242697AbjFPIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:36:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE8ED;
        Fri, 16 Jun 2023 01:36:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666729f9093so564329b3a.1;
        Fri, 16 Jun 2023 01:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686904617; x=1689496617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nUlEB85EedtTo7OUJk0cAfjzVwwMnBPTvHZqfkQyPPQ=;
        b=VDDnrIpw3pzhevob8HGkFgTUouneIhx+sEiJKDzhrJ02OIZnMMBuWDmwfeUh9M0z3Z
         JfcMSiUuJW/htSld08DMgr1rZ+oL/rA/miIF6T3cZYs0Ut4TnEpOJbW+xmm9eMDam9bm
         Ba8rS/Q7IBwFFWjwXmCKgpAqJyLQcKuW2qwDDbLmM5EGhRhtkFwbO+X+W5cYjhWrZFA1
         jvBC6tuTv5JBnApGykloAtYOi++oajLeLIgdfYUs92GI11FNhNkbd444Zc+iSMB7K0Bs
         +ORiQEdCGZ+n2XfO7J0qCu5xaBjKtXB5f3+5OuUg1zKU8DG3+b5s2rIMEgrsIIozP7fZ
         GV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904617; x=1689496617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUlEB85EedtTo7OUJk0cAfjzVwwMnBPTvHZqfkQyPPQ=;
        b=PIg20hdIxd/7NNDmDVbSNwvYiIorVmOrM5K/0tJ//Y7DqmOMnS7iE1UUJzRBxxhLsH
         t4+OBQxMJ2dRsT5NXM9jvBKVVZKFKVY5MyeEeuufhaqXPPACdxKSPVEsc7bvwy2InmNo
         65MRHLl3GFXhcF8EH2RcLv0eeyS23TssKq6RZoRiyTWQgtYyTQI9btFkUagDOQbu123F
         UFH87SmB3hY56plnMXOPNfkN+vKEpON8A/KWeZb4LxlRXAp9cMg66k8olEO6Par+0GPB
         rKIRQ5CvxFGxEh1cxHZ+qxIk5foLtQ+zLUX+vQR563rlkO6dmLiJr/dmVQz+q9LXD/QB
         YFqA==
X-Gm-Message-State: AC+VfDyczOh3VN7+dCU01yEa4SHGvlGm24HBNUsRJieOIUg5DdouxeP3
        9rvgLl2SdH/4xEDlinW8nKc=
X-Google-Smtp-Source: ACHHUZ6nqK4iJUI8WPqvd41ASoWrx39rLHYtAhosJEBQ+9LNfrs4NjOhNzdcaUXV5CkIH3x0fpgH6Q==
X-Received: by 2002:a05:6a00:1515:b0:658:8eae:a8de with SMTP id q21-20020a056a00151500b006588eaea8demr2130852pfu.4.1686904616766;
        Fri, 16 Jun 2023 01:36:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 26-20020a63175a000000b0053f3797fc4asm13966589pgx.0.2023.06.16.01.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:36:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <df28b348-28c4-a1ef-1d7e-46a60911ebc4@roeck-us.net>
Date:   Fri, 16 Jun 2023 01:36:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [v4,2/2] usb: typec: tcpm: add get max power support
Content-Language: en-US
To:     Frank Wang <frank.wang@rock-chips.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230616075241.27690-1-frank.wang@rock-chips.com>
 <20230616075241.27690-2-frank.wang@rock-chips.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230616075241.27690-2-frank.wang@rock-chips.com>
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
> Traverse fixed pdos to calculate the maximum power that the charger
> can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
> property.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changelog:
> v4:
>   - No change
> 
> v3:
>   - Use Microwatts instead of Milliwatts to follow the ABI, commented by Sebastian Reichel.
> 
> v2:
>   - No change
> 
> v1:
>   - https://patchwork.kernel.org/project/linux-usb/patch/20230313025843.17162-4-frank.wang@rock-chips.com/
> 
>   drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 9f6aaa3e70ca8..829d75ebab422 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6340,6 +6340,27 @@ static int tcpm_psy_get_current_now(struct tcpm_port *port,
>   	return 0;
>   }
>   
> +static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
> +					  union power_supply_propval *val)
> +{
> +	unsigned int src_mv, src_ma, max_src_uw = 0;
> +	unsigned int i, tmp;
> +
> +	for (i = 0; i < port->nr_source_caps; i++) {
> +		u32 pdo = port->source_caps[i];
> +
> +		if (pdo_type(pdo) == PDO_TYPE_FIXED) {
> +			src_mv = pdo_fixed_voltage(pdo);
> +			src_ma = pdo_max_current(pdo);
> +			tmp = src_mv * src_ma;
> +			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
> +		}
> +	}
> +
> +	val->intval = max_src_uw;
> +	return 0;
> +}
> +
>   static int tcpm_psy_get_prop(struct power_supply *psy,
>   			     enum power_supply_property psp,
>   			     union power_supply_propval *val)
> @@ -6369,6 +6390,9 @@ static int tcpm_psy_get_prop(struct power_supply *psy,
>   	case POWER_SUPPLY_PROP_CURRENT_NOW:
>   		ret = tcpm_psy_get_current_now(port, val);
>   		break;
> +	case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
> +		tcpm_psy_get_input_power_limit(port, val);
> +		break;
>   	default:
>   		ret = -EINVAL;
>   		break;

