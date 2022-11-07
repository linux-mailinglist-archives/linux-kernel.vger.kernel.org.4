Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52561F193
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiKGLLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiKGLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4A41AF03
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667819356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8Cl/06MPGSPm5RCcGRmqHy2+qFfaHoF23PzrGUHbl0=;
        b=gQAFVSogdmVtbnkqTjnaxFmeniAc/QMWZGR9xNJgztcS+f7/a47sEe/gZ5O4Wc9t+sd8A1
        ATpFIKv2x91TKhjXvsA+ViEGFjtgK76Okyk74q3oxliXYrrEJCfE/wmlJ7iqb5rt0F7OGW
        hDFY2oAKVeJD646tEZuu/aRq0rTG2dE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-omxSuqzCNOSUiA1F_6BqDA-1; Mon, 07 Nov 2022 06:09:14 -0500
X-MC-Unique: omxSuqzCNOSUiA1F_6BqDA-1
Received: by mail-qk1-f200.google.com with SMTP id ay43-20020a05620a17ab00b006fa30ed61fdso9788779qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 03:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8Cl/06MPGSPm5RCcGRmqHy2+qFfaHoF23PzrGUHbl0=;
        b=mv79E3/pu6+pBYRV28MDJjfLx1O1sn5nD2NLFtaHDmGFZvwCpcwqgD5oKF1kwD7+Up
         oC4nTlF+ORCGCBTKQQEEO00dlW23KpPbi8qGI2x4Ox0hcLp9QOsAL6xK/LCwQoZ7eN3/
         yrMIpG9JsyICn3MCrRll4F8yPoO4GaReV4nW4IszH9ggkTe6N/y8YVIuHeFZ2jVKwD7B
         Tf8LqfhP326M4JQYapTYop7Ie5iWUCI1IHr8hr47nryNtGuP/8EyCcqWVbV2FSWYZWng
         zqeXizFb/2ddD9hXc3L4mIgcp7f3xTtVhG1giZ2Yo6ROsXqRfGgy0RxZdQ6TbzqOyROs
         bi8Q==
X-Gm-Message-State: ACrzQf2DpQs6LkppbckS0GKlvNu6u46gQ5FGx0iS3zn32HMw63g4etyQ
        Nu4KLEGFitomeeS2Fd1t6WXL8ViVFhvw50XuYOInlFaUZhkTK/8CdiA2/8TTOOE8tDT8WkPNdp/
        x9gVeo7W4D9goKbVHLBcT7r7o
X-Received: by 2002:a05:6214:b6b:b0:4bb:9fea:f53a with SMTP id ey11-20020a0562140b6b00b004bb9feaf53amr44142069qvb.7.1667819354527;
        Mon, 07 Nov 2022 03:09:14 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4P+NUQULfed2HggHKoSQY6kh/nJD0vPq50SemRAN1ssl+3+ZctfwFB6qqd/+YR3SsRBOdEJw==
X-Received: by 2002:a05:6214:b6b:b0:4bb:9fea:f53a with SMTP id ey11-20020a0562140b6b00b004bb9feaf53amr44142058qvb.7.1667819354338;
        Mon, 07 Nov 2022 03:09:14 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id c8-20020a05620a134800b006ecb9dfdd15sm6481524qkl.92.2022.11.07.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 03:09:13 -0800 (PST)
Date:   Mon, 7 Nov 2022 06:09:12 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc8280xp: fix UFS reference clocks
Message-ID: <Y2jnWJ0FI6Fmy8/O@x1>
References: <20221104092045.17410-1-johan+linaro@kernel.org>
 <20221104092045.17410-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104092045.17410-2-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:20:44AM +0100, Johan Hovold wrote:
> There are three UFS reference clocks on SC8280XP which are used as
> follows:
> 
>  - The GCC_UFS_REF_CLKREF_CLK clock is fed to any UFS device connected
>    to either controller.
> 
>  - The GCC_UFS_1_CARD_CLKREF_CLK and GCC_UFS_CARD_CLKREF_CLK clocks
>    provide reference clocks to the two PHYs.
> 
> Note that this depends on first updating the clock driver to reflect
> that all three clocks are sourced from CXO. Specifically, the UFS
> controller driver expects the device reference clock to have a valid
> frequency:
> 
> 	ufshcd-qcom 1d84000.ufs: invalid ref_clk setting = 0
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Fixes: 8d6b458ce6e9 ("arm64: dts: qcom: sc8280xp: fix ufs_card_phy ref clock")
> Fixes: f3aa975e230e ("arm64: dts: qcom: sc8280xp: correct ref clock for ufs_mem_phy")
> Link: https://lore.kernel.org/lkml/Y2OEjNAPXg5BfOxH@hovoldconsulting.com/
> Cc: stable@vger.kernel.org	# 5.20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

Note that there was no 5.20 kernel; that should be 6.0. Bjorn should be
able to fix this up during merge.

https://en.wikipedia.org/wiki/Linux_kernel_version_history

