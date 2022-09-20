Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB05BED73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiITTRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiITTR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:17:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51761D4F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Umuq7Rt4qfecwN9j9UPn8d5cXBA4n6Sw9VMS7MDYu0XxCqoOk0FgyV6l9vVB0nU26B83mvl+herMVe++2ken1eLvYtMFojOalJTxDuzH+GxIFkj2/3QzlvqywwX3iHDTpVyeEW5SRMWSBOV7IBMnhYdUBW7QhoDTBkIoW7GdaqvSZGqh1Gpfic2ooiWuLF3090bm4HCuSXYL4itVz4n0fLpmGVF/36xkXo0eZ6NaU9sxY3F7Njaau0JHS3tn4uzUa5+p5p7wX5CE1OUNqV5VXihmX3HPpnBBKqJ1pbr/0PR+cAvDvry2Dlwthakl8gI434Z5iV3b6+mtgRDJUs4OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1++ptXMXQQjXaSpqI/QhCLlnNMIK6DOJH6HIldjRyc=;
 b=SMXRbWs5ZnMEjWwRXtbLUDT9HmMVxyTx2+5RfArK5PqVeZSvf3dQZB7/fbt70wknNdkjLSJHXFMTfLztCqWMz7n7FPJ8RWyNRw8fMXeOZ6Rk51mrFkQ/vX47utOBEAn/rFdTmHxJk2T8y63xwuXxtBncKDw39h9dpvOQwhRpPSVtPOXELHfXc/55mSl6dErGGaYunK2jpMuYmnkr+bTjaG+NilY2DkGnzeLj8mVAHUEQHaCkCw1PoBqZJy0lH0YSAndqJb6W8YLAZ3ha7AKA13oD9gLHFCmoswEoKj2A06Vs/ywFIGnexkDo9SSxiH7ugu2uifbi35CdSfMeS3SKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1++ptXMXQQjXaSpqI/QhCLlnNMIK6DOJH6HIldjRyc=;
 b=LSp7Oxkf3q2nrb20BPb/fVdQMUmNOT0rbvfMnUhLj9novylIgBEzTm3YcCxpWCpCiZKt1B/CcUzfpM3Tksk9QNnoLmDFN5J52SIczC+AJtB2RT+CoTFPMac5FnpJDMuMtHXZ+XHwX/sYlGsFxi0I2St7HwSbq8mFl807d7xMoR0Z9uFGYl9SBBDJTxon9Yw3kazBTEXunbalBWttjDfWvBiCdnIiNmIgI8C2kLp+KGHYryUnayTRlb2YpS1yoCGIzc3x4xiy3J2N2944oF7hXOrQeUyuRn2vQFefsYLc2FBBydIVw1ZczsIKtrpBRnQccIX/93BXER123j9D6d3AWw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 19:17:23 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1429:e3e9:dc54:ba98%8]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 19:17:23 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     Eli Cohen <elic@nvidia.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Subject: RE: [PATCH 0/3] vdpa: device feature provisioning
Thread-Topic: [PATCH 0/3] vdpa: device feature provisioning
Thread-Index: AQHYyOBJr1VSNY1wu0yqqTgKlaS10a3ouSJg
Date:   Tue, 20 Sep 2022 19:17:22 +0000
Message-ID: <PH0PR12MB548115F4597D409F94AB1E77DC4C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
In-Reply-To: <20220915085048.12840-1-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7649:EE_
x-ms-office365-filtering-correlation-id: 754ac0e8-673b-43e7-cd94-08da9b3cbefa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K5Kdd+4n9hNFkzwYRmCCOjJVTl3BzvU1aYRg3nFskFtyVMIUuZe3g6GQmj+Bo0DH5DAobMd6xvi9R8pHnqm1SgT/zoblNdI7BCqr4/pa9CXv1F8URkh0OnSVZ0KeM2boB1vzhz4q8KWSu9OPKDka/uph2qaXirS/adz22sxuD7t6fF4ElLp+8icc8zoTNcTnsfuE7jv0/kH5LBbodTaK03AkOSHjU1YG8dB+CzrPEaNIPHYCf3HVw2rg/J/V/Q2PQKjFaAUOWu9fi1qeCAJ9g2A70qbM0bBADw7Us3AEY9iRzYfxC6ctDDYaZAAnDm3TxWxzWOPZ+JuBQmL2CjgG7cb+OGfTjhnIh47hjrh4Y6AISxNr5AD15PT/dg7BsgRak0Oac/18q+VgeK/dACbsA4moXYOYXuQtZCqvFA+3nq1/WOy8cwuE3U7L2vKhgfQWSY5yPK3KoPe0MIP7FJ5f3gRCMJz1uSrfmNVsKELqCe3MEyhJe7ofFdJ7RJnx99yG5WVsb4eyFAh7dQLjm/r1+D0UBnV4Lr3j8ktm4fnnFbIBEdSAbiV0O41fb1lcfq1b8cKh6LlCGiWG74IuQZjs++TR71+9NZbTYMIVo7UXPrCYSZ6vVMZW0b6eqsHuPlZfqGMxWRZ1DgE9tcErCTZoSNLjGtR8L/7fBUaE/cZZQHjowgVD7NXVoIzWjdgGksQSLHMjp5UAd8fmosj+EgAwexpcaJjIl7VMio2ffxq0QHfRVqjC9IaCqMh1d+BqX1immInlxpoyRVfw0x2Kfxi/Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(38100700002)(7416002)(122000001)(71200400001)(5660300002)(478600001)(55016003)(8936002)(41300700001)(86362001)(66476007)(66556008)(64756008)(66446008)(7696005)(53546011)(26005)(316002)(110136005)(52536014)(54906003)(186003)(38070700005)(76116006)(83380400001)(4326008)(66946007)(9686003)(6506007)(33656002)(2906002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pSYf5CWIZvE8+B/gHGBkCoNBPjPaCwXrt7SE+zDY23VN9INdrnf+vr5cINmx?=
 =?us-ascii?Q?3mxFoP8M/sN+47LYZ4R/gQnBB5REIG7Cm+h8bXqffYihdIjZehFn/+uQQMFg?=
 =?us-ascii?Q?Jq7D2XHWb981u1nw/0h2Q2yq0WMxkmSDVhZQpvSXxX3JNSqyekN2gRaHG/LX?=
 =?us-ascii?Q?15yQ6M/SAgrYkPTmL638He4NZxhFwe1qGQ+HN1cYzmrDSPrrK31vt/CY4nrk?=
 =?us-ascii?Q?CruQuzYjlfHlr8Y4HocW0LFeB5UpxueCbvOrsFxq0coZloemu2+rmhrQBotG?=
 =?us-ascii?Q?LL/Qz52L3SWJSujA69WiVx6h6McJ04BxDZqAlPO5U3EDSOb5mQIdw/fqwkYV?=
 =?us-ascii?Q?6LZvVpk2DPEXZZUILNtwtpwr7k9Jdfjrct4/oy8gRJ2tCK8Jtw92bGbIKXH0?=
 =?us-ascii?Q?1rcZXDhfZA8uZXAFRDiBf05lJtfcamBskS360FiIi/q7svvW8vkhXHDHX8Al?=
 =?us-ascii?Q?79n8fXsmjsA83tBq+LRaVEOw0of7mgOEjJnJFSCo8o97AjwxWiGpDB193A+g?=
 =?us-ascii?Q?4DWe/4U7lN2cmW85PHlOiTnC5sTGuCpZ+jaq2kif2lERppys+aAjHEAvdNt3?=
 =?us-ascii?Q?qRywH+UJsETvW0hTWdWafKE2LoUoO5OYkgaACfxd0EFghPxk3aJ5LG9UEwrT?=
 =?us-ascii?Q?jzQHg5EduUCPu5egT4Vgd6yTx+qZbQn+Xdy/Rf8PPBZIkLDGCLk6uGHnDEcm?=
 =?us-ascii?Q?5Rij0M6N7eePmrCWFueaX0idPm7WJS/9Gv9u6ZLYzLzwg0kZN0zadVwz+vcG?=
 =?us-ascii?Q?3V59SHg1peutq1O9K2iGQne4dOfs7BFrcgnI8SieTeq0OhddoSYWGOH7+wYs?=
 =?us-ascii?Q?gyEFcciOHpplFAIlUKcRTsOk2wvicqzCFKAfsTNgW5jQkC3Gsa5uNodJX/6i?=
 =?us-ascii?Q?WFkR9CUypzb05dx/un/7MHNg0TaWRKv7BEEgV75sMUSoXsLyz54xCveDgnlX?=
 =?us-ascii?Q?yWP3d9Sgpq7VEFaz3Tz8gCqBuLZSX7JbV0LGZWo4DAK4cSjvuRlDXPrFzX6d?=
 =?us-ascii?Q?86ytOV/tWFI7fvP89kWt4Gc1tWoZadoODkBL3PDlj8EW4GXRN/dFsA/5XpcQ?=
 =?us-ascii?Q?pv23glSN8VdHanW0WXeQc+9PgPk/UBTYnh3HxrfPUTlyEdz2YbFKV+qoBHSB?=
 =?us-ascii?Q?2xtks1WXAiJYP6zcLemW+WZ6gRI///DqaZekI+XBHHJjgRYA+qeFqtXZca8A?=
 =?us-ascii?Q?J/FztG+1Te6fdUuOwECkRkh6mCuKZ6Iln77X2w6thHUeuKW/QjJg9vJfDwUg?=
 =?us-ascii?Q?+SYiEIQPTBaOwHVK0SZhQBAfx0SULDOBFfQxxc8IChbqExS0LkrJAWE38ORr?=
 =?us-ascii?Q?GaOj+GGdLNZ7cmfEkGafFZS0o3XEVnJd7aU+/cveWrse/X2+D9cyh9hNLuvm?=
 =?us-ascii?Q?20QYpKT39JcGFDskZ/fZX9YJkkqHoXozKwD8UEVXsctsTYSXYoKVXDaHcnGd?=
 =?us-ascii?Q?iILYfw3+T8Azox4Mf67uJKn09eKw/EffYssqrNt+g+kwmpFv0BRIYr7EmbrQ?=
 =?us-ascii?Q?5DBKg1/KZoBDb34YrGNel0UEgOmlKPv4zIQLU4bDxou7EncR2bGBd/sxLyfm?=
 =?us-ascii?Q?UJVeceDl1R0v9X2QUqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754ac0e8-673b-43e7-cd94-08da9b3cbefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 19:17:23.0172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srYZwb/OUaYi+X49cmsYPeJxBlOIMmdEizgY65pvqCm2yjajQGXDRmwZ6G66bj3da7pNG/Tvlvxeeh3NKdyI2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> From: Jason Wang <jasowang@redhat.com>
> Sent: Thursday, September 15, 2022 4:51 AM
> To: mst@redhat.com; jasowang@redhat.com
> Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> lulu@redhat.com; xieyongji@bytedance.com
> Subject: [PATCH 0/3] vdpa: device feature provisioning
>=20
> Hi All:
>=20
> Virtio features are neogiated between the device and the drivers. This al=
lows
> the mediation layer like vDPA to hide some features from the driver to
> faciliate the cross vendor live migration:
>=20
> vDPA on the source supports feature set X vDPA on the destination support=
s
> feature set Y
>=20
> Management can simply provision the vDPA instance with features X&Y on
> both source and destination to let the vDPA can be migrate-able between
> the two vDPA devies with different features support.
>=20
> This series tries to allow the device features to be provisioned via netl=
ink to
> achieve this.
Very useful series.
Can you please add vdpa example command with and without -jp option in each=
 of the commit logs?

Thanks.
