Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5768982E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjBCMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBCMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:00:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F265F2D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:00:21 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r2so4427967wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/egjzh03ngyXJ8FHTTg/0bQYtASQpdNMJv1hdvpB/Fc=;
        b=EZJDKhZi6FDDw/5bMJrAjrDxipE8DFd4zSfg7Is8OgI1Syp1Unmg9+kCVyntpI9Ah8
         ms1cK9oYqiMuEW8lJoL3+Pbky2PD7mVp7aCorL7I14++GZy3QAwRI33FG0ElzDNr0PWT
         vFaFCf+A0VIEt5SvaJNxmj6f+O0/MIz1hDNSX2iAm3KOxwx5TzVaYaspIpvrmIrRxkc7
         Yp+Ds1CPencAXduMvqvFaxN4/f87pC/z0lkpKQUXD9JWVr+yyj2quMcvN2sm1IFksFM9
         Gv02UHnSF9DL2lRRzKxSoQ/u3Enj0Y2GUc/NOe7C2vTDyZi/mLZQgKapmggqUNV9lM7K
         7JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/egjzh03ngyXJ8FHTTg/0bQYtASQpdNMJv1hdvpB/Fc=;
        b=nHQLgdNhJjfyCBjAKd5WVQ1PzE0ycWRGZatlcM8zaeM743HWwCQsYzf/KhnW/E9dWx
         sjsa8a/xA3ouJ9iKK4ci+8CMkEuVt3GTMTCMjjcGBpPLsEbhVPGcn0oVQR5dgupK2ZZs
         GoiB3jlz1Z0kaQWXB4XvDAA2nEq6lV+2UqA2+q8nKK3nixo1LVLfUapBf/SLSS63FWMk
         bJwIEKZ+o2TZ/k/7I0hlYl7A/ZLuqvbGisxWiCvb9U+hMTaiS4qnhus7oLukiH7Gs0Jh
         hP5YvFkCO4wkJUjIOjMOEJm3F2JbEBmZWWkdKNTKVSyTZU6tj0w0Bi/lXTgtOKdXsnPj
         hzZw==
X-Gm-Message-State: AO0yUKUbypWvxttl6GJusYtmnvtTI5aFL2zhajRcUNXqN3wHN611HOLi
        kiosiAaFLfoeH/1YG8h7A8jyag==
X-Google-Smtp-Source: AK7set8T8aMKg8ONn/ET9eKan7YGhEXPRxUtteeiVs5nS/u1CsnX5oz+t6Ydy0xu8bDo1Ib8w1xRcQ==
X-Received: by 2002:adf:e5c9:0:b0:2bf:ede3:988a with SMTP id a9-20020adfe5c9000000b002bfede3988amr10663907wrn.22.1675425619996;
        Fri, 03 Feb 2023 04:00:19 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d4612000000b002be15ee1377sm1486750wrq.22.2023.02.03.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:00:19 -0800 (PST)
Date:   Fri, 3 Feb 2023 12:00:16 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Message-ID: <Y9z3UG+wEBn4i3G2@myrica>
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:40:53AM -0800, Ganapatrao Kulkarni wrote:
> The current smmu-v3 driver does not enable PCI ATS for physical functions
> of ATS capable End Points when booted in smmu bypass mode
> (iommu.passthrough=1). This will not allow virtual functions to enable
> ATS(even though EP supports it) while they are attached to a VM using
> VFIO driver.
> 
> This patch adds changes to enable ATS support for physical functions
> in passthrough/bypass mode as well.
[...]
> @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  
>  	master->domain = smmu_domain;
>  
> -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> -		master->ats_enabled = arm_smmu_ats_supported(master);
> +	master->ats_enabled = arm_smmu_ats_supported(master);

I should have added a comment for this. Only found the reason in an old
cover letter [1]:

"When no translation stages are enabled (0b100), ATS Translation Requests
(and Translated traffic, if SMMU_CR0.ATSCHK == 1) are denied as though
EATS == 0b00; the actual value of the EATS field is IGNORED. Such a
Translation Request causes F_BAD_ATS_TREQ and Translated traffic causes
F_TRANSL_FORBIDDEN."

(See 3.9.1.1 "Responses to ATS Translation Requests and Translated
transactions" and 5.2 "Stream Table Entry")

So I don't think we can enable ATS for bypass domains :/ The PF needs to
be in translated mode in that case.

I can send a patch adding the comment next cycle.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20190409165245.26500-1-jean-philippe.brucker@arm.com/

