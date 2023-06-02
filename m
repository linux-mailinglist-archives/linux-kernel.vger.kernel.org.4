Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018DE72048A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjFBOck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjFBOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:32:38 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC6899
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:32:37 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39a53c7648fso1831439b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685716357; x=1688308357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NwA907vGnrNpaOFyWDRDxSy5v1vFxmBWhlUfMES2kw=;
        b=EauV+zfSnBg6r0ozgcM9FVLsm5gQCUXgiYyfYePz+nQ/L81vRnwKSIX3WIdM4BmfS2
         Y6Q0se655hmMB+A2zm5Ipm6ukstFJH/l3WWIKs6vgRvCR18zZL6inolAzhr0+/y2NZGd
         wLDgV6XS3o9gg12dJMji52ozOCvPoJ1oejgSpyUaETeJQtItQiIplDI7sgX65PF7k5G4
         6CGEq9XCateFJruI6vXJDAEmQOFsSgegr4aLlAXyQ/0o/BOZtRDufrYSj2nRrD0gd/Ip
         HkDVzLSDdWPCV3pG3MTk58ed9yYqeyz8j4tvKpboWViVkZaPjy84wwHmnWt93wpu6fLU
         6WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716357; x=1688308357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NwA907vGnrNpaOFyWDRDxSy5v1vFxmBWhlUfMES2kw=;
        b=iWsUaz3A2LpDZ58xMzYEvK8lN39Puy1XRBKeIG3tXZxjmFwwFh/8ZC/fTHRq+TNEg/
         tjY6auYwb31qgPpPCxsFFptrs+medqb0IfUaxhpqg6mK6aI6mUgtFFFJr0moUdf+PkKf
         GB9t965spItGmMjl7OmCxhxXtL0xlJz45Ljjee4/FeNWv33lZy2gcNZbwhxXj34HF6Or
         06H5z5YNZthePzR9xMc2rySauT0EZ9GqKNDAcb8jGPlnfDY9fUFdL77vIJ+nFw7mO2dl
         lXO/SPXq9jRCkGLaPbyualh8hccUTknUf0AiT7jKIQhkC7rE7QVmv2I4RVjJx8gat9ZT
         Y0jw==
X-Gm-Message-State: AC+VfDxzawA2N325lFYO0B9xK3KFQrbyEI/rij7ZkjLCj1Ebt5NerpLv
        LJJxYpkahrpb94Osftq8/A+NP6HTNc9S/zrJhqk=
X-Google-Smtp-Source: ACHHUZ4V0UzJXmOaS27pn0qGqFdFCh76Hfz2jr/a0CAePlRB6y4q8OwnVaD7Jbl2aB8HCK25aVZeqQ==
X-Received: by 2002:a54:408b:0:b0:39a:748f:4bbd with SMTP id i11-20020a54408b000000b0039a748f4bbdmr132133oii.15.1685716356815;
        Fri, 02 Jun 2023 07:32:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id j18-20020a0ceb12000000b0061b5dbf1994sm839858qvp.146.2023.06.02.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:32:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q55pT-001vhW-EA;
        Fri, 02 Jun 2023 11:32:35 -0300
Date:   Fri, 2 Jun 2023 11:32:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/vt-d: Use BUG_ON to check NULL value of 'table'
Message-ID: <ZHn9g6QoMUo3ZPog@ziepe.ca>
References: <20230530092503.152926-1-yanfei.xu@intel.com>
 <20230530092503.152926-3-yanfei.xu@intel.com>
 <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e75f9de-4c67-93aa-9fb4-28da9849dd48@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:26:55AM +0800, Baolu Lu wrote:
> On 5/30/23 5:25 PM, Yanfei Xu wrote:
> > Checking NULL value of 'table' variable deserves a BUG_ON as the
> > following code will trigger a crash by dereferencing the NULL
> > 'table' pointer. Crash in advance with BUG_ON to avoid WARN_ON
> > plus NULL pointer dereferencing can simplify the crash log.
> > 
> > Signed-off-by: Yanfei Xu<yanfei.xu@intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index e98f1b122b49..8aa3bfdb7f95 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1944,7 +1944,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
> >   	if (sm_supported(iommu)) {
> >   		unsigned long pds;
> > -		WARN_ON(!table);
> > +		BUG_ON(!table);
> 
> BUG_ON() is not recommended. Perhaps,
> 
> 		if (!table)
> 			-ENODEV;
> 
> ?

If it is not something you think needs active debugging then just let
it crash on the NULL pointer deref. You get a nice backtrace from that
already.

The additional value of the WARN is it gives you a line number, a
prettier print and it might recover more cleanly (or not, it might
just crash somewhere else).

Jason
