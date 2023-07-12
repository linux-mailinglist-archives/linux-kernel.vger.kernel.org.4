Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC388750088
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGLH6L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 03:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGLH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:58:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BCC10E3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:58:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-LBapHPsiOIqyNB-rdI5Dgg-1; Wed, 12 Jul 2023 08:58:04 +0100
X-MC-Unique: LBapHPsiOIqyNB-rdI5Dgg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Jul
 2023 08:58:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 12 Jul 2023 08:58:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'sunran001@208suo.com'" <sunran001@208suo.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "hare@kernel.org" <hare@kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] csi: myrs: Convert snprintf to scnprintf
Thread-Topic: [PATCH] csi: myrs: Convert snprintf to scnprintf
Thread-Index: AQHZsKXLD4JVpB9Y5EKt/m8ncbihma+1ypnQ
Date:   Wed, 12 Jul 2023 07:58:03 +0000
Message-ID: <6dbbfdf90a1c42d4927ee8fda439ee11@AcuMS.aculab.com>
References: <20230707073016.11786-1-xujianghui@cdjrlc.com>
 <20fbbc099e132bb4d3c367da18051c7c@208suo.com>
In-Reply-To: <20fbbc099e132bb4d3c367da18051c7c@208suo.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunran001@208suo.com
> Sent: 07 July 2023 08:37
> 
> Coccinelle reports: WARNING: use scnprintf or sprintf
> 
> Adding to that, there has also been some slow migration from snprintf to
> scnprintf. This article explains the rationale for this change:
> https: //lwn.net/Articles/69419/
> 
> Signed-off-by: RAN SUN <sunran001@208suo.com>
> ---
>   drivers/scsi/myrs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
> index a1eec65a9713..852aceb81f28 100644
> --- a/drivers/scsi/myrs.c
> +++ b/drivers/scsi/myrs.c
> @@ -1408,7 +1408,8 @@ static ssize_t cache_size_show(struct device *dev,
>       struct Scsi_Host *shost = class_to_shost(dev);
>       struct myrs_hba *cs = shost_priv(shost);
> 
> -    return snprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
> +    return scnprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
> +

You've added a 'random' blank line.

The '8' ought to be ringing alarm bells as well.

If you actually look at the code I think this should be sysfs_emit().
In any case it looks like someone changed a load of sprintf()
to snprintf() with the expected max size of the output
rather than using a bound for the output buffer.

IIRC at least one of the length is just plain wrong and
leads to valid output being truncated.

Using (say) 256 for all the snprint() would have been
more sensible.

	David

>   }
>   static DEVICE_ATTR_RO(cache_size);

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

