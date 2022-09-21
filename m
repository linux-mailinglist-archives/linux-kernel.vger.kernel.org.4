Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBED5BF6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiIUGzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIUGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:55:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0352E6F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:55:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f9so7650534lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sRNPPxQwMPWqLWjhj5YW/0hO23m4s4pA3ZxgfGEgLeQ=;
        b=G/8D3dSTttTpzXOjAWi9d1DQ7rTiVYMus6IL0Yb5KZ5Q2Ga7EPgRD7cGkuN3oXp67N
         dmtxinE/F2lefDeiN5Ij/Rt1oeRF82EaERJRGGA3NUnVDVE0zQ/nia9twKkSN5yQ/dVP
         tkp4MTTuTJW8soQP+qoOjyxARqSjRRf7zBaSx8LRkvWGDZ/5UM1zl78GaptJVuhgNSta
         JZ/U7v7Cj1TxFgdm9RzH2//TZ3zWesVB1P0DaKR5KcLqi3QJpDgjIy28r1eOz7p0oG/3
         /ulJnrHBrByf2SlZluGEDoOay0gHJNS7q3f9v/bFip0SATm9KZ4IihcB0S/d+KHU6QHK
         PARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sRNPPxQwMPWqLWjhj5YW/0hO23m4s4pA3ZxgfGEgLeQ=;
        b=Pyz/3zYtLlh6Z26253SNKSoIPdOO3L59E3DiAmYL3/uElIj8amHEfKuvhsI0TKBnq9
         mNtdFz4m6dl2rTWLFMe40Oaa1bWxeEdE0pti4Ws1Q7gA6gYPOKdKWuyupXLyx4CVR88i
         P8ovs8VxbF+CyPXtEMipNobAas817R3ucui4v8uAjD2Wpz78biIaJt/J0hzHGowYIcXH
         aaJ0syyFitTcifUyIlH18/glLzbEuDgQLTxEqAA9EdKPCMuACHbqUNpw2Qre+PE+Hqc+
         MexN52c+45qsQWXRkeXSWNHrHeWV+9wL1mwzTXNJpDOytr+lKxtK9sXRnQfaQ+o4Ziqw
         oWPw==
X-Gm-Message-State: ACrzQf0O63GamdqrLEC5E2qau3AZlxZOsqNIIYp/AifpZzWpjQ7ZbqZK
        0jdZn14qhGTUgUwnHujKX2q/Xw==
X-Google-Smtp-Source: AMsMyM4DTkJhb6tltXybTUjMwPnetSGfYqWpxsNwBGB5mUV9PpXWl3QlTC+kYnYLuO4XT7A9lMwEEw==
X-Received: by 2002:a19:5f59:0:b0:497:a72e:e0a1 with SMTP id a25-20020a195f59000000b00497a72ee0a1mr8976594lfj.259.1663743308568;
        Tue, 20 Sep 2022 23:55:08 -0700 (PDT)
Received: from krzk-bin (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j21-20020a056512345500b004946274b7d6sm305694lfr.166.2022.09.20.23.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 23:55:08 -0700 (PDT)
Date:   Wed, 21 Sep 2022 08:55:06 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        Khalil Blaiech <kblaiech@nvidia.com>
Subject: Re: [PATCH v5 8/8] i2c: i2c-mlxbf.c: Update binding devicetree
Message-ID: <20220921065506.6cu6p2cpu3zfhtie@krzk-bin>
References: <20220920174736.9766-1-asmaa@nvidia.com>
 <20220920174736.9766-9-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920174736.9766-9-asmaa@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 13:47:36 -0400, Asmaa Mnebhi wrote:
> In the latest version of the i2c-mlxbf.c driver, the "Smbus block"
> resource was broken down to 3 separate resources "Smbus timer",
> "Smbus master" and "Smbus slave" to accommodate for BlueField-3
> SoC registers' changes.
> 
> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
>  .../bindings/i2c/mellanox,i2c-mlxbf.yaml      | 48 ++++++++++++++-----
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.example.dts:26.19-20 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
