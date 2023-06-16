Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4BC732962
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbjFPIBr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbjFPIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:01:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BA2945
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:01:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-12-wR-rwUJuOZepVZfHZ7CX4A-1; Fri, 16 Jun 2023 09:01:38 +0100
X-MC-Unique: wR-rwUJuOZepVZfHZ7CX4A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 16 Jun
 2023 09:01:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 16 Jun 2023 09:01:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'wuyonggang001@208suo.com'" <wuyonggang001@208suo.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@kernel.org" <hare@kernel.org>
Subject: RE: [PATCH] scsi: myrs: Replacing snprintf with scnprintf
Thread-Topic: [PATCH] scsi: myrs: Replacing snprintf with scnprintf
Thread-Index: AQHZnoT513c9A1R2cUiaoES5niWIb6+NEQBg
Date:   Fri, 16 Jun 2023 08:01:35 +0000
Message-ID: <688a2c10bdd24db8a4bf86effdb52606@AcuMS.aculab.com>
References: <20230613065350.39003-1-zhanglibing@cdjrlc.com>
 <f82ebaeda200bc172cd1764b44fa1a0a@208suo.com>
 <6d2c37de23facd0cd854bbaf6913ba3e@208suo.com>
In-Reply-To: <6d2c37de23facd0cd854bbaf6913ba3e@208suo.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuyonggang001@208suo.com
> Sent: 14 June 2023 06:56
> 
> Fix the following coccicheck warning:
> 
> drivers/scsi/myrs.c:1411:8-16: WARNING: use scnprintf or sprintf

That is nothing like the world best commit message.

Also if any of the snprintf() actually overflow the terminating
'\n' is lost - that will have unexpected effects over and above
the truncation.

In fact all the buffer sizes are bogus - did you even look at the code.
I think they should all be using sysfs_emit().

There is also this one:
	char serial[17];

	memcpy(serial, cs->ctlr_info->serial_number, 16);
	serial[16] = '\0';
	return snprintf(buf, 16, "%s\n", serial);
A "%.16s\n" format will have the desired effect.
But completely untested with long names because the 16 isn't big enough.

	David


> 
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>   drivers/scsi/myrs.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
> index a1eec65a9713..ced1d2fbd862 100644
> --- a/drivers/scsi/myrs.c
> +++ b/drivers/scsi/myrs.c
> @@ -939,7 +939,7 @@ static ssize_t raid_state_show(struct device *dev,
>       int ret;
> 
>       if (!sdev->hostdata)
> -        return snprintf(buf, 16, "Unknown\n");
> +        return scnprintf(buf, 16, "Unknown\n");
> 
>       if (sdev->channel >= cs->ctlr_info->physchan_present) {
>           struct myrs_ldev_info *ldev_info = sdev->hostdata;
> @@ -1058,7 +1058,7 @@ static ssize_t raid_level_show(struct device *dev,
>       const char *name = NULL;
> 
>       if (!sdev->hostdata)
> -        return snprintf(buf, 16, "Unknown\n");
> +        return scnprintf(buf, 16, "Unknown\n");
> 
>       if (sdev->channel >= cs->ctlr_info->physchan_present) {
>           struct myrs_ldev_info *ldev_info;
> @@ -1086,7 +1086,7 @@ static ssize_t rebuild_show(struct device *dev,
>       unsigned char status;
> 
>       if (sdev->channel < cs->ctlr_info->physchan_present)
> -        return snprintf(buf, 32, "physical device - not rebuilding\n");
> +        return scnprintf(buf, 32, "physical device - not
> rebuilding\n");
> 
>       ldev_info = sdev->hostdata;
>       ldev_num = ldev_info->ldev_num;
> @@ -1190,7 +1190,7 @@ static ssize_t consistency_check_show(struct
> device *dev,
>       unsigned short ldev_num;
> 
>       if (sdev->channel < cs->ctlr_info->physchan_present)
> -        return snprintf(buf, 32, "physical device - not checking\n");
> +        return scnprintf(buf, 32, "physical device - not checking\n");
> 
>       ldev_info = sdev->hostdata;
>       if (!ldev_info)
> @@ -1303,7 +1303,7 @@ static ssize_t serial_show(struct device *dev,
> 
>       memcpy(serial, cs->ctlr_info->serial_number, 16);
>       serial[16] = '\0';
> -    return snprintf(buf, 16, "%s\n", serial);
> +    return scnprintf(buf, 16, "%s\n", serial);
>   }
>   static DEVICE_ATTR_RO(serial);
> 
> @@ -1313,7 +1313,7 @@ static ssize_t ctlr_num_show(struct device *dev,
>       struct Scsi_Host *shost = class_to_shost(dev);
>       struct myrs_hba *cs = shost_priv(shost);
> 
> -    return snprintf(buf, 20, "%d\n", cs->host->host_no);
> +    return scnprintf(buf, 20, "%d\n", cs->host->host_no);
>   }
>   static DEVICE_ATTR_RO(ctlr_num);
> 
> @@ -1388,7 +1388,7 @@ static ssize_t model_show(struct device *dev,
>       struct Scsi_Host *shost = class_to_shost(dev);
>       struct myrs_hba *cs = shost_priv(shost);
> 
> -    return snprintf(buf, 28, "%s\n", cs->model_name);
> +    return scnprintf(buf, 28, "%s\n", cs->model_name);
>   }
>   static DEVICE_ATTR_RO(model);
> 
> @@ -1398,7 +1398,7 @@ static ssize_t ctlr_type_show(struct device *dev,
>       struct Scsi_Host *shost = class_to_shost(dev);
>       struct myrs_hba *cs = shost_priv(shost);
> 
> -    return snprintf(buf, 4, "%d\n", cs->ctlr_info->ctlr_type);
> +    return scnprintf(buf, 4, "%d\n", cs->ctlr_info->ctlr_type);
>   }
>   static DEVICE_ATTR_RO(ctlr_type);
> 
> @@ -1408,7 +1408,7 @@ static ssize_t cache_size_show(struct device *dev,
>       struct Scsi_Host *shost = class_to_shost(dev);
>       struct myrs_hba *cs = shost_priv(shost);
> 
> -    return snprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
> +    return scnprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
>   }
>   static DEVICE_ATTR_RO(cache_size);
> 
> @@ -1418,7 +1418,7 @@ static ssize_t firmware_show(struct device *dev,
>       struct Scsi_Host *shost = class_to_shost(dev);
>       struct myrs_hba *cs = shost_priv(shost);
> 
> -    return snprintf(buf, 16, "%d.%02d-%02d\n",
> +    return scnprintf(buf, 16, "%d.%02d-%02d\n",
>               cs->ctlr_info->fw_major_version,
>               cs->ctlr_info->fw_minor_version,
>               cs->ctlr_info->fw_turn_number);
> @@ -1488,7 +1488,7 @@ static ssize_t
> disable_enclosure_messages_show(struct device *dev,
>       struct Scsi_Host *shost = class_to_shost(dev);
>       struct myrs_hba *cs = shost_priv(shost);
> 
> -    return snprintf(buf, 3, "%d\n", cs->disable_enc_msg);
> +    return scnprintf(buf, 3, "%d\n", cs->disable_enc_msg);
>   }
> 
>   static ssize_t disable_enclosure_messages_store(struct device *dev,

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

