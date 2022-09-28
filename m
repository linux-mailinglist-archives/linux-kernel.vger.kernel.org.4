Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A505ED265
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiI1BCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiI1BCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:02:19 -0400
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1B1DB57D;
        Tue, 27 Sep 2022 18:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1664326937; x=1695862937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H8hSdr2ouoEV9iLcJGZPwwcLyjIlA3SFEA3jC7RViyE=;
  b=XvKxmJUKYSEL4XbY49RQD6CqBMwIOawG0r7q983+hP3Qjp3JF7urvzzF
   dSGE3degYeOgYDiTW9uOd4sHrABUWw3dnGVOxgM7ey6QfNKA4X7rw1Dnw
   RMFcZM+g6ZKxtf+5BufvROFOf5Ssg8fs8z8Fc4Gi2f98BEyfMIHgXbNyF
   w=;
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:02:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caZ2WSq/mM2c1ELr+REGEOowhtrJnsnhHorzKmaKqtKSPtoHHjOQR30ndFa5MD8EyHCF6rMWNFb8BGpsBCYgEYOmx8liGNsc82065Panlp8b/nfYH9Aedr0tr2D51N+869Hzq2WEkh6dKThiNy6ffYLbbf7ZfY/YmtjVF+TbKzbcMjHmmcQBldsd0wdtcqh+i7NRSZlsOcpH8VwDa908pRO77rf7x/wQzobvCoRkw7ILm1Ppis0emRuI5el42c9FTvteKyclrq0GYNSne9oEUAgCPfkHqa8T2J1k116V2WIPJXjUv5QrZnDsX+HnP0B7ni4WY3E0EScyJ48kvgKJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIqx/dCW5dWe+K56byIp5IZHjyczuE3ZVzcH3ShJGxk=;
 b=fHhVCTtRo7Q0kB3+ebo7BOGFSIHQKsgWATL5jFeHRKYQ8qEq6WsFPIOBo/xKO3pFbz8ofkGuwJXzAqFDLfUvYN17mxvYpFhSN/AsgvoQiXhI0bgCQHwSv8JZFkbMTI21ZQDpUBcFzHkdlpH22jY2kD+dO+ndaeB6PCYdG1EzpDN8EUNGr4HYYMJ47+ngOB3Wovzdk6IzlHjVrkETpzk6nW/Lmt1rLmy1X942Kqwzx/hJ+Mlmr9qEjpazf99pz0YT2u2g045s5oLPn1Ran9trktM7TqCsZXLbaizKT2NIXpR6AQBnaykZb47GSXvJhjE4NvRYvJe+hkr3fAdOQJzhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIqx/dCW5dWe+K56byIp5IZHjyczuE3ZVzcH3ShJGxk=;
 b=JRgTWsEwVIyLmOxOz9ZUsd+V4veUR/Llof6tHl55+uOevgI6d66CRTHmNFJpMlzYz4LvnIAPcgUM66X2RCYNgDzs+/pMjGEEA4/2VjY9ARfzJhqJPEqqXX9yOwyIPtpLI1/Jhvl/ASUTqcZiRNBwB5WCsSa/PpQQBJX0tNZNUNE=
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com (2603:10b6:a03:42c::20)
 by SJ0PR20MB3691.namprd20.prod.outlook.com (2603:10b6:a03:2e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 01:02:13 +0000
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::10cd:3c54:ab82:6a70]) by SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::10cd:3c54:ab82:6a70%8]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 01:02:13 +0000
From:   Rory Chen <rory.c.chen@seagate.com>
To:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Paolo Valente <paolo.valente@linaro.org>
CC:     Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: RE: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHYhxl16wZu53I2nkyhDu//lRykYq2Hfy1sgB6yWuSAAgaVgIAAJ4jqgAzCDACACvKxAIAVNerrgACKJICAAAiMhYAeOIMHgACHANA=
Date:   Wed, 28 Sep 2022 01:02:13 +0000
Message-ID: <SJ0PR20MB44099E58A9EF256E849C8FF4A0549@SJ0PR20MB4409.namprd20.prod.outlook.com>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
 <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <DS7PR20MB4782D8436B69B7EF53749425896D9@DS7PR20MB4782.namprd20.prod.outlook.com>
 <21A4C080-7FFB-4ABF-86C6-E8E05BD83E6C@linaro.org>
 <SJ0PR20MB44098A7A5D1904FD68DFE73BA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <D21B6E4C-F190-4B53-88A7-4650020DB6A5@linaro.org>
 <SJ0PR20MB4409997FB0529DF0B2FA153CA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <DM4PR20MB506103C0D91FD65A0424B663F1559@DM4PR20MB5061.namprd20.prod.outlook.com>
In-Reply-To: <DM4PR20MB506103C0D91FD65A0424B663F1559@DM4PR20MB5061.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=true;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-09-28T01:02:10Z;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate Internal;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ActionId=ab1e5443-7c76-4931-84ac-b52b030fb3ce;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR20MB4409:EE_|SJ0PR20MB3691:EE_
x-ms-office365-filtering-correlation-id: 2db5bb86-a193-4ebe-e469-08daa0ed1423
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqWinZUzvau2lLtPIJL8EOjmwdITKdZ0MNGnvX8CCEWFyXuOqJZG6YPmBR1Yw1BFNJkx/DRIsi9kdlGtVG2e8BqqTztFfmN3W+gIg0U6k5lFfLzYuiasVwL4Zn947bHhFSyAD7CVqn9Zk+VsCvi+PtJKx0C0Df+K8cdecRXcwLhCQK/ipD2FXN9rKn3/iLfnlWx5pDwP2wGcUdz2HDhvZvI8Hi5mhYiMc7C4PvjotpV4JJm38UxayEhacvKZ5GQjdEH7er8TvHqZ9gYcOMH4Ps9lf72bi36WSpqb34upF1RJL6XDNltvPiKHVhJUFrPfQZ6Lcg46O4+ZayEAakrbU5Rd1uaxGmG/DUyP605KIoMULAVy42nSmh8p6xPwKFCYiB/u7BQ8a1MeeWhxXSGNT/YwSQZU5L7f7SFfqC7qlf4HpeVyQJ93ijBxSFbXydVyr+2EoN9tvyGcB4FXuu08r2A/dEfo2ovC8RznYLOtCvwCH73CmXeENiBeG/aRttcQ0FpDRtcrLKhn2epVD91ql2Rx3V+1C9r1HM6IjvIJR7hmVsdgj9aMuTzoTh+wtLLbmWqVi1+NmjD1z4EPUyDD+97b8V07DoJmS98pghzFd2T26+yyJSLXpqb2F1PaJdA7y+pJZtOOjodDHxUYAIoZNhCr7dn3qygP8t0gJZDNWl+X+Hdh9fPOmFHLcABH9L1tT0Sl08to51Zq6PgQVcAytlMr/OKPhxskx9gA01tFFJSMwMISFXL+upwLTF17JdYNnBIN8ZTJLtRgwxDPjRvOlj5SUqg3fc8nvRGCh8EE+nY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR20MB4409.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(83380400001)(4326008)(8676002)(38070700005)(66946007)(64756008)(186003)(66446008)(66556008)(966005)(76116006)(66476007)(5660300002)(71200400001)(122000001)(55016003)(33656002)(30864003)(38100700002)(54906003)(316002)(110136005)(41300700001)(9686003)(26005)(52536014)(8936002)(86362001)(53546011)(6506007)(478600001)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uAd0B8lJnrWZIpcbpaM2DWuZcWwz5Q0FWVVwlVl+O/4cflBFkSAjaCN5KNWM?=
 =?us-ascii?Q?NT022odcHnsrucrKJ0r6w2izTd1DLK87oSPxUw1CHWxCnjy0FYhkqIVzXNCl?=
 =?us-ascii?Q?McDxYAQ3oOpFdJCUfDHOOVJIJCHxLSboCKSN2UWoWhrDXrPcyZjRwCt3yiu4?=
 =?us-ascii?Q?dpCRVDCPAWLHf1neClLCoCDdR0Dj26o97yAhEQElY3/SjbE/fESvMqj3jb+w?=
 =?us-ascii?Q?MZbnCz3CDsCUcEEw9GsNibL3Sg/+O1C4z7bFIuguv+qm7kfLfK4mox0yD/0F?=
 =?us-ascii?Q?dGfETpGb93KJxXUea9bVkqoS4dM8kmRqya7ilYoCWuaNpo0javQDsROe9pwj?=
 =?us-ascii?Q?x25obPfRROcecg0hbWoLkUy8Z/LPHXeK1Ee+lP8X9CN8EoGKiWV+rd3qlSvo?=
 =?us-ascii?Q?kIASXZibmXWtYeapqDPfeuDNSejFQiC8Vqbcakq6gF30TsIgMn5M5h4HtXf5?=
 =?us-ascii?Q?ymV3qSEgMRdq6jff1fERknfaTqbqlHccPOH78pgWYdmtVhDppOziWPBMxJ6W?=
 =?us-ascii?Q?buifCm3P05qQnF0vnsamaWY5CP18p+mVmsCBl2sGG2tIuKVmMZZhE4zeH2qp?=
 =?us-ascii?Q?TCz9gi2OhyndjKG26s/40IbNzD1bBFPpzz9fd7hffaa+WIKW/1JBzqibUY/T?=
 =?us-ascii?Q?3QLdFYKjHn5dYHPzFdT9pjLhyHqi/6Uw2maINEzprednVfqOekxfGmia2gSp?=
 =?us-ascii?Q?+kCjR4wZ8cdBIhV1knfcaVL9lW0ETq1xp1X+Enf7JJ2tdO1llPyj4o7ex7S/?=
 =?us-ascii?Q?E76cFxVhEYzKiAU2pnHlTkcvnn/+q0Ax3Qb3vLUS8qvzvvFvslrlfU/rkbma?=
 =?us-ascii?Q?8HAWTlNxp5QmuMlTa8qq8l9eyq9J5IQPHj5YOtCfmsAp7SozbrteU5BvPA/B?=
 =?us-ascii?Q?TvUrO7OW7Y11Ydgay/FnT+OypimSPFuic524kLZWGRW2tfogBakZ2FIXN8NN?=
 =?us-ascii?Q?EmfTkzH0xZOGuQeMSmQOCx/myEK2gwsZP0BK/CEFXdNRH+r1Aak8+kyt58d/?=
 =?us-ascii?Q?NrvzzHGEQI/WWd8J31MltRl5vzld1SOCX9iNm7TwHcsBT+68IlSAS6oAxEj6?=
 =?us-ascii?Q?LI1bJc46kXRSPJ1R+ZBXeIDsqGWynxNhDIi7V5uSl9AmwTJwJrGG6EGWxD2O?=
 =?us-ascii?Q?SG/IFKT+IEG0J0I1x7gpTBuQk1D/Aj255XQAw0aNkID3rKG4g/5TcEwXgIYo?=
 =?us-ascii?Q?UHYgORcNvZYlmlWjT6qk1Mtk/9x2/JjngmBHDochw4Br0houfgdeosfiGipG?=
 =?us-ascii?Q?ELuwZBTP0B7W3YjWXXQ7cKk+sye7E0ML2PFkUPTxfbbb/KuzjgD6q/DgVtxX?=
 =?us-ascii?Q?13FstDlqaPSaCWfr6dToAmn9TcBedxAphAr5LzT6R6Qo323hPg2/qy+IACmX?=
 =?us-ascii?Q?OAPIaLCwggffHMTal2r2ivs2ncSYMgWiFSoRLnsE+tQ/hH60JXnONL4dS9j4?=
 =?us-ascii?Q?V/kaB5wfz0oVoqBPpuJPo9ct8cTC1qqL/d5oamTuNCEtVENXFoT+ZeKcMA/I?=
 =?us-ascii?Q?keV9gXPvNWEohTWA3r8AOxjdz3VxwwyqYNrTk0H0Y60vOi6F+q8XaezjCTig?=
 =?us-ascii?Q?VATfL5sh3zZq7LLjBuyQtWG2gfhZ0uZrmsFs0bXo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB4409.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db5bb86-a193-4ebe-e469-08daa0ed1423
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 01:02:13.1780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oFwxkwwwJS0ny3BEPUeblpLE39RwhzGoKXW++VLGZcHZSJM19DtemncXuaUyf3RIbjhBxVjSamfCvQ6ham5XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB3691
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arie,

I have no experience to submit the change into kernel. Can Paolo or other m=
aintainers help submit?


Seagate Internal

-----Original Message-----
From: Arie van der Hoeven <arie.vanderhoeven@seagate.com>=20
Sent: Wednesday, September 28, 2022 12:59 AM
To: Rory Chen <rory.c.chen@seagate.com>; Paolo Valente <paolo.valente@linar=
o.org>
Cc: Tyler Erickson <tyler.erickson@seagate.com>; Muhammad Ahmad <muhammad.a=
hmad@seagate.com>; linux-block@vger.kernel.org; linux-kernel@vger.kernel.or=
g; Jan Kara <jack@suse.cz>; andrea.righi@canonical.com; glen.valante@linaro=
.org; axboe@kernel.dk; Michael English <michael.english@seagate.com>; Andre=
w Ring <andrew.ring@seagate.com>; Varun Boddu <varunreddy.boddu@seagate.com=
>; Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives

Chiming in as we have customers who are having very good results with these=
 BFQ patches and are planning to pilot NAS solutions in early 2023. This bu=
g is not a blocker for us, but we do need the BFQ patches included in Linux=
 6.0.

Rory can you submit your changes or is it the maintainer's responsibility?

Regards,  --Arie


From: Rory Chen <mailto:rory.c.chen@seagate.com>
Sent: Thursday, September 8, 2022 4:34 AM
To: Paolo Valente <mailto:paolo.valente@linaro.org>
Cc: Tyler Erickson <mailto:tyler.erickson@seagate.com>; Arie van der Hoeven=
 <mailto:arie.vanderhoeven@seagate.com>; Muhammad Ahmad <mailto:muhammad.ah=
mad@seagate.com>; mailto:linux-block@vger.kernel.org <mailto:linux-block@vg=
er.kernel.org>; mailto:linux-kernel@vger.kernel.org <mailto:linux-kernel@vg=
er.kernel.org>; Jan Kara <mailto:jack@suse.cz>; mailto:andrea.righi@canonic=
al.com <mailto:andrea.righi@canonical.com>; mailto:glen.valante@linaro.org =
<mailto:glen.valante@linaro.org>; mailto:axboe@kernel.dk <mailto:axboe@kern=
el.dk>; Michael English <mailto:michael.english@seagate.com>; Andrew Ring <=
mailto:andrew.ring@seagate.com>; Varun Boddu <mailto:varunreddy.boddu@seaga=
te.com>; Damien Le Moal <mailto:damien.lemoal@wdc.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives


Oops, I attach wrong code change. Here's the right change made by me.

<               if (end >=3D iar->sector + 1 && end < iar->sector + iar->nr=
_sectors + 1)  //Changed code
>               if (end >=3D iar->sector && end < iar->sector +=20
> iar->nr_sectors) // Original code

Unfortunately, the crash is still existing and I can't find any clue from /=
var/log/messages



From: Paolo Valente <mailto:paolo.valente@linaro.org>
Sent: Thursday, September 8, 2022 6:54 PM
To: Rory Chen <mailto:rory.c.chen@seagate.com>
Cc: Tyler Erickson <mailto:tyler.erickson@seagate.com>; Arie van der Hoeven=
 <mailto:arie.vanderhoeven@seagate.com>; Muhammad Ahmad <mailto:muhammad.ah=
mad@seagate.com>; mailto:linux-block@vger.kernel.org <mailto:linux-block@vg=
er.kernel.org>; mailto:linux-kernel@vger.kernel.org <mailto:linux-kernel@vg=
er.kernel.org>; Jan Kara <mailto:jack@suse.cz>; mailto:andrea.righi@canonic=
al.com <mailto:andrea.righi@canonical.com>; mailto:glen.valante@linaro.org =
<mailto:glen.valante@linaro.org>; mailto:axboe@kernel.dk <mailto:axboe@kern=
el.dk>; Michael English <mailto:michael.english@seagate.com>; Andrew Ring <=
mailto:andrew.ring@seagate.com>; Varun Boddu <mailto:varunreddy.boddu@seaga=
te.com>; Damien Le Moal <mailto:damien.lemoal@wdc.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


> Il giorno 8 set 2022, alle ore 04:46, Rory Chen <mailto:rory.c.chen@seaga=
te.com> ha scritto:
>
> I change the comparison condition and it can eliminate the warning.

Yep. The crash you reported also goes away?

> <               if (end >=3D iar->sector + 1 && end < iar->sector + iar->=
nr_sectors + 1)
>>              if (end >=3D iar->sector && end < iar->sector +=20
>> iar->nr_sectors)
>
> I don't know if this change is appropriate

Unfortunately your change conflicts with the standard code, taken from the =
original patches on access ranges [1].  I've CCed Damien, the author of thi=
s patch series.

[1] https://secure-web.cisco.com/12uvPqOwOjHJPiVGM6hJ7791jpWxxy8My3bFD1oA0p=
Nh9m0W778f8IM7HPxjRUL8-94N0gKahHwtK-sEv1Tgk2Oo4H9GTAlLoml_uWF6BGktvDAlDp-zd=
NQUzCL7y1OCz_MJMaNlS5h0iwsE3q9m7tJsCFUWW0YEgcJE6LRTrZDQpFJhG3pGCLFgoPIuKa3o=
8B136dJoQvEtek7ZOQFKqesuZKbu4lvM4ds0HOLs5TIgJR_mSJ8UmhP5_M3a1CaDxdDzQ784H3E=
ydkRN9a6v9-Oogo-wYUqS8fRq35rUyw1t2IblmgJzr6aoGazZsJHxBXPjpxA9DSEQqUtH7oT5RG=
M4qxLpEmYjgyzpJUZqhUCSXye7-lCTIQIB-SGzRuZDVbIqK5tZd3F_YK9LcAN0iVH_qfBM4zRe_=
4w4h5ikJdhc/https%3A%2F%2Flwn.net%2Fml%2Flinux-block%2F20210909023545.11016=
72-2-damien.lemoal%40wdc.com%2F

Thanks,
Paolo

> but  bio_end_sector deducting 1 said by Tyler seems to make sense.
>
> From: Paolo Valente <mailto:paolo.valente@linaro.org>
> Sent: Thursday, August 25, 2022 10:45 PM
> To: Tyler Erickson <mailto:tyler.erickson@seagate.com>
> Cc: Rory Chen <mailto:rory.c.chen@seagate.com>; Arie van der Hoeven=20
> <mailto:arie.vanderhoeven@seagate.com>; Muhammad Ahmad=20
> <mailto:muhammad.ahmad@seagate.com>; mailto:linux-block@vger.kernel.org=20
> <mailto:linux-block@vger.kernel.org>; mailto:linux-kernel@vger.kernel.org=
=20
> <mailto:linux-kernel@vger.kernel.org>; Jan Kara <mailto:jack@suse.cz>;=20
> mailto:andrea.righi@canonical.com <mailto:andrea.righi@canonical.com>;=20
> mailto:glen.valante@linaro.org <mailto:glen.valante@linaro.org>; mailto:a=
xboe@kernel.dk=20
> <mailto:axboe@kernel.dk>; Michael English <mailto:michael.english@seagate=
.com>;=20
> Andrew Ring <mailto:andrew.ring@seagate.com>; Varun Boddu=20
> <mailto:varunreddy.boddu@seagate.com>
> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support=20
> multi-actuator drives
>
>
> This message has originated from an External Source. Please use proper ju=
dgment and caution when opening attachments, clicking links, or responding =
to this email.
>
>
> Hi
>
>> Il giorno 18 ago 2022, alle ore 17:40, Tyler Erickson <mailto:tyler.eric=
kson@seagate.com> ha scritto:
>>
>> The libata layer is reporting correctly after the changes I submitted.
>>
>> The drive reports the actuator ranges as a starting LBA and a count of L=
BAs for the range.
>> If the code reading the reported values simply does startingLBA + range,=
 this is an incorrect ending LBA for that actuator. This is because LBAs ar=
e zero indexed and this simple addition is not taking that into account.
>> The proper way to get the endingLBA is startingLBA + range - 1 to get th=
e last LBA value for where to issue a final IO read/write to account for LB=
A values starting at zero rather than one.
>>
>> Here is an example from the output in SeaChest/openSeaChest:
>> =3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
>>
>> Range#     #Elements            Lowest LBA          # of LBAs
>>  0            1                                               0         =
  17578328064
>>  1            1                         17578328064           1757832806=
4
>>
>> If using the incorrect formula to get the final LBA for actuator 0, you =
would get 17578328064, but this is the starting LBA reported by the drive f=
or actuator 1.
>> So to be consistent for all ranges, the final LBA for a given actuator s=
hould be calculated as starting LBA + range - 1.
>>
>
> Ok
>
>> I had reached out to Seagate's T10 and T13 representatives for clarifica=
tion and verification and this is most likely what is causing the error is =
a missing - 1 somewhere after getting the information reported by the devic=
e. They agreed that the reporting from the drive and the SCSI to ATA transl=
ation is correct.
>>
>> I'm not sure where this is being read and calculated, but it is not an e=
rror in the low-level libata or sd level of the kernel. It may be in bfq, o=
r it may be in some other place after the sd layer.
>
> This apparent mistake is in the macro bio_end_sector (defined in=20
> include/linux/bio.h), which seems to be translated as sector+size.
> Jens, can you shed a light on this point?
>
> Thanks,
> Paolo
>
>> I know there were some additions to read this and report it up the stack=
, but I did not think those were wrong as they seemed to pass the drive rep=
orted information up the stack.
>>
>> Tyler Erickson
>> Seagate Technology
>>
>>
>> Seagate Internal
>>
>> -----Original Message-----
>> From: Rory Chen <mailto:rory.c.chen@seagate.com>
>> Sent: Wednesday, August 10, 2022 6:59 AM
>> To: Paolo Valente <mailto:paolo.valente@linaro.org>
>> Cc: Arie van der Hoeven <mailto:arie.vanderhoeven@seagate.com>; Muhammad=
=20
>> Ahmad <mailto:muhammad.ahmad@seagate.com>; mailto:linux-block@vger.kerne=
l.org;=20
>> mailto:linux-kernel@vger.kernel.org; Jan Kara <mailto:jack@suse.cz>;=20
>> mailto:andrea.righi@canonical.com; mailto:glen.valante@linaro.org; mailt=
o:axboe@kernel.dk;=20
>> Tyler Erickson <mailto:tyler.erickson@seagate.com>; Michael English=20
>> <mailto:michael.english@seagate.com>; Andrew Ring <mailto:andrew.ring@se=
agate.com>;=20
>> Varun Boddu <mailto:varunreddy.boddu@seagate.com>
>> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support=20
>> multi-actuator drives
>>
>> The block trace shows the start sector is 35156656120 and transfer lengt=
h is 8 sectors, which is within the max LBA 35156656127 of drive. And this =
IO is completed successfully from the slice of parsed block trace though re=
porting the warning message.
>> 8,64   7       13     0.039401337 19176  Q  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   7       15     0.039403946 19176  P   N [systemd-udevd]
>> 8,64   7       16     0.039405132 19176  I  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   7       18     0.039411554 19176  D  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   0       40     0.039479055     0  C  RA 35156656120 + 8 [0]
>>
>> It may need to know where calculate "bio_end_sector" value as 3515665612=
8. I have patched libata and sd driver for Dual Actuator.
>>
>>
>>
>> From: Paolo Valente <mailto:paolo.valente@linaro.org>
>> Sent: Wednesday, August 10, 2022 6:22 PM
>> To: Rory Chen <mailto:rory.c.chen@seagate.com>
>> Cc: Arie van der Hoeven <mailto:arie.vanderhoeven@seagate.com>; Muhammad=
=20
>> Ahmad <mailto:muhammad.ahmad@seagate.com>; mailto:linux-block@vger.kerne=
l.org=20
>> <mailto:linux-block@vger.kernel.org>; mailto:linux-kernel@vger.kernel.or=
g=20
>> <mailto:linux-kernel@vger.kernel.org>; Jan Kara <mailto:jack@suse.cz>;=20
>> mailto:andrea.righi@canonical.com <mailto:andrea.righi@canonical.com>;=20
>> mailto:glen.valante@linaro.org <mailto:glen.valante@linaro.org>; mailto:=
axboe@kernel.dk=20
>> <mailto:axboe@kernel.dk>; Tyler Erickson <mailto:tyler.erickson@seagate.=
com>;=20
>> Michael English <mailto:michael.english@seagate.com>; Andrew Ring=20
>> <mailto:andrew.ring@seagate.com>; Varun Boddu <mailto:varunreddy.boddu@s=
eagate.com>
>> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support=20
>> multi-actuator drives
>>
>>
>> This message has originated from an External Source. Please use proper j=
udgment and caution when opening attachments, clicking links, or responding=
 to this email.
>>
>>
>>> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen <mailto:rory.c.chen@sea=
gate.com> ha scritto:
>>>
>>> Resend the mail as plain text because previous mail with rich text=20
>>> makes some mess and forget to add others at Seagate who worked on=20
>>> validating the patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>>>
>>> Hi Paolo,
>>>
>>
>> Hi
>>
>>> I am from Seagate China and face a problem when I'm evaluating the bfq =
patches. Could you please check?
>>> Thanks
>>>
>>> Issue statement
>>> When running performance test on bfq patch, I observed warning message =
"bfq_actuator_index: bio sector out of ranges: end=3D35156656128" and OS hu=
ng suddenly after some hours.
>>> The warning message is reported from function bfq_actuator_index which =
determines IO request is in which index of actuators.  The bio_end_sector i=
s 35156656128 but the max LBA for the drive is 35156656127 so it's beyond t=
he LBA range.
>>
>> Yep, this sanity check fails if the end sector of a new IO does not belo=
ng to any sector range.
>>
>>> I captured the block trace and didn't found request LBA 35156656128 ins=
tead only found max request LBA 35156656127.
>>
>> Maybe in the trace you see only start sectors?  The failed check si perf=
ormed on end sectors instead.
>>
>> At any rate, there seems to be an off-by-one error in the value(s) store=
d in the sector field(s) of the blk_independent_access_range data structure=
.
>>
>> I guess we may need some help/feedback from people competent on this stu=
ff.
>>
>>> I'm not sure if this warning message is related to later OS hung.
>>>
>>
>> Not easy to say.  At any rate, we can try with a development version of =
bfq.  It can help us detect the possible cause of this hang.  But let's see=
 where we get with this sector error first.
>>
>> Thank you for testing this extended version of bfq, Paolo
>>
>>>
>>> Problem environment
>>> Kernel base is 5.18.9
>>> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
>>> Actuator LBA mapping by reading VPD B9 Concurrent positioning ranges=20
>>> VPD page:
>>> LBA range number:0
>>> number of storage elements:1
>>> starting LBA:0x0
>>> number of LBAs:0x417c00000 [17578328064] LBA range number:1 number=20
>>> of storage elements:1 starting LBA:0x417c00000 number of=20
>>> LBAs:0x417c00000 [17578328064]
>>>
>>>
>>>
>>>
>>>
>>> From: Paolo Valente <mailto:paolo.valente@linaro.org>
>>> Sent: Thursday, June 23, 2022 8:53 AM
>>> To: Jens Axboe <mailto:axboe@kernel.dk>
>>> Cc: mailto:linux-block@vger.kernel.org <mailto:linux-block@vger.kernel.=
org>;=20
>>> mailto:linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.or=
g>;=20
>>> mailto:jack@suse.cz <mailto:jack@suse.cz>; mailto:andrea.righi@canonica=
l.com=20
>>> <mailto:andrea.righi@canonical.com>; mailto:glen.valante@linaro.org=20
>>> <mailto:glen.valante@linaro.org>; Arie van der Hoeven=20
>>> <mailto:arie.vanderhoeven@seagate.com>; Paolo Valente=20
>>> <mailto:paolo.valente@linaro.org>
>>> Subject: [PATCH 0/8] block, bfq: extend bfq to support=20
>>> multi-actuator drives
>>>
>>>
>>> This message has originated from an External Source. Please use proper =
judgment and caution when opening attachments, clicking links, or respondin=
g to this email.
>>>
>>>
>>> Hi,
>>> this patch series extends BFQ so as to optimize I/O dispatch to=20
>>> multi-actuator drives. In particular, this extension addresses the=20
>>> following issue. Multi-actuator drives appear as a single device to=20
>>> the I/O subsystem [1].  Yet they address commands to different=20
>>> actuators internally, as a function of Logical Block Addressing=20
>>> (LBAs). A given sector is reachable by only one of the actuators.=20
>>> For example, Seagate's Serial Advanced Technology Attachment (SATA)=20
>>> version contains two actuators and maps the lower half of the SATA=20
>>> LBA space to the lower actuator and the upper half to the upper actuato=
r.
>>>
>>> Evidently, to fully utilize actuators, no actuator must be left idle=20
>>> or underutilized while there is pending I/O for it. To reach this=20
>>> goal, the block layer must somehow control the load of each actuator=20
>>> individually. This series enriches BFQ with such a per-actuator=20
>>> control, as a first step. Then it also adds a simple mechanism for=20
>>> guaranteeing that actuators with pending I/O are never left idle.
>>>
>>> See [1] for a more detailed overview of the problem and of the=20
>>> solutions implemented in this patch series. There you will also find=20
>>> some preliminary performance results.
>>>
>>> Thanks,
>>> Paolo
>>>
>>> [1]
>>> https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpY
>>> eP=20
>>> rA0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08
>>> LR=20
>>> iTVoIOUC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0By
>>> LO=20
>>> NHEoI3p3e9QNIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895g
>>> YB=20
>>> Fn5S2WjBDQq2kzDzZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVRE
>>> EV=20
>>> a1b6bQByX6grF5pn3pTIo0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74W
>>> IK=20
>>> DrNTALs3xQvg03DH4jLez-T2M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%
>>> 2F=20
>>> %2Fwww.linaro.org%2Fblog%2Fbudget-fair-queueing-bfq-linux-io-schedul
>>> er -optimizations-for-multi-actuator-sata-hard-drives%2F
>>>
>>> Davide Zini (3):
>>> block, bfq: split also async bfq_queues on a per-actuator basis=20
>>> block, bfq: inject I/O to underutilized actuators  block, bfq:=20
>>> balance I/O injection among underutilized actuators
>>>
>>> Federico Gavioli (1):
>>> block, bfq: retrieve independent access ranges from request queue
>>>
>>> Paolo Valente (4):
>>> block, bfq: split sync bfq_queues on a per-actuator basis  block,
>>> bfq: forbid stable merging of queues associated with different =20
>>> actuators block, bfq: turn scalar fields into arrays in bfq_io_cq =20
>>> block, bfq:
>>> turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>>>
>>> block/bfq-cgroup.c  |  97 +++++----
>>> block/bfq-iosched.c | 488=20
>>> +++++++++++++++++++++++++++++---------------
>>> block/bfq-iosched.h | 149 ++++++++++----
>>> block/bfq-wf2q.c    |   2 +-
>>> 4 files changed, 493 insertions(+), 243 deletions(-)
>>>
>>> --
>>> 2.20.1
>>>
>>>
>>> Seagate Internal
>>>
>>> Seagate Internal
>>
>> Seagate Internal
>
> Seagate Internal


Seagate Internal

Seagate Internal
