Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F8C6E2307
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjDNMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjDNMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:20:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91FFB468
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbFlVxrEwzDK1oy0CWZ5OOBu1l+V1mLIfmPXk9PmlhAb/J1BJ+w1dk3h6DQ1MQsuEhNdCduzOZz3EpMG4Z/8sFv/J90PKc4vRqe85qnGyucEodgtguhdk5CkpTBF7uARMHtjcC3OKbMTW0m94Kszkent4bY2Balu6Qn05VuYh5Fsvm126jlkoA3CAA/hid6HjWVnvTYfSO8JPGPY/dBbiM2FY4kDn7GhNMvSMTrfdZf3QpZK6+8IEVuMIKnePwjSXERIkZiMK1R48wESk05f0OULCy0/kKu1CVwakYBemT4/TyoC178tCYmF33SvkaavYxqvZQq2PC7ai8w2kSIr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvWRb2t90AfLkhAN1rWMrwqJ8QrnNsulyAcs2vXbux8=;
 b=PytGFPf91FiDHNTut4FcmumPZ/2m/BLAB3GBsB+uagCbTXl0ZpAs3T2mWklDanwRnayVhfmi61bx9sj66gzhkifXS4bkL8EPXR3Avep3u8HI9rxIl/gREw7WXhx2BCxhHbwtBR84FBREIsL31gj0TlbKRlL1vSaItttLVWYOsCEKfZl9lSdsMaD+zNrPyyZ/raQ6Ps0yWL31Z+wUeGOLQZEraBQ0XRhWU7p8RKp19k1oFPya5ifHcZwBoR55dMVECfJ6NEfTmjmTjNPCeDNYY4iodZ7+UQVKFziozPF0XY1VkIZVkeiB1wxPt84GIveZbh3cAQn6U2FZ1AIFP1rHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvWRb2t90AfLkhAN1rWMrwqJ8QrnNsulyAcs2vXbux8=;
 b=J7992S2EpSaKerkH/YqUhTTUsjtS0gxMCZNhs3UTL+TVTzQnIgI10exANMkjDB7sly4wMWFJxKg9SlCbepFf+13oy+CFWM4W3GwqBMnLp2f/QDFNz6ij1lRkys67aCc5sHYTIkh6+BWeGUyo/MJIxU5+Hy3acsM7isRV/jW1x1Q=
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 12:20:05 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::4e4f:3a93:b7bd:489c%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 12:20:04 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cdx: Allow build with COMPILE_TEST
Thread-Topic: [PATCH] cdx: Allow build with COMPILE_TEST
Thread-Index: AQHZbWsLeUOfu6EsB0G0mjAB9ygYUK8qub5g
Date:   Fri, 14 Apr 2023 12:20:04 +0000
Message-ID: <CH3PR12MB8308847ECF9C51FF596BF38DE8999@CH3PR12MB8308.namprd12.prod.outlook.com>
References: <20230412181658.529415-1-alex.williamson@redhat.com>
In-Reply-To: <20230412181658.529415-1-alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=c225fb1a-b48f-448b-b52e-5fef192ed455;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-04-14T12:11:56Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8308:EE_|MN2PR12MB4407:EE_
x-ms-office365-filtering-correlation-id: d44f1301-28db-4166-8d60-08db3ce293fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mC2QimYVoqVgwaIUALVvmtUnykw5cmUytUUbPSZkwWEbVB848CQNnF88MgOhjudkjX3twX3KmOp3uWGP5wRGJ5KPPvqH/PsGWhhvuLgwZWjikFHgYH0Rod6mR2jMrBA4dpfYJdTREWskBgc8T24lHWjvbdU2eLPhPoS2X9eiuJl5XcrsJ+qS6okE16Qozbh1VlLNj6TlOjHTIoJWHPGWJWl0P0EqZm3tngMT+8xNYkW/AWg3Ri9DJLOFZd//1I6UQZi12/FlzzIlX/XNe3oJui11YdppRjn7StU5ntqH+P8xjxRWCmBnf5psf4cU8Oza9PqZEeV6G4K8hlyNOgoChvOLfuGsCNZETDIJBJg8Bm4eTT/cpI58Pr78sgNuRolHXppAHahcfLON/ESfv6eJu+vYsTeZ4m7jqor8wKKyGR+ia0MuNV60wR8bvPQV1IcKpk5ffRSQz/JsmxRAA1oyaWvYGpBJTKZEEQ7LBTeUCzMXyGtmBugfTl8QE2VcyOtqpJe0EnfsEV3KqBHJl16AVPBxRfzzbVvcXIhy9xLgAAb0SS2hlxEgW7c1p4q4sPs+JNchcNuXGkOhFbAClwIZmAuEQaA8gPlR6PgCWzWysfqpZYAJy/8IiZ07aBpvZ+3V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(2906002)(8676002)(76116006)(8936002)(5660300002)(52536014)(478600001)(41300700001)(33656002)(316002)(64756008)(66946007)(66476007)(83380400001)(66446008)(66556008)(55016003)(6636002)(110136005)(4326008)(38070700005)(7696005)(186003)(38100700002)(86362001)(6506007)(9686003)(122000001)(53546011)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?reOon68GQOCoGcavtvM7qHKgYMc/uY1jQDZwszthfrSYT3bl2p1wA2vhq72F?=
 =?us-ascii?Q?h3s4Dwc/31uk6oldimhqPR234rqAIFNX0gYHxbTL7YVBDcD2p97lqVAgYWjH?=
 =?us-ascii?Q?9a6txZEzHm6aBBfLqdfX/jFMRfXbDVLhy9z9vN8wCe0bPUgmGqUNPCytDjJg?=
 =?us-ascii?Q?vXiS6PSYlHOrtMIZDGzvxU3jXIPc7ZEkkn1r5I50k4j0YO4H9fboRy5Pi/Q+?=
 =?us-ascii?Q?sT63G4D9VaL8pRNnlEhh7DcPpJ3aRnlGbTvMjLTSNHBzUg4dRQ+YVdXcb/IU?=
 =?us-ascii?Q?DaViU2sRnPE3u4kRuuuJtpkUpKtSVad7n05g0J6QfdSgVBxI7sZlezLyeMqH?=
 =?us-ascii?Q?BXIAcEMeVW0J1JorcFvILS/JHUhtsrpG+g9loRG6IB6nipdkwRQ7Qk84SNLU?=
 =?us-ascii?Q?Pvr5C3aVYUv93Ofl0wlxaDs3n2krfcINP6F7PpBBGR3NEnqwoPPwGGt2Deez?=
 =?us-ascii?Q?mqPxqr9Nfcg9d76y6LhTOmc5YvqV3PeRAyIxDQftGgu+64527OWXyN07l6YS?=
 =?us-ascii?Q?gsgbtFXYp03mi4WcYdrOhJR7TXluy6qyOKnV+Wvfo1Lju98Xx05emmW60sGu?=
 =?us-ascii?Q?71X8W3bD9l3ALR8GTcN0EHh3Z1iD2OP2JgG5tV45avBIgQCGkqnplj/Lr8K7?=
 =?us-ascii?Q?U8znvoScLHXboYkL40RHs1f8s5TFHMsWoiAyriMiGiYIPsTuLq6fJrfbDT5E?=
 =?us-ascii?Q?hALUAHsEFF/5sDt72f73+YDgL0QfxYoOHOdnnpr89AuHGhRIegO5FKnNC9Hl?=
 =?us-ascii?Q?s4M23jqLXb72ZJo6PYhONhqkXsZbxZESRjVc0FaNJLihSChjplMOpTn305Oe?=
 =?us-ascii?Q?nYhavb7pbJHHppGKrhDCZWy52gYI4dIzpjbPdmYLCBx18LZpBwXd7zFH6I3/?=
 =?us-ascii?Q?ZomG/EAwC0Y/ivzYTY+FgiPuVPF6cTputgbCIB4tJNKs7G+F26WuIhk/gmai?=
 =?us-ascii?Q?hkezuD8VJhtCb23dw4NfNNW7lJTw+WohGPa84reyiB57zmW+YDmYBU7SWzMt?=
 =?us-ascii?Q?lvjSa1pxH+MP4zvBasBZnscY4m5pFp5WdsV/aWJIK4puFDo+RCghqRKI7Fwt?=
 =?us-ascii?Q?s180SwfJLmwFRIZUn/wJsij8D7m7V+CU2vEXOhSuzW/aUdC3SsvgPMK1UUof?=
 =?us-ascii?Q?Bk2H43c1VwcHJ2B1Ez9OfRWjbwGelrhIUnMwqzWFnqnhAiCXopPLUXTz10Kk?=
 =?us-ascii?Q?GKOSlYac77C+LhdQzM9KBszLgjjYEzkrxdatgxpogyCnyRxRfMUuxSZIIC45?=
 =?us-ascii?Q?uLQ0WwiuO3zZ4N7oAt+CW+YiM3TINgT2b7rMib9iS0RQ4OCQYBNi1cX6f3t2?=
 =?us-ascii?Q?wLx+cVFblTevN8CIfUo7hvrVmErLRpIZqC18eVD7g/3Ao8h2GDkVCq7RemBq?=
 =?us-ascii?Q?j7HobsMujPol0vpq0/niahMJbuVMVUxpDpy/98IMdsDYy+KvuFREMnJJ27Sr?=
 =?us-ascii?Q?DO8fErM3A+YWPc2NQq9Z8zIo9lD68hqVnTYNObLmb3qs0T9kGXlR7djGg6SO?=
 =?us-ascii?Q?2wDGMFsU6mC4IeYvixAV4IYQgqt2s+28jXXh262HZTgf415nbfFCXRHzxXXq?=
 =?us-ascii?Q?EHHngPPm7dx/HSYeEvWT7IWXOCjtMLnZPExIpThuWHE5QAD0HGYPthHvAVmo?=
 =?us-ascii?Q?XEmyCrV4jS0Ma91d16u7DfQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44f1301-28db-4166-8d60-08db3ce293fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 12:20:04.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrVN5cMpoNlJt3nOtNvBClFWSRiaphDI4YfigVHOSYyJ2t/535WCnUAgxQq8G28m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, April 12, 2023 11:47 PM
> To: Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>
> Cc: linux-kernel@vger.kernel.org; alex.williamson@redhat.com
> Subject: [PATCH] cdx: Allow build with COMPILE_TEST
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> Increase compile test coverage.
>=20
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/cdx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
> index a08958485e31..8e3cca77ec64 100644
> --- a/drivers/cdx/Kconfig
> +++ b/drivers/cdx/Kconfig
> @@ -7,7 +7,7 @@
>=20
>  config CDX_BUS
>         bool "CDX Bus driver"
> -       depends on OF && ARM64
> +       depends on OF && (ARM64 || COMPILE_TEST)

Hi Alex,

There is work in progress on MSI for CDX bus which is dependent on
ARM64. So, the COMPILE_TEST would break once the MSI changes are
added. Is there any other alternative by which this can be enabled?

Thanks,
Nipun

>         help
>           Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>           exposes Fabric devices which uses composable DMA IP to the
> --
> 2.39.2

