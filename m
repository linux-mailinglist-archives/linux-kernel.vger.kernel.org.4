Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF48E67A3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjAXUcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjAXUch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B8485B7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674592308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uh/+HvzKrTBUoVxhArKOizvvmhv3uYpJ6dJ2xzDMsaI=;
        b=WN530v4rMdaQbnPJAnQeNfkuH5xTJ1xsL1z2Fib7PmVGuWim3st7nv9pnQrWJ3TAOP54uY
        5QOItALlC9D9ib93zinQeLrEdKpXI9Isx4vQso4sMy60ZK3UFIWUeOVgGoRo9fpEJ8Kh7K
        3PB2QsjK5MYF9HgPsRdUGHKKs6HXLFs=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462-s5dZmYzJO9q8-HxU2S3aNA-1; Tue, 24 Jan 2023 15:31:47 -0500
X-MC-Unique: s5dZmYzJO9q8-HxU2S3aNA-1
Received: by mail-vs1-f72.google.com with SMTP id d187-20020a671dc4000000b003c3a754b594so3995655vsd.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uh/+HvzKrTBUoVxhArKOizvvmhv3uYpJ6dJ2xzDMsaI=;
        b=Q2SLr01udhXj70/5mkBYBUsSYUK1X3HKjPcBTVP82VPSBi1oi2krOR9OUu0RMeCbKk
         L55rgqwoNaKDw0IGqqBBPdNPLJbKf1Ge0HiWJcvzstAbBQeizuEvw8lXtn4Yvop7OJng
         Hhj3kFuCeWEWC+QAoe5x92kHUmP4miiNAFtrFfFeSHkMb1XJIxAqvR5WKFPJ60rcUhDp
         kgF/XngMA0Xxxj8/GHzegkAY7pUILZJpTJvdqFRHpyUSL/8gKkhgpobFLuM4r3Db5xrY
         g8IL9OrbFF7As/AmeYKtx9PXSrflYPcc4hIjsYHU+NAFNUHSv3sjTGTsXFyJbdQtjfss
         P1pQ==
X-Gm-Message-State: AFqh2krnmv1piHTCpSVsx2kIEoUm/7C4y4HA6zGdRousmnfI7lLEWHgl
        6/Rl4SlPhZ66ky4yTk1Lagl3wptHhP8eNHO6c0+dBzq7uUpF7QzWX7Y9xUiXpH8KF0xNP3ZGMUJ
        PD9v4uPO7L/GiNWEGI9v1ZkxY
X-Received: by 2002:a67:f049:0:b0:3d3:cc3e:1cb8 with SMTP id q9-20020a67f049000000b003d3cc3e1cb8mr21478516vsm.6.1674592306013;
        Tue, 24 Jan 2023 12:31:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvXX350O2gooqvZotJtjKqUSnAbPCSKlHgvw3iaV0OvujJ5QBCAbrLbpwxP6w+E8eexeRm2fw==
X-Received: by 2002:a67:f049:0:b0:3d3:cc3e:1cb8 with SMTP id q9-20020a67f049000000b003d3cc3e1cb8mr21478495vsm.6.1674592305816;
        Tue, 24 Jan 2023 12:31:45 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b006cfc9846594sm2048624qky.93.2023.01.24.12.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:31:45 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:31:44 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sa8540p-ride: Fix some i2c pinctrl
 settings
Message-ID: <Y9BAMO+qLqiYZkr7@x1>
References: <20230124192351.695838-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124192351.695838-1-ahalaney@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:23:50PM -0600, Andrew Halaney wrote:
> Some of the pinctrl groups were invalid for the selected pins. Select
> the proper qup group to fix these warnings:
> 
> [    6.523566] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio135" for function "qup15"
> [    6.535042] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio136" for function "qup15"
> [    6.597536] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio158" for function "qup15"
> [    6.597544] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio159" for function "qup15"
> [    6.597991] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio0" for function "qup15"
> [    6.597996] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio1" for function "qup15"
> 
> Fixes: e073899ec3e1 ("arm64: dts: qcom: sa8540p-ride: add i2c nodes")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

