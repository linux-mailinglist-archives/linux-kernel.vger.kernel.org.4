Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F35690FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBIR4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBIRz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90E65D1C3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675965319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfSndtfzj6buNB/Mqo3dLMDWEWOsRwTKIh0xVw3PscQ=;
        b=WEdbhDAlCo4zM2zq+lSr8utsuiCfRFt5VvLGcI4fZwz6OOu6CkS8TuQklceNW/Q88eVyY/
        yDhtM1hW/Tk42pVgkdXONannrIlch8Nnq+j1NgbW8p4pPaipl8kwUsTff8aPnuVHcNDc2A
        tk7xRcGyK1dbxI03a92EUMRdABoUkKU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-wRfxkbAYOUa_cKYT4Krldw-1; Thu, 09 Feb 2023 12:55:18 -0500
X-MC-Unique: wRfxkbAYOUa_cKYT4Krldw-1
Received: by mail-qv1-f71.google.com with SMTP id jh2-20020a0562141fc200b004c74bbb0affso1659228qvb.21
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 09:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfSndtfzj6buNB/Mqo3dLMDWEWOsRwTKIh0xVw3PscQ=;
        b=V9cD2cDMDDabn8xPu9lvmHd5IJS1hnRwawQWpNt5MVD3wJHjdWcdtqD6JcbMBObgWY
         yPdMGjHIBv2oSeknjNaCJLQQQhXelbs6RWjlTsd/Xc/jNtT/Ys8oclQ3YtTTBBXJ0/QS
         OfYF1KQQSH9bciNUydWz+CnhfeAz77S/F7+cTpn1egIhTJR37kWGxx09MfW5NFawGpsf
         5yZitjmI2hbxUZWdZUTjKUJmsMU852/IV/Um95CdZIHFa4wdHuZbMilDrdFeub49cRuV
         GASDv6pFOebqDPOe2huVbL9kpdc+vjxRh2sy4jKnVcZzGIyHm6B9CH0WEMF9QOOkwt5J
         vMEw==
X-Gm-Message-State: AO0yUKWec5oQpvJZeZGxT8ykawmlWgfBHlpjtBhXKgee+J9J+O4TcEkQ
        UdVQ9Yp6g8F70N9oK+S3wwf9DkR+GNP3GewUu68/d4rBy8KKZCpOB87mKoMoHLpRKCtF0PP475u
        GtbkRo2wPtBMPH7R/rZxxDsgc47cZFA==
X-Received: by 2002:a05:6214:519e:b0:53d:ab5f:d46f with SMTP id kl30-20020a056214519e00b0053dab5fd46fmr18023201qvb.44.1675965317066;
        Thu, 09 Feb 2023 09:55:17 -0800 (PST)
X-Google-Smtp-Source: AK7set/J1GkXSNiF1pdtEd7Yj6teE0aUrr3u6Q9rshfIv82y92vJxVQqykEMC3O2ahqTXrW6Ym26wA==
X-Received: by 2002:a05:6214:519e:b0:53d:ab5f:d46f with SMTP id kl30-20020a056214519e00b0053dab5fd46fmr18023173qvb.44.1675965316834;
        Thu, 09 Feb 2023 09:55:16 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id t185-20020a37aac2000000b0071eddd3bebbsm1799087qke.81.2023.02.09.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:55:16 -0800 (PST)
Date:   Thu, 9 Feb 2023 12:55:15 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: qcom: add the SoC ID for SA8775P
Message-ID: <20230209175515.xrebz5edmsi4xkzv@echanude>
References: <20230209095753.447347-1-brgl@bgdev.pl>
 <20230209095753.447347-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209095753.447347-3-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:57:52AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the SoC ID entry for SA8775P.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Chanudet <echanude@redhat.com>
Tested-by: Eric Chanudet <echanude@redhat.com>

-- 
Eric Chanudet

