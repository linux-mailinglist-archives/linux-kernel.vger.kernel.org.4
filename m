Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED20D5F365A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJCTdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJCTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818364686D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664825624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jRfHN3rWNPCHe1Xf3QN944kFsnl3YOd/zDvG5DtfTt8=;
        b=etoFVZtAReiZzyEWOnGK7FJC6zBAH+USSeAQXjHspJFjBrog/vMOzMZ9gDz2wwXbfModFL
        s/9jG8KoHQWMVVTyaC34VhTnZI02cwq01ZUI8uXS/ZcLR7mnjWrlY2KeFnGLRbDEiAPtz3
        jDovfsWitiecapmvaYlvCduf3OtZ+Yw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-vDWs7ciuO-qorlowIpGQ9w-1; Mon, 03 Oct 2022 15:33:43 -0400
X-MC-Unique: vDWs7ciuO-qorlowIpGQ9w-1
Received: by mail-oi1-f197.google.com with SMTP id z13-20020aca670d000000b00351430925e4so4274552oix.22
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 12:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jRfHN3rWNPCHe1Xf3QN944kFsnl3YOd/zDvG5DtfTt8=;
        b=XPFipVnGq751hUUHW+Wzhj4LJB6Rnpja+1QkMRcZFO9+0Ea5alr/i23suSffYioRcS
         W9X5fI9Kt+kILv84iaVP9e6//YpyZ6OtVi7Kdph1YVZMEhQ7KzlaPrE2gV0tBszkpr4P
         p0m2mQmg+hnizpXIR4MA7a7yDcAMt9WydI/irKdkBEfrOEE3ls7RFilX+Q+xWaZ++vFi
         Xnixjl3RarFALeIrZwZa63FwHNlKHz2Ow1L516IpFHk4J1EDDkg4lSvkUFd4E2rUFf2r
         C4CsDZ7xHj4ZrKzEK0Apy8Z4NCfdReYOuCsCDkQdrKzIm2QvyVirHKSYTYTIAv5wWvdT
         hsMQ==
X-Gm-Message-State: ACrzQf3HxnADdBEp1j0eyouJkAP0q6qEVgVjEUBlWPy5AzwRBOxxjSVL
        sttcP4jSBb2wbWwuX2DhzKXH0GhBIfhWIcdOhc99mmbzmRYCOq0eGS1kbv9KF5XSh/P6jlrypOc
        E1f9bJ5JDFpjfZpU7kyrNVWPY
X-Received: by 2002:a05:6830:25d5:b0:65b:cd82:9398 with SMTP id d21-20020a05683025d500b0065bcd829398mr8241960otu.254.1664825622775;
        Mon, 03 Oct 2022 12:33:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7gqtjaleuRh6+i4IGn1be3E3F+8SNurkp293ywx/AoOQ/dV8xj0H9T4mcYuwIQ50loYmHtHw==
X-Received: by 2002:a05:6830:25d5:b0:65b:cd82:9398 with SMTP id d21-20020a05683025d500b0065bcd829398mr8241946otu.254.1664825622578;
        Mon, 03 Oct 2022 12:33:42 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id l132-20020acabb8a000000b003504e119b10sm2621378oif.44.2022.10.03.12.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:33:42 -0700 (PDT)
Date:   Mon, 3 Oct 2022 14:33:38 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     Parikshit Pareek <quic_ppareek@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v5 0/3] arm64: dts: qcom: add dts for sa8540p-ride board
Message-ID: <20221003193338.airh43yxranmwehf@halaney-x13s>
References: <20221003125444.12975-1-quic_ppareek@quicinc.com>
 <YzsciFeYpvv/92CG@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzsciFeYpvv/92CG@x1>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 01:31:52PM -0400, Brian Masney wrote:
> On Mon, Oct 03, 2022 at 06:24:40PM +0530, Parikshit Pareek wrote:
> > Parikshit Pareek (3):
> >   dt-bindings: arm: qcom: Document additional sa8540p device
> >   arm64: dts: qcom: sa8295p: move common nodes to dtsi
> >   arm64: dts: qcom: introduce sa8540p-ride dts
> 
> For the series:
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Tested-by: Brian Masney <bmasney@redhat.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com> # QDrive3/sa8540p-adp-ride
> 
> 
> Just for documentation purposes, to get linux-next-20220930 booting on
> the QDrive3 with the upstream arm64 defconfig I had to apply the
> following patches:
> 
> - arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
>   https://lore.kernel.org/linux-arm-msm/20220915141601.18435-1-johan+linaro@kernel.org/
> 
>   Without this, the phy fails to probe due to the following error:
> 
>     qcom-qmp-ufs-phy 1d87000.phy: can't request region for resource [mem 0x01d87400-0x01d87507]
>     qcom-qmp-ufs-phy 1d87000.phy: failed to create lane0 phy, -16
>     qcom-qmp-ufs-phy: probe of 1d87000.phy failed with error -16
> 
> - This hack patch is still needed:
>   disable has_address_auth_metacap and has_generic_auth
>   https://github.com/andersson/kernel/commit/d46a4d05d5a17ff4447af08471edd78e194d48e5
> 
>   Without this, the boot hangs at:
> 
>     rcu: srcu_init: Setting srcu_struct sizes based on contention.
>     arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
>     clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
>     sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
> 
> - My UFS clock patch is still needed:
>   arm64: dts: qcom: sc8280xp: correct ref_aux clock for ufs_mem_phy
>   https://lore.kernel.org/lkml/20220830180120.2082734-1-bmasney@redhat.com/T/#u
> 
> - I didn't use an initrd for testing so I had to change the options
>   CONFIG_SCSI_UFS_QCOM and CONFIG_PHY_QCOM_QMP from =m to =y.
> 
> Brian
> 

