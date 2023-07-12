Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480477508B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjGLMur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjGLMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:50:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AE41982
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:50:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so7147080f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689166241; x=1691758241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYsJ63thWaEnF2bdwDOY9GkDlg8P9/us46x/m6A1eFI=;
        b=hn8H70Zyxu8TQrRfZIDwdYKutfQz+JQgByvxMUo15F+OMIywfFp+Qe1KHa4SIyr4wo
         bqkkofWAawRDiaIa5iVwlqDsQ3Qq0VR8tdn/waIy4t/Nb5At258o9quiRvf8x/6b4qAJ
         zWcyLaHmENBOVZpWUM/XrYn4XXcgKwXqi87Xr/6ntu7TiQ+DjPCKfHzB4X3/04rzZ3hQ
         Rwr4z+XHlzVAPJ0AJC/Pr8NOpE0M8HahqrV9k6qGPN1q52NhccZEW4X5jWZBmrELwYlX
         Ast0Hj2NW8cGb8NnubWNxSSxBuwJCNUFkTo6xtIkeVB1+Ejj/jh5XGpsSw4lmPfFgiK8
         HpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166241; x=1691758241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYsJ63thWaEnF2bdwDOY9GkDlg8P9/us46x/m6A1eFI=;
        b=FnPkxKhxNkruSBbKqDqEVDKkWL+wiXFCyOM5Fu0nnY2l9cnEi+q+PuYj2cMsD9iL3t
         xerQPdwtNl7c6bsr9dpQvhux9MFsPJnuoX4wN25CM2et53eFYrsdXl+WEu3U/J7DpAT0
         owiyCscXqLW/wBXwLHxT/6SYTOnSVwGSM2LhtngVJ1TBBVDA7uzg3E19ikNIrv+1LzJC
         W59gG1PCYk6feeHB2PY5PkCLenoNMT4jaGD0NUq1OkjzpkmatKPf9RyyAhq45hpy1Stq
         aauizm6BpafsAf76AO8I1qfM1EHf4HzG5v9vyb3mf0oQTk+MkjEh8dNX0fdbSY5gZyj5
         x26w==
X-Gm-Message-State: ABy/qLZZg1q7ojeSs8EiEZhxRZF8/Npjc5m05dzcYpWxZmRmyxA3CldV
        XSGFesZI3h3B15IKScHhK8hO7Q==
X-Google-Smtp-Source: APBJJlHyphLNHtPrSUBpgCjJ2oqeaRUQji6SkdMtP6DiMk3xvuG5d//Mi73F/YxpSOuHVBAbBidBYw==
X-Received: by 2002:adf:ed4c:0:b0:314:212f:360b with SMTP id u12-20020adfed4c000000b00314212f360bmr16925439wro.17.1689166240964;
        Wed, 12 Jul 2023 05:50:40 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id y17-20020adfee11000000b0031274a184d5sm5023825wrn.109.2023.07.12.05.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:50:40 -0700 (PDT)
Message-ID: <5c24ae39-5114-1b79-a952-e7a364a1f2de@baylibre.com>
Date:   Wed, 12 Jul 2023 14:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND 2/2] ASoC: dt-bindings: mediatek,mt8188-afe: add
 memory-region
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230712070821.23971-1-trevor.wu@mediatek.com>
 <20230712070821.23971-3-trevor.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230712070821.23971-3-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2023 09:08, Trevor Wu wrote:
> Add memory-region property to utilize the reserved memory region.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
