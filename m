Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D40699B91
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBPRvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjBPRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:51:00 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D54CC86;
        Thu, 16 Feb 2023 09:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zse8E4DK6MNrWnkjl9FSj60BY3huU3rdZwMBBN764xDaG3a/BoiDROn3+CiIb8+j33XoKucCxKTRAutVHH4IV/QRKro3qGsZn6TsO+zIkhV5UG4eaIw/cmz42UMjaABn8Jfb4kDrqNweXsDfYMmZ77a03DGxEn2Z/XIcheIP4mk5rrT5o+SYvQ1+8/4LEuPMKrtYyp/4zGnHo0bKD9X6dFFnIJ8atspyd9LPiIqgKRbMtlOuae+ZlykPxcHCSD2YtR7E5me6d02itQ3fG7FQs7jgnOpf9lh248ti+XuT7+i31t9uyLxr9MjepqbSwG8s2n+gPydfPgniVFoGPhTzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17a0sZ/zSE44PKdqss+Gtboc0d3CSx3qBQzzoUPZT/4=;
 b=bOQWwXZc9q1VkE+n+dCfo1sfa5mrGE2Jl/AJ+lZEyUuKQmM+9mZzzo9zbdJHBkK6LwzjRULB3RFa4rUoLavCUiSblxrEtZbwv6051Vmkwn2x6vOlT+nivkeYRyTwvle+gqyxLXeg2P+hVZwrSLJE0MrxZgYhwsV/8HRzgx0CHwfOZyHUuAJAXpTPXI2Mx6fe0eSseSVpa+idWtb6ITJVEBIBFSRU6W8jWRC2zzu6aDpBO7VtkKiSpUqoq7IUY3eCayvWtC+Qj09vThfPTnITH3ZrKhHKvbBRZd2vcId14Zqfl8blE6Pe1J4AAay3XMyaZ6UT7WcFIFeIrk7SrWbbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17a0sZ/zSE44PKdqss+Gtboc0d3CSx3qBQzzoUPZT/4=;
 b=i8xG3FURwDj0Cp+iXnDoZ4lTuKhsJrdCzW2zjMWdLo2rg4EYxB7AZbru1C+CVRmvt0xWtZuZTDuTgEnzD4V73w7pEdfkcl56Jd+7j3ADvI/nzlOD0+IDbukTVswJ4bDxQhOMxBzRDu/JncSjMkuSpqoxXTBmzMppJ6ZZUa5vL2owAaS4i8Khg514OT6Prm2pXg9H8Ds2QxxyaXtUw4gB41OFbw83zXDxOtPEXOYp86W08hLv4bLXpmQGf6iMlzBKSyPBC9X3TlHLaGDEbtVv2uQTo1Lf2Nk7BvjoIBPk4CFYPgt/i7EIsyJRAywQZ6ZhPGZg/WdCCPJ6UsSuMyWZUw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 17:50:56 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 17:50:56 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Thread-Topic: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Thread-Index: AQHZPWNgHTU9nf1rdE+MpmBAnswWQK7JpLUAgAg7eVA=
Date:   Thu, 16 Feb 2023 17:50:56 +0000
Message-ID: <CH2PR12MB38957ADFF0519278F33E9D57D7A09@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <acd85e20d3e8d45ce3254e6ffe5ad2b5039b1a34.1676042188.git.asmaa@nvidia.com>
 <Y+eCNEHcmo4qapcI@smile.fi.intel.com>
In-Reply-To: <Y+eCNEHcmo4qapcI@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|DS7PR12MB6069:EE_
x-ms-office365-filtering-correlation-id: 2da473cc-3e16-4595-f5fd-08db10465b22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rnmjz1h+BurkvbyUybPnuiL7UHS4LbnudvkG40JFEYM8s/V/rEXYHHnWcvufys+A15fdIkufOsRt+FZlo62RIYvfAAb1VmPMKVH+Duhr6NliFmJQnnF4Z4uCraNdPj6IiWoofZ7P+LHP3GJJG/D2wcAaQ1+aG7H5LQea/+msCLIUIzTQAnoYJMMBdBOVyqMi/q+nvtFlo2Z5b7/w7uQH+0bqZmN+dls3EozJ1Du2A5UH5/aZjl5PfMnwAcxDsXGpxu2SNFFm91UAiTK9B5eLMF2KURnzN1+GF8zlIaFoJj/qrVoUFnsdbbmDXmTULO304MPp5zpqcNraMOyiIw1IJxC6L4opSt0oYpbtfHglf07molK20lHEEwndbycnjs0y6IXRzo066it5HCND3/xE7hL9tVie4G2xsBO7mPZcln3GT4F+FoyDhHNLXU7IRPFITeCgJ3/Tzzm3tjqjie3pjebxaa8O8yOyHrq5oeZ4ZHen6wCBy0MURHkxagPwixbkfSn088uLuxx+iRAwLYdHhn/LlLFxczTFLMGcNZUccCksKuzt5qQ0Xmh8KGW5RLwLxEOXFoQnqVHbv6nCGPLgVzzh+1x+CVQWPK4bgtc4JZorargrjNCAvHgR64K2YXnsuUEYBS2zxyCZ/xLe2bEFrPSNycrx4YdJR6u5OR8djd1QlPTea0a6HvM9VcNRKNKZacV38/nN7+dinNDUe3r26Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(54906003)(186003)(4326008)(478600001)(8676002)(6916009)(52536014)(26005)(5660300002)(86362001)(9686003)(66476007)(66946007)(8936002)(66556008)(64756008)(76116006)(316002)(66446008)(4744005)(33656002)(38100700002)(38070700005)(55016003)(6506007)(7696005)(41300700001)(71200400001)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LaPByRHGKORV+WWkRyLKN8UhuZjhGlYkHi2zvQu3weF13jFWkkok5/WmThtj?=
 =?us-ascii?Q?IA0p6lS1hxwmPdmAws3C/A4yxMnYGcou+eww4Qd6nTdERAerG2ZIB0OB6dxN?=
 =?us-ascii?Q?keeE1Pc+zLwEqM7xSSPgBgkLv3LBnFhMJ/QEKVxkTXJHTcXJDMxGghBsImAW?=
 =?us-ascii?Q?UzUuEeLLHQ4hCYwr6XbcxB2Og4rx/SpJe5Qj2Krmmo2ZDYKEbZedZK3Pa+pL?=
 =?us-ascii?Q?TKkC+mvOVwUm5cxW9QsFh4EHkiqK+FzactaJrXAwK4UBDtG/ydyO81OzkJx+?=
 =?us-ascii?Q?Pa+M8yaeJ2WFH/8JSMe3XwZObgS2sUfLt5eReuti2t/4IQVm/nbAS8RVZAR5?=
 =?us-ascii?Q?qBGSWtDlRYg02xn9geU/9ZRMrUMuCwvMdee8oPz9g+n87LrmY1h/rahGpyGv?=
 =?us-ascii?Q?OYVlbRgBR7cOeS9ktcPNIpFu0PdWaqdSX+C0meJB9hfWC76CnP54k78AUl8z?=
 =?us-ascii?Q?vb9dYIT5PRCgJhc6SSOZmmbU+X763CHMGhFWyDhetYfxTZwt3O4YoRpwiIca?=
 =?us-ascii?Q?1/UsZ7d95xF6/vjdW/4AHuUc9ILWNrkjxfV14egRwn/m9YZ81W+kKvJVGceg?=
 =?us-ascii?Q?w9mwvnmK0+sDnkMYOqazYV+PVQpl3jPz5u8cEwxiNKEPBZWojMV+LLiB6gmI?=
 =?us-ascii?Q?vgYbtcU2akwAQiDWrQwLOYpZ46TZ2uLIuKygPVuy3FgB8E3HmANfVh19TbDp?=
 =?us-ascii?Q?VA7F8ur2wqfTI2nNHx3PtnwRCDBqBbhS8o/vBdEQZYH32K135Mbx4mvkT15n?=
 =?us-ascii?Q?3g8YbUNVf4+qLrItitrcP/4vXKXkrrQZw83KXpF+37rT15cI/P++CzUTSRYH?=
 =?us-ascii?Q?9kamJhGnUH9hvjHK1B9N0MRew3Xxb4vUWCvhZG8IU91w9gnOMJELp7VgGbZc?=
 =?us-ascii?Q?9OZKYmARndD0W5SrEYuIoIFQF8nhpov4CEplXuNo5BX0+yfMD/u5LREIDC50?=
 =?us-ascii?Q?W1yetnsH3NkVBQdOeNCJpmQf16XowMomlIdQ4xEkWZeu0SeLURWQRl2WXjzO?=
 =?us-ascii?Q?ptJxL3BTj8a0S2+ETQa2Gl2sYpWzjnSHEEtQxnieuhjT4IMApS0g9cX98iOV?=
 =?us-ascii?Q?LEMQbqoGqWo5SqAkgj4tlOyblTyxWaBQoQ96eait6lWEVPYIwAE2Z5LFaohc?=
 =?us-ascii?Q?Idp6yCsJfwAO8TJEkkOGj3s3raP5MflspQ+q2L4de6Nbbm4Cs++B7Aj7eUGX?=
 =?us-ascii?Q?R4bUalTzliHPyhehDsNV+s995kToTQOuuydKOj7dk1a8tpie7rftQsss0kDN?=
 =?us-ascii?Q?aqWV+zlOSJev41WSU3YqfDfrogYTnvla4BqPWWN2tCysHL3ZuGwiIaD2IsDo?=
 =?us-ascii?Q?E3BqkAmT21vKvWl0JfTyBcPwlxG5BOUOc2A6JJqzpaNitZNBScc2kDGbYvti?=
 =?us-ascii?Q?KRxqit5idHFrXT5XSHT/cCtb2RV81EySC2sXv0aEzPGhHhMrvk+5GPEYKpGm?=
 =?us-ascii?Q?TRe5COXOgPKhGm1OENWbO+nWjmKtATmkxqH9Yp8g5MmR0g9HBwe8aiDyN7NI?=
 =?us-ascii?Q?CVNyX1fDAfu5GFbkjGxjQBon8Rg/ihCM7Mz7dEIOZkhHDITwuF/IR+pHC5Y5?=
 =?us-ascii?Q?j59NuB8/Ca0bmtJQ4K0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da473cc-3e16-4595-f5fd-08db10465b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 17:50:56.5361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CeJbOfIoruexEJXlUZLByzZrd+C42RfDr4/mdi/NPmKzL8nXbTiSDAO75b2BJXUif55W2k4gA2EQyIsAplFhEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config PINCTRL_MLXBF
> +	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
> +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI)

This is wrong.
Please make sure you cover more testing.
Also, do you really need an ACPI dependency?

Could you please provide more details on why this is wrong? All our upstrea=
med drivers use the same "depends on"
Our pinctrl driver only applies to Mellanox platforms, ARM64 and use ACPI t=
ables. =20


