Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C3F6B6BB9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjCLVPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCLVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:14:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979527D63;
        Sun, 12 Mar 2023 14:14:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l16-20020a9d4c10000000b006944b17058cso5750281otf.2;
        Sun, 12 Mar 2023 14:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678655694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3VsWDPFaczsDfXU7WZPX8lGz1bl2jblkgzkg70JA3I=;
        b=gJpGxB9/cF15wBrFzEtW0fT9ajVGGu/rA5cz23vyfk5ynNj9DXTY5DeFFM3rn165SF
         DbNOenNYxuysw7kK+fXFeZY4SyelkZqQGeBLYsBasAIL3U0qOPRt5yAIi90pBWSCSpTQ
         /RSUSGw+6oBOG0UfSDYfsjN5eWkjXiSqoEcLcHNHdzrH+VNL/cB83BCc3bJDHVzU8TEU
         FH8VKaSsf+eX2dGPPQJBS5hhIggeRtAi9+1/2OZFk2vfjmqY/WX85+4mgVbcOLWnkeH0
         lLYUdxwe2zK+5BFYietyHO1v6/69cszw2IFaLHqYv8WJ0IWXoduAb+1d1I1U8XovBKIO
         r+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3VsWDPFaczsDfXU7WZPX8lGz1bl2jblkgzkg70JA3I=;
        b=rsA5PWSSl/W7+SZKGSOdjookIXFl28YnwH7+eXTAt0NB6he5X6ALjXp8HLimgBSidA
         3Rnxj4f+HoIewZUnaHNiI7Q4aH4bTu4ggVZRWpVLiNQtK2FudT+4ALbuhol6mbVBD6nE
         OKlZecabXJPZf9FbbBWBsPoS+Df6b31s/icBGZzQaHYLCAfh7Ci6vJNeofGxThMApdg+
         4/CiH/o20WbJHBRfa0lWqoDaQlp0eivFshvYG4FwNPlonxXMKE+Tz8bzfqeKR4mkkU8Q
         inN6e4xtbzrlDY3T0YRvsVZ4V+ItvwEbT6J2Bjkj88r8epmXZHsT0jFtFa4nv7HIwjsj
         rxhg==
X-Gm-Message-State: AO0yUKUROGWddE2Eyo15ni0CoYEuU+uA+gs4PdWR1L433xKcNKYAeefF
        +qYsqZv+q05KZkgZ8I6r5HI=
X-Google-Smtp-Source: AK7set+qz301ZhwVwfixwZorR/wkxy/EPudT49twzvbYcAaz6swzV2u3fDRxUpFCxwUxSI5z1XGyKQ==
X-Received: by 2002:a9d:128a:0:b0:68b:e4d7:b8d with SMTP id g10-20020a9d128a000000b0068be4d70b8dmr14529258otg.35.1678655694595;
        Sun, 12 Mar 2023 14:14:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z27-20020a9d71db000000b00690e6d56670sm2501997otj.25.2023.03.12.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:14:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 14:14:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: tmp512: drop of_match_ptr for ID table
Message-ID: <e3a8bf6a-fecd-4eb9-826f-0f5f974d36fa@roeck-us.net>
References: <20230312193723.478032-1-krzysztof.kozlowski@linaro.org>
 <20230312193723.478032-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230312193723.478032-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 08:37:23PM +0100, Krzysztof Kozlowski wrote:
> The driver will match mostly by DT table (even thought there is regular
> ID table) so there is little benefit in of_match_ptr (this also allows
> ACPI matching via PRP0001, even though it might not be relevant here).
> This also fixes !CONFIG_OF error:
> 
>   drivers/hwmon/tmp513.c:610:34: error: ‘tmp51x_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

> ---
> 
> Changes since v1:
> 1. Rework patch and commit msg - drop of_match_ptr.
> ---
>  drivers/hwmon/tmp513.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
> index 47bbe47e062f..7d5f7441aceb 100644
> --- a/drivers/hwmon/tmp513.c
> +++ b/drivers/hwmon/tmp513.c
> @@ -758,7 +758,7 @@ static int tmp51x_probe(struct i2c_client *client)
>  static struct i2c_driver tmp51x_driver = {
>  	.driver = {
>  		.name	= "tmp51x",
> -		.of_match_table = of_match_ptr(tmp51x_of_match),
> +		.of_match_table = tmp51x_of_match,
>  	},
>  	.probe_new	= tmp51x_probe,
>  	.id_table	= tmp51x_id,
