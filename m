Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB229664482
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbjAJPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbjAJPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:22:35 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7141788E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS7XQICSqFgu+3OCNVMM5f6DRurv9Oa1OzBjFSw6zgQKodV2qbCpznDN5GlvHYOKBETloqCXFJbO+tyq1VsCzmnNzKAOczTovvs204vQT9+I8UGJJV3np9EczK7unp3mPqEWDo+wyV6Sd7f5mxHaJdvR3AibBKElqIatYFfjD2WmyiQ52c2bP0lApbJm2YB9B77wOb48JeQRul1OApucdkbQtfLryoESruKjFHDim4E29SINfHX0Hc6AwJzaDCZ3Yw+7hg52VDpi8aFKfQ0ITka9tDb6325ON/LiTM43323avLHkOEMv+xJmlM7xLsNedOCP0OL5+3SLNpVpo3Cqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVjL/qiavLOfUhHpAs9qTk3d9eBRp5JhVoS1GkVfx/A=;
 b=bqsg4lIqKGwqXnnZ8yGXgdN5NMoxeyTxHOxcgWiEepVz4aZFy8qxhWUKfRM32dVzhJ4TyEYFqRFcykQWzWmJoO3FNnRsll0gnb2U1G+Fr23j4G6FcmK61n2YPrXNelynMT+HW/vbBLpjde+C1HyTZbW9lng1aGR+MLm7gxi+jRg47ARtR/LhUO3fmD+6uCrB18hLZpjRzFUL1VVovISzEGjHGU/mr7JNJBfSTLh3vcImeZVK1eaCJtE4+B+bpVBq0JTY3KeArQqMDOMfCVa/Rn28SbPb8MOU/PJupzSZ4XGqFMMAWpQ8BiL1JcJpHaRs42saQm2pQYgccWSMGJtlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVjL/qiavLOfUhHpAs9qTk3d9eBRp5JhVoS1GkVfx/A=;
 b=imi2NIVF6yxAISnHXOaUQnrwtp0CS8e5NpBbK9gyrH+Pgz3i/U0Y765qY5obdONDuYdLu3tPgfenGlKq18Kkal9sIPH4FxA1aiGYNTkKJdmT3Ywgf5/U4zx7ou/9KGi3MNNClK3LZpynvuTKAumEoTqD4K2lWhvaW7GmHJe/Fpk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB2005.namprd21.prod.outlook.com (2603:10b6:510:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.4; Tue, 10 Jan
 2023 15:22:31 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%7]) with mapi id 15.20.6023.004; Tue, 10 Jan 2023
 15:22:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH] x86/pat: fix pat_x_mtrr_type() for MTRR disabled case
Thread-Topic: [PATCH] x86/pat: fix pat_x_mtrr_type() for MTRR disabled case
Thread-Index: AQHZJMBmxZ2wfUHQ3UWiDX8chmoK+66XwvYw
Date:   Tue, 10 Jan 2023 15:22:31 +0000
Message-ID: <BYAPR21MB16888940067E4363B1321D85D7FF9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230110065427.20767-1-jgross@suse.com>
In-Reply-To: <20230110065427.20767-1-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1f557fb9-7c87-433b-bede-7fa6285b1692;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-10T15:14:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB2005:EE_
x-ms-office365-filtering-correlation-id: 413afac9-8407-4a6c-fbdd-08daf31e7e00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gGSPdyt23EakMIaJK563zYpZ3KomlM4AAjIczti4j3CL5/0A+njjLgrCa8IxxrplM9Huz2jkI9ZCe5twJH2FYl9Ahf6BVhAvaPN7pFl4MLXFyPgDUZl/CC95MKQAxMVwoVHCR9m9bJDSvjk7nNi2kEK1RHT800vfFipc1Yi/8aGGdExg2VRrLInryZuXYvuyQqeWzYzOXzqiPHU5ocxX7Vpelle3LJBA9koJSZJ92BWCANOwj0786TYLE+pLf7ZkwSqLHN4pOE0NkdkS6CWKjq1cq6DDz7JxzIiQZwobQ2uC6j0R4eLD4EPdoyrjGyhV7jIrbRw3q7sGlYEwdoRbFbuIdhBJBmEOcxeRVnHdrVMIGy7bjV8xavkoUR+wUARBRq297XR1zgilW+4RhP81epBHttRVpK5vquqGey1ldMhGjHsdqpSLreQ23e6Q3qP6aK74VI+39/Ez3wVBkRnrk33dMiCtFS7ey2SRS3+jO8Z8PDfv/lAyylUt5CP7dhzHdruhvEuVgaKFJnTXIVUZaXRCFwuIMMmdDJG+axcHxUArIOShamrLffShdNky2V4ATkQZfUp6MV14t/r4yUAhC/zK/SlA2yAL3VKET8W3BAAl2iL+rj8o6CRhnwM36RuH4Xb7ifzkeNWMyunBa3ieKKnwQaHlcRTt3RJUhJAIGYxlQ5GMufS2xUgmNT9AphHdfuYHoXBi+2uYfWI5k5CX5BpocwK5j5k7Jr4u85lR3ZLJySBVbSdkXB2DxZiHcJuc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199015)(33656002)(54906003)(110136005)(478600001)(10290500003)(316002)(86362001)(38070700005)(55016003)(38100700002)(122000001)(82960400001)(82950400001)(83380400001)(6506007)(186003)(26005)(9686003)(5660300002)(7416002)(66446008)(64756008)(2906002)(8990500004)(7696005)(71200400001)(41300700001)(52536014)(8676002)(66556008)(66476007)(4326008)(76116006)(8936002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tV7n0ohyai0f9Zr1TI2a8QkbwKhlLhTuHB6F+K0AGcdv+LhPLGnvARKNJWdV?=
 =?us-ascii?Q?qumLDie6bnQ73SzjqABtRgQg62U/wmgNsBhRy0b/ISvBeJ18bQ7rSauEWK2j?=
 =?us-ascii?Q?lWBcgtMBVQA4a6ZlnuqQvH5Macu6M0YF2VJdBLSVmlFJJMAXXzQeEUFtGNbX?=
 =?us-ascii?Q?3RH/wKLABaUggXtCfldc84SPFB1bw0G1Bb/kut2sQtoBvM3/ssHSqeyXV1/T?=
 =?us-ascii?Q?hYNGJJWxtyc8evAgswDuJK4A5a45zQx7gPODLFyW3HGfZ3aI/P8AQovh6d1z?=
 =?us-ascii?Q?QhWDTpukdYcFwPkbTxQQmeD3jCRpqdCEIWfAciCyhTwlfp9QljK3pnsAA/ij?=
 =?us-ascii?Q?acNCEQSwn2BwCown145h704DWQWkDx6oabT2XrqAALyjwgfvebBgox6uwdKL?=
 =?us-ascii?Q?AeWfrNMgkx/CvoJ16AmwdCiMXoFV9nILYrGZBv+c7Z0RyQwtTMbR0aaGhIwI?=
 =?us-ascii?Q?OG0ipoP282USOw9ZPFT+d2mQaiwydmjz3LlYhE4bb5jeMw/q4J6ZhjQHfwGE?=
 =?us-ascii?Q?W7p1dl8sefelqXS4UDKTPWRQTE2aS7hO4ps5Ym2WqSa7WW5s/h++VBxAY+Qk?=
 =?us-ascii?Q?5mqNMMdjre/5pp+UgpGjilb+Q3HHHnwEDg205Ji8ofAKJglxwEdideblE/PE?=
 =?us-ascii?Q?bOx0lAMy1tLiRqoPOiRsi7kCUAMY67PJG1GPQmV121gN8fl42gkyXOrcMmZ1?=
 =?us-ascii?Q?iosuJY/aIHQQ7cCiizD+xJkb26Sh+IzQCbpC+y0iV6taKvf/cvaePGBbcFfB?=
 =?us-ascii?Q?CgnYtpVbxDvWCV2bzMLzpRR9E2aJaK0dzH8QU3t+hLM1VTkNxVlro+3rxpTe?=
 =?us-ascii?Q?e2cf7SIKtQhMH1Mx85fuApal/a2yLadr8yAfYsxBKfYfr3u7Ate8DWx4Lpwm?=
 =?us-ascii?Q?ajBK4OuC+8oJfYqoCpmMh7l5mOyQNeRjc9vy5OpANAuxIThJuhx5cZ/YuVMH?=
 =?us-ascii?Q?cgVMRXF+Xhovz57eivsIy+c5B4F6TzVK76/MuEQXQAWX+GwgEmhX8ojw8kzJ?=
 =?us-ascii?Q?bwIuN56qF7nRvxGYHlz5iDtsCwiDEOGpXKjuy5iA4ANXDkidzxI6tL4yOQFM?=
 =?us-ascii?Q?MWoQTqCAkSAu1RJnLnf1TgQvLc+AQIqNYbukbT3WGI2lfWuLw+cUpc0dmq6+?=
 =?us-ascii?Q?02JB8+A4P7wk0LCTe+bPOeLvIQAvvSPJ9P9Zn2N4g5VUvTZ/LG/dGw2VGMg2?=
 =?us-ascii?Q?d7KVdX+mRwAt93Oi9by2cNNYQB3qlQAS2S1+StcVCpQ9CWNHfcPZ5XFVDQ1h?=
 =?us-ascii?Q?LfJ+JZskiTx0+v1Gth5YeXteCwtoOc4CAB/pPTEcJq4akY3AKA9Ba2tBkkFo?=
 =?us-ascii?Q?TRV0Q3vEb3A7wxhb+2R8VnYcoNlR04O+6Uo8M9cp7uM+lFaHdHAdr3imcF49?=
 =?us-ascii?Q?MaOgYwZViBR+47Wdv2c4G2Js4M8nZ8pJbW0UXQIDd7CQ4hsMkn6qEoMw+WtL?=
 =?us-ascii?Q?G4LF7XL0Qz4wOcEClhBkH6WbJO6AHuntFtQ5oRbrD8QtD7dmPPZU24iSHjQ4?=
 =?us-ascii?Q?JQU4C0qO3/XHl7jtHT1YAhP0qQnI9cRD6kz+hRDAUr4c6OftXOq7FULP6F/1?=
 =?us-ascii?Q?0mp0tlDC5Dm252biCWhtbST8PnM2sh3AYnNj04BMi9JqB8h6ysD0VeBhTOZy?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413afac9-8407-4a6c-fbdd-08daf31e7e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 15:22:31.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnjHfOQboFK+w0Vq46MegQkwfTYU+Q7752nnC2dp+9l4f6ICmN8keFSxB8ZyuMT4pizP6FiTzxKD2K19LsT25IHFRWu88Y14UHIx2dEcNZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Monday, January 9, 2023 10:54 P=
M
>=20
> Since commit 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly
> reflect state when running on Xen") PAT can be enabled without MTRR.
>=20
> This has resulted in problems e.g. for a SEV-SNP guest running under
> Hyper-V, when trying to establish a new mapping via memremap() with
> WB caching mode, as pat_x_mtrr_type() will call mtrr_type_lookup(),
> which in turn is returning MTRR_TYPE_INVALID due to MTRR being
> disabled in this configuration. The result is a mapping with UC-
> caching, leading to severe performance degradation.
>=20
> Fix that by handling MTRR_TYPE_INVALID the same way as MTRR_TYPE_WRBACK
> in pat_x_mtrr_type().
>=20
> Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state =
when running on Xen")
> Reported-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/pat/memtype.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 46de9cf5c91d..fb4b1b5e0dea 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -387,7 +387,8 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 e=
nd,
>  		u8 mtrr_type, uniform;
>=20
>  		mtrr_type =3D mtrr_type_lookup(start, end, &uniform);
> -		if (mtrr_type !=3D MTRR_TYPE_WRBACK)
> +		if (mtrr_type !=3D MTRR_TYPE_WRBACK &&
> +		    mtrr_type !=3D MTRR_TYPE_INVALID)
>  			return _PAGE_CACHE_MODE_UC_MINUS;
>=20
>  		return _PAGE_CACHE_MODE_WB;
> --
> 2.35.3

This looks good to me.  I've tested my specific use case of a SEV-SNP guest
running under Hyper-V, where the MTRRs are not visible in the guest but the
PAT is functional.  Previously, this use case showed many "uncached-minus"
entries in /sys/kernel/debug/x86/pat_memtype_list even though the mapping
requests were made as WB.  With this patch, those entries show "write-back"=
,
as expected.

Thanks!

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
