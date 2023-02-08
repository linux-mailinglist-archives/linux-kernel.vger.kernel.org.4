Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4DE68EFBD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjBHNa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:30:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ABE49415
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:30:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so1448516wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 05:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HpCaN7lG8XCYSDYTiFmo0cVwl51EDo9X6coy6Wp5QmY=;
        b=MhfzlfU5sY+wGQQQMW/8ySS5pdzxzPH8iIv7OSSZT231doUM5Y6Z+M7u5cZYUTnHnn
         Nwgh+CHswYjnoy3o7x1tfV/CchtnC6DLHjliRK0UiT1fiIu/eK0ZpKuKN/zYBS0W89mW
         wzcipCsUFqyl24KpdhfQ7asj0yayRfi8CgmbZ7p8sMoh1y2AcxMkGdWRUdw5Vh5YV1AR
         aV3sW8WHGpQxRjaTOLEEpIMQa5vvJOzWaRXUAuWiEY1EMXmjmLrqXqzlqcxhDtV4l1m5
         UFafj6veS/za8W+FjVLmn8AgMj6iiavpbLYgM3jxhJzhSGEmeh99X+2wysIoM35ix9U3
         SLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpCaN7lG8XCYSDYTiFmo0cVwl51EDo9X6coy6Wp5QmY=;
        b=ubZIz4TNPXyjzfUPXjn0zsEDB9iXxZLR2DnXbE2ceD86qTJOQOVm21771ayCJjHK7L
         SqUVvCffkGf+BA5n1H8gGfJHVCFlUBQLBaHrR9JVymjFtyMZfh4CJDJl8jH02BXWy+Zs
         FPTgEacsB+NAPAguEQd6y6hquUYWGlSwh2su1RfN/lA9hR/tiYgn3hftmQTe5HorQKyx
         UeJKSKbXVLyHUDeX1D3LkV2EaMDON8n5qVk9s+4zJadbq8QPE8HoYTONV6TJo9Th5EHi
         XTb5VnRsZhu1ernD8SqMAb4AZiZNiVGncAIs0U52G9PA4p02+oJBqI+6xUwfCRnbwlSN
         pyMA==
X-Gm-Message-State: AO0yUKVDddq3D978+uD9O/lSMLlouPvE13LH+w8XfJJJyc6AQ+ZEReRE
        /2BcCx94htpn4JO8AcpLhpKMOQ==
X-Google-Smtp-Source: AK7set8gTMHZ1IftF10m4fVg8A2AOT5sLEQhWbPfE+atmk79589ys3Tl9ZLjMH61OGI0Otb++12oXQ==
X-Received: by 2002:a05:600c:13c8:b0:3da:28a9:a900 with SMTP id e8-20020a05600c13c800b003da28a9a900mr6401021wmg.41.1675863051197;
        Wed, 08 Feb 2023 05:30:51 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b003dff2b493c8sm2162895wmb.36.2023.02.08.05.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 05:30:50 -0800 (PST)
References: <20230208093520.52843-1-jbrunet@baylibre.com>
 <Y+OJB7OPABnPfeq7@sirena.org.uk>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] ASoC: dt-bindings: meson: covert axg audio to
 schema
Date:   Wed, 08 Feb 2023 14:25:58 +0100
In-reply-to: <Y+OJB7OPABnPfeq7@sirena.org.uk>
Message-ID: <1j4jrwmghi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 08 Feb 2023 at 11:35, Mark Brown <broonie@kernel.org> wrote:

> [[PGP Signed Part:Undecided]]
> On Wed, Feb 08, 2023 at 10:35:18AM +0100, Jerome Brunet wrote:
>> Continue conversion of AXG audio dt-binding documentation to schema
>
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that 
> any important information is recorded in the changelog rather than being
> lost. 

I usually don't send cover-letter for single patches.

This was originally a 9 patches series and it dropped to a single one as
you applied them. I was wondering wether to keep the cover-letter or
not. I thought keeping it might be better to keep track of the series.

If the same case happen again, I'll skip the cover-letter.

>
> [[End of PGP Signed Part]]

