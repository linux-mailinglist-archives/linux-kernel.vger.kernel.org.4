Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FE0615209
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKATN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKATNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:13:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67316D9A;
        Tue,  1 Nov 2022 12:13:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f27so39532201eje.1;
        Tue, 01 Nov 2022 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpizzQAXxh2i/jnBYbtei8KHpjUU+A3hSqpgrk5Ku6g=;
        b=SSYOF72FfOEw47t4SN2Iz2CS3dysppj5Zvhi9GT+/dhaW0KlnmiAfeg03UUnmhc1nh
         3uf4vEp4MaMASXhplHR4uBKTcnjpFGK8PdDaJoJ/kFL1dbxDdzV+L7+y4gXb3pBO4zdm
         hNDQux431GT6O4znDHarP/mLVCPLEHchRqkSHH1odf+3QdrtiVm2Cw2RosuCPwmUundp
         fuKf2vOy9xsDz2iDSxnaI4X/v0AqpkoO+0KnjjTS9JgvoBKHufHUiwKDTjU9z3rV0jDw
         jE+a2eL+30BDzWwFM9qGmrgBy0n8YaGS/ed+y6zN3tmsW8zsFdPYs2hQiUm3pO3yJ42E
         S4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpizzQAXxh2i/jnBYbtei8KHpjUU+A3hSqpgrk5Ku6g=;
        b=PwXJb1muImT0JdkAm0qcXvd1lYzNCoIWiKDFpub+JmYVci1Jj7n/vqWD7eoO8KCOF9
         k0Q6KKJb+CHl1TMdHsdp2umxq4UXbd2vokTtYAaf/9DxuuAjOyxsStwVjvcAaMwPTRjy
         Qi0s77mGovY02UddYeg7eGdfNPXpUyvVHzCPIKNMJdV3ODnxAv8OzRYRqHaPvNbvBUJu
         OMp4f2E/7AKf/hQR6v3Ps8XLDHCTIWggInEt6CZvHQUHA9AxM539j40hbc8kSA1SCyvY
         iJiRHpylBvKtSqJ+P94uDD3OhD9Wtc10wWAB+63Q7PEfH9t3bWqLbrS2zihkGxpS8ZAx
         DVdQ==
X-Gm-Message-State: ACrzQf36H7/Fn4wxy63UMkZRhGfgJ1XiGQf5WMHD0Dw8WSqwIeGLvjUc
        PeJifFRprCm1CUe+f1yAtqF9stuvHaxQ2U0VJEsZSUUvKSA=
X-Google-Smtp-Source: AMsMyM4cbcrnEzI8IyIBJTuridAvR+HTV9wP1OMoLZ6qpd5uqq+VqkHMPZDrY/meyutGIsA2GQtg3IG91UN2xY76Sxw=
X-Received: by 2002:a17:906:401:b0:73d:af73:b78 with SMTP id
 d1-20020a170906040100b0073daf730b78mr20539867eja.122.1667329999851; Tue, 01
 Nov 2022 12:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221027-b4-spicc-burst-delay-fix-v1-0-5a6e9a88e54c@linaro.org>
In-Reply-To: <20221027-b4-spicc-burst-delay-fix-v1-0-5a6e9a88e54c@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 1 Nov 2022 20:13:08 +0100
Message-ID: <CAFBinCCx-8u_VNjNtjivgwp3aOc8cUppxstwzzLL1oGLtS6tZA@mail.gmail.com>
Subject: Re: [PATCH] spi: meson-spicc: fix do_div build error on non-arm64
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 2:11 PM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> This fixes :
> error: passing argument 1 of '__div64_32' from incompatible pointer type
>
> By passing an uint64_t as first variable to do_div().
>
> Fixes: 04694e50020b ("spi: meson-spicc: move wait completion in driver to take bursts delay in account")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
and also:
Reported-by: kernel test robot <lkp@intel.com>
