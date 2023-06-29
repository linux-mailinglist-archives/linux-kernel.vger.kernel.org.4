Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77511742C77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjF2Suh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:50:37 -0400
Received: from mail-bn1nam02on2084.outbound.protection.outlook.com ([40.107.212.84]:23470
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233019AbjF2Suf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:50:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIvaEt4qi8aAHU3DpSN+zRqZmxV32TyXbMamvqHpinEn17RfnGyWf+gCftBgE+3UxQxEx4yjGD66ZVlcxqJ7oX/ckM4C2+S6Arfi0ck80PQyf27DHBImQe4j9UcI4jYY3Mqq2YkU57t93HV6QJf+MdaGoitO0CXy1btvR5XcMWMx6K9687r+cMbbF5inEWbacmq2ZNh8+6znPE3Of3khKIrsZpfTnaGzdFaU3IqQ0T+tABKYydo76XxwccJiuEEulTpGUunVqV7twdTkPVo5ql1lO3BoKirDaLrqL9MeoSg8lGbXCtMrtYP4ewG5RdLWVYkychQLaV6h1nhXilbCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7s76AW4ShqaxEP3wTZltPIF21nHMVHMPwoy9wdzBLs=;
 b=Fa8kASJA9n9J/xC94SyoECq57AVSteefRHtvE5U7IaTBqgZ1Qrx4GNiUWLIMcEvc0xGMHUDq1N4hg0sis/6xqVxD2v+2fSlRWZrOInU0N4hA5PLLYjWhlak0kGHoSTyIOR29sYr9pvJXjSNIKU2j6HdgVTSQooPNIQ0V3reWyqAkiu0Ay0R2k9IkQEiE9g5Dm87cLjV90w3BTbHgQ8VDEYVIuIoXmLzypFVJVflnYJUoPefwnDa0H0SJ0KGlRFZFEvrobZPbQiIbylr8TqWIFVDa4IC/+zj8uOli1Gvrez8XX2C7jsUSjemmFl+1MtqHPnaZ2yNYHRnErvhdhiUBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7s76AW4ShqaxEP3wTZltPIF21nHMVHMPwoy9wdzBLs=;
 b=txaeCNuy5sDoa8D2BLJ+CHiLRo+0/XKSYP8SMGWHenOqfGh9C6BoAY4tizlY3AW0fNoHyg2JLgeyDpO/eNOvsjBVeklUTPc1Hqt/+yM0F62FmhMcIJ1Dcsjey6mdHCOjPFyoMLPyTLDS0xgh4TiU+yNqBZFhfRhmmJxbH1rErFlQmRSgPyEQSf4KXa1yimyKGrwEWD3dGoe7kRDaggULbyB8cpqfonR9QTyyV+IDWam04UpydlOMqXZqdXA9NM4zu9wAsuTvIF7jZbv5JKv/eyYuI7WK/8hSnlvqyfNv6aBIhzPIJdkyM6hBw8DLz0bf+bD1d5Zi9vJ5Th2Zt0an0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 18:50:33 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 18:50:33 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 1 XBox
References: <20230629172041.3771-1-hadess@hadess.net>
Date:   Thu, 29 Jun 2023 11:50:22 -0700
In-Reply-To: <20230629172041.3771-1-hadess@hadess.net> (Bastien Nocera's
        message of "Thu, 29 Jun 2023 19:20:27 +0200")
Message-ID: <87wmzm9k7l.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::13) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: d103358e-ffab-4d6d-c94c-08db78d1b7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJAJynyg6ZShRyjYPNW4wTz15lpljkJzvitfsOGRzhlptamOzsLj4DIi52GPm+xbG4kEhPmCfXUM/0NGIFmt9utlgwDsRd4PxKez+sYoBK3f3TV96Oq35ma0nhxx+Rduw7I9epMHS8p39lIF3oKBuN69fSyIqPpRxfQ2RVB/HnssuplvB3Fu3MTydsKogAB616/bziq2+z+1clEKJyXWAWW8KGEpUhDlU1IiEY6l1ChtmsK2bPSOBzA06eEzFvIfuP0/GDDosNsUZfEFIwZZu8CjAWSoiq6KhXofYut+IQ7Vrr/JeVsaJRUwH9iE0H8BxUS0xp2cGbJ0lLgvU8pgHmqDFbXxyi5yE2JvXGwkc/b3hbJpZ4On/w4CqkCkQqOTGYgiiaANtsoyfDpzYD/VKWEzbQHRfuEA/l42U9s4h3Vhipr9QGkZ0PEesjtGHhy9m1/cAKsycmaxW2qlw8wTe/q6GuPWoUN+fU3zhFS/N+S7Sdraz7PwMgOAcgIWGuQKWHpF3QwZp0E1sFQV28ZUt5WXiitUONhxgOWqC3DhalTJ15VNSbgsBuy+IS9+VXBv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(47620400004)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(6916009)(478600001)(36756003)(316002)(8936002)(8676002)(2906002)(6512007)(6666004)(54906003)(41300700001)(6486002)(186003)(6506007)(26005)(52230400001)(86362001)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7RIT7tiwsZIsEyHL6nOsEA+YFp721Ge17opDVoeVtmorQrLvQ6SRz97VYEQy?=
 =?us-ascii?Q?QqV9WXXkPDrO9nvVnm/A4EACXWbxN4L1KqSq4tzhectm1HT1q4Qs0yScx0bL?=
 =?us-ascii?Q?JNyz9cs+xeXs28n8yyEnGQTC1tdxJJ7xn8qoNQW7Fv8tBupzTAb57kYXO8xI?=
 =?us-ascii?Q?WB5N/X42K45nw04mcIKzc4gPkpT+oiLYEdYPrS7GV020cQ7SVs35n3Lnx61b?=
 =?us-ascii?Q?2e3EH+BF9q146/neT1yhrUEy/kAo96+ZEkFW8B/kNEofcB4duTijI46RVZ4w?=
 =?us-ascii?Q?iT2OVE753BJ0g5GhNj8RxN2AlkfuFwxvVRGUin7NhJ2L+H9NfqqCmDvbkogx?=
 =?us-ascii?Q?xtKyOYizq72D+4HC08/UAYx1r07wGv0Fk6Pvdwt1zhNis6P0tYioZYphhZoO?=
 =?us-ascii?Q?a8gdl+rm23P8dpe+3lbO9uGm0N+Ji6jyzTu+9mxgOpGMfYOeY+2mxg0zAOJW?=
 =?us-ascii?Q?z2RhPPXwYW+ZdacccYgR4tzaHtUILZc4mweRWkJYchA9uUd79LHu+Ll1EKki?=
 =?us-ascii?Q?p/7o8DgPRauzAvGtBsaD8d2y7P464TGdCnRBwozR2ge5HuFCIQ+SplwdMg5l?=
 =?us-ascii?Q?Fm8xCNcZYYprPockotRubo4LYiRMVc7Z9KKoVEnJOo6pu+Z2bDOe7eFomLsS?=
 =?us-ascii?Q?qdI8vD930HwVFeqyipIdgzzwQkBWECGKTFxMLDeYDOTs43dPgUsIlCns+kwX?=
 =?us-ascii?Q?NTQfAd2aF+7QtfbS7+GzDhn5izLjaOJb+Z1S3VShBxEblEW/Pj/DEOjkGMIX?=
 =?us-ascii?Q?YS2JCtyu/6fAKHKOZGuJdJ+NqXhyKkY2wJZpGQUWQuyzCMvA0IdMaYw4Ou87?=
 =?us-ascii?Q?E2a8UqEJNn6FDtx5MduZu1EvbpSdBMLLrs2umzV9KNz9jWj05q5lIV4jetzP?=
 =?us-ascii?Q?XX8WZmtNl89kVYIbi2KS+U4M8iZ8KApu/Kc7bLi4uXK8CdSugKaKz4SiFcnz?=
 =?us-ascii?Q?VImPO7D6X2Qbx+X8hAm20A6WYn4FK7+iVbMv/pmcAH/2YZ9JlnhQ90WT5QRH?=
 =?us-ascii?Q?bHsDaP2HRhcE33zfmRQTfJyFVQrxvpgUW+DPgtCR7Rhc2Ei8jg+fImOUmEO+?=
 =?us-ascii?Q?XCTLckdng3hhm5Gb0hy+JII0oOkFAu57mzYOMD4g3Sz9JxUP2MeHttp1/W1h?=
 =?us-ascii?Q?d4+Q3EqQwxOVjVTBtOIVMDu655wdBVC912l4YiylenjmQPgLPUkWWNTSsSd9?=
 =?us-ascii?Q?iuXEzEb5jsPra1mk1oSrv4bakhoThu8bM6f2zRrldC14Qfs/FRMEf1IWFNUf?=
 =?us-ascii?Q?boLppLhWzpZBFn3h/c0EhfST+W2CH+kXFcMWnsm0gGteAG7ttKTq5FkIxdxg?=
 =?us-ascii?Q?tJClX3HjSPKOL6qwQ5sETpWHktkwO7+z9LGAj/Qx8iLEhotW3sGxDGbtTdxd?=
 =?us-ascii?Q?aG3RN5VG7VDDNlwXgmdjUAPneEDl3t2wfr8rjJGIw02fTgRHTAW7OuDQOfXR?=
 =?us-ascii?Q?Q5P1Dea6w53AJvGpvxD49ZFvwtKHhApIpENyavyej7RgjB3SZVo3JWFETRum?=
 =?us-ascii?Q?EvhuD+u+dgvQdSmeO8ciR74cBUNepjrLuL3DXaTqKVLuo7dWswoRvw5AMvGc?=
 =?us-ascii?Q?CNWOz9R6a555qVbnf4GXElGg7efFT9EY6cXg68+nYbPZxsOI1JqFYECGAGQc?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d103358e-ffab-4d6d-c94c-08db78d1b7fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 18:50:33.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooeOErVs622xxXCbRw0Z8RxqNZ5OIAzXUmfLAvX0QXP7GbYECodpc8plvYa9I7AymY+bnDLsiLe1amJgrc4h3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun, 2023 19:20:27 +0200 Bastien Nocera <hadess@hadess.net> wrote:
> +static const struct hid_device_id steelseries_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1),
> +	  .driver_data = STEELSERIES_SRWS1 },
> +
> +	{ /* SteelSeries Arctis 1 Wireless for XBox */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, 0x12b6),

Shouldn't the USB device id be added to drivers/hid/hid-ids.h?

> +	.driver_data = STEELSERIES_ARCTIS_1 },
> +
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(hid, steelseries_srws1_devices);
> -
> -static struct hid_driver steelseries_srws1_driver = {
> -	.name = "steelseries_srws1",
> -	.id_table = steelseries_srws1_devices,
> -#if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
> -    (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
> -	.probe = steelseries_srws1_probe,
> -	.remove = steelseries_srws1_remove,
> -#endif
> -	.report_fixup = steelseries_srws1_report_fixup
> +MODULE_DEVICE_TABLE(hid, steelseries_devices);

Thanks,

Rahul Rameshbabu
