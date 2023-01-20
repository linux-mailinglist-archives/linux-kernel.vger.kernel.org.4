Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DA3675F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjATVBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjATVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:01:40 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E11D0D9F;
        Fri, 20 Jan 2023 13:01:30 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-15eec491b40so7581786fac.12;
        Fri, 20 Jan 2023 13:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tzxFb+aFw9dMe/wk/hf1HHuZk2skArzCTCkEveNnq0Y=;
        b=RK02qnuhT9xrm8TAay/cPuUlLF277sLsDVBJNhe8xouAf5eVDshELJRJAmJVbcFZ74
         r2VO0iURi3Nkxs1E/M1Si3sz33anY5FowsTfp73Za62QKe5sEs0Swx2HlsLldZ1OK1k1
         mrB20tu+53zhzMzCk6rdFPME7+YAcdFFUNqK7KS0cmeFas7hcw89MlFMJ7s5FjzKEkqQ
         VyhMXIDYfbZ1vD9QqVRqcUQTUn2ZiLVSj5LmSA8vJ75/N48teP+PaByFkqTITDxXXoDZ
         xtUNeMNeIyF43zHi6MqTJsrZsp26aTirMGGMuH/nYtB9ZqFt4lesIO9B8gBPN2LlxD/g
         ti6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzxFb+aFw9dMe/wk/hf1HHuZk2skArzCTCkEveNnq0Y=;
        b=U3r2Rg5KHKpUEXaKmddDrnkqN8uSKsCfz94SOH3eC5amC2BCzpjQssIUpw8G5PTMh+
         twuizZRzNwhVAlB5FpxKcf4TLUt8irAz+KWLJ2G0hcZAt+lmawZjORdELcNBHk0pJZVj
         I0Nb2X6UuaoaiNRZioQ+Ekc1X/9M4niS9kloxW0zmyQP9R0pdRCgekUVk1veKM7QLn91
         WU+Iz6kdwVK8Hrps7E16vILaVTiAZoSUxiA7T8ZhF37wKp95QwAPsGsfFC9AztLw/ly7
         /odVxUznOsrwUBxz8d2YofBAXdMOHDOliRH0EQo3KczpFWcFNn8HwYeKi6rQMTAWcsG9
         bqSw==
X-Gm-Message-State: AFqh2koGgjbJFGZMr6rs93L0rSnKgdKmWSGTB3GUFwGsMgjoN9cfhCbU
        VexyZk6WN32fzNnGCbX3WG8=
X-Google-Smtp-Source: AMrXdXtpzhoecJ2VPe8CZMMM7U8ejY9UZ1OenWXxmur5mXn46QWt/ey8t+PnpNj6z6Q3zTXAR+TPwg==
X-Received: by 2002:a05:6870:7b8c:b0:158:3ed8:b8d with SMTP id jf12-20020a0568707b8c00b001583ed80b8dmr20054361oab.38.1674248488725;
        Fri, 20 Jan 2023 13:01:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y34-20020a05687045a200b00143ae7d4ccesm8717369oao.45.2023.01.20.13.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 13:01:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7cfdc0fe-4911-74c8-a961-d5ea3f8b599c@roeck-us.net>
Date:   Fri, 20 Jan 2023 13:01:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] usb: typec: altmodes/displayport: Update active
 state
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
References: <20230120205827.740900-1-pmalani@chromium.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230120205827.740900-1-pmalani@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 12:58, Prashant Malani wrote:
> Update the altmode "active" state when we receive Acks for Enter and
> Exit Mode commands. Having the right state is necessary to change Pin
> Assignments using the 'pin_assignment" sysfs file.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes since v1:
> - Dropped the Fixes and Cc: stable tags; given the discussion in [1]
>    I no longer think this constitutes a fix.
> - Added Reviewed-by tag from Benson.
> 
> [1] https://lore.kernel.org/linux-usb/20230118031514.1278139-1-pmalani@chromium.org/
> 
>   drivers/usb/typec/altmodes/displayport.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 06fb4732f8cd..bc1c556944d6 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -277,9 +277,11 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
>   	case CMDT_RSP_ACK:
>   		switch (cmd) {
>   		case CMD_ENTER_MODE:
> +			typec_altmode_update_active(alt, true);
>   			dp->state = DP_STATE_UPDATE;
>   			break;
>   		case CMD_EXIT_MODE:
> +			typec_altmode_update_active(alt, false);
>   			dp->data.status = 0;
>   			dp->data.conf = 0;
>   			break;

