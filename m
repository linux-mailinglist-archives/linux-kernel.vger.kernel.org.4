Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06569212B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBJOxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjBJOxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7266C7D2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676040770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1qMoGyZitDLtPNourhoy8BxIjCzMdWzl566A9X9xVk=;
        b=NiA48VHoVx4X7yRWb1xhES97aB4KPj9awwx3emXVlcp79KbKphDr8RLdbb1r0FvJuDy3+1
        oiDu0j/d4GtNL1/YttNj/uDoetEoWMCiuOEnKbSfr1pCUKyH912+3qmoL2eSegN89JMTVm
        LB//rmyLb6zAqIlesXUBmOI2JWEQl0s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-nCts081uMt2FNPsU9nWmoQ-1; Fri, 10 Feb 2023 09:52:48 -0500
X-MC-Unique: nCts081uMt2FNPsU9nWmoQ-1
Received: by mail-qk1-f197.google.com with SMTP id j29-20020a05620a001d00b00724fd33cb3eso3420544qki.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1qMoGyZitDLtPNourhoy8BxIjCzMdWzl566A9X9xVk=;
        b=FanSo+L5YqJ4PH7hr9xCmpRWKAoWnH1IN6rd5jqru8i8IFP0HRGMzF87UoGEeDUpHC
         ONs5K0nwvzQoX8Rc5ruXTQkny7/JxWSkd/wQTI7rbDpLCMuf0jwvciEa8G1O4fbPe0Zp
         2f/04RAYPpq7wxLnIOVZN74MiA0Jw41l83W98LQqQalQ9IwX2L4tOmdYOloqxVSQiyTH
         jKSEQbe94BpHWHlm0r1QX7IXnZfgCpn4Co2CKvsjVmTAAMOdPFiTThbN9q+TfYC72W5g
         Lj+qc0/u6LKrnNyzltnt0qaI4cS6TiEYpoisyINZJscAmSKQQydLd++gK0w8AzLD6NEc
         r6Ig==
X-Gm-Message-State: AO0yUKXx+81oSE6KK62k4CPsMW7iXft1SGkaFA79AdYSoN+DliC0W83q
        KsBw6RsHDuViMV92LA1UCvA3jDOCmFAy0YsQVUEaAMkOwJwDjSeHg04hoyofg3AfCEWsduD+t4y
        mwX+T7oSLyX81c/nzkXzGPMf7
X-Received: by 2002:ad4:5be9:0:b0:56c:14a1:b751 with SMTP id k9-20020ad45be9000000b0056c14a1b751mr19283557qvc.8.1676040767451;
        Fri, 10 Feb 2023 06:52:47 -0800 (PST)
X-Google-Smtp-Source: AK7set/0E8zBTwg/UC/GsP0b0P/sbs7EikwLvTC+cGGNrrA3jEg1RBwChVEkVmdpw7sOGcdiM3HM2w==
X-Received: by 2002:ad4:5be9:0:b0:56c:14a1:b751 with SMTP id k9-20020ad45be9000000b0056c14a1b751mr19283526qvc.8.1676040767235;
        Fri, 10 Feb 2023 06:52:47 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id 145-20020a370697000000b007195af894e7sm3644010qkg.76.2023.02.10.06.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:52:46 -0800 (PST)
Date:   Fri, 10 Feb 2023 09:52:45 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: qcom: add the SoC ID for SA8775P
Message-ID: <20230210145245.jyqir6odnkyr5zdl@echanude>
References: <20230209095753.447347-1-brgl@bgdev.pl>
 <20230209095753.447347-3-brgl@bgdev.pl>
 <20230209175515.xrebz5edmsi4xkzv@echanude>
 <d1d1bd4e-0205-24d1-9589-6d6b57b6d477@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d1bd4e-0205-24d1-9589-6d6b57b6d477@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 09:58:29AM +0100, Krzysztof Kozlowski wrote:
> On 09/02/2023 18:55, Eric Chanudet wrote:
> > On Thu, Feb 09, 2023 at 10:57:52AM +0100, Bartosz Golaszewski wrote:
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> Add the SoC ID entry for SA8775P.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  include/dt-bindings/arm/qcom,ids.h | 1 +
> >>  1 file changed, 1 insertion(+)
> > 
> > Reviewed-by: Eric Chanudet <echanude@redhat.com>
> > Tested-by: Eric Chanudet <echanude@redhat.com>
> 
> How can you test a header? What type of testing Redhat does on the headers?

IIUC that ID is compared against the one read from SMEM by the socinfo
driver. I meant to confirm it matched the number the board I have
returned. My apologies in advance if that was inappropriate.

-- 
Eric Chanudet

