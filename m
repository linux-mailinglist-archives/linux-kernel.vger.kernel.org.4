Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461161FDF2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiKGSyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiKGSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:54:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CA02098C;
        Mon,  7 Nov 2022 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667847249; x=1699383249;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wse9lfFdYoNnsHozOn6S6AyJtMToRqPsuy43jq4mwR0=;
  b=A27iMrTOdlesBmIBX/HTQ9R7qnjaTEqrKmQ0AOOhKkb+Bea6dAovzQV5
   nhYzclpUVjKrVNeQgibVSPr3RNPeaFTGP4eYGM9uq1lHI4POe9Uytvvux
   rv4M2xAAoFKuAcDSUNn/puHmFcX+t+pX9miRSzsW7xsud9MtvvsJZSNGe
   4TePV1ZrEZd/u8lhLkiNRqBWmwS+2B5Q+uBPOeYh3leZZQ87sx6AzKqCO
   guJ45TFoOeB9bWwMBpdQRiKDVNVEW426g55mxnA3runG6rCXNbEV/8lpq
   4fnx6c52vLtIFG2SrNdiAGvl8KU7bCrfk1oZMxu2xpsCGt79jyjtE/wED
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="396791848"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="396791848"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 10:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="810949486"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="810949486"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2022 10:54:08 -0800
Received: from weiqiand-mobl.amr.corp.intel.com (unknown [10.212.240.203])
        by linux.intel.com (Postfix) with ESMTP id CF839580B9C;
        Mon,  7 Nov 2022 10:54:08 -0800 (PST)
Message-ID: <fc480d25aabaa3923f24bbaa9b0f329f78c40abb.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Improve buffer handling
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Nov 2022 10:54:08 -0800
In-Reply-To: <20221102212336.380257-1-W_Armin@gmx.de>
References: <20221102212336.380257-1-W_Armin@gmx.de>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-02 at 22:23 +0100, Armin Wolf wrote:
> When the DDV interface returns a buffer, it actually
> returns a acpi buffer containing an integer (buffer size)
> and another acpi buffer (buffer content).
> The size of the buffer may be smaller than the size of
> the buffer content, which is perfectly valid and should not
> be treated as an error.

Is there documentation for this that you can refer to?

> Also use the buffer size instead of the buffer content size
> when accessing the buffer to prevent accessing bogus data.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c
> b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 699feae3c435..1a001296e8c6 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -129,9 +129,9 @@ static int dell_wmi_ddv_query_buffer(struct wmi_device
> *wdev, enum dell_ddv_meth
>  	if (obj->package.elements[1].type != ACPI_TYPE_BUFFER)
>  		goto err_free;
> 
> -	if (buffer_size != obj->package.elements[1].buffer.length) {
> +	if (buffer_size > obj->package.elements[1].buffer.length) {
>  		dev_warn(&wdev->dev,
> -			 FW_WARN "ACPI buffer size (%llu) does not match WMI
> buffer size (%d)\n",
> +			 FW_WARN "WMI buffer size (%llu) exceeds ACPI buffer
> size (%d)\n",
>  			 buffer_size, obj->package.elements[1].buffer.length);
> 
>  		goto err_free;
> @@ -271,15 +271,17 @@ static int dell_wmi_ddv_buffer_read(struct seq_file
> *seq, enum dell_ddv_method m
>  	struct device *dev = seq->private;
>  	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
>  	union acpi_object *obj;
> -	union acpi_object buf;
> +	u64 size;
> +	u8 *buf;
>  	int ret;
> 
>  	ret = dell_wmi_ddv_query_buffer(data->wdev, method, 0, &obj);
>  	if (ret < 0)
>  		return ret;
> 
> -	buf = obj->package.elements[1];
> -	ret = seq_write(seq, buf.buffer.pointer, buf.buffer.length);
> +	size = obj->package.elements[0].integer.value;
> +	buf = obj->package.elements[1].buffer.pointer;
> +	ret = seq_write(seq, buf, size);

Okay, so the buffer may provide more space than what should actually be used
according to the size field. This looks like a bug that should have a fixes tag
on the original commit.

David

>  	kfree(obj);
> 
>  	return ret;
> --
> 2.30.2
> 

