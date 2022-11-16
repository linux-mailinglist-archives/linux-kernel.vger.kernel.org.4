Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E9D62CDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiKPWkU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Nov 2022 17:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKPWkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:40:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439FB7E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:40:13 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-43-QmRQHnZtPD-f-gfapKz2sw-1; Wed, 16 Nov 2022 22:40:10 +0000
X-MC-Unique: QmRQHnZtPD-f-gfapKz2sw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 16 Nov
 2022 22:40:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Wed, 16 Nov 2022 22:40:09 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>
CC:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] scsi: Fix get_user() in call sg_scsi_ioctl()
Thread-Topic: [PATCH 1/2] scsi: Fix get_user() in call sg_scsi_ioctl()
Thread-Index: AQHY+VSNJhar89N50E24WEBG2HeXiK5CJcRg
Date:   Wed, 16 Nov 2022 22:40:09 +0000
Message-ID: <9d59ec367e0445028775d304bcf64704@AcuMS.aculab.com>
References: <20221115155802.p3vjnk7eqqcyskt3@box.shutemov.name>
 <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
 <20221116004353.15052-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20221116004353.15052-2-kirill.shutemov@linux.intel.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill A. Shutemov
> Sent: 16 November 2022 00:44
> 
> get_user() expects the pointer to be pointer-to-simple-variable type,
> but sic->data is array of 'unsigned char'. It violates get_user()
> contracts.
> 
> Cast it explicitly to 'unsigned char __user *'. It matches current
> behaviour.
> 
> This is preparation for fixing sparse warnings caused by Linear Address
> Masking patchset.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> ---
>  drivers/scsi/scsi_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
> index 2d20da55fb64..72b3ab5137b8 100644
> --- a/drivers/scsi/scsi_ioctl.c
> +++ b/drivers/scsi/scsi_ioctl.c
> @@ -519,7 +519,7 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
>  		return -EFAULT;
>  	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
>  		return -EINVAL;
> -	if (get_user(opcode, sic->data))
> +	if (get_user(opcode, (unsigned char __user *)sic->data))

Using &sic->data[0] should work and is much nicer than the cast.

	David

>  		return -EFAULT;
> 
>  	bytes = max(in_len, out_len);
> --
> 2.38.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

