Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738556BE9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCQM6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjCQM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:58:10 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2351CF5F;
        Fri, 17 Mar 2023 05:58:09 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i19so2678846ila.10;
        Fri, 17 Mar 2023 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679057889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U8+4cXu3qDjUouNJqRhPXdnyraju2nbEvYbMrucPxSE=;
        b=YZy43MHhLsBKYE3NR/zoHY7UjvO8FU9R96nyRXlZAZegB/5jclv2il9icUwmi4/pYR
         bbBhrDEn51XVLiOwVd3RzY8rR8VQItdGtyyDgfkV0l+oJgqQRQvrQbQhOEnr5q8I1hyR
         r6geo/w9ouL30rFvDVtNLe7nt2AOXzCA6RFjYfJvGoH2o0cwrsdq9ReZJUiSsFqQ7sXv
         WHj4cDRq8IRnd1X/TwqR07CReq0FSkd5DDQNvHsEYD31F5n84qhCP5D08EEAlgCHyXLS
         zqYxN22vwAp9UiGJhAbrEx6083QEazixDu/GS3OvikqBRHIG+I0MeBgoyXHGVawUYMGK
         y1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679057889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8+4cXu3qDjUouNJqRhPXdnyraju2nbEvYbMrucPxSE=;
        b=cMo6yNp+60sXMRODshCTMqoZXrgqqF9DmrmSMICyxAwLz1GyxzZvDpDfapIlhJTOaM
         BEQ0WZG53Do4YJ92NuNPUelK0Kq5tthqXtlJKcREWM9aC/UL+NWPYZRWXNDITO3kZ4jO
         4PkGwuYfFmfToBvMHfHTPEiiYz1FVnEXYRvBUH56phkF9Xk498ngJSmMBF6DLOQ0yKba
         Lbt1BOACmN8m6Nkd/QZXQywz88HbxfUCmlqyu2DCiB87uGruAFgHb6l00C+zC3vvkhNX
         N4ewUexWY7k6UNw+EEwUWU4Lc6EqC7ubGGPxM6Q0159DuJROocDQR1kgqpwurl+nB90q
         mA4w==
X-Gm-Message-State: AO0yUKXrnr0c2LM8vn+1tdMcbAZCk7gCrg9sFDGWymq5HJ7LlasGu4WI
        lIgdUl/jjCcJ3ozCmfKEDaA=
X-Google-Smtp-Source: AK7set9imSwZfpVK/XShg0oQ3fFaFqKk37d66TfcA+zJ0qe4+XvX2no2yd7RUImM07ROYPHTSIg1Vw==
X-Received: by 2002:a92:dc4d:0:b0:323:1470:a08c with SMTP id x13-20020a92dc4d000000b003231470a08cmr9687213ilq.8.1679057889107;
        Fri, 17 Mar 2023 05:58:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7-20020a056e020f0700b00317a2fed5b6sm585329ilj.45.2023.03.17.05.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:58:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f5650fa4-db16-b1e4-f5b4-917fbcabb415@roeck-us.net>
Date:   Fri, 17 Mar 2023 05:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/4] usb: typec: tcpm: fix source caps may lost after soft
 reset
Content-Language: en-US
To:     Frank Wang <frank.wang@rock-chips.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230313025843.17162-1-frank.wang@rock-chips.com>
 <20230313025843.17162-5-frank.wang@rock-chips.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230313025843.17162-5-frank.wang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 19:58, Frank Wang wrote:
> Invoke set_pd_rx() may flush the RX FIFO of PD controller, so do
> set_pd_rx() before sending Soft Reset in case Source caps may be flushed
> at debounce time between SOFT_RESET_SEND and SNK_WAIT_CAPABILITIES state.
> 

Isn't that a problem of the fusb302 driver that it flushes its buffers
unconditionally when its set_pd_rx() callback is called ?

Guenter

> Without this patch, in PD charger stress test, the FUSB302 driver may
> occur the following exceptions in power negotiation stage.
> 
> [ ...]
> [ 4.512252] fusb302_irq_intn
> [ 4.512260] AMS SOFT_RESET_AMS finished
> [ 4.512269] state change SOFT_RESET_SEND ->SNK_WAIT_CAPABILITIES [rev3 NONE_AMS]
> [ 4.514511] pd := on
> [ 4.514516] pending state change SNK_WAIT_CAPABILITIES ->HARD_RESET_SEND @ 310 ms [rev3 NONE_AMS]
> [ 4.515428] IRQ: 0x51, a: 0x00, b: 0x01, status0: 0x93
> [ 4.515431] IRQ: BC_LVL, handler pending
> [ 4.515435] IRQ: PD sent good CRC
> [ 4.516434] PD message header: 0
> [ 4.516437] PD message len: 0
> [ 4.516444] PD RX, header: 0x0 [1]
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 9e583060e64fc..ba6bf71838eed 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4321,10 +4321,12 @@ static void run_state_machine(struct tcpm_port *port)
>   		tcpm_set_state(port, unattached_state(port), 0);
>   		break;
>   	case SNK_WAIT_CAPABILITIES:
> -		ret = port->tcpc->set_pd_rx(port->tcpc, true);
> -		if (ret < 0) {
> -			tcpm_set_state(port, SNK_READY, 0);
> -			break;
> +		if (port->prev_state != SOFT_RESET_SEND) {
> +			ret = port->tcpc->set_pd_rx(port->tcpc, true);
> +			if (ret < 0) {
> +				tcpm_set_state(port, SNK_READY, 0);
> +				break;
> +			}
>   		}
>   		/*
>   		 * If VBUS has never been low, and we time out waiting
> @@ -4603,6 +4605,7 @@ static void run_state_machine(struct tcpm_port *port)
>   	case SOFT_RESET_SEND:
>   		port->message_id = 0;
>   		port->rx_msgid = -1;
> +		port->tcpc->set_pd_rx(port->tcpc, true);
>   		if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET))
>   			tcpm_set_state_cond(port, hard_reset_state(port), 0);
>   		else

