Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794695B314E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiIIIE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIIIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80193B977;
        Fri,  9 Sep 2022 01:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6654A61EFD;
        Fri,  9 Sep 2022 08:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75658C433D6;
        Fri,  9 Sep 2022 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662710691;
        bh=a1cYy5MrT3rsObddkZ5SvOhpaU4KtFmno4KfYtVj8Xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=am4NbRnsoHr+0A8vcwv0XHWU0b+BxgCE2O20ksCk5uDUOlVL/OaPRJvnrdYTE7l+v
         lyMmCTIKkCdVwi5IMVXB/+Nac32pqEXrkINMqz88oAk/07686msx+m9hBpumRxASwz
         sAaOOTatfSCjwPEqrx9z6E8FyPGS7itc6BEvT69gm9CgEyKV1lOa5iZH0SVjhAGxBR
         QT+AGYi0uUpyOZkYNukudD6SYAWU2OUzTSwUZ87FL8yzgEciRVrzNHBPzcTSReYg+W
         wIX2NVCa/RBmMAcQbvPZkZO4WNIOGqHAJ6k5fmHWyynPL95y8LJZK77LxkhBk8y26p
         sOWd+CLheXNtw==
Date:   Fri, 9 Sep 2022 10:04:44 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Robin Murphy <robin.murphy@arm.com>, chenhuacai@loongson.cn,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: Re: [PATCH V3 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
Message-ID: <YxrznBoBQycR8xCA@lpieralisi>
References: <20220830030139.29899-1-lvjianmin@loongson.cn>
 <20220830030139.29899-2-lvjianmin@loongson.cn>
 <435e1283-9ff6-f089-6436-3c31a178fd60@arm.com>
 <66baf6f8-0f18-e0a6-4ed4-e2f783497d2d@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66baf6f8-0f18-e0a6-4ed4-e2f783497d2d@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 08:40:48PM +0800, Jianmin Lv wrote:
> 
> 
> On 2022/9/5 下午8:20, Robin Murphy wrote:
> > On 2022-08-30 04:01, Jianmin Lv wrote:
> > > For DT, of_dma_get_range returns bus_dma_region typed dma regions,
> > > which makes multiple dma windows with different offset available
> > > for translation between dma address and cpu address.
> > > 
> > > But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
> > > causing no path for setting dev->dma_range_map conveniently. So the
> > > patch changes acpi_dma_get_range and returns bus_dma_region typed
> > > dma regions according to of_dma_get_range.
> > > 
> > > After changing acpi_dma_get_range, acpi_arch_dma_setup is changed for
> > > ARM64, where original dma_addr and size are removed as these
> > > arguments are now redundant, and pass 0 and U64_MAX for dma_base
> > > and size of arch_setup_dma_ops, so this is a simplification consistent
> > > with what other ACPI architectures also pass to iommu_setup_dma_ops().
> > 
> > Other than a micro-nit that acpi_dma_get_range() could probably use
> > resource_size(),
> > 
> 
> Ok, thanks, I'll use resource_size() in acpi_dma_get_range().

Are you reposting this shortly ? We are almost at -rc5, it would
be good if we can proceed promptly.

Thanks,
Lorenzo

> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > 
> > It took me longer than I care to admit to figure out where the implicit
> > declaration of struct bus_dma_region in the scope of acpi.h and
> > acpi_bus.h comes from, but in the end I guess it's sufficiently
> > well-defined by the C spec to be reliable.
> > 
> > Thanks for getting this done!
> > 
> 
> It's a pleasure!
> 
> 
> > Robin.
> > 
> 
> [...]
> 
> 
