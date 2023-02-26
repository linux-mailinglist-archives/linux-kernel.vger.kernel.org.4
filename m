Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA2D6A3306
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBZRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBZRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:00:51 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45735F777
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 09:00:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwTQdRU7q47hu6zn6J20Rlx1O/jU1RpT5Hix2At8yiZeKrwf8Llj6+H4UgdOd6HEfGdbhmhOnB1c+FArypyp8PDXwgtGhgbx6uFK8txjJkiHl/z5qxw9K3eVc93XaFbo8p/Cnwa0RgDafFhzD/moOTtBiwlrlryAl9hZJVRR6JaTMW5QRb0MJtJPtRko2YG7flPYg+91q+Dbqsh6KMsXkJUxISekKJnPoz++bY61MgZJ0vjk7cs3Ka5rU4W7jPV5Jeyvw/qB2Ca8YOl3+Fc1RADNEPhsEnu83yBPMDUgKiI5609rKYgy53g3g94YZjM84dKu+oWk9YR9WSZv/qqySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QzqMtBbvFwF0zo8W9WPV05kF5/MODQHVRJmO0kJDiM=;
 b=AIWOjCMQt5PRU5cz3JErR60vxf5ISevkr1TyyvtfVfyJBxyCujTo/WVoECHysw46hrLrk+FTovC76CZyeqcTbf+QP3OO5hZFl6zZ6DFaff7clEAIpDVEMbAWVL3U5rNMGzWHTJANAoP/bSGzvZekgeRf15FIZYr6HeHlDTPQU3UQfh9WvHt7JOsMqvBhPkNoNMKSRsRT3+TM3m3/duSAJ+/kGIYXMkkAsAHxeGTrMNxAox1l0Q8EvKudyGu5YRJDoZMuCLW4RE50fnHSNJqQAM5G5LpuNW5Qyu0P+9qc5YcCCPwk3oETJRsRIw3lRNRELwx8py1lbntZcVVV69N78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QzqMtBbvFwF0zo8W9WPV05kF5/MODQHVRJmO0kJDiM=;
 b=L9yO+OHanale44v4jnbn2cdWul70qoNFAIFMs9/5acOwOfBIVsRN5KztW0QAkVbLvZgcxQQ9HTgFmP7yWp+B8sMlOwEVIJjgwV56wZevfR6Ni6a/1cPdAJ6b4h4J+5g4B8iO7QJh6tdYDsi9vVFLPcTce56SCtnzt+lE7rkq3o4=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CH2PR21MB1383.namprd21.prod.outlook.com (2603:10b6:610:8f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.2; Sun, 26 Feb
 2023 17:00:46 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%5]) with mapi id 15.20.6178.000; Sun, 26 Feb 2023
 17:00:45 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v3.1 10/12] x86/mtrr: use new cache_map in
 mtrr_type_lookup()
Thread-Topic: [PATCH v3.1 10/12] x86/mtrr: use new cache_map in
 mtrr_type_lookup()
Thread-Index: AQHZSBqCFz+cKKJGUke2Lm1BNzHLIq7hdHqA
Date:   Sun, 26 Feb 2023 17:00:45 +0000
Message-ID: <BYAPR21MB168858E9992B909FB7A8D7B8D7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230223093243.1180-11-jgross@suse.com>
 <20230224063718.27666-1-jgross@suse.com>
In-Reply-To: <20230224063718.27666-1-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7cdb1a9b-8b04-447b-96fc-9f723270fd53;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-26T16:49:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CH2PR21MB1383:EE_
x-ms-office365-filtering-correlation-id: 855ac791-1090-43e7-4fb7-08db181b007b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/HkbMcfOod1P01S3PRpUIgw2689WLsK8PsyPR4+FbQQzSp7KobQcSoYfa/Jm+AlI0E0cUgAwta3xkW6FubZj+ZcpR7PRlIjEaZIRVAw0c+9xf0pylbw9PYxz67wZNHrT8uDgxhTOyNQ5VRAk7bXGEGeGywVJSRxcVMj/+hyAmaQCAeovgo7OKUj2+ID53ah812WuZBbmoXASyiyslRRnWPHhkArVZx1VsdfxhXZbmI+EaGg/vNOygWz/x931UVC12/tgAHWNdbllXEye4/zSnNq7f34D2Zq6+4z8tcudNLF61Z3t/2tAMdGfoZXAt8+4DpckQzcz25nPtE66SkmgCRg+y+7uyMAKPdbq7RgmYflm79UsCE7rGMsl9O9LzZo7OC5BOy0/TP09oMj8/u4LvVKwUTJDKbELZFzKCR8VoUZhUNom7DMfhxXz8ptW0DUoWDHuxbfaMP2MxY3HoCjvI46JRGFdb1XihrzqcMdOSPnwdeoZ8e/eK/+V+5OMf34WDwodHZCk9amjC/F/b8UdAZ16TcHu27hK887JgDdHGLOHKAEK0w3z1Z/m7i6/2bXtTw5XqstKvmYb/CUsBO7HLe4RZoZKc0rn35aVY5GpIaplvdgcA5CEnQvdjcFGyEtCQSDiw5ScbxHOMTGuKWUycQQvO1AmabpFyLK1XYkWUoeLkn+by8Raxc2nbHbs8k56Ms9qYgTOeLdEa7BLSBLRXmKwmapwoepHaWzHRz9qIHJY3lirlywjy/JbKAJ+Yvr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(186003)(64756008)(9686003)(38100700002)(82960400001)(82950400001)(8990500004)(122000001)(83380400001)(316002)(38070700005)(52536014)(8936002)(8676002)(66556008)(66476007)(4326008)(66946007)(76116006)(41300700001)(2906002)(5660300002)(71200400001)(7696005)(55016003)(10290500003)(478600001)(6506007)(66446008)(26005)(33656002)(110136005)(54906003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?taDS5MQNe8En9ApMswiRbMsXuRR7kdbLW1b4NIqzZBVCEe77vT9uf93dPD6o?=
 =?us-ascii?Q?90cP6uUABokwkL1YldOeyYI47+m1h/OZhzM3lIBzy+5DnoxzVlvd8mkC+wjn?=
 =?us-ascii?Q?l9NohoX6ylu3Fjjp9F9hhUGwGWq090uMsMHo1Aa2WaLK0F65tfhm8pz0cxQy?=
 =?us-ascii?Q?Pb9LGYGyH0zn7jOmIvpCpS1odmia8NQyQcIqdP0gssZ3tci4svgrff1t97nD?=
 =?us-ascii?Q?EiXuh/QGKnpyA6Isx/ECuAgxnDf3Dzb9R6gROvFK/QoEHayjOs3GYcYSSv27?=
 =?us-ascii?Q?Dj3xY5N30GtvizFmNwZZAO9zproqkZdk/7dyTMh2GF/gHvs9CCD4UNBYOvZo?=
 =?us-ascii?Q?4FP8Nh+pDLg7b14lysFsxc8qYClMRkMXBrh1NjOkXWRXGTtNGyemHS6rEXsx?=
 =?us-ascii?Q?TgH6M7+7NkfNXE4CX/tSA++Cu3QXr5EM0anui2mhypnRn3aABupASC2o1Dya?=
 =?us-ascii?Q?IUXvbVV9x69ZdRZI413BKTCf5Tw1BQmqJEHLP3mLWxgDVsC+aifCK4iwz/BL?=
 =?us-ascii?Q?OaJS9tht/jjQcp+yN9r11NiCIIxdnetwLamA1MSXSBG9HxMWsOwLHFt2p4cD?=
 =?us-ascii?Q?IB6i8JO/+Pniq0M+FD8d9o8wOCU2JvzbTT5kQdvYThcJzIbu8K5KMt6Zj4X2?=
 =?us-ascii?Q?K50ktXeK+TgYWJFyeGKBk8LkbMAWhDOBGN+sdiTvs+EYxEfv0ExuUtm4Hz8o?=
 =?us-ascii?Q?HXf3vZQX+ztcqarVzbN4hqlyeJzZ9hErZoAnADamWJ2zQf1P1fn7rqMuGE/f?=
 =?us-ascii?Q?tdlL8T85jhyZfQvFa34zPDquNhnnPePA9zv3DKFEMjUrtA/H2vYwuQG7icEc?=
 =?us-ascii?Q?Mp3D3zhNUNttxQJ1ghAtMAlJuuXJW62YeRDvC2Rh5Iyhsp6ZzlKU8P1Y/AQJ?=
 =?us-ascii?Q?rxoLWS+XHr1kG90BpvAOEQahwrE4Ijs+XSR/eQq8U3w9W2VWrOmEAaONLu29?=
 =?us-ascii?Q?CcUr4xYv/Alwt0rYfeU/7rTnkuyY03coLA9Kra7DNJI2jV17dWwtvaHlPOVX?=
 =?us-ascii?Q?/iFgk0qoSbyXrX0AMIee5/wQwRads0iAw2Pwtn5SOnnFr0lGqNZVJCjGyLwv?=
 =?us-ascii?Q?Nqi75TzC9FyYYMbdpUL7TIcLuqDQikkcYjXAKjI52CfHzZRNY9PdhLSuhWyg?=
 =?us-ascii?Q?GsnZvsBMg6QKFgw3Gi9y2LGXmHNLaKfqVSLs1YTqB8gKd0b+6OBzwKQsVKZ+?=
 =?us-ascii?Q?SSX5hIghrm70or66soZ0rXOfzPVkSY6LU62A34IY6fGjsTmIa7NJHNjLlFIi?=
 =?us-ascii?Q?LK25V+VKcvMzfSVu/1G/cd4HZVTZTtDtP6rBRFV1qlqo43jwoQ9s39a+ZAln?=
 =?us-ascii?Q?MsmR5icic7s5ClMVhWOyUU1U07psUpXOYFyxw7UwhqxY7iGHDExOqClzKAkw?=
 =?us-ascii?Q?do+8/e2qiQlvZzP00a4/cmsyvQeg0RLYz92HaQXMOF7wg6gDULPsqN0PzlZv?=
 =?us-ascii?Q?jSgza/14VnSROhL+BA+UOyk+gD/R0b3ggOlrtpRor/cppwl8cD+UlqZvxmiv?=
 =?us-ascii?Q?EZdBtd9zxouNiYRj0pB+Y5LKtC0gAexrJrvTjCsgQJ8QjylfHk++Td/Bni6g?=
 =?us-ascii?Q?F+qv6hNkC4ahHpuzf+hCgv8GfZH4ZyBljAleNm0+EM3lEd5JUZxWQqjRZ4gT?=
 =?us-ascii?Q?9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855ac791-1090-43e7-4fb7-08db181b007b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2023 17:00:45.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsTy3HlwRVRXd20guEOwySQOgCgxGU9EpaK3zAuV1fgNqy2jPy2QFUg9S8Gjd7ujhkYLzqQMzje0AyjNTTrXTJud4iw84h6rSNV2/Pe+kC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Thursday, February 23, 2023 10:=
37 PM
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
> V3.1:
> - fix type_merge() (Michael Kelley)

Thanks.  This version fixes the problem I previously reported with a normal
VM.

However, I'm seeing a different problem in a Confidential VM where
mtrr_overwrite_state() is used.  In this case, we have no MTRRs, and when
mtrr_copy_map() is called, the copy is not done, and cache_map is set
to NULL.  Subsequently when mtrr_type_lookup() is called, the check
for a NULL cache_map causes MTRR_TYPE_UNCACHABLE to be returned.
Then we're back to the original problem where pat_x_mtrr_type()
returns UC- instead of WB.

Michael

> ---
>  arch/x86/kernel/cpu/mtrr/generic.c | 227 ++++-------------------------
>  1 file changed, 32 insertions(+), 195 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtr=
r/generic.c
> index ca9b8cec81a0..1926a9e64769 100644
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
> @@ -532,6 +384,20 @@ void mtrr_overwrite_state(struct mtrr_var_range *var=
,
> unsigned int num_var,
>  	mtrr_state_set =3D 1;
>  }
>=20
> +static u8 type_merge(u8 type, u8 new_type, u8 *uniform)
> +{
> +	u8 effective_type;
> +
> +	if (type =3D=3D MTRR_TYPE_INVALID)
> +		return new_type;
> +
> +	effective_type =3D get_effective_type(type, new_type);
> +	if (type !=3D effective_type)
> +		*uniform =3D 0;
> +
> +	return effective_type;
> +}
> +
>  /**
>   * mtrr_type_lookup - look up memory type in MTRR
>   *
> @@ -540,66 +406,37 @@ void mtrr_overwrite_state(struct mtrr_var_range *va=
r,
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

