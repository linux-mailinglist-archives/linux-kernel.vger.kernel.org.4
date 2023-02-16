Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA0F698D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBPGkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBPGkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:40:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61430E7;
        Wed, 15 Feb 2023 22:40:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 760E661E7D;
        Thu, 16 Feb 2023 06:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDE5C433EF;
        Thu, 16 Feb 2023 06:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676529600;
        bh=i/gFW7xw3ssMXfWealq1JVbkTWRlXjOE9hh4U1oAul4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vnrKBDI6+KleQd4h7q04YWpW6zAf4tyt5FOLu7IeQvJjvRle1fp/nrj+Owq0lxgqT
         9cL3kKh+UxeNWNeWftCalkyrhH4Sqvr288mXTmD8raLY8+6455lv3u3VkbXfNstmy6
         O7Fj1V8G0BFkR7Q/7gILSgPJEaj7IX5gI4Tapuuo=
Date:   Thu, 16 Feb 2023 07:39:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 09/26] gunyah: rsc_mgr: Add VM lifecycle RPC
Message-ID: <Y+3PvUqkC2YJaW5o@kroah.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212343.3311875-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214212343.3311875-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:23:42PM -0800, Elliot Berman wrote:
> 
> Add Gunyah Resource Manager RPC to launch an unauthenticated VM.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/virt/gunyah/Makefile      |   2 +-
>  drivers/virt/gunyah/rsc_mgr.h     |  45 ++++++
>  drivers/virt/gunyah/rsc_mgr_rpc.c | 226 ++++++++++++++++++++++++++++++
>  include/linux/gunyah_rsc_mgr.h    |  73 ++++++++++
>  4 files changed, 345 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
> 
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index cc864ff5abbb..de29769f2f3f 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -2,5 +2,5 @@
>  
>  obj-$(CONFIG_GUNYAH) += gunyah.o
>  
> -gunyah_rsc_mgr-y += rsc_mgr.o
> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
>  obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
> index d4e799a7526f..7406237bc66d 100644
> --- a/drivers/virt/gunyah/rsc_mgr.h
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -74,4 +74,49 @@ struct gh_rm;
>  int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
>  		void **resp_buf, size_t *resp_buff_size);
>  
> +/* Message IDs: VM Management */
> +#define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
> +#define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
> +#define GH_RM_RPC_VM_START			0x56000004
> +#define GH_RM_RPC_VM_STOP			0x56000005
> +#define GH_RM_RPC_VM_RESET			0x56000006
> +#define GH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
> +#define GH_RM_RPC_VM_INIT			0x5600000B
> +#define GH_RM_RPC_VM_GET_HYP_RESOURCES		0x56000020
> +#define GH_RM_RPC_VM_GET_VMID			0x56000024
> +
> +struct gh_rm_vm_common_vmid_req {
> +	__le16 vmid;
> +	__le16 reserved0;

reserved for what?  What is a valid value for this field?  Should it be
checked for 0?

Same with other "reserved0" fields in this file.


> +} __packed;
> +
> +/* Call: VM_ALLOC */
> +struct gh_rm_vm_alloc_vmid_resp {
> +	__le16 vmid;
> +	__le16 reserved0;
> +} __packed;
> +
> +/* Call: VM_STOP */
> +struct gh_rm_vm_stop_req {
> +	__le16 vmid;
> +#define GH_RM_VM_STOP_FLAG_FORCE_STOP	BIT(0)
> +	u8 flags;
> +	u8 reserved;

Why just "reserved" and not "reserved0"?  Naming is hard :(

thanks,

greg k-h
