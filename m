Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916666A5F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjB1TIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB1TIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:08:20 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A23402D;
        Tue, 28 Feb 2023 11:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwbMHPoy3JPg9W99Xr4howAP9VL+Xy2JW2mET0acDvdF/+QSNUoNRCLqgRqnbdlsaiP+2ABlC8WMREgkNMa2cBBirPJwVFRWAJe6UXLcCcbai2IeXVzOw9mUqQtrlQGcCDGFHfl0OcaWR1i4mqzra7nuOHIsCOQgoGCzJveYjL8ZOC6YmP6ca4AJywSLjQte+6DWoMCjqjhXNELg2osi1SEs1sKR3OrRNtAJuqi7UeAX3yNZzXQWh4uzFVIFVSp7tHu35beBCt0WW9weOemHna9j+x6pAKzSq3ZOSm98bF4zESAw9lpL1jA+fuiVJwjY0zDtTwIL8Sw0D54uKEPgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSIe72nEii+DkB8zsn/h3xu+VyLnNyvmvdhveY5aFVw=;
 b=H2KSiHWW9E8uprTwyjfXx+dXFMyZ9ushhsSy01V3SDJn22pUVkX6Di99GVGO5SMaGOZb3n57pXzub1PyvhnHB7w85wr7MJInL3BAGSE3/FjM3Xm5bEoPBVqnrFlKFKJ9iyM6NnGZyg3O3muPsEaOb8beHXkX0msHADlhRNVNF7UpDcaQHNe47GOKNj4dqwKC7l0WYFSPMVBMzPV1uCr/rWsnabR5b9byvfalzXgHgfw+Knun/2RhrtdIz+4CxqkYy2Fe3UzZggurLugo3dTTtju7m4icGvUBqXxa6AuD8bE7r/7wTOgCx3yxXHL7pMN9PvjpQZTwtWENChavfG30Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSIe72nEii+DkB8zsn/h3xu+VyLnNyvmvdhveY5aFVw=;
 b=ImWudu9N6Ky1hWRBu78dMiEusiGqNRmbEEj54PSW9BinAHEDQbqTcqy+bGw3qq5wCkij7+3FO238VcTaIAOWTPDnueEWmjlpGCmu4UepTc4xWHcPeS20H38QocAS1OAzoo5nWqPghgnrLS4DmXCdM7zV28OTz+AfYtbekYXyF+U=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Tue, 28 Feb
 2023 19:07:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 19:07:24 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Oliver Neukum <oneukum@suse.com>,
        Michael Wu <michael@allwinnertech.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>
Subject: RE: [PATCH] HID: usbhid: enable remote wakeup for mice
Thread-Topic: [PATCH] HID: usbhid: enable remote wakeup for mice
Thread-Index: AQHZR3iDazov67zqf0SmSMvJFyQb2a7cY4mAgAAKwwCAAHzogIAHLN8AgACeEACAAAoLgIAAAFtQ
Date:   Tue, 28 Feb 2023 19:07:23 +0000
Message-ID: <MN0PR12MB6101893BED7C03E079F190CBE2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
 <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
 <Y/dMq2KKYfdMdrjh@kroah.com> <801338c3-7c0d-6b3e-eac8-872ee5add466@suse.com>
 <MN0PR12MB6101B1BF9748F0602684FED5E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <f2142d88-259f-302d-da61-e0fc39d1f041@suse.com>
 <MN0PR12MB61017A45BEF80013FD7B77D5E2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <Y/5QX1gYsGinrPNF@kroah.com>
In-Reply-To: <Y/5QX1gYsGinrPNF@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-28T19:07:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3850c094-f9f4-490e-a9f0-95372b4ea6ac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-28T19:07:22Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 063e6309-c201-4018-9811-9da1ad3da56f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH8PR12MB6842:EE_
x-ms-office365-filtering-correlation-id: 6f66ec06-4cbc-4398-ea3e-08db19bf066a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASzPE4efi5mXmv9qlSVJeQ28ciHcr1/Mj4JKa9JrvHO03h8Aq5UEUCwXJNOYSYdArKnOmi8Quu2hY4MIge3zXiMsBgP4S132g1dySMEb54NIJ/mmKSNI8M29ZoMWwZLYGRZW5A54zqmVzN2aU3IuQmouDI1EVSlYfASp5bnIn81Cma+965fEySkdz2h3FIXqrS10SKtGaBa6N8t41SZ2Yeh6t8GTNLRzrr1BdEP+JHnV3Qy593/B2w0Qu/Y+IsvJAoVwoI8ZwSJgy4V7l7cieyt82z8c4nBZF6NCvDdwFjbAZlLlFQBXJCEYf4nJ0vMf6wSuipTpSTCzzJaNvSdr2h44PRdMooaemRovFN/eOjlmEwu+O9ZbS4huJGSvarykRtY+45JmZfRVH9rkxm5wZdCWZ73M4CcSe1RwopuGvPhZA/VgQmq/7bVO1R/idXwHNFAMu+YjOCNK/8lPa2qeiCKXY0AM+GBdN+F8JtHbUIZo85JWtnEcONEOmgc3xYfYCzs+GFrKq/dJrEci8OtasNEQvpeul2QcwO+J3o6l8fuWALj4j64+foR9RKs1a0/1GMHUyw9dc9GLecxX80AA6z4XPAxiIpUmmS1ce5cO37PBFucMWhylwGEf6dkIkFpfCwM13HeuuibuKU6GefvdJ1UTnSRpn7c0didOd63Bq7UqpH2Rm//QPz7Bs6lbCUOsi+VXSbwIyiyZl9C2UEmezA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(66476007)(38100700002)(66556008)(66946007)(76116006)(6916009)(8676002)(64756008)(4326008)(41300700001)(66446008)(8936002)(54906003)(71200400001)(52536014)(5660300002)(7696005)(478600001)(6506007)(53546011)(316002)(26005)(186003)(2906002)(9686003)(66899018)(86362001)(33656002)(55016003)(38070700005)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sN7zkDSB0klV7VyM3GSUzVL8Gqwf5+h8p5kFjXSih3Q8KIRJ1YNxuTfyp2+Q?=
 =?us-ascii?Q?7dbYsJXqCwwdJfwlPOBPGM3AXROPvppFhnsZkFvbro2SpkZIM0jHd2DJa5p9?=
 =?us-ascii?Q?BD4c7sPMgFW7TsTcZqalM2OYr8jnHNNv3tnsbDl1pDNVLbFYJtpVDYQdp+mb?=
 =?us-ascii?Q?c1suJ9XXSz6UfCWDqayM/FQ5PI5fPN7IeC+rsqDr39UeL1wo8i7zwxO5H5yJ?=
 =?us-ascii?Q?IZzwr32OXPLTuavYa3dFPby42ktS1SaeYAT/DLiR595vyuijnXI8uHYlPPb9?=
 =?us-ascii?Q?XKhgH6LyLnGE3/tcuDoeL7eEgypuU2w0lMaq9j8v6UUheAAM98I6O9wOxdkB?=
 =?us-ascii?Q?lAMdedsO17SOQAbma1AFQtFS1W34fJU9+fMeTkV/H3Zu2sZyC7KYq0SJo73b?=
 =?us-ascii?Q?lrZM4Qso/g0kV4dlwy2fKqKhSMq6TlvWHHmp9lgFoqO1gK7UTI4e7EVpNNCc?=
 =?us-ascii?Q?B9x2/+smyNWhYLBDDnjixUrBmh+ACqJrTMpUk4zhhZVhTNVAeml18o+fCQX6?=
 =?us-ascii?Q?4EjrIbuI0D3F6AgYMZ2R39OC4q7/neNI0FUeOwKfljFxhgiOoAyshkPNYhab?=
 =?us-ascii?Q?KybAmQtAQqED04FRgnFG3JCzZzCRpPDcsUyvpY62DXKkY8DHKD1nnhLuqOL5?=
 =?us-ascii?Q?Tu0Nn2SFKl68QDnkArsYdPAgO7sBBCL1m+SRkh1ZxJhsgfOrh1DWQbdhFity?=
 =?us-ascii?Q?EHs38oAMo1bp2cbAORHq5ESmKH4BHZ6n5uacmEhr8M4el3LJ38HsrpA4kNiR?=
 =?us-ascii?Q?013b1xJsXXrvvvmawJ+wTVzMSbw79V2QFlcIUZGdiRNR92Q6drBHiwScYTTd?=
 =?us-ascii?Q?1yiFOr1iYmYSPL39/ncbbIXx8j4xImSPzU1r2pemmcihlzzWn6Z+GJ3arAOg?=
 =?us-ascii?Q?Q5yxK3NYlIq4S4nmQNBQXvq4M8OlW9V7kJ+Dmzbj0sUYYNkS14Uxg1Ijy3p1?=
 =?us-ascii?Q?Xtd0UV6jxc1qEGUeI1kId2Xdjt0eSYDxk4fty+SzcFNiFJTlkzHRtxEWD7Ni?=
 =?us-ascii?Q?cG7cTvIgvrNYFCTHFetWOt1/YCcc2G/fBwZVu3Yr1gVF9gKAU2UlfgArcIzM?=
 =?us-ascii?Q?Y5LrzumNvJ3zbSY0+kkdMVfV5/JfibqF5tD7lIfIXYXmyBgw1Xi1J9n8Qauf?=
 =?us-ascii?Q?Hjjo4RvWQQbqVFwNuVZgXoROlUaA/903XOg0I5UyWvpzr29/z9SNHBKx83LQ?=
 =?us-ascii?Q?gQMy+Xo3O4dKND75dIL2fWr7HEbtvIwogsLZ+9hUk3Jcd/E71wtnojvLcvPs?=
 =?us-ascii?Q?KPsGSSBuEAFc1WpAxJh24JppVLYwzyXyl6toY5gnjUCqzS0s511IoopYmmrz?=
 =?us-ascii?Q?PZzbKVrqZdFbXte5mSP4AlTfUM7TxrNCydWJFvFABYv6PSRuBoZMBmkdVWfj?=
 =?us-ascii?Q?PLug+D7SyzqvhfT9lW4R7qG0+g9VY+mXNQYONgNLt1ob4cQU0rs/5GY47n3u?=
 =?us-ascii?Q?jtI0AlAb3LHxLLG8t1VLptlaLyFDssw0qVXtaltfDpoW4HIUsBOZUBZ7zlLP?=
 =?us-ascii?Q?PtEB/yqkfWnv3RQP+PeUoRFg9CGj6C/P6G94zjWz7uEWPAh7bXRtwwFt+l9U?=
 =?us-ascii?Q?veQ+ekCWkjNg6+y5u5o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f66ec06-4cbc-4398-ea3e-08db19bf066a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 19:07:23.9706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cC8LS0hyzLRFYdrKgb0IeH2svKMpnv0sCRaNnYC6Xn9xXKtoSFj/hrvE+OOoiGWEk+l0BsljTBn4bDasZ6lnVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
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



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, February 28, 2023 13:05
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Oliver Neukum <oneukum@suse.com>; Michael Wu
> <michael@allwinnertech.com>; jikos@kernel.org;
> benjamin.tissoires@redhat.com; linux-usb@vger.kernel.org; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; Gong, Richard
> <Richard.Gong@amd.com>
> Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
>=20
> On Tue, Feb 28, 2023 at 06:50:18PM +0000, Limonciello, Mario wrote:
> > I still keep getting inquiries about this where teams that work on the =
same
> > hardware for Windows and Linux complain about this difference during
> > their testing.
> >
> > I keep educating them to change it in sysfs (or to use a udev rule), bu=
t
> > you have to question if you keep getting something asked about policy
> > over and over if it's actually the right policy.
>=20
> Why not complain to the Windows team to get them to change their policy
> back as they are the ones that changed it over time and are not
> backwards-compatible with older systems?
>=20

Heh.

I don't think that's actually true though - Modern Standby is relatively ne=
w.
Picking new policies tied to that shouldn't break backwards compatibility.
