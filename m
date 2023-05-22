Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75A70B5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjEVHH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjEVHHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:07:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705CD10CB;
        Mon, 22 May 2023 00:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY43+Tp5qq//nwUp92ZL3vzOfDwdZ+CX5f85BmYkrRJNyUp73V06gxeeezUL2H50pIQDao3YZNEeqi/nT08VsZ+ySHUDzcDRy7Ov88DW1bo9fB1sSAx0UlSk8RkxgRssg/iedJKuPkr+5BEaiyf8PoQ3SjXCssJpYeU22WtucPPL7q93I/B63KtmsxT7qKNEArCCj8q/W1QLEXKXJ8LRHM/NF9MWFnwhtQu8F38AVcub2fcNMc6bAbZbUNjQz0uCirQn5vgGAkK2tlqWCtFh3rWgY4koo+4u+5Igk31m1IOC2hJJwXDVIVIDepFPTYxCX+WPP4jRIr/edf8WGsaFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzjO9/kIB9FkgIDZY6DNzHAJ507lj5AobWXY/HNoy38=;
 b=KrTCXMbKkOwb163BFe+dLPq8RP1WdvTmvLOKPrO5WkxIo74SpkniGNcl8KegXEzXOCxJplGB7DYHMSN1eeSU5ccFDWEB7oNNZKIoP6fH5ZrUViK0kXKVgWhtL74lg71RiiZzaqxozuP95lS5XDdVa2cCSz4ucLXOse0r/ia+Ri5MA7k95TenBvGaH/7gGbDhmFYoDOT3YG9tAh5Pp82o+NqXkEkjCcKXrrnCwCnxTJwobSt4PS3iFyk+4cgZ+Yjn8KmjIq4+lusp/DKUN9iGy0EJaHR5BYm881x0zowYYpX38O5NkOh2ivjsyGDMH9mGqoqbEVCaryGDveZekEY+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzjO9/kIB9FkgIDZY6DNzHAJ507lj5AobWXY/HNoy38=;
 b=u8BG3BMCtJUCzL6c6H5Y5NRXvYSKHbsz1DSP1wo15qNs6AHoxPFyJMZRFrI80vMyHiNSiEzX0EnE9mCtz+1/DIf/mPSI2ZgY+UPz4qCQEcGCugpZvvjIZX5651zMzprLbMawlAF64jKge9Wjw/TBLZvICvGcIaji+9Y9OSt3tm4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 07:04:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 07:04:45 +0000
From:   "Zhang, Hawking" <Hawking.Zhang@amd.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the amdgpu tree
Thread-Topic: linux-next: build failure after merge of the amdgpu tree
Thread-Index: AQHZjHse8j48Fll3ZEiM78mpmdLVzq9l3dWw
Date:   Mon, 22 May 2023 07:04:44 +0000
Message-ID: <BN9PR12MB5257722115CE287BC47679EBFC439@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230522170031.5fb87a64@canb.auug.org.au>
In-Reply-To: <20230522170031.5fb87a64@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-22T07:04:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c6ed0846-ab9f-4cc8-bb33-24c027934eac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5311:EE_
x-ms-office365-filtering-correlation-id: 58bef7be-d9da-41f0-424a-08db5a92d2bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MyB/eehl++3gVo7Fr7zRdZmOr/+drl46uY9BVt9/AQWW+9PXalJRNCqsGN+/Dss9MgfCyiRfaxaT2ZW6cgwtk3pzNeYITk4m8t8BXs9DE8narR/QsCHa7m+RbRCKgIVmyeJSFymQwffopK612Kk1PoRc7pMWHP0623Lk9mC2p3bbwkw7XVtcZmHIL3IwEed4LPqgxZ9kFRToBVZnN17p+dn/Hn+BEUcTCIvnI+2a4/yZYXm4bdF9YVcU4l5z2DZqkkSeBSdYh+X6Kzh5qbBxpetIBv8j28oGUk+kCmp/G7tYmFhLxkRLd3fQsSph0BskhCDcn7YTaVbgPqAkl2mUYqRh7h+m3ClCFe/AcUs8cJlTx8E7QBk7rh/nYCgb8I9KFlqA2ACHpzjrYGhLEb7pSPZoSDW+x100EGmJMLfPPeqAiDYg9hAD3WKknMO22ZdIGe1V7zP74U68iwpp6sX+btbg8+FIqNafykadtx8gbP8FPeRfRQATF060IJ1MwjWoyh6SHHC/yDch9CoqAn4ydSbLe0A7c2hNuxeMwDRSJEimt83Y1ZC5frcXyDKVv+Z/ct+QsR8N0AnpHmOc/sf1iqwzCHlDt3jyCc9XRDdOunKOOFqiUhz5a23s3xB8Xq7A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5257.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(8676002)(8936002)(52536014)(5660300002)(83380400001)(9686003)(53546011)(186003)(6506007)(86362001)(122000001)(38100700002)(38070700005)(41300700001)(55016003)(71200400001)(7696005)(478600001)(33656002)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(316002)(54906003)(110136005)(4744005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hg5ruEaRqxVqJtOLKiCpXvcPqmsuNGc6tLXw/Yn2vQrvUZUxz0/c3Vk4jSNl?=
 =?us-ascii?Q?CJR7g00hmB8S6uzcMMGQaojPGc5fw/oiklJjs8GfdgkWNRjwF7kj536U4l8j?=
 =?us-ascii?Q?jsjj4KgosHS7UlMHUSZP4uYr1ptpHgcyaei/nZ39kCioymc2Y0di6p6+bONj?=
 =?us-ascii?Q?6IBbSiXGemxIrpFVP/8T/DLAq5Dp0yFd4EVD47coF6Kr8iS5zPZxhg3JfiCF?=
 =?us-ascii?Q?n3fqPaKxLg93mGb211UUR0qtshmevgIlwpcp1e4uT96Rfpjl+T7+kNztuAXz?=
 =?us-ascii?Q?n0NKN/ngMTHmlYOftjRKhuFl2qDn7qeGXilEPHpV0wUcmEKXvEQi4Rai+lgG?=
 =?us-ascii?Q?xqJ5xgwY0qJ9Tqh/iEaoHIVQbemIri2Mel1+FVDcwHoTdpCojPzqURIq4cVI?=
 =?us-ascii?Q?lN8eplOlSMaXVvxr2uLgQhPpnSD02TtUAzGqB9l5LXIK2xSFawW6CLPxEN/N?=
 =?us-ascii?Q?DyTOHhn85/EVpoH7GIangm7e4K0vNVSZuFMmZ95qSVRjoBZgNL8+pC3jpzgd?=
 =?us-ascii?Q?QD2sKATPgbymitpIXUsOTtwIXxKCR/YdIxlMqlJ++vvebtsM/F6fdNY8KvWX?=
 =?us-ascii?Q?16JV2ZZq+tb9sqXzC7YQ9YxpfrHxWQ2JvaQTHg3tHMwx3zjNtxyjgXCGZP+U?=
 =?us-ascii?Q?MT0NPBQctIdpiHaIZD98ddDcsZfsPbzGzxbJfBcj7t1uesXDnZryzm7VVsa2?=
 =?us-ascii?Q?IEC1BD+dUsN/fGI07Vaw4F2Ki3WVbMn28X0WxLanj0Ms6+po32ru2r1rHlay?=
 =?us-ascii?Q?hMNEnVdC4uXlo0drlr1BCzU70z4U6Z+11TjxYBClj5fjpkQ9fMTD9ZPSWRtt?=
 =?us-ascii?Q?L8evaPBlCfNGkHWI34VExb0jIU8zb+ROYtCsptO1DPyhLB6hpXvpx0TaXihZ?=
 =?us-ascii?Q?KBDgRS/6mJ55Wabi5O9GQnzNawaq0wk5qltfhe06MqYgZipxjd+xF4XEhzMa?=
 =?us-ascii?Q?giZ5G98D6UEtdJyTDRIxRYn4/E7sl2gBJlyDgipx5Zx1XZOATV4siF3B7X6y?=
 =?us-ascii?Q?nY9Jh/q1SeNDilqWDK7u1GeyFocZEwisuET5qqz68XvVeT64rFhX1Tu+09ws?=
 =?us-ascii?Q?l5OuDghNkYxXWn3ROqhlT1mbDjmqtWY2JCftYtWURRZ3Q+l6kLlDPvj5ZJ4b?=
 =?us-ascii?Q?Grzt2dwLzfbItes/Prdck+6+WYl+YvcSL0SHp3Y/dnl0yIbLwG8+33uTgRvG?=
 =?us-ascii?Q?vi48SNy3GozVAEgoY2w4trJ8LPCtHsBaa67FdbtlOEWZhwtgLpTC8bOdADO9?=
 =?us-ascii?Q?dOW+v+p1SGTNIeQjCDVZnu1CGDjWVEIhlpMV0qzctDdoU4rd7kMaS/ModuSP?=
 =?us-ascii?Q?/1qgUTmIFgGXXgBI+EG5P4AzA1bNrM4Ms+u3srsgJfJrqVR/idp+ta75G1YO?=
 =?us-ascii?Q?5CnW0hTcN9h9UK8pBrnFMqvmv9d3YFhlAAUioRgCUzIbgeZA2kiVdsyMXKjH?=
 =?us-ascii?Q?O5pYq5WI567mSMS/DXG7TWkWzb8mnHlWWhUKVybuIyky9crOm6IQppkw3h+F?=
 =?us-ascii?Q?L/XAC+HBSVdAgC0bM5wxn68eVQ5WVRHAQdYuqDtbzAwsoh/rCdAOfxKiDA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bef7be-d9da-41f0-424a-08db5a92d2bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 07:04:45.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSLK7iaTjT3unb2Aopsl+TEIX2/AD5AT4sgyjJbOuUI3nP2lOqu6oTqzvRKLhCoCagEKWE6s0fIZL78qL9H8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Please sync up to below commit for the fix.
15dc5a8630bd97a5ea85d1f7ad7c6830857da656 drm/amdgpu: remove unused definiti=
on

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Monday, May 22, 2023 15:01
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; =
Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64 allmodconfi=
g clang-17) failed like this:

drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c:704:23: error: variable 'mmhub_v1_8=
_mmea_err_status_reg' is not needed and will not be emitted [-Werror,-Wunne=
eded-internal-declaration]

Caused by commit

  fa90ca94dbda ("drm/amdgpu: Add query_ras_error_status for mmhub v1_8")

It is only used as "ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg)".

Reported by the kernerci.org bot.
--
Cheers,
Stephen Rothwell
