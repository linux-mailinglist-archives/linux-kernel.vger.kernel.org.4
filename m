Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3370A6FF6F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbjEKQSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbjEKQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:18:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CB1FEA;
        Thu, 11 May 2023 09:18:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHH8P3VwCz67lhG;
        Fri, 12 May 2023 00:16:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 17:18:17 +0100
Date:   Thu, 11 May 2023 17:18:16 +0100
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
Subject: Re: [PATCH 4/4] tools/testing/cxl: add firmware update emulation to
 CXL memdevs
Message-ID: <20230511171816.0000303f@Huawei.com>
In-Reply-To: <20230421-vv-fw_update-v1-4-22468747d72f@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
        <20230421-vv-fw_update-v1-4-22468747d72f@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 21:09:28 -0600
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
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Hi Vishal,

A few trivial comments inline,

Thanks,

Jonathan

> ---
>  tools/testing/cxl/test/mem.c | 191 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 191 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9263b04d35f7..bc99cc673550 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -7,11 +7,14 @@
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
>  #include <linux/bits.h>
> +#include <crypto/hash.h>
>  #include <cxlmem.h>
>  
>  #include "trace.h"
>  
>  #define LSA_SIZE SZ_128K
> +#define FW_SIZE SZ_64M
> +#define FW_SLOTS 3
>  #define DEV_SIZE SZ_2G
>  #define EFFECT(x) (1U << x)
>  
> @@ -40,6 +43,18 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
>  		.effect = cpu_to_le16(0),
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_FW_INFO),
> +		.effect = cpu_to_le16(0),
> +	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_TRANSFER_FW),
> +		.effect = cpu_to_le16(EFFECT(0) | EFFECT(6)),

Beginning to feel like some defines for each effect might be worth
adding.

> +	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_ACTIVATE_FW),
> +		.effect = cpu_to_le16(EFFECT(0) | EFFECT(1)),
> +	},
>  };

...

> +static int mock_transfer_fw(struct cxl_dev_state *cxlds,
> +			    struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_transfer_fw *transfer = cmd->payload_in;
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> +	void *fw = mdata->fw;
> +	size_t offset, length;
> +
> +	offset = le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_OFFSET_ALIGN;
> +	length = cmd->size_in - sizeof(*transfer);
> +	if (offset + length > FW_SIZE)
> +		return -EINVAL;
> +
> +	switch (transfer->action) {
> +	case CXL_FW_TRANSFER_ACTION_FULL:
> +		if (offset != 0)
> +			return -EINVAL;
> +		fallthrough;
> +	case CXL_FW_TRANSFER_ACTION_END:
> +		if (transfer->slot == 0 || transfer->slot > FW_SLOTS)
> +			return -EINVAL;
> +		mdata->fw_size = offset + length;
> +		break;
> +	case CXL_FW_TRANSFER_ACTION_START:
> +	case CXL_FW_TRANSFER_ACTION_CONTINUE:
> +	case CXL_FW_TRANSFER_ACTION_ABORT:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	memcpy(fw + offset, &transfer->data[0], length);

Slight preference for transfer->data

> +	return 0;
> +}
> +

...

> +static int do_sha256(u8 *data, unsigned int length, u8 *hash)

Can't use the one in include/crypto/sha2.h?  Don't think anyone really
cares about extreme performance here.

> +{
> +	struct crypto_shash *alg;
> +	struct sdesc *sdesc;
> +	size_t size;
> +	int rc;
> +
> +	alg = crypto_alloc_shash("sha256", 0, 0);
> +	if (IS_ERR(alg))
> +		return PTR_ERR(alg);
> +
> +	size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
> +	sdesc = kzalloc(size, GFP_KERNEL);
> +	if (!sdesc) {
> +		rc = -ENOMEM;
> +		goto out_shash;
> +	}
> +
> +	sdesc->shash.tfm = alg;
> +	rc = crypto_shash_digest(&sdesc->shash, data, length, hash);
> +
> +	kfree(sdesc);
> +out_shash:
> +	crypto_free_shash(alg);
> +	return rc;
> +}
> +
> +#define CHECKSUM_SIZE 32
> +
> +static ssize_t fw_buf_checksum_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> +	unsigned char *hstr, *hptr;
> +	u8 hash[CHECKSUM_SIZE];
> +	ssize_t written = 0;
> +	int i, rc;
> +
> +	rc = do_sha256(mdata->fw, mdata->fw_size, &hash[0]);
> +	if (rc) {
> +		dev_err(dev, "error calculating checksum: %d\n", rc);
> +		goto out_free;
> +	}
> +
> +	hstr = kzalloc((CHECKSUM_SIZE * 2) + 1, GFP_KERNEL);
> +	if (!hstr)
> +		return -ENOMEM;
> +
> +	hptr = hstr;
> +	for (i = 0; i < CHECKSUM_SIZE; i++)
> +		hptr += sprintf(hptr, "%02x", hash[i]);
> +
> +	written = sysfs_emit(buf, "%s\n", hstr);
> +
> +out_free:
> +	kfree(hstr);
> +	return written;
> +}
> +
> +static DEVICE_ATTR_RO(fw_buf_checksum);
> +
>  static struct attribute *cxl_mock_mem_attrs[] = {
>  	&dev_attr_security_lock.attr,
>  	&dev_attr_event_trigger.attr,
> +	&dev_attr_fw_buf_checksum.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(cxl_mock_mem);
> 

