Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A929268E52B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 01:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjBHA5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 19:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBHA5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:57:08 -0500
X-Greylist: delayed 1597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 16:57:00 PST
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE8D40CB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 16:57:00 -0800 (PST)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317LsJL9025574
        for <linux-kernel@vger.kernel.org>; Tue, 7 Feb 2023 16:30:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=IUoXjWcHBwZ+6uEh7Lu4s/z9uMuPDYOQ8qnNv0LUC5g=;
 b=HJ9KdRdaMiUz/QsRZw4NLPpfXTWOj+IFKIRR0q5c0xkbSlSNhLAx8kEaqnd6Q3/w4OMB
 If3Z+asVi76ytP5LKWAmkQViDeud35f8FBpWCFkuQMIflB6AnGDZuenjgCIBDF8/s0NL
 D0nN0av4jvs0A5yTH5cudcHCnDjFd1M8DSEKW9tguFbra05Y1WBHjsy4LW4ptkzokeIF
 eO9GF1fF+7Bcm6Wv7WRLIsRZ32Ksx4CXyU1uhESknkWWkbQKNZrWuBQNvJZsuGTmhM0x
 pAlkJHY+/Nlirv8a3oZG9Sp8ylh7Q21rEpS/nBLTJVzFkYg3BYfiH/3lfcdxalrd06WI dg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3nhmk1agxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 16:30:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKZfYcQSpkaX+f81SzL+ztHsjHYner2QsigLLAb7AJuFbo77PcFvB5ASgOsZkzCQSd1ncj54dScZVtASEbpCFR/0h7GtVtMxCBv4uggKC7zMqLlqjpWj+IA+1qpKnm6bJj/2m+SHob+gVyTTOUn719PJ9HzEdDIPPSYUKrfl+3fRAhyYGZCDpi3GDUWf/K2eucbgZi1Rc8ZEwBanpWbGkGQzb+GJHM1bbTjgVcuEhzy8sY5nNu2m1pbbhbGjRwE/jCriqTWn7WeF+OjNDWcWhj8Qw7f4lnrLrdJ9aRY5Dg4ACnyHpdky3pVug86NrHn/XVWLsJ+mlp+gnCDlGHxstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUoXjWcHBwZ+6uEh7Lu4s/z9uMuPDYOQ8qnNv0LUC5g=;
 b=JulWMtvK9ixRnWb8lKwYO9+a/qVWd0r4Fd0HdEAN+svvm0l8q5tcUfQ+TA18e2OB4f7vVitHfOsMvOtd+QS0Fgx8agVAkIyk2r/skGp1FUC1GClkNLGrIGYfA02B9tynEXWTGB7jDv8aU2kSIcnE/wnM5wXLBXtX5KdshCV55YtSrvqTW/OII9WwVojBgFUvs0BX9/QJ4/zPKdl2dHw2XAsmCp9U3lVlcilSp+++orwFUHcNGcOVbc3k+yr5I6oE/6tGuH33pefLTTmmJmLV+AKRbs2FUMDdaRxri5DwGDVaa+VH6QW+Ca04jy+FZFA9GhTpEub/VlkOU2qoGwlQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUoXjWcHBwZ+6uEh7Lu4s/z9uMuPDYOQ8qnNv0LUC5g=;
 b=W3ZJC+GvxPQu0gD0COGcKtkhMdwNU+WJmopujKVdq09shvPcbunfVEtQKM+2Fj2EO3gdCvjvAOVk50WSpxvNqgUC0NAgPwWaKfj1ExnLVnpNX4SO6KwZ9jrZAU3Srm0Tl6eNx/c7gY2kaR3B16qtPl35DS463gMrtTIM7QvfLBKAYW+il6m2ElgoSh2BoHBKW22hBRMMEuASl9h+p9l1BmKqjORNgbvJAhFZM/wqoMueYnqPx35rdU/n3QNiQM+eNAZIc4Dh6BVB815ovv6Ysade1Ixi/nRvVrSUyLm3tfEssVBuDrDWa4BgjWAfAj7Dau2vPcx+VfTzT4u0Ab9O0w==
Received: from CH0PR02MB7996.namprd02.prod.outlook.com (2603:10b6:610:105::8)
 by SN4PR0201MB8709.namprd02.prod.outlook.com (2603:10b6:806:1e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 00:30:20 +0000
Received: from CH0PR02MB7996.namprd02.prod.outlook.com
 ([fe80::2ff3:1219:30d6:4d69]) by CH0PR02MB7996.namprd02.prod.outlook.com
 ([fe80::2ff3:1219:30d6:4d69%3]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 00:30:20 +0000
From:   "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
To:     "Kallol Biswas [C]" <kallol.biswas@nutanix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: intel_idle and acpi_idle driver initcall order
Thread-Topic: intel_idle and acpi_idle driver initcall order
Thread-Index: Adk6bYHffH51yATXQnGvpDCe7duUZgA5hOwg
Date:   Wed, 8 Feb 2023 00:30:20 +0000
Message-ID: <CH0PR02MB799683E84389C55B1D88F9E8FED89@CH0PR02MB7996.namprd02.prod.outlook.com>
References: <BL3PR02MB798658A2F65018B3C4B5E9E7FEDA9@BL3PR02MB7986.namprd02.prod.outlook.com>
In-Reply-To: <BL3PR02MB798658A2F65018B3C4B5E9E7FEDA9@BL3PR02MB7986.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7996:EE_|SN4PR0201MB8709:EE_
x-ms-office365-filtering-correlation-id: 4d0ffdaf-4a0e-4510-2897-08db096ba8ef
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nz5Fg2AkarQOPRXX4sck3KCxnXIUNBhxQnUIAyelk+DdUR4BhqwkxDVSOVWnRcPT4cPzhpWQ12QDvLKreUHXldEzkI3/TWIRVji9mifgSk+KUp1XwgEko0hVR/tr7OlbC4TV9yh4+7PLy5qCrxQaJknphtMTtqi5Req3pdD47ZgjYqmTOx3bm3gZ/1g9/SJ7zviDt3LT3pppdbH52wIHygqRd0amQkAA4bDf4XK39aqj++XBHasK+rIfCrjSVv/Zj79vD3vyIDk5AVyE9eQMH/7YvfRsSqWDx4pflG0hGht3rzmOeLjqgOz4V4ynh2+syD76xHNYfK/98uCk7k8n9PXURIzav0rz1UAMIWVYDYxewmTQHIEI16PgBOZeDVvTokUkxil+4XOD/KRdAMLxPOus0tvwt5i2AMpQf3Ky1yUcGb/aHojsfnCpEg/AUMxCftTpjFnvdl+uFqd8GG8pTU4qbG8N9rw6Byi4A/mW9Alg8jsDXiQbbqKoW3poe+YOEgdOk2VbaLeHt0S+2rgWae1GVxL6vJcNVMIGUi8V46FpqsxmufL0IsWf5smVdtn9Y+vfepzQj8PNHs8/3LclNObG4klzZkLjbeA7JDHsxbPHfpDmM/1IclRQ/aaqdyhY/ymZI27VuFQ0dL+xYWqB3NvP2Ls6KUvhJPSFedg8G2GiG8wmfIdRCQphwEBcapO7yiVHmgISV0tfoHn47k953Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7996.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(33656002)(7696005)(71200400001)(478600001)(52536014)(110136005)(64756008)(53546011)(8676002)(76116006)(6506007)(5660300002)(66556008)(66446008)(316002)(2906002)(8936002)(66476007)(66946007)(38100700002)(41300700001)(186003)(38070700005)(55016003)(83380400001)(26005)(86362001)(122000001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z304+OGdiCTyQ+aHVOfIUV7XV0TFUf4AnWc/nZiWx2bPpLlqizmbIkRgkKr6?=
 =?us-ascii?Q?1RzPDVbDnkKxGjkHRFOplyUCPwVp0sDG2WLpt3S8V73XVWD2/wChaUU9T5/B?=
 =?us-ascii?Q?NbinSYHHvqxNaPUB80UJzPLtreXhouOKiyo82XwYWlrpxKHvLCSWDKjQ1IOx?=
 =?us-ascii?Q?9JQ9f5z9lUsT8pi36W1zcWNG4VQOtTBLUlVPItYhLO/u3AIyXBblcjH69as6?=
 =?us-ascii?Q?+aeARZ+1TrssfrF4/a8sUVD66F263rQB21g5WamlevI0PatnLuGoA+TY0FGF?=
 =?us-ascii?Q?ozjFYkGLHe6u7jibv1+J9yGIDLwfEd53LmosSGMZhlJf6bOmp5ulLMhLWN56?=
 =?us-ascii?Q?Ll6YYABHJdzAlAWegAaccKxT3K2NzOBvh7DGGKfjnkb6cPHrhG685FIcwTv/?=
 =?us-ascii?Q?orPqKBViRuqi5mTBN1YG+AAZHywAY908uwogag3MlBpUJ2AO8s3LerD/IoZ+?=
 =?us-ascii?Q?wIbf9WfN1CROcn9RqU3PBPHjXOVEupC4pMZEATGomLHyMk5fEVSHkYEWCVXJ?=
 =?us-ascii?Q?fnLRLZ+ZrdFMHgIGTvhsboCYkO8nKF7gVAdRB1SJ9DSPDMUSVHr1iB+oiVqY?=
 =?us-ascii?Q?fAw6foxllxIPEyIBm8/Qw9R8rknBpYhfnKQEMVfH+xdsuo6lpBZ8vZDiGfnX?=
 =?us-ascii?Q?7SwyXN5Y23qfpzqbh3u9rETI42+fK30o8eWksnAogHSh6+dB+EuTUqPZDqmL?=
 =?us-ascii?Q?hmkDnJCw3q4TU01LLMicDN5YZiw1RlOUqshxX01YMtENY428YVwGc2IiK8zX?=
 =?us-ascii?Q?2F2wO+7ySAWU4ZyyBTOLckpxF1IIF7RMpcz1xi/JDM6GXrYX22W5eAV99eNl?=
 =?us-ascii?Q?6Wtm2Lrp+6WSVyAWJtlUaUlNqh+DdNHp6HJ1GqiFEekX2KIgGIJ59GxADdGk?=
 =?us-ascii?Q?86WnGhgdHZNVj+iGDVPuaYBhWV/3b/K7ANS5z1VhApI2ueyj/GHeNM6RIsmS?=
 =?us-ascii?Q?vpdegww39pwcQ0T/lj2i6lFplehVlckVlr47K2p3kYy35Zl44exezbf7dX+8?=
 =?us-ascii?Q?q16HlFWfaVbfwEZS/nl9l25XVMbNtfH1O/1HR4JgxBxI9TuHs1lBATh5rfd8?=
 =?us-ascii?Q?kTE8JcQMo+kZUHCl/Adv1xHc7V/d9BFYTfNtmZBikmJPyajC8MQGtv8R3thC?=
 =?us-ascii?Q?Gc1NTUcwU6bzD6bhiyEMVVGhG/68jxwELba5s4G3ajVjYkncXP12D6NzP+Fc?=
 =?us-ascii?Q?8eLUDAAwLLejARVBC5GD6iF8XXF5ModnYj6wffSmRxcD0r9Wo9e5NxVse7nm?=
 =?us-ascii?Q?fg3ckJV1Wg+VddzRphlnj23ub1bzyMbdPmz8KQpo54yjAcW6AQhIEWPYddfu?=
 =?us-ascii?Q?X6YH+Bq6U2Sw+6Qh9h+Uf1q+05CtzikzgTFMuQ1zIXk5qp5a7y//QmtZbMnC?=
 =?us-ascii?Q?TKqFwmPoDHdcr/f5N3U6lwIfvVh5OMRjwAXVhUEfUBnhlYADhiUoWqWnP+EU?=
 =?us-ascii?Q?wvCY4Iw7OJUWltPjqA9tmRBDqh4LVq+zjYTarn8mMonEBcaVtXqkynkNMiHb?=
 =?us-ascii?Q?ZFDrL3JfpUT9IwVum9IXYN8KDMss/FQFZ76i29rb+YhfBkoPhkGnUBgZf+wJ?=
 =?us-ascii?Q?E5e7kRo1T8xOfkHQE6z76VkhyiVyYQ+daAZkhPwg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7996.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0ffdaf-4a0e-4510-2897-08db096ba8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 00:30:20.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EW6H7wNXsBE4uZ/3BTb7G2u4J0N77ihR6bpo3MRXZgVQ96Ky4PIYGnpjgibBhwlh8nmPCx0ZwJk7/JMwY6wyyZGESAbe9KwUdu3V6KAgrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8709
X-Proofpoint-GUID: BaVsjVQ0mG2OzF7ePmMveqNQ5LaJB0NJ
X-Proofpoint-ORIG-GUID: BaVsjVQ0mG2OzF7ePmMveqNQ5LaJB0NJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have figured out why intel_idle_init is called before acpi_proces=
sor_driver_init.

The order seems to be determined by the driver location in drivers/Makefile=
. I have changed the file to bring down
obj-y       +=3D idle/=20
after
obj-$(CONFIG_ACPI)    +=3D acpi/

The resulting kernel booted up the system with acpi_idle loaded.


-----Original Message-----
From: Kallol Biswas [C] <kallol.biswas@nutanix.com>=20
Sent: Monday, February 6, 2023 12:59 PM
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: intel_idle and acpi_idle driver initcall order

Hi,
    Looking for help understanding how  idle drivers get loaded on Intel pl=
atforms.=20

The intel_idle driver always gets loaded. Both intel_idle and acpi_idle dri=
vers are built with =3Dy and both use device_initcall.

Added initcall_debug cmd line param and noticed that always intel_idle_init=
 got called before acpi_processor_driver_init.

2.736001] initcall efifb_driver_init+0x0/0x13 returned 0 after 5 usecs [ 2.=
736003] calling intel_idle_init+0x0/0x406 @ 1 [ 2.737335] initcall intel_id=
le_init+0x0/0x406 returned 0 after 1297 usecs [ 2.737337] calling ged_drive=
r_init+0x0/0x13 @ 1 [ 2.737350] initcall ged_driver_init+0x0/0x13 returned =
0 after 10 usecs [ 2.737352] calling acpi_processor_driver_init+0x0/0xbb @ =
1 [ 2.767685] initcall acpi_processor_driver_init+0x0/0xbb returned 0 after=
 29618 usecs [ 2.767687] calling acpi_thermal_init+0x0/0x86 @ 1 [ 2.767850]=
 initcall acpi_thermal_init+0x0/0x86 returned 0 after 156 usecs [ 2.767852]=
 calling acpi_hed_driver_init+0x0/0x11 @ 1 [ 2.767888] initcall acpi_hed_dr=
iver_init+0x0/0x11 returned 0 after

Question: What determines the initcall order within the same level?

init.h:
#define device_initcall(fn)   __define_initcall(fn, 6)
