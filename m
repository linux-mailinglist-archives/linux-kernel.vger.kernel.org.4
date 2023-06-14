Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA572FC22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjFNLOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbjFNLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:13:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2461BEC;
        Wed, 14 Jun 2023 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686741201; x=1718277201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gcHDrOy0AOTLaT3jmGiIVAZi7BeomDzYvMe8+hBefVU=;
  b=cgd0ALhlf095j1tyPIK9/5LgpvjreBGKaR5WXB1U8uLUhK1HjcXc1y6o
   GaG1wOeweO92VCl+Cjuq0LJEXhM5Gg4oP4nvJl59QbdARsmhXqFbCVcuh
   JTIa+GEjU9vsNcAtz4klam6sxGWx7j3M4thbSb8XG8tK1U3QHSTQaNuZG
   wJqv6FjlHTCUrHAlmcxqVeVnPtQoN5b63I3rDVWwxGuppe0njDsBZdEVN
   33AvvfTLsnsi2fFX2PRWrOxc3HL1zmW+gEsgVIfPnJZouEHHAkZFQEqft
   bAjcHA2NIsk8IrTIGhUROCZwuFyOsHunuNNDaVT9+Lp9Ob2/v2tp4fgoT
   g==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681142400"; 
   d="scan'208";a="347220311"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2023 19:13:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obEzAXCECr6tOvFyLn1MDsY6Qe25YUG10sgH5Z9EbsMDqhC9OiMsQ1nbMEpcuhO3ZJA0qD3WVJGQ4/ptSt/+g0tO4Se/5qQVPDB+szKzn+VUiysNGtPFLwI0a/b9XJe+ulpdRf2x5rkoLVhcQ4OExJ93qMVCykPUomo5254fOqEHkM+AENrcUP9pAoK9ZMpp3lLZ6Og0wDSsmqzXcLYgk1ezYuVMtJWilxBOV7nA1DhKvqhOxPUpOtSIweBNdTDBcTgfakow0SPk1HIsEj1Th9MBlzCF5CCi2WGzgfxN2/k8zz39SlAIhJ8csKgtXaRj2OU/mI62EvfWdE12PsQ0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5qzwJrUjjtPTiScrR92jeOuAzgN2e420ENJ6cxQ2uk=;
 b=BIVwMaGSL6HTmCxczCPEZyW6EtchTQ9bmbuZKmLJ1hLGazfaXoAWUAv1GFtZrK+ElqDs+/h6vGGXJahxRGF+qP3+FcaS2rHe4/RklTFr9ruuE7NRcFI2lQa480vN3vYqZLOPiZmLGaY5s50vt4DlrDN05kZy4tez8JPtinCHYWP3UHnt7l8nQu2HkMGv3p0Sb8MRFGpWEZTtv2ZAkz648vo06mtc9Gdi0ca+juGJ0TanovUgdo6h01bcrFRHD8A76mBRlwcbjkS/0kSBhMJmioR/z8x8mJHiO5/7ZE+kfbzuh9IZfeZQPsPPUAko2UyLFCsODCgHLgK7pmD5mKHBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5qzwJrUjjtPTiScrR92jeOuAzgN2e420ENJ6cxQ2uk=;
 b=aOJiVyxtKHormQOWt4rO41RrGQFRfL92mSVj+dpcxVc8GbNuAQKipWOlcRpvzDY1VBTgAoIjMthoTSp95Q1+RPkvO/Px6Y8UFdemTbKdXH98QJWRLQXckxQv501Ehm9//QuZk/xRN+2whDottIH6FaYGtoaJpXBpfdKQmjnL/Co=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8507.namprd04.prod.outlook.com (2603:10b6:510:2a5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.38; Wed, 14 Jun 2023 11:13:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 11:13:18 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1] nvme/040: Free loop back resources
Thread-Topic: [PATCH blktests v1] nvme/040: Free loop back resources
Thread-Index: AQHZnrE4w5/2y34gjUOOvl0fC4wVwQ==
Date:   Wed, 14 Jun 2023 11:13:18 +0000
Message-ID: <bsbx3i3ut32zbatwrpn3t2vjbjdmttqul2jt7opd3s4mipo6pj@5ojtsv7aunbn>
References: <20230612142945.10969-1-dwagner@suse.de>
In-Reply-To: <20230612142945.10969-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8507:EE_
x-ms-office365-filtering-correlation-id: 93de7d42-5d53-4ec2-5f06-08db6cc85b55
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o1oDzN6jcafx6IheyRW0Oijgblq1WZmVqjXCaZA5wnv0epJf8yY1nJXmsHwOS2gWU1mY9PTqnF8BZ0MKQubLBM544QTBXn9+XS8Ewi2MBocBl1YdgKgX1hK/mBonhwwY9JR7TWgfWF4JZqO3U969OpFZHE/vdLG8nXe2gVRQwdSKhEwLdfGMVYObjy6ihovxKRvRtG4uZfFp2tNDyXCDdLZ5QBpH4lZZz1qQJG0Rf1OluQ4/0kq4QKn/TyDncqNl6MfEsouiUr7l5GoBQcD4CQMRfEaPTqa2Dd0VO4/dO3+NIMjjcUT9Xw4FFJpxOhW0oC79K4QhkuoIgcWMxrBay7NiNqVgw+W6OzKAfywN/2ZNCQZxeeQQ6Ffu6MO8pi/gOlFrs0eCNHaSiCJe02THY/edHI2vbA3Xa7vLt55Mn0c3jWtQjSulKuD3ScGPWl75B7sxDupmEXuTN2YEaX48/nSB0T0cjI4zJtNfUwmXfVDZjezTF3xR2YMJGxiAzTHcHTke/LgRKPKW2vvzPwOM420vlU4+ZpgIdaMgSnY8dHRLOjB7/Cd6XDvmhfg3cba6Q7Y4MTqpLp1a/hW73UYKqA4Pl6IS+uZZzkkNTXX2C9M5gJH6MWbFfKro+ajLzH2t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(8676002)(8936002)(4744005)(2906002)(5660300002)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(82960400001)(76116006)(4326008)(6916009)(122000001)(91956017)(38100700002)(83380400001)(54906003)(41300700001)(33716001)(478600001)(186003)(9686003)(6512007)(6506007)(26005)(71200400001)(6486002)(38070700005)(44832011)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SayaivRjceBTxRDe6y+pmDLV3RPo+QJcsfYElbZmQSJyt2fob77AY9hVAQPi?=
 =?us-ascii?Q?T6jnJMjGS6vZlWjjhGsGMwf6AYreLPXmh3dtnmvhbDnKRZO7b+ICJBzaAVkV?=
 =?us-ascii?Q?1+jwxNiHD1OtNkej3lt9oESOg3uoGP/ZodzX0vWmKlZaBmYq6cITjkaXVfNC?=
 =?us-ascii?Q?cTayH3MNHwG/HyZN1QDFPH4nkFHORn+1ggL2eUl2dCZEp4u+ms0OlBzN4VVV?=
 =?us-ascii?Q?WvMhKXbBgCNv7r945c64VUs9AKMS0F8tOHzNqBavvoTHPycDtV2MmGc55JM0?=
 =?us-ascii?Q?RY9MCod9DgX+UQg5MutMoMEHpYA/pEac6SYxRCOYQ/NKvrGTciyHgn6/OT+g?=
 =?us-ascii?Q?dqEayBw14khWSxfcw57h7fZ+KXC5XXjDndYQvNgCG4T6VSSe90zVzOwW/zId?=
 =?us-ascii?Q?jbmh7VQ7B8CGgdI2ItHBkISCvxylDBAby6KvomrUaY2cwh45xDclj3PsstnZ?=
 =?us-ascii?Q?R8aM2yv88H05BR5XSWuj19Fec207+O7XSjC7DuIPHaEVloT/b3vKKrTzvLN6?=
 =?us-ascii?Q?OOmZ7nUwsYVKrlfO6G38738R2UE147xoNzRFse5yT2aoRoeDUTJ/JTpAJJmg?=
 =?us-ascii?Q?pLYc6tZqULdc9lXurMeMnkZmpj+DLEw/1QkTgbZ1H7sznq/gvN9fit3NdfxZ?=
 =?us-ascii?Q?mgmXFbZKvFPovsxVWjOo9HADmebj6O45ax1+xX7AkzRXSk7NO2khvNobJN3C?=
 =?us-ascii?Q?0I7PxHR/w+8D61IuJHrjqs+liNkDWlS3/dmufot3JnrlWXbKY09BeJ9RZWtc?=
 =?us-ascii?Q?FvuYJN2HQoL3Z0fFosycmrss38FJexPbabC/LPW5AvyGyXdSxbtpMselU9gj?=
 =?us-ascii?Q?lya0IgmDn9ouCN/WYIl0dEZNS485s79+Wra4l6CaWO++o2gp0b17VupJTfeJ?=
 =?us-ascii?Q?JoH0V9O/FWT+IZaVWxl/p1XBcZcOVeC90G5825llZymkmdiGIDpPpf9aUT55?=
 =?us-ascii?Q?qhQ78XLP9Smg6Wjm3nQQTQz/dlh8mBWfEs0xaJHIBx7ZODq+L9S0p6U2nfNg?=
 =?us-ascii?Q?dhlGK3g4UFUBD9Ge1CeyD3AVH60+KvFUxfkB/exgcUDMR2/UPXP+Zh5+2msT?=
 =?us-ascii?Q?N/s8uVeb4ZyDGZad1gSEr/yaxZTSfVc9vSMG6OwYuuER0vZGvxi8Qk34LdmG?=
 =?us-ascii?Q?KYX/gMVq8LvnOeKLoIAW+IAbEWflckJV5ng5Wf1IFFlytbLBmdPRIuuUhOVw?=
 =?us-ascii?Q?hQ3NYyTNn7Sr5P9WnPP/Ai/8Jq1jKDB/YqzlFmQiC1mh3QEPRnEVvUAQMKa8?=
 =?us-ascii?Q?pzIt3GVMqiVuTbdDNFGusWWYYEvDg/VYf/7vRMpVn6/jQdD9T4hlc+wFz3mG?=
 =?us-ascii?Q?AdBWjZYR0nKTlFzTim7vvAvh0ns9xhLkHglqrfdY+07tK/JYpM5b31193fVy?=
 =?us-ascii?Q?bmRU7cYmHCcPWIYrpo/nNO0Jw7EjosNJCaZGbZb8O7YAqehHoOJ+jr/aRy3h?=
 =?us-ascii?Q?bsjDx86TAwhR0SFjyCrcSdbAHZSJJ+sf0aMFc4NBVtJSMtFfUmcpm9IgI+bk?=
 =?us-ascii?Q?3P8G2MdjZV5wD/9y8+WGqImOjDamgxlPIZ/jpRISKCAb/yWjU1BPncsjDx9H?=
 =?us-ascii?Q?gy816HeOf+x3ZvBvRGFr2OjUKGr2FekPGknuuGmQOFjk1YFTHzHznbGzNlHl?=
 =?us-ascii?Q?NFPP6q6jPMvHXQzJHkhcSrQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1840D0EA9D5584183DF37C37715E767@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?U25XAK3iP6V5bjgV2U968t9SdX3QnMclHyzsuG7KG7n6wd8Y2P5GwthaZ0Tu?=
 =?us-ascii?Q?G/XMr1M8TJnbvIuF/XRwRS/YVu1p9cXtaOZ+7ms3FmwiYNLjtTPOtMA0evKQ?=
 =?us-ascii?Q?cpFdVraM0965AA8kdMRIdkOGndhE3lTo99PfEsv4PZV1HRxXS1eBjyo8+Eqz?=
 =?us-ascii?Q?n67315ZdtFJucEGyspCbu2MAl3yFpNTwHD6Exav3FUu6PBHFz7wNAbBOy7Nz?=
 =?us-ascii?Q?k6RaG6gxxSGUldUTe9JgqHhMJ87XGDI28GYj8/VN5w5NoIvssZYBJSZoxM7v?=
 =?us-ascii?Q?N1OdY1ebsfaIUw/RcjcS13ViTKgTXaUaNmtLfovsXjp/eXoawiVpOsmgUDIL?=
 =?us-ascii?Q?St+kHsOkTfZvekfGu+abGiyqcUqZm+2APiFJial2MR8/FLjMFG7I/1t7EDZH?=
 =?us-ascii?Q?uqn7LFZQux0pzzSFO081pRZWCryOdm/kXFhHImnQiki3a2cSC7f7uUMhY8vR?=
 =?us-ascii?Q?TAKTXYqFNGLgpIJERWn6vUVzcGeN6r6hHm+hcpI0JSsrbNPRJ6ML+iyPz8Yd?=
 =?us-ascii?Q?NFtTJ2Fa6D1uXLFNzy7zgIx155X8n9MaUZRnxkdECmrRXVqWtaoBalDY5KcM?=
 =?us-ascii?Q?oKqvniE9mcvESzE2oa4Atq4aOUCxiY6wvkd9YZDAiEZOQ3DjK/380/r+uFWR?=
 =?us-ascii?Q?cJLy3Xt1PNPiyG5J+ep/qvDH+ZVpkMsX0hjO5oD4HMtzXHlCfHLwYdWjH+8r?=
 =?us-ascii?Q?2ibFGT/rw+mZjfVBhF9XrNp0YAKiS4kES0YIhs4m6vPfiGC2pvMh2TqSvwf+?=
 =?us-ascii?Q?EEFQElACl2M2B5D1OLU/qRfC64Imjr8ZWUzS5e+K9v0vk8hotmjQXCMPKQLn?=
 =?us-ascii?Q?2xIQUXLYDUNKZj/tHFXS/UTM5GE4YyLXEQXFyV2gy+KgapQHLRriHO4QZJDZ?=
 =?us-ascii?Q?sKqFVxbDtW3iMxtHC9d+IRaPrCcBRPLuMTAYHowb3b8fCYrrEX+HT8TccmYK?=
 =?us-ascii?Q?ecJUr4B7Vq4b9L4unAPsWg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93de7d42-5d53-4ec2-5f06-08db6cc85b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 11:13:18.4083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0x/zttwNTuBTYDxTwExU/8iDrMfeEnqwWO5TzFy/QoXnaHJTujkwT5y+ofqlTgGA6ChySkJlXbggA4Gw1YcBUw1OxdohEE1jWAzVagBc73s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8507
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2023 / 16:29, Daniel Wagner wrote:
> The tests does not cleanup all resources after it has finished. This
> leads to rm not being able to remove the TMPDIR cleanly:
>=20
>   + rm -rf blktests/results/tmpdir.nvme.040.m2J
>   rm: cannot remove 'blktests/results/tmpdir.nvme.040.m2J': Directory not=
 empty
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Hi Daniel, thanks for the patch. It looks good to me. Now the test case lea=
ves a
loop device. This patch avoids it. Good.

Question, I do not observe the rm command failure in my test environments. =
Do
you have insight why you were able to find the failure?=
