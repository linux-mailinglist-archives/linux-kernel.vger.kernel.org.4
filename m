Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9FD6A7B90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCBHDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:03:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E731ADE2;
        Wed,  1 Mar 2023 23:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677740627; x=1709276627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dTPhDV0sOy8cHPoz8neDVVs8moaIf4oek0G9C+zDL8Q=;
  b=gv32pSnuIw5aT25yX/lVxUTz5brOMV1UdJTrybApkg2F5t3vACmjNVjI
   LEQt4XPipChn5a3ibMGkS3+pFTcQ3T9nGDjfyst0XndJPC/P01gEv8FTg
   BFjSv8q5UFTTV9MNB6cvJ6BC5uZyd4CkU2egbfA3TIiyhH1FMOvEsrrFg
   xV/A8ZHUKVu2IvfaOX3p2LnDoFVkdN31OP6nkCIKrY6OzrORpLONg7V01
   or03q9QL+O1HwwWb7SuEP6fJs4i6FTKFj8NdIk5lVFeXmBBqG+bWAR7eD
   EHNbYrGz/sNl2Ndoxo3ETyRbywqPT1eQHFcYNcV9LJfZ4pRGcwwq54Cr+
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,226,1673938800"; 
   d="scan'208";a="199528341"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2023 00:03:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Mar 2023 00:03:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 2 Mar 2023 00:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbsMgTIleTEGxo1iZ9r2WoECivSbm97g8+IrgLfi0bEgdMaem1vHTlx02gvbstfoHMHNr3VfE0ktJ4vEYt8FTO34IYTdxYsvmAe3jt2p2k0IvKHaGqcJKHk2m44y++I7NFHFcwC0nxAsd8yp2Krw27VPcH4/9US5dsAwT6dugMrfKfzEeRDAvRHmCywEYTmLXPajsU9NMgwoR+JkqIGInUsMZACN1Iqn6vulsEWGqbnOlFxPdaU7+Qtoz5Jx9OEawyBgHUUNUOz0uhaVB8vOLa3SXMx9RcRa/5+CbwTVWL5bhkv7HVkcpKujwOQ0JMJNS4O5BHOLRRg/+OnAbEkr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTPhDV0sOy8cHPoz8neDVVs8moaIf4oek0G9C+zDL8Q=;
 b=fDNGewECJJjN1ooAkj7rBbopHPx0x4eCuj7gs2PLzQ4AbKXHbfdAtBhXfYYt9RKCjfZ3/87ZTGdyYOpMUFj2CKbMZKx4+uNAH4+4FinBi7lA7BTJQpQXr122xl+SVYZD30QGlH4XLhKFIscCWNB0CdL1sP58uYqX+sFQoK7+Sls+9ZyMxVY9h50BTpJpSEk3D9KMmk7TXVNqEcimy5EVNhq43ky++cNewGUlzeIfqQJat+/RDhFq9pxBTwxhQ/af6XOW4xTXKd3VYpHzRLHBl7zzcel2mjrsTJkqVXJ9u4ddMSnDZ7UlqGCBd/e+mWHpiYDYuQOpBBRrFnqnvoAwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTPhDV0sOy8cHPoz8neDVVs8moaIf4oek0G9C+zDL8Q=;
 b=MEWM/s9HQzCN4ciCFXm4IDY17/+j3lN5TCAWNvOy7aG4QYDDjwlqzGdt8xi1mbRnMpAdSjqQydTjPg/rZKnTyS0JI7MVcQ5B+XmVLwVoGavbKlh3X2gjy13k7m4pEPHR4LrnFaPPBdJqhhzO5ZymNrfx2m/mCdLXEEBW2OZYylY=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 07:03:44 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::df96:2404:8ae1:8b9c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::df96:2404:8ae1:8b9c%5]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 07:03:43 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <deller@gmx.de>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <matthew.gerlach@linux.intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH tty-next] serial: 8250_pci1xxxx: Disable
 SERIAL_8250_PCI1XXXX config by default
Thread-Topic: [PATCH tty-next] serial: 8250_pci1xxxx: Disable
 SERIAL_8250_PCI1XXXX config by default
Thread-Index: AQHZTDCNxIUk480bSEuGuyNQEIwXsq7mE2gAgAD9WdA=
Date:   Thu, 2 Mar 2023 07:03:43 +0000
Message-ID: <BN8PR11MB3668FFE6503056C4EBAB9DDBE9B29@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230301100930.3519883-1-kumaravel.thiagarajan@microchip.com>
 <Y/82Ehzj2+FgIRh3@kroah.com> <Y/902nTSA05VY3i5@smile.fi.intel.com>
In-Reply-To: <Y/902nTSA05VY3i5@smile.fi.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|DS7PR11MB5992:EE_
x-ms-office365-filtering-correlation-id: 0bc882f7-71ec-47ad-7ff5-08db1aec429a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHLEG2OhHLNf94vlfM3airIAlkAnldbAatMnNYj8TJp87fZGpxI2nZawUnLrYIRr//64s44rtogNz657D81cl7k4aSfLjzh8A1gC3WrjdfLOSwmTWcZzxFFsFKnc6pw4mr8PAwsv+SoVF+r/YL15LUwhriwvpldDBVLtfT8ovr7IMUEWU6TyyDx563/G0d/ibNrcd+bHQ+Y6IiaJVSyBOXGwbNHriq04zI2NZ2ApKs66kzUDe52//UcZN/IRDLodnOpljT1LagjL1wJipdKCv0J+ADjPXdJOSTsjzFICYX0sUJ3UBp4wY8szkuMoFLQCRt2376rsPfDp6BEl1/M3JZoAc9sh5e9h1TE8fVRgxgyMYu6W0yd4oyuTsKyj95u/9360bzVGtndLjpW7UYfvuZQyKX5R3M6J+u1jOr0cX7xmF4gg38bGiE4rpxit/6gW64erqsh6uGLWUGls53SIVijgpbgpQcItbjMHKTKLSNrG3LGNEs97yIt0M3xe/H/p0Uk3Xn/DaRimAaowwgzSe6+re78za2MZbpV64CTFjWoG6D1PRJ/KWxo0A+TVNErxMBsDkj9Qw7hFP4tBMlyI/DF0SCS9uDIk7JvXInqupGMynz/oCwDEqTDA2kdbc26pEH+FrYV5ZdoBDKqEsXUvmnP3kHhsQXR8JeI29DV4FSqVcMDVIROiPuyh4GP/f1W2HkgI7OpNwnBNtTCVxpMPBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(122000001)(66556008)(33656002)(8676002)(38100700002)(55016003)(41300700001)(86362001)(52536014)(66946007)(64756008)(4744005)(8936002)(5660300002)(66476007)(7416002)(4326008)(66446008)(2906002)(6506007)(110136005)(83380400001)(9686003)(26005)(478600001)(316002)(186003)(54906003)(71200400001)(76116006)(7696005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zzExBN7dHaJK3LKJopYxU+lLcF8qW6nAUuUv0DbbnLW8cnNCCkmZgb9Thu4Z?=
 =?us-ascii?Q?FobbpDGn84AkgpLBQtoR8PWDcO9k/kKPnzc69nS6oceRLDqEoHg6ylkSFFpt?=
 =?us-ascii?Q?hG5gwsK2uHoLBrqL2Vti5YhkCtgwELkTJUlXjqFYRVx+4CI9lBxs3gZtJZ5w?=
 =?us-ascii?Q?mZS3v/HRuJ4O5467O6FBwoMF3oTm3fYyrX6FJyEqwv/MBeU74IHxl4JJjCCF?=
 =?us-ascii?Q?q3fSo26JITcS+B5rVsVCiwNe8zbQ7qmU8jF0Y4HnXzChWYlVit5XrmKqwWCN?=
 =?us-ascii?Q?0x9eD7a5av5iG5/oQRcgAA85mC1H1vIWK7G6UJ52Q9ei0OYPnBLi+F1zLoLV?=
 =?us-ascii?Q?FeA0E4lR4H54Jk+KpKSPMXk+FZi29ijRibMHPXPE/Zf4MWJgpP0jbIrWfdqa?=
 =?us-ascii?Q?XYY/CoK2Nc90bQAbCdH2L5YM+R5eVp8tHhVWlLbyu7blhmP1MEFkIlhM/tEw?=
 =?us-ascii?Q?o+Y9vAkgaMZuqgGbIBF8UVdlWChUCe0D7wBDqbuGApl3St10LVlhkUHb6f2M?=
 =?us-ascii?Q?R/JiGbPcRTU37rcgMqaK90OIfDXskqkDnlEhnMqvYY3p2KLfTrgOxS+be+9T?=
 =?us-ascii?Q?B8T3LmgvL/8Jkq+P4aqm1NEKuk2DBiU79plajbclCk+kB4omCRd0tez48zj8?=
 =?us-ascii?Q?GgGbJJqjvlB+jaC+TtDjpKsbXYMRN34I4KKKeNNyVnMMRAtfmeJPztfIdNLp?=
 =?us-ascii?Q?lzR9dCGG6q3w636aB4F++mjg4XENx0oL7L0aaJ4OH2RzvpLHj3nVzG9UZzSy?=
 =?us-ascii?Q?LYc+B/nzw5K0fNEx40H6iHuiGAwOKQZQiq0Zyy8x0eGWBBO31og0FbaS07Em?=
 =?us-ascii?Q?VXO6Qh8GV7M00fxCh7/ZMQ0YErBGxFSiq55Po5RvtHLFwPMnzElN86hAiu6r?=
 =?us-ascii?Q?nytR9+L1L6xDav8vK0jW5KGR3MivhfvSzYOsKOd3mmDRPd+GANuuBqQNoc7R?=
 =?us-ascii?Q?YJ0nSZNt7g+4AwBWhifreGG4E0Jy57Ct9s+Eu7TSU+UNgAknQp8Z26y5Wuta?=
 =?us-ascii?Q?AQ17qgJsgW2TkCXRWoG518uuFrwZ0/8SWHmhHpbl1Lb7o45K9ms4c1cj4Jz1?=
 =?us-ascii?Q?dQ68IDNu2G73SHhjCB/aEk5sIJZm9qcQ8klzwITPAsATP6w8G4w4osSNkMSt?=
 =?us-ascii?Q?apQuSioDnPU4NC06iOK3OpIR9qYG4wYQWy5oZXzapD/2RNWus2Z/8FwtYIfm?=
 =?us-ascii?Q?PQO2tKLdDxQgBKCcFSg0+zxw5t8cylD41YqqeHaexDN4wBcUUxB4LupUtLhw?=
 =?us-ascii?Q?NHl/3PjXtS6LEdGHHryvx2CkQZc23ON8liFokyDR8s7V7lL/7py558zJmILN?=
 =?us-ascii?Q?z6fBqNiqTJOzs69E3bxAOzTcD2lPtMAHSswGu2Zzw9E2yfmFT0MVfGTdW4eY?=
 =?us-ascii?Q?oiH9WVsBjcblHUHU2lTSXaKaRN2b1rzJCTQ+VWdiBujItbn7Uvrck+Sn9dqk?=
 =?us-ascii?Q?OyXWeSBDhDCFTP7F0ERfLV4VZ+8r4zNC1oMBARA0ZTXV7hS6lMs8ghjGX3D6?=
 =?us-ascii?Q?WL6Qo9AL2UZFM9xEyedd+spiw/HOKGlOqmdddR9eqctKK4nvuW3+DdmBVZp7?=
 =?us-ascii?Q?JoxJhWPTyAyZuFxPClUgCjwgbdCC+6vZyDeIUkRQPi1WYNO36vZMwfKTJGUV?=
 =?us-ascii?Q?1RQ93aTQG56L6YQ85tIDOuQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc882f7-71ec-47ad-7ff5-08db1aec429a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 07:03:43.4926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfPxogUOVXa7hGiMhQ3x3+NgWGYveYFadmvpSXKbeOavzS/JB2ppfGLtZvStZRPtb0Hf4iDw2ucPlHDnaKXG2Qsij7HqiMWTodT9gHoSzOK/SNwFl4z0QnJ0gxt/fpyt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, March 1, 2023 9:23 PM
> On Wed, Mar 01, 2023 at 12:25:06PM +0100, Greg KH wrote:
> > On Wed, Mar 01, 2023 at 03:39:30PM +0530, Kumaravel Thiagarajan wrote:
> > > Disable SERIAL_8250_PCI1XXXX config by default
> >
> > Why?
> >
> > Please read the kernel documentation for how to write a good changelog
> > text.
>=20
> Kumaravel, hint for you: Take what Linus had written in the discussion of
> Greg's pull request. It mainly explains it all.
Thank you, Andy. I will do this.
>=20
> > > Signed-off-by: Kumaravel Thiagarajan
> > > <kumaravel.thiagarajan@microchip.com>
> >
> > What commit id does this fix?
>=20
> Another hint: this lacks so called Fixes tag. You may read about it in th=
e
> documentation.
Thank you for this too. I somehow missed this.

Regards,
Kumar
