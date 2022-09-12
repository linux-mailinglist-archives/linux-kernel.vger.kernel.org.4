Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271265B5CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiILO7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiILO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:59:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D5D3AB21;
        Mon, 12 Sep 2022 07:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBco2eIZEmD4IZXj59xyd1T2p6ujt02psm/u+yAd8/kp6GNDqpl2GVEPIhiEEMLnsSQQ7d/AqPNQUg/oZovH3c+6lkhp/fNWcgYL5o7v+XWcb5nYqtmLC7oUqcc1irSAbB9ZheecrDGFheFuKGjEGSuJMDxpntJi5lcqGRIBu566NKZvCIjaL0Uc4EXfLUQqe7ysw7zgm+hLLSrCYVOxpp4RLeiEtP9md7iHNXLURPfpUet0AISB2hHFwL+1A8s3+4LfUQYPfKVb4fDc/9TE2YcgrH0P68+F6KKzeSw6X3tdT8oaIEK8rvV3zw2hbBIgsEZP1J70gy6w2CWKuFWB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGWsw0jqQ36bm/zGeJ07qSj6jS+V1t+FRIBZbkhBXik=;
 b=MRSHAjt2bKwd67QR9+yZM/ZPFECdqfxpzxZeQymE2zxoqhY81PUMSmVruKEJCzOV0/6nPQOi1BOIo8vOQi3uB1B5mNi31IrOAP4rPuYVTVKHl5EwZsZzLIiH4CFcB0GHnid4049Iuv03uNqm95JZz8nYhT/vsDjI7Zw6bn0uquceZBLcfRl/EAWclC6zF+Q9io/6aWswV1ABUhcHgfvanZjrEIjml8z39Yj7puDKv0oqY4wN6B1WZNgVH/ymE7/SM1bo0DWa8vaGKoCt1JWKarZwYzUoAv2K/uOe6dOYd0HT1vGta+nYVKVjmri/2BGvlz4hF2r2f1r3rPh0tX5gAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGWsw0jqQ36bm/zGeJ07qSj6jS+V1t+FRIBZbkhBXik=;
 b=C/s/0ERfSd8Q2C++yLM5Sz1UgtHOyqJ9shWc7gvwos4eZi2IwnPD2G0pNVBNpUUNEePWo557uApAuMOKXzqlmThf/Z0SZUQuaCPfcbxpj6PE9ZYHl/Yr5Y6MGnQl+Gp2UHM6+QCv3X+R4jQdf5h+vQQFjg5oiXCx0HpG2wchA4M=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 14:58:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c%7]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:58:51 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Philipp Zabel <philipp.zabel@gmail.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "catalin@antebit.com" <catalin@antebit.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Thread-Topic: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
Thread-Index: AQHYxHa9Vv+M6MQ4hU+iFAXLUHOdra3b5t0AgAAAInA=
Date:   Mon, 12 Sep 2022 14:58:51 +0000
Message-ID: <MN0PR12MB610147F4362BB95B7B5397B4E2449@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220909180509.638-1-mario.limonciello@amd.com>
 <Yx9ItlBjl6bxxu2H@rog>
In-Reply-To: <Yx9ItlBjl6bxxu2H@rog>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-12T14:58:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6457929f-813a-4457-ab6c-e2d7d5f43c99;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-12T14:58:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 543817c3-7284-4493-9ecf-77017390b2f6
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB5182:EE_
x-ms-office365-filtering-correlation-id: a019ca22-f4a9-4fb4-a28f-08da94cf4de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKWoNkNyG6xPiTxy8i5/3KphDUMBShWLTk6SVT7OPPqB+XGi/S5VYQS0Kv/OomuwSYG0GuuF/FX7Lu5pu19yWxlgifN8o3LnGnvJRDvXSECfMs/eAamE5cKIhDfnm3dT1fwB0HdA9p6bmUoraJbnWQfEiiLAuI0xnW0RHqhuXfvFeRqR3a0S3dc0hIPoOpUTCss7RfGlD4JUOHjHmuww9D+cRLBTrd3N7Dx0ulJDI2tSzlqBRd27TVAcOJ9NtJGzLh+g1n16OYcOpVW1x0ts25uXwht6dZY1DB4146+aen9PqanpceojyZMLie51Umbh6yVajEIkKlyg73DtqNJFKpQqb6jvMPM1UsgGkSBpsTjzmh2n0eBnFdXDDKTwTipYQdanIFKs5WH7IxtyJRGymtFv/hlw+lXK2X7SZo9ThSc3QqlyOOV3/UZ0eiSVh8xnf1sJUwliZuMatOzbSSVGfJwCVbj8kvkKjh3T56IDNHTEdWw0Tg7K1aq0IGyLDSgv0NUiipv6aMdMxEd9E25Oo6bNqm7p5TIT90D9qxqimT+Q1Xj8f7NGmVGtMwYYwAQIaCOv3LBIbFoJ8GRtW29EfrTk6TuXFgfAwHxucAplMQrLNV54ZelE3dYPpYIQmGiAIXJK4f4wwNFhEfORMHOy5eVol8KhmgzRALl5aLmZVJisPGFVF7bPfAfhheK0wf1wuKOtcZnK9oKU5Kx0IljU0m0IyABN8zxpV9Drjb+sMXkabbPuc9wj3Z+zLTx51kkVzKLY8tUZJZzgaSCtTNgFdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(122000001)(38070700005)(54906003)(316002)(6916009)(45080400002)(71200400001)(38100700002)(52536014)(76116006)(2906002)(5660300002)(8936002)(66946007)(66476007)(66556008)(66446008)(64756008)(8676002)(4326008)(186003)(6506007)(478600001)(26005)(55016003)(83380400001)(41300700001)(9686003)(53546011)(7696005)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ztroZBESCpcke5Urf/1eb02+GmyxSv+I0LwsyjF98KxEOQ3brOMa4moU2g4L?=
 =?us-ascii?Q?6yxSTc7PtK0Ed4WUqSxF5BdNzBt6kpEX3vKQ9MF0LBFUIp5J/0sYK+fgmDFn?=
 =?us-ascii?Q?rHU9kivMzTWk0uFpdO8wqMGWwkrUOKKIAvdv1pHvqbGYj8O8BHdR6EKvVclH?=
 =?us-ascii?Q?jTuVlPMmrTUMpzLxNQm6aDodZgCLzZa8FjQXcow5DNpWygJnLDgRZBAH5sqh?=
 =?us-ascii?Q?WC9KN/Ztyf/FtHNMWishOjmn4zIuW5w6alTcnGq9BG9RTEVAxOthMCUOc14a?=
 =?us-ascii?Q?IbQ/8xjwufDrG0bj7a3El10OwfjA+itiRdtpZWkhQ67emJDx86J+EeiaDUMN?=
 =?us-ascii?Q?iuo0qD7JCCY/2gEqQGQ1yXID/tFvHl0zsX2BcUxkTO41tR4CwxIwMTZJc7vy?=
 =?us-ascii?Q?ZBTUAJCPDI5spA2ysz74D8J5rAkdVDo/N5nRwweyclCmAo2XyK2mGdVT6zrP?=
 =?us-ascii?Q?ZqDGqbC7JizpgOt+v/595qcUJBrtSR6KopkT+L/18z2f4Md4nM1jYCgU97qv?=
 =?us-ascii?Q?FW7a4ycFgoxl+9zL94sZbevkaV3R2asjKbJeO8pyA0ii3/k2pmxFLm/wC+oF?=
 =?us-ascii?Q?RugMilb/RShnmNpnGIAaVUViDUDgajdtMy5iXR1NDrmT8WdimnaJcm7iwHrE?=
 =?us-ascii?Q?5zbDBdhUd9ouvXAoAGpszBVIaSdNNs8wNqQk1rp+ZytZp9v8gR4+XUf9H0BP?=
 =?us-ascii?Q?60TMtEYiICw7WUnPh9Ksb6rmHEV1tyX6InMNuGI2BSbUsGOCfy0abhjq+2Gh?=
 =?us-ascii?Q?qRIrMJu55/GwLPokH+WkqgUcYYk7wLp05cqb3RAr6iXG0ow7vOKA+aFAjZlF?=
 =?us-ascii?Q?XjTklhjo94AKW3iG7aZzyNXqjXQyenL/s4TRHZjSi2kvLRQ6TLPU/Hu9ZoyF?=
 =?us-ascii?Q?uD0oWPFd1Et01P92rU+HO7nUoq3fIqUdLToDxZ3yfedR0wGyMjJpmEJrmqop?=
 =?us-ascii?Q?kkK0bFLx61tNwZzNr6mvfI1slZbJmVgtrTGQfSpw2fLgJZo0FlzHzmkbMETl?=
 =?us-ascii?Q?GNtRjcrnwlG/2e/6MelJha0rd8E49EQHJf49Zumb9UyZSh+ZU44j6bHPj+Vc?=
 =?us-ascii?Q?u48Xio9EbYnAnOAln6SOIzBvcnL6rEu4ubiI4Z4lilVA14Wm3h2Bi/3QIv/9?=
 =?us-ascii?Q?VLoPB7Y+d/rh/1yN9S548e8mioS5m5PWRT/5g3Xr5pWLoF6z2IyI2j07KXA3?=
 =?us-ascii?Q?HJW5iHtQd/74pDJ0254027NVnqil/PSMRJ3HTZyGZK4MPIXxHTNxitvXFcSn?=
 =?us-ascii?Q?LELvjM5eziX7pWzmCgr8URwj9pde9FBYaqhowaNZCYKzZf5WeCv5cpoeje2d?=
 =?us-ascii?Q?LmogtJIJWzzFlf5dg6ATZO13rsuQ9htqXcin4cwOti1qKUzrPIV+TaDpnh+h?=
 =?us-ascii?Q?pBox7BtS19FfslC4nFxLbuVGMs9vNhZ7kLccTLl5BmLITRiAGmCWYGGBLU5p?=
 =?us-ascii?Q?gF6dNEXI05K3xlKPaftta1dwZZQNQDY5uSg+KDaXF8LPxGko/9gicD0DWr9/?=
 =?us-ascii?Q?H+Mpwa5LElooyWvPrAHHe0rWMKczM2gyIiS4YXP+qZpaZOe2kkyEcKvOiIPW?=
 =?us-ascii?Q?zCIa4QYlc1Ulrl1gHUs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a019ca22-f4a9-4fb4-a28f-08da94cf4de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 14:58:51.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CbqcJdc3bzyH3PUzRYtZfr8ePuLdSXXuzqxP9VkqsN48g6y2wbzJuVeaeVueMs0n3QcrvbkWth/Fn+WAs5PDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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



> -----Original Message-----
> From: Philipp Zabel <philipp.zabel@gmail.com>
> Sent: Monday, September 12, 2022 09:57
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: rafael@kernel.org; catalin@antebit.com; S-k, Shyam-sundar <Shyam-
> sundar.S-k@amd.com>; Len Brown <lenb@kernel.org>; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/4] Fixups for s2idle on ASUS Rembrandt laptop
>=20
> Hi Mario,
>=20
> Am Fri, Sep 09, 2022 at 01:05:05PM -0500 schrieb Mario Limonciello:
> > It was reported that an ASUS Rembrandt laptop has problems with
> seemingly
> > unrelated ACPI events after resuming from s2idle. Debugging the issue
> > proved it's because ASUS has ASL that is only called when using the
> > Microsoft GUID, not the AMD GUID.
> >
> > This is a bug from ASUS firmware but this series reworks the s2idle
> > handling for AMD to allow accounting for this in a quirk.
> >
> > Additionally as this is a problem that may pop up again on other models
> > add a module parameter that can be used to try the Microsoft GUID on a
> > given system.
>=20
> thank you, these also helped on an ASUS ROG Zephyrus G14 (2022) with
> BIOS version GA402RJ.313. Patches 1-3
>=20
> Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ

Did you use acpi.prefer_microsoft_guid=3D1 for your system then too?

If so, I should re-spin this series to add your system's quirk to patch 4.

>=20
> regards
> Philipp
