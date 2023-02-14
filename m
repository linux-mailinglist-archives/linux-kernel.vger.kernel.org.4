Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1FE695929
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjBNG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjBNG0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:26:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A61C5A7;
        Mon, 13 Feb 2023 22:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676355957; x=1707891957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cILuK8VgdrTlbbCN0Lhp3fk2GNVXKZSH35d9F/NdDeM=;
  b=LXVgKGplGn5utLyV7KwEBeW2CtwM6lcKtMSQyl0dYLGGKNwXQauj/2r6
   CzvcfTWEpcgyi6+ZwpQfxhofhMoFAcTgBN6vj75FrhhGJ7u+xZ5jGtTRx
   0SzMD4UZGe1fzSuO3YfH2YfrCDueWaCfw7R7iaoHaGAoMmJf+iQk1wJw9
   /PGtHpPfIr1m1gmjYq5cbKowC7QeRtc7/TshwGAkphvfK6FmSJk76o328
   9hqvgTmHgVoTK1bIRHQTdqvrWVDJy7uGUcF6dm+ubiPj4YsbPDsfDlNJa
   JFBtNreRagDN65d4od5BP6SaytgiJ03LfxElF5CbAjA+23j6cTN5nUN29
   w==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669100400"; 
   d="scan'208";a="200379148"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Feb 2023 23:25:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 23:25:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 23:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftnVj5fMQ93eA+lOXcpRgfm03a11TgDwCdR4ssf81VoV2saSB6kARqAJ0+jlD0iztR3/LFZogQ2azI+wt8TffQ2eCps6Qo8AozLkeKDuFZ592J1VbezzadMY6AbW+zz8wtW1o7tzNfQVAv1kr1RO70kvecdcIP1oJFCg3HNPEoSUsBjZaUF9h3yBsDn5GQWqsRW3pbcCYLt4tWxJHKYliaex8SBz2JTxKHZLn8Lse/IyXFrDOB3dr5VlpmkRmQvki7XsTgxRfR4/pY9aEkejHG4fo7EdlBVRe13ibqbdoA9DGgE99eFNWLhV2MAPGryfLcoOEszlpCQfHCA/wmyM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cILuK8VgdrTlbbCN0Lhp3fk2GNVXKZSH35d9F/NdDeM=;
 b=LEVHPz9okLfDimZav2MzNYqZIof3K9DhqQtNiu0PlL4+rC9ELli0f+GvHgmMhSXqAJHTiWbkcOEXfxrO7Bcwm16XvG53QAE/TBdjA2j0csi6QzmCZY5KCtCB2EH5MnOxteFHkxf1hiN6ZdxkSHPRQMixBl01JGokVHdGZce0XL6qLtuFCqBm2EBbTGNnIZJYVPUonz6Hm2jXbaGprqdVQZGll870FrmyJyXe6FBhn2+RQI1f4nglJ14niXEEG2p279XqbQu4CwX5QmHVoAiT7wylwM3+Hdpz4Nn453oDbeKBwpKbEBnycHMWQFnRFgMJohhhiXh3gyDgSf4RoHSHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cILuK8VgdrTlbbCN0Lhp3fk2GNVXKZSH35d9F/NdDeM=;
 b=IHOJXoixCzTeL43uKe7//KW57DaHLLsZKMUJ++wM120YNb6oc9McdCvCeTWwI9sNRVehNbS7j7gtzN4ONZ64x90MPY6YTdXwBQpEQIiGaSiaGEI6ooGdVntwvrMOjmHatshMeFsdWL8YkadXOEV+dUme1odLWHJmMu7TZuiHfFY=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 06:25:54 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:25:54 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <michael@walle.cc>
CC:     <gregkh@linuxfoundation.org>, <UNGLinuxDriver@microchip.com>,
        <arnd@arndb.de>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5D8pOvjRSE0idcTrTWegJHq7K5KqAgAHjmYCAATSsUA==
Date:   Tue, 14 Feb 2023 06:25:53 +0000
Message-ID: <PH7PR11MB5958785F61CE3CA6C25C312E9BA29@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <Y+iQnfR65M0El34R@kroah.com>
 <20230213120009.2661528-1-michael@walle.cc>
In-Reply-To: <20230213120009.2661528-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|PH0PR11MB5112:EE_
x-ms-office365-filtering-correlation-id: b62a9981-1521-4229-2385-08db0e54533f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRQAn4sef8fCbi83DhbXBGpYYDqISAHO5ZdnvVGBVQmxWa0Caj1J2bLo9KG7CPBy2mzGfJZ0MBs2QyRDVYYtfg2B4BSg7fl7WmIcmrgq7nrLxqfS2DlkNN9+xVVvjSQsyChzvRtR/4+bCLaS8xU/SsQiG5hSX2IvchESFR7qdn1Uwf0052r1392eqDvGIPjNxhyYo6SHw/dKTsnshLQlRqAw9AqUt5XEG+PS5hqmchFAis8FoHUVP+iu4/BNmpZcwGDqjtFLctRM2NwUNnyVlTGuHfpcN9BMH9HO5xuazQvJpK0nn+M/VOPCYjivtiZNkykWeCUBi1BlmVmM0SLkh/3ZBe9fTdufNB8xQbk/udGepUQh5aw6dJcNGas96+gXvt6HID2YF0Y9ByAYAJAyxNSLV+0v1W6MPxLbUb/wLO/LG5Zxm+lgmSF86h3Qzk2xZqAcKamLGeEsLVpw9otTkR6R3QHHrCldmdSr5+o3B+F+wcmqJiH5mBHE8hBcIXhe7MLq+VAo7Du6+2/x6Dg+VqfLM1K9hK2XxnFq53iRQQAGdBWhgws/Qy15nTM7T5CksnY46AvX1aywA9LFXFqIKlVxzxeV78G9mrwRnt4axWvK4A1aiTZq6nXn4NqNakQYH/uxtYNSNRIO+5DZiPDyUGjJgkh8LOh8XV61bzZ8saGlQ62bzHWUlQPlkse1bRaS6EpCFO+kRlj2igizbkPYc5ndmPwRIUslirm4j6GDtgg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(478600001)(316002)(38070700005)(86362001)(33656002)(54906003)(9686003)(2906002)(66556008)(66476007)(4744005)(8676002)(4326008)(6916009)(66446008)(5660300002)(64756008)(66946007)(41300700001)(53546011)(26005)(186003)(6506007)(55016003)(71200400001)(7696005)(38100700002)(8936002)(52536014)(76116006)(122000001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yK+fqQO+D5+qj/tmOQp5L+l1g1xAT89+lI4B3yI7OIzwSLXlvy/hrZ82m2RC?=
 =?us-ascii?Q?uiYEl4KyVAaLFl2DQZsaaNUhMwEt6YwqYckDjjttNhSn13Ug9qC99zHFDqVE?=
 =?us-ascii?Q?x1thOpdmIAscMxXeq5Xd9mO17+oMPke+D3JsY5QMnyTeEgP/2Zz7fuKnHTFs?=
 =?us-ascii?Q?zwjZ2PV5dSHqsdrCl1bDwM4vLdQi1XrAX0bXbNjA6H7cQjDMyMi7FHliRiIM?=
 =?us-ascii?Q?HDbCZt6Nxgz1UjbIx8NdA+Vbyu/BgZ4gmzTx6g/R3CEaH3jShn0pUuHFwk0S?=
 =?us-ascii?Q?LtrS/KzEDpDCMt2Ez6QbVK4iqdfejTQKbxQxEPzdlJ5Snjz5Xc3gFbOEkq46?=
 =?us-ascii?Q?Oh8TgAniG95xKb4haPIU/qU3w8fAkNqCkl5MdR1cMHZnHS7nm8kCHvObVuYu?=
 =?us-ascii?Q?xCyQB2xbS7zfFPtiN1YCh1JOABzoa8zuYNIObPSUkgWv+KPIoO2W24q8a6Eb?=
 =?us-ascii?Q?tKNfjEb5HIUN/A43qjcpfxC/wyi+S9OnAGwAw5zUzWNeW0f1orR7gzFz2a92?=
 =?us-ascii?Q?RDNRB9S9aSB83wcB4SZL0KdOEGvxCSwta7SsEDT9uFw3HyFnKptdEZhTQ5CI?=
 =?us-ascii?Q?fp+FJPD+s9PMKdKd/lPqXEtynt5aduumTTapUKf5rrYQcQs3e73UMz1KslhP?=
 =?us-ascii?Q?J3xmijgDxb71ZKC9OVMH8xflVAxRZY5Fzv9Eb8YYhkC9u4g22esdL2xwLXiw?=
 =?us-ascii?Q?W/qwjp+klYUUZSSvkaeq/yDSYsS7wLE0iNq/B1PuOjMlrtwSZaJ9nCo7DTXW?=
 =?us-ascii?Q?trJQuyJFsBmWMNnZnSkVY8Nn1g/yQ/xwiFR/6r+l8xZrc5GcmYthwz3rk36z?=
 =?us-ascii?Q?+RsWHzDV8Kuqbq3C2k/ORsE9+jODJ0XXVQYGxPO+vAJVmUtmQqyovklS8cGS?=
 =?us-ascii?Q?lU5HqmroDWkP7dP4WZtBsAkgwcJ9TOzPKJhdy2di4l+ZTS5ePvzFXtVEoan/?=
 =?us-ascii?Q?ZrtiyAXsq7P0tTapZv++huQsnj+wCe0jLDCM8c/U0QzRz5AZv1fQWccZ2UQo?=
 =?us-ascii?Q?gaAyeU3EKqECjP94N2IwUGRDGKzZAMphQJFCP/jvoxwWVMVYR5WwCva0xVOX?=
 =?us-ascii?Q?APAXh+hVzE1efEOTm1ez++S+xVeQy/SLhq09DdRfmGuY8xtCS+jmdhvY11xS?=
 =?us-ascii?Q?tPTqhzdrkbRJhB14ep31Gwf2NtrJjUdd2Wuizb6A3DT8/OlXCmLNRfo2W4db?=
 =?us-ascii?Q?VMRoApz+gB/kqc9kRamXJfO5Qy8bmsUj3azyjdOpl4CDHt8UEhFx9zpoNRwG?=
 =?us-ascii?Q?jU4tfqVPJJxtp5FTAUoXYdKEtm1LGKwAkSd/Ey5cuF7lU66P0KbwGGpx4il1?=
 =?us-ascii?Q?ZOoPP3tyCYx7p2mOKOFn76MldeyJrTtwy5XaJNvxSNNGVSeBoUndEDpVniyy?=
 =?us-ascii?Q?WDzz4WvQMtTnsS4GleE7GAjkZLXiyoq1Gng6dhsiuoibyzQm8is4g4MjjDHJ?=
 =?us-ascii?Q?k6blPUWLe0JUfxMkh22lypdMi5Tyf3zcDkUhme8YynaGSFq4B17JwOCdxV94?=
 =?us-ascii?Q?Ykp4M5MItksgd4b8f+oFOMlOKBjp5a8WeTDdi+54w8f7BDauKg5DCp7JLREh?=
 =?us-ascii?Q?JrCv9gct5QraUA6dSbQkopBzblyufdmurO+mHK43z0qNE9B4Dk86DiG3RxuV?=
 =?us-ascii?Q?RF/Gr41w6LNQ/guTGEdNgXw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62a9981-1521-4229-2385-08db0e54533f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:25:53.9277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPOwR7bgwAmuJb4o3y3epJ0LoJZiC+GlXzkrXdNcNl2HbXU27Fxwq1ACiNCRl3x0iBOKYU2nx+VOzr+AnYGGlmoECahYMerd2TLYBrDRHyzykn/cg8jENmK/YQ8IMeRS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael Walle <michael@walle.cc>
> Sent: Monday, February 13, 2023 5:30 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Also, it is good practice to CC people who did comments on the former
> versions.

Okay Michael. Noted.

Thanks,
Tharun Kumar P
