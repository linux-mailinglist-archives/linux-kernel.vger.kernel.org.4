Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3437A6CFADA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjC3Fll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjC3Fli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:41:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF39129
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 22:41:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kq3so17046274plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 22:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680154896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TAnOB62ctYJ+xcEWyxTBLF5P3A7lopNUPybiMwLxhiM=;
        b=DTUrhqlp4U3R4lE552xBdl6Uc+TbMd6p8lMlbl3NjzDuTayKTinFKrApFHtf7OcIRH
         bUHI+FW26gqUrW0FsC2iL+vNGMZTxR7qVckNlZM/HNF0GCu3DMyIyZF+5xhGbufvIpYp
         FRZCp3xm611OkXsJKCmXIsGnRIgm1Bh4tZPmj/Zt9MuVogc2DrrC84VWLJfQjbmcfMaA
         fF5+vyQluAzErZ36nR2lJfkW/X1OUT8kP80n0ZEIytT5H3mxFffBPv9CsXN8bS/GTC2E
         y5zwKankCvXB37XjmwcatDeTjV2CSa7Vktt4EY1MvtGz00ZPX5p/MsXttBDL4oU881AI
         Rr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680154896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAnOB62ctYJ+xcEWyxTBLF5P3A7lopNUPybiMwLxhiM=;
        b=sqrrFmCrVltqgm4KACl7HvE5mPowUsgipXFf+yz699VyP8ufufHygfIf3RaPfi9jFU
         WvevKzBreAwlRcY5zCEUKrTqii7NwN55b5EVKty0IfOW8xZYE8G5yFD94sSx3t6xjIEi
         iMpnuGGqjCUOx6s+irBpIS1eAwMoeNPbll2/CtzkgvbYBkt+VopHgPUpM4AOsoKUlubx
         2lyBOSFc2uRoOiXtL7mM9WF4bixVjUd0qP3QDUajMpg5dRMspE1ZDJLHngtJA/3AwMTB
         O437ZFqCRtUBHu57MYedja3HTVVkBHC3auS6hbQh1q4k/Vro368QEowk05omT7DxKoae
         yQYA==
X-Gm-Message-State: AAQBX9e0DOF93c8ipIMEW8gfQTqPYGTOR25WQ1njn2kZj5YYnerVpAKd
        kCW39e9224F+fAPqclwdara2
X-Google-Smtp-Source: AKy350aX6sHQt/xsMqLk0oB5MMOu2GEEt7EWROffMK/zg7fgAZiw32FaOUuJxhy2awLRaeopdDNM3Q==
X-Received: by 2002:a17:903:2442:b0:19a:9dab:3438 with SMTP id l2-20020a170903244200b0019a9dab3438mr5523514pls.2.1680154896628;
        Wed, 29 Mar 2023 22:41:36 -0700 (PDT)
Received: from thinkpad ([117.216.120.213])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902b68a00b0019edf07eb06sm23926181pls.122.2023.03.29.22.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 22:41:36 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:11:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, catalin.marinas@arm.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, steev@kali.org,
        iommu@lists.linux.dev, johan+linaro@kernel.org,
        andersson@kernel.org, linux-arm-kernel@lists.infradead.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Message-ID: <20230330054127.GA9876@thinkpad>
References: <20230327080029.11584-1-manivannan.sadhasivam@linaro.org>
 <167991987524.1305084.466646756285487652.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167991987524.1305084.466646756285487652.b4-ty@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:52:01PM +0100, Will Deacon wrote:
> On Mon, 27 Mar 2023 13:30:29 +0530, Manivannan Sadhasivam wrote:
> > Some platforms support more than 128 stream matching groups than what is
> > defined by the ARM SMMU architecture specification. But due to some unknown
> > reasons, those additional groups don't exhibit the same behavior as the
> > architecture supported ones.
> > 
> > For instance, the additional groups will not detect the quirky behavior of
> > some firmware versions intercepting writes to S2CR register, thus skipping
> > the quirk implemented in the driver and causing boot crash.
> > 
> > [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 

Thanks Will! Could you please tag this patch for 6.3-rcS? Even though this patch
is not fixing any issue introduced in 6.3, the affected platform (SC8280XP) has
reasonable upstream support in 6.3 and the distro folks would like to stick to
it for some time. This patch will allow them to boot mainline without any
additional out-of-tree patches.

- Mani

> [1/1] iommu/arm-smmu-qcom: Limit the SMR groups to 128
>       https://git.kernel.org/will/c/122611347326 
> 
> Cheers,
> -- 
> Will
> 
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev

-- 
மணிவண்ணன் சதாசிவம்
