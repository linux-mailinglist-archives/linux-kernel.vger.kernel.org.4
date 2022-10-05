Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99005F5C71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJEWMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJEWMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:12:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2E8286C;
        Wed,  5 Oct 2022 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665007924; x=1696543924;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iqbkauKjmQifKVKFNI0aEYhlhw9OZRDoXLYTk3E0aJ4=;
  b=A/hrn0UZExlsb8Zrgt5nNys9Oh1x8TQaRbyZZrqbG61X4C5PpVX5l+9l
   Xa0n10aEXQGEvRXRNtfNwlO232LnFzF8FDpgZ+1VjEjGwIbMQT44daJU3
   S+fIGrvzbTug/X6XE7iKp2quW0q/b+28VWzlxTmqz4RGKbQPXgHL7aMoK
   Kw+VdDqiQkZLQQAjp7cpQ6bYXOM8DBuc1zmhPxp7YkBSEy8p+C73W6Dqb
   pFpEX2YMYM1gSfle4Q0ghnX31WsgubyizslV3I4D3ET3vCyoKPjtVkg60
   GifmG/APpTpddbVw8Lhs16NTDFDwa80RrBINpfdrCWqwu1SbrytOiHL6C
   g==;
X-IronPort-AV: E=Sophos;i="5.95,162,1661788800"; 
   d="scan'208";a="317373000"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2022 06:12:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+0Nc4/7Mo9ZpceKgbhpwhD1Y7X3/hcfswBerwT81VM2KSkCI18hwZgnUtNTH+5tTMKMtqFtvF8bg7aIu6uuTo0d8ixMgjus3iXhmCSxG3RIBqd3sBDMoEI+WGot98BOUzXs9qC2s0faMfnV2YtU6sjlLpWB4tKa0PWXLX163LKM0EBoJydu1KlKHJoX8duYjhboOsuEhC3gUlQahZGkxAdbFmWhXItndjqH4FgfauAAH6WgssmyiHuCEUzRbMeBkhKlqWJnGNMqrWUnJO0aMJyoBq10ksjOu1q+hK52CF0y++VQ3vX+egnZrna0566tbXv7CYtQwyofZdwAEm8mDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT3QfW1xKB/QjgaL6871r3Hw3E3a/+uYR+oZpKtjpec=;
 b=YpjPqOCVkZyMU+8oCXFTgUWee11VUcoW1ZFlSh31ZTqHBBegfVcL7sWXXCyVUWAJvRGPScjiKXbPMH1m10Iv02RlioX9ZuAJqEn2G2vLtGhBR8/aDqH2udkPmnlVOr8fZfjOTjUaGZzpK4uVeKezbVWFQCmoC8IG08V6pMAssvLRBSGokaYDWrHkby1NFVVyrwAfI+WbY/+4plEnJjm1eT8duQozuo+B3yPLV/W/IgMOeaLy/oO3fzXzGhKszSlI4Dv/0bOSTpbpr0+Yve4eOfcQHBnEBblCd5SoriF5NAbSMWuCEWsyhON1sPiX/vXPCq+S8CntL9TtH1nb5GL6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT3QfW1xKB/QjgaL6871r3Hw3E3a/+uYR+oZpKtjpec=;
 b=D84WqdEHuKxGCc9kUkuqMtMsoCl7XoZLXJark9FAT9Mk/hsN9jUUpmmEUAXTIWAvtNx7UuBPFcCuMb7QjVCZHwBrxU8KD4uTbsbBsJ7U2R6+uzyTld17TBrGBFby0Ct7RZCrWT5rnsB2A40GAqXLqiDC/mJuwOYyUW9/qF7W8Xk=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM5PR04MB1146.namprd04.prod.outlook.com (2603:10b6:3:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 22:11:59 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::966:8440:b721:5425%6]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 22:11:59 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     John Garry <john.garry@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        yangxingui <yangxingui@huawei.com>,
        yanaijie <yanaijie@huawei.com>
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Topic: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Index: AQHY1/ID0O3xyFitDU+9c+6EHqQqRa3+RKaAgAE7cQCAANLyAIAAAgSAgAAKBoA=
Date:   Wed, 5 Oct 2022 22:11:59 +0000
Message-ID: <Yz4BLTPkXqyjW4a4@x1-carbon>
References: <1664262298-239952-1-git-send-email-john.garry@huawei.com>
 <YzwvpUUftX6Ziurt@x1-carbon>
 <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
 <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
In-Reply-To: <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM5PR04MB1146:EE_
x-ms-office365-filtering-correlation-id: 522bd0ee-5360-4609-7881-08daa71e9f77
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U99EFOOGW6N6LbbmIAv0sIctJtv4ZH6NABR6nEEbW2cGMOMFU+z2+G1gHVp3Vayq6PQWrUv+UsbZrqOX5trEXMegRjGX8pdiyoD0SqLg1jIkkXrCvg/OxRwpvWPGwDeW98iPUzAK9o060NR4MLpdSlma0JWHoqWn6TJE7XjYSmnBCn0KzrV0OQiL9zZd9LVuApbnK1s8b2lh1iGDVCTNzdnMUSipoNUzLzZog0Tg19o3pE6rNrfNepwIpS7JmbIygXDDCgKHffmfU2b7Ob9wNCv0GrX/u/9nPu2zmdmM42BTGmeuOauDCXIUSpRl9aIS7k8IrxJATtXmm3IBKSNI7z5UnDTns+hnwXgqnzKCA1jhBoDnm1PRZkg/9zdOSuz2CPGRFzd4rCjE1XOXxxp/+jZlQnhs+rEW0UPU0ga/Bb7W9w5sBVyCw/3UJKZWOJoZWiNi8ACvx+gGF3K7vqbB+340xk3fkqqaBmUqFAAE9EPQ0Dxi7AVJW4mACkG4DcC9fHCyPBKXmR4/XF7iJ0IpRAyqY0emXzDAHIIRyxNKYoxs9Dq2KkxWS8AE5CymzajIksnfw1bfxd0MB5JZpY3WWATWKZ2eIBN9ZbuyWzkGCWV4wnKIgr94bNZs6N3mzl1EqY8ARlL7i6IP+sDbfOB5/K1UfzQSWlpzjz37oi98BLyT1y+05twrWKNxgjvMnlBJJcBFMFpxQj++MSHYq9KXIAOMnQEurtzAA01WK+vl8Wx6F8W1nszW0kv0xsLQbUZv8d1l5hS7rb3j7WDKOV02188HMaLeDBxLR1y4jyArzgc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(8676002)(316002)(54906003)(26005)(6506007)(53546011)(966005)(9686003)(6512007)(71200400001)(478600001)(6486002)(86362001)(33716001)(8936002)(41300700001)(66476007)(66556008)(64756008)(6862004)(4326008)(91956017)(66946007)(66446008)(76116006)(2906002)(5660300002)(82960400001)(38100700002)(122000001)(38070700005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fhktV39ZQHoJ/aQt2cVLdUL/ArpqGDaFndgsBSDJW2I14btADRGy4sbDBawo?=
 =?us-ascii?Q?q+CZa4OCKyoPGA1v/cFmn4ztylyL6syxSdeLZ5b2peg+CHxSjs+ZQtBahRhl?=
 =?us-ascii?Q?EzjrOmeVQyKfMZo1hlC1RrShvgJigtmf5e1jhYYgzmspZMZ59LlJv8HVUM+3?=
 =?us-ascii?Q?FtUNPusmhwyXmDdNVfYQu/LULjv4XesmSqiRpBhbExivbdkBJxSu4qtC4vnR?=
 =?us-ascii?Q?dBYpJNQX84y+4sevsmVdVpnLBS644DtXRGN/cF6+MxARQ5vKcv6LtQ9gVDsm?=
 =?us-ascii?Q?ZxRK8YhIK6Z9AyFlAxO2lUZOg2BqdWxi4OOw1u7EsdyXJY1/24BSIMieEnAO?=
 =?us-ascii?Q?GKT1wvHmZihLA45k31an12PwokjRfcSkSFRsbuF1ZDj1YPjp+rQpxE3EIAMP?=
 =?us-ascii?Q?DwpSqQvMa+sTnhosZgP22aPM/OdvqBTc1tyMaHQrG8KX7I9G7E/OHKyD6zbe?=
 =?us-ascii?Q?AQFSMAkUCgtqGHRQg1sdaTak45V9IB9QAZg6atRCHn8+6eop7V3Ggg/HQAid?=
 =?us-ascii?Q?+ceHHWppCHotBtp0MQO9hnJc2gmNysuQCj4hKOJiWOqo4ZGZ4dkOUq37nzVC?=
 =?us-ascii?Q?cgkiaSwqfkq+99iJKIs/evz1KlA6BDc4ylUKE6mJGSeFdHNla/mETSFvLyI3?=
 =?us-ascii?Q?VGOKtkIFSShFXZIDqw3dEjxEgaCs+faWRc4IAuxFDnDKrI2vpAyYQdrp/Al4?=
 =?us-ascii?Q?Jpv+BLzSnzCcZpMvI+J+GWOqFkWfAJsZb6DzCpuoo8D2I6MP5pzgAAn3LmgT?=
 =?us-ascii?Q?zzUUMvesLuEggV6ZNNvTei2QKocq9L8Fw3IGxJldp4ix0na+MCSWBc+jdOSS?=
 =?us-ascii?Q?fEYfszXBfhe7lHgy6daXYs2/5KnhJAtC0EPJR+gbdAr1Na1ql7cXHnqXaW9X?=
 =?us-ascii?Q?JkizSwO2pSAB2PfPoNlMA/i0Z3Lk2ql4/02Dg/Jc+QbsTt71QXzGSr7sqvp7?=
 =?us-ascii?Q?8bsEOhkWUO5Bx+221Hi7hjU7jcaDGA1njtq3ehhVMU0OV8BXHuS2ve20ki5+?=
 =?us-ascii?Q?FhcWKZHkn6/cEwU89wTHnWwnFR5LWhjaCE22jbmTVUcegvNK0V6xNI6i4DY4?=
 =?us-ascii?Q?c3EJNB1Qe7oikeXQNY82yUxfMei+baX22gRKH4iujjxOfpP776T2qjxRBjyX?=
 =?us-ascii?Q?YC3FWScEtLIrzONquwA1Rhwi3Wp31qL3hslr7EX/RJmNpXs78tatCLtEAFNC?=
 =?us-ascii?Q?wG6R8F4bHRHJxbfumqnjMT+uSaXkkqc8IdRdx0H3ovHqosMO1wUZpKiuaJV+?=
 =?us-ascii?Q?9LP6C9hLHRtAkTF87VDfwTvkp7bNtxd6hQ+d8KBgaE/Nl2hPbTCYpxziX7Gv?=
 =?us-ascii?Q?L6yoYIEgvOZZoKg8wVbYIzkUsgyM3WPfv8gTAQXFnrlG9VadGjFwSRauNG1f?=
 =?us-ascii?Q?Gi9wcHaRtElkiC+SF57cbkRQpEj/wTROrGvRao6h688w8ON27t+sQzHFZV+i?=
 =?us-ascii?Q?W7zb2MzG1S1QkLM7rAcEhDz5YXq+Z8nDUVJXDHHI0zDLoRzJQAHUTbFSfdQT?=
 =?us-ascii?Q?5k5qDzt8+E6LlItQe4PsftlsXtLmkBqMn4uR7e36//46ml+lqeUQ9+Oun9Lg?=
 =?us-ascii?Q?ioQOlBP1fqOs44w6MZd1BYndK/GxBN8ZAE4XZYl7Waq0jq34Z10sAGgEMVwP?=
 =?us-ascii?Q?3w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E4CA75C85B2A14889B3E3F4B623C6C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K1MwXwhE8r47N8dml10qhj48EVnz3MmTZQQYjjDzhLYoOCtRvLceR74GAtPD?=
 =?us-ascii?Q?29iI+xS+bZMS99HK8dAGlw6kg3ppMAYqDF9VoNLyGOCfbj9Lje66kM3ZVMNo?=
 =?us-ascii?Q?3Dwca8C0Z/VRKsRpVL+LbsHj/j48/0D1bobdpPn2UB6Bt6Xs5YefeP5mc2Ku?=
 =?us-ascii?Q?SaD+dfFdhU9Wa7MO23+9HYd12kKO8IgHToT9XOCjR/vTJ6ECsnrNQ6Nz1rXq?=
 =?us-ascii?Q?/8T5UcFpINbjf2cQ9Uop82AYzBnUordSkHDGEFhNRGWH0YYt5nfQzPfxEaUK?=
 =?us-ascii?Q?GWxdX9EbvE/7KuBVFkLV/hHbCvYzeLwRYGD6GaKVuM3pfP69hog4R6MQgkJL?=
 =?us-ascii?Q?3OzfI35Eu6PQaXstzDJWke+e1PdQt7oS8TUxXht00XG7XVxQhKO+r/0sWb7E?=
 =?us-ascii?Q?zgjWUdeyHDf/ihKeukuqJKZ11mKWhg1uFoGPl4eXTKLQBQQN1BR5T5n6mLVS?=
 =?us-ascii?Q?/xM+9JBLbxK2sm29e0PxzsBjtSwESjki80uKRNCjBWhOjj7Sfh1vl4X0+gAY?=
 =?us-ascii?Q?wyzi0BGVsy+cXL9rLmCBFNLhwakPQJK9xEjIA8pyb5ZC0Jn+p9/5VlXNXmOt?=
 =?us-ascii?Q?pGG9LzNU+uRzNmaUfOyUyB//JfAvcLYVxZa9FG7mA9mAYEKUShVjJ++vKTNV?=
 =?us-ascii?Q?G4XwYLEGfo/7J7GvRHsFh1B4ASXjnO4KONBJzqlg/oyn6QvkKegN8k+w3tXk?=
 =?us-ascii?Q?P5Ou1DfNBqMOdjxGmHgkb2xasSJGqjY3d+uNTZv1WrY/cnYYADIIVsV75kmP?=
 =?us-ascii?Q?fZi4Q9F4/tjKJr2pYf9r6O+Ir4h64Zb4EcaOSds2xdZT6xaFSKIkRwVltkD2?=
 =?us-ascii?Q?i6H5b3xI6S+KiDrmssI8IyglPgeHpvgyDgjcyjbETMs0J4Jz0QWUQhkZ/AUJ?=
 =?us-ascii?Q?AOGuFForVqaPviWIBeufKmVBZxj9PbQJbo3BrN1La8aUCH6Vi5QH2HtVVAd1?=
 =?us-ascii?Q?+CAC8jFXZNhNMChXiK0rVFexyFquSiuIr5xoh/t2MReYx5odTZVFf//ezWEC?=
 =?us-ascii?Q?ciieaAMB3ue4fCLsH7Lbv5yZLx7+SEX+RCg9FrG15JrY50s=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522bd0ee-5360-4609-7881-08daa71e9f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 22:11:59.2142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8CByTnWZaK4raBrH3UeFoprx1pT1Lm3lGiUetinF24+3BzlKodkuqs5nR+Sl03UnMrQwnvAzKgblOiorKMmCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1146
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 06:36:05AM +0900, Damien Le Moal wrote:
> On 10/6/22 06:28, Niklas Cassel wrote:
> > On Wed, Oct 05, 2022 at 09:53:52AM +0100, John Garry wrote:
> >> On 04/10/2022 15:04, John Garry wrote:
> >>
> >> Hi Niklas,
> >>
> >> Could you try a change like this on top:
> >>
> >> void sas_ata_device_link_abort(struct domain_device *device, bool
> >> force_reset)
> >> {
> >> 	struct ata_port *ap =3D device->sata_dev.ap;
> >> 	struct ata_link *link =3D &ap->link;
> >>
> >> +	device->sata_dev.fis[2] =3D ATA_ERR | ATA_DRDY;
> >> +	device->sata_dev.fis[3] =3D 0x04;
> >>
> >> 	link->eh_info.err_mask |=3D AC_ERR_DEV;
> >> 	if (force_reset)
> >> 		link->eh_info.action |=3D ATA_EH_RESET;
> >> 	ata_link_abort(link);
> >> }
> >> EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
> >>
> >> I tried it myself and it looked to work ok, except I have a problem wi=
th my
> >> arm64 system in that the read log ext times-out and all TF show "devic=
e
> >> error", like:
> >=20
> > Do you know why it fails to read the log?
> > Can you read the NCQ Command Error log using ATA16 passthrough commands=
?
> >=20
> > sudo sg_sat_read_gplog -d --log=3D0x10 /dev/sdc
> >=20
> > The first byte is the last NCQ tag (in hex) that failed.
>=20
> libata issues read log as a non-ncq command under EH. So the NCQ error lo=
g
> will not help.

Hello Damien,

John explained that he got a timeout from EH when reading the log:
[  350.281581] ata1: failed to read log page 10h (errno=3D-5)
[  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 action=
 0x6 frozen

ata_eh_read_log_10h() uses ata_read_log_page(), which will first try to rea=
d
the log using READ LOG DMA EXT. If that fails, it will retry using READ LOG=
 EXT.

Therefore, to see if this is a driver specific bug, I suggested to try to r=
ead
the NCQ Command Error log using ATA16 passthrough commands:

$ sudo sg_sat_read_gplog -d --log=3D0x10 /dev/sdc
will read the log using READ LOG DMA EXT.

$ sudo sg_sat_read_gplog --log=3D0x10 /dev/sdc
will read the log using READ LOG EXT.

Neither of these two suggested commands are NCQ commands.
(Neither command is encapsulated in a RECEIVE FPDMA QUEUED,
so I'm not sure what you mean.)


Garry, I now see that:
[  350.577181] ata1.00: exception Emask 0x1 SAct 0xffffffff SErr 0x0 action=
 0x6 frozen
Your port is frozen.

ata_read_log_page() calls ata_exec_internal() which calls ata_exec_internal=
_sg(),
which will simply return an error without sending down the command to the d=
rive,
if the port is frozen.

Not sure why your port is frozen, mine is obviously not.

ata_do_link_abort() calls ata_eh_set_pending() without activating fast drai=
n:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/ata/libata-eh.c?h=3Dv6.0#n989

So I'm not sure why your port is frozen.
(The fast drain timer does freeze the port, but it shouldn't be enabled.)
It might be worthwhile to see who freezes the port in your case.


Kind regards,
Niklas=
