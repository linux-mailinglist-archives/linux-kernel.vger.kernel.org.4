Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCBA5B3477
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIIJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiIIJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:49:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9654EC74;
        Fri,  9 Sep 2022 02:49:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F22DF15DB;
        Fri,  9 Sep 2022 02:49:52 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A785D3F73D;
        Fri,  9 Sep 2022 02:49:45 -0700 (PDT)
Date:   Fri, 9 Sep 2022 10:49:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCC: Fix memory leak in address space setup
Message-ID: <20220909094943.7nasdznnbwmg3oeb@bogus>
References: <20220909021348.472674-1-rafaelmendsr@gmail.com>
 <YxqmJLCQrK39Mx3O@macondo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxqmJLCQrK39Mx3O@macondo>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 11:34:12PM -0300, Rafael Mendonca wrote:
> On Thu, Sep 08, 2022 at 11:13:47PM -0300, Rafael Mendonca wrote:
> > The allocated memory for the pcc_data struct doesn't get freed under an
> > error path in pcc_mbox_request_channel() or acpi_os_ioremap().
> > 
> > Fixes: 77e2a04745ff8 ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> > Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > ---
> >  drivers/acpi/acpi_pcc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> > index a12b55d81209..fe5ab0fdc3bf 100644
> > --- a/drivers/acpi/acpi_pcc.c
> > +++ b/drivers/acpi/acpi_pcc.c
> > @@ -63,6 +63,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
> >  	if (IS_ERR(data->pcc_chan)) {
> >  		pr_err("Failed to find PCC channel for subspace %d\n",
> >  		       ctx->subspace_id);
> > +		kfree(data);
> >  		return AE_NOT_FOUND;
> >  	}
> >  
> > @@ -72,6 +73,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
> >  	if (!data->pcc_comm_addr) {
> >  		pr_err("Failed to ioremap PCC comm region mem for %d\n",
> >  		       ctx->subspace_id);
> 
> I was wondering if pcc_mbox_free_channel() should be called here as well
> in case of acpi_os_ioremap() failure.
> 

Yes please. There are not modules and shouldn't matter much but it is good
to have it for correctness.

Thanks for finding and fixing this. Also please add the fixes tag in next
version.

Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")

-- 
Regards,
Sudeep
