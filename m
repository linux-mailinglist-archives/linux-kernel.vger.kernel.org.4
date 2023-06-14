Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF0F7302AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbjFNPCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbjFNPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:02:14 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33032101
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:02:12 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7748ca56133so54699239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686754932; x=1689346932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4sjlStxztTY7q6pTG+2ubizzXPZ9YpI/qMjGbH/hEU=;
        b=iLanjjCCh+abjNsb7HzMXbgc5I4WamBdXQttBei6MT5HSLmUShwbqbXITVO/XETnpr
         JQDj+MEPU/I86l8Ji8r1MUZzrhAk7e8As+MlrecodDfsiw7CdxGHzH7woBb3PpBhR0a9
         6/aG7DPFkJcPpQkWV//vHLMQaBhPyLCHpoqBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754932; x=1689346932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4sjlStxztTY7q6pTG+2ubizzXPZ9YpI/qMjGbH/hEU=;
        b=IRdgDraKBm++CzHEwjohKw33S0/uqxSEoa25+NKrg4N8WB17mDsdsJdslk5hYtwIoy
         OjVtf3DCpwHfTLDUbahRVJoIOASZgCUmSJ71d1GxJKsxnxdAzLVvN2fKe0ANBgjC9FCl
         XZxE7uYCagDaRKcIOGTVrNtWi21KGno4HPWWyY56wmS2RWly4uF9M5u/IC4fMA/T0sl8
         q86LFBRZ0fb5I6xL4EfTD0lKZLkxW/dMLIXn+Ts/R8qm+4yEsGhVIO3DlJIJQOUCqT+l
         gjK8+DckN7UPju/tAVFmNs9OV4xExw9UqR95xUqKFEjPgvLv2DYRiWZs5CatGK32m6aH
         UHZA==
X-Gm-Message-State: AC+VfDxkMOL8wgpSMYYGVFiHr7l9gghw8WRwLnSYa2vKdRm6lrRxjhD4
        aDqYws5H/t3atjDTzokaTHKTCg==
X-Google-Smtp-Source: ACHHUZ5WZysEEpfgX9MjC6+Mfwtnk8IJSYq0wqb2ALccliUeJPDjzjDv2v/nuv/CLoitYhkkDE7zvQ==
X-Received: by 2002:a6b:8d4b:0:b0:777:b6a9:64ba with SMTP id p72-20020a6b8d4b000000b00777b6a964bamr12074626iod.2.1686754931962;
        Wed, 14 Jun 2023 08:02:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n9-20020a056638120900b0041669a9fb62sm4963571jas.131.2023.06.14.08.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 08:02:11 -0700 (PDT)
Message-ID: <785c1d49-f080-2f21-2948-d12d522c9fa7@linuxfoundation.org>
Date:   Wed, 14 Jun 2023 09:02:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] usbip: usbip_host: Replace strlcpy with strscpy
Content-Language: en-US
To:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Hongren Zheng <i@zenithal.me>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230614141026.2113749-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 08:10, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20230613004402.3540432-1-azeemshaikh38@gmail.com/
> 
> Changes from v1 - uses "< 0" instead of "== -E2BIG".
> 
>   drivers/usb/usbip/stub_main.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index e8c3131a8543..97043b4df275 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -174,8 +174,7 @@ static ssize_t match_busid_store(struct device_driver *dev, const char *buf,
>   		return -EINVAL;
>   
>   	/* busid needs to include \0 termination */
> -	len = strlcpy(busid, buf + 4, BUSID_SIZE);
> -	if (sizeof(busid) <= len)
> +	if (strscpy(busid, buf + 4, BUSID_SIZE) < 0)
>   		return -EINVAL;
>   
>   	if (!strncmp(buf, "add ", 4)) {


Than you Kees for the review.

If Kees is happy, I am happy :)

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
