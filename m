Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32168B87A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBFJU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBFJU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:20:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780124C2C;
        Mon,  6 Feb 2023 01:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675675256; x=1707211256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=urBxPIsFBJ0SWtrwV2/7uamOfOIf5Zi/lwUlTJ6cSzk=;
  b=doCri9ALHd5sPEEU/5quArC4fCJQrC3X6qEKdVGxV8fPM5cxE1mVBVQu
   jRPJaJSxJ1LU51oiPQFHEsZuD3M+iCTkb2McAtxCOGvzRfWn9FNxIFUfh
   SIWqBG7Afv+bCeeg6JlQsd1i7ll6m0/BE8P5Dc+mh4uw2PLfxgMGlrMAH
   CM80sShnim7gNUXM0D9HrjWcRNAIVKuc+c3l1rjvTqQclhx3H60ghopUc
   mqL1/w0ZscjB7M0Yy9pJi6uxIv+DYBWGT20XBPVuUyArxCajyup42AigI
   YriplnevPiLl6wP1A31pidRiQuGyhDBmXQ//LiEdHrYV40irILbM+OGxr
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669100400"; 
   d="scan'208";a="199079013"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2023 02:20:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 02:20:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 02:20:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiC2C8UR64QON7VWuqn6AsJ9/r/rwRibCPzzn30sco2BCj4bnIufndJ3f/pw85y+8psrSYTfC4ADBQvt8Dgsu4nuKqBFjr7/RrhU7pqUIvFToqzLOqUB+RsAD+5D2Zl28/aBxCLqg5gN9dkrCLYUsf/oqI8tOXkovoHlNWD3MGmuzrKXBCaPL/AOdiL5q5exrn5cHQoz3AToTqU7Fnb+hAQo+OdWz2+WEfA5r4GnAWKI2JGUL7tqZIaQAEg+pzhRa4+zj3mi/ZSjKK7NPz6ddSyl7LsTcXqLVxdLXclsZVDMsVQp+8Vu/s9jrI4OU5jsgDoqhqV4377kWkolXYOdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFjoiB+LK2mTsqMwNttqAozubq8fyJ925BjrQwjKVFw=;
 b=mbbYAuVrD02YiYyBII5YInpZtixm84V28rb2s8ZdU0UWZR029JOS7RivWiSjTwyndpXPjRpTIgPPRLiAYV61QJrK1yNFpvl07L74sAMMv4YbtpBPr23I/0T0mp5vfoCSXuB7YuSuJ2I4J/gvEnfnP4PukYkDVJIGwMtoZ9101Kn9CDeUXPeON6Bd6rnLADBSWTW+03sChzq3Gciv1C6H++xjkx6JfJ2oG35HoTGanENKMxVHhq+ut37Sjz/uvAdTdm9oZolXzTsd6ySJ3OIX9EsjwPdD2sNQ8MyY+0eXB/bhXY+E6xDNtmPWlAgoUgN++iIfUHLsg/aibRB4co6aAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFjoiB+LK2mTsqMwNttqAozubq8fyJ925BjrQwjKVFw=;
 b=Cek90+s7jDBaJt5o8y6a0u6IDrOYN2wsS4NHdwafHFaBUVzaMLnR8TEKkmrASP6HfbhcUsnLx0Sh6Sajj35X03cbLzQZIiUwdmvWN61KzTGIrS3TpJnP4DiSzVQpnMJYZ2Xa5LYDEHC1RB2dnWjwdVdUGpSD5DfIKQ5/z7ZAPpY=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by DS7PR11MB6040.namprd11.prod.outlook.com (2603:10b6:8:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 09:20:51 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 09:20:51 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <gregkh@linuxfoundation.org>, <Kumaravel.Thiagarajan@microchip.com>
CC:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <lkp@intel.com>
Subject: RE: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZKXdRTqU9jy+mxk+hberHdhxKbq6nKH0AgBqbxPA=
Date:   Mon, 6 Feb 2023 09:20:51 +0000
Message-ID: <PH7PR11MB59587A0639FE44245A68312B9BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230116192908.2980862-1-kumaravel.thiagarajan@microchip.com>
 <Y8pzIgeMyf2oNCn4@kroah.com>
In-Reply-To: <Y8pzIgeMyf2oNCn4@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|DS7PR11MB6040:EE_
x-ms-office365-filtering-correlation-id: 3c2f1d97-292b-4482-3dcd-08db082370eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uxbe5wXlxJX9X1f2L6Lns2/4nOqCigbxFJP2+iJ70JvwEGpRH0zyGT+79DnKthh/jScJDYuMa31OegS3kAz4wsj1/vfGgLoZVjaOyhCanHTuQieHuwB2k5tPokE5rsepeKyiPTxNO2E94zVmHsg+jo5Hil+eynBlQScENc1qTydZaCcsDb+/jwQ2prXWDOiE0nIbuleyPW+DDJeHq5o86vkOvgoB1MdjyIL8t4PPoQ8jwGb+OXgSE3sTVaB+1e48j1rOZIby322uQSCDDUVeglla2v9FMdb8yk9uNEX3BC9XgytQQavDGn3gknuX+Ii1R/7hlc1a8oNCsw5Ucne3zHEHrQN9bJGX+NOjs/A61MeZOZc5nUSi/6B7Lg0wpjv/YTTwyqOuw6vxKbai9xtrWXItjlGJBs3BaeyHV7ypLkBz8uh/cK8MaG9mdg7zOteWCrxum2AG6/z18DVBzR0BMJy06FDfwpB5QDwntcL1mMJIGGHlxSeWdJS/1LcWXhfQUOHlD/rBZwCFSOf4RbCTnECVq7yT9xxV1q5P2mqIvZeGgW2HO+iZOhGPUMjzOxHVNuhQUpUmn1duOHflGKIFFAaPdEdu1HDwaYHI5nXEgmaTR1SE/ctiLl5VREca61a9SogjjW+yWcF6O3aTt+Gy6wb6DgwvRugMkzcJVirUyKprwh0ZRbCw+bO2RnByHldgckMIEswGwu5HUOBQU3lOESsUg6EX1RN0yVSuars/L3U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199018)(86362001)(6636002)(316002)(33656002)(110136005)(26005)(186003)(54906003)(71200400001)(55016003)(7696005)(2906002)(66446008)(64756008)(66556008)(4744005)(8676002)(8936002)(5660300002)(41300700001)(4326008)(9686003)(478600001)(53546011)(6506007)(52536014)(76116006)(66476007)(66946007)(38100700002)(83380400001)(122000001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YXFV+vOYyTz+IpmEpWfgTOtma4VLH4O/ERG7ceXatOsXngW6s4PQVP8QQTyc?=
 =?us-ascii?Q?ZPsFtDuukXnjpVTCQwPrQ5A++hxxXrC8eMbAw4bT6o2RkJ8UGUhisLd5AsET?=
 =?us-ascii?Q?4Z02SFQdZeM6mZrXSD6QsAlbyRgutc6KG/c7hY3/nLkYsO0nnJP1IqfMvWtF?=
 =?us-ascii?Q?pl16sQuvxCIkuVdNGDyov4S7OzVhv+8AW+kh16TYkBsTH/VLGH0PgVq740Fg?=
 =?us-ascii?Q?MLlPsRfvC3dKDXP5BtGPpz7rRNNBziBV4IU/YjTAbNtHYQkyX58dh1iJdzrE?=
 =?us-ascii?Q?jA4l08LB1j0aojKub1wkSla0fdv+rGCVd1opfxoqj7skdfnFIexcMRcGYE7+?=
 =?us-ascii?Q?DbYMdhUIfNQ5ngUUuqCdmMqACo2lpHSg4z/PR5vX9/0EXhemfEPmDw8V6tU6?=
 =?us-ascii?Q?9gmnhZmBvXN1lNUHUwLXhLffNofKa/bUt2yZVef6QyI0zooQvdQPp09sVnjt?=
 =?us-ascii?Q?Ud046a3m7SZcDdvbs0kp/T6gD39f3FU9BpgyOUyb1gtNF0WtdDDMlui2ZAaG?=
 =?us-ascii?Q?V4FeOYFOQwxO7mGmTPL5bhvea5MtnHp/x1FcFSgUqc+HXY9r/AIz5LHkE8Ky?=
 =?us-ascii?Q?Lpjafh2MAjEjL27sWup/qWjYMMTI/e3DME7NmdogYB830bO9ySwU+adwyzsV?=
 =?us-ascii?Q?c7ENPyqfWjKBGKJuym+RiiUd3zoJVezPV6p0M5cVPgnKZMN6lu4aK6WKRZNm?=
 =?us-ascii?Q?4N3ZnhXtmLVgtu2zLDYEqREDypY6a8ThmOSN5oIEaC8S78ROjizeXCnP0Btt?=
 =?us-ascii?Q?0rmpdx88ui04l1KxTRKkjdtoH3ZII7VEtfbbsGQ1zanXpRF+dSw9T1hirgIm?=
 =?us-ascii?Q?HwBCHm0YUlO6KNAmm4cqK1iKWgI9ZUcoIQI7hkJR7lFmar9AvE5CZAsp6WpD?=
 =?us-ascii?Q?Vc+a/oirELKPzWrcN0byMHNL4R+ZwBFWQaGfkU2TD4yK31Gj4M9XhyLVbDtm?=
 =?us-ascii?Q?Vs653EZCmnW2c0Objm94+pVM+qGqY4SvroOSQdBkdiQMBXvLGtXmV6KEN20y?=
 =?us-ascii?Q?HvusKiN0xkUuXhhGk5vkWA/VAY4mQyIWaHIwQv6RMGwLGoD5xHYR5uCrwR/O?=
 =?us-ascii?Q?87qSGabaJ9ZK/364fM3eaTcnsevJSkLkqyAbJSExpugz3qTfdnJvTsMP8sDI?=
 =?us-ascii?Q?HASqGS18E1sQvLjtELWZo/FD25VbCGCPNOZXW5tuzrRZp7Sleyv36WEnrAgT?=
 =?us-ascii?Q?FbkXKjK7jvKBJii+sujxixrHaChZXcsaqK9mmt75+LOOQBbcIiDuTKJc+9Fm?=
 =?us-ascii?Q?PebBqutRmTl9W+3rhjKtjLjIucnpIXxFvzN+aCO4KIPilQPYJF2VvuAp2ELf?=
 =?us-ascii?Q?7Dlmp69T483WE3ew6xo9eUYtK7bT0popK2lKig6hNLkENFS3abmCIHD7qDmM?=
 =?us-ascii?Q?e2lfsnC4DKg3Ncy4BU2i3zNgrzKmvBVr7HQApmL0G5FuFY1hVqB2FyK0FGIN?=
 =?us-ascii?Q?Q8T/V+qIiRAsOLYwb74bIf41lLOA53DWoR76aqw4STjvlk3oknWa2xSo0Bkl?=
 =?us-ascii?Q?cq72HKS7+M58UzW4I/WD5AOv4N0mRRFjCyCFvzhhyZaOgHfH/dKqkDtCEtiy?=
 =?us-ascii?Q?IMPqqQLGwHECuxsqY1CyIY4JZolrmDrzGqqa641nz5G8IM90y/VcU2wTKR0B?=
 =?us-ascii?Q?FeAiggL/AkIK1S4fFxG6asA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2f1d97-292b-4482-3dcd-08db082370eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 09:20:51.3931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amn0+spys4H5ZA8Uk9POEM+boFxSSXwE26yKszuGrgoJigzBG2UvvnoTsxdIuV+0yaas+pjdQEh/P3OkvMJOtfT4+fI2cvGE8nWgJHQvMBdnkuSYR3DAnry/0ExIZBVG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6040
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, January 20, 2023 4:26 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>
> > +             dev_err(&priv->pdev->dev,
> > +                     "EPC_Timeout, EEPROM is unresponsive: %x\n",
> > + data);
>=20
> Can this spam the kernel logs?  If so, please rate limit it.

This print will only come once at max and will not spam logs.

> > +     delay =3D msecs_to_jiffies(OTP_RW_TIMEOUT_MILLISECONDS);
> > +     j0 =3D jiffies;
> > +     j1 =3D j0 + delay;
>=20
> Are you sure this math works out?  Please use the jiffies math functions
> instead so you can handle wrapping properly.

You suggest using any existing APIs to add jiffies to handle wrapping? I am=
 not able=20
to find any such API. Can you please point out API name.=20

Thanks,
Tharun Kumar P
