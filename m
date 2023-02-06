Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8412A68C42B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBFREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBFREI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:04:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9123869;
        Mon,  6 Feb 2023 09:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675703040; x=1707239040;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xuN3tVOIOLlioQabWx7FzN9hLbS6wx2pErGebJIRAis=;
  b=kJmyycLry7VL306D3xO6O0KQcVQII58EwNpfK85iB6myPLujucNnyKs4
   mkS4vlajbVN6lLRzdUbKo473luWDbNUeTbl1YyAo73AtKYQvehmPJreee
   KLAn1jHaRfiNXWZtiZ+xq6Q1KSPOcRybAdrgSTivaBFz4Mn6B5m8Te5uA
   RZ6aTQV1drB9V2quiy6+dlCEI9Q75wF/LRWRjOnGL47tP1gmHrUcd3s1i
   OJ9b3VzD655rOFVg1byBgNxgTJTQyR+qv8C6i1zw3/MRa/aEaHXweGkIj
   jxooG5mjLBbaAvxbHW5GtfFaoLxivBaHCeoGRfMFQCVp21B8IHHUnqPbu
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669100400"; 
   d="scan'208";a="199148390"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2023 10:03:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 10:03:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 10:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9pxGkE6XYUQ8/bv3xGmIKe3YhZUmJG0hUMgoVewGHiL8FYdqp+dwgUeLU02CXCXXrQiiGk4+MnV4mgIqf8OawafnHy91F27j2hCahvF8nLcvQFh++Ia1Mk/MKV0PHz+dNVbulnCQFy1Qv5wvcoQpOWtPboWAZxlfXjQWsmVsWYSb3dWZU0FM7aHXCIOVpYMH90y1+xDqH5hzJjAswHbRaiAlXna8XnwLiXtOpfJU3afBLOjo62j23R5oW7cAb/qRwwlFNk+EasSwZSo5q0Z4rjrn2hkEf9ZA5fJpDuNRfz+viN9mrLd/1ldpKBUElZppA0Mx/UlIiwfJ5kX7f7XmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UElmytZ5ZknLdM2Mjj6ADZgXX/RmD3Oh74s+RIxqpVw=;
 b=oM5iL3YhpmQzy/b0Mpa/suuafRXkMtCrbA87UJ5s1U5nI7Tt1sxkcAK0mB0oKi15HC049j2pXyoAgKQDecr9N2toQaqZIwte/hDSQQKsEy11LhdfQ6BWKl/wtULm3uhF6gZGHY51vaMHFHNfenFswy2b9eCXztzBdehSnTe60/Nn32PzuZdvRaXJb1Qx7H/5NpazYo5o8oQag3H42ZrxQwYq9WVUggoVA1REMJ09iQHYDGEiM0RLXGSz9zDtHwuL8rA7/ixVur18HdyI7PM6hDSGBGWeDtJz4MC2GCcZqADD/aLZgs0ib/3zVG0uq6IPeTcfrzyMriTYs5NGEXN26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UElmytZ5ZknLdM2Mjj6ADZgXX/RmD3Oh74s+RIxqpVw=;
 b=Sk9jQVLMa7uogFBBX0vGx09L887OvoadPBuBKC7pfC9NCxeurSOzJLunNSSAjWtC1fkymkx2NFxjrKOrcOSX73tm4d1Y40VZv4mrKecf61NIt/V9/iORF5R7+DdBfsNRWBxSSCaF8vZW/hb0kM/csyamTbQICGUXm1XD9rmxFpI=
Received: from PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 17:03:57 +0000
Received: from PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6]) by PH7PR11MB5958.namprd11.prod.outlook.com
 ([fe80::cf2e:97c:7f47:9ca6%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 17:03:57 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <Kumaravel.Thiagarajan@microchip.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <lkp@intel.com>
Subject: RE: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZKXdRTqU9jy+mxk+hberHdhxKbq6nKH0AgBqbxPCAAAdBgIAAekcA
Date:   Mon, 6 Feb 2023 17:03:57 +0000
Message-ID: <PH7PR11MB59589EE1C7787496316C04339BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
References: <20230116192908.2980862-1-kumaravel.thiagarajan@microchip.com>
 <Y8pzIgeMyf2oNCn4@kroah.com>
 <PH7PR11MB59587A0639FE44245A68312B9BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+DLVwfOjEKYJpyB@kroah.com>
In-Reply-To: <Y+DLVwfOjEKYJpyB@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5958:EE_|SJ2PR11MB7475:EE_
x-ms-office365-filtering-correlation-id: 2dc6cf1c-4779-4eec-3dc0-08db0864228d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhVlq6enjQGfigbnREzlsWsp/aKgBHucQ5gODAqkeW4y8v6VnqFjVEzSDmt1jipMMV3gSWYy8ur5OSYwMRyUasVQ8UpnOvAtsasOxmnyDREAYEeTGUXrv5mBDAygheOsiYKUhiDusFl9zAkUPGOvaJtilKMYh7amUov8InvtnUr9g0AGz+XHKjFKTuNFoxywnGJ+IF869zfnvpsXTo82/7uWgGMpZvDzRACsXPF2W+RX5D2ESb7pHTOblIMny54sQ1QiAAL3WGbAoD1/BDARa0xqRMdqQ3eYmDQc3G5JQ+K2m9n0OlZ7GZrtRhDRDJ7qNe8sbXyTL7bl04Mg9r29g2GiKOsV9x6PjEIctGVFsx5JGcaZUD2nmBVbBXcZ9IbtOIJ5htEIwP96zxod0OIu3vO75QjeX3Oh1FCfqMCO+GxdCh/umro4AclIhtFbV74pweGU/+9CYpKqKL0ygDr4clC2x+hOPS1iw+1dZXxwTwrndJnExrLnbbkkrirtaoKmbldG6OhjBRL+eOvm1WAfTQPE1cbelXQX97BwfZ9oQBI0vsucIU9LQjvEFjNxt7RUVchkOzaJkQRiHXEvc/2wUUNgSsRwmuBZosoFc2HFktr2u/1P4PUZiJnFSmL8GSiX0qufHG9ySpLyHGAGAMAbzpOYPe2MIChMUIBn/h0lgq1grBFeNY5rKzOfi8+dkPXw501FAv5zgAsNIRZzjCCU74xvrKobtmThd8wvJpDpu+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199018)(7696005)(55016003)(316002)(478600001)(54906003)(86362001)(122000001)(33656002)(38070700005)(2906002)(38100700002)(53546011)(71200400001)(26005)(66476007)(64756008)(8676002)(6916009)(66556008)(76116006)(66446008)(66946007)(8936002)(52536014)(41300700001)(5660300002)(186003)(4326008)(6506007)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ilOUHehLg55KW/PamKpDyBaz9WCLTh7tT5+ylkfb/hlH0ya5NnHPykhrDUT?=
 =?us-ascii?Q?vyGApmuLBQfge3a2D3d9QOIcQIYcjrBiIfq6O1IeuB3PNw9zXs1dQOK228TC?=
 =?us-ascii?Q?wZqd2xnVjv2m+UGtoUrMfpsgeFj9Br8n1B+aPwNWdgnvlkS5PDRM9n4TnjZU?=
 =?us-ascii?Q?nJ6ryLFHQ4us2PomCrVm/uHhUEdHTf1wHK29cEtuLKxgnAdwHQcIhMzxrrii?=
 =?us-ascii?Q?n/HzquKkv7OnQ47Cb9dkWaJCrJhzrn8tj3yNWecBBVzn6T48b8oMJ1H4fZnF?=
 =?us-ascii?Q?rhq62n6NrGEgXIq1pxdJkMCSRt2H6TE13O3UWc2Ps6ucCAKIEJDmsMeV1Rv0?=
 =?us-ascii?Q?el5DSYYhP59c4MBxvY+2ZVqWSij67frdMzVZU436EzRnGZkvxDeXUjmGbm2f?=
 =?us-ascii?Q?Xv6tyW+YLGMxZzGOdRlbnP8Mt9nPAROPA/YW8SWuL3iVpi+StpSdyd/EFhmv?=
 =?us-ascii?Q?zWENuDojynVCbq1NljRYNCwuYuRRdypXnRH2mTRFJJ1elasj56uySibiv6x3?=
 =?us-ascii?Q?txJ32hseq/IdBtRR+RNOoOYDSly7xkJPvmrAATsH4dbxyXzWURj595qSKZh1?=
 =?us-ascii?Q?HHxvGE6rX7OKl/G9R6BRxSgL6MWyT0a+2jBVJRryVH/jySto/HaKdfab/kp0?=
 =?us-ascii?Q?k5H5G15QKV53u3uHv6C3EuSz0iGkkIwbDmScijIN3ua7L5bvXcu7E+9BzboV?=
 =?us-ascii?Q?JyB4x5J+AjHRxmm3S926AAfSeBn5qPE7Sc0vEek6Z89YjmovaVjAVxJXJm05?=
 =?us-ascii?Q?TalItuoKtD1cATsWlcR+4WWHD2gQeXzJPOhq15pw5wqya+FNBbKl1u73oCMZ?=
 =?us-ascii?Q?KMsdD/leWBR0XRuEsKmPs/d1542bXTnF3HVry4IPnoeHai3f/rsxDK+t5a5+?=
 =?us-ascii?Q?tTP4hysX8dkVXScN6nimdTqFRRDZa+jBhJdJX68cXEk2oHbN4PA4oEcwnq+X?=
 =?us-ascii?Q?7pJSk/LOyt2PcPv/PMaq3hH3Rt+PJnjPiYXlE5Qj3aAwGu9g2ZztD5acP2ul?=
 =?us-ascii?Q?9LkwIB0ucWu2QoCO2MhnIaJ3MLDZKkavvOTsIYPIHPiKvusxeNXLlSjZFvvQ?=
 =?us-ascii?Q?N/RZP1KgbD1bRnAE0SJ0qu5po3fhOUUIbLBgMbQsTTW+KO/lWyGD0mOu0xjq?=
 =?us-ascii?Q?UP2cdPPSJvTx2Bblbh5k8k36zxpxp7WU+nNrnao2Dv3RfiBp5HPGOdmixmQl?=
 =?us-ascii?Q?0JIlZHBvD9AOpBgocf4UwUi3fBhE0pLM23RvT/d1aoPxTRMj2NxLqGrtAyJH?=
 =?us-ascii?Q?QPY780074zONnQsITAdp0lvKk46hdlUIU3qbtpPIDItDH2YCNcGPGYWOwpfr?=
 =?us-ascii?Q?c7QTU0Y45Cg4tkxQil3wZ82JImKIqTmc2ttl11paRCDBEO1y3o6zSYyp4/Hx?=
 =?us-ascii?Q?gPkaHbiggWdZAm6NCrxYxwPvc11mxVlNqevOgrGKILSPbDOBPKAT4Xv3TeE+?=
 =?us-ascii?Q?bUvbSEXvxB/McHCZgabuLSnQagvSF7q5HFjx7jqipe8wHc5JFpPK3tSm6gfa?=
 =?us-ascii?Q?kxUK8TCaF6I74F43KIdlOiqzrLGO9RaeSodgxTPMVJoCpXRkk6mi4YcEqJPD?=
 =?us-ascii?Q?la4Zsyu1+wxmsENTaXNe1wLr94AzV+YIV8LHjS/OwF8a+1z5jqqPt4CJKnPE?=
 =?us-ascii?Q?L5fXBHP83zEhL9uaYQdYg9Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc6cf1c-4779-4eec-3dc0-08db0864228d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 17:03:57.2022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+Jm/QziBqMWoF/Cjst+jym7YdfsQzqfmTRymspBl+xTq7GoAX6v6fuLuubR/CDijKE1Oz+HAs7mzhoRrsRQQSEmxPdCTLcQ4TlbfdnBZtbpjv5ls28pUJGLyyTDNf2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
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
> Sent: Monday, February 6, 2023 3:12 PM
> To: Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>
> > > > +     delay =3D msecs_to_jiffies(OTP_RW_TIMEOUT_MILLISECONDS);
> > > > +     j0 =3D jiffies;
> > > > +     j1 =3D j0 + delay;
> > >
> > > Are you sure this math works out?  Please use the jiffies math
> > > functions instead so you can handle wrapping properly.
> >
> > You suggest using any existing APIs to add jiffies to handle wrapping?
> > I am not able to find any such API. Can you please point out API name.
>=20
> I have no context here for what you are doing with the math in jiffies, b=
ut
> that is usually a very odd thing.  If you use the normal timer functions,=
 you
> will not have to worry about the wrapping as it is handled for you, right=
?

Hi Greg,
Our objective with that part of code is to wait for OTP_STATUS_BUSY_BIT=20
to be cleared in the hardware, but make sure that we wait for a maximum=20
of OTP_RW_TIMEOUT_MILLISECONDS ms in the driver and not beyond that.=20
This logic is not possible with normal timer functions. Timer wrapping logi=
c is=20
handled by time_before API internally. So, there does not seem to be issue =
with
existing code.=20

Thanks,
Tharun Kumar P
