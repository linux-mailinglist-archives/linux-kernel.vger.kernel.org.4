Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF7689838
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBCMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBCMFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:05:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900B95D2D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:05:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBF6B61EF6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D4BC433EF;
        Fri,  3 Feb 2023 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675425917;
        bh=0lFtytynqLkq8kJIpsrWpdqTQgna4urzc2JF1yxsxnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7LxKwIiJWDREcPzlQp1Nkr+1E8PUzD8RvgkDrmri/8BGgRxfmZZimGAEqBclIh5I
         zbzwUvBvW7UzIhIQqprXumtriCc06ocpOHEMEQ+KyAo6s5uLjOlOhw+je87zQFS6vd
         EmLglq/qb/MZD1/rX+U+WeRfI5BdgeG5/815jRCBAkI2zSXdPzy2gNlGjiv2eKB6ei
         +kxZARRrrwiDwHcy+VmM9G7v1aUQp3evao/BqzVe+qQDQwN3gE2mijzgvYu2g6gKPz
         tRSlmdT+XOD7p7PVi0wvUQNIwhr7DWTjVpeNKKleNRDPeZKABj9iLjzDd16z/YFchJ
         UoxYycFh9AapA==
Date:   Fri, 3 Feb 2023 12:05:11 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, robin.murphy@arm.com, joro@8bytes.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Message-ID: <20230203120511.GA6274@willie-the-truck>
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
 <Y9z3UG+wEBn4i3G2@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9z3UG+wEBn4i3G2@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:00:16PM +0000, Jean-Philippe Brucker wrote:
> On Thu, Feb 02, 2023 at 04:40:53AM -0800, Ganapatrao Kulkarni wrote:
> > The current smmu-v3 driver does not enable PCI ATS for physical functions
> > of ATS capable End Points when booted in smmu bypass mode
> > (iommu.passthrough=1). This will not allow virtual functions to enable
> > ATS(even though EP supports it) while they are attached to a VM using
> > VFIO driver.
> > 
> > This patch adds changes to enable ATS support for physical functions
> > in passthrough/bypass mode as well.
> [...]
> > @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  
> >  	master->domain = smmu_domain;
> >  
> > -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> > -		master->ats_enabled = arm_smmu_ats_supported(master);
> > +	master->ats_enabled = arm_smmu_ats_supported(master);
> 
> I should have added a comment for this. Only found the reason in an old
> cover letter [1]:
> 
> "When no translation stages are enabled (0b100), ATS Translation Requests
> (and Translated traffic, if SMMU_CR0.ATSCHK == 1) are denied as though
> EATS == 0b00; the actual value of the EATS field is IGNORED. Such a
> Translation Request causes F_BAD_ATS_TREQ and Translated traffic causes
> F_TRANSL_FORBIDDEN."
> 
> (See 3.9.1.1 "Responses to ATS Translation Requests and Translated
> transactions" and 5.2 "Stream Table Entry")
> 
> So I don't think we can enable ATS for bypass domains :/ The PF needs to
> be in translated mode in that case.
> 
> I can send a patch adding the comment next cycle.

Yes, please!

Will
