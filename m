Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97FF6B3B13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCJJnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCJJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:42:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2365C212A2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:42:19 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l1so4424847wry.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678441337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPInLZOYzoIRoYx9Oo6+KDA8Q8BwRlCDWnK6VRoNQtY=;
        b=VksT2yUtiBhAGeXiIMD5vubmOwq8Z+1ZDssMnKiobsfS7Pa4KkKezwLm1LP53Qsbpx
         bqhSoOGTWnasgW5MYrdFS0LiG9+8F1RXqkc8bCBg9+rVlq3Wnq0lXTA/ZeKwKcCPHaJS
         7OmpFCM3pigjrmMrKTNpXw+5mO6xr82fTzpAVnIAtx/cUTHESxBK77usRf9RD+b1HoyE
         Q+/JnQ+iCNdAY4Vyx9X9Q/uRIQ9pmuwjzXXF/G7Ceh375fO3BxUEjqR6GNQwpyoLA6x1
         noS1yhDL3BTa9W+wwwyUS+g31jas1IFYIJtkIaLzttgWOSuI4gE4ZHeMSepncJfLezsh
         hV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPInLZOYzoIRoYx9Oo6+KDA8Q8BwRlCDWnK6VRoNQtY=;
        b=py0ax3Agyc+4GIziF6ie/ftbo07KcQiGYySI2fvGxl9RXLip8R0QFY3RYYUtlYHZ5y
         vKBbQTSRydjNrAtwbgfjiIsp7Amj+EidCB9uFulV3+ngxgjFD151mmFPBEsYgamaIohf
         OLrCUjgHpW75T2FGaVGWdLDE4rsS9oxWu1EA4BlJ0QL9fWnfD0AO9cd1afiKtHhOI5/i
         nshhDlGVCb7XS+i2suX72wV3oCVO2omZbITugoK9NGpVaM4ncfEYLFiDQBGXRs6aIkcu
         /ZrQMljsIm3ZxFXV6aqwptbtTkx3XXS1kBLjNuJ0xPLVD4VhQXRaCojChVDNynmmlSfZ
         DUOQ==
X-Gm-Message-State: AO0yUKXR90p85dKUh+65RQ1NkCl9D/ogMAAhvvhJQSKX6gasn+D6QGvG
        yVRRozkOtmCy82OKa4IxK+TRfJbkXrQudq/FRKQ=
X-Google-Smtp-Source: AK7set9RTGOc68ELXC0tenT4FKlqCU3FXruN/fg2t3uOkYxqzGZ8byBrnmngtpQdc6EUT36OJxzkRA==
X-Received: by 2002:a5d:5386:0:b0:2c3:e20b:82aa with SMTP id d6-20020a5d5386000000b002c3e20b82aamr16264290wrv.22.1678441336747;
        Fri, 10 Mar 2023 01:42:16 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe10f000000b002c5526234d2sm1671789wrz.8.2023.03.10.01.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:42:14 -0800 (PST)
Date:   Fri, 10 Mar 2023 11:42:12 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto
 Engine nodes
Message-ID: <ZAr7dIFHzd71n5L5@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-8-abel.vesa@linaro.org>
 <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
 <ZAol5o5a6HZYgRaG@sol.localdomain>
 <b5c9aa6e-69d1-165a-4ff9-b5a9f33688e6@linaro.org>
 <ZAr2nlFSKkBBQgcY@linaro.org>
 <4ea944dd-8a42-e83f-607c-1a36124d19bb@linaro.org>
 <ZAr5v/jbd18K5Lug@linaro.org>
 <e9413338-7f33-8fd7-11cf-17a9b31aba57@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9413338-7f33-8fd7-11cf-17a9b31aba57@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-10 10:37:42, Krzysztof Kozlowski wrote:
> On 10/03/2023 10:34, Abel Vesa wrote:
> >>> I assume you mean it breaks if someone is using old approach DTS with a
> >>> kernel that would have ICE driver merged. Yes, that it does. And for
> >>> that, in the v3, I'll make of_qcom_ice_get check if there is a reg entry
> >>> with name "ice" and create an ICE instance but for the same dev as the
> >>> consumer driver. OTOH, if there is no reg entry called "ice", it will
> >>> look up a device based on phande of qcom,ice property. This will allow
> >>> legacy style DTS to work fine, while using the unified driver as a
> >>> library, in that case. For newer platforms, the recommended approach
> >>> will be to add a new ICE node and use qcom,ice property.
> >>
> >> For the driver this sounds good. I still think that existing (older) DTS
> >> should not have regs removed, because this affects other users of kernel
> >> DTS.
> > 
> > Yes, that's what I meant, the already supported platforms will remain
> > with ice reg in the consumer node.
> 
> ... unless you plan to add to them UFS ICE, which would be nice feature
> thus justifying DTS re-shuffle :)

By supported I meant the ones that have ICE support already :)

> 
> Best regards,
> Krzysztof
> 
