Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A563364F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKVHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiKVHvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:51:50 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DF3206C;
        Mon, 21 Nov 2022 23:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669103509; x=1700639509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OFXNyNojgzVrUneexpTCAdap6Jy8WrMIebBWli596SI=;
  b=J0MB4cLdxuHuUvKIoG6GVN6zBTxpoJQ7PRaB9jnhgGflNiYBuu9BQ8ba
   WU49qxcDudyPYm6Q/vKdJkhcrKG5Ezoi4YSNXJLEZCS3NuiSNqtkDLutH
   i93yxmO8fbTR988cuLy5dPCpMYyUZgoP7tTsp1g0A+gTYwk9CJnVDF66Z
   QwQazH8Ow8hkwVp4e7fCyyzVnHBtd+a3BfdGQiPHin6CVy+arDbIlOc0R
   ZDzLHrUkKxFIMG7eVqrxYuIw7+WLnvkGwBnSpqiHVq5gDMJ31cgCFyRn0
   kG/GMexmhEciYQDbRJgzBQBSVVJJ6fdOsbhj/B7HaZzuM/iKJnm0JrdFB
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="215119529"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 15:51:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpMKdigOeZ6NKSWHsODp1D7l9Q2bdB1DqX4KdLe/0CU6EJzckquMxpSW+CV+5gWou2QzqrkwiIrd/D/H9ENtWuSmk1maG1EFiQXfsErQm6TC+9lUQusJgLxQhaHJzUQhuPJB10SUtWhJ0kDKo/0YT1f2gRJAtRFYId5GxTGAZoP1mgizbJqPH9gS1+PmM5LJEGt/7Z26EMSbXaUOaOxnRNqTkxA+AmqygfEpxGg1dGvEFqUlBei/GY8KD1Bu/dDzS0iiA5Oy8kstr84R69oFMBCaQ+iYRr1qYsGplPs40N1R4lDqShZCh+CUVUHdhzAhjPJUlhFw0HJLHvVikNIqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXy/9VWtJcZMKAummnLpgP0RHYybJJPe9vhEV47WSYA=;
 b=RN1Sfyl1SKb66s17V60aQu8G3uEtb7Gm8D0EvCVwaP5jESl3vUZUbHHidqG+9uv0MNzMeN/QbTHXrTQAKawSq6QqdNzfZ+tRC91q9Ajr0MO+Z47Pnb5L0wZgSVuhW2ogxu5KNZLOLqG8bWnRE6/WOhFsjZj/Byaj5DvFXezULNE4Pq2vsc0ot4lnCveLqT0vRXCbKeUZYibX1Bs536w4zYOu0SFKbSByZL8+1oXhcwUtCQx2ZRBjVQ9ARgnyT+NFM7MjPD8GaaoJO9WjvuR5XCpCqaQ2GtDHVzwhzAaiqvn22BUgOvxSRuGDHbiFirsMJG+t2WwvvSD0S14RRn0HXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXy/9VWtJcZMKAummnLpgP0RHYybJJPe9vhEV47WSYA=;
 b=v7edfaqRrLReS3VyBB1lrfQ3n1Us6pAUR2J60MsjNlwEaSE+pv/eJ7VkadG5Zc/thbsuOatIBTeBETVu9sSeqfr3F5wH/TtwBhD3+UoagdDzxigLzJBs81C6OS91Nd9A9quSdS2V5kz2VKdtq2fpQPPoaL0a74MCa3+rlI5GkaA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB4086.namprd04.prod.outlook.com (2603:10b6:a02:aa::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 07:51:43 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 07:51:43 +0000
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
Subject: RE: [PATCH v2 2/6] ufs: ufs_bsg: Cleanup ufs_bsg_request
Thread-Topic: [PATCH v2 2/6] ufs: ufs_bsg: Cleanup ufs_bsg_request
Thread-Index: AQHY/S6maCN3xUC9iU6nCajbprM+ka5Kk+Ug
Date:   Tue, 22 Nov 2022 07:51:43 +0000
Message-ID: <DM6PR04MB657526124CB8A463C1093CB4FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
 <20221120222217.108492-3-beanhuo@iokpp.de>
In-Reply-To: <20221120222217.108492-3-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BYAPR04MB4086:EE_
x-ms-office365-filtering-correlation-id: c40e9c0b-4940-40b0-399c-08dacc5e65f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7j6tuVr8YEUDw28ooeOGlnyyMXvT1D0ntSFBCbmla2reJ8ncbeB+oWSWIBJuCEIhie6lQ/DLyT6r1LOrLuAHG0ASUpaqKSx3eJd5jWB4JCLU4hxcks9Mtbg23FfVy8/If/EcMpkKfEx5Q+n+oAjzAR6igDTMC6eYN3+DJykdS7CVgoLTu5fWx7EItzbnSw/JpUZbM09LVqzgtMlB5Bseyu0Gohb7KGqwqs/n1X4Wbix3eRhd0OYjxG4S5QDBj8A4DzCxs9ZRICwkQUBz7bKYE5dA1TpamcZoiiSY0vSsy07suJtNnFHK/7iNWY58yHyi+P3K2FvM1L1O5nfA3z3Zmh2JpnWPbQyQueurwClIPO1xzBNJ2GHIhUpZx5i7+qlfduQde0t47qvnWIzIqXbbVUlpSDhQSEOppbsLKNjTOqYMSGIt/7UWyH1yKpxotko0nEnwIFs4U6ZjAHVI8J2h/U4vpttndTD1rOjenn2BScDAYVa1YzFcwqdR0EnZxY5x8ITHCG1BwlgFk52AuAmNe9tBwgDOcbVj3/wWdGl0b0CHy5gHiSE8Q5KsP2zxu4BtFtQC4Q7gf32NuQfaUVuzDJpbOykHVwiYLgPKuqJ2xe7x+3iedRW+FSn2E1dcXdIukkOaPRLzzi5QcM2mzmY/BxACc6La9EKWwgLXGHfuTh1qy8mKrwhoH4milDGgkxid0sX0qnAre9TBf+kfMpGWpRxfPsrAdg8qsjiSBhg6ARU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(83380400001)(2906002)(33656002)(66946007)(66446008)(66556008)(66476007)(76116006)(55016003)(41300700001)(86362001)(64756008)(82960400001)(38100700002)(122000001)(7696005)(6506007)(54906003)(921005)(38070700005)(110136005)(8936002)(186003)(5660300002)(7416002)(8676002)(4326008)(52536014)(26005)(9686003)(316002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fgVLpggNP5cimifSRST/Wp6qrc7ZJf2kBHXT2ncTgs+ORfyjnUqRpUQpdKnd?=
 =?us-ascii?Q?7rFvngpgxyRKzqYnm6ocX8K+avelZxiWkqCJpb0SGH8jOGwwrVcCWR6qzkro?=
 =?us-ascii?Q?MUVSShVqOHBoH9QME8c6dN9mlk3S0bcgtN4ZTVIK0COlJODVkjowRRDJKeLD?=
 =?us-ascii?Q?sm5AKSHfKOkj3FJEzAm77BHUMnvS6EO7tszbASFW13sSXCaZk9ePg7Q2wB/3?=
 =?us-ascii?Q?w+6FioDVqm0AVNxFUY1xZgf0qnkTwQ72QKRNQLPfK87fNIygk8/K/s2I6DwX?=
 =?us-ascii?Q?PHTjggCgjzStmQtg0cJeW9C3fB391Tf3Toael9dSokrvscQFjrSe6eeuaDRg?=
 =?us-ascii?Q?ZUKOBE34M9T+ukbQUkRITilQPW25thmR/84RINg3JPk6Gs5g6lNNux5W9Xw8?=
 =?us-ascii?Q?brEgsLT4tp1JpOHRUrZ8BrmvX1k5r/syU+wu1u2i9agyXY5xavsQ4Qz8rJ3e?=
 =?us-ascii?Q?/TrZ8R+KcDrPu5MpaEF5/+N8K8JLxvm+kkKw+cefR5Hs1oDhs4iUbTdcw/4O?=
 =?us-ascii?Q?GM5I2oJjO6DoXsTUgU97r85HMSjbOP1mHZO+FOjZL8GQDylUErd12cRE578e?=
 =?us-ascii?Q?iCZJ8ENwJ+QipMqwM8EEy7fGnISgla0FLxH7jdezXDblebzVNjUWQ2pvbuVP?=
 =?us-ascii?Q?yeixG7b6j0CItBACJnyoMeP3qeh6/zi1ziBFk3R7eiKOJN0/lzproO8exUKs?=
 =?us-ascii?Q?Ch7BA8aAXlQPSJ/bAoEL6Ity40SXMmbq/hwhLib2s1v2KhrI0cX1viuMIG7m?=
 =?us-ascii?Q?ge04OuL3pifET2jn9o1w1eLZoTxQirc+4SGs3lUlPVofqZo/1PkXXxSCQw3K?=
 =?us-ascii?Q?I+FxiRgseGOZAwmlCBrA9e7dW1JmELoM6GUfLRfkfMofJOqSASYjnyroFP+A?=
 =?us-ascii?Q?Eepco31XZNxB5Q81j43z8WKEqimByHeFcCJoaV3sDM0YYGzarpNzze+F34BJ?=
 =?us-ascii?Q?yGXAZQWy3owMe9n8OMlJWBNzOBx9iUGjO88EeP7KeKUDJle7OZB4FIicDp71?=
 =?us-ascii?Q?vcS36EFQ0Yq7Wd4CFBSSuTfHfztzThRJVK8GfP1asjwGIaNiv3cHTJu9jpEz?=
 =?us-ascii?Q?3yTq9IvaR1GySfPUC5RrTrD+yHufgtAihHqPreyFuQNLxQLpSO9hw0j+ypOq?=
 =?us-ascii?Q?jL6ovLRsMg9MmAIxEfftOvWvxtmNQsCENEfbIhGh62hltQtDQRi5Jp/62JPu?=
 =?us-ascii?Q?XHPQ9/HFU/7RpH7rhi2D+wi/uqx7HNMtJThaJ74KEWrYoY8DFzcr+WCO6tHA?=
 =?us-ascii?Q?vScwLDBMQa+lj2f19qzMhfdRuscY0vSp17/zp5rlzJMLUbTmkdQMTLPuV6Uy?=
 =?us-ascii?Q?or4e+fGvrsQurJOhFWAd4yzvzTZwcIcfRgMj153Df/O0uhP1khf5S2U3FOs2?=
 =?us-ascii?Q?s+R+5oWQxqOJ+j1slbc55QDu/C5GcIHWaaax+ieMLv25AkNA4CmejwIur6Rz?=
 =?us-ascii?Q?8EnYzld//GrnwDjLEGYhBhumw/+VX3WlEyAASW37VJ+xreq9HZ9fK3itp3z8?=
 =?us-ascii?Q?9lOxMUMEHqoFBW+ZaOCUiON3In2uFr/ELw05uC0PXxHH8i9rc2xMpO8cWvHk?=
 =?us-ascii?Q?VumGX4HYKTqOPwH0MAvk0G/INRY9uuF5mYg6u5ae?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+K3vHAx8zg0ULVXdea/g6/5zHR64jzGTaufoGcIyNr7IK47eMLKfxL5F219L?=
 =?us-ascii?Q?u9MvgRD12+xw7tDIGlwB/fOS45r/qCUTOTshrZLvl4PRRnhZ7seHVMrFfhGe?=
 =?us-ascii?Q?KKDwSxpvw8GPbV4bZouRaN+YWeZoHRlJLk1Lt7bfxZKzPBE4cX9Bj7jSt5Du?=
 =?us-ascii?Q?LWjK9ocKwiY+FV0Vc1zl8u3hmUtfdSeBv17usnYXdRQQGehoXoIxuHXVnvbU?=
 =?us-ascii?Q?rYYDeRvbagxoKNDcku1p2NdWAYARRjxa3VWL4Cw2YW3taWqir4kUfNFtJpqd?=
 =?us-ascii?Q?DPTWcxaovnc3bMBSm81NWPipx7TjqzqQZxfMg/70XS+Cl0SrY9+xMoLPyf9f?=
 =?us-ascii?Q?bRrYkSbu4kN0nU15AO0u4kJB26g2biO2dWZ9CI5xii6Sc31X8RhEtHT4kFOD?=
 =?us-ascii?Q?qz2xzHJdr5QeYSfE9CId8dys/cAaPWynXYv8H/3PKQCW0MAOB5S/kNfEM8mh?=
 =?us-ascii?Q?Vo5LUcFK3RcU2Msoy8y/4pWMlzOq+sxzuk53GDqAn4F+gd8kzYE4fufk0AwI?=
 =?us-ascii?Q?tiaLFukYAOZaIc3sM2pj8MIm4J1Fj/bvI98/7UHEt/N7KEnym+wIH1cA7QAz?=
 =?us-ascii?Q?N2g/FoiLu9jINtl5Tv9nn2XjF9hH9ikHDllZjvTLzLofaNlzAHVyLlX6I8J/?=
 =?us-ascii?Q?798oAZEb6KIRNSHbaWogigU+rWD+OTsO9f5vJVPx66iXEAbNAcQKhHlVbVms?=
 =?us-ascii?Q?iObMaa+mHm4/CMlyim2Eo43EK83LbTMkIW1tpgJXc/s6JAdZHQHQMOB97ovM?=
 =?us-ascii?Q?yULWLeNnUK0KH3KA0iViM9nV6jqEj+tauYv0zlCcSB8B/CSPD639OORWd7MC?=
 =?us-ascii?Q?pErjJeVM620UEK0VJXRWhbakdqnvwdwAfyP36VAYEp5yckMncOBbqkhUOHLS?=
 =?us-ascii?Q?46jVkQhEtwRBDxZC8MTouTnPnWAACzfmdEocLhAE2y+dK/HAHMu6VsBUqeVl?=
 =?us-ascii?Q?j9DRUgiRqey5Hp30qKx3xo4ExVSHkM68OLRwveKMUo9K329eGG7V6zIFPp3S?=
 =?us-ascii?Q?YDOsTQoZQqd5qvVXHFhdM0dEqi0esLCqI5oP285rGqt745WNswR76jR7ktlV?=
 =?us-ascii?Q?N5+SRgzqqju7M0OzVttmAjMr7KdvX27JJY9tVvCyHM8vIqJe6ouz8yruy390?=
 =?us-ascii?Q?MR5Zkq+HEaxd28/szRwkwTJzZPVggUFij5gOKSSntHybGIt9LoJjPJtq+e31?=
 =?us-ascii?Q?r6nhcFn5WKh0SnXEK4XX/9vUIV2AfFvObxf1akKEp5sVNARqUfYjCpSdrimU?=
 =?us-ascii?Q?Jo1qeRFdwu/z+BDGpxFZEIu+4HGxCkHShGwJ/Foy/w=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40e9c0b-4940-40b0-399c-08dacc5e65f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 07:51:43.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRsXpF43Ca9haFPM7DcyGbNdcz+JDYamxC2/a/op74PoCSARppBXmUZTVGvXrOlEu8YfCWOLZ9rgdfS4QbqYgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4086
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> Move sg_copy_from_buffer() below its associated case statement.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/ufs/core/ufs_bsg.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c inde=
x
> 9ac8204f1ee6..850a0d798f63 100644
> --- a/drivers/ufs/core/ufs_bsg.c
> +++ b/drivers/ufs/core/ufs_bsg.c
> @@ -90,11 +90,8 @@ static int ufs_bsg_request(struct bsg_job *job)
>                 desc_op =3D bsg_request->upiu_req.qr.opcode;
>                 ret =3D ufs_bsg_alloc_desc_buffer(hba, job, &desc_buff,
>                                                 &desc_len, desc_op);
> -               if (ret) {
> -                       ufshcd_rpm_put_sync(hba);
> +               if (ret)
>                         goto out;
> -               }
> -
>                 fallthrough;
>         case UPIU_TRANSACTION_NOP_OUT:
>         case UPIU_TRANSACTION_TASK_REQ:
> @@ -102,9 +99,12 @@ static int ufs_bsg_request(struct bsg_job *job)
>                                                &bsg_reply->upiu_rsp, msgc=
ode,
>                                                desc_buff, &desc_len, desc=
_op);
>                 if (ret)
> -                       dev_err(hba->dev,
> -                               "exe raw upiu: error code %d\n", ret);
> -
> +                       dev_err(hba->dev, "exe raw upiu: error code %d\n"=
, ret);
> +               else if (desc_op =3D=3D UPIU_QUERY_OPCODE_READ_DESC && de=
sc_len)
> +                       bsg_reply->reply_payload_rcv_len =3D
> +                               sg_copy_from_buffer(job->request_payload.=
sg_list,
> +                                                   job->request_payload.=
sg_cnt,
> +                                                   desc_buff,
> + desc_len);
>                 break;
>         case UPIU_TRANSACTION_UIC_CMD:
>                 memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE); @@ =
-
> 123,20 +123,9 @@ static int ufs_bsg_request(struct bsg_job *job)
>                 break;
>         }
>=20
> +out:
>         ufshcd_rpm_put_sync(hba);
> -
> -       if (!desc_buff)
> -               goto out;
> -
> -       if (desc_op =3D=3D UPIU_QUERY_OPCODE_READ_DESC && desc_len)
> -               bsg_reply->reply_payload_rcv_len =3D
> -                       sg_copy_from_buffer(job->request_payload.sg_list,
> -                                           job->request_payload.sg_cnt,
> -                                           desc_buff, desc_len);
> -
>         kfree(desc_buff);
> -
> -out:
>         bsg_reply->result =3D ret;
>         job->reply_len =3D sizeof(struct ufs_bsg_reply);
>         /* complete the job here only if no error */
> --
> 2.25.1

