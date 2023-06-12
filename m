Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045872B74F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjFLF1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjFLF1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:27:08 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1E09B;
        Sun, 11 Jun 2023 22:27:07 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso6815775a12.0;
        Sun, 11 Jun 2023 22:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686547626; x=1689139626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3t4qSSoxQIBSIIXeZdppBB0nlvRyy5H65Udz3iU4Dw=;
        b=YuZmd8VzsYjjh42s98ZyZbmJm9UVMs/CqdPPZaTibo0pcqMgQSwOjRz/RvruUvDnWF
         KTgoCay5hXVtu2lj20SZcCs/kJ9a6a+tF0CvNkHwZV3boi8fA9oa7Tn9Xs4mNIqFgOV0
         UVf2qW8C7bkcI4IeFRyBM9N7qdDWGIlNg0MhQGPdE4RyrBiJuT9MR4x8/18ILN3/bHSX
         3vNLcUvqmDnMIQ21fZW07DYOAXLMAMHw05EsG4DChfT5I2BABs2NRQ2TNomRIAMTrCwT
         tekQLcAf1ugTbQDWeN6siki6/W/B28BoK3wx1IQyUEWzH7z+uHG4oKpSXBu45g+qpf4E
         A0CA==
X-Gm-Message-State: AC+VfDybQnTgbbCCDvXhAj5TO8ZejFSn3Wbqsg+4bGgbnCVU8viaxT+r
        br/aguusSMxL4NgV7vRrBnMiLTGQyRk=
X-Google-Smtp-Source: ACHHUZ5uVMbqfnul1WYNGtgKFJKIhcCu3N8VzyHGBB1j+b6/TkuHzJwaEXs5S9gkFWx2PFFVdmAh+A==
X-Received: by 2002:aa7:cb59:0:b0:514:56b4:35a7 with SMTP id w25-20020aa7cb59000000b0051456b435a7mr4966606edt.36.1686547626183;
        Sun, 11 Jun 2023 22:27:06 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id ay16-20020a056402203000b0050bce352dc5sm4640947edb.85.2023.06.11.22.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 22:27:05 -0700 (PDT)
Message-ID: <3725cc72-b6e5-848a-13b6-b3162e38be7b@kernel.org>
Date:   Mon, 12 Jun 2023 07:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/3] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() when iterating clk
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Thomas Abraham <thomas.abraham@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
 <cf3e0053d2fc7391b2d906a86cd01a5ef15fb9dc.1686412569.git.christophe.jaillet@wanadoo.fr>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <cf3e0053d2fc7391b2d906a86cd01a5ef15fb9dc.1686412569.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 06. 23, 17:59, Christophe JAILLET wrote:
> When the best clk is searched, we iterate over all possible clk.
> 
> If we find a better match, the previous one, if any, needs to be freed.
> If a better match has already been found, we still need to free the new
> one, otherwise it leaks.
> 
> Cc: <stable@vger.kernel.org> # v3.3+
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

