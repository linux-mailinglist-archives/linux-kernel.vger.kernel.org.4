Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB55FB097
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJKKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJKKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:41:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B7B43634;
        Tue, 11 Oct 2022 03:41:28 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mmsjj715qz67N5b;
        Tue, 11 Oct 2022 18:39:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 12:41:26 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 11:41:26 +0100
Date:   Tue, 11 Oct 2022 11:41:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 01/11] cxl/mbox: Add debug of hardware error code
Message-ID: <20221011114125.00003bd2@huawei.com>
In-Reply-To: <20221010224131.1866246-2-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-2-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 15:41:21 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> If a mailbox command fails the driver always reports ENXIO.  But this
> may not be enough information to understand why the hardware, or in my
> case Qemu, was failing.
> 
> Add a debug print of the error code returned from the hardware.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Seems very sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 16176b9278b4..6c4d024ad0e8 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -181,8 +181,11 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>  	if (rc)
>  		return rc;
>  
> -	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
> +	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> +		dev_dbg(cxlds->dev, "MB error : %s\n",
> +			cxl_mbox_cmd_rc2str(&mbox_cmd));
>  		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
> +	}
>  
>  	/*
>  	 * Variable sized commands can't be validated and so it's up to the

