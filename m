Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E596FD667
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbjEJFzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjEJFzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:55:31 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6ED3C0C;
        Tue,  9 May 2023 22:55:30 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so12566218a12.2;
        Tue, 09 May 2023 22:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683698128; x=1686290128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvksywUSURVRlCm5zQiV7rq77JOAXf05KhB1WTtG+Rs=;
        b=NIN5kSDW507bt4rW07fpnBrzTatmEybyml6sXqVsRoD6o72eN18ftEL5Ub/yVsJV3u
         XMQF68XldEwtKkKlgfQkTXw0d5h9WocXOkomTQomoYhRthzS4xshjWS/WbQPtjxlTqbF
         btFigaX9jvbdQDXIuomwf+53WsFaesULlZMM+IdJWVc81jp37fidwl/37yPz272mm7Vr
         UEemvnlhvQSxVHEmXdbkpIvTHAiboVpPtJ9Ww7xbKn6mG07DgF8MseVDGm53RD5RgqRl
         3fxhASR4L6c5NCcnDiRokCkbF1QykaRdCcaOFMlaSoZrP5GBAOfLXFTlX0Fip1e0X2gB
         sa+A==
X-Gm-Message-State: AC+VfDy8ihMRTySHnDm3XwzK1kZC49FoHEsUqsN+H7Tb0sLQd4cFH519
        OxuG5cp8cQ2V7msUFVG2RN0=
X-Google-Smtp-Source: ACHHUZ7KYs0Mf9UjBf966hG0bnUtGRzTlrZZavRjNoegFMXCG68MrVCUiSENczjvyyjTkx5Jn5ENsw==
X-Received: by 2002:a17:906:dc93:b0:965:4b44:6f5a with SMTP id cs19-20020a170906dc9300b009654b446f5amr14952752ejc.10.1683698128285;
        Tue, 09 May 2023 22:55:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id fe18-20020a1709072a5200b00968242f8c37sm2236449ejc.50.2023.05.09.22.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 22:55:27 -0700 (PDT)
Message-ID: <b9e29856-69a4-007c-930a-87e05b82eaf8@kernel.org>
Date:   Wed, 10 May 2023 07:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 3/6] serial: 8250: Add dl_read/write, bugs and mapsize
 into plat_serial8250_port
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>
References: <20230509113924.19540-1-ilpo.jarvinen@linux.intel.com>
 <20230509113924.19540-4-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230509113924.19540-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 05. 23, 13:39, Ilpo Järvinen wrote:
> Add mapsize, bugs, and divisor latch read/write functions
> (->dl_read/write()) into plat_serial8250_port to carry the setup
> necessary for RT288x/Au1xxx devices over to uart port.
> 
> Document the added members with kerneldoc style but do not enable
> kerneldoc yet as there are many fields which remain undocumented.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
...
> @@ -28,8 +44,11 @@ struct plat_serial8250_port {
>   	unsigned char	has_sysrq;	/* supports magic SysRq */
>   	unsigned int	type;		/* If UPF_FIXED_TYPE */
>   	upf_t		flags;		/* UPF_* flags */
> +	unsigned short	bugs;		/* port bugs */

I would suggest u16 for bitfields like this. (Or DECLARE_BITMAP, but 
that would unnecessarily eat a long.)

thanks,
-- 
js
suse labs

