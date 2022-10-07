Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352795F7BB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJGQmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJGQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:42:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A7271711;
        Fri,  7 Oct 2022 09:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx2xiM+zlPqCOJNjNwIth2HZRlAERXc8L6joc1CvQ22z9Mq5E4/AsMMtdqZHZANFrOF9snDaLm90TdifrFkGPHToqfjjHjsQYg4UW20GnFY5fNZkqlfZZcipZKAEo00hc+1cv4tTIrmSTGhzsxR3/7moI8Erm5S1FWKHX5U8hGD46/LlEvc1jPn7zEoIFsyhOLKHNDMFgg1FceQGBuS0kTJ8aL0NCOSdBi8d/eurc/fRFQIwhEPhAPPxdwZEU+JSmkJid4CAVTPZDsrfgUDVE5m6p/cFgVvIYFQ0+qZmiB9uOGvheMVJThY6esR/HixE3d+ZZ2TwWRGARk6kftwrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHFLiPTkMQf8JH//yLqYn4coJ+0wDay84nTpwsGfW+k=;
 b=glHkvDsJLxYwmk9Jj/kouhw4CcPbM+Oy+nM7NPmrmMa3HAGAwwyj8DMKn73bE2uwyWKyb/jN+3hnaWLIz8gG1d3aBBGCGe45y0t1rVZO/4LqTXypo4wbUC4UttHEl8XrVXfPIsmjzjtjkP+Mn4zRXneUM9F5dy2ke0xeVGJtAHbFZ4l7p4ny0jRmcDJzPL09kZVA0OHDBdN/AhpSOrn1Rip43rOvx1sD9FqhzzCu/wG8qXw0gQFixp+xbea/WaT3ovUgRzuwxgo8F2OpWDxgRKFHIn4u29aqG6MgQ/mdgthpQ4B2D8i5L1ldG71gZoFcJhtl1A/ThMmqE2h++kuDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHFLiPTkMQf8JH//yLqYn4coJ+0wDay84nTpwsGfW+k=;
 b=LM6a6i3VPUVENf19v4OK4EJKe1BixYHRsrSuXlMvbgXNQd/pqEuMVrJssav2mORfUs5nQQcIAnIV3t/aj5/PIajRiydDGZs8TFZNDSKEUZwgt3jKxKcigZ0G4ayYrRg89nWKXQ8o6NaEaHrVcouwYLR5EsUiwefZsurNgGI03Uc=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 16:42:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Fri, 7 Oct 2022
 16:42:36 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] xhci-pci: Set runtime PM as default policy on all
 xHC 1.2 or later devices
Thread-Topic: [PATCH v2 1/2] xhci-pci: Set runtime PM as default policy on all
 xHC 1.2 or later devices
Thread-Index: AQHY2cjK55dRaswYc0+X8qxCkwxYqa4Csi6AgABxcDA=
Date:   Fri, 7 Oct 2022 16:42:36 +0000
Message-ID: <MN0PR12MB61013B3B55D21A49C2450B1AE25F9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221006211529.1858-1-mario.limonciello@amd.com>
 <20221006211529.1858-2-mario.limonciello@amd.com>
 <Yz/3eeVjx8v6/MJe@black.fi.intel.com>
In-Reply-To: <Yz/3eeVjx8v6/MJe@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-07T16:41:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8d4202c8-2da7-4949-87af-70a23bec279a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-07T16:42:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 58f3576a-4080-4d28-80af-0f71190b5465
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN2PR12MB4112:EE_
x-ms-office365-filtering-correlation-id: f09b68c4-ca48-4d6f-9143-08daa882f0f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q71fSiaC/qtdSJdwXpbquS0MSSVOOYwwRrmMuud7e722ghxc+Pctq3l66uSJ51koJeXmPQLxn9cjOAG3/IzTFulGsenPyEm444SR69bVzcQDmIuSfaHA6gdH2Cvx9Wl7v6+7PUQNYYc7n+DyqeYZNtxS/m87S/NGiQvAadCYOCC38obTlpBJ7MLWinJfZZjgHsmp+i5vHf4Z17El86n6oPQtRSyZAaE8mG/caBc0DEMKjkxYzGiHSiNVfs9gmv+vzY3rC/m64w6lyjlahZtRbGOffqhTu91wmbcek20ZB7xvAR5mADsD4fTmUThkm6OKFFZXYI9EFVgGSOt7mwI/NIPEqRurb8wpgKA6rsOOyzpS82QplQvkC/rkKfsPkd6nrBWsrB6ixfaSX1MwcyaVORYnm9n7L5zSfRqgS1QEgKsC56R6b8n7VZxR2XQQiHD10sWFjbdC5Bj0qGkc6k8u7wIagCO1FMTW0Wg0onNskvpzi8+nhAZXrkWGWrW/H0qsKsN0FEQFvCrKmLX/X2gFmO+iOPbrMifri4kkVZn5Q/M4XC6Nm+r3JlGSimtjW64briPaP+K/eU1/pNKllSgiXZbSIn8WzfqJsfDarfXdyEVcc339Ug5gtsGafumUni/JqvxAfzOl4c1WL5ZmhJCb1P7Qkp2Ujbe5iYyyhS5rTuSB6et5NCwVqI5v6MXzI5TEJ/Ipzi/CrjU2B4nKVYkDsG5gRRR1paFt+ma8jmIPSSfX2VgxCD2v/6QE6kQ2+xUEjuaydcnjDguWylIaf7acuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(52536014)(41300700001)(2906002)(66476007)(66446008)(64756008)(8676002)(4326008)(66556008)(5660300002)(76116006)(8936002)(66946007)(38070700005)(55016003)(316002)(6916009)(54906003)(38100700002)(122000001)(71200400001)(478600001)(26005)(86362001)(33656002)(83380400001)(53546011)(6506007)(7696005)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?veYtK+lHmlrs8N8xAmBKmgjn9lAavMDkvyEHNCvIfQlr+TZy1v8GObUJA51H?=
 =?us-ascii?Q?YFQYZ4DbhDc6aHs5fZNqV4EQnmKlJHmyCksnqYTicHn2s/ifRSFSoEuY8VA2?=
 =?us-ascii?Q?+66pln+/ORCfcHMype8Mz6v2cL7BaiuFT8jL70ovH1n36C0/6+5co9Zcteae?=
 =?us-ascii?Q?OMLARf+yKyYZhswALPMPptYmJDXbDVkkncWZWmiCYqRU3KGlliJdwTgDkuCY?=
 =?us-ascii?Q?v8DvTnBI+8Wfyo9xOLuFL3cyNLiDvSUZEDskrzcdnpzKvcuDjCIBGRFtMQRP?=
 =?us-ascii?Q?TRD/zOxSJClM/XqK03AnKZWRS9NALB0+/0Xx1A73HsklgwmDAE2OpQqxBpYk?=
 =?us-ascii?Q?QCc+9dSamyF7qKYse0nU4A1+SE5qMpyYEdSK1LeybZzmYJ9xdoo+h9CCEoHa?=
 =?us-ascii?Q?5aQku58h/Vh5zoq6H55X5OeB7Xdea0GRHUEodaAPOWIZUO0pxV8v7YolCLV6?=
 =?us-ascii?Q?hHnYGbV+mKmDc8MMBhV6Z4ArboFyiQA7y/rIVr5mXu9OTXN2PFho2rC6jAHz?=
 =?us-ascii?Q?oKwuZmAiLzmZ6gLCNhEyNThzoN/Yv1xiNFCyXob4h0MOwYiwqiZZLhRxSXSw?=
 =?us-ascii?Q?uQGknjKWOQ7CUw2TqBndK/POBfHXMzgIE2Y5U/kkxR2nqDxuuFfbRZOviqFq?=
 =?us-ascii?Q?bEvMCHxrJIDL8T4FNkPeGZUa44Zj8y9IFEBMHl+nzf2NmXgPO6fKsxUaEQWr?=
 =?us-ascii?Q?ajMdqC1rJVw3KgE3zY28/UrS/C5NLhkkYx5zJPJODGbxc+HwSNZxyvJUBCHH?=
 =?us-ascii?Q?BDGzaPYBctFDQoiFkjSgGN39jbUZ4T4xQMELyZe4R4aNMsPwSz7qfbEHYYJI?=
 =?us-ascii?Q?p+cPzM0B1ZDdIFONeJsOToFe3oYm1X6DxoHtA48HGWqt99EV3DGYGvcogAbq?=
 =?us-ascii?Q?wLYQE5JFt4aAQ44usTYQm13NotaG1HRA7U+v/Ff3/jqVkh8xuV/vH4nOCI40?=
 =?us-ascii?Q?kp3Lw/3D84jvwpr6gp70enJ5cXwBhYQz6NcHSvAxcO+mUun8J4f91P79XTss?=
 =?us-ascii?Q?MXjfPkc7FUCzxNpwHgl4KHR6NlBjotysURrkA4T+Cut9tucNAa5IfLgo4r+8?=
 =?us-ascii?Q?ra0gifLnZZT309pzOjo8+F/aYYvBS6jfUNCt3VrnbpsztbNj9lJsbr7ww7W9?=
 =?us-ascii?Q?UPP0Hf0oDCkQIEfnLFYQV2I7lOaqyV1UgFQZ5va2+v6BnQRFl0WNK0dXJrFY?=
 =?us-ascii?Q?5Psj7or9CSmgqJ8L8pQTFqfoSsSh+ax68BYdYLUmU/PXftShQ71nzwK++Uru?=
 =?us-ascii?Q?+0xfq5ACjD+3+K91qQhESLTiNTi1QVJj5OUKHVf4nr7d3G7jN2BnYXGDfbE5?=
 =?us-ascii?Q?5cXTBM4Fx5e/3NBGVOb+ixyHSe9n+bhFzXejV8cTgkrPO0XOQ3glcMSMNphJ?=
 =?us-ascii?Q?MaWxQV7BPA3jRe9K1a1xN19jQhnty/ZwK8FLmFfDlh967yK3bywij+zsC07n?=
 =?us-ascii?Q?s1L8OvBBwakjC7OJUbsqmhDy4JPy6bQIaKImXOrRfleZ6gFJ1sjY6v7e4m/v?=
 =?us-ascii?Q?jblYqZe9ae++bUzIX4Icbsb3K+UKUjewpYLGrqZRH28mgr+dFvlzyXtXgprX?=
 =?us-ascii?Q?FkGuyPQeI4sQAqpy248=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09b68c4-ca48-4d6f-9143-08daa882f0f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 16:42:36.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDYKwSxX2sWH4IqdnP3y7F8apP/AT0Z3FDskT4kT9gjutZCLPtVczTDYKk5FYFfJTXjX7T5xF+MdYNIlo9Xiwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Friday, October 7, 2022 04:55
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Mathias Nyman <mathias.nyman@intel.com>; Mehta, Sanju
> <Sanju.Mehta@amd.com>; Mathias Nyman
> <mathias.nyman@linux.intel.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] xhci-pci: Set runtime PM as default policy on=
 all
> xHC 1.2 or later devices
>=20
> On Thu, Oct 06, 2022 at 04:15:28PM -0500, Mario Limonciello wrote:
> > -	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
> > -	    (pdev->device =3D=3D PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1 ||
> > -	    pdev->device =3D=3D PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2 ||
> > -	    pdev->device =3D=3D PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
> > -	    pdev->device =3D=3D PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
> > -	    pdev->device =3D=3D PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
> > -	    pdev->device =3D=3D PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6 ||
> > -	    pdev->device =3D=3D PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_7 ||
> > -	    pdev->device =3D=3D PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_8))
>=20
> Can you add a comment here explaining why this is OK? I think it is
> easier that way to find out why this is here in the future instead of
> going through the git blame history.

Sure, no problem.

I'll hold off sending a v3 though until you and Mathias can double check
everything in patch 2/2 is OK to take out and agree with that secondary log=
ic
change.

>=20
> > +	if (xhci->hci_version >=3D 0x102)
> >  		xhci->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW;
