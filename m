Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C1E654D98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiLWIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiLWIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:39:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C5357B5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671784718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZaM5RaawEocKEQbKOSqiq42IHOql7KbQpJo4YjSpeA=;
        b=eZLEGSh26G/XMRjRdB5QrfbcpUNDwxnyOLAYnrNxvOz2UZtjGBqR9n/XN4elwPam6fnrOf
        HHzOacpGUX6FfO6xQX/o5a12bytkfTBW/vsqvXQjL0AilnI147TF3E1aOHLxsc/3PYzIZh
        ngkWr/KUKLvW5MfGHStkJOyDeloVkKc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-ZM-AEzwQPtGOyklr2tI2eQ-1; Fri, 23 Dec 2022 03:38:36 -0500
X-MC-Unique: ZM-AEzwQPtGOyklr2tI2eQ-1
Received: by mail-wm1-f71.google.com with SMTP id v192-20020a1cacc9000000b003d21fa95c38so1929775wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZaM5RaawEocKEQbKOSqiq42IHOql7KbQpJo4YjSpeA=;
        b=Fj3Ik+Wgonh2qCQwu+Bc1etWEK8IQOQ9q6FBJhxrkAqqv0XBSs2gcXEKsXOmWD5tZs
         s137Jsk+I3bGP9j8qjR0blqv9I8vbl74N/Vpr55EsrW65R2TCv8J4FzSghvt0swOzzG3
         ePurxS9d4y0Pd7uUxbpD+kU8agxwazjPC+4+2/MJHGWO//o08CohslCpuKESiVg2+u7E
         XPDs5QP3YhTpopEGUu3ewqSnILt9H7X9maPwzpOGxf/duiz7ck3ULZtvUlDjZ5mTUXIr
         Y+GfsuWAbWOD34RankWDXQs5sKIk7eIce4I5cOsI9kAG+fV6GSePBEBNfPxaJhZ98mRl
         dImQ==
X-Gm-Message-State: AFqh2koF6RGlJf5eUyjPabBjMZiDJkds28ghbBLrJoe1JzngIhHi/PoW
        iXkcWUtMH3DPhvrta9VmvksY4UkpScChAAUKXtXw0cZQaFq+kB5+FQ5077QAJ6+uFkjSPdif3ry
        ziSUYS+9FBZ0pf9ZSQPBQvtJs
X-Received: by 2002:a05:600c:22c4:b0:3cf:8ed7:712d with SMTP id 4-20020a05600c22c400b003cf8ed7712dmr9226057wmg.14.1671784715689;
        Fri, 23 Dec 2022 00:38:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuHR0lUeavKdI1qt8CqUCBjmUtjFYm6N205U+J8Kt1KyzbAi6jBgUST6zdEQwLA+dJN6GrcCQ==
X-Received: by 2002:a05:600c:22c4:b0:3cf:8ed7:712d with SMTP id 4-20020a05600c22c400b003cf8ed7712dmr9226037wmg.14.1671784715464;
        Fri, 23 Dec 2022 00:38:35 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c161600b003cfa622a18asm8000118wmn.3.2022.12.23.00.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:38:35 -0800 (PST)
Message-ID: <ad8acc7d-7f23-2ab3-bd1d-445d6e5f74fb@redhat.com>
Date:   Fri, 23 Dec 2022 09:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
Content-Language: en-US
To:     Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Robert Mader <robert.mader@posteo.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20221222223830.2494900-1-javierm@redhat.com>
 <20221222223830.2494900-5-javierm@redhat.com>
 <CAO_Mup+P-QMDfVzpg_eg=gmoHUzm6+Kipaq-4q=kdVdS0_xp6A@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAO_Mup+P-QMDfVzpg_eg=gmoHUzm6+Kipaq-4q=kdVdS0_xp6A@mail.gmail.com>
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

Hello Maya,

On 12/22/22 23:57, Maya Matuszczyk wrote:
> Nice to see Pinephone Pro getting worked on.
>

Appreciate your feedback.

I agree with all your comments. Was too focused on the panel driver and didn't
pay that much attention to the DTS snippets. I'll clean these up on v2. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

