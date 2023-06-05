Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B97224E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjFELuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjFELuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:50:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FE9C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1SMSACg1GPbaEdmVgENIBUdTqskGTT5hcqOZ6kapPEIewlabUpTJV0CmIBGwY8yXSC0zqpKHSaeorLX9bEimc4AQ1C+oj8x0kjVFTe5NW2esx/kbsgNBz4ppNAfODs2xu1TejMuiWAl8DN2/7zj0dl4ryIaQbHUxQk0JO1qf/cGrp6K8ogEDttNNomJwUvHIbpIC+6Ga7FYW+0e1JwWNuiwokl1ioCqFtWBS7XGbhSh0KFPTA/CZBjobLyPPI3juzkngHKwMfm0v0wm5CsV76VxQ00P2g1bJBOTonJpETh9jan9ii+k0iH3rIw8wamfrpY4235ABYLfwxpQi8QV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNtO3MaoxvUXNMW4CxyYO8P5XLb4sEijyHoCHIvPN2s=;
 b=LUgBHLAP+crO/Gcko3jh9pv2xmZg0UfbEMuw4DGBlBeBr6thUHT2hH3f0XC2PT562WG0nJo3slH3kD3i326wb3rg4NQuP2J6dOwPulriW9FtEBm/+Ss+58kRO5RQq+ZNSqOU4kldrVnb98eV4jAX+ykFCcq0LBwlyNILrsQACGkOhlYJk5ueTuNYjHeELvmgvzF/RUPOW22rwYTmkfWG1L7ee18yoPmoJzTq7ExfbXNNONwj73l0YgDvTpMR6IQaHCMeqtXE1hqGz7GyMkeX4FCyk48vMaEbchglBJqiZMsYzNLhx2DY17KP9cCotdsLQzi6f5Mn/oZbXRZcy9bdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNtO3MaoxvUXNMW4CxyYO8P5XLb4sEijyHoCHIvPN2s=;
 b=gy7BDtEh4z+/8XG8/TDEOd4M0sTUxQq4++v1TrQso0zW7Ae2NPtxIvoTtrzVWWWdC9e3Ys/2v6ozVZWgYRfVMVDXgqTz0oVdmdIyCJ7eKnZdbW0MhjnETqrfq1n9Fzqd9wx87WwMq5xwWF3ih9yOW0Y94pVBdTQ5Fb0p/RT5N04=
Received: from CY4PR12MB1912.namprd12.prod.outlook.com (2603:10b6:903:11c::10)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 11:50:15 +0000
Received: from CY4PR12MB1912.namprd12.prod.outlook.com
 ([fe80::4576:e56b:c25b:e91d]) by CY4PR12MB1912.namprd12.prod.outlook.com
 ([fe80::4576:e56b:c25b:e91d%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 11:50:15 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v2] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Thread-Topic: [PATCH v2] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Thread-Index: AQHZjmvgsVD+1Ig7a0aQc3lL/cA0p69pv12AgBJYy0A=
Date:   Mon, 5 Jun 2023 11:50:14 +0000
Message-ID: <CY4PR12MB1912E437FC6295F65141A0FB8F4DA@CY4PR12MB1912.namprd12.prod.outlook.com>
References: <20230524181613.5351-1-abhijit.gangurde@amd.com>
 <2023052401-overact-unbend-5a68@gregkh>
In-Reply-To: <2023052401-overact-unbend-5a68@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b9cb70fe-70cb-4414-8b18-a60ae5d1dc2c;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-05T10:43:01Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR12MB1912:EE_|CY8PR12MB7265:EE_
x-ms-office365-filtering-correlation-id: 2acbfd69-40ba-45e5-2b47-08db65bb06cb
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: on56TQ4Dn87cK2jxv/0cps+WZVkeYrAOe9KIvH0moM01dYIWZ8rfkrWyGpJiHyDM0MlY8hFM/JEMn/MrwYSWrhdcv7MG2/6O5IxKI3t49Kqje/idOBBF9hNhfz+FW/FOCWQFUmo/2hW/FZi29MJxjVrM0bZjgDtqIezPa2kbjte7jHEHBGwR5JgI4Q1l5wRIhHvzmwEEHtrB9p8egZ0Rpxf9tbVR8u5Qse+gvTg1ZAGTeCyTuVQ7EenMbvY5N0aewduNs40QOdaGYBoyX6xXcIPhTJ0QkQzg/+FffychhtNr1peLqopy6r0yOe67qlVXmnlz5b50ZCGvqK30DgAjA/snkJUgTVe05aFEEUcG2IXGJYbfMjHIpK/q7WPf4GQiF8MogiKJUN7XSHQkg+WtE3UlaV25kgnOxGfdFchuXm3MltO8SmK9UtkdQpegug/WIwGjsUeM/qPh9Q73xwpymTAVn033RRj228D1DIYr+OP2MmCm+uB1urD2k0eQEOUTy71cdlbtHqusnnOS1k1rfgii1mFmW29UkCWah915Fx8prbAle8f5ppdZORVYgD1qOQDbhG0d8y4V+PDhXfaJ7/jtvSmWJVQtI2pk6tPuzj5plr3/WsiWcye5Uu6daiMa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1912.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(55016003)(54906003)(478600001)(8936002)(8676002)(4326008)(6916009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(122000001)(316002)(38100700002)(41300700001)(186003)(71200400001)(7696005)(9686003)(26005)(6506007)(33656002)(86362001)(5660300002)(52536014)(38070700005)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iOaEXNHiObQjkWHvySYaShqVeEh5K+qxfri0Z0yrY/KUlksmddl2KjiZE9RW?=
 =?us-ascii?Q?BMxCLggfJWXxuHjpxHBwamDV69JQwLlKuqBQh93MLNE7vm7soYWRD78YZuVg?=
 =?us-ascii?Q?DUvpXqvXpWj018nqk4/37ixz7l0df2eEb9lm9GScH+pr0zf8YuPltzDBYw2l?=
 =?us-ascii?Q?77cBdzihAxpbab1N7464HzV9ieOSbcwW0kXH5tdx0e4kV/RZ8rwEbomTSn5q?=
 =?us-ascii?Q?QlU0e1mubC71neIJ42Gu6SZnmWmisHfuEOI9bWIhuPhCQjK1a7K9K/+l0QAq?=
 =?us-ascii?Q?ZDNG3dPKGraypJ1V6GxvgdCozKYLiDppRTL1FFPWikPy2t/AWZS3N4EiC5zN?=
 =?us-ascii?Q?MkhGRsA/u07CVZhbUim8jZskmGO+IaL51ozoVnxNqkc5/o2LWzllrN3/50dX?=
 =?us-ascii?Q?626M4K5IKImMUvrF3Nzjqed6CgH4yn2rwMss1WBQc9WwkkmnKo6pg0J9JgY5?=
 =?us-ascii?Q?krHKICUPa83WVPdsY+sgON8Nt4JR2OsWWPVWD1BQ65lpUaWFQ4Jqvp9HosGE?=
 =?us-ascii?Q?uxEA8OVZ50Ht8HW1D4y4W9TJJ0jqSEQ3zEEBnLz2Mq9WIQ+itd1r8+1mNzA8?=
 =?us-ascii?Q?+d8cbMi+4oODeP4lZwzzX2bmh4eA0xQ7hboFq8GuI+NgDxxFJi7QQL1Oa39c?=
 =?us-ascii?Q?A83wDz4CP+nEYzVnslxBxG8eFRwpFJghN9pe9QptOG4Rs+EhvP/143dL2zb+?=
 =?us-ascii?Q?wh1zq5isOi813ZYrY8/z7BIbEhyEPKQq+nFst2Sw2BD+qTR4KZ5NC4qjBi84?=
 =?us-ascii?Q?QMcxFixLK28HPx8RRCYAzCeUsheGy+PYaIUi2W5149LlEJqjplbM+JR/ml5H?=
 =?us-ascii?Q?QO9nvX9FrxElTfqPbLvS3MzqvmcC34PkkqFG14WBOeDa2eufnWtH5z6a9EFB?=
 =?us-ascii?Q?7g9F+qC3q4i6cUzgcjKn+eyD4/hscvpaHPLIBhYj8nPUFgp0a9zgSfXAZPxQ?=
 =?us-ascii?Q?BMfujztZmGCy+GUENReM0g16kvLoyRMQoFDThH347hIoM4C5uEkXD8+56WM7?=
 =?us-ascii?Q?Wp+AvZoctQm2rQrMgacsitF87AGJRG8MEl/aCWrNLcBu/GOVpgk1WVM/i9WT?=
 =?us-ascii?Q?AvNsdsd4syhL653QU7mgoGISViH+zerhRfHIbpqg7GTkrC59iLIpAOqTmRoK?=
 =?us-ascii?Q?fqfE/PcpyIH0DhxAmmU48/HdegyJ9/oHt+4aLnKwqu19d4TbT5JCeMi11Ger?=
 =?us-ascii?Q?NdbazCa3WaArNUT6cNVBQ2JB9URcD9EwYI2GthqZJPpMhvzUIv5AkDwU8RfY?=
 =?us-ascii?Q?KGryAOZ6Nn7Kv0vDz+penY3a9zcLni4bgqS2CpJ/lA2Y5FzI4/j+VJTcZIDN?=
 =?us-ascii?Q?ipUDWE94h7+1poIrGoiF/DJUhykbQOSix0dBKVUlLXq2jPf/DCP7kK7aqiYA?=
 =?us-ascii?Q?Qqlh5zGlLyPbvsmoPcQGY3Nob6U/kGSfKDixTiA+2RqO2BU3zCgbk1b/ruZ2?=
 =?us-ascii?Q?40zuib5+hIbhQXg22YGF67YomWUneXrhYIkWv6nVvCGiJ73SBrngECcybezg?=
 =?us-ascii?Q?Djjn4Bi4QSi2uY1fG9tAS7xdcDcQEy2gscDATKv6zG/WI9O/LYCNVyY2vMN5?=
 =?us-ascii?Q?dM1oOaMpRB50H7/sCTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1912.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acbfd69-40ba-45e5-2b47-08db65bb06cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 11:50:14.9794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFCmmU8E9DaXHmcUUkJvuSfDrCL7lMHRYDzqPr1cHx+uzl/rAbFEatchy3jVClhLwPv9SBGHiGf2h+TAnTenCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

>
>
> On Wed, May 24, 2023 at 11:46:13PM +0530, Abhijit Gangurde wrote:
> > MCDI_LOGGING is too generic considering other MCDI users
> > SFC_MCDI_LOGGING and SFC_SIENA_MCDI_LOGGING. Rename it to
> > CDX_MCDI_LOGGING makes it more domain specific.
> >
> > Also, Move CONFIG_CDX_MCDI_LOGGING to header file
> > and make logging variable as a configurable sysfs parameter.
>
> No, sorry, that is not allowed.  Just use the normal dynamic debugging
> in the kernel like everyone else uses.
>
> Also you didn't document your new sysfs file, which would have not
> allowed me to take this no matter what.

I'll drop the sysfs changes and send v3 patch for renaming of the macro
so it can be on the rc.
Also, will look onto it to be supported by dynamic debugging.

Thanks,
Abhijit
