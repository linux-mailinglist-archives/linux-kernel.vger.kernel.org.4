Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F663EC40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLAJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiLAJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:21:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F8A86A27
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:21:16 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h33so1141621pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hULkPHep2RVUAcrgt0CfVoNcgvBv0xUNvebj5PtpN/4=;
        b=s5ClAOIcTUSE+2itQEkwK5A16qTxXLBiPEU70mr5H0hZ7zWxveje7vEYFpaoPvxXB8
         /PI6Jyrjmi0oDalScPnCNSYretKaiwiyZ6tgOv+08cMMsLo+1AVddFPvQ8tYZO1ny539
         vuo4T25e+hkD2K2VbYEu06KF81WKs1zyOY7T7lD5wuxG/5pkjS3DxH7k1KJ4a9a+g+cH
         cT784n8TQQ250GoK0JFam9zYNZR8s/P+Rxu8U9ZHCR0tMqfYWG5McOLYZwQqlgEhTqJd
         BD6lZAwg1jV94ejnpC+3pKF8VS4BB3qLFURVwAszgghQ5nyBymtJY/LJ28pyp8YvJUIX
         PARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hULkPHep2RVUAcrgt0CfVoNcgvBv0xUNvebj5PtpN/4=;
        b=1gmXTbVJzx/G3XDbC1h7OcsmSVPqyPOxRC6fV+ex7B/erzIB/bcXD6R4N/84RJZ054
         G/uiJZhzwaTh/9QZt5r8JiWGThKOoAmH6EKx8kZNnMdD7ySQSee2DW50BCviMrOT2ZY2
         66pqgY87WGf5R5wfhegE1ss+/HKh/uL4pTxPurTn5w0PIf1myHeD1H+L9I10ocTxGrX4
         GwGY8klPr3bx5D1LFWjU+l8D9Q9FXcFjxhy7G8SCv3Ujfv4HiKO5fz9iP+vfnoDczVet
         7MzZ6mmzjN2QrIPPrblgTHhd0ia0Ct0DZ5gvlsa6fJ3ebv+wcla2ZpV2QdEim5CofWqQ
         Aa/A==
X-Gm-Message-State: ANoB5pnOlPw9OhIvIYA1aTI3fAtUjwL4t+Me97o5FXq1bEZSMze90Roi
        W48WXbcIbWAD8j2oWRB8Rb95Vg==
X-Google-Smtp-Source: AA0mqf5sEyTTPT1O2Vctr4CAEyWozCb4b0HMZEKeRnyM+cdLgP9vsFKgEErAR894h28eHCdSNp4EWQ==
X-Received: by 2002:a63:4c63:0:b0:477:103:d1c4 with SMTP id m35-20020a634c63000000b004770103d1c4mr39463260pgl.369.1669886475786;
        Thu, 01 Dec 2022 01:21:15 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090a4f4d00b002191873187dsm4416068pjl.33.2022.12.01.01.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:21:15 -0800 (PST)
Date:   Thu, 1 Dec 2022 14:51:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Add
 QDU1000/QRU1000 cpufreq
Message-ID: <20221201092113.fh5fgevjaopl5xn3@vireshk-i7>
References: <20221118182416.4920-1-quic_molvera@quicinc.com>
 <d2c730eb-1c77-9339-b491-e3a8bb503b60@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c730eb-1c77-9339-b491-e3a8bb503b60@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-22, 11:27, Krzysztof Kozlowski wrote:
> On 18/11/2022 19:24, Melody Olvera wrote:
> > Add cpufreq epss for QDU1000 and QRU1000 SoCs.
> > 
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> > ---
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied. Thanks.

-- 
viresh
