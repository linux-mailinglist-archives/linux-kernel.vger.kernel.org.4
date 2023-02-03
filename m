Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5668A324
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjBCThz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjBCTho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:37:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE2BA8A1E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:37:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h16so5555105wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 11:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=db6MYL6B1qCC0WghXqCqpmCV3BHmf50h/GnlGcgDEws=;
        b=NejcbZPMYGHRsiENQYz73HwZK/9UL8brsL56ssuMEEaDh7BfaeG5MgjlQC13JxmepS
         M0sYVmEsXS7mgyYEFXcu4HOW8U7sS38JF88Ic27hOSq1v25TcP8kgLdAdw9iypZUoOz1
         GTZ4vYsVM8mntAcvCueB0/hgRoiTp/G2YeyAwFXMIxTxCjXaztDHASyidKEKxWE+HcTZ
         ZGXUyltBkanzVFc2TNFwKp6tjcusPMlQYO/sIubxAXr/971nn9I2CplF5cDqUc1vvQk9
         fWbn4v/41QLAhtgfB/9U5F1fwFL96fXJ1N9HTRd0mzYAr0uk/PapTsrZNdEEcCBZW4wq
         bxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db6MYL6B1qCC0WghXqCqpmCV3BHmf50h/GnlGcgDEws=;
        b=jsyT0bpBdjgmZFtVk8x9ak4beNHV0wFS+V2DrMaLPD6BJoj1j4zCiRzhhqtF/sp9x5
         v31EfT56ZkgzCe1rXEpzqAAkd+VYyhPZox9QKkXMUVXGnvuCW0L/l9ophPqGvf90bKo5
         nZMIjIV8ngTWnUDfjWkZlr5l95xXOo5GhAdaPgkhQFDYMLQMsDBE7t+Xn1yE8fGwmT1y
         7LXIdSCNuq5haMyqduLqKOK43IQHZWVMfG2fdAK+3+xPDscTruZc/Y+y+qoKN+Lj7qA6
         PfW9CWzuMfqGAbUaMoZoF3xDpeR3PxFZ146dTWIGJ0D+4PK6BFBX4LFY9IpREs5nIbaj
         DErw==
X-Gm-Message-State: AO0yUKV3m9UiggbkJsw5SCHoLB8NrOKT4557ms2zqAJcuTI/VJjwY4YP
        STcZTPinrqgAtv95UnCksfz6Qg==
X-Google-Smtp-Source: AK7set95ZxUhUht3lmVwu6Z+ambqGhwtxGfLtaPaosE/50HAbN2VkxWC/Qzfga+8oosSaxr+m9qmXw==
X-Received: by 2002:adf:fa84:0:b0:2bf:ae15:ac15 with SMTP id h4-20020adffa84000000b002bfae15ac15mr9307669wrr.62.1675453061095;
        Fri, 03 Feb 2023 11:37:41 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm2744105wro.57.2023.02.03.11.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:37:40 -0800 (PST)
References: <20230202183653.486216-1-jbrunet@baylibre.com>
 <20230202183653.486216-10-jbrunet@baylibre.com>
 <f229e181-c56d-6ec7-2a1c-754690f70438@linaro.org>
 <1jfsbmn7ql.fsf@starbuckisacylon.baylibre.com>
 <fede7119-4a9b-76a1-ae1a-7af5dd8d1032@linaro.org>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] ASoC: dt-bindings: meson: convert axg sound card
 control to schema
Date:   Fri, 03 Feb 2023 20:34:21 +0100
In-reply-to: <fede7119-4a9b-76a1-ae1a-7af5dd8d1032@linaro.org>
Message-ID: <1jbkmamtfg.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 03 Feb 2023 at 18:59, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 03/02/2023 15:13, Jerome Brunet wrote:
>>>> +          Multiplication factor between the frame rate and master clock
>>>> +          rate
>>>> +
>>>> +      sound-dai:
>>>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>>>
>>> Old binding was saying it is just phandle
>> 
>> It is just a phandle but the bindings used to have problem with phandle
>> that had cells.
>> 
>> See:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/devicetree/bindings/sound/amlogic,gx-sound-card.yaml?h=v6.2-rc6&id=d031d99b02eaf7363c33f5b27b38086cc8104082
>> 
>> Was it wrong or did the situation change since then ?
>
> Then define it as having cells:
>
> https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42
>

The card is provided with the phandle.
Whether or not the phandle has cells or not has nothing do with card
driver. The card just consums sound-dai. I don't understand this comment.

>
> Best regards,
> Krzysztof

