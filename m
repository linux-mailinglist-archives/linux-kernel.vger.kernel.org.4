Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD6631C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKUI6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKUI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:58:45 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF5D2D3;
        Mon, 21 Nov 2022 00:58:45 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id bj12so26809731ejb.13;
        Mon, 21 Nov 2022 00:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVOvAfGe8EFehC4Um3S5FYYIC4OCoqGuqtE1Oktag4Q=;
        b=LpfMOpSbAca9wWz8nkQpSsO2Gi/9UtBgRk7YanbPNDrHQ6nr0/JLDPaNR1jT3uBxqC
         UTuguHr92aXYfouIskj5MkhY4qqea2E5Vs1yfVE0OpGut/Tn56NOZP68gRgPxCl8AED7
         5T/FJa6KmgP+BwWJcNDLnoQNbOGScyOh6LvM1EvALTnxOSAnKCTw4NvPnMuOAri3E5vK
         wgijhxrTBC5VB8jjnhOOtYOpo1kvwambZWt8i7uTy/1kWUIkoW8g5xUox9BvTz6qH17w
         4u4Xfh7LaJr3GFELuVa4IExsWmGBi74CUVc+UOiB2OXtb/VVw/OsfrdA1aznDaQaE4/r
         yl0A==
X-Gm-Message-State: ANoB5plXaG64aJ3cK26NA94r71kTrRliyNy4qo0J+5DF8ysnx4Bqh+Xs
        WhH9gU/bI+AL9bHhl6T8B8I=
X-Google-Smtp-Source: AA0mqf6uDngcY8U/b2D28EFm58gOju20m5WgSxWJC4mLLcPZa4hFvp1jvQh+4WVNdBhjdVxJHRzDng==
X-Received: by 2002:a17:906:3fce:b0:7ad:bb54:75d3 with SMTP id k14-20020a1709063fce00b007adbb5475d3mr14286281ejj.484.1669021123551;
        Mon, 21 Nov 2022 00:58:43 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b0074134543f82sm4824059ejf.90.2022.11.21.00.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:58:43 -0800 (PST)
Message-ID: <7e2e76f8-5d88-4df4-2335-9f7b129b2e26@kernel.org>
Date:   Mon, 21 Nov 2022 09:58:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 13/14] serial: liteuart: add IRQ support for the TX
 path
Content-Language: en-US
To:     Gabriel Somlo <gsomlo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-14-gsomlo@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221118145512.509950-14-gsomlo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 11. 22, 15:55, Gabriel Somlo wrote:
> Switch the TX path to IRQ-driven operation, while maintaining support
> for polling mode via the poll timer.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
...
> @@ -154,6 +148,8 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
>   	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
>   	if (isr & EV_RX)
>   		liteuart_rx_chars(port);
> +	if (isr & EV_TX)
> +		liteuart_tx_chars(port);

Wait, how do you ensure the OFF_EV_PENDING reg contains EV_RX and/or 
EV_TX in the polling mode?

thanks,
-- 
js
suse labs

