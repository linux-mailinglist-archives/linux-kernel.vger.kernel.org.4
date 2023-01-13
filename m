Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A5A66A548
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjAMVpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjAMVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:45:49 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F5910B5D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:45:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s3so14617199pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLpE4svXD3XQQRSXVJzXdGhWxSRO6yXuEUgvAKhMVl4=;
        b=seXJpHkX75LLjeAQGGDYlo3npZTN5KBqgznJsS+O6gpK2NmQ8Yi8U38tzdE+sC0EtR
         5QNoTpmSeSffYXeoVSQnn2DDfEUU15bx7u8Rc9mQ7+nG4BrIVuqxpf1JQJStGuZpibXL
         us0R/zMDHhkDokII30bM1n/PGIAWgWXSABq5bm53ejqYhpqMuyX2VG9tuy7tkBOcBPXr
         IG/Grxqr1iz8WOBM4TaI5wMisBoRkN7/HNxFv0u7XrxoEJZ8VtsAoxndPL1Ch+k+o3w2
         q2AwPfjhCwZUciSBXNwm+cYaZBpI27vZHdYtB1+MOOaRomdw7nEBN/HbhoNBnskedaKr
         hCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLpE4svXD3XQQRSXVJzXdGhWxSRO6yXuEUgvAKhMVl4=;
        b=pNWpkHNWLaIBKEGO/VXWqC/w1bAzH9GazDo58Te+l79xlEMqzAhnkL9I2qyLkVtwuv
         TY5aJXKYeyShguVXepfwNVqIFBwajOxqdiVWhSJ/fsEnXACcOTKhsolCmJhOE91Gveiq
         1Qfoq4Bld+j9v4TwBWB/XZn9cuJBb8pekOB6l9DXAtBjfDsDeoc8sDfUWWornk4bG0rR
         DW/hv5oRbItChm564XAA4Sh+zjxh1EHC7OCZN6IMd4kJuLYrGFksWhWqOrZ6YfTA/0/v
         8nxQomhVnPr9kagXqeObZarNFOX3uUZ2b8/M5jR0FlL0OsK8yo1DBqZGHpCtf93cM7uC
         VjEw==
X-Gm-Message-State: AFqh2kq/Mnjh+WyzQiH7klvc3juuoHPt5dvl8jtyzZlj5yBhrckiJPSY
        gUpe4HsYWcXF6qUStgac12EmgQ==
X-Google-Smtp-Source: AMrXdXsrIOvOzBb3717HQB1WC3lU2RR/DE+Mjyapbas+eMRFoGzQr3ZhpTdppsDT513yxfgfdqZIMg==
X-Received: by 2002:a62:6001:0:b0:582:33b4:4c57 with SMTP id u1-20020a626001000000b0058233b44c57mr11213692pfb.33.1673646347798;
        Fri, 13 Jan 2023 13:45:47 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:d88b:1f:16ba:1ee7])
        by smtp.gmail.com with ESMTPSA id e8-20020aa79808000000b005897f5436c0sm9309127pfl.118.2023.01.13.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:45:47 -0800 (PST)
Date:   Fri, 13 Jan 2023 14:45:44 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     andersson@kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com, praneeth@ti.com,
        nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com,
        devarsht@ti.com
Subject: Re: [PATCH v2 0/2] Add C7xv DSP for AM62A
Message-ID: <20230113214544.GA2956142@p14s>
References: <20221230132453.32022-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230132453.32022-1-hnagalla@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 07:24:51AM -0600, Hari Nagalla wrote:
> AM62A SoC family has a C7xv DSP subsystem with Analytics engine. This
> susbystem is intended for deep learning purposes. C7xv is similar to C71
> DSPs on K3 J7 SoCs with additional harware accelerators and IP updates
> for deep learining.
> 
> Hari Nagalla (1):
>   dt-bindings: remoteproc: k3-dsp: update bindings for AM62A SoCs
> 
> Jai Luthra (1):
>   remoteproc: k3-c7x: Add support for C7xv DSP on AM62A SoC
> 
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml         |  3 +++
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c            | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
>

Applied - thanks
Mathieu

> -- 
> 2.17.1
> 
