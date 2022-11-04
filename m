Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4423961A198
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiKDTyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4EE42F69
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667591628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1Y13hIxSrsibCYbBKTOvWFt6HnV4ZBbfk9Epx0sXBM=;
        b=iP3geS4bhKdQA0IR+N4/rXFInf09xDI+IYkPznyiceCWMOejScFy1ruIfjnuXrxQT2hrrK
        KTZjJszz6VUFwkhTs4YqRR/UEnffKHf89pTx8zM7v+CiJiYhmLfrrGGJiRatHuQFXCcFkD
        1sfJWZdkETqDKePe8S4sbT/Hd9oeV/A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-lNjZM4BpPqCzzhRBDOqEcQ-1; Fri, 04 Nov 2022 15:53:47 -0400
X-MC-Unique: lNjZM4BpPqCzzhRBDOqEcQ-1
Received: by mail-qv1-f71.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso3928440qvb.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1Y13hIxSrsibCYbBKTOvWFt6HnV4ZBbfk9Epx0sXBM=;
        b=zdMf/rmbzDyo0x9SdCxhgSvX/gfMZX19g63PFqBSzr7ob6Q/l7UBt/1G0Ovk+IYQ6Y
         JTkn8WyC+lab/y2yABNctRNw+p6IbzylEfRLXhqpqXvq18CDJG9Le4BZh45ynTQCeL7K
         HKdILIu3x4buoy2v7jXsMbadFIlcoR6HO8aZ20ai9tsLJZzzFELXCqrZEokR3WBumGtO
         b6JRHCAG3dvFOHkIUP29nSlALsTDdycHXGuMsMhYjEcSytER7IEmlYBPWMRjGztV9Ho5
         HOBpXLw+rJZNwBdblHfjMWt9w7SBn/8E2bajh+R5IhIZ8GdRSvG0Z9KtCn1zbbfS5D3p
         ZbgA==
X-Gm-Message-State: ACrzQf3dDcUc6iu3UvtxUeKAo8OhCocXjQwfisuRiczCub0oY9rLIx9I
        qSzbMBgypX091RwigNqlZU2m/i4A5ze7qtKERMsStmcOhjUMeoUA4+Itp5JZPjzCFeigtW7pC3I
        A0yNW9MnuSVK5rVuGM3ro6rVc
X-Received: by 2002:ac8:5747:0:b0:3a5:7262:47b0 with SMTP id 7-20020ac85747000000b003a5726247b0mr2363140qtx.393.1667591627213;
        Fri, 04 Nov 2022 12:53:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4sMMtix+VFAlcIVy7dyWq6tx5K9CnJi3y74R/xZx/+zXuKrxKBOJHg8W54+J9nHdRKaA2LMQ==
X-Received: by 2002:ac8:5747:0:b0:3a5:7262:47b0 with SMTP id 7-20020ac85747000000b003a5726247b0mr2363112qtx.393.1667591626941;
        Fri, 04 Nov 2022 12:53:46 -0700 (PDT)
Received: from x1 ([2600:380:5832:f20b:6e6d:975e:a9e9:892e])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a134800b006ecb9dfdd15sm36890qkl.92.2022.11.04.12.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:53:46 -0700 (PDT)
Date:   Fri, 4 Nov 2022 15:53:43 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Eric Chanudet <echanude@redhat.com>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 0/3] arm64: dts: qcom: add dts for sa8540p-ride board
Message-ID: <Y2Vtxy6U133OcctU@x1>
References: <20221003125444.12975-1-quic_ppareek@quicinc.com>
 <YzsciFeYpvv/92CG@x1>
 <20221004132816.ryhyo5ihwruxspl6@echanude>
 <Y02rrdFqN1X2PC4t@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02rrdFqN1X2PC4t@x1>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 03:23:25PM -0400, Brian Masney wrote:
> Parikshit: I found a way to reproduce the crash and isolated the issue
> to the qcom_q6v5_pas driver. Here's how you can reproduce the crash
> that we're seeing:
> 
> 1) Use my instructions at [1] to build an upstream kernel with the arm64
>    defconfg. Today I used linux-next-20221017.
> 
> 2) Copy the modules to the root filesystem. Before you reboot, mv
>    /lib/modules/6.0.0-next-20221017-xxx to
>    /lib/modules/6.0.0-next-20221017-xxx-old so that the modules are not
>    automatically loaded on startup.
> 
> 3) Reboot, and run lsmod and verify that no modules are loaded.
> 
> 4) cd /lib/modules/6.0.0-next-20221017-xxx-old
> 
> 5) Now load the modules that work as expected that are loaded with the
>    upstream arm64 defconfig:
> 
>         insmod ./kernel/net/rfkill/rfkill.ko
>         insmod ./kernel/arch/arm64/crypto/crct10dif-ce.ko
>         insmod ./kernel/net/qrtr/qrtr.ko
>         insmod ./kernel/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.ko
>         insmod ./kernel/drivers/soc/qcom/llcc-qcom.ko
>         insmod ./kernel/drivers/soc/qcom/qmi_helpers.ko
>         insmod ./kernel/drivers/remoteproc/qcom_sysmon.ko
>         insmod ./kernel/drivers/remoteproc/qcom_q6v5.ko
>         insmod ./kernel/drivers/rpmsg/qcom_glink_smem.ko
>         insmod ./kernel/drivers/soc/qcom/socinfo.ko
>         insmod ./kernel/drivers/remoteproc/qcom_pil_info.ko
>         insmod ./kernel/drivers/remoteproc/qcom_common.ko
>         insmod ./kernel/drivers/watchdog/qcom-wdt.ko
>         insmod ./kernel/fs/fuse/fuse.ko
>         insmod ./kernel/drivers/soc/qcom/mdt_loader.ko
> 
> 6) Wait a few minutes to be sure that everything is working as expected
>    on the board.
> 
> 7) Make the board go BOOM:
> 
>         insmod ./kernel/drivers/remoteproc/qcom_q6v5_pas.ko
> 
> We don't know how or have the tools to analyze the ramdumps from the
> Qualcomm firmware at Red Hat, so we're flying blind right now.
> 
> [1] https://lore.kernel.org/lkml/YzsciFeYpvv%2F92CG@x1/

I isolated the hang issue above to a single Kconfig symbol. First, a
quick background. We're not seeing the hang issue using the upstream
kernel with Red Hat's automotive kernel config. We see the hang though
with the upstream arm64 defconfig. There's thousands of symbol
differences between the two defconfigs and none of the changes stuck out
to me. I wrote some code that slowly morphed the Red Hat defconfig into
the upstream arm64 defconfig and committed the symbol changes in stages
along the way. This allowed me to do an automated 'git bisect'.

The symbol CONFIG_NO_HZ_IDLE=y is what triggers the hang. When I remove
that line from arch/arm64/configs/defconfig, then the board continues to
function normally after the qcom_q6v5_pas.ko module is loaded.

Any ideas what could be causing this? Could it be the safety island is
monitoring for a kernel tick and if it doesn't sense one then it kills
the kernel and goes into ramdump mode?

Brian

