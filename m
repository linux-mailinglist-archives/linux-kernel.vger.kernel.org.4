Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3772365698F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiL0KrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiL0Kq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DC021B2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672137972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7BDaLx2vlolGs3dmZXimAfrXQipJ0Z8+AKbW5eVyvk=;
        b=RAAk/KJu7YC/n/xGRUh1XqMPtQEJ12tEBo+9EXPwOcaAIG2qpYfcq718N1bb486DTvAyKT
        8PkvSHa7CNLrUe0Vcd1A39gMiokxCluTYe7Bx8itz51tmsA0KA9KpQ+BwPs7vADRIgy4iy
        D4/GTeV40QwX0Ev6vfzbOso7XVsDCfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-vv5wg974NNWJuwdN3UeEgA-1; Tue, 27 Dec 2022 05:46:11 -0500
X-MC-Unique: vv5wg974NNWJuwdN3UeEgA-1
Received: by mail-wm1-f69.google.com with SMTP id bd6-20020a05600c1f0600b003d96f7f2396so6274619wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7BDaLx2vlolGs3dmZXimAfrXQipJ0Z8+AKbW5eVyvk=;
        b=5cyd8610bRqsk7YV0YdRAt8MscyArwxi5t+sseMF/e+u/sd2B+dJi9Yco5FAyBLx4t
         ODGUJtJbY+obFtWzCcymldHxsuowDJwtD9RaSomhmcqdQQ8AUMguKE/aNSUpYX3MLmxP
         86Nm69CXXxNG+ne/TgDob2wws0hzS2bC0X53hysaeoyE/hEzN02Fc1rDz+ZWA5/yYvep
         APPa9y7TIZQJwZTxwUCM98fHtSamLow3qlcWUNZfpqPqqaY2HZmpcNsUbVc+THWuJLKV
         6Nixn5NrvQtFMRgcVxAVyBUnJ9ErT9i33R7LW2tqV/PY2OCnj0M0OfeF3XJLMfvIoVTp
         8vmw==
X-Gm-Message-State: AFqh2koCgpJyG5rlhFBGrSzzWR+eiX+S/E+GrFZUOzafV+K/BUyCpOfv
        e6uFtl4zXehnlzBALv3By/n41LMRjMAxiSF2AlJGttibXHWjStYQ0esVql6KDmvHbRB/ipM+8LW
        bn92jD1koIiYGR/k7lrSydRuW
X-Received: by 2002:a5d:460d:0:b0:242:69f4:cb6a with SMTP id t13-20020a5d460d000000b0024269f4cb6amr11958151wrq.9.1672137970225;
        Tue, 27 Dec 2022 02:46:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvQS7Awi2feDRmYhRXXpgGINwihRjB8yjUFZf6u1fv0XYA4KBECYdgHzXt8AN8JgFECUhOuKA==
X-Received: by 2002:a5d:460d:0:b0:242:69f4:cb6a with SMTP id t13-20020a5d460d000000b0024269f4cb6amr11958131wrq.9.1672137970031;
        Tue, 27 Dec 2022 02:46:10 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b002366f9bd717sm14444667wrp.45.2022.12.27.02.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 02:46:09 -0800 (PST)
Message-ID: <1848f28f-6c6e-4a1c-b58b-ccd52ae723f8@redhat.com>
Date:   Tue, 27 Dec 2022 11:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/4] dt-bindings: display: Add Himax HX8394 panel
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Robert Mader <robert.mader@posteo.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221226134909.2822179-1-javierm@redhat.com>
 <20221226134909.2822179-3-javierm@redhat.com>
 <f47cab97-2c8c-a3d5-b362-774f970dffd3@linaro.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <f47cab97-2c8c-a3d5-b362-774f970dffd3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 12/27/22 08:44, Krzysztof Kozlowski wrote:

[...]

>> +required:
>> +  - compatible
>> +  - vcc-supply
>> +  - iovcc-supply
>> +  - port
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>

Indeed. I did test in v1 but forgot to do it after addressing your
comments for v2. I have fixed the example snippet now and done it:

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTEX    Documentation/devicetree/bindings/display/panel/himax,hx8394.example.dts
  DTC_CHK Documentation/devicetree/bindings/display/panel/himax,hx8394.example.dtb

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat 

