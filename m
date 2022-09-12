Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87E05B57E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiILKHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiILKHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:07:50 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B721C902;
        Mon, 12 Sep 2022 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662977269; x=1694513269;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=H/4VzayjkB70dEg1qoHLsMIeLuPocxolcjy47Tnu8YtwcKcoH3TeccHm
   BHKe+hYnAowLw0e+W/5t/t4Thjpsp1Tjxv7uO3D+49Fcej7rlariwZ4R2
   cEct47t6iESTyaAMm1GKMykQ60emewH9lzQi/TPngyqliEmmSfwe/6F3Z
   RcZGGHWaPYGQvtfc7tG0AEYtQSGqqO+93A6t5QyYqnFylkMVMit0TqSe9
   ZD9D2eBBQuz4PdBtjCtNroxzYrOCyCx8mDqm9g4mSua9YjLPtduZDStiI
   wczNTna3tWTEYW1dKE8ARDVxpBqpTxB2ULbrvsPcEO/YkKXw2DXwDgov9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="315397346"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 18:07:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdugSHVUM6RSX8GB0MzrgQ8AWJRlkQ3KTXn94wq0pV6eBTgglKw8eyXNmPrWre8hVGr1ZRXE6PyxKERPPiIpZY903fpWGFDNeevPs8T7MdOuAL6Em2NotVcbSXYtdq8BgtbehmAXE4HMbUu2xOdC/ujTjR3XhD6JdaEBw4d0MRKJ+LwIA3XULH3luqtp77fwqiKxmsqPLuAI+Lv2BzTl0eIST4QQL/YZcqdibTLbyoF+DvNN16fcVewfktPvFLj+I4Mkt+R9ABCeCxH/iyOeV310En4fMRFGyj0mmwUTRqqbI65CEqkt2FphX8IS/T6JQcDn3NtZa6XWn2cOJ/mP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jCjJuCZ1CkgtIvs5jVRe2AXsmhg1FPS72RpwJC5z87ake53520aWvs3NlYUxlY48Og7g7LLndQlgwfQ5xWIASi/LswkOM+r2Fu4ynxNPCMaZak81TExRLkmgMPuZR0UbWg9x2eDWHG5NB7wcXknDmxzhRAezbjnBLX6Dm8ak4Bm9PPY/RowPSh875W2oXLE1R5m4mM2dlZO4qa9GBW44WhHEbZqEdpl28V2ZNwbTVithRAL6Upo5ECp+Ue81EhbkliXOyzQIqEi2IY0cXW+IHyiQbm1RNSTWXU/7RkcJH73doFiIV+Sx7dhLk7NMJ6pE41TImFA4vWRkiGt+nvka7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HgtClUfz2CaQB5D4Iass2xkb2RkxusUC9bDspUDiTbch3r+xka7I2Imkllsx6HOonp0tk2hMbm1+W3DNYf3f/aSbZKP3elw/bf8SxG11lwT4okT8DR5Laiij8UpCm/WfMNZPWAku7UMXchB4EyS5ILc2K/aeQumAS+Mc0EwrZPg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4740.namprd04.prod.outlook.com (2603:10b6:208:43::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 10:07:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 10:07:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v13 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Thread-Topic: [PATCH v13 08/13] dm-zoned: ensure only power of 2 zone sizes
 are allowed
Thread-Index: AQHYxoDSwsClPmmx202P29lqx30ycg==
Date:   Mon, 12 Sep 2022 10:07:41 +0000
Message-ID: <PH0PR04MB7416352EFCA15255CE9AF40F9B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082214eucas1p1a5796db60e6972eace43c3ab6976248c@eucas1p1.samsung.com>
 <20220912082204.51189-9-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB4740:EE_
x-ms-office365-filtering-correlation-id: 6203619c-b409-44a7-78a4-08da94a6a10b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJ6irJCaqucBwMmC3RwYrmfmPb9HPsQYZMIF03WaAq28XrBBuWLRL+/MD5T0QZYfbDHTjnajWBHSNvDluwCAu2DmzCE5LhDRyWrIFwQnsEW0ddYQRc+ea7DxIXLoSkTHh4OAH/BrTehnLdb+8E4vCqL+mHYqGVYHI1GDehy2Iq/eSsRKgi405z3gI1l/M1AY9xXxvwCNAlYcxl8Evzeh9cqhfcC0Li0Fxg38EtrT6tuddvulYpy9qGNNmCMb/LKcoxuA+gjSM2acznH9Q/8w79PnPb4oFRcMnDNy1Rkpf1iYs9szvjIlZbypU0lC+/VXOVXFLwOXMrBaqKx2CQ2V1qh8bOJzQxFhHQi5VpArIKaE8RiKWNZv7hjJQRG9mAhl6f3/MrzfJpXcF13BWeDsyKWDVMwZChOde+Gt8qsfAGgK8PR544RVNUdBti97ptDPbtOa/bMCWbz4ViZEItWQ9ojBzjt4fGfjuYM4hvcZ8zdQGZDQyx3tfeAtsNZDoTpscY5Vy2xWoz7QFwm6KXSZvfxBgt/8Px7bjCk6NwXC8YCe4n8fFac98r6H9AD8U6Bks+fXmjgn+58JQ6FVXgwI2zh9llV4Ifn+xImR8UCUhB8UMfyzTA3mPECL3k0Z2pYNGNHWGs6Dueu8q3Uy4L0Gh1xidkUHyZlRpZSa7Pgz9ZBTtUo23oy53PIPWyUnZkFQzvUMxV1v2ihysZnIoNzLjtIVgbQBPBj2lkAovW2fmpjrLB76Pnz7J1q1kFieFJz1fU9COVLJmqke7dR+Bn0tSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(33656002)(5660300002)(186003)(4270600006)(52536014)(2906002)(8936002)(19618925003)(7696005)(6506007)(9686003)(7416002)(41300700001)(54906003)(38070700005)(55016003)(64756008)(122000001)(76116006)(478600001)(91956017)(66446008)(66556008)(4326008)(110136005)(66476007)(66946007)(8676002)(558084003)(86362001)(316002)(82960400001)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XdynJ8jQ3nvxvuFumaNidfj1tCbQ+hYkksjmcct1fOTtUUKmy9uixMGy/w?=
 =?iso-8859-1?Q?1sfM/AlD3kd4GIRfh4HmHqTHlyr3A4K6W5lyVd65tFYgjaUqlukjO4oTgh?=
 =?iso-8859-1?Q?kt4C6OEIRHabbVcsmceqeClAi4fB3lX7+K8eX0udgUJ3ZGK/R1y1PdMGkO?=
 =?iso-8859-1?Q?IKNrCdDXkwTzZhMKeDeB9rWFka0mwf2uKGfV9w9IWZHao0lRo0POL7o3du?=
 =?iso-8859-1?Q?vUhCvXnOXogZTcXdTC529c958z43vFYmZsR4AZlNPdnLWhNt45RaTFNVzS?=
 =?iso-8859-1?Q?f2owJlqdo8qStSU4GBRh3cVAxw30QUPUOih8D17oryFH9cgMWNSiSi/Dqa?=
 =?iso-8859-1?Q?gqDODJ3WoEfl0aUoUFH6r75CfKiitRVpkG7ixX2pSb6i7wvPEqrSuU7Bxa?=
 =?iso-8859-1?Q?ZHJ0ThGfE4k7LSo65tHzzr3+yyV1t7Weqi3PvT48yX82FpbJyabREuQZvm?=
 =?iso-8859-1?Q?FbjSgnTHcVZYYiEFW5OPbEqwm7TE7SEsRnJU1eEXxcckLKsJXbenzBkv1a?=
 =?iso-8859-1?Q?deWhmyXdFoCOaMIdZ8fzYCKm7KrmDWZ4TQXIKfngGGfoBz45+7rA/F/5lU?=
 =?iso-8859-1?Q?KtREOhoof3xDiYvT+TQVD/NX4JCL0jJBBfAaD3xYihiZmvMNucvI8ZzPUr?=
 =?iso-8859-1?Q?B2tpjMf5sqm0x6NjMfInUnIYvRRO82ysG0ATYxq5mKmuimxPMv3yBJIFua?=
 =?iso-8859-1?Q?3zS/+pWpSds1sKq8PD/ZNO8BmfyR/R++3AHYpFtdnAPomRDwRqkILwcsAK?=
 =?iso-8859-1?Q?ms5yT7T8Zr3huD7BzcS2g+NXCnuYxTzo7lbBeph6l170wKOloOmP0vlZJ1?=
 =?iso-8859-1?Q?hr9hV7PKPO1us7XUjpgwRwy5ErJ53SqjcWZB6ZbVmSLC0kMfXWdCc+r6Pk?=
 =?iso-8859-1?Q?GhWckDtJ7vMszdSI+XpyhkTbc7fxuBxTkhdJK1J86hqX65msA+jGgJlcf7?=
 =?iso-8859-1?Q?NDUjNPU5rFCdSspqxB/A/b1PH24UfeZCgbZh891KxhpmXAh44inM4xLNpI?=
 =?iso-8859-1?Q?SUnpjjhxF5A2w5BhB48YO4jR4i2nB8ngjX5r9FkaJEKrQhOpXTpXKTt6rp?=
 =?iso-8859-1?Q?kZOxquwyAKs2eaNZax3VowfoVj2d6ah6wizaiD8VR/i6nXTg7G4VtM5M2b?=
 =?iso-8859-1?Q?/yLefC5H4MYo5sK6MMtP5pNLAakYvqluXoFEI65Foy3in4bS0tahDeopzL?=
 =?iso-8859-1?Q?sLpYak3FqGToQauz+Tn+pD6r5rBeNJLs3olFnw0B33p70B1Es1RQoGG1Wg?=
 =?iso-8859-1?Q?NUdZut5MV9oKbXAZS2DVVz/+mUIbOem8BTYiD+2GMHE0hfHOQXs41x8/b1?=
 =?iso-8859-1?Q?7N/tzcyMxw7Ka5DSSau+SR41Hj3rwuJtJjO2aRUZ6GqoYVQxqcjZCzlqXx?=
 =?iso-8859-1?Q?YfPUGgchdHV/B7UdlxIUCOWLkCqLgAubLPx5ZA9vNGVAOOLqr9/OIvgfzP?=
 =?iso-8859-1?Q?ydWI/reFZZQFoTZWzqsPUlmt4L3wcPYijAcGeRStb7W7zK5yTYMMDkymG7?=
 =?iso-8859-1?Q?ZIkFNKU1dFa6xaEq8WwY1E+/mRuA6MvHF8lqL8tstPiJ2sMUjYL1828dic?=
 =?iso-8859-1?Q?aMtoIuQc8rjYan2LadkY4jFSmU9MDdowJ907aLJ1eH9pCUrAiqr0fSCpga?=
 =?iso-8859-1?Q?AjyBy9t/xy95au3qKeSL46qB46QlOj4LQjs8s+d5rhmBQb3hOkL3K1qIEC?=
 =?iso-8859-1?Q?0LR1RZ0Lid51nPsibccFDFS7zaW3CHdT8l3KDQcVAu3yzZk3Pluz6CkOwB?=
 =?iso-8859-1?Q?kXY97GRmP2u+eIv2lR/R/pRQk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6203619c-b409-44a7-78a4-08da94a6a10b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 10:07:41.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jV0RltIiI0nx3AHazM+0wNaZrM1aYlhqlAuhQbDKLPnL0wvVi0ZPNWyntBCZOrnrsH+y6wV5c/XRWSSrGu28NYvhmnqqwCpz6iXfaO61tKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4740
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
