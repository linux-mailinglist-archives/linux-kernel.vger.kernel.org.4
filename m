Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99A65C29D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbjACO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjACO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:58:15 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D2132;
        Tue,  3 Jan 2023 06:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCJYLHCBqqpyeaRwHYWWr8AsLS7FuxmZ62E236c0riJSua7LBT+Ru/Is7qUoJViAMOAajDmqD8U6iwCUE9wIr8JarrEq270PU2pfpK6MsZGAJHgL5xDqGXsS9Nc0RJyAykKkF2AlIdUwQoW1EIH5QxV6i0QVsnZWa0LXQe+fpDLasbvL5eW284fFa/OlGJr1ZeN/KPiMVfyyiPULzf0dBh/p0GvCA7KlwbU52vbdaiqwsZCrDAQahTQc3RJbqpD2OqY+K1caxjMgxLk2yN0QXVghSErjVhBUJE/EUJoTD/olvv0pVsTh/cIOk/9xeX4Q+4rQw9+rR0jOgjrGdgybaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYTNsE8vAumkPJakzklZJiM+0xT2yG3YPZQzOoKcOGg=;
 b=GbFzcRhPtz40P6/N3/rmN2FbeOhjTja4JeDcsSCRx0JGjncZCH7PFmLBx6o6pHLz7lI6qhOXN+PqB/3UfuvrV4kjEXllwseeY0M/1dXjbedb7XZwpEtihQY6vkMSdguO8jUbIrTb0l0Gu0QBVta0GxrcWWbQ+cRZ9pg075qY0TdW2FgMboJy5LhkYwZP7GoJ5GlC1donhT3ThOg82JiR6OO8ECZY6LaWEbmwGt4Wy9uKJvE9H0bour95sABJDcNg+6m6nbSwuhY7wEwggM3JvNyRKMyTe4zvYNh4/Pqp3EilyZiMrcTEBFY5muyJm4ItWXAmRwuB0yGNNIQYrcng4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYTNsE8vAumkPJakzklZJiM+0xT2yG3YPZQzOoKcOGg=;
 b=uJbhXJ4qI7cTxdZZonZZMmsRK+xMViCl4keNYTcC9mTPzWHB75AFquzhISE9yAwL5uh4J2g7GuLqs5WojzQ6dZuInYHjDa5T35FfAIGcO4wKuQqbTjxjhp/OsQRcLo3GnWqdrR0OCJUwIeWVqs25k6N5qzOpyLuMjeyEgrbpdg4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 14:58:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%6]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 14:58:12 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH] Bluetooth: btusb: Add new PID/VID 0489:e0f2 for MT7921
Thread-Topic: [PATCH] Bluetooth: btusb: Add new PID/VID 0489:e0f2 for MT7921
Thread-Index: AQHZECuTThDXIjyI9keEjT+ohlcL2K6M5uNg
Date:   Tue, 3 Jan 2023 14:58:12 +0000
Message-ID: <MN0PR12MB61013012BAA4423ECB4B58C6E2F49@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221215021854.1429-1-mario.limonciello@amd.com>
In-Reply-To: <20221215021854.1429-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-03T14:56:59Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f635e0c6-49d2-49bd-a827-f0f5d43d50dd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-03T14:58:12Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 68b6f9d5-1ab5-4b7a-986f-17d619c7a7a5
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BN9PR12MB5052:EE_
x-ms-office365-filtering-correlation-id: dbcf43cb-6118-4f6c-dada-08daed9aef78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ou/cPzkGHDiDhwCXLu8T8MN/+jdHTcSk+gLj8CfYCJU2prM4o0vf+wRzzxnIGP9fWluXHsXL7KhfHcavYZSySHLeixqnJn0cCBUZ8yCPiDBW7dtiOHMAJmNz1OFASnBMCs7uo4Tm3wXx7B2drmtCgXjpSidWjAwIV45qv7Td660PdNWRDedLf2/24835eDokj9srcCCn5j3Wum1PjVqLOAoqVQ5vpM08RfhV2PpkxB8vxljFT/3csZ64GC94KAaXf42qhZ6vM95CCJ9zWX380z3KR0JpnSoCQb/tD06mCNsyh/zjpNmGKVpTk7vulUvx486nioyXMjP2sqj7K1YdVUXtRqbNvqhlLGCIiUXML9B1RDdIbcyGPzPG0ZXsWa7rm5WsM4/WL2v+xypasP4FiIHYxNogmvtwX5g2sro5Lgskme8TN3PneEIJK+ZPiKB3NZeh53099CYTNfz5Kis9uzsuBU98ILSvcOSh1jX28sVGbRwi2X7zQ7RITj4W5Y4MAjjFPY1ogYZBh8bWVhFr8BWPLBDJVL6TOs+d6LhPwAB898gWXLReJvNakD6Ebfl0yBhfUC/cSKCfQcyn5DhCa0wW7x53tS9QKllrlUkBS1HRAtBJc3DZ2lDKUMjIrURs96Qnzuk4qdCw9yOn/juPSyBlYETnX1m3loi3OHdQljdmhrR7wQ4cVMMMHQEbAIfpC4acN6EfvjKt6U5lOCAd4Ac9cWpz51PctRY5nFlqDk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(5660300002)(2906002)(52536014)(8936002)(8676002)(4326008)(41300700001)(66476007)(54906003)(66946007)(64756008)(110136005)(66446008)(76116006)(71200400001)(316002)(478600001)(66556008)(53546011)(9686003)(186003)(55016003)(33656002)(7696005)(6506007)(83380400001)(122000001)(38100700002)(38070700005)(86362001)(22166006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k01iMMtMp5AWKIWPHD6PUzdwZveGFtqMkn3qx53C+w63EieGBTSpAKZinu/G?=
 =?us-ascii?Q?dfAdOIhdjQI0b3shkDlzmNQkuEdTHfMOwVgb0iYrnI/IWDQMq0k4m/hNMujc?=
 =?us-ascii?Q?Z+QE7b2XCqNhjutdlKdds4k/p/p5i0Ll297HeUhbQde+XESmbwfXrc5FWQoP?=
 =?us-ascii?Q?+uEXcCafvnt55nwhT7px/7EBZc1far6Bb1DQctUlhP9tVsvkFMVDaoSKZJFj?=
 =?us-ascii?Q?VJRQfYqS7pjvwZxe9IbtL8BTmD+78SJxdE1dr4oBetVCtloGOI7trK1zD24i?=
 =?us-ascii?Q?GYe4vi4YFATcNqfcu11za28VXX8F6Inz6m+to2Y4Q6pFxLDKyc8vhGVKckcA?=
 =?us-ascii?Q?stnHc14Hcfkj5x6PDvjYib3wRVukFFoWKLEmEVkQrkbCqR5uDwYWVmzNdjys?=
 =?us-ascii?Q?HadqOcDnaX917Cxp+uZ5JBY8rMnfjl0MzUYfPG9r8gHrIjfB39mQ26652kop?=
 =?us-ascii?Q?ZnNNBMndP0/MF0E8LMFkrox0jumj61ur7cBMG9St0Kb5WcRn1ZhZ0H4ViZtv?=
 =?us-ascii?Q?Gce4FgatknYR5QN6nEHPChuEAIq2xj7N71dfkLlUIawebWr7pMhTepc8HHOP?=
 =?us-ascii?Q?gVws6KFiNJ/WJhdmtBZcIhNDHCBMBs2ikncsZiRfTBBfAhEuBvVeNhlBSWt+?=
 =?us-ascii?Q?RZrmxPfqKGoc5CSNIbdhT5xYTUz0f2feISZ63GzeP6hpmxMyhts9iSX0CGmY?=
 =?us-ascii?Q?XOMQkZiJxjcTRqeSelTpcOiDjjE4juwP08MovWmxJYpxk7qhV0Tl7JYxYQ3x?=
 =?us-ascii?Q?miTSwaItOcrDzx/WbaAbIHSGH15VBy6FfE31mS+V/9enBNvcVFHbi39dGrNh?=
 =?us-ascii?Q?GIaEHhB5UXqW9lqCQGHvUauPSwhmur0BHwm5R2P8FnhBZL83KGIFfikFqyPO?=
 =?us-ascii?Q?rrFqoUxy1xdVqc4FD4IedTLBgDR3ZwNhnFj5avre2oJS6HQTK30LMOLHj4Bf?=
 =?us-ascii?Q?mUl/RaU3y5dcPMYEFtpt6SbpYCtM6TK+itTWINDoMOfYn79Ck34dCctCuqto?=
 =?us-ascii?Q?Pa5GiSJYqYssxxvDFyMQFZ4G1wZo4JqBtSO7c4duq1Rdh2wCphw0eOXhAUAv?=
 =?us-ascii?Q?24NDTHZhq+jh2MVlN2X8pl7NVBUT/JGObDx9AyjV74m6uAijDqDuSOb0NEIb?=
 =?us-ascii?Q?iM8N+lxELvbv+e9BuWCtFiMnqwPK/awpy4GHJIex7fMl+YvZGlhZyEaViA+f?=
 =?us-ascii?Q?kpOR0myRi8eTHkfvlow8e/OTZm0rq7YhLjELyucLr2dESxlRyVKzUsgSNKbj?=
 =?us-ascii?Q?8GoFj7dxmf4/UQkJhjoFEBtclyxgpffL1SmepLjWm6JUtBA0hNEt5yraEV9e?=
 =?us-ascii?Q?FuOuNFpize1WmUO50KqVP3Q9M49JbGuMseTTM0b8e4542JCby1FjZDjpVY5k?=
 =?us-ascii?Q?0cw4u5AQ6dSFK13WmpIZjF16hpZV9pdsEak17clK3zJ8MAvO579s+yB5coZZ?=
 =?us-ascii?Q?bCXMvvXBSOPIsMsJ1rNIJvqhmGlZuSsj2l0DMM5trqhHLnvbropOE5ZMzKYT?=
 =?us-ascii?Q?nlqfCXdUGKys6jHxb0TJCQOv4OV154GHEYWfZSdaXIY203gsYwnUQrxRSCBo?=
 =?us-ascii?Q?5COKbGIm9hGAU9KS850UYNxup+6ELC59Kl7bs64UTvrj8tzGVL7OjtYnZIKf?=
 =?us-ascii?Q?RKT/5zl8nCyPE1tJfZBr+i0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcf43cb-6118-4f6c-dada-08daed9aef78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 14:58:12.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weA63HyLoUi27OJ7FVLTTD1hkEivCKX5+arE8iKXiC6gSgOQ0bUnZEjIKEqIx6HCylrT9709RmOYIl+TYdJfNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
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
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, December 14, 2022 20:19
> To: Marcel Holtmann <marcel@holtmann.org>; Johan Hedberg
> <johan.hedberg@gmail.com>; Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>; Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Sean Wang
> <sean.wang@mediatek.com>; Tsao, Anson <anson.tsao@amd.com>; linux-
> bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-mediatek@lists.infradead.org
> Subject: [PATCH] Bluetooth: btusb: Add new PID/VID 0489:e0f2 for MT7921
>=20
> This bluetooth device is found in a combo WLAN/BT card
> for a MediaTek 7921e.
>=20
> The device information:
>=20
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D02 Cnt=3D01 Dev#=3D  2 Spd=3D480  =
MxCh=3D 0
> D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0489 ProdID=3De0f2 Rev=3D 1.00
> S:  Manufacturer=3DMediaTek Inc.
> S:  Product=3DWireless_Device
> S:  SerialNumber=3D000000000
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
> A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
> I:  If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
> E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
> E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
>=20
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Anson Tsao <anson.tsao@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Hi,

I didn't hear back about this.  Did this get lost in the holidays?

Thanks,

> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f05018988a17..c413826787b5 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -473,6 +473,9 @@ static const struct usb_device_id blacklist_table[] =
=3D {
>  	{ USB_DEVICE(0x0489, 0xe0e0), .driver_info =3D BTUSB_MEDIATEK |
>=20
> BTUSB_WIDEBAND_SPEECH |
>  						     BTUSB_VALID_LE_STATES
> },
> +	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info =3D BTUSB_MEDIATEK |
> +
> BTUSB_WIDEBAND_SPEECH |
> +						     BTUSB_VALID_LE_STATES
> },
>  	{ USB_DEVICE(0x04ca, 0x3802), .driver_info =3D BTUSB_MEDIATEK |
>=20
> BTUSB_WIDEBAND_SPEECH |
>  						     BTUSB_VALID_LE_STATES
> },
> --
> 2.34.1
