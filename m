Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34126288F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiKNTMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbiKNTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:12:48 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F324BD5;
        Mon, 14 Nov 2022 11:12:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItshIdb4I2XE4pg6j2qM3W4I75GkBYidcg+xEs66oiLVkwquhz4iyS+Z+P/O52EbgJ3nVGTmBeh4r2yITCUAYHLYcuVZ5170MGx6Pefh0so6EPPAm143fs0wQwCOGyjGwe2HdskBK+S6B+8wV4BYtsicT/YuGu7Yni9q/+1XV5WV/Ymsrem0MVl7EO+TcKWjGWVsLKNmX4ryLYenYaRPLe2K97GcxqotzeE/ilfAocGZgrn2WHO2IU/W2c5JulwTegCD1/MX3rsJpbTU+WK2z3YU8BS5/1bRsvLiMSw5AWDV/s9DdeRkyuauC4T2/EK39T7I0UhasiURfwqSsDN/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYca1CmKSo2swLbkHAPDfmvg0FLkLOqnpnL/x3445bs=;
 b=hRNDXHcl3MXQ7oWdhpmznU9vcH1K96+1GtklHe/kesU6LocI50OW38ppdfWGqVLgli6WEAFXcnmAtfigZQB8lvIDavGzPnL7Fc11Qgzl6LpqkfiRNdQf9O9HuiDUGEt5sy+miRM2yPq/ukhObcjsWy6hQT5WIIPnKe2i2xs7Mz4fD4rRF6h+wWphnz4St3GMfMDxPqzJZ8PEv4duRI5HhWsYmFK/M0qZDqy30LkcDqHF9zdRhCz3csjx/z9HC6fdxuOD/uELn1x4FWa30yrIX34I0rNr9YWuu90cMUzlG5MrVLJJPszpg9b1OcUXk3FIhl+eo3UtSa2S6cr1I98qkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYca1CmKSo2swLbkHAPDfmvg0FLkLOqnpnL/x3445bs=;
 b=acJdZmvpW7NookCBjUJWx83DtskVqVWU1o83nUI4c5Oz91uOsx3u4QemelkxFtHeELDvJHGpgZD9+zAGDlRUklyLi72SInY4zS/fPC1A16ZLN5t3bttLOH2K31wq+PR1lJnBTSeCXYyh0dstaGMivHmMt1NzjVNJcCRC1jGzPXY=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 19:12:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 19:12:45 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Thread-Topic: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
Thread-Index: AQHY9NCYQ+ZBoZLjL06d4Pfsi7tE0q49jLAAgAFCUuA=
Date:   Mon, 14 Nov 2022 19:12:45 +0000
Message-ID: <MN0PR12MB6101BB92574BEF0A0AE2AB11E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com> <871qq6tnqx.ffs@tglx>
In-Reply-To: <871qq6tnqx.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-14T19:07:21Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f947aa2c-1c7e-4ca9-9723-99f444ee3555;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-11-14T19:12:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4d15366e-4a90-48f9-bf04-eb8d62cb5c9e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW4PR12MB6801:EE_
x-ms-office365-filtering-correlation-id: b1bc8f60-8ff6-4db7-9949-08dac6743645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: la2Gv8jpJzeZg4r5npjNwNPgIxGLDs1k3QYhIIVDpz/hexT1Opfcl08mK1nlZFBCymLxw4iON2Z/cgtHRtHddw7SeQejQ/rihxqDqPlN4HJYUF64JTQGvafwfHiVTJrl1ixw/rivWeO0hD+6TDw7dUfAKaehohsY76kTcYdNO2qgFCIsFC30wM9ouIFnbfbtsGNbznkZkvQ1ascDgVA0b0YJZD3S+x2/im1AmD7vo4MjBYv6FDvBHCpTwX90lxlCNzKmMSGfh08755EfnSASKN9hKVPzLRxsLWjeaM9hLxlTV1PpAcQPnWk8+KN2yQBbQuLnPweJ9VThAqzERpSqrmeDaXH8iIv3DpSV5NqFYsU8GVrWvNHP66z5KyV8IjvTRTDKBy1WAw15CpQeqHEs1Bel/cPwhu9VIhhm0duXCscWgbOA9LL1mgQ3ZaY8/EkcFRTE88XJXR/Y2yQz+IqFLYms1MLWRk1R+zRTI7MFwlScycaWnfU83j7+pZ0vt/+1m8MWM6cq2DIBMX5wfBbf5Llvl2nQNGrD1C7LJ3fU0mRVRfegtg7jHBHhW6MkCeudpo/JE5dgkGHFTQ8Z8Bd01Fnrj+8YWDOohVLLlC8gfJ+qD+6rl+KBVT6QTsbCCKUi5myXsMKAjAdqPI47QyN9aDvewZ4Fhy2iTL7oOMK7JgsFOfqSBMvpn3p6wNFTN9Tif8i8aXjygDwMXbsNlMBN28qBM/i7XQxASyuy3tzjf/VtMuI2cnB04+dX9mfmLoQNAkcWuwuHmJ5mvyJJLrAUyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(55016003)(8936002)(83380400001)(9686003)(186003)(7696005)(26005)(6506007)(38100700002)(66899015)(122000001)(5660300002)(2906002)(7416002)(478600001)(71200400001)(110136005)(66946007)(8676002)(52536014)(64756008)(66446008)(4326008)(76116006)(66476007)(66556008)(41300700001)(54906003)(316002)(86362001)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R5ROiX9HRBttiSclp8uIFAy99YvMyftOiqQo+wVgUqPOAybEbjt39E7ReaKW?=
 =?us-ascii?Q?UQyUMJBBe9EcPBYpzLR9vaSQU0QoRkWDs+d2N7ZETCRwKsSfmHvsWE4mPo3d?=
 =?us-ascii?Q?9fu2OTqQrUKP2TE7kOHftGKQ3ZWzqwCd1bls71w8CjH+/Duxs/MBHKkV5jvN?=
 =?us-ascii?Q?XRlN74dBsmvpe/GD39Hja6ijo1gLyTDqgZeINyXAT3U0kSldEMQo+IUG9rKz?=
 =?us-ascii?Q?TrfglpRdhsejRA/0bANiUYVRwGNbsTGVdrfOvHdKuXKCRbEGJqAY7u5prkJN?=
 =?us-ascii?Q?cqop6BGbHP0bo+/x1c2nw84CBrwElJsMWW+6hnKudt6IlKAkuzjLreAo0bvw?=
 =?us-ascii?Q?zaE91wI+iT0WgPoEhyEjTcpko88NKcTe8fgVvJ/OB8seCr/EDcjCEgUArEw+?=
 =?us-ascii?Q?f30X8IASIqq0K4aHAjRKWGN8klTEQzi69jUKe18LNR3JifpzFLdxFd+F8bVa?=
 =?us-ascii?Q?lo5ranAt2IVxyujkB+71wInbBHCt/GvnzU0x42TTPfnSLt4eFjMVRSZ9Ht1g?=
 =?us-ascii?Q?Yon/GOmOpix3A/JhKQl4YYyXhpsuWMKDN9joVDGE0cxAmtzxDTaPaPdYdS0T?=
 =?us-ascii?Q?b2ZPqCdlIFn/pwet3m/TVpBm4PF8fCfY/dEZYUxlY0bXUSOVkMIbzol0XlrS?=
 =?us-ascii?Q?Nfu0ZkIHVQ1835FhfsD838hIEh/8w6JrlNRH+lsU0ZXBE+KJBYHDJMt4tv2U?=
 =?us-ascii?Q?WTOwpxhHmJX+ZJu1uTSD+eOwJsoZ0cnkvw1gmALcV32dsbYc2hxYNa4KYdEz?=
 =?us-ascii?Q?oTaDLaW3tnElVbcqh0cwtmwhvDU0Gy6590ypqZ2Lh8C/9c49wa186KMnCHyV?=
 =?us-ascii?Q?gLXtsiC67irWcRBmTQxUF1J0MtsAlNcwVCx7MUhJRsmoDqWWvVTZBYADC2Ia?=
 =?us-ascii?Q?lfeHPe1TWJmjE4pPO8EcKj0ZQzlz6tp/See6nOHNI9b2aLjerGL7abyVRYTP?=
 =?us-ascii?Q?OAcvDGI5+nvlNdHAN9/jamI5kxzlTYCb0I4anR5EjIYy6e/VnGxva//pja5I?=
 =?us-ascii?Q?0QLIslHA941+7YiVIrcim8WRBo6aIFeX9j2u7L9EYXxYDY/VApkBaNEkuNXp?=
 =?us-ascii?Q?YEIxzL3C3VnuZr2ykDLfjXzdUyeJFARD+cOKjWddcHjT7SKI6Xqfw3cqvybF?=
 =?us-ascii?Q?OnZQ0CsoiXX5al1Ou1HxTBeCfzqSfDnOjcGjiSqL60qe6i3f1+ITQkmwHcy/?=
 =?us-ascii?Q?XPHeh1k5ZOsgCYV0DVbZ2Y3DPu2ekSfn1fn6MAM1YUwOkP8fJZWlhE8mAX6c?=
 =?us-ascii?Q?d4+g5SAsZ8FwJ8on9ry+UGO86A+vbQkWyEN2V8eo8bQF1DnmMrkrKU7mvKRG?=
 =?us-ascii?Q?INOh2l8CLyx0EpInNbXBEj7Y0ddwrgA6y645m4eJRYiIFRNCetIIqyuejL4q?=
 =?us-ascii?Q?PwohKQ/x4HiCTLdeYL2vsRwAmQSQXUtbUbTAAJN0XI3bX1F/+0seDIJGAWOh?=
 =?us-ascii?Q?xb91bcHI2w0wnGrBUQgKgH6isINx155TNHfzeqdzyJIeRDKNPL01KguoC0xx?=
 =?us-ascii?Q?CqsSwGQieObgjaMVoydH68jC6ESsF+5hKHyzpyPLhpocTEv4qpUeboQFSPHs?=
 =?us-ascii?Q?D/BuDIgltwZHnT0Qc5Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bc8f60-8ff6-4db7-9949-08dac6743645
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:12:45.4914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klitxGajXO3x86eHYfWPUhtqyoWmxFgfZg2HFSlRZDokHdNrbDGT7HZ57d4Fp7dGlDmmnuKZkJ4qm/1gKbQs0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

Thanks! Appreciate the comments.
At least conceptually is there agreement to this idea for the two sysfs fil=
es
and userspace can use them to do this comparison?

A few nested replies below, but I'll clean it up for
RFC v3 or submit as PATCH v1 if there is conceptual alignment before then.

> On Thu, Nov 10 2022 at 00:47, Mario Limonciello wrote:
>=20
> 'Add a sysfs files'?
>=20
> Can you please decide whether that's 'a file' or 'multiple files'?

Yup thanks; bad find and replace in the commit message when I added
the second file.

>=20
> > Both AMD and Intel SoCs have a concept of reporting whether the
> hardware
> > reached a hardware sleep state over s2idle as well as how much
> > time was spent in such a state.
>=20
> Nice, but ...
>=20
> > This information is valuable to both chip designers and system designer=
s
> > as it helps to identify when there are problems with power consumption
> > over an s2idle cycle.
> >
> > To make the information discoverable, create a new sysfs file and a sym=
bol
> > that drivers from supported manufacturers can use to advertise this
> > information. This file will only be exported when the system supports l=
ow
> > power idle in the ACPI table.
> >
> > In order to effectively use this information you will ideally want to
> > compare against the total duration of sleep, so export a second sysfs f=
ile
> > that will show total time. This file will be exported on all systems an=
d
> > used both for s2idle and s3.
>=20
> The above is incomprehensible word salad. Can you come up with some
> coherent explanation of what you are trying to achieve please?
>=20
> > +void pm_set_hw_state_residency(u64 duration)
> > +{
> > +	suspend_stats.last_hw_state_residency =3D duration;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_set_hw_state_residency);
> > +
> > +void pm_account_suspend_type(const struct timespec64 *t)
> > +{
> > +	suspend_stats.last_suspend_total +=3D (s64)t->tv_sec *
> USEC_PER_SEC +
> > +						 t->tv_nsec /
> NSEC_PER_USEC;
>=20
> Conversion functions for timespecs to scalar nanoseconds exist for a
> reason. Why does this need special treatment and open code it?

Will fixup to use conversion functions.

>=20
> > +}
> > +EXPORT_SYMBOL_GPL(pm_account_suspend_type);
>=20
> So none of these functions has any kind of documentation. kernel-doc
> exists for a reason especially for exported functions.
>=20
> That said, what's the justification to export any of these functions at
> all? AFAICT pm_account_suspend_type() is only used by builtin code...

I think you're right; they shouldn't export; will fix.

>=20
> > +static umode_t suspend_attr_is_visible(struct kobject *kobj, struct
> attribute *attr, int idx)
> > +{
> > +	if (attr !=3D &last_hw_state_residency.attr)
> > +		return 0444;
> > +#ifdef CONFIG_ACPI
> > +	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> > +		return 0444;
> > +#endif
> > +	return 0;
> > +}
> > +
> >  static const struct attribute_group suspend_attr_group =3D {
> >  	.name =3D "suspend_stats",
> >  	.attrs =3D suspend_attrs,
> > +	.is_visible =3D suspend_attr_is_visible,
>=20
> How is this change related to the changelog above? We are not hiding
> subtle changes to the existing code in some conglomorate patch. See
> Documentation/process/...

It was from feedback from RFC v1 from David Box that this file should only
be visible when s2idle is supported on the hardware.  Will adjust commit
message to make it clearer.

>=20
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/compiler.h>
> >  #include <linux/audit.h>
> >  #include <linux/random.h>
> > +#include <linux/suspend.h>
> >
> >  #include "tick-internal.h"
> >  #include "ntp_internal.h"
> > @@ -1698,6 +1699,7 @@ static void
> __timekeeping_inject_sleeptime(struct timekeeper *tk,
> >  	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic,
> *delta));
> >  	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
> >  	tk_debug_account_sleep_time(delta);
> > +	pm_account_suspend_type(delta);
>=20
> That function name is really self explaining - NOT !
>=20
>      pm_account_suspend_type(delta);
>=20
> So this will account a suspend type depending on the time spent in
> suspend, right?
>=20
> It's totally obvious that the suspend type (whatever it is) depends on
> the time delta argument... especially when the function at hand has
> absolutely nothing to do with a type:
>=20

I fat fingered this.  In my mind I thought I wrote pm_account_suspend_time(=
)
Will fix.

> > +void pm_account_suspend_type(const struct timespec64 *t)
> > +{
> > +	suspend_stats.last_suspend_total +=3D (s64)t->tv_sec *
> USEC_PER_SEC +
> > +						 t->tv_nsec /
> NSEC_PER_USEC;
> > +}
>=20
> Sigh....
>=20
> Thanks,
>=20
>         tglx
