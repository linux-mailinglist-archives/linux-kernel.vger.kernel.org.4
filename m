Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6D728319
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjFHOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbjFHOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:54:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C909F273A;
        Thu,  8 Jun 2023 07:54:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcRyT2NYBz67SFB;
        Thu,  8 Jun 2023 22:52:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 15:54:37 +0100
Date:   Thu, 8 Jun 2023 15:54:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 4/4] tools/testing/cxl: add firmware update emulation
 to CXL memdevs
Message-ID: <20230608155436.00006087@Huawei.com>
In-Reply-To: <20230602-vv-fw_update-v2-4-e9e5cd5adb44@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
        <20230602-vv-fw_update-v2-4-e9e5cd5adb44@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2023 14:20:25 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> Add emulation for the 'Get FW Info', 'Transfer FW', and 'Activate FW'
> CXL mailbox commands to the cxl_test emulated memdevs to enable
> end-to-end unit testing of a firmware update flow. For now, only
> advertise an 'offline activation' capability as that is all the CXL
> memdev driver currently implements.
> 
> Add some canned values for the serial number fields, and create a
> platform device sysfs knob to calculate the sha256sum of the firmware
> image that was received, so a unit test can compare it with the original
> file that was uploaded.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

One trivial comment inline.

I've somewhat lost track of the test utils, so less comfortable on reviewing
them than the kernel code.  With that in mind this looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/mem.c | 162 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
> 


> +static int mock_activate_fw(struct cxl_dev_state *cxlds,
> +			    struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_activate_fw *activate = cmd->payload_in;
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> +
> +	if (activate->slot == 0 || activate->slot > FW_SLOTS)
> +		return -EINVAL;
> +
> +	switch (activate->action) {
> +	case CXL_FW_ACTIVATE_ONLINE:
> +		mdata->fw_slot = activate->slot;
> +		mdata->fw_staged = 0;
> +		break;
> +	case CXL_FW_ACTIVATE_OFFLINE:
> +		mdata->fw_staged = activate->slot;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Might as well push the return 0 up to the cases instead of breaking out.


>
