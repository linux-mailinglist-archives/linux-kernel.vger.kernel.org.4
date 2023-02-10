Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A0691C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjBJKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjBJKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C0226A3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676023629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntExVcX2zpshND9UNOnxaEMSIbbr4Th0LFPKOz+KlP0=;
        b=h97JS9DKv168q3TaN/20ak3lKz3MBbNm3uIvytpDsctxKKU8YPuV2Q6g1/y+L3oBD4IRXD
        hgN/V8gnpoZCovveXiQcPMkMsgYkp3T/3+9J3tyqEdmXHqgHJpAu6TSyBxub7QgPu7DkaH
        WNXeUJ2r2za/JtB/MeDVbWXAsB00Z1U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-OQJQrXh3O7KZjYhfdoMMjg-1; Fri, 10 Feb 2023 05:07:06 -0500
X-MC-Unique: OQJQrXh3O7KZjYhfdoMMjg-1
Received: by mail-wr1-f72.google.com with SMTP id i9-20020a0560001ac900b002bfda39265aso1133867wry.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntExVcX2zpshND9UNOnxaEMSIbbr4Th0LFPKOz+KlP0=;
        b=66gVoReVkLyIrsxCw2VuVeMKOAKtF0nv6EL8O72EkcMu7/W3vGzEV9tHxmC07JQtKt
         3p8/e2F3yvCAbtlvaLbLP+cBlFJg3kt/6vUfTahmU/GtQUYbrUryevp0A2R6ZgsiKL0N
         VlvvrNYZB7MhSenDJqQ17shkTEDzZQyRYyYA9wgrgBvLIf/HA9tGI3zzoTwofE+cOKI1
         Vb/1u9527KtgA5HmPLEyGgszTy84pE2pzQxDw6UxZy5oOkXxw4I7z9TNlnCND9iJyb76
         MKwLxrkZDygiGmaRU66B+yZgKvSpUjzy2k9kU8SWqFC2IjQINIGWjntkCwzT2WNw5oSV
         YGWw==
X-Gm-Message-State: AO0yUKWO9+nPVC725d0KOsmACC1wYTrdC3JJpdYoYIdfr9l8FeGnsOhT
        GmYFBJNY2+Ewd3miDJ2gGd6solBOiU8+z60x1e+XSqSh1CPI4Hdx5KH0idzkgdqLagdKXqCbOQL
        W+jDvTRG2Qe1GF8lBmP+l5W7E
X-Received: by 2002:a5d:5341:0:b0:2c3:eaff:aaeb with SMTP id t1-20020a5d5341000000b002c3eaffaaebmr13577679wrv.21.1676023625114;
        Fri, 10 Feb 2023 02:07:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8+Vork7W3EVzOtUBHjxqMsMetvc9V28TkbMVisNUCWK9d969tKv9WJXzwkmtJOkAieKxg+MQ==
X-Received: by 2002:a5d:5341:0:b0:2c3:eaff:aaeb with SMTP id t1-20020a5d5341000000b002c3eaffaaebmr13577670wrv.21.1676023624944;
        Fri, 10 Feb 2023 02:07:04 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u6-20020adfed46000000b002bf95500254sm3306658wro.64.2023.02.10.02.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 02:07:04 -0800 (PST)
Message-ID: <e87344c6-acef-7f3f-5cac-24961dbd9401@redhat.com>
Date:   Fri, 10 Feb 2023 11:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
To:     Vikash Garodia <vgarodia@qti.qualcomm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>
Cc:     Albert Esteve <aesteve@redhat.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Fritz Koenig <frkoenig@google.com>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "Rajeshwar Kurapaty (QUIC)" <quic_rkurapat@quicinc.com>
References: <20230207102254.1446461-1-javierm@redhat.com>
 <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <ef09bc9f-d570-be11-238b-bd34063917fc@redhat.com>
 <70c01751-1dd7-c4bd-a96e-94dea437aa40@redhat.com>
 <DM8PR02MB81696369DBFE619E43F81EEFF3DE9@DM8PR02MB8169.namprd02.prod.outlook.com>
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <DM8PR02MB81696369DBFE619E43F81EEFF3DE9@DM8PR02MB8169.namprd02.prod.outlook.com>
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

Hello Vikash,

On 2/10/23 10:22, Vikash Garodia wrote:

[...]

>>
>> So what should we do about this folks? Since not allowing the driver to probe on
>> at least SC7180 is a quite serious regression, can we revert for now until a proper
>> fix is figured out?
> 
> I am able to repro this issue on sc7180 and discussing with firmware team on the cause
> of reset failure. The original patch was raised for fixing rare SMMU faults during warm
> boot of video hardware. Hence looking to understand the regressing part before we
> proceed to revert.
> 

Great, if you are working on a proper fix then that would be much better indeed.

Thanks for the follow-up!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

