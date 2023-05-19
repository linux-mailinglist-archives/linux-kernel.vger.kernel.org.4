Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B4C708E18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjESDBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjESDBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:01:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24F10E6;
        Thu, 18 May 2023 20:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684465280; x=1716001280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hUWtTnPkdiCSv1gD3T8DNAmXlhYNSbvOr2sFJG2z9xM=;
  b=d7JIoEdwSCZN9/cOTSgj+tXmlBUAO+cHpd53i/we4rMHfVPeQ44Y44IP
   6fufHfwyozJKi+hwgcXS2KlkzpBGXbFRxhZjtwgT+CFFMXQQbdpI0tG0L
   nxBIxTZ31HH+ha7qrX2i9BuWd0Aq9BsYLjnCOvNRkJuPb9mtKZ1xAulT6
   nSV1LSZ7TmK0CgW+Vj4476SzB9ePDTSSmdo7/SDhX5d1sKZE4XMZNn4nn
   EwrqvT0fvrYnmQgQQz0H14LQWcXTGOt9/h/CxicAFCOoZe6n0JNGy5CX7
   VoaCotNXNe1CPupeHo9273Frb6RhQltAMyHHEDS6cLuxt/iS4h4TXCkaO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336854925"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="336854925"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 20:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="702371204"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="702371204"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.20.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 20:01:19 -0700
Date:   Thu, 18 May 2023 20:01:18 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 4/4] tools/testing/cxl: add firmware update emulation to
 CXL memdevs
Message-ID: <ZGbmfsU6vc6uZ+E+@aschofie-mobl2>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
 <20230421-vv-fw_update-v1-4-22468747d72f@intel.com>
 <20230511171816.0000303f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511171816.0000303f@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 05:18:16PM +0100, Jonathan Cameron wrote:
> On Fri, 21 Apr 2023 21:09:28 -0600
> Vishal Verma <vishal.l.verma@intel.com> wrote:
> 
> > Add emulation for the 'Get FW Info', 'Transfer FW', and 'Activate FW'
> > CXL mailbox commands to the cxl_test emulated memdevs to enable
> > end-to-end unit testing of a firmware update flow. For now, only
> > advertise an 'offline activation' capability as that is all the CXL
> > memdev driver currently implements.
> > 
> > Add some canned values for the serial number fields, and create a
> > platform device sysfs knob to calculate the sha256sum of the firmware
> > image that was received, so a unit test can compare it with the original
> > file that was uploaded.
> > 
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Hi Vishal,
> 
> A few trivial comments inline,
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  tools/testing/cxl/test/mem.c | 191 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 191 insertions(+)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 9263b04d35f7..bc99cc673550 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -7,11 +7,14 @@
> >  #include <linux/delay.h>
> >  #include <linux/sizes.h>
> >  #include <linux/bits.h>
> > +#include <crypto/hash.h>
> >  #include <cxlmem.h>
> >  
> >  #include "trace.h"
> >  
> >  #define LSA_SIZE SZ_128K
> > +#define FW_SIZE SZ_64M
> > +#define FW_SLOTS 3
> >  #define DEV_SIZE SZ_2G
> >  #define EFFECT(x) (1U << x)
> >  
> > @@ -40,6 +43,18 @@ static struct cxl_cel_entry mock_cel[] = {
> >  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
> >  		.effect = cpu_to_le16(0),
> >  	},
> > +	{
> > +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_FW_INFO),
> > +		.effect = cpu_to_le16(0),
> > +	},
> > +	{
> > +		.opcode = cpu_to_le16(CXL_MBOX_OP_TRANSFER_FW),
> > +		.effect = cpu_to_le16(EFFECT(0) | EFFECT(6)),
> 
> Beginning to feel like some defines for each effect might be worth
> adding.
> 
> > +	},
> > +	{
> > +		.opcode = cpu_to_le16(CXL_MBOX_OP_ACTIVATE_FW),
> > +		.effect = cpu_to_le16(EFFECT(0) | EFFECT(1)),
> > +	},
> >  };
> 
> ...
> 
> > +static int mock_transfer_fw(struct cxl_dev_state *cxlds,
> > +			    struct cxl_mbox_cmd *cmd)
> > +{
> > +	struct cxl_mbox_transfer_fw *transfer = cmd->payload_in;
> > +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> > +	void *fw = mdata->fw;
> > +	size_t offset, length;
> > +
> > +	offset = le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_OFFSET_ALIGN;
> > +	length = cmd->size_in - sizeof(*transfer);
> > +	if (offset + length > FW_SIZE)
> > +		return -EINVAL;
> > +
> > +	switch (transfer->action) {
> > +	case CXL_FW_TRANSFER_ACTION_FULL:
> > +		if (offset != 0)
> > +			return -EINVAL;
> > +		fallthrough;
> > +	case CXL_FW_TRANSFER_ACTION_END:
> > +		if (transfer->slot == 0 || transfer->slot > FW_SLOTS)
> > +			return -EINVAL;
> > +		mdata->fw_size = offset + length;
> > +		break;
> > +	case CXL_FW_TRANSFER_ACTION_START:
> > +	case CXL_FW_TRANSFER_ACTION_CONTINUE:
> > +	case CXL_FW_TRANSFER_ACTION_ABORT:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	memcpy(fw + offset, &transfer->data[0], length);
> 
> Slight preference for transfer->data
> 

What's the story behind that Jonathan? 
I imagined kernel developers leaned towards the explicit.

Alison


> > +	return 0;
> > +}
> > +
> 
> ...
> 
> > +static int do_sha256(u8 *data, unsigned int length, u8 *hash)
> 
> Can't use the one in include/crypto/sha2.h?  Don't think anyone really
> cares about extreme performance here.
> 
> > +{
> > +	struct crypto_shash *alg;
> > +	struct sdesc *sdesc;
> > +	size_t size;
> > +	int rc;
> > +
> > +	alg = crypto_alloc_shash("sha256", 0, 0);
> > +	if (IS_ERR(alg))
> > +		return PTR_ERR(alg);
> > +
> > +	size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
> > +	sdesc = kzalloc(size, GFP_KERNEL);
> > +	if (!sdesc) {
> > +		rc = -ENOMEM;
> > +		goto out_shash;
> > +	}
> > +
> > +	sdesc->shash.tfm = alg;
> > +	rc = crypto_shash_digest(&sdesc->shash, data, length, hash);
> > +
> > +	kfree(sdesc);
> > +out_shash:
> > +	crypto_free_shash(alg);
> > +	return rc;
> > +}
> > +
> > +#define CHECKSUM_SIZE 32
> > +
> > +static ssize_t fw_buf_checksum_show(struct device *dev,
> > +				    struct device_attribute *attr, char *buf)
> > +{
> > +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
> > +	unsigned char *hstr, *hptr;
> > +	u8 hash[CHECKSUM_SIZE];
> > +	ssize_t written = 0;
> > +	int i, rc;
> > +
> > +	rc = do_sha256(mdata->fw, mdata->fw_size, &hash[0]);
> > +	if (rc) {
> > +		dev_err(dev, "error calculating checksum: %d\n", rc);
> > +		goto out_free;
> > +	}
> > +
> > +	hstr = kzalloc((CHECKSUM_SIZE * 2) + 1, GFP_KERNEL);
> > +	if (!hstr)
> > +		return -ENOMEM;
> > +
> > +	hptr = hstr;
> > +	for (i = 0; i < CHECKSUM_SIZE; i++)
> > +		hptr += sprintf(hptr, "%02x", hash[i]);
> > +
> > +	written = sysfs_emit(buf, "%s\n", hstr);
> > +
> > +out_free:
> > +	kfree(hstr);
> > +	return written;
> > +}
> > +
> > +static DEVICE_ATTR_RO(fw_buf_checksum);
> > +
> >  static struct attribute *cxl_mock_mem_attrs[] = {
> >  	&dev_attr_security_lock.attr,
> >  	&dev_attr_event_trigger.attr,
> > +	&dev_attr_fw_buf_checksum.attr,
> >  	NULL
> >  };
> >  ATTRIBUTE_GROUPS(cxl_mock_mem);
> > 
> 
