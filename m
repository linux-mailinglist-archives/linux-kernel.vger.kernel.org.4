Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92233654DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiLWIpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiLWIpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC9357B7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671785099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=saMXhQ6FaRFb79mAY11mIOCOiw3Mj/T5tk9AKBUTHeM=;
        b=X+1+Q9UQIRazUif3ENhNP/iRtLcjOi+ur838di2FLdoYDrpWiqP/vhAQHr+DXWfrmF6adq
        hRVBsbVD9Zd1SKmwMUhj/HouzONkvdDs8dTpWTz3pfTQl76+8Y+sFNo5refamMKvlHC6F9
        9dhsSgPUWSrHDg978Sg6q2G1I0TKogw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-29-7UMb2DCJPEyVNDkLfBVJJw-1; Fri, 23 Dec 2022 03:44:58 -0500
X-MC-Unique: 7UMb2DCJPEyVNDkLfBVJJw-1
Received: by mail-wm1-f72.google.com with SMTP id bd6-20020a05600c1f0600b003d96f7f2396so456744wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saMXhQ6FaRFb79mAY11mIOCOiw3Mj/T5tk9AKBUTHeM=;
        b=u1ub5EUXwXqNTH5/ec9ukykSp/Vn/e4tOdTKReK/Nn2bn4fOq4J4/8hsQfwpaqmfcF
         fpwrjLyVHoVnDeJ0XUaMruNOo6xaLCie63QbcT2gYT1O8JDMLJeBkoW//+JzEY9L2VIx
         pun2FwjJ0eUflE9DPd9cdYFXvAL3aA9L4LaXMZ/YtU0UWVw+wM237Y+OXnxRBgq5pVad
         GTZE9zBFn1VRz7LFL5AyxsuQGo1ve19OLnRDVWKeSz1p/8Xa4w30apAsIxRMneri6NY4
         ghum+BGuA+PVyVxjG2w1f9nmfaANQ3gTYJ3wtpPlXO6fq+W3AAWBXOGeSLoZeP3WnuhP
         KXDw==
X-Gm-Message-State: AFqh2kr8qBN7usHqsvp+tDHW3dIwdAiuWnh15z+gh/sQazUWywkqOpJt
        b7MBcf5JwCLOYMgPp473eoNmr5TZBdtVEgwmuh1thAOWZnHV0kdqzy1fkYhhDwKTXDKvWkmH1Mo
        2ptg8Xvi2fG665S0iCn3GLapH
X-Received: by 2002:a05:600c:4e04:b0:3d2:381f:2db5 with SMTP id b4-20020a05600c4e0400b003d2381f2db5mr6216509wmq.22.1671785097116;
        Fri, 23 Dec 2022 00:44:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt1Fkupw8Va8m6hEvjj4yEMTWjnMAE5PPtO0pCOALsERpBky1niqrg1HyQfg57dwjlb1upXpg==
X-Received: by 2002:a05:600c:4e04:b0:3d2:381f:2db5 with SMTP id b4-20020a05600c4e0400b003d2381f2db5mr6216489wmq.22.1671785096950;
        Fri, 23 Dec 2022 00:44:56 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b003cf4ec90938sm4316705wmq.21.2022.12.23.00.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:44:56 -0800 (PST)
Message-ID: <f86d661c-7ecd-4950-53c4-6a342d2fe963@redhat.com>
Date:   Fri, 23 Dec 2022 09:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] arm64: dts: rk3399-pinephone-pro: Add internal
 display support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Robert Mader <robert.mader@posteo.de>,
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
 <a73d99fb-0d47-ad93-27e2-9b51dba4b824@linaro.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a73d99fb-0d47-ad93-27e2-9b51dba4b824@linaro.org>
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

On 12/23/22 09:13, Krzysztof Kozlowski wrote:
> On 22/12/2022 23:38, Javier Martinez Canillas wrote:

[...]

>> +
>> +	/* MIPI DSI panel 1.8v supply */
>> +	vcc1v8_lcd: vcc1v8-lcd {
> 
> Node names should be generic, so regulator suffix or prefix (looks like
> other nodes already use suffix)
>

Indeed, Maya already pointed this out. I missed this when forward porting
this patch from the pine64 downstream tree.
 -- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

