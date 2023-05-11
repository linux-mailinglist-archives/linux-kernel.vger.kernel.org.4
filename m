Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051636FEF45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbjEKJwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbjEKJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:52:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAFBA240
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6439f186366so5137822b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798689; x=1686390689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7K36+8B1SD1Xzb+iZd8HUsYEkuMTLaZcxAaH/mKK2nA=;
        b=ys2fxS+jiP+VebXqtBioQkEWSrWqd7rkCu7w3vP8ao9vMswqXdH7sqsFkicH9K06iN
         U56srgtrSyPa2tm2qErelnEXM2SeRI34kDqqZviUTcM7/tgJa87TZxrY0054AdSTcK8l
         mjuYnXG1LCXmxymon+LTBCLCS9m9H9WApEI2DcIrNKomaHAs7OAAnJjxkDXBOGbkKjXh
         4ouV4Tr6bg3AnWaoQ3bkLSKoBSz02MtBySowxQqYJ5YnPMa9bXCJ2vcCO9SjwUx4GbU1
         +cKoBNnK/CLyWGKnU17Qb++V5nVBVdJfyC8ARCuHIqMcwpYh6ktJ/gEQzXqaytO7LGqL
         8aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798689; x=1686390689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K36+8B1SD1Xzb+iZd8HUsYEkuMTLaZcxAaH/mKK2nA=;
        b=JbD7tb9typaagRV9R2i3qVOB71BMZbiECo+uF8dsAtyBs8JV7vzzyiDD4/4FJIQ2er
         xT8qIoTP0wpU1GDVpcKSaeWZ3n7qdE/ppCrVHmGDXe+GsqyU/yiPdCveD4aMhQuN1W2x
         gyYjfM2/GXy+jH7D23ji7Vl7Xv9sBfTX/mNjk6BMUWdcO02BUZgVSJvFnSmOhhKqbIhM
         eOPGUJbTxqCrbpcMUkwsOrXB0ymmLn0BcGmwUuBRcrY18CGkAwIINyYQqLpLUIh0bpZP
         7TmrHgZPYMuuOwIdWhf0CVWqYS1FFDeHDW5oyuNwWURmqBx4aNePV2Y2mB4m/gIJ+IGv
         P0/Q==
X-Gm-Message-State: AC+VfDx+eL2+JGI7h1ZsAZAGf5ghfd4QekPNYL/gyTXXUVX103Nk0fgh
        e+mN8MiIZR0nP9fwFMQKYcNXoA==
X-Google-Smtp-Source: ACHHUZ6KrX+X3hwabbbDxK5Sf/9lze6eTyuVdLoRkJIOf1HU9Yqv8RuUQUMmjCY2BCdN2ReNoOy/tA==
X-Received: by 2002:a05:6a21:380e:b0:f0:69db:ebea with SMTP id yi14-20020a056a21380e00b000f069dbebeamr17813824pzb.30.1683798689000;
        Thu, 11 May 2023 02:51:29 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79197000000b00640f51801e6sm4889071pfa.159.2023.05.11.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:51:27 -0700 (PDT)
Date:   Thu, 11 May 2023 15:21:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: imx6q: Disable only available frequencies
Message-ID: <20230511095125.ye5jt62dwrvjas5m@vireshk-i7>
References: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-23, 11:23, Christoph Niedermaier wrote:
> In the example in Documentation/power/opp.rst, an availability check
> is present before disabling a specific frequency. If a frequency isn't
> available, the warning of a failed disabling of a non-existent
> frequency is misleading.

Which warning ?

-- 
viresh
