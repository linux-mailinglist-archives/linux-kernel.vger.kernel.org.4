Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84E6BB4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCONhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjCONhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:37:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4A8907B5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:37:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso1719020pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678887458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YePAT7cRSVCK2M5mNZ0SrXrbIX/sKHS6O/ir9QF/3YA=;
        b=sWwAOsbgy+eqbrZ35YrkSLBldjwCCxqfc/OtqiTkZhbNBBnoqgR26+xqgxk+vKQM9w
         a/rGmYCNTZtX0JtYPCXu4+mn488ZfVCHPnIIW5oCgnA4bd5MYmumJ2Eo0syFsNxrAs0x
         a5paUBLKgUBJNXJOIvt3nVSVO9qglDnUIFWGubuN+d3LB+y+dToOAanWfbnPCaCj8TZP
         QsCqx36GxIUgXRZ2ytHXfPBmQsE5tUvY6gS6jsqc/jBlHOS9IX5m9k0gQRa+coqtCVyo
         V8DhH+QUlHEXkwLEnvSebQeMj8vBGuPboKSqb/yresH1uCctR8z51d2T7fmW+zQgOspg
         mxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YePAT7cRSVCK2M5mNZ0SrXrbIX/sKHS6O/ir9QF/3YA=;
        b=tW4+1EPftAlhOF4fl/qtU3ENQkOEW0r32x2XTA7XSe04ZV45mWN9pviC5bbPfPpvVo
         35lZrGvhbl7ueaVEoLA6aPLxjB6Md9FHRZJx/2/50BlDzref8iHDjSGVLteiestur53o
         HRZBMYFt8H4oLuW7KHDUlR8rSEQhszYromcq78hxCsAFicM+FWLVT3CUciEt6KkN21T5
         e9LC5+20fzJLvRXhann7N48ZqY57l66xPUh0CmGZlMmxydy/JF94wI3kH3/b2t3DqfA7
         7RZVploSXhWrcJOibmMhi40Mu7dASKWDrm8I6u3K+oixEj7Y/vx5mQB2HzAc/f9/xrEg
         0iEw==
X-Gm-Message-State: AO0yUKVGb1L16XRDpadUfBLp2CNPY83Y2Y2rebPB3Uty14g4uSrOIbWe
        pM9UxOOnMpc1qSEr5hV8onW9vWEJqW/p76CffQ==
X-Google-Smtp-Source: AK7set+5E8xt64b6V5eMrpg1l077mbaN0K4ExGQ3kvL4USwI7EPfUzhMUK96WTT/fV9x7Pjs4/kmlw==
X-Received: by 2002:a17:902:d4cd:b0:19d:af20:3fe8 with SMTP id o13-20020a170902d4cd00b0019daf203fe8mr2841030plg.21.1678887458252;
        Wed, 15 Mar 2023 06:37:38 -0700 (PDT)
Received: from thinkpad ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902c38200b001a04d37a4acsm3691872plg.9.2023.03.15.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:37:37 -0700 (PDT)
Date:   Wed, 15 Mar 2023 19:07:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <20230315133730.GB98059@thinkpad>
References: <20230314184659.176473-1-manivannan.sadhasivam@linaro.org>
 <ZBF1vFBWKXhHeD2v@hovoldconsulting.com>
 <20230315075958.GC25575@thinkpad>
 <ZBGEEk1d1WtNq4lT@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBGEEk1d1WtNq4lT@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 09:38:42AM +0100, Johan Hovold wrote:
> On Wed, Mar 15, 2023 at 01:29:58PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 15, 2023 at 08:37:32AM +0100, Johan Hovold wrote:
> 
> > > > +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > > > +{
> > > > +	u32 smr;
> > > > +	int i;
> > > > +
> > > > +	/*
> > > > +	 * Limit the number of stream matching groups to 128 as the ARM SMMU architecture
> > > > +	 * specification defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > > > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping groups. And
> > > > +	 * those groups don't exhibit the same behavior as the architecture supported ones.
> > > > +	 */
> > > 
> > > Please fix your editor so that it wraps lines at 80 columns, which is
> > > still the preferred (soft) limit.
> > > 
> > 
> > If exceeding 80 columns end up making the comment more readable (fewer lines),
> > then why should we limit ourselves?
> 
> Exceeding 80 column for comments does generally not improve readability.
> 

It all depends on the perspective/preference... But I can limit to 80 columns
here.

> That part of the coding standard has do to with not adding excessive
> line breaks to *code*, where it can sometimes impact readability.
> 
> > > > +	if (smmu->num_mapping_groups > 128) {
> > > > +		dev_warn(smmu->dev, "\tLimiting the stream matching groups to 128\n");
> > > 
> > > dev_notice() should do since there's nothing a user can do about this.
> > > 
> > 
> > Ok.
> > 
> > > > +		smmu->num_mapping_groups = 128;
> > > > +	}
> > > 
> > > So this hunk is really all that is needed to make the current quirk
> > > detection work on sc8280xp. Why not simply stick with the current logic
> > > and use the last group until there is a need for anything more?
> > > 
> > 
> > No! What if the bootloader had set up mapping for 128 groups? In that case
> > we'll overwrite the last group. It is still required to find the valid group
> > and use it for quirk detection. If no group is available, we'll skip it.
> 
> Yes, but that's also entirely hypothetical (and could perhaps also be
> handled by adding a warning for now).
> 
> If you want to rework the quirk handling for this you should at least do
> so in a separate patch as it is arguably a separate change from fixing
> the current quirk detection for newer SoCs by capping the number of
> groups (a minimal fix that could be backported).
> 

Using a separate patch makes sense to me. Will do that in v4.

Thanks,
Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
