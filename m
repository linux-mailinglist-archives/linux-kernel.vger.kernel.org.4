Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64072B756
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjFLF1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjFLF1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:27:35 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B707DC;
        Sun, 11 Jun 2023 22:27:34 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-97460240863so650950166b.0;
        Sun, 11 Jun 2023 22:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686547652; x=1689139652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMnpq9+OYfPg6TBIFvs2+QVo5d8XqzLQKqpOPnUzs8o=;
        b=US7v6sMsHqR1vfKK73l3XAS15TMneJGpSt0SUn9z0e1jaWFlw+hY0i1k+zYTzhbfvL
         KWEuah9mQKQgrslcodTwowJRHUCZDLoJ6t8fhqHYd1ZZytAK9XRxCiQv+msx4LjKkDoJ
         /n1xAUqwSaRZqPXYyqc2aLMbTOGYM0oKongDKDpvsEhq5UYSrKfviXSRtikvqfvo6iU1
         W6GMm8QOwM/Lo4rP40w16SOOGwLG+b0VGPXuflNFt0MZH165u/MUhk36r3deXhaxYCzB
         kMtgX9ooZLm3nWMmIJeLUGd+4OVKNxHpZRbnm55qOkpKWkyBDQ/EJj4j06AEYElCyEFb
         eLNQ==
X-Gm-Message-State: AC+VfDwNHrwseAf/8szl+epAlVs+89/zPVCbTQg2P+VvuET+Wi0gYSDJ
        mZTfMdVdU7s1oRjyyT6p/MY=
X-Google-Smtp-Source: ACHHUZ5oyPtH6OnVxF5P1vYb6NSLPzWRrIxiELKhUTqeyiscVtToeF2N5wo0kwqxaVkjLWtVsVOe6Q==
X-Received: by 2002:a17:907:1c05:b0:973:daa0:2f6 with SMTP id nc5-20020a1709071c0500b00973daa002f6mr8984288ejc.3.1686547652334;
        Sun, 11 Jun 2023 22:27:32 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id p4-20020aa7d304000000b005169ffc81absm4601230edq.51.2023.06.11.22.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 22:27:31 -0700 (PDT)
Message-ID: <9b1468fd-f2e2-3b84-7bf0-0fa28ffa0e19@kernel.org>
Date:   Mon, 12 Jun 2023 07:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] tty: serial: samsung_tty: Fix a memory leak in
 s3c24xx_serial_getclk() in case of error
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        stable@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 06. 23, 17:59, Christophe JAILLET wrote:
> If clk_get_rate() fails, the clk that has just been allocated needs to be
> freed.
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

