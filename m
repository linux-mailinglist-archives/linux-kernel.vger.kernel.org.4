Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545726BECC2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCQPSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCQPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:18:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11909298EC;
        Fri, 17 Mar 2023 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679066289; x=1710602289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gk71JEOi4FAYdh6fRRydoATdOQaiPRSPkGDJN9O3Ga8=;
  b=vbi/dRMEBNTFpP3qsdh24rxadi+A923tT+kfgDMPOSUpKN6bC6bVwp0w
   YyfQQ9I1hGBknLLhE0WyTYc+aHifnMSvj78N6qoZWEi2UQdZMLw++xScJ
   0/nUOzEnM/TsEv/mKYZNQ9irELC5WI+qkFs9sVto2vUDuT8Wob9hc3J0W
   BHi8tgsENc4p88ZKbBM+2itZis6t3QeViUtSUdM4yLmdGV2dgn5qWH6e2
   h1HEsL55rts4y/FTnMDwSJmYC4tjDQmUZLi0BZauCgR7FOGUiDzko+GWV
   Inr66uzp1et46r6jhZBu3r0Zzxys4JKU17o2rIP7KGPZVQnj5JHyMM86J
   g==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673938800"; 
   d="scan'208";a="205233007"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Mar 2023 08:18:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 08:18:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 08:18:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8Rr/fZ8M7W49b0yZ8KoKQQbpUoGBrkJR4w1CB9z1JM1mES5Zw2xI0SzZpLh2hg6ovdQuZuOG4uNZngvdUSmJaRqdkj7Ehvwzvr0Tbc48sFrsdQin434jZC3QJP738WHw1X0cLdgHtWUmxY8PGutukG87uWd3rCKm6mQfUuOVJvFfszVeX404UiBMCduFAqmiTp3VpcFMr/fcA7kmn4wbkKVcb+pcSEzAtKWBLgUhzdwCxgFn2kRKi50X4DeDFWg6bYygglQWp2I3+EhbHEMC9oa3AOvL1CycTuumbMON4ZlZ1vfvdNwoHU9JlyJLQPBf9EYlE2QflEw4Wl5ZX3cvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h57uJsEgfHRJPOgBehBBE5nbC2XJ6g6eHkbBHKmV46U=;
 b=iZrQ+M6oogkyppoU0P3/egu2xYp5yN0HYlvLBuIFvnfmZna9xHi+vLp4cHPSDM/VEdUpfDBNnsGhj6lFc/HQVVD79fjKSFFGEqdBqYKHqqVvvUA6sorTJ3XdupaSTFVe6EWbRzhDjs07oQZRswWGXGeUJsuq4ZsQF4CjxW3FTljOX9nZ+4wDA1+G9XA4yD35SDnFHw6FaRz9WJmBcy8viYJfa9OCoBwosyrAlenbotZNiYz3ks/Q7liOyowDLStvoe8MWPz3mx23XBqXrnBxdm2F/OTOwrv72W1FNwd7V4MTvhBLXN0XzjsPlDuTROIqng7CagqHbKVKe+8nVO0fsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h57uJsEgfHRJPOgBehBBE5nbC2XJ6g6eHkbBHKmV46U=;
 b=odR8uPIoIOKUL2b7eq9RxQCNi1uPNoiSQ9oM6K0x2rC/7gKQjocYhYoBdoIqgBvF+xisMjbnwCe5nG55RdhG8RQrnBxsPDplrAe3iMf5jjeMD48E0Wbniz6730Bfg4KhXBMfbdIaepRFK7RoXFH7SA9eCJnlLNyZ9/1BlEem5Kg=
Received: from CY4PR11MB1238.namprd11.prod.outlook.com (2603:10b6:903:2f::17)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 15:18:05 +0000
Received: from CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::d753:5f87:f63b:3a56]) by CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::d753:5f87:f63b:3a56%11]) with mapi id 15.20.6178.033; Fri, 17 Mar
 2023 15:18:05 +0000
From:   <Don.Brace@microchip.com>
To:     <jiapeng.chong@linux.alibaba.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <storagedev@microchip.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <abaci@linux.alibaba.com>
Subject: RE: [PATCH] scsi: hpsa: Remove the unused variable transMethod
Thread-Topic: [PATCH] scsi: hpsa: Remove the unused variable transMethod
Thread-Index: AQHZWJRo6BZ36MhljE2Z9r7NjO3PNq7/D2Sw
Date:   Fri, 17 Mar 2023 15:18:05 +0000
Message-ID: <CY4PR11MB12384AA421B9CE94FBC8A5F0E1BD9@CY4PR11MB1238.namprd11.prod.outlook.com>
References: <20230317054940.86685-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230317054940.86685-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1238:EE_|DS7PR11MB6175:EE_
x-ms-office365-filtering-correlation-id: a738aeae-dacb-40da-9fb1-08db26faceb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lG66zWngCKRARJ2xRwe1aDzn45G7ObdTqWqucp/yiYcPpWOBXuVXtuzDgmeBl7070ob3NYIUvB6YAYwe1l/WDkQSRSt3veUAJ1cbUjV8+GjGKjjYsB8298Oy0az+g1zgIPIQ3HXhRnuGThSeg6W1pDFAbqPKrCHvAE3TcNrlPyvp0m3nQ0LJ+DIw58ezHa/Pa7gOAW1sIoT67PxImaB53fiwzHxHuFBT9tJHgZR7aLDb/UlN8oi2HER03HNH/ezpCvpQVcwo5rM7aqpLsuwXQ61CiHVAJnwIoHwRNdoFp3H7HYBgRIhAeciJw9ZZbwVdeu7kwjPVGgHQbQC9Gh3cizm++Afose+e8g1wHL6ksiJWG+yM2gXhTLYUtIcINt28HBqpuvQIYdnBfs6PabNQ1g24s8dnzV3WeCftF6qmEj7EolOyrZEOQigKYGGBpM5edkG4z9t3Rk5xeVdaZIWpdxD5Dny/qiaHtK9YX40nCfCueC18aco7nRO0nPe+7OUn5auAdAd2NvG0B/gP4SDaXd4k3oAGgdz7HeH0QGFfiBHfgvhOc/HDIPLfTaY7Jj6HC3PzvayEGDOnY62lbGjGwSrS8EOKheInjY7Llz8co1iS9FrlKBaTQc5ayUv05gD0xn9ML8sRFDwZDoVy3g3kZ1chSpyAg2KtyKgSuzNQq8dLLjwn6kMsTTGCw8zjpsk1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199018)(478600001)(64756008)(86362001)(66476007)(186003)(966005)(76116006)(66556008)(4326008)(66946007)(66446008)(8676002)(5660300002)(9686003)(26005)(52536014)(83380400001)(8936002)(6506007)(7696005)(33656002)(71200400001)(6916009)(316002)(54906003)(41300700001)(38070700005)(55016003)(122000001)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R3hXBjm9Bo3HspE+pXTTD4r5nmUc7IG3rPxF8QuB8mhEj23yQzuV5wrnZL89?=
 =?us-ascii?Q?AU1Fah34Vn4qt+asd6kmTmgiw8Bi6x1Hz9ImPL1Gwpol9HLqR5bZldPowkZu?=
 =?us-ascii?Q?N12vM2GN9/LmjvFjG97Nz808WJgCAKxtUMjvwGBP7FtmyAOdM8GY1xmRWByE?=
 =?us-ascii?Q?9ej42RyBgrLBTjtJBMFg+Qvekp5bDUdsU0kear1eLl+oDtX8ok1vFR2esYyh?=
 =?us-ascii?Q?aE/cTP+Uy7YUFDVoYyaJlTmTPWr76FGH1ar9lxKosHrZhO4UabIFtfbEebGw?=
 =?us-ascii?Q?2xDtXsV0eBzcAssBW+Ytj2DmbMLm/DqxATMUPjXoFKX8dUSOlgt6JR8/mQhY?=
 =?us-ascii?Q?8IBUoS8KMiQ6tWIyuMXkWO3AvQrUBzqEn5F5wyIG1zSSUob5JF2RJDZm+Tsb?=
 =?us-ascii?Q?/D9QvrVup2UpS11d22tb0rv9okPKOvm1pHCk/mDUrckK8HvFwGdGir5J6TSb?=
 =?us-ascii?Q?QeyXXXWzU330TCq7S03kROwTxm9lT1pnk68+wmncIGZPlg83gJinycxJWFZl?=
 =?us-ascii?Q?+sV51GFafnQWirV3P/q+Bkl+r6DrB524z7uFMZsiVABHCJ9VEQvKzO/c4xOA?=
 =?us-ascii?Q?Fe6NMjQxo0c8nlhGfnq0nr0vG/ZHxCQuTfjWo9UvWV8NJGsc7bpXbCLi20gJ?=
 =?us-ascii?Q?W6D3WqLtk5IM37mpEp7+LVRKQWN/1e+QFtc4zCOc/SfVI4+KnAZt6jyzbk6j?=
 =?us-ascii?Q?NDqAGo9CC+oehM2FlXwHxyZ/zavxl0bPqvaRIrKmXa1a5zSzatzpOVESQX5W?=
 =?us-ascii?Q?g6Qx5Re3N8el+FpYk+xwVmYvqLD1hif6HIMxG/95nLLUIfWrw+BKA5kBXFbp?=
 =?us-ascii?Q?dgSUWK1lJhayv67w2/NTSLqEeiRU7Q9bFb5Jwd8pUmn+837v0yI7kocf0XYe?=
 =?us-ascii?Q?QaxDlSOsd5Ra4PRslWDEqGcsmZeB5GBKDu7zMhzrPs6pZ88BS80MGNVwhXjr?=
 =?us-ascii?Q?PLq6l8xIURJ6+SlkKsmIX+9n1nc9iXN+bRA93UPRXGLoVGvj3XGs3CBNFHWQ?=
 =?us-ascii?Q?xkLz7ZIzEIba5BcjGWIGnOVDz4aMzuTm5+a9U7G0cKdfSodvNQUUW1O/s2rL?=
 =?us-ascii?Q?GOmzZVT7QN8DSLRG3BF8mzlJP1nin/xEm5ZbBM1LOQ2YrBAfTBrCClTd5iah?=
 =?us-ascii?Q?OBNzzGE2zcG6LnIstO4JJ0S3EJeCCbMO0KrKpT6BYzrDyuGEAuSNiMWOpv+t?=
 =?us-ascii?Q?fd19hOXDyoQ7Yhqm6sCiDnpP9r0yKz6qoULPN/xvsxGjCnKnnjmRNTGtNXsd?=
 =?us-ascii?Q?g+6ANI+APb0dsE7XCt01mIx5D90Udy8RQt/2MsJ3aIv/b2HrPHqfcfnSfYkC?=
 =?us-ascii?Q?rDCvYsHhd/gffj2MiKkdE8RgBuhjZm1u/6O6zS+wU0dYIH/t3/ng1F6wgbPR?=
 =?us-ascii?Q?akf7pTzkwMMV7Z+EJ5aM8AZZoRvmNvGLO8SUb9oET8OCmEXcS0ytApsmrjH5?=
 =?us-ascii?Q?ijSdKsVXKLzAuuPQgjEZ7eYybqI7PA5YUPk32U47OCmgOINJcyewhjfqIP/w?=
 =?us-ascii?Q?di/jjZnMJzM3r67s1kjXVqnUbYGNgFBz+HkM0hmj2eMzgDW3e/tGmgAv0jwR?=
 =?us-ascii?Q?rZ23RgZZ3/8+Quc12o+/oULGbU7qJk4yH6Ngw6de?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a738aeae-dacb-40da-9fb1-08db26faceb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 15:18:05.4393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYupKwFHbNLb204lwHxrdDmY40Vm9LbKm9hS39crER9CpE/EPoDB3KATjMR/QKBJDWBInk3Osx74Hnox9xThvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Jiapeng Chong [mailto:jiapeng.chong@linux.alibaba.com]=20
Subject: [PATCH] scsi: hpsa: Remove the unused variable transMethod

Variable transMethod is not effectively used, so delete it.

drivers/scsi/hpsa.c:9478:16: warning: variable 'transMethod' set but not us=
ed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4554
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: Don Brace <don.brace@microchip.com>
Thanks for your patch.

---
 drivers/scsi/hpsa.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c index fec7e17747f7..=
2f2b46a95102 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -9475,8 +9475,6 @@ static void hpsa_free_performant_mode(struct ctlr_inf=
o *h)  static int hpsa_put_ctlr_into_performant_mode(struct ctlr_info *h)  =
{
        u32 trans_support;
-       unsigned long transMethod =3D CFGTBL_Trans_Performant |
-                                       CFGTBL_Trans_use_short_tags;
        int i, rc;

        if (hpsa_simple_mode)
@@ -9488,14 +9486,10 @@ static int hpsa_put_ctlr_into_performant_mode(struc=
t ctlr_info *h)

        /* Check for I/O accelerator mode support */
        if (trans_support & CFGTBL_Trans_io_accel1) {
-               transMethod |=3D CFGTBL_Trans_io_accel1 |
-                               CFGTBL_Trans_enable_directed_msix;
                rc =3D hpsa_alloc_ioaccel1_cmd_and_bft(h);
                if (rc)
                        return rc;
        } else if (trans_support & CFGTBL_Trans_io_accel2) {
-               transMethod |=3D CFGTBL_Trans_io_accel2 |
-                               CFGTBL_Trans_enable_directed_msix;
                rc =3D hpsa_alloc_ioaccel2_cmd_and_bft(h);
                if (rc)
                        return rc;
--
2.20.1.7.g153144c

