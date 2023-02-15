Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67BF697C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjBOMwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjBOMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:52:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3938032;
        Wed, 15 Feb 2023 04:52:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAVE8nqgQsSdcved5kWo8iyIA5hlYB/ZmQ/07h/4lujKykjZXIjnlIY/oiBtpbyHaYAuziSHnFcb+g5t1KlNUkFXU+0BoSiRVQ+YYqb0wHIP6uHs5FD5Pg25euv2hTdBvO9q0kPtp6IRAOz6HQXW+kMtZVzCztSBCymYtH/WeVT1HfdDM1x0rL0YQaLzB6uIy3qt7E47gNprlD1lCDjgfCrjgCiyHXvYIAvlNjHQZTje9ZHQtBSUe6M/o3wQhNmsVC2Z3NfVj1ZfNoINRoVqPDhnLv9lMRDt7IerIyR4ASlx1FLVpZMOLkg8V+8KMf+cZLNrpdv0Vp2PctKlItT28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40tMrOlwEBWREGyIhwLXGzGfwUYaOh610W5LfqIFbQs=;
 b=U4KfV1bipSPAeohJeR5FrzN8TVJ8FctdNZlL4hkBZcWpqusGAHKG6tkAEwr/wdi6u9eiIQMfsz4w9d3U1mMrRJ/BrXnKf+p9ynD9JypDaAJ0YA3FN6uY6KtW/TS++HTQkSyQ/llRhBmNtEBKde5boZ6ns8Aklh/X8csAhR2Q41R9U9ITwMgcSK4HcMUWDHrl29VuBGs5rPrCm+dYNKpzQwwjHaTJuA+Wdv4tmuYmpigNe84ywa8GJOEYSSob94LZDVLF+IHjaoXmgb502ce4NxVAaxG8HUDi4bUmvoDFuq8cpbFtiPH17eIzH1G9wRJZ8im2iKTLOTZAFmado2aIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40tMrOlwEBWREGyIhwLXGzGfwUYaOh610W5LfqIFbQs=;
 b=EKjpuUm3JDbWo9yEXFrhvPHu+/+UnnO+p8V7eJ0WWHsloHoxvhicE9h8Ikxad8ygMetY5n2l0PnH40oly75C+Hgi4Makk8pOoDPucw5AcuMdw9Atxfkt1TnfqTZ012ShWUGebq2stbMA5elaja35RBY7CphVS2dKPUsDLfucaU8=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 12:52:07 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::882:91b4:9e16:6d84]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::882:91b4:9e16:6d84%5]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 12:52:06 +0000
From:   "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To:     "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "jeffrey.l.hugo@gmail.com" <jeffrey.l.hugo@gmail.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "Michael.Srba@seznam.cz" <Michael.Srba@seznam.cz>,
        "mani@kernel.org" <mani@kernel.org>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>
Subject: RE: [PATCH v7 0/7] add support for CDX bus
Thread-Topic: [PATCH v7 0/7] add support for CDX bus
Thread-Index: AQHZNU/R42HTbcoQU0eH7h5/0tPKpa7QC+7g
Date:   Wed, 15 Feb 2023 12:52:06 +0000
Message-ID: <BL1PR12MB533354263F0C9A8D5234272E9DA39@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20230131084049.23698-1-nipun.gupta@amd.com>
In-Reply-To: <20230131084049.23698-1-nipun.gupta@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-15T12:52:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b5e49cc6-4858-424e-b061-60ae14b01471;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|DM8PR12MB5477:EE_
x-ms-office365-filtering-correlation-id: 700edc50-aeea-480c-0024-08db0f5371b1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEbgMEI+jAv4o1DpKppvFjxctevaUlf0A3x9XNk0YEtZimFFJwq7B226Imq5GPQWTVcZrhCmwdDI5lPRbOcHWw5V5MAhzwar5JI/nVHWbK4fsEjyr54AI9LyzGgDe6sIkXKlt1MGfpZ+5633rUSnADZ1kLd+3AphKsV9QucG3Vz17t+LxLQPlUwAVp9SzFANFsOdxbvuocbWiDpmbXoxyfVCoPRVwVw5Saes6CQNtVlrkbpHEPpGHrPybgjRDfxyNEfkUtQH7gjYBxve3M/f2blAOLygZe4H2/VL7KnuquPwWf+LKZIkGpjDGwZXhn6YKf+sAzsubMVb3JKfu4tRHa4oo9SYvnszy5qNr8cDrJd2gxw0UQwv+N17MFpVNrplY5lrzN5QwVBAwQT2Enj1oCqj+NooPYX8JnhA6A8DiyIWrPnVC80RfYoqC2+1sMDcX+D7diqM9onbTueYbeZxjK1jaRTsCqGYfmgMMX8Zr1LvD2Gdk5cQ3LmnbF4uPFP2CdsnWd25Eae0kVsa7lTvyRa1C8O1/ua3PACqIJdxI3qLWhHhI0KZaxVYhDIm1ZbkNyqek7x2X1GfnNOJ9r2hW0LMjBUe8q8cLelQI243SkQISKOaapG5ud2uB0H/EvErWEZbhcpxd+9EAwAM8/KMjL26fccEBD1uW7UaMkkP4nLoZ21sz47ekTYaHDWysGK64xcwZ342KoIGBrn6Guj82x+K2BEyKxrqr60Oktv1iIRwEtNuQh8KSsX4iJwzx3tJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(921005)(71200400001)(7696005)(316002)(7406005)(110136005)(66946007)(478600001)(54906003)(26005)(53546011)(9686003)(966005)(5660300002)(2906002)(52536014)(66556008)(4326008)(41300700001)(66446008)(66476007)(76116006)(8676002)(64756008)(8936002)(7416002)(186003)(86362001)(33656002)(55016003)(38100700002)(6506007)(38070700005)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fCc+7JNONxU/Ycbi5fQEwTvLBLpq+X0qvdVqhLP+OH1IoVBzpY/bA0GBauXu?=
 =?us-ascii?Q?+ZwrbBVfsOjRaURpXRoljp52ZXjkcCuuChXQPhXuUT4FOzLIHl+AxYef4sdW?=
 =?us-ascii?Q?eLddujTLy1Lsam1eHTYe6vAs/jFSrvhraB59p1DzjQJ3ND4M82RdKEn/sfIP?=
 =?us-ascii?Q?bjAA/qt2MM8R7tpCHEfSOiNV3QpOnT7HLJI01J/YQ11wrfe9taOae2cdylzv?=
 =?us-ascii?Q?9xm4F3VVlcJc7vlWXK2cx+HvOz6TO2hHwgb+PNIjvcN32bvF/dWeA+lxjxaC?=
 =?us-ascii?Q?hUk4+ogtySaLZI2GTVE9Hbl5tXtDdojvH0zk/uXLhWdgU0dBx0TCVSgW08Bd?=
 =?us-ascii?Q?W1suZbYwvNRtzLOcSUdmUGc8YSbBRG2Uem5Ep483dEyd1fEM3H+xXI0opd3D?=
 =?us-ascii?Q?ascpM6ivME9amfk6OTSgzLp+clAGGQFs/6xLa8xOJ9J4eZwk7MXNfLcduRm0?=
 =?us-ascii?Q?jVWsPs3V6qDgGYm1sZDvfc/ndiXdiOIUZg2U/+vo2PD+4qqb5cJXGamIHuzf?=
 =?us-ascii?Q?bxfju6d6CMC2vsnxn9K1uSzG5Qls24JzMLDd4VNXo4cUTGBS8yFE8dkNJXDk?=
 =?us-ascii?Q?UY5LuqqBUeKXHbgQqrSOOsmpFDYSMXVSFflVzNp0huaEalNwNPfyh2gtgakt?=
 =?us-ascii?Q?Q5Ja9MCHusU6MF75auXU25pGQseIB2YEh1f4PJOvJExkDuMqMW8nJhyyl0da?=
 =?us-ascii?Q?N3zV4uw/b2UWcB0lgoifiBica+x++6H3ScfrhXqplZIlqdQ35jhxBlY473mI?=
 =?us-ascii?Q?ASh/ez//2vrsTndnGaY1elujgY9ASG3vd0/dihzoCppUm/YCOEt2nZ55OGqu?=
 =?us-ascii?Q?yhtLBJko8xj0yIYKc+X2wtf61462AxgAHNZNu9HU49pJHIRK/uBVh8p1Z4sM?=
 =?us-ascii?Q?Y/bwMobWUzLXqE0aIK83cPT9+MAIOJKkx5Le4xWR2mkGqSkERzp60elcIcWU?=
 =?us-ascii?Q?jEcUsBpi1pSf1lIncrMnVTIRaOxa1NVq5E/aqGfFmEOYaI+zvjvcEMoLtTHl?=
 =?us-ascii?Q?7x2CHxq90MSIzrYKhmyDjvLoYIQnXcY6CRfZ2UhZNJyJkp4Hd2DAKvbONOte?=
 =?us-ascii?Q?j983swDZsxP/rbEGwy1VrhJo4U3cgh9kxt6N45jim/BQ1oxQhLgQJlWDLLsm?=
 =?us-ascii?Q?vGWQa86GUHs67ArKQKb/Dux0FY+qroivspkcGnPtDCUrkhfBNHV3E5gZtNrL?=
 =?us-ascii?Q?tHP7ceH+NLaSpePE3p4ZtE3fX6ZALGR4PhrkXw8VkYCmBVAmdpS3rECsq/1d?=
 =?us-ascii?Q?4TGVDIdzwPHF1x6LCMHjQVoSnOYjJW5BVZ8+1ksnTgIWUxCja35Yq9Ucwjzd?=
 =?us-ascii?Q?K6Aw/brGxmnwWA1L6iOql2jf2VhdRbOlsn/fK8a2QST5u3mCh/M9O5EPQE86?=
 =?us-ascii?Q?0uZTjjHNzyKPpGXRSd1PMvp+4xSwT/ARdzpD67vvbOJvZB5+WpO7B1BqFvs3?=
 =?us-ascii?Q?NUgUQopZK34IHHjxYazS1kZ7dFkK6nZQxELi3WCH5zQW+D6eUzNFVjm4KiAC?=
 =?us-ascii?Q?RRFFpL+Gyy6PLFDIsFXXMLRxPOrldfQ8oi8gd+oNNP5BP3HC5VxUj+wzYR03?=
 =?us-ascii?Q?IxeI+bcgNnbwvqkk9OE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700edc50-aeea-480c-0024-08db0f5371b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 12:52:06.7029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9iHFb2jjFi/p5o81Pk1S3aaYqsvtChgjMVM0Q5Dw5ZQPU4CwKeXz8SibEi0azf38
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

CDX bus driver series:

Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>

On a vnc board for versal-net. Also, on QEMU simulation platform.

> -----Original Message-----
> From: Nipun Gupta <nipun.gupta@amd.com>
> Sent: Tuesday, January 31, 2023 2:11 PM
> To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> gregkh@linuxfoundation.org; rafael@kernel.org; eric.auger@redhat.com;
> alex.williamson@redhat.com; cohuck@redhat.com;
> song.bao.hua@hisilicon.com; mchehab+huawei@kernel.org; maz@kernel.org;
> f.fainelli@gmail.com; jeffrey.l.hugo@gmail.com; saravanak@google.com;
> Michael.Srba@seznam.cz; mani@kernel.org; yishaih@nvidia.com;
> jgg@ziepe.ca; jgg@nvidia.com; robin.murphy@arm.com; will@kernel.org;
> joro@8bytes.org; masahiroy@kernel.org; ndesaulniers@google.com;
> rdunlap@infradead.org; linux-arm-kernel@lists.infradead.org; linux-
> kbuild@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: okaya@kernel.org; Anand, Harpreet <harpreet.anand@amd.com>;
> Agarwal, Nikhil <nikhil.agarwal@amd.com>; Simek, Michal
> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Gupta, Nipun
> <Nipun.Gupta@amd.com>
> Subject: [PATCH v7 0/7] add support for CDX bus
>=20
> Introduce AMD CDX bus, which provides a mechanism to discover/rescan CDX
> devices. The CDX devices are memory mapped on system bus for embedded
> CPUs.
>=20
> CDX controller interacts with the firmware to query different CDX devices
> present in the Fabric and expose them to the Linux host on CDX bus.
>=20
> This patch series:
> - Introduces the CDX bus and CDX devices.
> - Device tree binding for CDX controller
> - Support for CDX bus in arm-smmu-v3 driver
> - Add MCDI (Management CPU Driver Interface) as a protocol
>   for communication with RPU Firmware
> - Support RPMSg channel for Firmware communication
>=20
> v6 patch series is at:
> https://lore.kernel.org/lkml/20230117134139.1298-4-
> nipun.gupta@amd.com/T/
>=20
> Changes v6 -> v7
> - Fix compilation for x86 environment in case CDX bus is enabled
> - Fixed crash in reset if device is not bound to any device driver
> - Update sysfs with typo and other minor changes
> - Removed header file issue reported by make versioncheck
>=20
> Changes v5 -> v6
> - updated compatible name in the CDX dt-binding
> - updated reset CDX device and removed redundant function
> - moved from drivers/bus/cdx to drivers/cdx
> - used xarray instead of controller list and ID
> - updated sysfs documentation with more details
>=20
> Changes RFC v4 -> v5
> - Fixed device tree documentation
> - Add MCDI as a protocol and RPMsg as transport for communication
>   with RPU Firmware instead of using MCDI stubs.
> - MSI patches for CDX are not added in this series as it's
>   support is being revisited as per patch series:
>   https://lore.kernel.org/all/20221111133158.196269823@linutronix.de/
>   It will be added as separate patches.
>=20
> Changes RFC v3 -> RFC v4:
>  - Separate CDX bus and CDX controller driver (Greg K-H)
>  - Added MSI interfacing to Firmware for writing MSI message
>    to firmware so it can be provided to the device.
>  - Fix MSI review comments - multiple cleanups (Mark Zynger)
>  - Fix the device tree yaml compilation (Rob Herring, Krzysztof)
>  - removed vfio-cdx from this series. It will be added after bus
>    support is complete (Jason)
>=20
> Changes RFC v2 -> RFC v3:
> - Move CDX bus as a new bus type in kernel rather than
>   using the platform devices (Greg K-H, Marc Zynger)
> - Correspondingly update ARM SMMU v3
> - Add support for vfio-cdx driver
> - Updated device tree yaml with correct binding information
>   (Krzysztof Kozlowski)
> - remove 'compatible' sysfs platform patch which was required
>   for CDX devices exposed as platform devices
>=20
> Changes RFC v1 -> RFC v2:
> - introduce CDX bus infrastructure
> - fixed code for making compatible visible for devices
>   having the 'compatible' property only (Greg K-H)
> - moved CDX-MSI domain as part of CDX bus infrastructure.
>   previously it was part of irqchip (Marc Zynger).
> - fixed few prints (Greg K-H)
> - support rescan and reset of CDX bus
> - add VFIO reset module for CDX bus based devices
>=20
> Abhijit Gangurde (1):
>   cdx: add rpmsg communication channel for CDX
>=20
> Nipun Gupta (6):
>   cdx: add the cdx bus driver
>   iommu/arm-smmu-v3: support ops registration for CDX bus
>   dt-bindings: bus: add CDX bus controller for versal net
>   cdx: add MCDI protocol interface for firmware interaction
>   cdx: add cdx controller
>   cdx: add device attributes
>=20
>  Documentation/ABI/testing/sysfs-bus-cdx       |  56 ++
>  .../bindings/bus/xlnx,versal-net-cdx.yaml     |  68 ++
>  MAINTAINERS                                   |   8 +
>  drivers/Kconfig                               |   2 +
>  drivers/Makefile                              |   1 +
>  drivers/cdx/Kconfig                           |  19 +
>  drivers/cdx/Makefile                          |   8 +
>  drivers/cdx/cdx.c                             | 553 +++++++++++
>  drivers/cdx/cdx.h                             |  62 ++
>  drivers/cdx/controller/Kconfig                |  30 +
>  drivers/cdx/controller/Makefile               |   9 +
>  drivers/cdx/controller/bitfield.h             |  90 ++
>  drivers/cdx/controller/cdx_controller.c       | 230 +++++
>  drivers/cdx/controller/cdx_controller.h       |  30 +
>  drivers/cdx/controller/cdx_rpmsg.c            | 202 ++++
>  drivers/cdx/controller/mc_cdx_pcol.h          | 590 ++++++++++++
>  drivers/cdx/controller/mcdi.c                 | 911 ++++++++++++++++++
>  drivers/cdx/controller/mcdi.h                 | 247 +++++
>  drivers/cdx/controller/mcdi_functions.c       | 139 +++
>  drivers/cdx/controller/mcdi_functions.h       |  61 ++
>  drivers/iommu/iommu.c                         |   4 +
>  include/linux/cdx/cdx_bus.h                   | 174 ++++
>  include/linux/mod_devicetable.h               |  15 +
>  scripts/mod/devicetable-offsets.c             |   4 +
>  scripts/mod/file2alias.c                      |  12 +
>  25 files changed, 3525 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-cdx
>  create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-
> net-cdx.yaml
>  create mode 100644 drivers/cdx/Kconfig
>  create mode 100644 drivers/cdx/Makefile  create mode 100644
> drivers/cdx/cdx.c  create mode 100644 drivers/cdx/cdx.h  create mode
> 100644 drivers/cdx/controller/Kconfig  create mode 100644
> drivers/cdx/controller/Makefile  create mode 100644
> drivers/cdx/controller/bitfield.h  create mode 100644
> drivers/cdx/controller/cdx_controller.c
>  create mode 100644 drivers/cdx/controller/cdx_controller.h
>  create mode 100644 drivers/cdx/controller/cdx_rpmsg.c
>  create mode 100644 drivers/cdx/controller/mc_cdx_pcol.h
>  create mode 100644 drivers/cdx/controller/mcdi.c  create mode 100644
> drivers/cdx/controller/mcdi.h  create mode 100644
> drivers/cdx/controller/mcdi_functions.c
>  create mode 100644 drivers/cdx/controller/mcdi_functions.h
>  create mode 100644 include/linux/cdx/cdx_bus.h
>=20
> --
> 2.17.1
