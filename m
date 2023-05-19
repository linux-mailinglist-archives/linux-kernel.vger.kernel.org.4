Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341A77096FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjESMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjESL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EADF5;
        Fri, 19 May 2023 04:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 955C765710;
        Fri, 19 May 2023 11:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ECCC433EF;
        Fri, 19 May 2023 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684497597;
        bh=jGfCp1g8O5R8vITSnEGD8PGxEQbGPlY0ilYpANNCCaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rl3XaIMlUbNbyDZRfTH8BGhpI6z9Y9DxA6Svt94cOsXYGzba520RDaU0XgL24vKdM
         La3NQRENMGf2yXJziYPJq+MzgzRZIzqWpoNcjDWRa6I8vGsvsbnl2o5eYY05go683w
         lHFsXp+mjrnKW1jVMXk4PIxcvEJoaaCPZAroSn/INjFJhJ+tl/k+cCS8asEYp5S2JM
         HsunLtnp4zHAklMhHbSSYxvWgnU3fKmC1A1JDYi+2tGAWV/fZ+Ev+2a+Chc9lFWh9c
         lq0yhdjf/BDk8+6xRkZq2gQwNkcLT4l2u4XlbmMjapUH+MZRGHNUVbDAb3AYkgn173
         wsYZ/eTE+RuBQ==
Date:   Fri, 19 May 2023 12:59:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 10/24] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230519115948.GB2637@willie-the-truck>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-11-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509204801.2824351-11-quic_eberman@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

On Tue, May 09, 2023 at 01:47:47PM -0700, Elliot Berman wrote:
> When launching a virtual machine, Gunyah userspace allocates memory for
> the guest and informs Gunyah about these memory regions through
> SET_USER_MEMORY_REGION ioctl.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/virt/gunyah/Makefile    |   2 +-
>  drivers/virt/gunyah/vm_mgr.c    |  59 +++++++-
>  drivers/virt/gunyah/vm_mgr.h    |  26 ++++
>  drivers/virt/gunyah/vm_mgr_mm.c | 236 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/gunyah.h     |  37 +++++
>  5 files changed, 356 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c

[...]

> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
> +{
> +	struct gh_vm_mem *mapping, *tmp_mapping;
> +	struct page *curr_page, *prev_page;
> +	struct gh_rm_mem_parcel *parcel;
> +	int i, j, pinned, ret = 0;
> +	unsigned int gup_flags;
> +	size_t entry_size;
> +	u16 vmid;
> +
> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +		!PAGE_ALIGNED(region->userspace_addr) ||
> +		!PAGE_ALIGNED(region->guest_phys_addr))
> +		return -EINVAL;
> +
> +	if (overflows_type(region->guest_phys_addr + region->memory_size, u64))
> +		return -EOVERFLOW;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ret;
> +
> +	mapping = __gh_vm_mem_find_by_label(ghvm, region->label);
> +	if (mapping) {
> +		ret = -EEXIST;
> +		goto unlock;
> +	}
> +
> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
> +		if (gh_vm_mem_overlap(tmp_mapping, region->guest_phys_addr,
> +					region->memory_size)) {
> +			ret = -EEXIST;
> +			goto unlock;
> +		}
> +	}
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL_ACCOUNT);
> +	if (!mapping) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	mapping->guest_phys_addr = region->guest_phys_addr;
> +	mapping->npages = region->memory_size >> PAGE_SHIFT;
> +	parcel = &mapping->parcel;
> +	parcel->label = region->label;
> +	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
> +	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
> +
> +	ret = account_locked_vm(ghvm->mm, mapping->npages, true);
> +	if (ret)
> +		goto free_mapping;
> +
> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL_ACCOUNT);
> +	if (!mapping->pages) {
> +		ret = -ENOMEM;
> +		mapping->npages = 0; /* update npages for reclaim */
> +		goto unlock_pages;
> +	}
> +
> +	gup_flags = FOLL_LONGTERM;
> +	if (region->flags & GH_MEM_ALLOW_WRITE)
> +		gup_flags |= FOLL_WRITE;
> +
> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +					gup_flags, mapping->pages);
> +	if (pinned < 0) {
> +		ret = pinned;
> +		goto free_pages;
> +	} else if (pinned != mapping->npages) {
> +		ret = -EFAULT;
> +		mapping->npages = pinned; /* update npages for reclaim */
> +		goto unpin_pages;
> +	}

Sorry if I missed it, but I still don't see where you reject file mappings
here.

This is also the wrong interface for upstream. Please get involved with
the fd-based guest memory discussions [1] and port your series to that. 

This patch cannot be merged in its current form.

Will

[1] https://lore.kernel.org/kvm/20221202061347.1070246-1-chao.p.peng@linux.intel.com/
