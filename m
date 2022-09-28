Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594CE5ED61B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiI1Hat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiI1Hap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:30:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2DAEEE98;
        Wed, 28 Sep 2022 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664350211; x=1695886211;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bTH/ODyi0Glv//kD7AYg82biaOpKqEGiMcExAzrXinn5ips3jaQ7I16f
   5MJSflZlC2M9Q+D/byAvCMtc6q21T1hEmPo3aVRxnjS1vNUAjZ5HSK9HN
   gH6RjgkMnjSGno7VoBoQH1C/UHRowEb1223fUICGTNycH409kxK+VNDZ0
   HSeEV/PNJSru11ZDtRicMcAcgr/soyWKVh/GTLugUJyiNO2jMKfCixxZJ
   WqTKsc/GwjQZx3sopAvYt8vM7NNwOG0Myto+zV+hPH2eV5zLTiQ6PXIuI
   X+anPVxXhdgcAnWNcoRdMj5rkZw9I9Whp29y512Hn9NJTGcIcbLJcPFY+
   g==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="217644549"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:27:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpMReFN0c3as6fZRnu7l6+W6vDql7dTpH9Bumyq7EJOIUJoVYfG+aGXpUvw6J0PMlqmYSaYyP+b+2xVkGHsUHhQWErXfvx03g781ghWbl1tMKW9RCZKOE3D2qc0iWfjXWytx1EYkvJxMYUuR3GtIwUfBglBUAxNif1MkS3G8SA4H4RbZIcRV/aTXr++iEOx/I+htPQ+EFET6gdwqvf2RjFWenN5+6tFQSZD7vY9nRcUdh4KpySfYTT8iph2bz904QApvYUOSWA8xaA/SZpWzACJCJYZF6GvLzRWVcP7Xuu2Z8+Pt937A7+SEyNfK0d1OSGAWuzDD/M8JmtA9K+bU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hQwBAx6Eldn1mRT5KsbfJUr9jh+t1rTWAGlZ0VOJExOhA/78G8bUToCDDetqHrvzKE+fXOG93tUQHTYldL5bcK1A9U1bNCe11nHmkjZKs67TY0eTeVHPGQJA0aGIsgpDDqNxAJHec53vbHOIMomqXM2S+V7CwmeHMTr4JB1yQobnWIYn0vjQNONK/hASOdub6xXLzktMLiSXzoWTpkmit1bGtoiyBIvoRpTKeNhqS/BUs7AF3LtMmr2UDDckXKCA6Q0Uyejh+e4fesjEAxiI9MVsyC2JZtMJAOmY3PFwGj1FWddokTey1VG8An9YYxAmfMWuIFT12mCeIe6dRT+Yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NOebmGJtj+inw3MIALiRDipx5C2cKGyV4BW1AEmNTHkwjsbcOnkWLpYFEpPAU9CgbVje6V7BoqN8wR4UDYj8Y5y0sEuDigycfWP4JwhrGXpfQA4uwV8V813eTk966HOjMw770PgtbyhTApln8PKdxD8Hgom8fOwIzfVeYtLVRiQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4487.namprd04.prod.outlook.com (2603:10b6:a03:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 07:27:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:27:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCH v6 4/8] scsi: mvsas: use sas_find_attached_phy_id()
 instead of open coded
Thread-Topic: [PATCH v6 4/8] scsi: mvsas: use sas_find_attached_phy_id()
 instead of open coded
Thread-Index: AQHY0wUftrvnCF21Rky2Ns61cfH7SA==
Date:   Wed, 28 Sep 2022 07:27:26 +0000
Message-ID: <PH0PR04MB7416DD7E7F29D5A1F64C44B69B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-5-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4487:EE_
x-ms-office365-filtering-correlation-id: ea63dcfc-3298-4714-7286-08daa122e47b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CBAXABu4SG0w/b5iN154YZoIP1rcMhTi+ufrNMOWUTBZBmrx2tUR50CUzBh63wNGfZGrw+dCdEDpvgJq4wtwF4pBsXoNDK4QWQv9fyX1oIisweVjBZzBT7nMm6nQFUtG4/iNFfwTV4EQdkchDaTsR3ZPwdPD8fAf9MM4sDuZaksrftkeCZ5SuqjH5n/Kske9TxY5NWsTr4LtHf7RwzNFZhjEmTGV2XrPuaSawGHuPzgR4DBw0VPHey3XqHGguXMyJJZajHGEG5ng2EbittoXPZSQ3MtJnb1OGtYtkMZi9Ov9HmcQerpO+00/NTgnEcbR7CEgrdQFp79AnSPLMmgKIJRMrWa2u48VtzlPqwU2hP7Ij4PCXGWOFLw13YtbckSPHO/MBFggSydeu6UW6Ybg4eeRs2+V+z+7c4I7mHlPCSJNpJ/fE4tVZ6ffCyrogSMCIaJWnB67DheiBQ05yrNs9b/2FP/qcA7oDiZMWI06l1zBrXOlqpWNRKSIw42qDv+cCOGMCppXMfn6sL+SgSvHinFY2KJE82bV9Z+jFkBmomAfg9EJk2dlIC6c6XUS3XtP4lUrapnxMhzD0R+4yBLJPfoc8Nv11UPQkzNjraamTEHB0Q0n2DPmVOH3UlAMQuKIK0n0eDEs0OTNFYICWeQfath8VLsS2dFs4MNUiUdclIRk/NkUtsHr7+JJi/E1J9EVonk4roe8UAEWlQtxQYIHmix7+bm92rHy7JBKpVwjw00rmW8KTm420Lozex64NX51lPXAcHnyFEmUVnzx68plXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(71200400001)(55016003)(86362001)(110136005)(316002)(54906003)(66946007)(7696005)(9686003)(82960400001)(8936002)(52536014)(2906002)(19618925003)(33656002)(8676002)(66446008)(64756008)(4326008)(6506007)(91956017)(38070700005)(478600001)(66556008)(66476007)(76116006)(186003)(41300700001)(5660300002)(38100700002)(122000001)(4270600006)(7416002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EhCRvMNASfXTRGusbd95Iz8wEeVBjZE7H4Gw4u6VFJeJaNl4nULK8NqF0nkI?=
 =?us-ascii?Q?0kmgWWgBEN7UAogqwcqIhd7e+ndPNxWRZPEKntX7FLa6wGIG/60vnj7pNdWg?=
 =?us-ascii?Q?Vs8Ybo2erLnIQE+mwtuLOuEs7Xo4s8uK6UY690FEV457KLNua1zNdoH96zit?=
 =?us-ascii?Q?VemnTlP/hJ5vcJBNzZPgmKyh54wfv8z8FOIvPdx9ze+Onu+eiFOfSl5lgtsS?=
 =?us-ascii?Q?dHh1pE+Y6BWkhF4hOt1UluGqRXSgUVRJNMNCG4Djpyra7whhaskULuyvkODk?=
 =?us-ascii?Q?GbUGc7FV+3TjFCwXcDIvwD3PHzK8NnrK0COsoZtUeP0fMei7MMuJx5pzW9sV?=
 =?us-ascii?Q?Mzo0uce8X3kIJZTOS2VAr403lkOq26rIvjGhG1qvhZRaHJ4P6Ymw7MzoXfmm?=
 =?us-ascii?Q?LPZj0iUD11LsCotn7xGT+fYFRaQqCsZubINRHjRDakCb+NAfIOw0aNdmBxm/?=
 =?us-ascii?Q?WMOEw19xt9B/casWBImTo3jXBBP2PlS/+uXY1WcZKo2/vi7SCBWFORtnnl8i?=
 =?us-ascii?Q?sUDqMiGcsS7gEdvFswdbQRScVsINieDdfzmGZnNw/wL23M35XpS/y0TAQL7q?=
 =?us-ascii?Q?bthQrwjFAxI/nAMD5a8Q39FtXQ0cFzrzqG06EkBe5fq5I62aOYIkoImPbTrB?=
 =?us-ascii?Q?AYJwa0TZxCLrqOAEU336M1HDe8GyJN5u8f2Lv98im8z9rmkh6wvdTDS2bqFG?=
 =?us-ascii?Q?6YatYwzySzjNE+59eOeg22CbGjjM/h5IJRyOBP2bzxt8AXFgMoqKWOGvEn4v?=
 =?us-ascii?Q?nZ+P3rh85oSms/rFXmFv3jUO2hRKTGadu/ELSIOL1onjECuN7/gyL94IOPyN?=
 =?us-ascii?Q?IycxrEA5VIu/waveQDqJx9mvzhsYX1jVLIWksLZHJCUnz3k/UcibWjKsY2EV?=
 =?us-ascii?Q?9Q3xo+sxKsyPAx69Y+zewuN2sQSNQHoyY+7/V2/PomcH/M4dbYPCY5TQCzYN?=
 =?us-ascii?Q?DUuAK5U2YbIsBIy4EX5ohVV03jKQ73L3+wC7oj6xBNWE/4NzEV2n/X5GyQHn?=
 =?us-ascii?Q?7rdtwCCAApLBGi3vay5d3Rq2EFWkNsuDuVq0ZXCT2lH9I+DULcRQDVA2VBoN?=
 =?us-ascii?Q?6cv3MB+HdDLo0tPLDSkNxbacowKEJWvh0q9KE9vFN3QS6GiWYJNxdHp901E8?=
 =?us-ascii?Q?d4HoMJ68tcNQnxDPWdrvrPZUGVO76cfWBEd3MwH6bY+Z1CIhSh3FAbnaLivK?=
 =?us-ascii?Q?Cwh3N6OsVwmYFBLkN4xrTs7PHBeYmU46OyuzyN1YzbG+RlzXUpc97B96Izpe?=
 =?us-ascii?Q?dZjNZMaOZncu+19cugLPvhY7qS0axG303UuljLUHal5QnoFLziB3FWUDJlaW?=
 =?us-ascii?Q?ICxZjAO2HCPPfSirk/D/zchbpR7JtnaZCjdKTaaJXANWJzSZQJ4rbgslq9al?=
 =?us-ascii?Q?Un7H5V6qiovZr1CGmwSPL4CQNW/4uJwXO8mxz65ynmNPGQFZO6zp0GBSAJ1F?=
 =?us-ascii?Q?0aCHSC9/AZwascYrYuAtvmpCK8tGp2Yyzstr/wknLfPYu1yr13yZ8aBBpy6K?=
 =?us-ascii?Q?N6FqUG6uxznpr+wsYInHWymXfA4Y+LK8Fmky4uiPkuVujf4i1PL8k9abrj94?=
 =?us-ascii?Q?m+JCK4CiZhSCgUZqjWd6vtP21x/kSmI7FqGC1uNJEGK+y/5vNjFL9PPbSDFS?=
 =?us-ascii?Q?F2a1rm0mpZFJwbfjkHeaETZsSANx1wDOWUuxld4dZwRfVf61bD6qyfGqE161?=
 =?us-ascii?Q?mODoQnzx1gPHYbF8+NqFyXA1scI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea63dcfc-3298-4714-7286-08daa122e47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:27:26.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R38kbF8iSrUUD4HiMA/DqZI5TPc7JjVnOSbbj63dzC+EzGbqDtClx0AOguU7vWu4RGZXcNs/Kn9o6jVoenY1R5UuqzcH/EsVtl64DxhL9YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4487
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
