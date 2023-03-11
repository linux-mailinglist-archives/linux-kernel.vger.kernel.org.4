Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A046B5981
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCKIbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCKIa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:30:57 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C5412C832;
        Sat, 11 Mar 2023 00:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678523453; x=1710059453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w4zGJfzQ+4KpdpBApWLjNV0dRfHDchX74OpwBBYH5LQ=;
  b=exZ3ueQKSXnI2cHO+UGkhcVwPdmRjd+Bex05x0DaWjttfApjT9jYtaAK
   Q3xUgzTlIoavs1WqSd42AjEzAPAc55RMeTvYo6pVyrv5uSucyNOWqCbjG
   Cp6wtY3k+cK1tpCQFXle5tw40cO5BT7ZrtEP1qIAmdfZDq8+wXff2NboI
   Ex8T8LeBE2USuifLggpBfBSBSzFlDVpva28OPZW9awHvrMtx/vckepB5O
   sRTFZX6zFnbuw3uvR8hPR6vefJ2vO9uE21EIHkVXfczF0Nxe//GBPpJMf
   xClfgvu7tR27sCaEcb77qUpb1vcllKhxJ8kRhlNJ+WLSmbvDvUV14Xjwk
   w==;
X-IronPort-AV: E=Sophos;i="5.98,252,1673884800"; 
   d="scan'208";a="337379581"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2023 16:30:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHhI4ID5lQmTb+XHOcxumNwRS+KACiS3l9JTMdSLi6Vk63uIPDoBRW1K2kdjiZbmOsf096vAI7RzycSk6fSTPNbf+dstcvRLQDW3h+5LW/Ar1eRsiKdHv4kXOb1QLyXm9Tnm5aXoTcvzJ9yVmPdyRjRmkAimpyoWdBppIpbCE6tAqkW28URdaqUdQphBi5RPF1cGo6KTcbiCdhwLwT8m5Uhh/biI3pMMjNQlTcvCdlvDPb6dPtdCyZjSoYVhOXuPT/SjtJRtzuhaBMjHOmrXw3YPSuvBY7ianoS0l7LVEknbOKVThoR9qWgFxYGbObn7sw+25km8ugKSSJOrAYyjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfnQugV6unn+PZ4nr1IfkVOeIDog65RzHf74l+wRi+U=;
 b=iKi1vbwy4EgkqZ08ab01fp4UV27DtTfhxgGJrgObSvsfQPBdRVsQrMCn6wdIf3Uh7qRbXIb1i+6d1NL9XwTIfUbhw2ZuOEFkGfSwfXb+H2f+lzxTSGRzYBtUuSq0nT+wpmIGRJtq6BuOmeY8bt8iga+3ERXjtChoLrLF9p2AO4YHWVYbFgpm0w5OE6e7NY2k4E6tm5oYz2q7vm+TYAjULc94xmCT+3sa2Uf5MR1nqwKMCKIulZa/FYqFxdXvT4OlZtvNuYjclw9eotqW66WuQtojj1JHFBuxnxK+U0zkm4bNh2jOl73HU+9ILzwxHVesKhHO6LIarMte3ftHyCSYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfnQugV6unn+PZ4nr1IfkVOeIDog65RzHf74l+wRi+U=;
 b=NTlRnoq/wk51q3yyTNvgCVsjuJJzv5lMOQ+JA/87EQnk6sv0s78JUu5MLvs+9ZH61LV2RtjyodUFLLhCsLYsijuEufpra7PJrLwI+Vmvn9JMT5uVZx+Pvn7DeB0CO/WhYPHztxEJdURn0VFwL9/qsElCzU6j83HRw692YHZzmVQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA2PR04MB7689.namprd04.prod.outlook.com (2603:10b6:806:14c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Sat, 11 Mar 2023 08:30:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2219:5d8b:8a1c:944c]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2219:5d8b:8a1c:944c%8]) with mapi id 15.20.6178.020; Sat, 11 Mar 2023
 08:30:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Topic: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Index: AQHZTRVlmdiu5jdy/kOzGvaaPem9+q70EoYAgAE5B0A=
Date:   Sat, 11 Mar 2023 08:30:46 +0000
Message-ID: <DM6PR04MB657539A7A39992CCE996EC7DFCBB9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com>
In-Reply-To: <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA2PR04MB7689:EE_
x-ms-office365-filtering-correlation-id: ca3a4366-920e-4805-c3bc-08db220ae955
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+4enJ4zPfB63bNQQZDdq6SRBPMfrQRC/EnDUmrXenq4I+39v/rrQwHrogoUuf+W/UDs5VkTO2ahQlPXEUfXrdSXmZHsAoBTf4md8rvd6SXOWA1Nfym7rjef7/rhLzlgMjbv+O/k9GvmNIVgDfO+X5MUz5HWWtOCw636Rp3zesFEU6veULY0Gr50ExfdyOhaSt1TNr/QKKDQtP9y5hNecz6tcb6CRFiYcSiG/QHf67LPcJT+p2v8F0q8fhmUvEwBLNtwbUO4St4LY6xO0Pw3Wcl3lCOYLgMOyb++SGeg/KC/36TJ1g56H88KRM/13Wllx5H2VYE/3yb8jdmCrJnnakXxzjOT9VUeda+SMWZ2jmS8r/Kp/FdvG6uA7SvE0iluHWtYagFoALCYXl/Xu7fTNhCYc26xaSNKLwJkQrjVJRlkXVlpKWjbPf74qGH8S5i5KKo/v6DVId6T+26CXGYYC3JPw+6/uXJ3/Ga+PldPHDlYopS9GtYCNCeZcWqIIqBwJCnaKXQrTGKierQttc5iO3jiCP9CECfrKG8dfr5Sg15roOzmQj0mkzT5zgIf8gpRdIJuSBYWBd0KB32edatR7IR43BYQ6GWUIc3E9V1T22PVTumcz7PiYrbcR4Qp4Hf2w+6pN0PAGdoMN16JGpxrNXPOVsdYgpSmmX1zpDQrqJ4/XG3ekTTAKOul/4vSNoKc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199018)(33656002)(110136005)(54906003)(478600001)(76116006)(966005)(71200400001)(316002)(5660300002)(52536014)(66446008)(2906002)(8936002)(64756008)(66476007)(66946007)(8676002)(4326008)(66556008)(41300700001)(82960400001)(55016003)(122000001)(38070700005)(38100700002)(186003)(7696005)(26005)(9686003)(6506007)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vRypjZ7UCkJNoqecut8jhlViYJjt/n+gbwHT9mKyslTaYyqK6Ca7bSd8op?=
 =?iso-8859-1?Q?HXpoldQ83IzlB/IAXbHtfSjWLKY7jPSqA4jXYE3BwbwBqp1Hpa8T3dweGt?=
 =?iso-8859-1?Q?0XY9Dn0UEigOTVSSAs2qvjjrTc+CS+GTnnNQBwmSSfUrXQoB3YXm00zK/z?=
 =?iso-8859-1?Q?+WSzDlSMqMwk5/K/1mwdikNW9CFBuPbpxQZ8gu6T6xJ+1PmckcAQOCz7DZ?=
 =?iso-8859-1?Q?2hJDn4/vl6a4DdE2EyABMioy3iZK1AETczshez1QnSSpjhRCkQh+Sx+jmL?=
 =?iso-8859-1?Q?lJ4N3qieShwTthfGAckfuem7csGlFqaQKnvC3LKAF3+M9GaxzsJKNSz32L?=
 =?iso-8859-1?Q?GLNms418yPsQ1ABn/dcijmf0wZvOTBhGPOxhAJ7xCWwXDahbTE6TfAjINO?=
 =?iso-8859-1?Q?jw9kUb8xCM/htFCxAmoGiJAoJMf8HrXazczgizVZcy6MZ75iQehJtuq6dl?=
 =?iso-8859-1?Q?b5M6RufGjhqtFnxnEyL/qFmgBC5eYQz1RyupnIA7f/nS49ugIN5Pic2Y6V?=
 =?iso-8859-1?Q?nA8lyI+mCacW9w9O1x1yE92AjAojEsQPbsVAn8RtjZkQeXavlGTogSbRdY?=
 =?iso-8859-1?Q?kWUd0a9DVZFCZlWzyfe82gAhUQsEc3B/4q/+gyhoZg4iLBExmcE3LSTl4Z?=
 =?iso-8859-1?Q?9mfEmZi/aL494iXtD7PYhA0NU3bJK217qP1fSuB0+b5QU4p2B43ucxDVSt?=
 =?iso-8859-1?Q?qnptYMyK552W/Mt4qEASIFS9CCk2lyLsbBs/wSvCCKyyTmJ/tXJUgcvfcd?=
 =?iso-8859-1?Q?l8Z5ZQvXPZB1Gw7+760mTj7jP1vwNhnb8NNJR1NxzD2RA92+hCnwFn56MS?=
 =?iso-8859-1?Q?oatexMRJtJLJsjxjeyBZ3FQIFf+WpIHzFRkUoXUKFhMSiWwusyEGB4UiEG?=
 =?iso-8859-1?Q?eJAUKhaUv2HF7kim4JVvTXO0ADKmY52BvnSS35xUMeYVYy7l0QbJwQi1Ts?=
 =?iso-8859-1?Q?y6swQH1XwAVsq4K+1K7B227ShE0q5Grug7eSNZqNTf+LsbY5VU52bah1Vh?=
 =?iso-8859-1?Q?uNMPyFKoHLkP52rmuMVmvttAhSHojexIHh6ZqJlD13KHm7dRAowVOiO5Ir?=
 =?iso-8859-1?Q?0IjHYBSfeDZm0citP3/b02xoIm8PpcPzxg82EKC/fQ78fBgn6NrN6dYgsC?=
 =?iso-8859-1?Q?e+hpOSXkJ2udR+oo2M5sfhajEUS7QPzPSiaGd5XT8xi5xnuijG2wQb5Wmr?=
 =?iso-8859-1?Q?SZtmOYl04QDdr5vGtVyylMXS4r+uB76aNk5R4KlDAa7cUzIJxfMvo5zU65?=
 =?iso-8859-1?Q?Ok5/KgJknxIz68LV8dGiwDJOutMZSEPg6uMFV0GXnoP2vFO9vbu3PgGsSP?=
 =?iso-8859-1?Q?WCmtJ4aRbOmtcFR8hCqB7NmT5KjEC/lT22aSq/IFzN7tGGr7YRAOVCEnPW?=
 =?iso-8859-1?Q?Lgj+xLvjoL0LPGgFcdoI56GOzc07Q6MdzqBxP/Tkkl+Vvp7DdbdiFfNdRl?=
 =?iso-8859-1?Q?kyb0zyQ++pw2c9HlL1hB6mKzLOHtiqYBRF3Q6KxLp9lmv7Kq6bebhY8keG?=
 =?iso-8859-1?Q?K0ipGKz/Y0DTHpVghh/yFlhOLQfVfm0r0LFtBF3O3NFthXCIPZ5Zhk5Z9x?=
 =?iso-8859-1?Q?34pdfng03ancV9PdM42kODJsPuMWbO1jvtSxGpqr9sp4EBDRxHGGS+jwwD?=
 =?iso-8859-1?Q?yJqov16KO53+XnNgr799sZaT1Z5eZO41NJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 10typyFb0obN2wj3SQabpDrNaIClEpmvPU+BisFGPwZdJF5dkD7dW4vciuqApRAWbM8O63STjoWB+OkMquG0yJ0DBWUTLh0dAgERbYphsJaKtc4pTVpVsmi5lQ5TiaFcM4bioRnFs/Xuv8w0viS7AHY75kTLpRVhsNp0bZQMUsKDsRMnVYxbtnPSxCzk3JVYJ/veU9IXaNuUVP4mKXCkzDPNaR+jKa4A/uwN7CuKGAujaZTnvvdBtaoM8ubxbL/HZgMmlTJruvC6BnUDNMWTTskDe54e9q2xx8JBQe8WHutQSvL+6XH+cjJU/fjMbjzSrh3gHaFPuejndZAeEi/u0yBrktDjL89meJOziVV+ekLSWDSSd+eiy44108jS70cebXF8jdaBFPfScIoXIIXm0qnJhFLmOvnbopTs9bFh3tWuyjuRITavk+xvEFDH7lvH1KIr/4mNDMAXQTGLnJAydExQPRWnN/QTNosjX7nuw4JsAt7vM8AWBsuhsqYsffb2Ljr3xtRrIWqF+tAhXW2rkoisT0/xXUAZhMRMlAchy5EasMLp5GF+6kPzTzpb+gdAztYhwLDoWnhp6cJgzswRuLHSZ7Z+Gw1Rzbj9NiSz2pOMTFveuAAx9MMQJFK80BBxZ6sJxKVE+JR4utOW5gVKjA1wUBYBs8u6VLI2YlUYpKBcUxyjbOYFZaELR/itxNcXUqjC+Gmo6jd/CPlgLAKCFJl6yrKLGtOpWVqMII4+g5eJPsiyAIVDUBqDHlzGUajHV6CKxEIl1mZro4NuWOKKocIQ/Tej8MJgRokE1wNM68ocsJTsg1MWvwmTPpM8oKj9RvtEU6igdRQ5nt2QqFjhE9omObRJXXdFC0D9AbmWgLtfwXCjDsOvpoeDDjkeP0tr2BusdtaSpOi/eJ1jwzBCdNtgSee5ot03evlUPLw5GBk=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3a4366-920e-4805-c3bc-08db220ae955
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2023 08:30:46.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Swn00OXcBoPQafiiuDBNufSp6ciUe0Jcoh0FhiA9CoJt1JUmUWFeNmWxv8BnIOMSSc9iIu6MFh41HHPgclgnhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7689
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> I have benchmarked the FUA/Cache behavior a bit.
> I don't have an actual filesystem benchmark that does what I wanted and i=
s
> easy to port to the target so I used:
I guess I'm a bit late here - sorry about that.
If you happened to have traces of the below runs - I'll be happy to provide=
 further analysis.

You might also want to look into fio which allows you do write to a raw blo=
ck device,
And has various sync options - so you are much more in control of the paylo=
ad size
And how many reliable-writes / sync-caches were issued - if any.
 =20
Thanks,
Avri

> # call with
> # for loop in {1..3}; do sudo dd if=3D/dev/urandom bs=3D1M of=3D/dev/mmcb=
lk2;
> done; for loop in {1..5}; do time ./filesystembenchmark.sh; umount /mnt;
> done
> mkfs.ext4 -F /dev/mmcblk2
> mount /dev/mmcblk2 /mnt
> for i in {1..3}
> do
> cp -r linux-6.2.2 /mnt/$i
> done
> for i in {1..3}
> do
> rm -r /mnt/$i
> done
> for i in {1..3}
> do
> cp -r linux-6.2.2 /mnt/$i
> done
>=20
>=20
> I found a couple of DUTs that I can link, I also tested one industrial ca=
rd.
>=20
> DUT1: blue PCB Foresee eMMC
> https://pine64.com/product/32gb-emmc-module/
> DUT2: green PCB SiliconGo eMMC
> Couldn't find that one online anymore unfortunately
> DUT3: orange hardkernel PCB 8GB
> https://www.hardkernel.com/shop/8gb-emmc-module-c2-android/
> DUT4: orange hardkernel PCB white dot
> https://rlx.sk/en/odroid/3198-16gb-emmc-50-module-xu3-android-for-
> odroid-xu3.html
> DUT5: Industrial card
>=20
>=20
> The test issued 461 DO_REL_WR during one of the iterations for DUT5
>=20
> DUT1:
> Cache, no FUA:
> 13:04.49
> 13:13.82
> 13:30.59
> 13:28:13
> 13:20:64
> FUA:
> 13:30.32
> 13:36.26
> 13:10.86
> 13:32.52
> 13:48.59
>=20
> DUT2:
> FUA:
> 8:11.24
> 7:47.73
> 7:48.00
> 7:48.18
> 7:47.38
> Cache, no FUA:
> 8:10.30
> 7:48.97
> 7:48.47
> 7:47.93
> 7:44.18
>=20
> DUT3:
> Cache, no FUA:
> 7:02.82
> 6:58.94
> 7:03.20
> 7:00.27
> 7:00.88
> FUA:
> 7:05.43
> 7:03.44
> 7:04.82
> 7:03.26
> 7:04.74
>=20
> DUT4:
> FUA:
> 7:23.92
> 7:20.15
> 7:20.52
> 7:19.10
> 7:20.71
> Cache, no FUA:
> 7:20.23
> 7:20.48
> 7:19.94
> 7:18.90
> 7:19.88
>=20
> Cache, no FUA:
> 7:19.36
> 7:02.11
> 7:01.53
> 7:01.35
> 7:00.37
> Cache, no FUA CQE:
> 7:17.55
> 7:00.73
> 6:59.25
> 6:58.44
> 6:58.60
> FUA:
> 7:15.10
> 6:58.99
> 6:58.94
> 6:59.17
> 6:60.00
> FUA CQE:
> 7:11.03
> 6:58.04
> 6:56.89
> 6:56.43
> 6:56:28
>=20
> If anyone has any comments or disagrees with the benchmark, or has a
> specific eMMC to test, let me know.
>=20
> Regards,
> Christian
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

