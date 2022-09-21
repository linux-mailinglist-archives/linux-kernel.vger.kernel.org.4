Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EA95C00D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIUPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIUPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC66868BE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663773111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsOa/mWaZHd2rYYK20igB3bqeTA/cfqJrX2JVmmNRr4=;
        b=Dofz7YP5e787+a14sgjXCD59K0/qWFmyh9Pea/GexcBG4Ras15PjzofES0Umv9YHeCCoM+
        UCwve7EGBsn0zUSzEU5jBNzK2bNUofc5VdSOGj5Wdj8b1eakXYHpVeLPM1BNibt9yWELkG
        fsuQdV4w2RFGEF2sa8lugAuv+Q5rHh4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-wbSANL8SPIW30yyvnvcrAg-1; Wed, 21 Sep 2022 11:11:47 -0400
X-MC-Unique: wbSANL8SPIW30yyvnvcrAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A315855423;
        Wed, 21 Sep 2022 15:11:47 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.39.194.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA0364024CA3;
        Wed, 21 Sep 2022 15:11:45 +0000 (UTC)
Date:   Wed, 21 Sep 2022 17:11:43 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     margeyang <marge.yang@synaptics.corp-partner.google.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        dancarpenter@oracle.com, marge.yang@tw.synaptics.com,
        derek.cheng@tw.synaptics.com, vincent.huang@tw.synaptics.com
Subject: Re: [PATCH V4] HID: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
Message-ID: <20220921151143.xrchxekzqrgqlujv@mail.corp.redhat.com>
References: <1660559178-5323-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660559178-5323-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15 2022, margeyang wrote:
> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
> 
> The interrupt GPIO will be pulled down once
> after RMI driver reads this command(Report ID:0x0A).
> It will cause "Dark resume test fail" for chromebook device.
> Hence, TP driver will ignore rmi_hid_read_block function once
> after system resumes.
> 
> Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
> ---

I have fixed your signed-off-by line by adding a space between your name
and address, and converted the C++ style comments into proper multiline
comments, and applied to for-6.1/rmi in hid.git

Sorry for the delay, this one went through the cracks.

Cheers,
Benjamin

>  drivers/hid/hid-rmi.c | 14 +++++++++++++-
>  include/linux/rmi.h   |  2 ++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 311eee599ce9..45eacb0b8dae 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -190,7 +190,7 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
>  {
>  	struct rmi_data *data = container_of(xport, struct rmi_data, xport);
>  	struct hid_device *hdev = data->hdev;
> -	int ret;
> +	int ret = 0;
>  	int bytes_read;
>  	int bytes_needed;
>  	int retries;
> @@ -204,6 +204,13 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
>  			goto exit;
>  	}
>  
> +	if (xport->ignoreonce == 1) {
> +		dev_err(&hdev->dev,
> +			"ignoreonce (%d)\n",
> +			xport->ignoreonce);
> +		xport->ignoreonce = 0;
> +		goto exit;
> +	}
>  	for (retries = 5; retries > 0; retries--) {
>  		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
>  		data->writeReport[1] = 0; /* old 1 byte read count */
> @@ -469,7 +476,12 @@ static int rmi_post_resume(struct hid_device *hdev)
>  	if (ret)
>  		return ret;
>  
> +	// Avoid to read rmi_hid_read_block once after system resumes.
> +	// The interrupt will be pulled down
> +	// after RMI Read command(Report ID:0x0A).
> +	data->xport.ignoreonce = 1;
>  	ret = rmi_reset_attn_mode(hdev);
> +	data->xport.ignoreonce = 0;
>  	if (ret)
>  		goto out;
>  
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index ab7eea01ab42..24f63ad00970 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -270,6 +270,8 @@ struct rmi_transport_dev {
>  	struct rmi_device_platform_data pdata;
>  
>  	struct input_dev *input;
> +
> +	int ignoreonce;
>  };
>  
>  /**
> -- 
> 2.22.0.windows.1
> 

