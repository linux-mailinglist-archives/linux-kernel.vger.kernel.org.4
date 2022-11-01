Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B207B615153
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiKASKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiKASK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:10:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506261E713;
        Tue,  1 Nov 2022 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667326220; x=1698862220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XXauGtTwVRZ1PevWJlRKBi+hjH7kgGuKHjiGafSaL2c=;
  b=PIwcwFc0qFDr74Qsl+uEXYrCt++nsYyHXSDkuhcZuhlbaZ+jQQ39k33U
   Vq+mBUDlvkeEpUFzDf7dJm4U1Fvrl/nV2ED7G6L2ao/+G/ptgmUqq0PT+
   jec3FQ7S42Uv7c+izdbJVvRDwjMq91/z/s69FETSQDbjDCGljuh+thg78
   u73XCfRopNFgAr5mDMN2jbGqXXutRdjpR8NZDuuEKoFsDbuqfCcyEjZu3
   NgSvTT30afoylNolp+dpCDC+oikaNP3BTAj1X/zF6WdqFL5J2DGMMmqsq
   yACYuyiuf8+xwqVN9aAsi1cwUioW+wmlqBi8vSNFoG6RqX4huEc1ogw0N
   g==;
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="197950085"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2022 11:10:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 1 Nov 2022 11:10:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 1 Nov 2022 11:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8VYnWNvenwXs532uliUDRWY62NuIleovvaaCSsK4SRjc8jyRnAuBqAJpLCHRLKlH0tbMPfknWae9t6sCLpLJTAEWx/7KDEM78lv3vWOAp0CIgZNLtNrXWhcBWOhWertFqG2zGZMfqwu4h3VLHU4bFuhlJqdwxjz/dnptmFoFkrFQEOFchpqseq51iRGUK2Gz349eYzV9WDEZkyo4QrTdncwN40P/KT3g3WzVYyJDn46NdNumJQtnGpCLXfjOf4K5ejQRN8BjXRHinSP10d7b5TF0JuLVt3Pg0uFUCPcbykjqrRmI2WyEJRmYUqyrNjXOkfuSmLbwHXczo42Y/B8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXauGtTwVRZ1PevWJlRKBi+hjH7kgGuKHjiGafSaL2c=;
 b=FcEg3vhw5Q0L1cb54hKWw1DHk11k6Sobd63jCUxWcPAds4ZRRQqouUXEukFhDmvlxuOD/dxP+P+FDkF2FgRa+ux76lat7VWZ3EExa7L//wYpeqtyE8tnsrUuuRhPvSlCan145LkMvLkF2s+FNb5149zrXk/Csiki3youYoTiTdP1LgeVM1WlnbXofx0R7ChATtjdupemYB/dr0jd8pVz9GmExB5vMybJ3Fx+U27Sxj3lPhMXImOQnkV71zvfVmJFropBvtG6vnx5xmdpnRPWePtWN9zud7HeQPcwPKx3elKGgL3ypaVUjER5liRMaC3enwqg3zduypkWTJhIlZwSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXauGtTwVRZ1PevWJlRKBi+hjH7kgGuKHjiGafSaL2c=;
 b=lK22B9DNey3EzMzDVdy15atWr/aBzjfcUwduHltIL+NhbVv+IrvBcitO0WguMFdq+nQBMnkpbnkgoS/OQKIpn632PLZkiLHRVL5HX770GmS1aHQRWHDyzrETtvEt+3W9hCLsKfRzA7ca8aQDrmwIe5wR507MlWk2YA2psXD9vmc=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by BL1PR11MB5350.namprd11.prod.outlook.com (2603:10b6:208:31c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 18:10:01 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::1cfb:5030:3f7c:7add%9]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 18:10:00 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <ilpo.jarvinen@linux.intel.com>, <andy.shevchenko@gmail.com>
CC:     <Kumaravel.Thiagarajan@microchip.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <johan@kernel.org>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <macro@orcam.me.uk>, <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
Thread-Topic: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
 support to quad-uart driver.
Thread-Index: AQHY1V0xlQ9ney05Q0yTvysx01RZiK38Y4YAgC3ztyCAAAppAIAAAsqAgAAEAoCAACXW0A==
Date:   Tue, 1 Nov 2022 18:10:00 +0000
Message-ID: <PH0PR11MB509619A1023CD03AB03C15A09B369@PH0PR11MB5096.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-3-kumaravel.thiagarajan@microchip.com>
 <e433da81-46d5-5aad-4ce9-6d48b2e674e@linux.intel.com>
 <PH0PR11MB509668B72B3B85C2966D36909B369@PH0PR11MB5096.namprd11.prod.outlook.com>
 <adb2d184-a247-ec16-10f-dfc13831ffc9@linux.intel.com>
 <CAHp75VeuYDbjvShTTW5797opunO4DvGSLQG3Aiv0pTpx-6ZZXg@mail.gmail.com>
 <2646f5e7-7f26-e748-8812-f1d17c799b8a@linux.intel.com>
In-Reply-To: <2646f5e7-7f26-e748-8812-f1d17c799b8a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|BL1PR11MB5350:EE_
x-ms-office365-filtering-correlation-id: c1330d65-d413-41f2-47fa-08dabc344ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v486dTozbq+vNwrHJKjSzPb/6mh9vdmABj+/fJ8St3ZSy96u1DB+TIVm+bvdRK40e5Nltyvkj82VlLEitwuMchyx8QmrofOwzgWOslFydc4laj4Vn1baRPq7okhyWAzleJ9Rpbk1zCXbY/Ta7zVS4RPOHNRBtOkbSvJcbZ5TOZWf39CGUPJFvwq7uKIGlIkAi4JTVPGizCvksyv1mkYtiIHV6/8yn4oztJcos6olK/cEYCfLVNNz/lswPlo3HE2U7i+DQTmz2qBs+yyQx0fXlGvfNejflvWOXL5h4KkYRH4xWcIyISofP8IObWNrSZxjrB/3iryOg0nQJ4BbHqhSStKyl9J2bdySqnEn4jn9o8VE0c8CPYFSMqYrdAZ0tAa2HwgPwLCWUgkThV8CMZdVEpYx5ZLjKMA1GpeMWWV4SiVluYYLabyf4IGxK9h4XDzf8dMZvefsF2UiqBhbAK4aZAbzzb7Zx+292/dYHpefmHiIxnSvGCXYb1iGE9xDeyBeDClndKyU8lVGgg78buHdkikTpJPs6nESTrER1BeQM+9L7JY/IMpbsY4L4XReQ1/rrlxPZmYm/TOYqvC7YxiLPYuivH8YJd8US/D4bGYXdd5GdegCqBmrhWjganiVEJfa+hDcwbkIWKBn1gf4tj9xUjAUEgGuVggabWtebFd2osljLrm8/YwAHym93ArnxYbpggjljOxfc2DSTat6HpBIssPuH6L7RxuBljf1aalTtuOORY3u8HJ63XWGkySq/AGg2JqwvUwHwYEamv1cr3lk0g3sest0VCV16cN2D7IWFWMh1AgMKJlp05DDmTRD64/OB6Zm75D13AXMQMKNZpKs5Kxs//Fv6dEzNyosj8c4IVw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(478600001)(107886003)(26005)(7696005)(6506007)(53546011)(9686003)(71200400001)(122000001)(66574015)(186003)(38100700002)(86362001)(66946007)(76116006)(64756008)(8676002)(66556008)(38070700005)(4326008)(66476007)(66446008)(110136005)(316002)(41300700001)(7416002)(4744005)(54906003)(55016003)(5660300002)(8936002)(2906002)(33656002)(52536014)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nNEik60cJ9jwHiUam3982L/hFsZBK7Nndw5yGfaAoaMu+MAp8ONBcM/xR9?=
 =?iso-8859-1?Q?UN52uf5ls6T0LkbuMPNIcEMwtDRgp1ggw5L8xrxBDeTt+a4TRFjAwgNXcv?=
 =?iso-8859-1?Q?M0dkUpJH5i2NQyRuv8bXfmp+/MsG/x8g5fo5lwUShmX7JhTZJbAaWc6ohF?=
 =?iso-8859-1?Q?e7r85m4xX+zczpbKSUL/SjNIoQs/YCMQ8TNwbwl3sM7jkS8kCqzWby9JV/?=
 =?iso-8859-1?Q?X/UBnoYYBAaEtex3hWMdXqU2mnnLAzN4BZhpSLwtenFoDvID7UaQC06RaN?=
 =?iso-8859-1?Q?2rMpykxGnwR7QFXk2IICwJLcaCxLTEC4omjdAAC1b0qGsuvBncEHcMV1t4?=
 =?iso-8859-1?Q?E4Dc3nI2SxOm4SBxTOifbNutZ/eeauaByv5v2uAIAZDyW5hY9clvGQL6md?=
 =?iso-8859-1?Q?7Z69ReojJLOlSsEn3IPVK016UAuSFYkItxehEbiYV3X8G+melbZ5UpxVem?=
 =?iso-8859-1?Q?4JM6era7wHGYvAnpRghLYOIw0xXxF5Ss4ZkX3hjVm74aKJ69+MJBPMk7rh?=
 =?iso-8859-1?Q?lycvogNMpPdpUr8HbVYzoOFagW2qGpJn2zO9husp1uFjXyppjAjzyTKW9M?=
 =?iso-8859-1?Q?/HqQ8JK/QqSEnmeOMnlgnAp/XNoxKNHNPKRB09AfkKX0W+er3/qccIx3iK?=
 =?iso-8859-1?Q?QFlCkASvqZ3gsyepGpzuHuRdcEqJjQ//FosZIKulCMdW62WaIC2EoNFBeo?=
 =?iso-8859-1?Q?Q25QOj0GSc1GsFsamylxW3urO9MVu0oVhq9UPE5LH7s4Tpmwo2BajI0tbP?=
 =?iso-8859-1?Q?SWScd8yeS/vZD+8uuwqUpLHuiT+pQmkj8r0+PlWLt+mfCiIiIq5+nv5rZg?=
 =?iso-8859-1?Q?gr/qUAuT6bFmenkWKNrpE41qQeR79igq2vYbJ875+m2Ga2rmEOmDYacAVX?=
 =?iso-8859-1?Q?v/By3TMmyOVKKdEDZU8GlO0r+xLHW11t5Y4R6Jss7oSmnh3jDLHqMKyczQ?=
 =?iso-8859-1?Q?jMDwiWJZqeKCvnSWmSTXq10Ksy+2QyJlv6hf5iooL38bQebIRzJkDxzZXt?=
 =?iso-8859-1?Q?A0PvemEC78CAjYVumKbbIT8MWWLetVlpBDALtZfCCskmAOnrexKPME52g9?=
 =?iso-8859-1?Q?mEuaHpUTnix7V2iVVgDwFgmjAf/VB83zkOz8MUPb3+aqgswfID+y8/zhOt?=
 =?iso-8859-1?Q?fFd4IjPKEBykXEOvOAjO6An8jKuVpATQgYNMMpvW32W68yGR2CPXNcGQeh?=
 =?iso-8859-1?Q?va9dcLBVALTzIFjtT9itJNm3j6nDsyRL+D8OF5oYnbwiki6Vr2H6p5PQ26?=
 =?iso-8859-1?Q?RYIqKsOfYnJCfeV1i7DEUVz6XRp6T6WLpsoWigYgnqTqTVgxgn9gbnsPXl?=
 =?iso-8859-1?Q?JniCbT0rqXcOSOze+1diVyIktG7kQry3PlMVCvnvUtRrpm5C4qOks1iFj4?=
 =?iso-8859-1?Q?x+P26juQ7XsPjQDu9izIUP2qm2l2KsMyqI+FHvopSyG/U0zxQM76NO93PI?=
 =?iso-8859-1?Q?vELDZ7r66G7tJoCIXpDf23ucMo+GrA4O21xM9+rN024xJ/I7kZa6o6U9lI?=
 =?iso-8859-1?Q?2ZCDN3B1qUW8Y30P/RZRUKJX/BprsF7HLQXBsGSHI6A/wcs41BWX//Yv4L?=
 =?iso-8859-1?Q?SJ5MwVSHwqC71ECyKemeIOEcRQtYgrn2eAPD1M021XqIyZoBfFDJeOwea3?=
 =?iso-8859-1?Q?jDXwwHkK/HxfKbIVyTdk+Y4JNkcGBvd5Q8MhQgaonB7k4+Zmkoonrxj03a?=
 =?iso-8859-1?Q?iFVx8POgyaj/nNkiGrU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1330d65-d413-41f2-47fa-08dabc344ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 18:10:00.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gide3p4VDFoL8YbQiRTVTTcVQThMc14oI4lVrtN/ZjyBNe1Rv5Y6o0TKfh2EbKCptG81wiXOlnAgnbiX2ajb7rbt2oZNStcagdZUleuTtaumiviGpFHrYyxpYNAR2R3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5350
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Tuesday, November 1, 2022 9:20 PM
> To: Andy Shevchenko <andy.shevchenko@gmail.com>
> Subject: Re: [PATCH v2 tty-next 2/3] 8250: microchip: pci1xxxx: Add rs485
> support to quad-uart driver.
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
> =20
> There have been perhaps one of those things I pointed out that was added
> later than the others but it won't explain why nothing was found from the
> code.

Sorry Ilpo. This was a mistake from my side. I was referring to older kerne=
l instead of the one in tty-next branch by mistake. I will make sure not to=
 repeat this going forward.

Thanks,
Tharun Kumar P
