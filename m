Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42C693B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBMBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBMBIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:08:20 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A371510258
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS08I1Q1n0PTmVKv22KyRpB88tdwKg1zhN9WXfSq/JtB2eGxFHGmltPTaAG7zKZl8i8SEXh3zPuFR7cWLsRMl2kxWEac4tlxrQewDCzt7ZnCXBhGn0mjtrU1BnbwuHLv2ZKgFQbg1cKYMSEVy9RikBX/TQRRu+T8tjrTnAGGK19TTmOQOnwEgt5QhHtZWd/enmP9GRNHhIlK4dLgDnjubAWnlXgzeHcgvUe/3su7+eiIQIp0IMSL9Xu7ZyXyhp1OQlirb/VTLGUCxQQtzGi1iOFiPmyBjtP0/qKcC2V3A2e3mdu45VgrOw86yTIMTNcNI9Vt/jhqFA/r3cQ3XiJcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2OCTrh7tMgV42mXYKjHw36Ki+GNiwMV8tzuh3lEpGg=;
 b=F+C2KRelDOS77NqkiQGqJiWfOouX9k+B6mRl7iiB34K8hZFluRqRl2+hwWVOM58OUWepBuEZkF5DVJwSNp/KuiFyHBKsrri7BptzGxjCw1whLdrYpeI3Muyq3r0y+7h3H+JZj3Uj7o344sarWQBmv9yJzPGLpSW8khmCiVlTVwNLWUSQOwp2xHELt/yCENIlNkFRq/n+jD4+yT7aHSVXPyMH0dju3TKStWrCmnGkyueOzFvP2zttucNmS2DHxha1UI/cagbbJWQpgwTktE1OmmGadL33l8dGarbS93PeUoNcdRFQ31pQM6n7IP4pztIbQSL6RexRh+gHoUuu+RQfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2OCTrh7tMgV42mXYKjHw36Ki+GNiwMV8tzuh3lEpGg=;
 b=YNT1Lctcp1aCp3mCnCJmmfDuDdlwYHk9K+TOzyhDF7ueqdi+8UwXvqJ89ETBiAn4HKIspngMEYcPslaOofhlfp9bMa5e/f5ld9ozOWL76Opb9771zXycNyrnqWwnVPbRuZA+7CrvOUryGM26HYoMTcybQLXjmWCYR1H5Dm4jhsM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3430.namprd21.prod.outlook.com (2603:10b6:8:91::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.0; Mon, 13 Feb 2023 01:08:08 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.007; Mon, 13 Feb 2023
 01:08:08 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Thread-Topic: [PATCH v2 7/8] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Thread-Index: AQHZPFdbFxstpbOX7kmH7AmnajmUt67LvPoA
Date:   Mon, 13 Feb 2023 01:08:08 +0000
Message-ID: <BYAPR21MB16882DD5A99CB365F2BD22A6D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-8-jgross@suse.com>
In-Reply-To: <20230209072220.6836-8-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e8680456-7e4d-460b-88fc-043963a311ef;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-12T19:47:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3430:EE_
x-ms-office365-filtering-correlation-id: 9cfd1db8-30a0-47f1-a0e0-08db0d5ec4bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3RTZmMfPGDg9vEz5QhVkJI4DC7XLykzEAPOn0oQFJ8CVN08Wmi2Js6+uCX1j8UDrIXBygbTJPYfQfuK6aUlPqkmUZAc0g081OX3YanAgYtCauDKlGbv/zOvMrRI/gwFzXjVn/1P+g0pWaHPI3D1D1lJknzblavZ1s5EQshQvgIcsFbOKyEgQ7Xd4zMiJm9xsIVKF8lbES6hzYRnnqDU/u7xDQw2RfMSosWnHmq1iLoR2e3IRmyj7ADCif5qFnjtmBs63X1w1yBTgaEFz/6qZhxfiJmvteFxpWXcJpLTVsXmmRA6w2oagZOHgivhpMDvJmtjv5Ep2BRMS6+/7/yxN2DXYqYS9vJ+oNt7uuUVf/kpcUi4ATXhDpcHtre0eBOlDAJLirdC0XmVjYZrdwH1qWPGvlW7b00ps6ARhSwCJm8NE7SyLiTUA4rOH08O5l2hWI88btdizes8Lw3dXLMYFaDH4Tn+n9Eer9bsAXIToZJgwa2arz0M+gAK6b8AsylO+S2ro8qeGUTS+tk7Ob8KBs2/U8Q+x8ilgy3cE6ttfHlLR4uTs+8UXpzNq46LZWFLDTTX27NusYudBwkDcI9qLEXfAuvuQfU0DNQRJfdtdiQKVP290RoDdcFBIFleYPp//OrI5Kw3AfAaAGHPOURMCjCLVQG4UE8fvWRLP+bdofZgBfdhjbimTHMg112Y9ZzJJoU6PAvErbkb99J1GD+kesbVSFmQds/2GzkjuR2UwO1Od8m+tFzKCOvDfhtIvdBMw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199018)(52536014)(38100700002)(38070700005)(82960400001)(82950400001)(122000001)(33656002)(86362001)(83380400001)(186003)(9686003)(6506007)(71200400001)(110136005)(2906002)(8990500004)(10290500003)(478600001)(4326008)(66476007)(64756008)(66446008)(76116006)(7696005)(8676002)(66946007)(66556008)(7416002)(5660300002)(41300700001)(8936002)(54906003)(316002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+tN93lL1wOn9el9xHHthsSKxmFGxAS04vLLS0tgnhKvP5bReNG3Q9g+eXq+6?=
 =?us-ascii?Q?tDrB5cn1zLRmQDBI84/+PA+v6Pam9WhwbMH88BOZm131ES91oTisB6ewlndN?=
 =?us-ascii?Q?icjjDcvCNamIfQ/e6AzOOdy8dBeOGi6Y0T3RE/sJHdQX8rH4AuTdzX2mQq3I?=
 =?us-ascii?Q?IPnq0Yc6bkIa/WaNAhuz13RINp70sMbN8JS/oh6M35NBBiO9KnRVKDdXiZAw?=
 =?us-ascii?Q?S4W4Le/ZZ3Sjj9sfd4JFhuKiL1hD75aSHYIvUdIhFlwtLlgfIjOVjKHwIoKD?=
 =?us-ascii?Q?AgDlMsTB/02F6oD++8MZZjesJhFCdx02bWKyMEXjcZmfFZ65COj3/X8lUlPI?=
 =?us-ascii?Q?Q1MSFJxtafj6Zf50imS2ygeh/XVoeeIC387x4h3GXUjdMiBjqHyvRG3wDiFL?=
 =?us-ascii?Q?22gkTKziPx+f3YkxGv099WCzO5kLdHW5T7YG5Ar+798YzW9IHMwykrA2YEuw?=
 =?us-ascii?Q?v/fHTv55mTllPzYpaaKd4/trOa4fSJiAq1yRLaq/5GrQYdDqFo42FiGBnBgv?=
 =?us-ascii?Q?RT3ZcnjE9NFnCBzv899zSZU4V/UqyZBM8IwVFStqy8A3Dtuy/1RC7sDSQBJx?=
 =?us-ascii?Q?cWsfGa2WYFloZQJ1wFXGpMBotpYr8zm31Q5BxnOkxkP6lrntGY/1ZIvFVPah?=
 =?us-ascii?Q?JbKq1yOBMmfbi9WTacGRUGSGhjCPWHSfy4MUhNTWlQmnrwdSmUjlJ+XKcDp0?=
 =?us-ascii?Q?tlJN2FFU8iCHy/4ANZrVhb2aJ15xoM1QLfzt6odS/WkG+w726U9N+xHWcNpE?=
 =?us-ascii?Q?4MHOLzvpyJ9LyczP9R1e8X5MuI3/tWo5hinZR78YZK0l66eh5cgosnu2v2jF?=
 =?us-ascii?Q?I/fUit7OQPrSx2HB1iwNNKnnoO1Rel6WC8lCXwmU6JHtbi14tT//0HL35L4V?=
 =?us-ascii?Q?bUwNgN1bDcl2aQtrwKtXLxqHRUuegT/UKntKTg1RzERBOAy5lIzzDcFxig6H?=
 =?us-ascii?Q?T4BQYJfQCyXuHlxHaOqTQrlWup9F6fBTJgk/LGJzBSqIkdT0BKS0jZbUM88e?=
 =?us-ascii?Q?YgPGpWKckvgGaL8PzCHDdK3W2anFtlsM1S9eLGc9B2Tt6ois5/GTsQZ/aDtU?=
 =?us-ascii?Q?nlLsF0q76X3ZNpHaeo6Uz7u7u8tAqamvmOGSAUNaS/pXngFevIbwsbbbsvaq?=
 =?us-ascii?Q?pIQ/CD0e1OFmhcRjCjQ6JRo7a14FZnPUc2GGCTQBht9fdVMrQOIlM2hqt1B5?=
 =?us-ascii?Q?d4BQEmMFnqwOU15Nef2J0BlpWBGsxIKFN2wPdsj/+kWHcLen2i/AwdabgUqN?=
 =?us-ascii?Q?ANzcTBKOIfFU3nAr/LVFu4WXZkP+CdfK9e1d8THbuKpyxRzHMQB4BUP1SN6+?=
 =?us-ascii?Q?p0oqP/qAFJS9kdmyDfJ9xv3p2UN8bkxWTkaAZdDaPG5VSph5C+ESSuysOm+l?=
 =?us-ascii?Q?SwqSK+0ZIQ0Z0vUZnSsMib7jBmA/j/PZYuiUhdltTFb0U0wQf00O6urMDdG4?=
 =?us-ascii?Q?E1RT+HfT8NxlziR9P6QNZ2BtiOE9iu1mV/6iwM2vvOuX51sWIormvdIComBs?=
 =?us-ascii?Q?qPfkTAw0jJQRpSFdDTRcdM3xyRfzKcPoSV8UJfxOqviLmbYY62LOxx2r230J?=
 =?us-ascii?Q?+Zcz4rZ3k4XRcY4ft1zQDI5T5AaYdZz3+Ev6+UQQxZaFo9pyzUsY2aRO2q6m?=
 =?us-ascii?Q?597fa+JDNnhgGOUnGgwNIsiSbrJ3X90YG9ikjWdvTm8ycDFlfL5Np802wzPA?=
 =?us-ascii?Q?eJa0nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfd1db8-30a0-47f1-a0e0-08db0d5ec4bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 01:08:08.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Qw1E9PZxNLnkuFdgVEXZ5/u8mmcPmjk1r6Lvn0WxRMBLRxfkZAX3S1eBQr2dNPu4AxdJ3fJ4GcFXQlx4VumX5Ueh1QeC9amzgL33TEBqaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3430
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Wednesday, February 8, 2023 11:=
22 PM
>
> Today pud_set_huge() and pmd_set_huge() test for the MTRR type to be
> WB or INVALID after calling mtrr_type_lookup(). Those tests can be
> dropped, as the only reason to not use a large mapping would be
> uniform being 0. Any MTRR type can be accepted as long as it applies
> to the whole memory range covered by the mapping, as the alternative
> would only be to map the same region with smaller pages instead using
> the same PAT type as for the large mapping.
>=20
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/pgtable.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index e4f499eb0f29..7b9c5443d176 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -721,8 +721,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot=
_t prot)
>  	u8 mtrr, uniform;
>=20
>  	mtrr =3D mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
> -	if ((mtrr !=3D MTRR_TYPE_INVALID) && (!uniform) &&
> -	    (mtrr !=3D MTRR_TYPE_WRBACK))
> +	if (!uniform)
>  		return 0;
>=20
>  	/* Bail out if we are we on a populated non-leaf entry: */
> @@ -748,8 +747,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot=
_t prot)
>  	u8 mtrr, uniform;
>=20
>  	mtrr =3D mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
> -	if ((mtrr !=3D MTRR_TYPE_INVALID) && (!uniform) &&
> -	    (mtrr !=3D MTRR_TYPE_WRBACK)) {
> +	if (!uniform) {
>  		pr_warn_once("%s: Cannot satisfy [mem %#010llx-%#010llx] with a huge-p=
age mapping due to MTRR override.\n",
>  			     __func__, addr, addr + PMD_SIZE);

I'm seeing this warning trigger in a normal Hyper-V guest (i.e., *not* an
SEV-SNP Confidential VM).  The original filtering here based on
MTRR_TYPE_WRBACK appears to be hiding a bug in mtrr_type_lookup_variable()
where it incorrectly thinks an address range matches two different variable
MTRRs, and hence clears "uniform".

Here are the variable MTRRs in the normal Hyper-V guest with 32 GiBytes
of memory:

[    0.043592] MTRR variable ranges enabled:
[    0.048308]   0 base 000000000000 mask FFFF00000000 write-back
[    0.057450]   1 base 000100000000 mask FFF000000000 write-back
[    0.063972]   2 disabled
[    0.066755]   3 disabled
[    0.070024]   4 disabled
[    0.072856]   5 disabled
[    0.076112]   6 disabled
[    0.078760]   7 disabled

Variable MTRR #0 covers addresses up to 4 GiByte, while #1 covers
4 GiByte to 64 GiByte.   But in mtrr_type_lookup_variable(), address
range 0xF8000000 to 0xF81FFFFF is matching both MTRRs, when it
should be matching just #0.

The problem looks to be this code in mtrr_type_lookup_variable():

              if ((start & mask) !=3D (base & mask))
                        continue;

If the mask bits of start and base are different, then the
MTRR doesn't match, and the continue statement should be
executed.  That's correct.  But if the mask bits are the same,
that's not sufficient for the MTRR to match.  If the end
address is less than base, the MTRR doesn't match, and
the continue statement should still be executed, which
isn't happening.

But somebody please check my thinking. :-)

Michael
