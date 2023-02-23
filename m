Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225D36A1082
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjBWTYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBWTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:24:17 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F00B1C339
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:24:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3QUwIypawNb6fgrpzmcd/Fzi7U0dAzH0FcSwj5WH5zs3L6J6OJkKYR6KVnlhB+HPxUlwKo6+nKQEQYotaSkKYbth3y0LlHdUT8r65aoWXNXKt59PRck7WtFkuhKcMD+gEmPDGbtZDrijSxnOaL/UM54WVHAmexCm/FXWVWCoF8XYvbEBJA6NfYsqbyteKH/ZL6mPgMDV9cNIqrEyCQaL8mUGHviw0M4hHrMrz9Jrqn8ppoxkHY+y6gsO15hfyvUDKX86xZEik3kCf32PdTvYp8EUJ+IKg6MPzBU0l3699oFdmIXbxPZ/K2P/bBQ/eIiIowT400sIbx2Sf2NrUuLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa7729h1vZPtNSZlrIVOejKCreW1rU+Tjgn9dy1FEfE=;
 b=n8JzUOWK4JbbxieaEEpJ8pG0Zr3O4XI3HVszsDJob5jGLQHkL7LXdiIhYQMdiQUivuBAvMM6f14GKq7I3sntp/IbHP+s/+SvQSSPeu5b2yB4fe4/xMi/n1EcMmqSs8mZ8U/bCuhdDJ0UCEktQ45Wabj7XhrdCBJfvCVk2Jnwq+IgzGoetlz75dGKLiTvYs2cQ1BFxcj9+FdaZFzrYG7uiiBjxv6KEFxv2lVfNv1sEbidk0NbTf3tP9Grvwv31VM0T7n5nd1kI3+i3ycDKCJMjNdm8NKvAx6bjWqOyxaiPwWFAHrr0zw6RZpP1beVxUAOvmGoPLjqXqzSlEVXKaD6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa7729h1vZPtNSZlrIVOejKCreW1rU+Tjgn9dy1FEfE=;
 b=NnqILYhnPgKy3kP2wThs1guuoaEnDeEbJfhY7/7w3OliOlQ7pyaau4CNARH8zAY8AaZUApq1z+cimKtMo7jLK3o64zly5zumVrAGGoc9DRer2++xjWpTuuqk6emOGE4sHHE5T1kjccjp7lFA1ylTpOKjx+xW1EajT24WO8d/F6M=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1289.namprd21.prod.outlook.com (2603:10b6:510:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Thu, 23 Feb
 2023 19:24:12 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%5]) with mapi id 15.20.6156.005; Thu, 23 Feb 2023
 19:24:11 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v3 10/12] x86/mtrr: use new cache_map in
 mtrr_type_lookup()
Thread-Topic: [PATCH v3 10/12] x86/mtrr: use new cache_map in
 mtrr_type_lookup()
Thread-Index: AQHZR2oaHJP558qbgkyFBCbS8ouHoq7c5eng
Date:   Thu, 23 Feb 2023 19:24:11 +0000
Message-ID: <BYAPR21MB1688C09C285013BD11DC13FBD7AB9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230223093243.1180-1-jgross@suse.com>
 <20230223093243.1180-11-jgross@suse.com>
In-Reply-To: <20230223093243.1180-11-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=32516fa9-3428-4d96-8da8-145c995ff579;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-23T19:09:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1289:EE_
x-ms-office365-filtering-correlation-id: b125d9e2-62ea-4154-94b3-08db15d38b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3+LF8pOfBcT7KjfRielI4KPMFBbb6FJinC5x7vBqO1pkCoDFqxhbfsi9kCVpD1sz5RG6NbAsARAyX7WHvJfASi4EQWZwxP8qSI8G4qf5R+NFTiCwjBTLUqg/4cKQ/oyU/h3bF+tzx7Uvw12VHiZFHlDKwmnFhAdgGSh30+Ivqc1sYg2vCCPv1LMVytfj5uYnyjfN96i783Nx7JB2cMHTS1FsGhYHDC43XBBFkgi5JA74faIn9syGGJzBR9xAJNClUen+dVtWyRsJ6TXG4sJ2B8OQziqVF6ZovsQxr3ux/GLq4PS4qQui1gAjXSmtIxOcMnebAFAgMLjVvKr8egys0ssoWEFf+7f3KwvaL1ECT9Zh/CV405GiMYN2pYRTFRcASmDm7edsQBd8yI5y6opFAezIO9YgfoXtLemQ+1Pci/1cg9xoCkpx0YONMtC6k4MOtrTs3IWvVFYgmH4hbbhFTPfpPTXzHU2T0Y8+WU8956Yb6Za+PKzlXxLigmWlH1iuZAElj97an2qkQM+C3W8Ya+qRvihE534cmkBvrt6Z2hpomafPvlvoaaht2jytthQtLASOue0uXE2DoPA+ErWm8X3jDJF1KRkB3Vbe7sDCOnyk5RmjEx7GF0wO5F4Ox3f4dBFPntrgNaH/GMpnLD5mfYAWbcrVm+eRmTF3LPupCFJiliJ9cHc2MwiUSi5N3fQBu42Q4pVlp0YWVCRbTQWubTebLFpvuBOT0LnOq06Mi3eN0vB2Uf3w0+M1/oSPIaed
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199018)(9686003)(186003)(26005)(6506007)(83380400001)(38070700005)(122000001)(55016003)(86362001)(33656002)(82950400001)(82960400001)(38100700002)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007)(8676002)(4326008)(316002)(54906003)(110136005)(5660300002)(2906002)(41300700001)(8990500004)(8936002)(52536014)(478600001)(7696005)(71200400001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lOOElXPoILC32yq+QcGva6FbyZDfoNEg0RCKV5XaFPsDX/RVs69jpqE3BSo8?=
 =?us-ascii?Q?ppNq1wKxZKSnBwgvpazwE1SqGXswHBmznGvqhL4U2MtOjtfhdxq4jir1ZTg+?=
 =?us-ascii?Q?sjeypZT39+LCH3adwevqQ/VMM6GoZPKjaxdFdniEP2zjiP6Ir+IIiZXIE46a?=
 =?us-ascii?Q?zpi1uxOf1XhOeimMqyqqikDelvP5MKP3dNtjWYFYRu5r/w7/XIu9RHZSqFUZ?=
 =?us-ascii?Q?TGAis66h7sCDfuC8JfWSW0JUgvOV5Q6G7x5tCw6akvuOyHJXacvxdj+KwFhA?=
 =?us-ascii?Q?ZPnzdycHQW9LXs/+hJS1/5VnIXJlEglDDkglnp4enjj1xXasXqHpiv5th4jy?=
 =?us-ascii?Q?5jcBl8jdH7co38LToRCGp6LPibqqzPrWypHH5ZK/3lzfuyiievIsvGezZra0?=
 =?us-ascii?Q?XJFezusSFfbLVUEDLoApZt7JykAUtqurIspXynWPi2rHPAW+e6mts3Kgt2ir?=
 =?us-ascii?Q?B27745hnY2F7nF/zRp13tgibNHAku5AtU5iBfWLZTfnoc2kgyFQuFQtvIdan?=
 =?us-ascii?Q?Tfq2szG/lq3OSP25eBCPuAvKycv+a9pMzCl9M5xrRaWxL0vXwiP/3mmJ6OXz?=
 =?us-ascii?Q?PjGvct7UcwYVALjL7XOWrgSR5BJl6IRftO+y4nHQcjk+TlDrK/pbes+/62oI?=
 =?us-ascii?Q?/XV/JE7bmSBeKN6a19uIYerK+8sIVceVqdHG9CBkRvs3GH5FzUhUwufQ3ToL?=
 =?us-ascii?Q?QhRTl/PGixsFBT8kG5Rg1rW+tTnTrYITd/lBlZjtcG3Y/bQ6hC2h+j2k2stm?=
 =?us-ascii?Q?5P7z69BIPzrKHXNUCkVsP2zoWfHUit//Af/VAVdO8h6nYtuTEDIxIs47Zi4v?=
 =?us-ascii?Q?H2CiVAmlYIV6wVeasZ/K/hcdtspKfsSu1BRUqA2c3VhaQnilEu1H4mi7kU9z?=
 =?us-ascii?Q?YgjynDMet4K8T28VNDKH34csbGYUD1QoewmKO1Jsu38mWB2rPBKzuk3C+LL5?=
 =?us-ascii?Q?GmULRmqECsmT54pz5f+Leb/OG+EaQG2y8DY4/c2+XDZHBtJEu5P+88EWp5K9?=
 =?us-ascii?Q?qgyVvObpsWtY7B65z8ubVlpcLJFPYOamkVasCIFRyU/ngtbmixWoNnsgBx+F?=
 =?us-ascii?Q?VUjwKh+WomdEV3IM3TZnEB01M5R1ah9DmdaDDahit0i8rqxDLlW/AZS7GF+5?=
 =?us-ascii?Q?3ZlxN+hsIl9FPUtm6W3j8QCIiCgjP83IHkOz96l+LUs0F/Wo79WdBMo6GKTi?=
 =?us-ascii?Q?7s/pln13Q+9r6Bst64bZRPPj6CJShkzU0xnrGBaZbQEpXATv8deMKwxqX61q?=
 =?us-ascii?Q?4nJWQVyVfhlSSOq3pYMlFGYR2NGlP59eUap0ctG7sk0bNrT+W5I8Ok03nhuX?=
 =?us-ascii?Q?btRjIcp6YvxGpi3ytWPz/n5ZOJdkonHOOfX7jhJKSbF0yjh8q0dZ/GQanAFA?=
 =?us-ascii?Q?t6IhowwMoLKMIYffAWjsxXqfaSqrLndV0XKECbOQ1vB5Yj0vWHC8r0iqF8d4?=
 =?us-ascii?Q?RvetCNThg43PcvhxuwYeM+mlE0b6ukRREZkJ+olQHLIbUZCl8eJ83l/xdQFB?=
 =?us-ascii?Q?MMP1e/onl/xGMD6hIOdu7kQF+82pcEnz/JVMW/k2ny9jsGSdrC0shN6pyizo?=
 =?us-ascii?Q?LOMH9GjIMPtf9MOUBd5g8YrcJy561VWK9Pih/hK/u4C/mTfyRofYDgCf+hLC?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b125d9e2-62ea-4154-94b3-08db15d38b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 19:24:11.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5d8JzbtX9zZSuEpL9XPHu4Bh+xyByG4OSfJG0/Z1LOmlsnKnJ/PTr5feJ134MUOb3AZ4evnlqWxY7W6kCBGk+2JmXsnEJ5/F1kcvFNHB/IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1289
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Thursday, February 23, 2023 1:3=
3 AM
>=20
> Instead of crawling through the MTRR register state, use the new
> cache_map for looking up the cache type(s) of a memory region.
>=20
> This allows now to set the uniform parameter according to the
> uniformity of the cache mode of the region, instead of setting it
> only if the complete region is mapped by a single MTRR. This now
> includes even the region covered by the fixed MTRR registers.
>=20
> Make sure uniform is always set.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V3:
> - new patch
> ---
>  arch/x86/kernel/cpu/mtrr/generic.c | 223 ++++-------------------------
>  1 file changed, 28 insertions(+), 195 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtr=
r/generic.c
> index ca9b8cec81a0..9c9cbf6b56bc 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -138,154 +138,6 @@ static u8 get_effective_type(u8 type1, u8 type2)
>  	return type1;
>  }
>=20
> -/*
> - * Check and return the effective type for MTRR-MTRR type overlap.
> - * Returns true if the effective type is UNCACHEABLE, else returns false
> - */
> -static bool check_type_overlap(u8 *prev, u8 *curr)
> -{
> -	*prev =3D *curr =3D get_effective_type(*curr, *prev);
> -
> -	return *prev =3D=3D MTRR_TYPE_UNCACHABLE;
> -}
> -
> -/**
> - * mtrr_type_lookup_fixed - look up memory type in MTRR fixed entries
> - *
> - * Return the MTRR fixed memory type of 'start'.
> - *
> - * MTRR fixed entries are divided into the following ways:
> - *  0x00000 - 0x7FFFF : This range is divided into eight 64KB sub-ranges
> - *  0x80000 - 0xBFFFF : This range is divided into sixteen 16KB sub-rang=
es
> - *  0xC0000 - 0xFFFFF : This range is divided into sixty-four 4KB sub-ra=
nges
> - *
> - * Return Values:
> - * MTRR_TYPE_(type)  - Matched memory type
> - * MTRR_TYPE_INVALID - Unmatched
> - */
> -static u8 mtrr_type_lookup_fixed(u64 start, u64 end)
> -{
> -	int idx;
> -
> -	if (start >=3D 0x100000)
> -		return MTRR_TYPE_INVALID;
> -
> -	/* 0x0 - 0x7FFFF */
> -	if (start < 0x80000) {
> -		idx =3D 0;
> -		idx +=3D (start >> 16);
> -		return mtrr_state.fixed_ranges[idx];
> -	/* 0x80000 - 0xBFFFF */
> -	} else if (start < 0xC0000) {
> -		idx =3D 1 * 8;
> -		idx +=3D ((start - 0x80000) >> 14);
> -		return mtrr_state.fixed_ranges[idx];
> -	}
> -
> -	/* 0xC0000 - 0xFFFFF */
> -	idx =3D 3 * 8;
> -	idx +=3D ((start - 0xC0000) >> 12);
> -	return mtrr_state.fixed_ranges[idx];
> -}
> -
> -/**
> - * mtrr_type_lookup_variable - look up memory type in MTRR variable entr=
ies
> - *
> - * Return Value:
> - * MTRR_TYPE_(type) - Matched memory type or default memory type (unmatc=
hed)
> - *
> - * Output Arguments:
> - * repeat - Set to 1 when [start:end] spanned across MTRR range and type
> - *	    returned corresponds only to [start:*partial_end].  Caller has
> - *	    to lookup again for [*partial_end:end].
> - *
> - * uniform - Set to 1 when an MTRR covers the region uniformly, i.e. the
> - *	     region is fully covered by a single MTRR entry or the default
> - *	     type.
> - */
> -static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end=
,
> -				    int *repeat, u8 *uniform)
> -{
> -	int i;
> -	u64 base, mask;
> -	u8 prev_match, curr_match;
> -
> -	*repeat =3D 0;
> -	*uniform =3D 1;
> -
> -	prev_match =3D MTRR_TYPE_INVALID;
> -	for (i =3D 0; i < num_var_ranges; ++i) {
> -		unsigned short start_state, end_state, inclusive;
> -
> -		if (!(mtrr_state.var_ranges[i].mask_lo & (1 << 11)))
> -			continue;
> -
> -		base =3D (((u64)mtrr_state.var_ranges[i].base_hi) << 32) +
> -		       (mtrr_state.var_ranges[i].base_lo & PAGE_MASK);
> -		mask =3D (((u64)mtrr_state.var_ranges[i].mask_hi) << 32) +
> -		       (mtrr_state.var_ranges[i].mask_lo & PAGE_MASK);
> -
> -		start_state =3D ((start & mask) =3D=3D (base & mask));
> -		end_state =3D ((end & mask) =3D=3D (base & mask));
> -		inclusive =3D ((start < base) && (end > base));
> -
> -		if ((start_state !=3D end_state) || inclusive) {
> -			/*
> -			 * We have start:end spanning across an MTRR.
> -			 * We split the region into either
> -			 *
> -			 * - start_state:1
> -			 * (start:mtrr_end)(mtrr_end:end)
> -			 * - end_state:1
> -			 * (start:mtrr_start)(mtrr_start:end)
> -			 * - inclusive:1
> -			 * (start:mtrr_start)(mtrr_start:mtrr_end)(mtrr_end:end)
> -			 *
> -			 * depending on kind of overlap.
> -			 *
> -			 * Return the type of the first region and a pointer
> -			 * to the start of next region so that caller will be
> -			 * advised to lookup again after having adjusted start
> -			 * and end.
> -			 *
> -			 * Note: This way we handle overlaps with multiple
> -			 * entries and the default type properly.
> -			 */
> -			if (start_state)
> -				*partial_end =3D base + get_mtrr_size(mask);
> -			else
> -				*partial_end =3D base;
> -
> -			if (unlikely(*partial_end <=3D start)) {
> -				WARN_ON(1);
> -				*partial_end =3D start + PAGE_SIZE;
> -			}
> -
> -			end =3D *partial_end - 1; /* end is inclusive */
> -			*repeat =3D 1;
> -			*uniform =3D 0;
> -		}
> -
> -		if ((start & mask) !=3D (base & mask))
> -			continue;
> -
> -		curr_match =3D mtrr_state.var_ranges[i].base_lo & 0xff;
> -		if (prev_match =3D=3D MTRR_TYPE_INVALID) {
> -			prev_match =3D curr_match;
> -			continue;
> -		}
> -
> -		*uniform =3D 0;
> -		if (check_type_overlap(&prev_match, &curr_match))
> -			return curr_match;
> -	}
> -
> -	if (prev_match !=3D MTRR_TYPE_INVALID)
> -		return prev_match;
> -
> -	return mtrr_state.def_type;
> -}
> -
>  static void rm_map_entry_at(int idx)
>  {
>  	int i;
> @@ -532,6 +384,17 @@ void mtrr_overwrite_state(struct mtrr_var_range *var=
,
> unsigned int num_var,
>  	mtrr_state_set =3D 1;
>  }
>=20
> +static u8 type_merge(u8 type, u8 new_type, u8 *uniform)
> +{
> +	u8 effective_type;
> +
> +	effective_type =3D get_effective_type(type, new_type);
> +	if (type !=3D MTRR_TYPE_INVALID && type !=3D effective_type)
> +		*uniform =3D 0;
> +
> +	return effective_type;
> +}
> +
>  /**
>   * mtrr_type_lookup - look up memory type in MTRR
>   *
> @@ -540,66 +403,36 @@ void mtrr_overwrite_state(struct mtrr_var_range *va=
r,

This last chunk of this patch is not applying correctly for me.  'patch' co=
mplains
about a malformed patch.  I manually edited the changes in so I could build=
 and
test, but I'm unsure if something might be missing.

> unsigned int num_var,
>   * MTRR_TYPE_INVALID - MTRR is disabled
>   *
>   * Output Argument:
> - * uniform - Set to 1 when an MTRR covers the region uniformly, i.e. the
> - *	     region is fully covered by a single MTRR entry or the default
> - *	     type.
> + * uniform - Set to 1 when the returned MTRR type is valid for the whole
> + *	     region, set to 0 else.
>   */
>  u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
>  {
> -	u8 type, prev_type, is_uniform =3D 1, dummy;
> -	int repeat;
> -	u64 partial_end;
> -
> -	/* Make end inclusive instead of exclusive */
> -	end--;
> +	u8 type =3D MTRR_TYPE_INVALID;
> +	unsigned int i;
>=20
> -	if (!mtrr_state_set)
> +	if (!mtrr_state_set || !cache_map) {
> +		*uniform =3D 0;	/* Uniformity is unknown. */
>  		return MTRR_TYPE_INVALID;
> +	}
> +
> +	*uniform =3D 1;
>=20
>  	if (!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED))
>  		return MTRR_TYPE_INVALID;
>=20
> -	/*
> -	 * Look up the fixed ranges first, which take priority over
> -	 * the variable ranges.
> -	 */
> -	if ((start < 0x100000) &&
> -	    (mtrr_state.have_fixed) &&
> -	    (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED)) {
> -		is_uniform =3D 0;
> -		type =3D mtrr_type_lookup_fixed(start, end);
> -		goto out;
> -	}
> -
> -	/*
> -	 * Look up the variable ranges.  Look of multiple ranges matching
> -	 * this address and pick type as per MTRR precedence.
> -	 */
> -	type =3D mtrr_type_lookup_variable(start, end, &partial_end,
> -					 &repeat, &is_uniform);
> +	for (i =3D 0; i < cache_map_n && start < end; i++) {
> +		if (start >=3D cache_map[i].end)
> +			continue;
> +		if (start < cache_map[i].start)
> +			type =3D type_merge(type, mtrr_state.def_type, uniform);
> +		type =3D type_merge(type, cache_map[i].type, uniform);

This determination of the type isn't working for me in a normal VM (*not*
SEV-SNP) that has MTRRs and produces a reasonable cache_map.  The
cache_map contents are this:

[    0.027214] mtrr map 0: start 0 end a0000 type 6 fixed 1
[    0.033710] mtrr map 1: start a0000 end 100000 type 0 fixed 1
[    0.040958] mtrr map 2: start 100000 end 1100000000 type 6 fixed 0

The lookup is done for start =3D f7ff8000 and end =3D f7ff9000.   cache_map
entries 0 and 1 take the "continue" path as expected.  cache_map entry
2 matches, so type_merge is called with type =3D MTRR_TYPE_INVALID and
cache_map[i].type is 6 (MTRR_TYPE_WRITEBACK).   But type_merge()
returns MTRR_TYPE_UNCACHABLE because get_effective_type() finds
type1 !=3D type2.

I don't fully have my head wrapped around your new code, so I'm just
pointing out the problem, not the solution. :-(   Or maybe this problem
is due to the patch itself being malformed as mentioned above.

Michael

>=20
> -	/*
> -	 * Common path is with repeat =3D 0.
> -	 * However, we can have cases where [start:end] spans across some
> -	 * MTRR ranges and/or the default type.  Do repeated lookups for
> -	 * that case here.
> -	 */
> -	while (repeat) {
> -		prev_type =3D type;
> -		start =3D partial_end;
> -		is_uniform =3D 0;
> -		type =3D mtrr_type_lookup_variable(start, end, &partial_end,
> -						 &repeat, &dummy);
> -
> -		if (check_type_overlap(&prev_type, &type))
> -			goto out;
> +		start =3D cache_map[i].end;
>  	}
>=20
> -	if (mtrr_tom2 && (start >=3D (1ULL<<32)) && (end < mtrr_tom2))
> -		type =3D MTRR_TYPE_WRBACK;
> +	if (start < end)
> +		type =3D type_merge(type, mtrr_state.def_type, uniform);
>=20
> -out:
> -	*uniform =3D is_uniform;
>  	return type;
>  }
>=20
> --
> 2.35.3

