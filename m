Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D481E68EA81
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBHJHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjBHJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CAF45BF6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675847185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SRi2tCsuOLJoQz16HbU6hg4NjL1uIMJ9unPVHJd4sSM=;
        b=h7fFgIE+k912pmhCY+3Vc9dzdkmxl7bmkM10ZhfagZ84jCVzmB0dOeSuipdqXU8JOaV++4
        w6+zly/NhnBsO3CspuGTABY9d8/au/puTfMsAbCUWUIu+qiSVLOE8b9Ih9Gt8PBIzLHzQM
        5+gTrPOZO3Tpazih1dgrA+4QpKfAfw4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-318-bVmL0WCSPcyVKKsPh1wOQQ-1; Wed, 08 Feb 2023 04:06:23 -0500
X-MC-Unique: bVmL0WCSPcyVKKsPh1wOQQ-1
Received: by mail-wm1-f70.google.com with SMTP id o8-20020a05600c510800b003dfdf09ffc2so8192845wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRi2tCsuOLJoQz16HbU6hg4NjL1uIMJ9unPVHJd4sSM=;
        b=RdmgQK6Si1sclH79O1fCELZhbgxkC1yHm6mX8TsWKE2k1OcAoZEtTIB/RLJRn8wVjx
         NxfagNbo08NIlOMokYh0utiXqJ6l/+1k24FTxbpndGlcTG+hAC7zSXKFV9UX0Ge7rL6Q
         /7Xwr0Xq13kHYgCcbgzM3oO4abHe8+SThrwg9i8NkYTKqbitQTbxZq10VSwRSTLX6uDV
         t/6FV44MO5xVWY6S4aPpwqBfbt71LpxNCWoszla5nfAjNz4KlUlKGlO8MXD4kdMzyKBN
         2XzULlA2y8Wg8Qbd5i7afL4S1gNVqnRdS1eoCMMT01Zeqqu0JrzvlLIKxZhfxtqRPG7s
         2qBQ==
X-Gm-Message-State: AO0yUKUvImFuTH/vomhnRNol+DwUe8Tevcp/fifvTpEfLN1ShniaKqgK
        BlZ8xIfcrvs3xRb9ZmD76MM0Ej460cNex+pJHHoSPX8c2w2coil8/wdaozN12CE971UXnrOLdWt
        G37julVEpwhqsxkLvEJ6i08T5
X-Received: by 2002:adf:e3cc:0:b0:2c3:df05:b1a with SMTP id k12-20020adfe3cc000000b002c3df050b1amr5904235wrm.71.1675847181115;
        Wed, 08 Feb 2023 01:06:21 -0800 (PST)
X-Google-Smtp-Source: AK7set/k/7l50TXIQVYYeZY67BmTWHXujQFNMNbuLHWBhMgxQfjdhadxx3tu6ctEY4QeFNCcCLrSlg==
X-Received: by 2002:adf:e3cc:0:b0:2c3:df05:b1a with SMTP id k12-20020adfe3cc000000b002c3df050b1amr5904210wrm.71.1675847180947;
        Wed, 08 Feb 2023 01:06:20 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k6-20020adfb346000000b0027cb20605e3sm13397155wrd.105.2023.02.08.01.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:06:20 -0800 (PST)
Message-ID: <ef09bc9f-d570-be11-238b-bd34063917fc@redhat.com>
Date:   Wed, 8 Feb 2023 10:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
Content-Language: en-US
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vikash,

On 2/7/23 17:40, Vikash Garodia wrote:
> Hi Javier and Matthias,
> Can we try the attached patch if that fixes the suspend issue for sc7180 and sc7280 ?
> 

I tested your attached patch on an SC7180 machine (HP X2 Chromebook) and as Matthias
mentioned, it still causes the driver's probe to fail:

[ 2119.063779] qcom-venus aa00000.video-codec: non legacy binding
[ 2119.085695] platform video-firmware.0: Adding to iommu group 11
[ 2119.156302] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x000000b0, fsynr=0x61, cbfrsynra=0xc40, cb=7
[ 2119.259382] qcom-venus aa00000.video-codec: failed to reset venus core
[ 2119.267782] platform video-firmware.0: Removing from iommu group 11
[ 2119.275052] qcom-venus: probe of aa00000.video-codec failed with error -110

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

