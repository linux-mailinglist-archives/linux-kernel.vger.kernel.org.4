Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA726BB588
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjCOOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjCOOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8E521EB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E911C61DB8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4E4C433D2;
        Wed, 15 Mar 2023 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678889480;
        bh=2ZgKuhUmzQIJi23DQ8WF3KDhzuA/X0PImxAEr7gKhN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kA5f8Y1Dnke5ByAplIBxQGzhQT0boWVHFAhi8fDZat3Ya3sdFuvKl/TOeAfowyXjL
         JBKnMPQFDwGyOge6nRoKAIbtu/XLv+z/E1al/+14xw7ukgDy/l3iGy+DUMPOquHpU7
         eNirsu4oWOgbs9F1KLsJ7zEyVW+G5+yVL8bSWFqPnJ/v0Nk9VqPYjYYpvkQMYF5DaO
         JYau2YuL7OeKwTDqRyNY6UqtEEkZo7rlXYFpGQBq+83t1fhlZXl6DH8625dDseTs8w
         AosefqK5NnUkjM+7SIsXr1sJ6m4rx1HJS6Sy85TeKxWx/UJYhsSeEYJtqDvqweaWsq
         CHXERPBznwQ9Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pcRre-00012y-UT; Wed, 15 Mar 2023 15:12:27 +0100
Date:   Wed, 15 Mar 2023 15:12:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <ZBHSSrcOYtLpnFsm@hovoldconsulting.com>
References: <20230314184659.176473-1-manivannan.sadhasivam@linaro.org>
 <ZBF1vFBWKXhHeD2v@hovoldconsulting.com>
 <20230315075958.GC25575@thinkpad>
 <ZBGEEk1d1WtNq4lT@hovoldconsulting.com>
 <20230315133730.GB98059@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315133730.GB98059@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 07:07:30PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 15, 2023 at 09:38:42AM +0100, Johan Hovold wrote:
> > On Wed, Mar 15, 2023 at 01:29:58PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Mar 15, 2023 at 08:37:32AM +0100, Johan Hovold wrote:
> > 
> > > > > +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > > > > +{
> > > > > +	u32 smr;
> > > > > +	int i;
> > > > > +
> > > > > +	/*
> > > > > +	 * Limit the number of stream matching groups to 128 as the ARM SMMU architecture
> > > > > +	 * specification defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > > > > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping groups. And
> > > > > +	 * those groups don't exhibit the same behavior as the architecture supported ones.
> > > > > +	 */
> > > > 
> > > > Please fix your editor so that it wraps lines at 80 columns, which is
> > > > still the preferred (soft) limit.
> > > > 
> > > 
> > > If exceeding 80 columns end up making the comment more readable (fewer lines),
> > > then why should we limit ourselves?
> > 
> > Exceeding 80 column for comments does generally not improve readability.
> > 
> 
> It all depends on the perspective/preference... But I can limit to 80 columns
> here.

No, this is not about preference. The soft limit is 80 columns and a
valid reason for breaking that for comments would be, for example, if
you have a long URL or something which does not fit within that width
(and not just personal preference).

Johan
