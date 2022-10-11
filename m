Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E05FB87A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJKQqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:46:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8EA5719;
        Tue, 11 Oct 2022 09:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIJ+l5pM+cNH5b3Qo/OSV1Pxds6pJt/9372mbTXLcNr26d2wDA7z/6S48YPRFneAyLzKnY/+LL7qxYgauJYj2yEcrewDnrTMExLjRQuxW8I583buFGj4AqvY/5pfkWZCVhtKDofUO340pT8x7jaX5lZIUkonqD8HFf2hQI5th3EI7tc9cy3/2V6oI8qzZ00pJa4Ic/6ne+6CEDYC1z4F56ekNYCxgwPhevGZA+EetYt28fYE+v8FLxmTy1JApBtcmLls2WHL3tWkXiz7t+qvaj7K5WMogEk4ognpFSfsF1Mp744XdAf1Hn7SgLq+JB9wR1hZaEbf7UjnTKJlfTEZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvkkvXkr0FYnegQtX6+AFYwSoq/cJM8dHufT4PVJhVA=;
 b=BGk0zqbuVx/JzOgHD8+pG+p9rTrz7DVEVui2zN9dpLcCU5h7sLlOn8r//XIJFMrLRDoah/Xk+Fy+Wkisv1qZEOc1gfS8ScUkpdh6ZULiuVn9W2qM6U07UoA+O/0TM3GZLOzI2H7wZTBQI2Oub5aC05dHbP+9WcJTfnqpsDetKxycS16ngqtacHhUn+J+iZNBfS0oAx3uhwmWx0UsL5lLZ/q7sZEowF+tgKbRKeS/G9/h4LaYpNvtnaxKkqTHQKXSgQNC14/NK1PVgjwqss+VZTpvVbzUVXcJ2Zj+GrWWFqIegeOZEFAALWc4q3MiZgUIbtxPosktNRPDMOS1KtP7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvkkvXkr0FYnegQtX6+AFYwSoq/cJM8dHufT4PVJhVA=;
 b=HKlKDW3moSvHNCcj19e5nLamkO8aUlTTiL849SnvGYD1bO7ipgecYLwwQYImbNx1NfCncMQZctVXCp0+Mub/YCofdGko+gAq+OrgitSliaFq7lduJEd60DMe/v23Zq4b3nSfjXUkYPCAOLWIpYBzbpJmBy6tdjH0hjxvGfBGFlk=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 16:46:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Tue, 11 Oct 2022
 16:46:15 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] xhci-pci: Set runtime PM as default policy on all xHC
 1.2 or later devices
Thread-Topic: [PATCH v3] xhci-pci: Set runtime PM as default policy on all xHC
 1.2 or later devices
Thread-Index: AQHY3MFxw0xTSbUMFUup/ASq53Cjf64IpkIAgACHj4CAADlEsA==
Date:   Tue, 11 Oct 2022 16:46:15 +0000
Message-ID: <MN0PR12MB6101ECEA1CCED9B65667031DE2239@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221010160022.647-1-mario.limonciello@amd.com>
 <Y0T68lC6bUY7dg7D@black.fi.intel.com>
 <7c08c4c8-562d-553f-e513-c925080300a7@linux.intel.com>
In-Reply-To: <7c08c4c8-562d-553f-e513-c925080300a7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-11T16:41:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=07659174-a77b-4081-9234-df2625d74d8d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-11T16:46:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f1702402-99a1-4491-abc5-cf900be47ad9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH0PR12MB5203:EE_
x-ms-office365-filtering-correlation-id: 150c9f80-ec76-4da2-afc9-08daaba81cd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mGg9vojgLr4LedcYmkWdPA7AI0Ffh/u4hdQc85QOCKL4YZ3qXQNxa+XEkQVTIHj1uKlfJBzUhBNK2NR2s1wXS+IVvfy7x0/lxTc8og/0Hf0mIoh7aRZ/Bvq8fRWq5t9oM8L3jmz0aPyjB/P/sqfFMFiDnRvMcZnhiFzAH1Y5mgJ9xKAPsts4b4YSgaAedIAgFMQV6KRgtxiR62CzS1ZlQqahBGV+1In3C9Lvexj0pcdg24ZuaovYT7YZLnmcsgfyr3KMfzcZMBe55uTkU4VggRhSf6A8T1gnWeQVsmh13VL6SE0O/IWkH9FRWZH/jTp6vnsdcE0ibe2Jb4oxMAm4V7XHdIVawt8w0jYBeoXPjOUzqMlB7mzctNSFmErx2unVSGeP1yzs44GvcHAijoFWNO6XlaL69Ivs95X6URlFFZ87PGpgRf9agP+arvmUtrrpG46vQGrEphnoaMTVpZPsBRRf3SaVCHTou13eGmYlwdJH7z34lBqcdEakHQWvEdU0RYbiG6ZB9DpXkf/GjXj5KLSqYXeRVFkBkG3ZUF4KenumY6pR51riNzr9UKdTK6qd9FZ+zy8uMuDfuZj6dBXBafiW62ExqEAYzIku05cBdKj7WoKWG/loEuCKnPIj3erMqiH2+rSSn7tMH/7zCTYWc3ypRnQRXlaoYyjt/E8WWkClgT7d/lKyOnN12slY5NN/wO9aP789L/db3PpmSs++IABt+yfYEeCBsJu3d9oVEGyitwQYs8QHQkKufgPQiERASfr5c1N/B3shfBvI7TuK1H5yFRScmgQ8eedMKCTrYKw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(2906002)(4326008)(8676002)(316002)(66446008)(66946007)(66476007)(64756008)(76116006)(54906003)(5660300002)(110136005)(52536014)(966005)(86362001)(41300700001)(71200400001)(478600001)(45080400002)(8936002)(6506007)(33656002)(53546011)(7696005)(83380400001)(122000001)(66556008)(186003)(38070700005)(55016003)(9686003)(38100700002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uaqhL4sawz4lK4B9TdvhsTVe9kMq36/wz6eV6XkjvF7k7LOC8jWrlpAjZoeP?=
 =?us-ascii?Q?xZ6iEu0z6s259fRkBXmEykk6GhlC0MB1R8lezDzddEgtw+88WcnJKvsfEnIy?=
 =?us-ascii?Q?YvUbRXQ2eailjqlnBux5c6sJjw5Z1jpj40UHQpVP88A6vWM73xK79bmeir4c?=
 =?us-ascii?Q?F583MIbTR8r6XpASA+AfKcz8aEm8HjFgA7LH9fgVkavr6rloNtWYOcRKBsLw?=
 =?us-ascii?Q?E2TJoiX31WSkM2soZ97JZ14KWKCalh0pQ/Ln97QX1uR1/n5OkEJblFSBfCoc?=
 =?us-ascii?Q?A4ToOfNWMsaY2qzmUpeK2OPT95vuWBKGzXAcoBqN0NhdB3Kx4t6J7lVnH5BF?=
 =?us-ascii?Q?B9sbCk/6t+WeLe0bX/2ENZQfm5rRb36ZAHWkbgtJ+bjSEsg7ucZqzhfxpJLH?=
 =?us-ascii?Q?aPPPhtsPC6yEbWF/tRGZpS0/5DH5ISHW4JG4a5qOaAnZf1PFMtWBB2vgSazO?=
 =?us-ascii?Q?tsVmeahedD8sN+ZjKukkM7c8aIUEZT7y1vRtpYUBn/Uh5ulk3BJ7v4VGn0MV?=
 =?us-ascii?Q?M5mZDoLGEq1uJ+ZBpIPnaFV/5euQzGH8bTFDpojdPZcqiAdM6hc1vUqrDRLh?=
 =?us-ascii?Q?RahryQhbnlk3hzQhGl8LYkE2Esne1VEBH5hQQUoBd8qh+o0XS/YcTmijpkar?=
 =?us-ascii?Q?zXizkMAs+517r3iDHFu6h8e+YxXeGZN8bLMb7EHJV7xywZAita0QlPH9315A?=
 =?us-ascii?Q?bPYjm5Ofug2C2qm+HzmuomWZk0ML5csu+mzrmSHAOdQvTNsG+3n4LKNRYxFc?=
 =?us-ascii?Q?seoSZbAOCyIZWZR9bp6z0CxyYF9cVow9ujNvVSelF/Kay7S3mi+Hw1nhfPLh?=
 =?us-ascii?Q?dYfXHOAFccSxpsGgWe0E/pYyGBbMewfXaxUxXo7ODle9USZPCCBKa52uVG7D?=
 =?us-ascii?Q?+wY4khdtvZ0c8zzn1tyIMnhl0piOykU7a0Z+pFn7P42Poq8ot1IyepJdrQR1?=
 =?us-ascii?Q?g2IeSp7yGaAhuNVMmlLTDUooDX1qK8S/H5SLB9pVQWe9Jsrc1h4tVgzLFrAo?=
 =?us-ascii?Q?7L0qECstnRIteFByXrNBKAfcxXGNt2tbcNmzF5vFeGK8VVFvtO++T4vBlaGP?=
 =?us-ascii?Q?3Xe2tT8rKXGv3bihB9xx9Pn/KZb6esJYo3HIX0EMFWOXKOJoucFKd3O0NnrL?=
 =?us-ascii?Q?6XHf6aMm6VOWO+zPJB9ZkPUrusn1SvBfX0WJeQlO/KDzkj7RdtlEv+8YdTeT?=
 =?us-ascii?Q?2GCj8xkLtxw+T/RhTnHPJzD2lVcNiyoF5x79zArd/3vgbPv0EB52jJKtDEx5?=
 =?us-ascii?Q?4C2Q5qbQ4uENeZib5EYxdPZkqSiWA6Ln6ppIguBlSD819acZF2b3V15vBpAY?=
 =?us-ascii?Q?syqAbuaT29onzr+nQSC0/Uijxb2QHnH/dkyPNUt+CxpLtENckbiUh2GPcAO4?=
 =?us-ascii?Q?XrCBA/rTukAGJ4Jee3GRsyxVMsBIaBvmjMMjmy6nq99g+BOcI4ZJtQqHTUIB?=
 =?us-ascii?Q?KdgKvDl1RWHNPrer0YLwaMBA7QMtsilA8e0pRKrJy5qpqjgg8pvXBYKVLqX5?=
 =?us-ascii?Q?AbvLKgfhi/bXS55XvWF73sOAqqLVxrF6u4STrcHMpQhXBa0qs7E02RsOgY63?=
 =?us-ascii?Q?cqCPc6FFUok1klBcXBE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150c9f80-ec76-4da2-afc9-08daaba81cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 16:46:15.2433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jj2afUBglI05wVI1m4VKJ7Xu9CLDvy98vVnryakX6jxFKxpqmFz3yBbnN5SnHCb+TWBVYFzz2H6ux5SZZFwK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> Sent: Tuesday, October 11, 2022 08:16
> To: Mika Westerberg <mika.westerberg@linux.intel.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>
> Cc: Mathias Nyman <mathias.nyman@intel.com>; Mehta, Sanju
> <Sanju.Mehta@amd.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3] xhci-pci: Set runtime PM as default policy on all=
 xHC
> 1.2 or later devices
>=20
> On 11.10.2022 8.11, Mika Westerberg wrote:
> > On Mon, Oct 10, 2022 at 11:00:21AM -0500, Mario Limonciello wrote:
> >> For optimal power consumption of USB4 routers the XHCI PCIe endpoint
> >> used for tunneling must be in D3.  Historically this is accomplished
> >> by a long list of PCIe IDs that correspond to these endpoints because
> >> the xhci_hcd driver will not default to allowing runtime PM for all
> >> devices.
> >>
> >> As both AMD and Intel have released new products with new XHCI
> controllers
> >> this list continues to grow. In reviewing the XHCI specification v1.2 =
on
> >> page 607 there is already a requirement that the PCI power management
> >> states D3hot and D3cold must be supported.
> >>
> >> In the quirk list, use this to indicate that runtime PM should be allo=
wed
> >> on XHCI controllers. The following controllers are known to be xHC 1.2=
 and
> >> dropped explicitly:
> >> * AMD Yellow Carp
> >> * Intel Alder Lake
> >> * Intel Meteor Lake
> >> * Intel Raptor Lake
> >>
> >> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> >> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.intel.com%2Fcontent%2Fdam%2Fwww%2Fpublic%2Fus%2Fen%2Fdocum
> ents%2Ftechnical-specifications%2Fextensible-host-controler-interface-usb=
-
> xhci.pdf&amp;data=3D05%7C01%7Cmario.limonciello%40amd.com%7Cb286e9c
> 63e9e4c3a1a3708daab8a9b23%7C3dd8961fe4884e608e11a82d994e183d%7C0
> %7C0%7C638010909687542135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> 7C%7C%7C&amp;sdata=3DCetIs1VuAqj8nNBoLnXaGncw6Sl4JcImYY67JpVxyjg%
> 3D&amp;reserved=3D0
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Thanks, added to queue

Thanks!
For my own clarity - is this something you'll still take to 6.1, or are you=
 meaning
6.2 queue at this point?

This thread originated from enabling Pink Sardine.  Wherever it lands after=
 it's
baked for $long_enough I would like to bring it back to stable eventually t=
oo.
If you think it's too risky for stable later on, can we do separate set of =
commits
that adds and then removes the IDs for pink sardine that can go to stable? =
 This
would at least mirror more closely what has been done historically for the =
other
USB4 products.
