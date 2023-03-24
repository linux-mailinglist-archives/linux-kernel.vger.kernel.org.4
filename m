Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263D36C853C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCXShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCXShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E712B;
        Fri, 24 Mar 2023 11:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A1762C3A;
        Fri, 24 Mar 2023 18:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20BAC433EF;
        Fri, 24 Mar 2023 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679683029;
        bh=qATMgxUc7/Cj2AjJ1pQbCXfHyJibt2CWK82bpsYLbc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKwKT2jvATosVkXDCUEzPEw02cvUIrtlKc+rNC8B3kZGwALTtjAqCdTI4Q5GpoGGN
         9Y7si8l171gHXPBR5mBw2WvcJD36A4J0gLyjokARGzgfQhq6b0ae4WG9HmptivDfRZ
         sPVSIKdZgIiskRlKC/AGFhkuBOtqobk2hRvrIggEtIVQVcHBKlOpb1uVAX6mWbz1eK
         Y+bJm45ekeVWYX46WrgRSy6HqWenyWfcRsAAiQ9ATFhph3aaM5DJtnezcP+g2kGTPR
         lnTV9mxkv383cFwpwcmSVU6qbn9yFxUE22v4eHWyHOp3ISB5zDTYdtiX1wEbHWfU51
         TG9KVF5SI638w==
Date:   Fri, 24 Mar 2023 18:37:00 +0000
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
Subject: Re: [PATCH v11 12/26] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <20230324183659.GB28266@willie-the-truck>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-13-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304010632.2127470-13-quic_eberman@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 05:06:18PM -0800, Elliot Berman wrote:
> When launching a virtual machine, Gunyah userspace allocates memory for
> the guest and informs Gunyah about these memory regions through
> SET_USER_MEMORY_REGION ioctl.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/virt/gunyah/Makefile    |   2 +-
>  drivers/virt/gunyah/vm_mgr.c    |  44 ++++++
>  drivers/virt/gunyah/vm_mgr.h    |  25 ++++
>  drivers/virt/gunyah/vm_mgr_mm.c | 229 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/gunyah.h     |  29 ++++
>  5 files changed, 328 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c

[...]

> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
> +{
> +	struct gh_vm_mem *mapping, *tmp_mapping;
> +	struct gh_rm_mem_entry *mem_entries;
> +	phys_addr_t curr_page, prev_page;
> +	struct gh_rm_mem_parcel *parcel;
> +	int i, j, pinned, ret = 0;
> +	size_t entry_size;
> +	u16 vmid;
> +
> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +		!PAGE_ALIGNED(region->userspace_addr) || !PAGE_ALIGNED(region->guest_phys_addr))
> +		return -EINVAL;
> +
> +	if (region->guest_phys_addr + region->memory_size < region->guest_phys_addr)
> +		return -EOVERFLOW;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ret;
> +
> +	mapping = __gh_vm_mem_find_by_label(ghvm, region->label);
> +	if (mapping) {
> +		mutex_unlock(&ghvm->mm_lock);
> +		return -EEXIST;
> +	}
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
> +	if (!mapping) {
> +		mutex_unlock(&ghvm->mm_lock);
> +		return -ENOMEM;
> +	}
> +
> +	mapping->parcel.label = region->label;
> +	mapping->guest_phys_addr = region->guest_phys_addr;
> +	mapping->npages = region->memory_size >> PAGE_SHIFT;
> +	parcel = &mapping->parcel;
> +	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
> +	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
> +
> +	/* Check for overlap */
> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
> +		if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
> +			tmp_mapping->guest_phys_addr) ||
> +			(mapping->guest_phys_addr >=
> +			tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {
> +			ret = -EEXIST;
> +			goto free_mapping;
> +		}
> +	}
> +
> +	list_add(&mapping->list, &ghvm->memory_mappings);
> +
> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
> +	if (!mapping->pages) {
> +		ret = -ENOMEM;
> +		mapping->npages = 0; /* update npages for reclaim */
> +		goto reclaim;
> +	}
> +
> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
> +	if (pinned < 0) {
> +		ret = pinned;
> +		mapping->npages = 0; /* update npages for reclaim */
> +		goto reclaim;
> +	} else if (pinned != mapping->npages) {
> +		ret = -EFAULT;
> +		mapping->npages = pinned; /* update npages for reclaim */
> +		goto reclaim;
> +	}

I think Fuad mentioned this on an older version of these patches, but it
looks like you're failing to account for the pinned memory here which is
a security issue depending on who is able to issue the ioctl() calling
into here.

Specifically, I'm thinking that your kXalloc() calls should be using
GFP_KERNEL_ACCOUNT in this function and also that you should be calling
account_locked_vm() for the pages being pinned.

Finally, what happens if userspace passes in a file mapping?

Will
