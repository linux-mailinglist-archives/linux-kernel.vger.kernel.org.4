Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D77A622531
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiKIITE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKIITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:19:01 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E21CFCA;
        Wed,  9 Nov 2022 00:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667981940; x=1699517940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=44laDyOE6Qvlb7OsQxixrPaj7oIA6rSjrhWb16Wk+rc=;
  b=B60XlfAosLP9c2EyqMhMDZRq9H6Js/pP8bpgIluhRa5wjuWxXYSj+ljL
   gFJFFG+1bY1nG+o+i4iyT3NHXyiMv8ft1ngpfdFDlVzRsa6EXhA6snaz5
   jnud+41oZtVxvI+jWhZjSsu6fBfiP05KyvrbUsXYfhTDYcqaCX4u6jbO/
   hRHGYGfP9wepg3l5b93UWP40yRHXyE3B0PMhojaICv5jZepPxHgY1CJuI
   uH6NFPo/gWHQqZtbOl0kUYSNs2K+hj6+kdqGaIM8G++7PX0WfOjztlloJ
   vm3+ErqI1QwMnFDZTOWLLiQd7rYYm6ZJ6C0HpWo6bwIBAQHJCmeHtoF6t
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,149,1665417600"; 
   d="scan'208";a="215841851"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 16:18:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNZGycS2YF16Se73tRqoz4SNu7lBj+f853ldFdwui3yd5reGvVwzB4ucSwwF6OWRoYUj0067UXRG+4XTDvoS+rQ1BSDdrs3xoCi8VMwefQJtboesJUDCBo+JBPsrJFVl8q3JWu+MIqmfyilvx5lwUMTKz2P4MDz7Shb1kT2I97yiusbrxeJasnvyF4SYLAHQUI45WYmOEjPe+L2pWyvTj1JUug3y/ou8AusHOngwPoFoWJvzAqXPbrhJ3Kj3kAP5q8/Bj13A/8Ll5UhdHAab7rY7wZnRSOsLfpI+L40S0Sbzeza4caqL7SAt8Z+CJJx1XlP1j+5NdX0H6FzVVvr1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn8L8p0x/eoLYofkzwftHzs7e1I/eKXdCMeuvyFmSeQ=;
 b=ca/g/n4UBwPSI7EunJPJH9tWNn2mQqVlh5pbRAwVOZaee+sv3EQ/7wPo2RLzcev679NnEinizaz8Wb0DGyEJkKh9MNm4zuRo494QCCoMQ4I9EswTy2SxRbRqF2UA7MNDwZuEg8/TFHZ43ELi84MM//Rf1mvOtU60Ka2VxpEvFON/ocOel+E5xG1rrEEJ4triUcvYkWGJmPCFtfourtryLucnZcrP2Wg71stxLmJOhm4P+wpn5lIzOEOp5WfZTdYEH1diFF3tawRC+UUAUlrGT167U2aBVph0uAA/T45aC7HskDcObFbZd1NB6ARdf2nGpa/JNKBDIYgmnCR5WUvT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wn8L8p0x/eoLYofkzwftHzs7e1I/eKXdCMeuvyFmSeQ=;
 b=tUHvlekdsMe9KO0aARCyiWpQ6zQrwsfOyWI2tR5XLhYZS+epkRjqCmXikWgi9mVe3wc1ZWGtvnjfR8Tgj7756UmN3wdJOnMklE+NyEd1kyzn8OA2+z5TnD8bqAsbNpNGtgfHJcIQ8dvw9MujA1++RTyEVVSJX0RMmub8DajDl2M=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB7350.namprd04.prod.outlook.com (2603:10b6:510:b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12; Wed, 9 Nov 2022 08:18:54 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 08:18:54 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 0/2] UFS Advanced RPMB
Thread-Topic: [RFC PATCH v1 0/2] UFS Advanced RPMB
Thread-Index: AQHY8qpuI/QP6FW+6keQsjCzPOix+q42QKMg
Date:   Wed, 9 Nov 2022 08:18:54 +0000
Message-ID: <DM6PR04MB6575F12BAAB0883DA91EFC5DFC3E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
In-Reply-To: <20221107131038.201724-1-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB7350:EE_
x-ms-office365-filtering-correlation-id: ca243dcd-ed24-44ba-634e-08dac22b0ac5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tr1HlCDs0tQLGQclwFqh9dV8JM44gKJswwkU3FywJ5RVRJQ2QDa45NXDm/geU9B6Bzlzd2kQsaMY42/Nt4OAGc6U9Vi/hH02kj5QbPmYg1kDwvfaxp9VQ2BkbcgnE1RYzwYf6wzRO2xmCifGg0lcoxVmMOeemTTkjqsAUMNDNQl8cZROlmKH7O6ORM6106yFHF4TP3PPq53TimSw79YrvSo7TZILn1RGRGEXJSDgY4z9AnaQVgHirSsCGSB0lCOttqmx81F9aJ0v7Hn7og6RDgt2YCS8lVW23d20w6yj7VpitroAiU3ymXI9ZQtADd+JIp5wqBWBxrk7iWGvJGx3X5iki4SOo6WlS24Anj1MWtbmnwtGKa0CuB5VAAncb2Fd8ciRADGpjnW/bYE00KpSXWiVuKOP1aFB4icKOfRTmFEixIUtpIhh7zAG6pgySq7d+EBjoFXeTjCWCxoMkJ7H2l+LuUVAV11JSVg+tm1PHnD9pBrUxldprERQ2jmR/axVMUkAoB2aEp+1yRkmI4oRhZ0wj5LEiT5kAKpGBsNTYmCj4Ix8hs0KRRC9G7yI6qcGFTNmI2WhahPLYNx9oY+QeBf/mdVEcXXdxRrVbBaPJYFOHEbLt+Iq0iK52ARXQ5vsIk3pGnh2nv5aajdVpX2tACGtRKg1q7PulVXnQhe/HR3UdgWgVK8MPITlCYQrogKu677yUUOTn+bbULnZbx8/Gr4g/F7lC/5SalGAaWYmoLD24TiJfw5bvvdphRdi7aXWG72deC+CFZSu+KWa4lfByq+OV7B2L0LEUDEyfrmdauc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(71200400001)(478600001)(66899015)(921005)(38070700005)(54906003)(110136005)(6506007)(7696005)(316002)(55016003)(4326008)(8676002)(33656002)(66446008)(66476007)(64756008)(82960400001)(66946007)(66556008)(76116006)(26005)(122000001)(38100700002)(9686003)(86362001)(8936002)(52536014)(5660300002)(186003)(7416002)(83380400001)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k8/tTtldFZiEsQhBv12uZOUWmdSKZ9wOHUlYPWO/5uv5hodJZxzVxYfw1nm6?=
 =?us-ascii?Q?99VyqAG26cwQpIefBlMirbVUtb2gBpdQ+myY4ko7pyJGW1PEQx9GwqoNMO2d?=
 =?us-ascii?Q?oQaV0L6OqRzLtzK116ZyByD044LGGHAigmfqcayO/tOVT47V/LhZU8G2NK/7?=
 =?us-ascii?Q?vr3eEyYD75SezFN2BRRDtgM7OI6jsCM1jSXBwVkPfmeT2b51+czh7XkXfw5a?=
 =?us-ascii?Q?XAcgIg73cIE8A7gk6aoA/nM02EwwMnCFo10ApxU1iRYjYfzHosoR15Er/w+i?=
 =?us-ascii?Q?Fq9k9fJ9EmBOmBoli77l704n+K++o7YQd3flWXvtEiGRzjQ7YeQf52+ws+lG?=
 =?us-ascii?Q?XtHUxDGo8I4D9ASRWFkl0OppMlwYWT/MwgGZEOgcbSuJKhj3gIno0NaEzhsM?=
 =?us-ascii?Q?rxbyYaKktEpyVv9TldhzGZ6M6HkjX02nOYqP1yRehbKUOyXUFi7zY7qyrz0y?=
 =?us-ascii?Q?rw4Gmopj6BbuQ1GkqS4wjSUt7w4HoihZWWlyV6j6jBdaIdoUriEg137T9Tpv?=
 =?us-ascii?Q?LyIqx+c4o2PB6ZKTBvDkbXJUXMhcJ0kIPklgOY/hpn1zkTtADQSFLnTpmrBN?=
 =?us-ascii?Q?Br5rRAUTaFMd1r0vwxbKZgSkME1Ubpoq8dTcpZM9IccT2Xfgp4DgPCRkiK4v?=
 =?us-ascii?Q?i02mIE9oo4fEO6v22jTAe+1R6cBrH8hnMD1EvVe1ZZVIeK4EppWTlil7U14t?=
 =?us-ascii?Q?1lq2UEJOojYyVb8xuis6mSlFeY9IuuWXyXBOgH9pB47cQkLrKMtv5wz/64D7?=
 =?us-ascii?Q?jdo/MQzZ1TfCQSTXTr1X8Ot2v4H9zG+3mep3s01A1ZG6kq4jfCJ7Kkk2r1y7?=
 =?us-ascii?Q?XqP63h2cMJnjRKzmjRuxXDC7ux1YfHxvU6dmQucW/RWiRGC/QaVIC6f/AGoY?=
 =?us-ascii?Q?3iF5PSPztXs9ed2gtaJLiz5YNZQJudbNEaOfRT2DbuDqOCdaslQNVhQFDdi5?=
 =?us-ascii?Q?swQ4p7cEfFuSvFM6Xx9ZvE4a/T2+4CmgW7/o3yRcGnzTCQA0dbbvTDC4vytU?=
 =?us-ascii?Q?4t0cTZwaJmEdQ+m2nh5Bbto1mDXfNc1XF9+HhbKKN4B0dYa7sBdoDWqkR+xm?=
 =?us-ascii?Q?97HizKKEMH3dtw0azSB2yakq+8vzRmyAvM0CVDe3+YSGXUAqroY27SSsiHnC?=
 =?us-ascii?Q?FZ2q2UPiVSyV3Bo1nqBK+cEz2rxtEEE6OEa+xnjF46D5o2q8kdjxxT7qS6fs?=
 =?us-ascii?Q?E4GZF6UGQ7nuxonwM82Ff/TTzfI4+DV3sBlrSbOag/zbPz1PeOsx6xWph4z/?=
 =?us-ascii?Q?pTpsefmKQL8A8OshGLbo4G8S+A+kUF+dA0JichL/6+XqOioZypDWIs7AqLZB?=
 =?us-ascii?Q?RsJesVXq1WqQHt6fAWMy4PGtDbNE5ME96sod+NfthqI4L1z73eKa7LgMh9Js?=
 =?us-ascii?Q?x5St30QbAnci6BexX+Xi8fOlH6yDTnnIZGz0s8AFh5PndnGWlGsV+t24vkOt?=
 =?us-ascii?Q?n5qJIw9Ilndk6u6pmjSvMlWdmoZe65AU9ddrmcx9fgtrnCDXjx5N7qFOkMNz?=
 =?us-ascii?Q?BlZEOgskEDquu+yOsG/OrBo8oxIu+WP0zezGhkWnHm7qar7OXF9YWq9sBc8P?=
 =?us-ascii?Q?wkFvSU/uoLOdv3KYxT5gShZfCBjrDoqfuXDQnGAs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca243dcd-ed24-44ba-634e-08dac22b0ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 08:18:54.6125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRFjss2i7vPH8xyOz1o6CuWfSMuOlkZFRlWOwW38mYK6k1ZFcvn8ffZVlEp6/ZTN/dCJdjD7r8SMNMTyj/tEjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7350
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> In UFS 4.0, it introduced advanced RPMB, which can significantly improve
> RPMB's command performance, enhancing its atomic operation. We don't
> know which implementation will please everyone, mark this advanced RPMB
> patch as RFC. Any suggestions to make the patch a master patch are welcom=
e.
>=20
> Based on suggestions and feedback from Hannes Reinecke and Bart, we can
> use job_bsg->request and job_bsg->reply to pass EHS packets without chang=
ing
> the BSG V4 structure and BSG core. So we push RFC patch just to start
> Advanced RPMB mainlining
I concur with this approach.
The current limitations that the new spec imposes,
e.g. putting confidential data in a construct that lives in the ufs-driver,
practically gives no other alternative but ufs-bsg.

If no one else object, maybe you can leave out the rfc from the next versio=
n.

Thanks,
Avri

>=20
> Bean Huo (2):
>   ufs: core: Advanced RPMB detection
>   ufs: core: Add advanced RPMB support in ufs_bsg
>=20
>  drivers/ufs/core/ufs_bsg.c       | 115 +++++++++++++---------
>  drivers/ufs/core/ufshcd.c        | 161 ++++++++++++++++++++++++-------
>  include/uapi/scsi/scsi_bsg_ufs.h |  30 +++++-
>  include/ufs/ufs.h                |   3 +
>  include/ufs/ufshcd.h             |   5 +
>  5 files changed, 233 insertions(+), 81 deletions(-)
>=20
> --
> 2.25.1

