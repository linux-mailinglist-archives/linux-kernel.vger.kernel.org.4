Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E9F6C2302
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCTUle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCTUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:41:29 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511292203D;
        Mon, 20 Mar 2023 13:41:11 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l15so5609480ilv.4;
        Mon, 20 Mar 2023 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfP1M8AIpQDk/dFV6Re7F0lLwMe3nNKA3tGt6+sXSrA=;
        b=fqgInDamz/2KApokQYzyEA0HcCwgH2b0u/VF5rAWQVF/3Jwx5xvqiXtEQlyd7oW65f
         agUQ5obgzyK2bhDc6I/5ULgb+P/BCLs5i38UUwEDZuyoNiFwM0P9ZasrTUXVihlAVUBz
         8FZ7DHyUR+T02tNZUj72EjaGYqRdmzpMRXg+hfUwogH9uzzZmPLZFUya2B57nWlaAxq2
         o4uFCX4LO2ZnsJxYi+4xTl9UfF+iwbFFT8P3WqqPKEKphow2UhQ23JCvOtAFsunRNLka
         3YH9kw9wFEEyAsqsKJx33ndrg8VrM1fp2/zydqUnk9EAeUqjj1x9CLDvrvZlbRmPaIti
         Jj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfP1M8AIpQDk/dFV6Re7F0lLwMe3nNKA3tGt6+sXSrA=;
        b=5drYxV6kMjtLgRMhKKdts4jrTu/FEbz3YKhZcrILuJ0Jn9ubaVKiiuW0U9GkY2OxiL
         p6zdJRLKFSjY3+WOULSE7taF526JXIDOexth31otw+MgmgiDrED8/YGwx4+ys+ROoZK0
         VfzW9vTWz8sIf0uToipAFjjkzxhTKt7vdQqaaBVOxPQCR2VrY0+51wzQVzSBYY8yA+tB
         LNUeTZVoWoJ2KvlJZXd9kcAbnXijO8HfpYnPs/nUrhmwaedEGnj8AiH1NM7pJM0vSEGh
         AfXDlVo1ooiSnQ472dMCEJRO8JrXF/nouuGQxIbRdoVEzt7wGLvHJZGMzo61UIGzxw5U
         2/bA==
X-Gm-Message-State: AO0yUKWCmSysMOHuOrzj/HcRiz5UfCLFwh5f7sUAwv+O/wZcJGAKLZDd
        H8gJZy5EGeepKnoaOE1j6JWGlNkAUA8=
X-Google-Smtp-Source: AK7set/Jy0gPn/8VLWBE5pMhbyEeAt9lpYudgFKGUHcMaHHuJnNJDBpUNJ0hyh1VDjVpYm/+stOPBQ==
X-Received: by 2002:a92:dc42:0:b0:315:9937:600e with SMTP id x2-20020a92dc42000000b003159937600emr542324ilq.26.1679344870512;
        Mon, 20 Mar 2023 13:41:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n16-20020a056638111000b0040619720af8sm3455751jal.35.2023.03.20.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:41:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Mar 2023 13:41:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: trivial-devices: Add acbel,crps
Message-ID: <13782cac-c46d-4299-896f-ac0341c26f45@roeck-us.net>
References: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
 <20230320154019.1943770-3-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320154019.1943770-3-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:40:16AM -0500, Lakshmi Yadlapati wrote:
> Add Acbel CRPS Series power supply to trivial devices.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6f482a254a1d..ae2cf4411b39 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -30,6 +30,8 @@ properties:
>      items:
>        - enum:
>              # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
> +          - acbel,crps
> +            # Acbel CRPS Series power supply

This is way too generic. There is not just one Acbel CRPS power supply,
there is a whole lot of them. It is very unlikely that they can all
be described with a single devicetree "compatible" property.

Guenter

>            - ad,ad7414
>              # ADM9240: Complete System Hardware Monitor for uProcessor-Based Systems
>            - ad,adm9240
> -- 
> 2.37.2
> 
