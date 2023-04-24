Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665036ED0C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjDXO5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjDXO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:57:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87F491;
        Mon, 24 Apr 2023 07:57:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so4703951a12.3;
        Mon, 24 Apr 2023 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682348223; x=1684940223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jEergD1zL+x+aQvzC4nZYBIEvad8Ak+41UsuXipqhFc=;
        b=daWGnk80/s+NkWCQfiZZzM4zMKHuCsmCLPNnsyOBAFLYYduZBvQ7PYCHuEUODWV3fG
         +oB2zvqzkqGL4lmFcZvpfx1+VAzhWfAD+u4bGVThPtSQTJJ4Qdgz4XLqBKA9CjhFpAcT
         OK00g+rUYP64cM1YGpThpChpUFdmVh6CVeDpTmJQ/esoclD7ZKlbI59cYwQp7FZEN5wC
         T+Sr77H1SU1z8cI1y9mssADnwM8s3I8Ey6E261Ni8ty3CkKZjLTDsxbhRnFap4R4J6c4
         vt1GSTIHPt+AetCfbLvXB9iJa6nBuk0NlSZRdN3UBGoBoAyvzGig58cuWrMw2pMrRa8G
         xX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682348223; x=1684940223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEergD1zL+x+aQvzC4nZYBIEvad8Ak+41UsuXipqhFc=;
        b=PwOR/KyBMKbVNiW/jH3t356zMeXY2tdFH8PzWAZgrLkGI1qILz6rxW9+RTFVIPweGo
         Z+phHNzlAFCUE2+Vo3RgGGcmkMX+cYVXIauJOxBehEsp9FSNGRgVy+Le5k1F7jfVoxmI
         NA0sph/OswF9+/wO42K23lR5UJdKA30L7Qy6eQqU1vcAI/75YVH6PGms0MhLuPR4zBDr
         D/UchDJe2q/IEIdH/qVOc+UOwnC6xZpcaJ1AOJLiQ+r80bPyq1lPIVNuH/FCSdxYkAaz
         ndkY6MAXSC5LvuxDDr5tPZe3lOPO8SuYP+gVSfG/UzjGgcBnLQJiCVgPRJZTpEHuGv0t
         jvGg==
X-Gm-Message-State: AAQBX9dDa3We0x2wndD3EuzdAwXW7tN/RAVuM+UXlG+GWZBaoL/U+iBh
        9Jp1V1fekxgejD8Z3q8T7VU=
X-Google-Smtp-Source: AKy350augUtMjy3xQ5O/eilz5C/4FjY9bf3NvJ0sCaWZf5j9G0SVCqA0ZyK3n9jR3R+cdiqMzDyaDQ==
X-Received: by 2002:a17:90a:ac18:b0:249:6086:a301 with SMTP id o24-20020a17090aac1800b002496086a301mr14082137pjq.27.1682348223279;
        Mon, 24 Apr 2023 07:57:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mh16-20020a17090b4ad000b0024781f5e8besm8483942pjb.26.2023.04.24.07.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:57:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aabe7488-29b8-895b-38b8-67e5a7d1dd35@roeck-us.net>
Date:   Mon, 24 Apr 2023 07:57:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 0/3] Add support for ESM
Content-Language: en-US
To:     Neha Malcom Francis <n-francis@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org
Cc:     nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, kristo@kernel.org
References: <20230424105011.70674-1-n-francis@ti.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230424105011.70674-1-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 03:50, Neha Malcom Francis wrote:
> Resending as no major changes, commit subject change only.
> 

Maybe you consider changing the subject of the bindings from "misc"
to "hwmon" as not being a major change, but it made me aware that you
are trying to sneak bindings which in my opinion don't belong there
into the hwmon bindings directory. This is not a hardware monitoring
device, it doesn't have anything to do with hardware monitoring, and the
bindings do not belong into bindings/hwmon/.

Maybe you can convince the devicetree maintainers to accept the bindings
into the suggested location, but that will be over my objection.

Guenter


> ESM (Error Signaling Module) is a fundamental IP responsible for
> handling safety events. The driver currently present in U-Boot is
> responsible for configuring ESM. This patch series adds dt-binding and
> nodes for J721E and J7200. This goes towards end goal of having DTB sync
> with that of U-Boot as well as ensuring completeness of hardware
> description in devicetree.
> 
> Neha Malcom Francis (3):
>    dt-bindings: hwmon: esm: Add ESM support for TI K3 devices
>    arm64: dts: ti: k3-j721e: Add ESM support
>    arm64: dts: ti: k3-j7200: Add ESM support
> 
>   .../bindings/hwmon/ti,j721e-esm.yaml          | 53 +++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  6 +++
>   arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  1 +
>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  1 +
>   4 files changed, 61 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
> 

