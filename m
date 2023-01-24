Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27333679B52
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjAXOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjAXOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:15:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99147EDD;
        Tue, 24 Jan 2023 06:15:22 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i1so11286351pfk.3;
        Tue, 24 Jan 2023 06:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPFSsnfgBHnR6r/v/HTwsyyR49qFnc3Enl2TTvdrGH4=;
        b=jAZSAneKnxki1ApFf2pOjDUAQjqsSUDAQP+Q5ZHhqwJYTDuJHDC1fPoOcAcnwHv8Io
         26WzuyHHOAUH9rNnRk8QCH/ihX4pUSa7LQ0KXlbLff6ly1RrcuTseiwzomQRP1+/Tofo
         nXzDF6QRU5slDlMZf0UsCagwQdX5aTCqJd3J8U0L71Ka9XiyChejSzDgheOHYcTHYl9o
         wMXtqWZIOBlZ4qW+NIN6ESQll8WMGDL/XSsyqHxjO9mF1x1VJI9RDiFWHsyrC7KVUoxY
         h5fX/w2dfLKxc0zVqXb160TBiEER074Jus0LMj+NPcgQ8oigT3hiAm+XqFLRilV+nCRY
         x73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPFSsnfgBHnR6r/v/HTwsyyR49qFnc3Enl2TTvdrGH4=;
        b=wHj1UPQ202GJazgt/YydidT1XKFeDM9a4bzxwrWqq9/6UAGLozt6IYvWHlenLH7nBO
         QVhVBsefOemA/IpiDgRtaZNwfVrDD0xb6lqRrdjSclSnt+J0tO28NHLnNtAKzanxrUyD
         Eco0iCKM8aJgiU0DgL1z/T6ErOoaJG0Sw2SJB4/1pyTPuWNmND8pWQb5igV4nv780ttW
         bqWGU4pfX8vlp+cz2coiqqCpFxyvlLtXoJQ0AZsELd2KGavRLG5jDDf3gVBg+HodGpEA
         jjrX4KyKbjgUtv28raqICgp3zYr1N1V5//H3xANkkl5shHWZQ5K4M4ePVY2qgNy1RIoO
         05RA==
X-Gm-Message-State: AFqh2kpQxXSCRR9L7MkUAohCZPnoMdUuiZUAT3reW5MSnzFgLDPlSJGo
        7HCOwYnw982a1CXh0wVJZtM=
X-Google-Smtp-Source: AMrXdXuTSnHq2ajdtWq4VkjgtQb03onDVNX5b77OIpkAeXcH4hiur8bmo/k9BO9WmoywfGhQRH4Mpg==
X-Received: by 2002:a62:61c3:0:b0:581:2a6:f04c with SMTP id v186-20020a6261c3000000b0058102a6f04cmr50003110pfb.30.1674569722043;
        Tue, 24 Jan 2023 06:15:22 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id z2-20020aa791c2000000b0058da92f7c8dsm1712001pfa.17.2023.01.24.06.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:15:21 -0800 (PST)
Date:   Tue, 24 Jan 2023 22:15:13 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: Add device tree for Xiaomi
 Mi Pad 5 Pro
Message-ID: <Y8/n8X1XWuaTS+lq@Gentoo>
References: <20230124135318.10023-1-lujianhua000@gmail.com>
 <20230124135318.10023-2-lujianhua000@gmail.com>
 <f7a93a51-f104-3c75-8e59-6f718255555c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a93a51-f104-3c75-8e59-6f718255555c@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:03:17PM +0100, Konrad Dybcio wrote:
> 
[..]
Thanks for your qucik reply, I will send new version patches.
