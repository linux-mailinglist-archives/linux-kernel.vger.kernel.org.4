Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29D6A5E34
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjB1Ram (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjB1Rak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F34B13524
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 09:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677605397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/M/BA8zoi28CzpGx6Qs+kD66QOsyFh2ZNKOpFNjGwHE=;
        b=Hw+J5+SnlS5skFW8YMoBYZgn1nPCa9b0yCAcNzEumBBCk+5zeP/XHUw29CkAMt95SUjr3U
        2c/IxYETWqEKzUoYH4UDtFFTzeMcmNqWKcxeYR7nvJgvgGuORqfnAY2ttN8x+haFoADg+l
        b36ze96/MjyQ7eXZ/8nuASYI21pklXo=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-hvyAL9DQMgyKR1VrOsNBCw-1; Tue, 28 Feb 2023 12:29:56 -0500
X-MC-Unique: hvyAL9DQMgyKR1VrOsNBCw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1728f81744fso5969064fac.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 09:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M/BA8zoi28CzpGx6Qs+kD66QOsyFh2ZNKOpFNjGwHE=;
        b=mMLkRwuQXuvsYqfedQweYZPw30udbRi6Wa+lqc/0Mw6DvMN21c0kCICrExsk5Kcr5V
         Bbrg56SepS5xqKSlGc/wmBtNBqA+IuESV7Q/vEcdRETUmFLPGfjchcHBZZ9McORYvynY
         S4cEJnC2Od0jwQRlA1aV0xwfl12yW4YK+OLun/gSSYFnSP4HRBJD6LXWlWIIhFqvPNri
         WsIAqNCHY4KoHtVUifvAbm/boLn8J0W9RD5fP+rS3PlfTBrGfdACnAld4B/ZTRD4Q4hl
         COoX8rrmikpn9GbtSG2toqqs8w5BUTlygdh3gpbbCTsYKFTy1lsctlKdieOYykgks/Xe
         aGJA==
X-Gm-Message-State: AO0yUKWe6TxFpq/fNCA9ePUVKRawPgQr4E0QYEP0FYCvZc1/43Q5f30o
        TkDi2lphL7LV0hsVwgTWft3cMeLccb3rdGgBY3m0l94cRA//Muqn5c56K9WotgbiuBSiKE/bWPg
        +XjzFCjkpGYIx1dMGDHtbExoH
X-Received: by 2002:a05:6870:2198:b0:172:968d:9356 with SMTP id l24-20020a056870219800b00172968d9356mr2350577oae.17.1677605395220;
        Tue, 28 Feb 2023 09:29:55 -0800 (PST)
X-Google-Smtp-Source: AK7set8xmDAxa5uNNknR4po9Ufd+f1Hk/8vUD8P7AehIRmtgtPxDI6cJRJ/rxtHXvVYE+e3T75WzDg==
X-Received: by 2002:a05:6870:2198:b0:172:968d:9356 with SMTP id l24-20020a056870219800b00172968d9356mr2350567oae.17.1677605394952;
        Tue, 28 Feb 2023 09:29:54 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id m3-20020a056870a40300b001729ff63d07sm3430603oal.24.2023.02.28.09.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 09:29:54 -0800 (PST)
Date:   Tue, 28 Feb 2023 11:29:52 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH 00/16] Qcom: Fix PCI I/O range defined in devicetree
Message-ID: <20230228172952.nfjce7cjos6tume3@halaney-x13s>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:17:36PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series fixes the issue with PCI I/O ranges defined in devicetree of
> Qualcomm SoCs as reported by Arnd [1]. Most of the Qualcomm SoCs define
> identical mapping for the PCI I/O range. But the PCI device I/O ports
> are usually located between 0x0 to 64KiB/1MiB. So the defined PCI addresses are
> mostly bogus. The lack of bug report on this issue indicates that no one really
> tested legacy PCI devices with these SoCs.
> 
> This series also contains a couple of cleanup patches that aligns the entries of
> ranges property.
> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
> 
> Manivannan Sadhasivam (16):
>   arm64: dts: qcom: sdm845: Fix the PCI I/O port range
>   arm64: dts: qcom: msm8998: Fix the PCI I/O port range
>   arm64: dts: qcom: sc7280: Fix the PCI I/O port range
>   arm64: dts: qcom: sm8550: Fix the PCI I/O port range
>   arm64: dts: qcom: ipq8074: Fix the PCI I/O port range
>   arm64: dts: qcom: ipq6018: Fix the PCI I/O port range
>   arm64: dts: qcom: msm8996: Fix the PCI I/O port range
>   arm64: dts: qcom: sm8250: Fix the PCI I/O port range
>   arm64: dts: qcom: qcs404: Use 0x prefix for the PCI I/O and MEM ranges
>   arm64: dts: qcom: sc8280xp: Fix the PCI I/O port range
>   arm64: dts: qcom: sm8150: Fix the PCI I/O port range
>   arm64: dts: qcom: sm8450: Fix the PCI I/O port range
>   arm64: dts: qcom: sm8350: Fix the PCI I/O port range
>   ARM: dts: qcom: apq8064: Use 0x prefix for the PCI I/O and MEM ranges
>   ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
>   ARM: dts: qcom: ipq8064: Fix the PCI I/O port range
> 
>  arch/arm/boot/dts/qcom-apq8064.dtsi    |  4 ++--
>  arch/arm/boot/dts/qcom-ipq4019.dtsi    |  4 ++--
>  arch/arm/boot/dts/qcom-ipq8064.dtsi    | 12 ++++++------
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi  |  4 ++--
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi  | 12 ++++--------
>  arch/arm64/boot/dts/qcom/msm8996.dtsi  | 12 ++++++------
>  arch/arm64/boot/dts/qcom/msm8998.dtsi  |  2 +-
>  arch/arm64/boot/dts/qcom/qcs404.dtsi   |  4 ++--

Would you mind giving sa8540p.dtsi to similiar treatment? I will admit
I know next to nothing about PCI techically, so I can't even comment
with confidence that this is needed there, but it looks similar to other
descriptions modified in this patch series.

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sa8540p.dtsi#n197

Thanks,
Andrew

