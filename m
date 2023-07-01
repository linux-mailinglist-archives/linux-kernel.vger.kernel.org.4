Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59650744796
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGAHMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjGAHL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:11:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165F63A87;
        Sat,  1 Jul 2023 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688195345; x=1719731345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1BBxCO7wIDy0+CCLOs9u54L8g3EB5NTn7dIoqxQnJjc=;
  b=XoOuZrlFXy3eHEIEPdFAw8Fqcudt8PsDxZSd9IbF+tht2ckDCLUtolgV
   Q06j8Ln7iiN4iS4R1bq3BF4GVJyc8PnUhHiNYXhGYoRC7TJs0NFxNH+Is
   10za8j3iwVLmgiVy94XZhFG0aR+4w2iu64RcoVszsnW6m3LQ4WIOdpmMB
   SnCErbk0FRNvHBClr3+40A+0DFdszlVyZ/XJ9/pwbhkKNExhoJMPxz3Aw
   s3loQbwdGsvc7Y/HfpGoUNS0/VAbaURs1zqpBGoXsZoOx1+I4OibX/d5p
   vSjhb48XbRatcLCiab/OCxcLeM70B7bysGSVbvRruxngDb0zclAaPcWBH
   g==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="221530355"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2023 00:08:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 1 Jul 2023 00:08:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 1 Jul 2023 00:08:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0I5vSJpzoEHc9an/PwaxPP9NFiL+v9s6Pg4XGf7GWzsGIEgfSAAgDZ46m5Rsjg/mQRE7lulx7TA2/yP3YEvgAevMgFp+v9oJReXvHt0UdfKO0ELd45sjdW/za7PkZJ0oTbFn3D3U4wplVLUVAS3BzqRndrBqumHHJeUK0GJd6OJ/DoXUSoglGOD3itv1SzVawPJMJNznF0AQv6V7LJeeZEZXZ5J/pf7uss0b9NMLk1SQgI9ICI0NTu7/U7UeFBKK8YNrujOd/63lJTYp3Z7nQpWO8hbVYwkB5iweVSNNhhd5KWXBNNfjpjO99VMlwlgpCb1c8qlkGz9qXc26ybWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BBxCO7wIDy0+CCLOs9u54L8g3EB5NTn7dIoqxQnJjc=;
 b=gEN7F2AOOwFcdshaRShvCSGYxDrZZe0blSAQqDMxatanYukHG93rR1BS10y6DjH5PdgdYC1+jhEfbniEv8dWf4Vg5IZR12exdDoKiy08lZiveVlATC1hWc7gNG3dzKoqWDkxEpo1NgOP3iOMuZE50N2U2IEDCTok5HI4as2pzjynHQvdOS4lnna3UNftS/82qlRINzUV2wUGMDPutFcCSpfYRG4oQ7vh6gUakakZk0qEEH+19+cehNhlfyC1+PRzjVaunuX6iBsSN/AQEEd+Z79vaNthfsoYDcGwkHtG0DykBEttpdeNUkSUXJYO0cQLBQtN0JSiZsFPIfhlPRdhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BBxCO7wIDy0+CCLOs9u54L8g3EB5NTn7dIoqxQnJjc=;
 b=u38uGWl4nMsfIZ75nGNqhRwGM/1b3B95l/d/bCb1OHkf8zMD9Y/tU3mXxt5BQoJEwQY0/vVJzPBsGFB0gIQZeAWgZ9FpRiP2uB5Wek8wp8daawCoBjbkfhGq4w9NesUuXviDcArpWAc+Sd22Ch4OK2jvjwKNUj+0fEaWmn6RNbc=
Received: from DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) by
 CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Sat, 1 Jul 2023 07:08:45 +0000
Received: from DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::128f:5f67:cfc0:b1f4]) by DM4PR11MB6238.namprd11.prod.outlook.com
 ([fe80::128f:5f67:cfc0:b1f4%4]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 07:08:44 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <arnd@arndb.de>, <Kumaravel.Thiagarajan@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <michael@walle.cc>
Subject: RE: [PATCH RESEND v13 char-misc-next 0/2] Add OTP/EEPROM
 functionality to the PCI1XXXX switch
Thread-Topic: [PATCH RESEND v13 char-misc-next 0/2] Add OTP/EEPROM
 functionality to the PCI1XXXX switch
Thread-Index: AQHZo4SH09Ugvlh9bEKSzTSqsM67mq+YEyuAgAxy27A=
Date:   Sat, 1 Jul 2023 07:08:44 +0000
Message-ID: <DM4PR11MB623829DD125CA15D628FB4B0972BA@DM4PR11MB6238.namprd11.prod.outlook.com>
References: <20230620143520.858-1-vaibhaavram.tl@microchip.com>
 <2023062354-rejoice-preschool-5251@gregkh>
In-Reply-To: <2023062354-rejoice-preschool-5251@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6238:EE_|CO1PR11MB5041:EE_
x-ms-office365-filtering-correlation-id: 7f917957-e1c9-4806-876b-08db7a020225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBmUbgE8aavKwJA/fwm+4Z+1tgMpLMiNbXTyAD2Qvs+kCAOX3qE7YFVLAxWr3NUEXJaceHMPUmI9e1SmUNHJvMdDStJCJtnIWs0WTbev3KJLJDkSjOamGAVz/WNuXEY7VghwA1Quk8PcMLMbpaLugfVnwUZWcjfRUrjk+B3imZpv8iLpfV+1bLco8ed1KL7+Kqmb01sJHRzo10BjKt0AL0GnQr/g6cB7tw6NnRurpJHmSw7v96xGqZFfANsmmieWlEelFGTTJbCv+SZsCClBQoQHsoiiIFyYkDoexl+fFMYufJBgZmZS7kzWxK9H3L77MuQAzR4EdYUU712sT9GrbArXXgUNM7MQVKG/xGhqXdjDB9rSDJQwTSHo3eiFatpUXxb2E2DUcFOW2kZvHbbl612RPmAqDas+yuVdLvN1JCHi8wTVatlkXeMkBQh1Ox9/sO67UFbNMLy0QOX/xIjglv7AYhYJBElcQgvXpdAfbev1XbTK7m6g0I3Fm/NAzqQXr8l8xP2syzd6Y0MF2l2WowOXpbByxFQvUdrqQyHu/0wV5ASlNTPRzFekhuosmMj4LYeNCVY+qf9ID3IJyf4LdvOEeJWxfOk6apv/v3zEL5ut/OhebP1ebNcEGM2HvEM21WTcHP5AJ6LyjhqjuAhKklbHkgedRm82yh4f2FSygApUZ0RXR6P74VeUkGgk9qCZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(6506007)(76116006)(316002)(38070700005)(66556008)(66476007)(66446008)(64756008)(66946007)(122000001)(55016003)(38100700002)(6916009)(4326008)(83380400001)(186003)(26005)(9686003)(478600001)(54906003)(2906002)(8676002)(8936002)(52536014)(5660300002)(71200400001)(7696005)(86362001)(33656002)(41300700001)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ce1YTVfjKgauWXyg0EQmrDvZ7ErFnjIldZUX0MDkbUqcAxcWfD3egTeGw0s8?=
 =?us-ascii?Q?JJaou3FmZUaPsYL0Lp6pHEV/Lw95XQEr+PB+7Y0g2d/dX9AqLhnCXUNwo7Xq?=
 =?us-ascii?Q?XkA7noRGZdBRerFyXKddY/9GYX7ohf8dQHVBhAVUQczYdmOweZVK2q2ewytW?=
 =?us-ascii?Q?y5C96XRS0Wjvj2fHYZ8Ev+v9Z+3weRaitSdlL9hkAujCuzQhx1R+dEDuSpZ+?=
 =?us-ascii?Q?93ToK+CjKdeRqcvJ1yDrvDslQS5CokC8qyhFwleLFILQ3say12PWI/PoHu60?=
 =?us-ascii?Q?+PwUIb7nFsUsgLMDUNrGOKq5qwhgqgHd88Xsy8gXAvUFF44AYe9Z4KAM+tb6?=
 =?us-ascii?Q?aiXxamhjExnysTa8IDm7DVBAgBHdm4TeGdCj1O3F2cpFoJdTHWtkuOlMCiuk?=
 =?us-ascii?Q?/BnngS33742CEBFYja4VhEOF1l62fE+hMpIc8p8o2k+QEJyiF3XkydutX8Q3?=
 =?us-ascii?Q?7UaAuQfwrLweDYUVayU3fEjrUau+LEu3F9vAgyQ6xpU1av3bhg92lyJXxTBe?=
 =?us-ascii?Q?WZmCDOXEAALeexKp26HrQYMMucmOzhQL/enBz3B4y/fhz/eVqbszhmT7fQ5T?=
 =?us-ascii?Q?JlAyM2PDIfYn2dRIEvoCD1k1zLXpWsQqTVSgbEmdxRq6d4uJ5kSs37raCqOk?=
 =?us-ascii?Q?QGfLPShS0eH3IEktT+wN0ThWva0o4xhTAyRMbo8sSZuBSuXewHvlB0yBwzeV?=
 =?us-ascii?Q?QonuzI63/oIplwuJyOYbUiESwZxgrbfa6c+xkGpSsjgzHIX1HGuP69eNijRT?=
 =?us-ascii?Q?MbUQnfMiJdPKgjCWIATaGMe7kT1fWpNGpHObiUhdtiv8IfZ8ozzouHYNbjL5?=
 =?us-ascii?Q?N4Rb6zpKPjEiBx33Oo+MNC9yW6dc2JzK4eK0XMPc4+ciN78IBHOJUkGFXBl9?=
 =?us-ascii?Q?xCgEhxtBMo2lt+jBRtoLlGrNg4blrnY+aSo/S/c/CgR1vAL8Z3jIcNr3DJ6m?=
 =?us-ascii?Q?oS/UmGnW5eKy4PGmDM4XNoE1/TDP1WZ/fzog2vMUy5TNgeWsCjMhnJGqFiVo?=
 =?us-ascii?Q?reTbQ+8tC+joOjaFnivFwHpyvCsP2+FqDzTemPiB5dWoqP679BHhj1fIoUqD?=
 =?us-ascii?Q?aRlE+jxxZtdbPto6YBgWz4Wndwzijr14fMxNw6yV0eRO41WnXWn1qTCDQLUR?=
 =?us-ascii?Q?mBgCfDRkzbp2WZV6hs6AVDfV+JoglCEWcGPSerB8Lt7ugKxk2Dhzi3jnxWuN?=
 =?us-ascii?Q?4aH59jAnhIJP2433keneWa+lkHmBReLqWuSejPwgZo2JtQS7UTUF6C0LHcxe?=
 =?us-ascii?Q?T+bZd5LGPehFN4n9bcIVdsLMEnxzRYLF+KG7znniF3z5y9VXxbvXbyooOYHQ?=
 =?us-ascii?Q?VVasspvFqlZLFTIsP96i5JvbuoHt8xQA9ZtRIbBVCeoDrFEYIMy92Ev+4gDh?=
 =?us-ascii?Q?tzWJ7ZmwmkqezJ2HgnXICIHx2MHnI7H8QCkdVvr3X87U8/No0eqa3VjB8Fl7?=
 =?us-ascii?Q?pchgbpz2SO3pyjCrhwptIVhIdY7W0TRSoKvrllkdPtyeJoqDWta7p9OIarNP?=
 =?us-ascii?Q?qGfWnt0Eg/vVlioHPqbK3I+WTn0cURx8E9AKiVarZ2u3R03WIB7dkZvrgdis?=
 =?us-ascii?Q?kWGeJMN/FmWdXtNMUrJDaXJ0vTXASbggU9/Dsfkshxpq6J8W5Z9RRyL+1Hg9?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f917957-e1c9-4806-876b-08db7a020225
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2023 07:08:44.6990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/iWinrSsVnnAhC9EQs/lwPSFuIaGZbx+Ii9PNG21uQ61lgW5zL0DjrgLg7KKF+a64T/j5VUucesakksQy29c8bsYPegxtDvQhcsgCnOyhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 08:05:18PM +0530, Vaibhaav Ram T.L wrote:
>> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,=20
>> industrial, and automotive applications. This switch integrates OTP=20
>> and EEPROM to enable customization of the part in the field. This=20
>> patch adds OTP/EEPROM functionality to the pci1xxxx switch.
>> ---
>> v12 -> v13:
>> - Moved release_sys_lock() from patch#2 to patch#1
>
>This series is not showing up on lore.kernel.org at all, are you sure it i=
s getting to >the mailing lists properly?
>
>thanks,
>
>greg k-h

Hi Greg. I too can't find the root cause for this issue.=20

I have used get_maintainer.pl script to get the Maintainers list and it loo=
ks like this:

Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS) Greg Kroah-=
Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS,commi=
t_signer:2/3=3D67%) "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com> (supp=
orter:MICROCHIP PCI1XXXX GP DRIVER,commit_signer:1/3=3D33%) Kumaravel Thiag=
arajan <kumaravel.thiagarajan@microchip.com> (supporter:MICROCHIP PCI1XXXX =
GP DRIVER,commit_signer:3/3=3D100%,authored:3/3=3D100%,added_lines:15/15=3D=
100%,removed_lines:1/1=3D100%,added_lines:3/3=3D100%,removed_lines:2/2=3D10=
0%)
Tharun Kumar P <tharunkumar.pasumarthi@microchip.com> (commit_signer:1/3=3D=
33%) linux-kernel@vger.kernel.org (open list) linux-gpio@vger.kernel.org (o=
pen list:MICROCHIP PCI1XXXX GP DRIVER)'

This is the command I have used:=20
git send-email --to "linux-kernel@vger.kernel.org" --to "linux-gpio@vger.ke=
rnel.org" --cc "arnd@arndb.de" --cc "gregkh@linuxfoundation.org" --cc "kuma=
ravel.thiagarajan@microchip.com" --cc "tharunkumar.pasumarthi@microchip.com=
" --cc "UNGLinuxDriver@microchip.com" --cc "michael@walle.cc" *.patch

Is there anything am I missing?

As of now, I have sent Patch V13 from Kumar's email id. Kindly check.
Sorry for inconvenience

Thanks
Vaibhaav Ram
