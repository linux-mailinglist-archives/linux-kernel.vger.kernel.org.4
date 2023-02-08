Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAAE68F19E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjBHPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBHPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:08:22 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7D19F14
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flps0AQ7VvXxhDXz3IOCs86R4GnGCtG1WkV0Ve7I2C2zn6zihiUOt7BkYB3XbrefVN4NcQURAvQCWBuMRQXFSkLc16Pi+Ao0OnDLj8snf2yqcb+ShUwzI+h9rAmDbfNvBMkJkfQZEZg55ZolhUiPcHCtqMBJh9NIHfa6w6oT7uuikaqcyFwD1xe8vOGnmy0jwvWU/+xmZeReo36Dp1xESeIbdC9RCQsVA31LxDH5wm6Eu39ypcFaq6mXUr2P6SAP3PaknIes0/iyJAdYZhjTXnWK5jny29wfLylnTHzT1QcrNqHX+Vq4lUSrvnm2ZUxI9/VqgNipwLGrduNZuBpKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOMpNz9t8BaxoeOVHG/nZox0u4VJ39ULIzZXGLH7fls=;
 b=GEcqnhA6+DL13hZizKLg8rd0Mdi4UhTF0PTJgMJ0gIbtxLI96xubcVYQVYAQgV6A68QKffZ6PykEmfYYBjUfTD68DPZ6nrnltMxbuBCd4as+X2e330MIflYjvAqskn6rqlY6/DhOVtlUM4UDkeMFzpH9BxoDJE65dxtTCdg/IZxKGwFrrydO9u7w36QKyWoqzatIhVbiBE2skRkZBDHmJLSMga+iEuMrWdSvq2PM5dkLurz30OZ9eQea/JYp78/ooPKWXQir76tE6iGXexaXKxCmhrazm+ax42NAtWWVhMwgUlFQSDWyRShVwW061ZFZlhSMv+aTZwJPnm17vDHfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOMpNz9t8BaxoeOVHG/nZox0u4VJ39ULIzZXGLH7fls=;
 b=UWAysa86sfD5wbsXXcDSnYTOUxiGNKzRVtS2U+bf6cEMLbcOo8az/W4wpeW4MucIms70zcXLRVo2OZE6wZBjiYyB8Aqa+t2wQhl/qReApGtcbmbIIesDrviU9gYgHFqwmUjEuP1vboqp5TddDLtVjF18Mgv3z8ZLY/Wvfi06GUw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ1PR21MB3531.namprd21.prod.outlook.com (2603:10b6:a03:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.2; Wed, 8 Feb
 2023 15:08:15 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.002; Wed, 8 Feb 2023
 15:08:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH 0/6] x86/mtrr: fix handling with PAT but without MTRR
Thread-Topic: [PATCH 0/6] x86/mtrr: fix handling with PAT but without MTRR
Thread-Index: AQHZOsXe7AitaY9DOEuA0tess7fFFq7FJflg
Date:   Wed, 8 Feb 2023 15:08:15 +0000
Message-ID: <BYAPR21MB16886C389C45912DB4EBA362D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230207072902.5528-1-jgross@suse.com>
In-Reply-To: <20230207072902.5528-1-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee2da22b-6cf0-4de8-894c-f3f647f54275;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-08T14:58:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ1PR21MB3531:EE_
x-ms-office365-filtering-correlation-id: 4b20fae5-55a7-4fa4-74aa-08db09e64d8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MK4yqm2mgh8LMO0mvVz5hg5TvtpYhjS6c6P0I/tFy0rnAQAXpfMUDax+LM/6rlBgsU+d3uR51+ksDI/cMpME5Sa5WLoxrUu3rSdgIDmV4yNWYz5S/5vX9puC0G6TjGqYLrrSELmpB6A2ELElHglR0Kmy0fuFSTBu8VJYyfp2BCK+9fm0w8zLyzdbRIpwtcqWtsZxJO1RwOYmRtKlmfWio9kk+WwyrTCctjeMyinRwVprlhSgEtwo2mFB4e4INMVrn+Eg8AiurcwzGgT6tITiFpQYvg5HaPGnxEp+39+zc5zlMNeObnyBEieT+ZwFMe4b268GPJQyCN2LGZvdNMZ+PF/F/b4wFBjx1Jp5q0JjltqBLy7Vc+jfNS/Ghns1x+FNOL3H8NeFw+gHDBIYzUPM0/bEm8BxigAEyh1zEMfR5qtyo4WEelJuicQYgpKZQggGYqfUk9MZY6IqNYLj4BqPUV/WPpzM7Qjl8Ndl2MSKVfBfvhE3HB9dM9nWv8HFxw8Csrt46pn3wwKPIcXir0DmM/1ItClDGngy5WfuAHDouuz/dMv5utOgnbPZFJ72d9CQPyR5eeAhgc0IMGqTmDArW/OkOqMhLbry4qY/5eJUf68nhnI4V8+MluBe+Cbnuum//5h+kIA/XAPRuQt3hZT5wUtsNkx3ed1uNfHiQBsNGUQ3yr8OENtE9zIrBGyyC99TR2O6PAOUS3Kht4pn6722RqCZd8X8gb4iIlSM1N9gVhCctLgrp49TU3NKsC+Z1OSZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199018)(7416002)(41300700001)(66556008)(76116006)(66946007)(4326008)(66446008)(66476007)(64756008)(10290500003)(38070700005)(478600001)(7696005)(71200400001)(33656002)(316002)(38100700002)(86362001)(8676002)(110136005)(55016003)(54906003)(186003)(6506007)(9686003)(52536014)(26005)(8936002)(82950400001)(122000001)(82960400001)(5660300002)(2906002)(8990500004)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qn7jrDlRj5DXwTxsXx4Xp/mq5NC7Jfdzp3P04yB/hZnl8tgoHio35lXts8Fg?=
 =?us-ascii?Q?vMJSmtJBl0ERMjcwECaLySHPMpkn+YzNe7ZCvhq3P8iv+j8o4OjLnPuDtK7r?=
 =?us-ascii?Q?m3jsqWsPQEPwnsuNzq/XaHSx2K1122ya553oB8lNWjRL/SrR385zYol6MDcW?=
 =?us-ascii?Q?h2MEOUHaUg352ICYutlJU7aoidK8hD2tmS7b4xh9EKPp3+4xb1i2bYj2LUnR?=
 =?us-ascii?Q?tEUXhlBLyaFsyMD12izv1x0sZDUtR23Gd8vEJ/xYhqpn56m8bA9S9fgAQpIu?=
 =?us-ascii?Q?29XhPA4BVOPJJcQ6ODrvjP1byIuj5A11FevP4AIOJHOAJZd8FFo07IU5JEpb?=
 =?us-ascii?Q?bS9OHKRQVvJO2XEgBtDSAhPI+J0HocxX6dm8+7yvLWHhwwwLYjZUsJiGoiK3?=
 =?us-ascii?Q?Fwj66BmgEHiJoEJY8IJM/oecWeCTeCQfplRbaX52eWdXyzIxRVhlirdT6P6P?=
 =?us-ascii?Q?HdWBwNzxAili4VT0KseotJYmr65StklcrXSjjBdwtJcmkpWb1J2Tk+JcfxYP?=
 =?us-ascii?Q?IIvQd0l2Mr2LCI5kVuqXktOuytkwOxJNGe+MwFX7+k0E2ZmaJ/tS+HboQ5rm?=
 =?us-ascii?Q?FfQtPX0hwM1ID5T6jfq5xsSbeFrxDkqwYp8XHIvDfhtrzQnchSIbSuMgsifk?=
 =?us-ascii?Q?ElaI15z8GqIuzGhgjUyXwEbREYN4maCzRc9hrbhGP1xLRRUfLx1KIRLXR2Ae?=
 =?us-ascii?Q?Cx0+Ob3uL9ppMg9vLOdUrdzpAtu6q2SFTzeEyb+PsKAQXzxglev9bRBYPL6x?=
 =?us-ascii?Q?uBc38zKnI5TofsCppDJxw8Bsl9Am341x9z/12t6/4CaapQyrdopBgGUol3Si?=
 =?us-ascii?Q?lDPIW/X5W3sDyW1qtwkjDfqiOE3VNq30M7O7pXo8EbSUkyVO4e+u+7CVp68P?=
 =?us-ascii?Q?9RhhiWgDq6+LBCUfPH1YCFMMKuM/QnT6LtivVgpDt4ZGagCCfCc5hcrNKMGJ?=
 =?us-ascii?Q?AmyMgKUsXZMQ1obzIuNp39eE+3QO70vgpER6ARXC1ntPvAs5iTEZLa2CsOde?=
 =?us-ascii?Q?da93y0IvTE5YWzqcRdF5VULOC/k8FiSwhhslXiBHZEqdiRchC/1dRyMOONQk?=
 =?us-ascii?Q?nuPOcCX2dtpYEEebkpGf6yjj7dpAHYO6zPrEYwg7riPU5NTXR2apP+TmkxRp?=
 =?us-ascii?Q?2nN3nBfaU11Vhr8RBCpQjzzYOHqA8g17J/2GOfbN2FUfC4zzmFi+JotGXzjF?=
 =?us-ascii?Q?Wm0nCB3g6DM4CNix8YxQFFv5muEFuJJtKxpVS7hsbpCimggClImwi6wkviw4?=
 =?us-ascii?Q?BKyHFTujk7GDz0Tpm2Fu1Xi6vmQ/wPVv7w9sSV5nIzMMt3sMV/yonysMos+A?=
 =?us-ascii?Q?yYm0l3I1PObSkKAp+gN49dxmGJ37AjagLeblQdusgHgYUjQzHU+QSpzoLS/g?=
 =?us-ascii?Q?T8PiLccOuw0TAP1dLGr4Z25dHV7/2rPIOjGR9xTyy5UIIUeZWPrJ8CiGGXwp?=
 =?us-ascii?Q?ZhCO8D43FlXHQ9wDIuXIc8NsHqd4IFMH7ek8A7O4sRAezT7NbcCk+r/IvuRQ?=
 =?us-ascii?Q?ST3JJKwJl7sDVFXN3FyhtQisOWugk+lgHQSgGT8A2IhzlSRgXsnmhSqjk+af?=
 =?us-ascii?Q?AHB2hHimySrOkWFmCFK3xqmMZkTwQuJa0YLtMm4LYwHqkYLX803Gl1Taxuni?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b20fae5-55a7-4fa4-74aa-08db09e64d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 15:08:15.0898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1OU25Lcl9xMab6SfiQ4fsWhhI7/VFCDyTFkVsNe0h7CvXAyar3aFBhiTWVp4rNigNyVUVbhftVT6km5eWdA7IxlbROrCarEsu34nJMFlqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3531
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Monday, February 6, 2023 11:29 =
PM
>=20
> This series tries to fix the rather special case of PAT being available
> without having MTRRs (either due to CONFIG_MTRR being not set, or
> because the feature has been disabled e.g. by a hypervisor).
>=20
> The main use cases are Xen PV guests and SEV-SNP guests running under
> Hyper-V.
>=20
> Patch 2 seems to be a little hacky, as it special cases only
> memtype_reserve() and memtype_free(), but OTOH this doesn't seem to
> be worse than in previous days, where PAT was disabled when MTRRs
> haven't been available.
>=20
> My tests with Xen didn't show any problems, but I'm rather sure I
> couldn't cover all corner cases.

I tested this patch set with Hyper-V SEV-SNP guests, and ioremap_cache()
is correctly mapping as WB.

As an observation, with commit 90b926e68f50 it was nice to have
the memtype entries created.  I could check for any unexpected
mappings in /sys/kernel/debug/x86/pat_memtype_list.  With this patch
set, we're back to not creating those entries. =20

Michael

>=20
> The only cleaner solution I could think of would be to introduce MTRR
> read-only access. It would theoretically be possible to get the actual
> MTRR contents for the variable MTRRs from Xen, but I'm not sure this
> is really the way to go.
>=20
> For the SEV-SNP case with Hyper-V I guess such a read-only mode could
> be rather simple, but I'm really not sure this would cover all needed
> corner cases (I'd basically say always "WB" in that case).
>=20
> I have added more cleanup which has been discussed when looking into
> the most recent failures.
>=20
> Juergen Gross (6):
>   x86/mtrr: make mtrr_enabled() non-static
>   x86/pat: check for MTRRs enabled in memtype_reserve()
>   x86/mtrr: revert commit 90b926e68f50
>   x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
>   x86/mm: only check uniform after calling mtrr_type_lookup()
>   x86/mtrr: drop sanity check in mtrr_type_lookup_fixed()
>=20
>  arch/x86/include/asm/mtrr.h        | 13 +++++++++++--
>  arch/x86/include/uapi/asm/mtrr.h   |  6 +++---
>  arch/x86/kernel/cpu/mtrr/generic.c | 10 +++-------
>  arch/x86/kernel/cpu/mtrr/mtrr.c    |  2 +-
>  arch/x86/mm/pat/memtype.c          | 13 ++++++++-----
>  arch/x86/mm/pgtable.c              |  6 ++----
>  6 files changed, 28 insertions(+), 22 deletions(-)
>=20
> --
> 2.35.3

