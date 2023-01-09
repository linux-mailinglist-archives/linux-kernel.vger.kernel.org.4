Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E312A661CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjAIDiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjAIDh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:37:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F8959F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673235475; x=1704771475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HKWAWim232pgJhfaAnFy24yW/WfYe8dhW6YDZrY7cvc=;
  b=L0EHguDoyJT2UYJ116Yw/BYyWT1dBNdODpeKpHZn4JGxcVTe/gKSl/M7
   Ve+FtZvlK3/nfII4MLUphX4+Is6dUjO3o6kyB9kilrMii3LP+TYQC9dpB
   fjrzK6j78hnfLueA16iAzDjeKVbFzNyGnTqs+mg0rnYmVKevrP8il7ulP
   oAnGtaLxO0j2ks60BW0MbrdmNbw+3+sL/N8OPjFcbdnVw+5shuuGGTyh1
   mwPCFebr4L98gVY9WcnoAyP/z47IAlV5xusp4DFCrGZoiqnh/+PTY43+H
   EfcRu0gvfKk8OIJprjAKzZSb70hxSJmIi2jtzRNtw2BOoRSRMKWvmJnYu
   A==;
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="131384833"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jan 2023 20:37:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 8 Jan 2023 20:37:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Sun, 8 Jan 2023 20:37:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E16maaMTgpcSMGBTeI+ZqYF14l1MsJ7tfMXrHUeZVy+SleM3F6PUPLv5feD6k/nY5FE6SV8eXErEgiyLbJCQkZI/yj15st3Np+F2cRgvBebp12ZzydkM9t/u75UpBXqd3kjyHUVHmdordsMn+vwCRRTgN+AmNx507wTj6uOpjGab1wqbLq5SNdxlSNBMdBBv5+XPvfbwOJB19lJF2zCttc8eg2Qz0qPlxglEsVyQilIb8pxSENllsbJYAceUrax3L2mlKK0sqOup0SGmN9YauAdOqdO3P+XHUv5pkhWQqqPSda2ZETqltujgBjzu9xoHpYKDAk1A5xURcFWpQCUrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpKN2iENoeoTEz16gKdjLZWx0qmsC4hQNprL7S5GX7k=;
 b=hzDVQX2FqZMNQb2DNCwnlkiofn/PqOL9DlNPaI07owm0rKXU+dUgROt1JszKIu1nn4T6g0WeEhcNO/om7lVySbJ5nPLlK8l5ZCFf/zZ5rlT+cDDy0C1yQ+HdWxMhX1mVo2x8OUkN5bG39IbOipNXEubXY0pT4rtpQCPMZRXMm/4MMpcNcs+Daa90c8bqrGugBrz33srLewQCfeOxCVvrn0GLkftxivaN4nlW7YduUXritV11qfbeJf93Rmr4HZHEQ48fm/gdNZ4It5ze6+em6yZ1BwYVdn/t1YA5fJrojFrv6vr50leGAN+UMeFdFnOfEgSsh5uCnfWPn25JAvoo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpKN2iENoeoTEz16gKdjLZWx0qmsC4hQNprL7S5GX7k=;
 b=lhxJ0fhNPW0wKRNr9MXlf5s92VT8sW1EXbHywR9r3nTnwlu4tQPnCpH9vyvGp8UZcdgrvXr7xc/MSm41zhTm12t2inbujzD+gkGlCcUYUEWZSKTzaWZczbc6VxYZ8ZMfP09CT2e6LAS2NPyXF9YW9ZH538NWrfddjsww3wDefPU=
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 03:37:52 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::97f3:ca9:1e8f:b1e1]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::97f3:ca9:1e8f:b1e1%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 03:37:52 +0000
From:   <Divya.Koppera@microchip.com>
To:     <error27@gmail.com>, <oe-kbuild@lists.linux.dev>
CC:     <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: RE: drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn:
 passing zero to 'PTR_ERR'
Thread-Topic: drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn:
 passing zero to 'PTR_ERR'
Thread-Index: AQHZInLMP52dWZBq+Eyy+C8bbwJBrK6VcdhQ
Date:   Mon, 9 Jan 2023 03:37:52 +0000
Message-ID: <CO1PR11MB477198373D836FC02B79F460E2FE9@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <202301070307.5CkACLRd-lkp@intel.com>
In-Reply-To: <202301070307.5CkACLRd-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|SN7PR11MB6678:EE_
x-ms-office365-filtering-correlation-id: a20955ea-111c-4a76-4f79-08daf1f2e32b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YqJ8z0yjMPCZaU4XjMVZKbFvn2ZuDRHW2YyORKDxsYWYKRZCDezTc8snDNUvf58Y87Wv9Y8N6T5WyXTAZzzi3lxgq+8iQd2xjI3KNOwxFNvoNBTzgEaEMfIqXA+t9jJ0EyOpcZqVs7PQ9myw2ZLu1cEtQS7aszJBOY5hgtv6Ks4iUENpC/gAQTU7mvK2tG/OLaom0bUVK+BKLF+blQ3YreXZVvcqI/51q6b67nFc3Uiw3uJAd0srTYoFK/MMDbTiX/2xWgBkUUhhDwZOWuxmOx22QXDX4CMBzIXKnSwZgtFjZ2eB7HgdKvwjJR1xrww/zHL7Kwc/tr/NeJCJ1618OrJyFKTl9HiMVE6ZQ/ki3EZYgDzZSuOxaKaoDJEfF4Q3xS59YJn0VDU5VFGzfTHY94J4oQhpGjLwrH/HR9ZIm+ubbYk2rw533fM2LJYRr4IotHV9TXcOy/SggHS917zVHnLrNsKpHmeJ5paCUwyuxjsuFL4nk31MqBd61iwuJktZb9RGwcziLiAPmG9E5FTawWfjC05UAtadNb7AOHgzSfJ5Ld+QEsRDsnTiKO6avrzlheWOkUydKudIqjeH3IBXYQzTn2CV/nxxjkDvXXvwVGbHRe5n7+qhWI1nx5+TnIEIFdk4gNTeL1LapGatOmxBLcG4JU82wlyeHwCAHpf6JJDOxmn502g7WyByalO8wv0WGrf+pgvwbmFC1SfAW9eD50diDBEgx3dlCOT6TA/ZbcM+fjouD820hjSuU36mzC8T/f8K1nUcPE4TzFqTGXpXCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(478600001)(66574015)(86362001)(110136005)(54906003)(76116006)(122000001)(5660300002)(38100700002)(38070700005)(66946007)(66476007)(66446008)(64756008)(4326008)(8676002)(66556008)(8936002)(316002)(41300700001)(52536014)(26005)(71200400001)(966005)(33656002)(7696005)(83380400001)(2906002)(53546011)(6506007)(186003)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R0Nr+mCG1dD5je7nzPn9pJejPzWwFeWJzAsbSewrcPfWKQ33r2Gh/nHRsR5L?=
 =?us-ascii?Q?C18zGJx9eifDSXrBxxIFBdJLnlzVg91LUtTqu1g/xIAci4Cbijaq9zyY52TR?=
 =?us-ascii?Q?NVCNgEISFH+anf6LKpo+g0+GOMDEyOtPW4bmAzYvRGR5mYhpt1BC7i9RmHfV?=
 =?us-ascii?Q?RYwsAuUOwc8m6RpMYV+LoRRX1wtgVEAsRuz7v4ggFFnXlPuUkY5en9L8AICi?=
 =?us-ascii?Q?ePGoxoHWAZUM/3ITv8kXZtqP1c9B0OpxYOl24doQSD//KZoTtohhu3gQZ3RM?=
 =?us-ascii?Q?C2Zca0Vi9KDEMTXI7PBoVhnJF1roU/+rCqPxozjNUDMF26zHn+EtjYKDJYPV?=
 =?us-ascii?Q?r26znOW4lqS9R0dIoFnsRnLHg5Eoe5Z6rT2JjT/IzgogkiWN3oay3aaZXC3g?=
 =?us-ascii?Q?DJtfxxiyOL4D8Qbn3hFIEUL1oac+wWKL6pZq9rzII0pQZwrbwnx9kLK2+qN1?=
 =?us-ascii?Q?aYxDMH2KFCM+OZ9WlgZfLDr/g/yP53OZEyMx7q55tLE9Sl51HhCRhBnd8Jdq?=
 =?us-ascii?Q?Rl+hVxCL2qMJnzeqWdZUpabvChKRlzKObbgb96Kb4a5/R8okD5pQVcn/OgYq?=
 =?us-ascii?Q?EN9wtn71gT6FlDvnmUP6dwzDaww+3yjPunfs61Z8ZPpx6WhcSlyDjN6PFVFr?=
 =?us-ascii?Q?IzctAq2RwGXzmR/UCFSYWCpGE5YnxiBmHtR2uiUeynlCgsyMj3YXO8g5Buwq?=
 =?us-ascii?Q?51yeW0UvPQ/HMh3Wd8wN4JCWHiWlMiTCBGWNXOd0GEeXApsqmZWbNqb1ENKO?=
 =?us-ascii?Q?ao4KertpSfRD/FW44W/GQqhONiHgAuVY13ko6jlTla+jtzlPpolRXMtxU1w4?=
 =?us-ascii?Q?yOnteXmhFCZDI2ExIHa2/rKb4Bx9++Phcd+crYuRvVU3wZkwIsy56OoFwrYv?=
 =?us-ascii?Q?WAO1VVZ9Xjhx9Qm3JKf7kdirav6K6I5Us7A2hDjGrhfO3GqVAHbhLuDjOgwr?=
 =?us-ascii?Q?+PEu2H1Rw/nUz/vI/5I9fKVR1mpzrt/FhsjDuBXnCkGCE/hQhIqTP4LMfLGW?=
 =?us-ascii?Q?YiST3pQOpx7lEXEalOkye/vHBPrqn8y+EngvdjrDEE25EulH0312+yM/8hXx?=
 =?us-ascii?Q?j9rQiRpG+JYolV9tZE0YhR83iiOEMIc1UTG4thG+118fHEBmhVVWcPThddZi?=
 =?us-ascii?Q?gKh6LW4QC8nvYcXLsSQxVqZsBI3C8T6i/V/whEsDpb4lfnFRozwFyS+alSte?=
 =?us-ascii?Q?kfPOWbwvi21usKrOQ3lUivdH7lbYNI3G3mDajLe4F5XR8wyqpkmoPT2fLc3b?=
 =?us-ascii?Q?HzwQiAsBoGDZnWsEDHsD/oG5K6zQ+wmBYvEO5VFPqlbaKhh1DUK2AAACvUOC?=
 =?us-ascii?Q?B5bjyMoHuD/UFITBkzCirJLMLgvwo6T6xyOEpY9IIiVNdi6f5ro3IzpgCoA3?=
 =?us-ascii?Q?8ASpI58N7ADlCsNRs52IfUMgyqhfQHyy3kk/ESLup7w8wRHzSsoNpNSQ2+/w?=
 =?us-ascii?Q?IHEZotMD3Av55JUO86AYdcVMVoNp4fZx/wN03WO/ECUVgqnCwR9vBsJTJKHY?=
 =?us-ascii?Q?IZSdfd0nfpYs2hMxJROnUuK5SC46EfNW+saj+PyXZSGonl/Drn66Ijw4W+L9?=
 =?us-ascii?Q?BdM+uNrKjYnTnKIaOl4db0ahAEYAFyk8BMyGfAlI58GV7NTFoVCIx2Nryz9H?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20955ea-111c-4a76-4f79-08daf1f2e32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 03:37:52.1523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2TwzI58AYvzITFxNmBr9maVDE3TwduKvOnxZZVPMudS/VW9ZlWFteZjCMpqmtepvw5dLiwoK89SWKA4lT294N3XeoIm8+pj4Kh4Du3OYxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have given fix for below smatch warnings/errors, reviews are in progress.=
 Please find below for reference

https://patchwork.kernel.org/project/netdevbpf/patch/20230106082905.1159-2-=
Divya.Koppera@microchip.com/
https://patchwork.kernel.org/project/netdevbpf/patch/20230106082905.1159-3-=
Divya.Koppera@microchip.com/

/Divya

> -----Original Message-----
> From: Dan Carpenter <error27@gmail.com>
> Sent: Saturday, January 7, 2023 2:03 PM
> To: oe-kbuild@lists.linux.dev; Divya Koppera - I30481
> <Divya.Koppera@microchip.com>
> Cc: lkp@intel.com; oe-kbuild-all@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn:
> passing zero to 'PTR_ERR'
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
> master
> head:   1f5abbd77e2c1787e74b7c2caffac97def78ba52
> commit: ece19502834d84ece2e056db28257ca2aa6e4d48 net: phy: micrel:
> 1588 support for LAN8814 phy
> config: arc-randconfig-m041-20230106
> compiler: arc-elf-gcc (GCC) 12.1.0
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
>=20
> New smatch warnings:
> drivers/net/phy/micrel.c:2613 lan8814_ptp_probe_once() warn: passing zero
> to 'PTR_ERR'
>=20
> Old smatch warnings:
> drivers/net/phy/micrel.c:1750 ksz886x_cable_test_get_status() error:
> uninitialized symbol 'ret'.
>=20
> vim +/PTR_ERR +2613 drivers/net/phy/micrel.c
>=20
> ece19502834d84 Divya Koppera 2022-03-04  2589  static int
> lan8814_ptp_probe_once(struct phy_device *phydev)
> ece19502834d84 Divya Koppera 2022-03-04  2590  {
> ece19502834d84 Divya Koppera 2022-03-04  2591   struct lan8814_shared_pri=
v
> *shared =3D phydev->shared->priv;
> ece19502834d84 Divya Koppera 2022-03-04  2592
> ece19502834d84 Divya Koppera 2022-03-04  2593   /* Initialise shared lock=
 for
> clock*/
> ece19502834d84 Divya Koppera 2022-03-04  2594   mutex_init(&shared-
> >shared_lock);
> ece19502834d84 Divya Koppera 2022-03-04  2595
> ece19502834d84 Divya Koppera 2022-03-04  2596   shared-
> >ptp_clock_info.owner =3D THIS_MODULE;
> ece19502834d84 Divya Koppera 2022-03-04  2597   snprintf(shared-
> >ptp_clock_info.name, 30, "%s", phydev->drv->name);
> ece19502834d84 Divya Koppera 2022-03-04  2598   shared-
> >ptp_clock_info.max_adj =3D 31249999;
> ece19502834d84 Divya Koppera 2022-03-04  2599   shared-
> >ptp_clock_info.n_alarm =3D 0;
> ece19502834d84 Divya Koppera 2022-03-04  2600   shared-
> >ptp_clock_info.n_ext_ts =3D 0;
> ece19502834d84 Divya Koppera 2022-03-04  2601   shared-
> >ptp_clock_info.n_pins =3D 0;
> ece19502834d84 Divya Koppera 2022-03-04  2602   shared-
> >ptp_clock_info.pps =3D 0;
> ece19502834d84 Divya Koppera 2022-03-04  2603   shared-
> >ptp_clock_info.pin_config =3D NULL;
> ece19502834d84 Divya Koppera 2022-03-04  2604   shared-
> >ptp_clock_info.adjfine =3D lan8814_ptpci_adjfine;
> ece19502834d84 Divya Koppera 2022-03-04  2605   shared-
> >ptp_clock_info.adjtime =3D lan8814_ptpci_adjtime;
> ece19502834d84 Divya Koppera 2022-03-04  2606   shared-
> >ptp_clock_info.gettime64 =3D lan8814_ptpci_gettime64;
> ece19502834d84 Divya Koppera 2022-03-04  2607   shared-
> >ptp_clock_info.settime64 =3D lan8814_ptpci_settime64;
> ece19502834d84 Divya Koppera 2022-03-04  2608   shared-
> >ptp_clock_info.getcrosststamp =3D NULL;
> ece19502834d84 Divya Koppera 2022-03-04  2609
> ece19502834d84 Divya Koppera 2022-03-04  2610   shared->ptp_clock =3D
> ptp_clock_register(&shared->ptp_clock_info,
> ece19502834d84 Divya Koppera 2022-03-04  2611
> &phydev->mdio.dev);
> ece19502834d84 Divya Koppera 2022-03-04  2612   if
> (IS_ERR_OR_NULL(shared->ptp_clock)) {
> ece19502834d84 Divya Koppera 2022-03-04 @2613           phydev_err(phydev=
,
> "ptp_clock_register failed %lu\n",
> ece19502834d84 Divya Koppera 2022-03-04  2614                      PTR_ER=
R(shared-
> >ptp_clock));
> ece19502834d84 Divya Koppera 2022-03-04  2615           return -EINVAL;
>=20
> I sent a detailed explanation of this bug earlier but it still has not be=
en fixed.
> Search lore.kernel.org for more info.
>=20
> ece19502834d84 Divya Koppera 2022-03-04  2616   }
> ece19502834d84 Divya Koppera 2022-03-04  2617
> ece19502834d84 Divya Koppera 2022-03-04  2618   phydev_dbg(phydev,
> "successfully registered ptp clock\n");
> ece19502834d84 Divya Koppera 2022-03-04  2619
> ece19502834d84 Divya Koppera 2022-03-04  2620   shared->phydev =3D phydev=
;
> ece19502834d84 Divya Koppera 2022-03-04  2621
> ece19502834d84 Divya Koppera 2022-03-04  2622   /* The EP.4 is shared
> between all the PHYs in the package and also it
> ece19502834d84 Divya Koppera 2022-03-04  2623    * can be accessed by any
> of the PHYs
> ece19502834d84 Divya Koppera 2022-03-04  2624    */
> ece19502834d84 Divya Koppera 2022-03-04  2625
> lanphy_write_page_reg(phydev, 4, LTC_HARD_RESET, LTC_HARD_RESET_);
> ece19502834d84 Divya Koppera 2022-03-04  2626
> lanphy_write_page_reg(phydev, 4, PTP_OPERATING_MODE,
> ece19502834d84 Divya Koppera 2022-03-04  2627
> PTP_OPERATING_MODE_STANDALONE_);
> ece19502834d84 Divya Koppera 2022-03-04  2628
> ece19502834d84 Divya Koppera 2022-03-04  2629   return 0;
> ece19502834d84 Divya Koppera 2022-03-04  2630  }
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

