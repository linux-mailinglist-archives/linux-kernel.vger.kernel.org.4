Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE32609215
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJWJsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJWJr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:47:59 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D945B7AD;
        Sun, 23 Oct 2022 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666518478; x=1698054478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMmcRd2eIWgKF15LMVmvmEcgiPZlfpkcszSbubo8AO4=;
  b=EAsReTuaCcDhJFH63UkqBmdxJPIYknAp5YsOSEUjzBcCcCdKSSQRUxAB
   CgsnF1HDoRsTSJ7tTspmXghcDNdel6PYTaMIV6Qy11HiSsgvUQQw+oMXV
   IuRbgQk2qwwJkeRQONZwosbtb6BJSXppSdSg6q6l98hnIg0Eop4o9GaGt
   j6SxjQ/cNkbqoE/iiLSCQ9psT8aFgJRDJzfGzp8WywYEu7TEMv6wz2k2E
   JECxh6Qw6bGQQrhWTUCuwN3ko1nhG4n0os8dMZKDM8HBXRrs0mtxAvoKk
   6M36KUklZHdJyscbcQgPASDXxo3cAzh19Ig9PdRUaRsXbwxEwz+KTxCk4
   w==;
X-IronPort-AV: E=Sophos;i="5.95,206,1661788800"; 
   d="scan'208";a="214527397"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2022 17:47:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+ROlrNcv7F2X52u8FRJf/mB+JOxrg3T80jZs+90r5uKe7N7DhjwegeIDjvaA3XhxhguBv7lTbNEE6ltB2DbKkCe8xUgNT/4o+B9wfE7srXOX51BOfhmOsTpT/7bUtatxc7Jigki6/7dmyVn7xbazTsOeK06yjY+kErslkQEl5y757Uoond9oASjX+ov2/mwn5xYZA2FJEmWzeaRMYJqcgrGrOmxEr6MiL6feQHO9Tq12X+8+Br7lj8LixzYu0NH4e+YuLTDD1qY/rnfr+SqFg6DgL/+eQCLd2v0b4d8OkaTaiYet0QWGxVQaz5Xu6TLm7SpYqseLXRMkrk19NN2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMmcRd2eIWgKF15LMVmvmEcgiPZlfpkcszSbubo8AO4=;
 b=J9+X7xna7jpNF213y98qt6tIgFXwoExc0MAJswTPeD37kwPO+IbXo3kUFhOjTqi9ciUSsUiYMzCATNIgyCxELaJ7oWRFVeuo+NxAiMUrSH3An/NQbGfbPBopmKY2KNQ8oKW3iqJ133mYEV6NryZZ4NfjLqk3QTgX4AzE3Us3UDeZhiEg5oN66e7Cv2DtzspVtakGGWnH69uZH9Wq9+c3KUBLerEYRuD1Vb18dkvmkWtvQdneAC/YlN6IHlRqo6Nxye/FdKf+cc+S3NwHtaTQo7nXF1s3FpwXvtosSDaGN6m2Wg5vlx3OZACDxpUg4d21lj6DuCO5XQcCMJ+Mm8m4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMmcRd2eIWgKF15LMVmvmEcgiPZlfpkcszSbubo8AO4=;
 b=q3g6EGC2Pb91oIIZYhepyDFpuAqlJvcCzXYwwRL7HHE0x+Ne86toZQEn7otGTTutAiWU45xxPklWKWsL1x+5al9D1FVvEsKhaHM5WooL/b0AyNfILMvbjjqs7qerZAPHkGtBoOjqqo1dvw++vc8RCm7HxX+C8WrtCMEUXBNwJpU=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SN4PR0401MB3584.namprd04.prod.outlook.com (2603:10b6:803:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 09:47:55 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::49aa:c6bb:bd87:e26]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::49aa:c6bb:bd87:e26%5]) with mapi id 15.20.5746.023; Sun, 23 Oct 2022
 09:47:55 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/3] scsi: ufs: core: Use is_visible to control UFS
 unit descriptor sysfs nodes
Thread-Topic: [PATCH v4 3/3] scsi: ufs: core: Use is_visible to control UFS
 unit descriptor sysfs nodes
Thread-Index: AQHY5l571FAimslJxUyWS4zr13rJ9K4bvDGA
Date:   Sun, 23 Oct 2022 09:47:55 +0000
Message-ID: <BY5PR04MB632722B3296B62E6D6A67208ED2F9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <20221022213650.626766-1-beanhuo@iokpp.de>
 <20221022213650.626766-4-beanhuo@iokpp.de>
In-Reply-To: <20221022213650.626766-4-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|SN4PR0401MB3584:EE_
x-ms-office365-filtering-correlation-id: 8cda36c8-b6ab-43a6-1c3d-08dab4dba8e8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1/hWP0cBpIa8jyYYALP8olFQGTWOJqcm/aXXKYN9mNjhhSmOnE7Y3n5s2rcgOShY5VSXCiDYv2vBxjjG3wRxeS/IoCP00QqQK/YIkJfrfclQ45jiPdf+hmfbH9zfRoz3mqO5LBR4xdvAZThOVJRut05zuq5fxgHciFIQqFRHJ+flrE/0XPjSrNl+trkmaXZ5TwBOckMonGyi8Ui3ygM8qTLJCE7/S9p4dJrxd4tEOwJ5knvtDt6KWTlcIC5uvD2DymBGEqNgNc2DPzNvFsKgSgjjgT9pCquLfm39lVmAA4bHihLHgDytXAlcZQKSWmaald3DsnmnRibQLBxnkM8ZkGixtiYru4B5cLGR8QfSmVNQNnNluDt7X/u4zxE0FgcagbQdZBC0jkahyiJEUTjwHs/8WXsdT3bx6s+Brej81eEE7AFO/NOutHTjNwYeWkzdXm1iHLcsZosiW94Yota+m2VBLOMKlt2oAykAeLKnj5IGf7Cc/wb6rF/Gr6GlyL6xcpeeoi0GCzrNupDxWbA4kfIOCriEzdynSlFmgMYhdVStvb9gxn4Zzodh0vsRHp/9VdFtVkrlRpQsS+2RigDZzGG60k1ndyDw4Ra0zIF/1Ad5lw/Z8Vbioimn87sBRzGteWdnCXWlvhfMUIOSKRfgDgvuKyIQ+kgtt8aXTWFC5LpGUPswmQ6GvlUTbMaJV0F5PNDAQCgmb6XSgVTJyV1t8cH3McATz8pa2U8SdvuMDK+2tUM4t8JBfoVD8YXO7PAMRZLT3cLngWEMHVplTtTVwxKPwu9AOzTDS3xtloUwH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(66946007)(53546011)(76116006)(8676002)(66446008)(64756008)(66476007)(66556008)(6506007)(4326008)(921005)(186003)(55016003)(7696005)(83380400001)(4744005)(2906002)(110136005)(9686003)(41300700001)(26005)(5660300002)(7416002)(52536014)(8936002)(478600001)(122000001)(38070700005)(86362001)(38100700002)(71200400001)(316002)(54906003)(33656002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BqiwYSoFFYGxoiSLobjRp+rbgCbe4o2dcESBMwXxbuDNXzuPi8K3AoxuQmpt?=
 =?us-ascii?Q?qje7sHvUQYYCIrznt49u72CNavr2ffC3p96GolgXx16og/eZchy+ef9mJz4I?=
 =?us-ascii?Q?YNxOGOKfs0VIzb1z1Fy8T6mBkw8PZLCDM71Wp4cOP6ffnb9wKVLR3jzBg7dY?=
 =?us-ascii?Q?pZEMnQvSgH0zJfrclgNpuEHNOVS8YGCEhnPPeVc3jDHayPu1XI6HxEraW9xH?=
 =?us-ascii?Q?EuDCgfd/KChWSi0zVrjG7uTOrACKhME4xX0OjHPW5yWtWKvuxZ2wZAENIEq+?=
 =?us-ascii?Q?TU90aku13YpoM2Ja1CNdB875XR8XUgAf3Y5ffP/0d9DxrWhqd3sExlk73SLo?=
 =?us-ascii?Q?sBLmBsGlCctguaBJ8Se1B9H5iXrSM7GJ3qDgTHd42yTiZYmyTTiGJ42pbIAn?=
 =?us-ascii?Q?m/7J6nRH+b57fQFd3ykQwZPNO1FNi37jyVbjq1g7l+25eHLkXcxag+JnlUky?=
 =?us-ascii?Q?bordQcnsDXsXk3SC5uAu3lFP4AAbC3UMNstssXLmMeys2bES45740GtYeGMQ?=
 =?us-ascii?Q?KsBaSCsuSgkH791xSUTGgmCqShPCyw8fQmiPM2AHIQB0dnuLGdyxxNC9LCYz?=
 =?us-ascii?Q?HTr0AsCOMxwfhjz1CtyPsSN5Qg0boMjeralOSeFb+E47Mbv+v/zB1V+GUzh0?=
 =?us-ascii?Q?1kuLoosczmJ0n3Chz6ISMolNyCd0lIt/WT0m5j9MNi1XVwdP4t4nlgQKGCaQ?=
 =?us-ascii?Q?X4tY5dNRuQftAhsgBoaOz7vo3yfOa9yNDSfXdvpDbKTSDRv6jRG8xgt/zJ1c?=
 =?us-ascii?Q?ROkI7mN3XNiHF4fO1iYv6rsQRb74dQiNBHRJxoKk1jjJ/5wJkCFf2LRnyLaA?=
 =?us-ascii?Q?oZq5Rt3rVyvcgOPs+0TCcK9VmxEUyTUHHoHeo1NDwjt4TjsMytC0wszJXYwh?=
 =?us-ascii?Q?r3bC8hFRsKuELSQS9O5eU0oaj8IAHW+Ga2/hJIxY621ERJ1mjtkweQ8qggK2?=
 =?us-ascii?Q?BPIdB0X3bF0XmKQcoQNKarazwAc0USzxN3cj2Z/c//8M6AM77NQHPLNoajOd?=
 =?us-ascii?Q?F4C9xCAFx57G7TJ3Rb+ERxX+UV+JU9fLyU2nR/ZZ2jseJ3qEPAsWNOyO9BAH?=
 =?us-ascii?Q?Pg9Lyg/JggnhDu8uoXB22oU1vjyxGRGcCgJDxc7Vb4HPZ4FRtegUlXJbD8Fm?=
 =?us-ascii?Q?P5+rtFg+xB4kvh16ureCiJG9AQ50h5FeSX6J5UA9DIwMqZy72qDEqlYHLQxH?=
 =?us-ascii?Q?R5keZugcvs0/fhke6WLMDc9IZaHJkqT90Y8ivHtG9eo4A7aBKSPaQ2P3VhKS?=
 =?us-ascii?Q?i61crEVnPfnzDw481ku64cjYQAqtw8DK70mQSL5dkO4BjDKq6bU++h6Ir9CE?=
 =?us-ascii?Q?4IUsPfK83/byvAI869NkoIonB8fkCGaTO+kakxepgG0oOfYvnf7hCNbf4QK4?=
 =?us-ascii?Q?WTksEmoe4d8YFLhcFF8UUzIeGp1LqxabcLzvnyqbaIJNSDy0Y8r/1E0BMfQr?=
 =?us-ascii?Q?3gTHLmF6qRXdCHzZtMBsMz23M9a87bNxJSKk2Tn1SMAmRPu3qcV6MVPvop12?=
 =?us-ascii?Q?f4Y09KHWgf34oy9doC5Sw4qIy9yyDJxKl/Xa5yvFHLX+JkHh8zvU8pqPmylh?=
 =?us-ascii?Q?NCxOnAzHnNopsM+z8XgxB6DSLTDPvXtc6tp0N0Ev?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cda36c8-b6ab-43a6-1c3d-08dab4dba8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 09:47:55.0498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aG7ue2T+kQdjTNcuJDFa+gT2GbBEGfhHr7F/Vr6jjTG7nRTea7yLarHwZ3JKT2oQDIFn9CtC/UpvyWCfEf0gaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bean Huo <beanhuo@iokpp.de>
> Sent: Sunday, October 23, 2022 12:37 AM
> To: alim.akhtar@samsung.com; Avri Altman <Avri.Altman@wdc.com>;
> asutoshd@codeaurora.org; jejb@linux.ibm.com;
> martin.petersen@oracle.com; stanley.chu@mediatek.com;
> beanhuo@micron.com; bvanassche@acm.org; tomas.winkler@intel.com;
> cang@codeaurora.org; daejun7.park@samsung.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v4 3/3] scsi: ufs: core: Use is_visible to control UFS un=
it
> descriptor sysfs nodes
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick
> on links or open attachments unless you recognize the sender and know tha=
t
> the content is safe.
>=20
>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> UFS Boot and Device W-LUs do not have unit descriptors, and RPMB does not
> support WB, we can use is_visible() to control which nodes are visible
> and which are not.
>=20
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Reviewed-by: Arthur Simchaev <arthur.simchaev@wdc.com>
