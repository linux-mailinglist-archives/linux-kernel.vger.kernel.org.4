Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23DE699C99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBPSpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBPSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:45:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F372054D;
        Thu, 16 Feb 2023 10:45:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNgl/vaLCOx68tRs8Oc1asY/cFkii/CIgcm83w5aJuB+vmfYLFEP4h5GW7l5O8H+7rlDPJTNbs6Hb+kLFvjVGz/4Q2aq5iRsEfbyAueLGXPVMw2teq3MPVNd+otEKumk275RRZqsH2EsebEGsR8TT+w6gJKL/9+ZXirCqYEo1HQdOlvBC97jq4ET+s6+r+LPP3QX18I0uCf4BkaTlsCsv5tITVLaVQMuQzgEmwXUHvLyqfQjsp6+X99vLaRY6MN7XCIAbCTFmP7tfNUyJPfKtObhQGhOmcuM4eVhF0IqJ0603iO9JAnx/1CwdRMQvl0qoP7JqyPVztuYTu0fm3aILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHn+u5pbokSc3tB0HNKSNBPZ8gJ/KDb1Mtgg9PxC3iA=;
 b=cbIYH/QZiYYy0yGpF1M8lAYMPSICsEsx28CpLNwUKxtnIMVgGXUqWIWME4x4FslM2ZVbxOoYPpySp8JW+Axg7B520IZv3dJ9oXhUHxLxVpNpJFfC5iHrt8tdGQQY1/ep+h8NLQH57ErXVzjG7g3kgg7sjfl7r/H9Rhw/VyIsta1x36712nuFdxWj1CNm06hIUryeif3ZjWXOA5C9S8b9LyVj/88XMl1s3mE5W4YWEld3wvfRAoFdk9+wDNIf87ICnyONL5gyFrW91n2tOgGGP5uopFW4Nch4f8RNtUabhsxeujipUT7hUtLgrhAhUr/TIlUpnaVSE+feftKn/Z0Qvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHn+u5pbokSc3tB0HNKSNBPZ8gJ/KDb1Mtgg9PxC3iA=;
 b=kYQ4R9GHat8Hf0IrETfoG4zSu4M5O8qiXDHROt1yZPNEV0U0GAPL2HL0F+KZIfYzs1I1qqJzSVxZUdzIlLLAC4HViKxViBDR2aL+dYGp0seW6sFLKiPiJcn3UWQ2UxZYmubi9oskvNzFFqm/iwbWapvi9enSeNFRFtnXwdLLPJJcuBlICK3ZpALh4Y2qVNetEvqs2Uw2BUfqAftvzhJBC2+Wb94rbNVxrEn9kZbKAIF9kdiFo3Y1yvqdxZvOYKMIiVzdEDkrvO4qR8z2YzYQFCO8ae1ynVVoPYWUeHKWbE58bcq3LY5g1HC4H0t7/13Gov3wBGhS6cnMI43pFvMRBA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 18:44:59 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 18:44:59 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Thread-Topic: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Thread-Index: AQHZPWNgHTU9nf1rdE+MpmBAnswWQK7JpLUAgAg7eVCAABDiAIAAAPSA
Date:   Thu, 16 Feb 2023 18:44:58 +0000
Message-ID: <CH2PR12MB3895DCD7B2D54B2228CA8F24D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <acd85e20d3e8d45ce3254e6ffe5ad2b5039b1a34.1676042188.git.asmaa@nvidia.com>
 <Y+eCNEHcmo4qapcI@smile.fi.intel.com>
 <CH2PR12MB38957ADFF0519278F33E9D57D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
 <Y+54Prj3YiPex5lw@smile.fi.intel.com>
In-Reply-To: <Y+54Prj3YiPex5lw@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH7PR12MB7235:EE_
x-ms-office365-filtering-correlation-id: 51c6ecf3-3098-403a-67a0-08db104de804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0REVeqO+/Eh1XCumzu7vXqYekBfua0ynLtph73oEZ9s8/ysLb+XGy4zYrywXW421ZDiKaTGFndEFwZ033Q33LCN6hTHGML0MWj8n7wpj6hJbmecjHOe0GXDa9WOyPWLELa+UIMfSgsM6ZTzpGjsy322fsEVeeIrEdcO1+11CKnOXuB5coskNC7xtvkMxQPVk1gB0SAs3F2sA0QDm0d7WaL/FKxTPRa0XXTR6ahsR7VE8tfwrN6vE8VSeXmmmNDLLVaBjOdJcFAxx/w4aQQnLPICfjWmPoCW/wX8kT5QPOtS92AyILBniHC8Xn418MxSr9LfuKVKC0Ue1wGUKPK1boOLjKJSisRXAqQhlxF0hxSDutSImadRBSxRUdnmKZ3KIgbOWs/ZMNVzkSfBMhm92F7Hs24yvB1dDN0icWd4WXZJwPdGcbtZJgjicpU/qv79+T6RsJJ79TSU3BpR0JhlQW20oQelxAw0mdoSNN5U+Jdlj3kXa4/ceVa5L/79qFRh83AMYuR6CmsZ4FTXFT5Wq3nFDd02OZUZ/wcNydu2iRnT1jBjrsF8sTrQYGz4ht1Kq2KinCboHqUi5FPsCgPod72n1iu/PKUon365d1OkNSaK8JL+aVdIjIVae4Ai+D3xCgHLe2onnSgbNh60EazM+ByqBtsdPiBuKDUFVubFZICNndJHgtZv9KmHyBVtrwebffJ+OPWGCnCJsdw4F0euufg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199018)(38100700002)(316002)(122000001)(86362001)(38070700005)(9686003)(71200400001)(66556008)(7696005)(4326008)(33656002)(8676002)(2906002)(6916009)(478600001)(54906003)(186003)(6506007)(26005)(66446008)(66476007)(66946007)(76116006)(64756008)(55016003)(83380400001)(4744005)(52536014)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0t/AnhqJYQCx2cHFqqGCnfY1SR+SIQwc2dKplhwFnzLFA6eG4ULoAYwvp4Kw?=
 =?us-ascii?Q?Km6RKOR0zsFOAIRXi3XrG/qiaU0HeXvmLUJfFS4UQBCnKPxjsKTAffsbZZh8?=
 =?us-ascii?Q?HRWC4Yban53Mdhi8Qk9hHAryRGR2qX+hLh7MxrpGGLFPN9f8mrbXfeVcidIT?=
 =?us-ascii?Q?RwChgDvGIUhDDkx5K1b6SHZRzJWTJb7IaKwhlXHnD0sDkesgyK533A9Rwz2X?=
 =?us-ascii?Q?zB/ltDmyxg61xiiarxbWkZBL2bWukF++aQiEn6JMak0T1DuOjS9RgITr0BGz?=
 =?us-ascii?Q?iUavzeK68begibd1uBBUx1WjPvVJ7wQrbR0ozWuOIBmXThsL+bwsM6tCsqDy?=
 =?us-ascii?Q?hnB3LVkTI4u0GC63BcbHrh3yMUwXONDgq/U1LcGcmJBJbuON5ZzO//muyEme?=
 =?us-ascii?Q?dbl4G/oz+WFu1tD50OlLW2Bld/FbD1Unhezgq1yC6LaWRvKS7cJ8iCDjLee9?=
 =?us-ascii?Q?5VMvB0ZJLk8K/vK+NOockWql56VL7v8p+TakN6Ek99PT2KQyt3Ae8kkJhCDc?=
 =?us-ascii?Q?F2+fHYW7olVc81Mwm428ImWPo+iOdPlPd23WD+lO9821VaUcUevJzBPb9JRH?=
 =?us-ascii?Q?R5fgQ5JImxjUMXp4fjZBuiO79aGzNBEoFxdkiPkej1XonX4srOScIe/8gFzC?=
 =?us-ascii?Q?n0PFelnO2ajf7/Hdziv57xFtumLhogaNMyN9r8ET+cZ9TQ7dp75xs7OEpLOc?=
 =?us-ascii?Q?wAL/dSw9xkhH9D8z4mWUEo0jIwMMyiW72nf3Iqawl/VL/+kRjr+imSi9oj7q?=
 =?us-ascii?Q?KJ+/ZNVmel6+3NcYvCaDnAa+F2x5jESKLf+L1+DcKm4/w51oaUCtAa+2nFTM?=
 =?us-ascii?Q?VXFNAKp9suJ6uYKlaqgvDO3h7N20w3xFATIRjAxdV7loxkPsBAxzsNsUTbe3?=
 =?us-ascii?Q?Q2tBMZ/xezUnXC0UhNblC6M0yQLQzKLVtk1lZImGvGaoncIf/uPXgxMlccy9?=
 =?us-ascii?Q?T4BlkP/or+ENQ+KCFCFPQ7eDjp5zvLbAHkYQiKEaFG6ysRhs9RjfNI9swXU9?=
 =?us-ascii?Q?0LoExAz3nrqS1awDBDfS2QJ5sfJd4LnE2jdCOaGVBSPDJ26kiql2vP6k29Hz?=
 =?us-ascii?Q?sZ30L9CSBScrO56y0m+Uj7hDU3Iiao5qfYkr6btVYWXUrTq7pny9VmdLER66?=
 =?us-ascii?Q?6rF1cY8zf3PS0Ip4bIrfrfwHlQk4m37U6dhvhm0WNtZ6D2MWBU0cgUkmQvRP?=
 =?us-ascii?Q?/W/NsXRVbrDlZ5eZWUeWNc4cm70imK1x++gpIVgZFRSI2KWKKAwc+ER0lBd8?=
 =?us-ascii?Q?wItY2D9uqiWQD6bR3mULhw++tpaLvu0P8nuJOSQ5tIVky56rqZB0+WF3DoSz?=
 =?us-ascii?Q?KPbHE7nH1izqFuyjRJ9c8IbzfwWL6K0MnZaLsqNTTUmr5rceU8gdw1xTBCLI?=
 =?us-ascii?Q?cewNImmqpY04r2igEzDpApwVVCkQQlDmtzN9MN0E9KXxxhTbVy4V1OpZGJHk?=
 =?us-ascii?Q?CCtgqxlIasKIEnFNXGfJZPyAC8rIftWNaNk0PY+cfvFBzsYqbgmWJW6+VuH9?=
 =?us-ascii?Q?VN6txlj/A5A6ve5X2d1H0WDz83eADRNlpncxx2zD/ZAerA4emwAp8yt8qz0g?=
 =?us-ascii?Q?4nrl+C+038JtMJVCmSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c6ecf3-3098-403a-67a0-08db104de804
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 18:44:59.3717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dns8vCCXY8PS69pZfGkgDI1rTzL+X1TzToA9F2oBi0sj71+mnxPrvhbTo2TUmVef79bmxe9BNDV9nJqZhSFJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +config PINCTRL_MLXBF
> > +	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
> > +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI)
>=20
> This is wrong.
> Please make sure you cover more testing.
> Also, do you really need an ACPI dependency?
>=20
> Could you please provide more details on why this is wrong? All our upstr=
eamed drivers use the same "depends on"
> Our pinctrl driver only applies to Mellanox platforms, ARM64 and use ACPI=
 tables.

This is wrong because it narrows down testing coverage.

Besides that you need to define functional and build dependencies separatel=
y.

ACPI probably is not what you are using in the driver. I do not believe you=
 have at all dependency on it.

Noted, I will define function and build dependencies separately.
We have our own custom UEFI for BlueField SoCs so ACPI tables are our only =
options (for users/customer etc... as well)=20
