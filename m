Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF23740F87
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjF1LAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:00:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10199 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjF1LAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687950048; x=1719486048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1m/7E0/GB5QC+DA1ZPBPoTQ9dG+4QT2/B2ILpjjpaC4=;
  b=mWQdgPRlwcrYZDT7Q/GuxMLekY1nMQbxX8JwUdqvBaivj5NIRhl7jYR4
   LJvjaiGpzjusJbKba83vi9W5/fLFoBTfykX5yDjzLqDeErSs1RoHpyKxp
   x/0rJkR5pCBLyil188yVK/7sHLwxWBYyhvpS8ftqniU81TMk4O0H4a8BL
   MqAo3ZKuQkmElQ794IL5MzJ8RBCABJoxLWdNp+Q7KiIjn+F2IDI6NqZCD
   v/QK62gY8XlOh+GMrOPd2bZeGLKidZ3Inpv/VhAemWAOA/roV2XNbGlaJ
   FfqlMXSVeuFkw7loSXgJaxbdywRNKsRUTBm1x2cOYQAh2cyDJ6zVblvka
   A==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684771200"; 
   d="scan'208";a="241415263"
Received: from mail-bn1nam02lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 19:00:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFHts7suBM7uheu/UTZybMP/ow1vMaZt+K5wSDWpqhKis6I7c0k3AsPHZajvjTBl/dKao7yAeWTMluS6wT2MApOHFSR851bfa9bfh980as0OzqyVn1EHf1oMd9wQ3tL5DbsfekAyXfgwDZ6Yh0vq4pyYym/iAXExjK3z0Ge3wjwa6CVt5nEWuo1AF4a+ePE0RhFaWmbzVHqzOcF8vb4lGNHIKm1U5KWSuv1ShvTaozuRKeKe6Ta3dF1Nkka93oInHZt647S4q8N1WI2Pol7K/bZFh10uTQGiXxLA15vm9njUTz5ou1eYWIbHi5fZA6z8f6BcG3OfEuUJtBKJl20Fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m/7E0/GB5QC+DA1ZPBPoTQ9dG+4QT2/B2ILpjjpaC4=;
 b=GSUdADwzWeGSKGrHt+l5BmMXZc4bwBeC/GTS7iFaXcIl4UoY+OiRoGA065jLiXCgcj2QMEMcjyvKaU3PsGPHa3K4Tu/oPYYXT9quUf4BZNCXTNKs/auNihQpbU5HRJB6oWvyGWuFvFvcnNe7zpf8r/lwDIsNy99/XTnY6B4EC5x7ls08W2DXUl7cbn2N+op1WuMjnjfaq/NoOpGdNIgPRyeKkzzESffl25II9+J7VOMdoX1hyQN1Xxmrb4CwVR70YS0cVwCRWf/cZw1OcwOf/uUQPtQRAv3YV/AzYpPn7xYK3705v2qblh1xMNRV/yIAm91uoNnPGz8auqcRdqRg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m/7E0/GB5QC+DA1ZPBPoTQ9dG+4QT2/B2ILpjjpaC4=;
 b=dZRmbFGuoxcBK5uRPiYYbVhpy+W7Sj01+3t0+uksL+fPT2M/hAkRFmMKAln8bljRTuJnhnfiNNmkakKW3sMYlb9BukO1vshTdKR0/eTFhRMknoUdAI59fzD9QdPQH0YcQIR3Hy2EA8sJf9w8Jd7oWjOsZXfRIomr3VrZtUcdsNY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6770.namprd04.prod.outlook.com (2603:10b6:a03:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 11:00:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::aa08:75c2:45f7:2d6f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::aa08:75c2:45f7:2d6f%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 11:00:41 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>,
        Tang Huan <tanghuan@vivo.com>
Subject: RE: [PATCH] scsi: ufs: Optimize the WB flush process to save device
 power consumption
Thread-Topic: [PATCH] scsi: ufs: Optimize the WB flush process to save device
 power consumption
Thread-Index: AQHZqY6OHBTqRdMiA0iSFVx8XZy+n6+gCiIA
Date:   Wed, 28 Jun 2023 11:00:40 +0000
Message-ID: <DM6PR04MB65757599481E7CAA98D89CE1FC24A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230628070229.61855-1-luhongfei@vivo.com>
In-Reply-To: <20230628070229.61855-1-luhongfei@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6770:EE_
x-ms-office365-filtering-correlation-id: aafd2cfb-b79b-44c9-bda5-08db77c6e9a6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YVwAmcLf6YjqvGjQRZPHNaeuHn/aDgdvRUcRaSkjFLVUazzvy4n4YAwNlBdE0CTcbZPxvqF4VidrxgfbtIXlj29A/Rykvm1Ak5zborDctQoJtlqXUaBbW/snuaudkqWRFR8XABw9/EIuFWlDLku8Jt3dxYoEl1TnSRJDHQib8Ox14oQPwezwVSanf1wFOve0192f/UF2ey/020mV9TONlkWIG20yZoJVE3nBfzEH/JshBVZzThmCjGd58kPb7blqmuKzRgpldpJU6CrAyfLO8HRAQrTd2jksAhUm849Zqif4ygMbvpfBY8KDvMU1SRehGSywiuwg9MbgH5g9GSZd5aavoPGFqL9jUa7t5L4aO9fH2TyoQF8y5h15/1cTX7aSFgLgDBrOPehy8JAaYPmMu8vvhORKCw19HslIjS6eaE5nR0tME7JWpTkzPpq0euZOiis3us5AXqosYMX5pq1hqmUMz1cJALwObUnKSFsPxlVccB7fbp5ePzkBcboxMWUXyDW3HjOz2y3ax5WoqzeR2yK1GJW8/YVfknqK04O9tf7Alk7Jj9Ma4kpD56CXEa3JUv7+rW/DXsFQ+stKhcxUZWMlfQ3SdOKMWz58e1drUKz+vsQqm5nxabQkvwEW/8AaChWulGWkjuZYvhz02/nIlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6506007)(122000001)(52536014)(33656002)(921005)(66476007)(76116006)(5660300002)(86362001)(7416002)(316002)(64756008)(4326008)(55016003)(66446008)(38070700005)(66556008)(41300700001)(8936002)(38100700002)(66946007)(82960400001)(8676002)(2906002)(4744005)(9686003)(186003)(7696005)(26005)(71200400001)(478600001)(110136005)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lZRu7yE7mT6kAs9LoG5d6C2+vNLhHXSfnR+/U+g5uRUxmdb0KzbFxcfXpFfj?=
 =?us-ascii?Q?Zaa9uiBtcZAPjs6UdYRXYOmnn1KpBGDR3ShsFdaQ6YkkWfLcf3M/7/CLVvD+?=
 =?us-ascii?Q?RrCburU8vRwtR1JShrRdkGnRoR5tTN7/ay6rkI+WzjeenrtTPDmY4EgFzs+F?=
 =?us-ascii?Q?j6cMWokQTAhipfM+UPJYTNH5RCU2vZX8UIZHLR2YOrBqdnBgwyUV6/KwngaO?=
 =?us-ascii?Q?gWvaUUcdbyyALcmvyhQpfMTU/278VaWiJQXmX1MGhMteZqoFodKl1fEN90uN?=
 =?us-ascii?Q?ln8K2cSBppeF794rAF54iYeeAcKKUzdyd0TXu8pXZ/6kFF9vthBdsTK6eQci?=
 =?us-ascii?Q?2/+Tod7WQdrjmx3E0IZe5FK9yRqXmbJ4U+dr/hIaUGKlc43TQ0cq0UBMlTDL?=
 =?us-ascii?Q?lotd5BiBJeOqWmX/fWtb/yYj4N/LZFcwWxfirPSM/9I+VZ6pIVKrv1+O/gwV?=
 =?us-ascii?Q?au9Iiut//SUSZg9lqey+ie7l15IfJ3I7jk2//gWZkm4xV+26g6ckOmHeEdHU?=
 =?us-ascii?Q?1I9s3ONlBDdsDKxSHWHkT5q7EB+Dl7Ltzy0ZcvTcixCKYmdh6KhmzHAQkB4d?=
 =?us-ascii?Q?TPYNnlh4koGeuZOxWercP9sweuW1ZqEIo7ySC5/J6veE8YsCJVKoH4QL3dJ8?=
 =?us-ascii?Q?k0qm2JJY7V5SLNNDtwSCPGQ0ocHapVg7VlktPztZ/0iOIYVhHiC0HfbBXyk6?=
 =?us-ascii?Q?hYY0fvjsLeOGPSm5xSndsu4Md5aGzR7+4wusVBn1TXoJSA1vfRJBSxPs5c3w?=
 =?us-ascii?Q?2bDonjCAVbhlL3n7AWivibG2cxelpxn5LguKB396k2IExyO45xBrKhSH1SYI?=
 =?us-ascii?Q?zkLGTeE2l1SPPClQp6dP5JLKsubOf2J1gSoHN6X/7PwSJeL8ZNm0YTosc1it?=
 =?us-ascii?Q?VcNWZFx6dY/av1b8pchdN8Wz6tCMqxMSDIeQBFUx8MkdKQYof5vimTn5ygHJ?=
 =?us-ascii?Q?Iu51sEV1g0OhglE89ZyljQYqqyjuF7jQQztD8yg4ajeQga1ZvhZuOSwvz3US?=
 =?us-ascii?Q?wL5Z+FOplrdaO+JQHqt3aHrMc95CgA6f0pHzH2j88RVl95KN+gfZXoCnho9G?=
 =?us-ascii?Q?EnTaoBZqS2i5jeiUvhW32fU5UeAe5iBtB8uFZVSCqnRqVIrhrl6nqip4PG3U?=
 =?us-ascii?Q?OyrS2uCUgXJOXdb+dKOcaZbioj9U8WGqVp+dA9Ti+l2wlLK5cP6srWrchqZx?=
 =?us-ascii?Q?vTJcQZ/pGIRsGeGmjuWL4ynxvIDTZOkTRBs0N12xNObhFf36f6QxMnaMVcVE?=
 =?us-ascii?Q?CZJkVZg5chnjB6OtM4/Dm2wgxEbu55ogIaCeHBOMk/g/0QDXeQC4lgmEImZe?=
 =?us-ascii?Q?HujKpLuZNfW9PXocLmk4nAZFGDZrCFFpjRoehf9CbW3UQuYZ19PqnPdW9VRW?=
 =?us-ascii?Q?oQ9zy84a1a6+F06L0ed4/cv5C6b8SztENcY+tYanXZqL/R8qmcFRSDoSA57f?=
 =?us-ascii?Q?lBTQqknRvQcvAzO8T7oqY+qe6ZdU9huIDcGV9GMVMW3uKM8v2yARwvXiJu17?=
 =?us-ascii?Q?2dqLSwsIzxyOgAf8RUNewznQOXztkkGUGQSZYq2VoWPatd3lBdztjwIEzC13?=
 =?us-ascii?Q?JHlUM02tQJkzvgAfuHYNd9AEF985Q5RILQ4+wGMx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9vxrXe0X5KLh/3vdORcAWQMitsXI9OBPcjwc5SLjPALQ0khfXNyuF6tGBMso?=
 =?us-ascii?Q?JEe23VEZQkk/RKh66YwMOR0UqnU2cPVQx1qg+xekKd5kmUAbvvM7ucHItHWK?=
 =?us-ascii?Q?70l7HQ5RQOUFndN+Vw9YZ+msB8/0eivzFh5KXeLobYOGKV6mfGYykE4N3P0N?=
 =?us-ascii?Q?xGfkifXOhoowFG/joohkXMHw+tCSlRZNCRrMn1HSOyuMbrk8n5AuMcu+jNVj?=
 =?us-ascii?Q?t5y3QaGwvU+VuQVeomqqcFPQvNsyswdtNxtsRlXsOByXhB3toj7q9SAIGthu?=
 =?us-ascii?Q?P7UPBNgtOlnZjfyrMJGftAn2atSU2Z8735alnMZOLR62uxmdmEd6wNrVWi6X?=
 =?us-ascii?Q?j7alNgKoIbuZAgPslOGePdbB76RyuLPr8MdLbWVoXINkSP9buOwiWQDWm1qu?=
 =?us-ascii?Q?DRi963EBKoIGSSPsR8G1JbTqlPz7cyRso7Uikb4B1Ak4ZfD5DFjVwbYGWpAP?=
 =?us-ascii?Q?50Ec+KTYbkucez+g0yTz/2ty5c6F4bVj1SXQd8Op5hbCZFkDWRCp9rQjqmqE?=
 =?us-ascii?Q?yV62PUOCRl/YaPTr5hyVAv2pmqmpzlOS9YXMPsH9kzc8O/+0ZcgusmPuOCTC?=
 =?us-ascii?Q?tm4ooMjMG7GmYhY5nkRb8SV6pS17/RrPM19d5LwIJ0uNUb6ImMM8QvkT9sft?=
 =?us-ascii?Q?RoejoiYpnWP0Tqv0MR6xwt6f/2QxCu48Xwf2upB2h4ILE+6Jd9nAfOQHPMIa?=
 =?us-ascii?Q?mRZOhGjA1QctYjvzzmHnLPvE2bSdrB/Ys+UPzofP23MZXZHSItxKjPpexUt9?=
 =?us-ascii?Q?R7lmc7itd9CB010vLSRFwMLKzeNfzddR+INSmh/WYlUF98QEzUmI1SJWBNEP?=
 =?us-ascii?Q?yvmHhepOeNuRaMgbMx1BfoqodUq7cOw3iy0SP1lyPufjfFc4VZL0Bkz4KOK0?=
 =?us-ascii?Q?EVgdLrchhHe9KFZr3An02mRjmhf6ahVQs+pSJ+vceUht1QBj81LW0tkouM+f?=
 =?us-ascii?Q?EVwmyo5lXw8Lzb8D2VF2D665hNHOYHWRCiDuaxGFIUSYRco3/+ExnOFPTbk5?=
 =?us-ascii?Q?G8WzzyFIUuj0IKi6O31I9/m7Ww=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafd2cfb-b79b-44c9-bda5-08db77c6e9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 11:00:40.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WD8/o1sjGY64ROQJkw/soasczoFDOq1nTwQ3xLC8zRfSsLhSJ6sR5pPJtPYrwbavBtNzl4Ve+hB6XJSKW1qmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6770
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> In the original logic, WB Hibern Flush was always on.
> During suspend flow, the host will determine whether the device needs
> BKOP or WB flush, and if so, it will keep VCC supply.
> WB flush is only a part of BKOP, and device that needs BKOP do not
> necessarily need WB flush if the conditions are not met. Therefore,
> if WB flush is not needed, it will be better to disable WB Hibern
> Flush,.....=20
I beg to differ on this conclusion.
If you expect SLC write performance, without fluctuations,
the host should let the device manage its wb buffer on its own.
This is exactly what flush on hibernate does and better leave it be.

Thanks,
Avri
