Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1B68E8A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjBHHAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjBHG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:59:59 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11012003.outbound.protection.outlook.com [52.101.63.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EBE457C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:59:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZPr/p+1TKOesTJseEoTvh3AMgX/BwBgsi13pUJ3R4zbOYB9x7zCcEgUczMaSAo81MElBCabKrmEqqZg3CAspcjV/iWeTIjHOBvXSZseDq8zUAlM4MczkBW6VSBhtNjsEy+untOZOy+LMAErZjZK/XAZhFzs5OVa2Z41YUc3UXUKBtzeA0pMA7ExK2ib+3O3Z+7pMYeXMHRWtDmbrZt7JDheMoxpqwzW7tg+QrbMzz/aauKbZZgQBpNnRa4jGtGkYm5yT7s3wtHBMdlOD1ORX7TqVrbbwtR4BuCEgXURfR3iasZQL7n2GjZEemOlUA/bQVXL5GSIIuDhNGz2QwX2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/kPtjqxq4GyD0iCdVnSdWL5jXNEmR4c8NPMzVx+094=;
 b=CiMxIz1Y84AFlZqLsu738j4FiVczLKU0u+7BbnpAlhfgDsG/bs4QsV8Lp/WUxXX2NmAM95Q6pP9LEopAc+5WV7ry5F7a9RkQ+7+2awd9VxGyKxqT3LtwJqYw9WRh6TTbb96+F4IZ15vJlYBaL2FbfmI8pKO/cwu7bf9HjSvuLWKYua470j9fzIPMkbd4mdTOC9yn0sNWYesArbGRt6N84j76zbJsngG6LqyCA2UVJWW05RRjw/y1euugheiVreIXH3iCZdwSVE28N8ePtc9SDtXar5aMZgyrlb6ln7csRn4t1jtgxvWIRJmdsjRp9iRxBExHXBKFYmUZz4J7zFCfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/kPtjqxq4GyD0iCdVnSdWL5jXNEmR4c8NPMzVx+094=;
 b=e7VjAuwDxWVizHFF/tuUKDxT8CXKUaUvdd08zUfMoYXIjjHBT7TW0bjtfIrEt4EveE6cb7VUY5eny76WadEy82d2gLE+ZFdebgDi8kuCSWNV0bWFOfol4gIcINmo3wB9BnOGImEFJISN/NC6tB7Ws4exF6i05dqBVwqaMmBsU9Y=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BLAPR05MB7281.namprd05.prod.outlook.com (2603:10b6:208:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Wed, 8 Feb
 2023 06:58:45 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::624:f4e4:128b:fa0a]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::624:f4e4:128b:fa0a%7]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 06:58:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Thread-Topic: [PATCH] x86/kprobes: Fix 1 byte conditional jump target
Thread-Index: AQHZONzOlqQ9zgLH5EacMBCbCDIQPq7CQ9CAgAAGPYCAADuhAIAAJgkAgADyRgCAAAN3AIAA+40AgAAGTACAAAB+AA==
Date:   Wed, 8 Feb 2023 06:58:45 +0000
Message-ID: <835C41C0-7E42-4220-8F21-D8419937CBEF@vmware.com>
References: <20230204210807.3930-1-namit@vmware.com>
 <a75c134d-8278-b17c-e05e-409b70ad15b0@intel.com>
 <C4863EDA-106B-4AF9-8D39-D603EEE4BEDC@vmware.com>
 <dc964552-dca7-dd83-52a2-283be7f51555@intel.com>
 <20230207095424.42f4c0147f693a8cef25757c@kernel.org>
 <20230208002132.63b70cb9d6e5badad45fb828@kernel.org>
 <9fb39b3a-2edb-7fd3-2b7c-3a347478083f@intel.com>
 <B790D31A-A0BE-4707-BA01-398B5668C3D8@vmware.com>
 <b1300308-8f29-fa73-5542-25d06925ca84@intel.com>
In-Reply-To: <b1300308-8f29-fa73-5542-25d06925ca84@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BLAPR05MB7281:EE_
x-ms-office365-filtering-correlation-id: 89d29153-e34f-41cb-c1c8-08db09a1ebd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +JoAAuJuodGkttj3zjyVx37Mvn6djxvwOFs6DSyhGhafUnHqBdvA/okQAanS+xne353mYLx2n0wFUeL0zfUyLPArVO3Et2bamWAWzWenM3wWKGwH2LQ6EeW/fmUkmaVpH/ezBXdBJ9mLmLG9e9Q17ipKLuKv/yK+hg1G21/TnMxGzGYPJtSIOX4nYNpsp04DY9vO5ev6jWxnnRkU2syTMbSXAUufl26bSvaadEhsPAHd4+cHdCqfABAtRO4UEFA7G7LPVx/txtNMRJGScr8J+U1axR9un5hZlPXpkGQ8qNKCSPL8WKp5+L76wJ57hAOWbM3u3ojZqaFVZhHVcskghEzGcnHtr4glmE9+Jj85irNL7wFvvAjiD7oB/scRg4V8TxkAACLy09LmNgFbrFI2GF4XzrQ8QbPM44cT5XPwYR8VnIC3g6C/79xX0s1T9vu1jz7vBLAyhfcD/+KbC0pGaIby8XWV4OZ6vDDSJgYAcPWvYrvIf5qPs8VgcV5ZjWRMujr3K7KUtXaZI0V0sDzusmt95HbifZuk7vCB8H6+et4FvyBkfjfRquQb/mCz4fK0qiP0Kvs+o8DWvorhVEoPbazSVXiz4h2mLQID3Mo0g4816b/9yXEeKNejbgBXQzMx4bcoCRnq1qoIWD+5RJvoXk41CtuoBFDGx0knHnp5Cw5ElS/dpTdl5KHByDeFKU86GCa7+CgG9kUpPmmkNgRwGVqasKyepRruv4KmVHDvrPtoNeCdbq4npafI/BsZNyYHIbCjEAjWjQuYxLY06XRmYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(5660300002)(6506007)(86362001)(53546011)(38070700005)(4744005)(26005)(6512007)(186003)(8936002)(2906002)(8676002)(66946007)(64756008)(66446008)(66556008)(66476007)(6916009)(4326008)(76116006)(91956017)(122000001)(38100700002)(41300700001)(316002)(2616005)(478600001)(71200400001)(6486002)(54906003)(36756003)(33656002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pbqlhbjxWNncdFUW7lemIZSXRehe1KYijQsgz3u0mjDieAdAnyYGrMRSe31p?=
 =?us-ascii?Q?1cHESIY+5GcD3rwTnzldGqF9jXNVbRGUEZlgO/Emymy8+NMCivTXigoGjN9d?=
 =?us-ascii?Q?ayfp471XYo1ePsFK3QtjezhtK0gVOC3tuGNps9w1AAUcfn31HaUzIXwBvjZY?=
 =?us-ascii?Q?C4SHKWG10AYP5j95hdtneoRWSq7/M6A7VTc5DOKZXkvhezc6jLYlv+blBQcj?=
 =?us-ascii?Q?RW+NiGUbrhxOtXR82kQDIeIdWoyY4udq7WkOKN6POw9NJDtq4RDwXI8ISpA6?=
 =?us-ascii?Q?HGSMWalBMeWv4y0pAoFzvZdmaNcXUpvoVs6PsEtsPFEnrFzJ+i+kXnVlTPGA?=
 =?us-ascii?Q?qHQU8Nizk+ZaQNnEcsEQecu720476a+yxVZMKMNLg2yeYN8R4fYAf25mvN1J?=
 =?us-ascii?Q?MHphashNlCHL4g3TN1+t9S5TF40ETvnhEROUe+JYBKUtDYx3DZXrv0Vwlqos?=
 =?us-ascii?Q?0Kx4zZWlbgogxsRaREC53RtjiTvu9YqTSgrh5KllEerqKdEbG2hrZF7ZKIkS?=
 =?us-ascii?Q?bAL/E1+URxQ0c1s1sH/lkc1diezlFAXKE82z20OKAt++eXNntM+WZWTKz3nX?=
 =?us-ascii?Q?3vG3Ym8nXunt5hmxlCY6etgoXEV9IpoT63HoZdL0b7RiudRCMmPl6VCWYdIm?=
 =?us-ascii?Q?W8iqb0sRNibiC7gpOrLtMbKFUbwoYsWS9UavswemlVGz9B/gX/82rQ+okiM8?=
 =?us-ascii?Q?tCmQPGAZv7mcYPCmtmqU8vuGJj+W27MovYrW5qs6su+C2YdJkszLSdgk2tpA?=
 =?us-ascii?Q?YmALMdt4BG5E+QOoj5jpakvgNKSHpCBZKub9+Z26rakh23y8Mmcic4rzpsSH?=
 =?us-ascii?Q?K/94xC/LKsQ7KUJscQeY7YFaU5HxyJLNfDAhq4BgQD02GG8NhHiAi6SOuBfX?=
 =?us-ascii?Q?OcSG/87y2DI2awF9s1L5eQFzuwkTR0jvLZIOmd6hrFySmTEqk/dLLncGqtm8?=
 =?us-ascii?Q?3VAZgPMdzUUD74CAYjSL9EsNpWB3/fYrmoqqWERjXYauf69/vK0EVBZRa0Xu?=
 =?us-ascii?Q?OfpOV3RCqV+MyTikg7nntG3JkEK5Rz0VpfgkpLtTbl2rIzEpBsNDHPUeUm0s?=
 =?us-ascii?Q?FR9UT/gXkgS8/TpPpyRIyiWMfS6Hj6BdsItlu41/VYwQXvwaEdHq7d49pucM?=
 =?us-ascii?Q?QDn9Ygy7ChEzPeGWn9MvY8zU0ujDXjnbC6KrXDC0oIQohSuzp00YOQdMC+9/?=
 =?us-ascii?Q?aJYRunJZGnGdIeb+L/aiJoe8TD1vrjZRAM8WMhmRIHe61rG3tx+URe3+icYw?=
 =?us-ascii?Q?jusBUgftz9dxZSrde5XkEKYUgg+bXxu9xe1HcwDAN3ob2rbsadNKmesloyg8?=
 =?us-ascii?Q?ECrvmendxCH9ayzIH8Uh/0Y1cK1/H6MobuQIp8Pky6O8f7IbL/1NrnwewIiI?=
 =?us-ascii?Q?819rk92xUFGwHqwPxUlA1geFnPEZeJ/mFihkCEnC33BhAixU/pQPtFYamaPX?=
 =?us-ascii?Q?LAtfEU/nBmlK2Z4On271atNC2zl46T2DNcGIhtTgSYdhnetFEFmJJzWrkrTf?=
 =?us-ascii?Q?H7+GG5KH1ZUL09nIEPATE4OG4JkIJicObAIZQ2apxolwpjefG/GQpJsHdlTA?=
 =?us-ascii?Q?rY2V1H7omLzyUJPeHdoJjXuFFcztBi5rhdH76IkA?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <812C20612F29FC458C321F92112C9489@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d29153-e34f-41cb-c1c8-08db09a1ebd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 06:58:45.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwsDa+QeIcRMl+j80jOo53lhPVOg42axtNzCcacj96jHQWaqGpsminGIs6nbBnlNDhUMr2DMozUADsSQuYSlZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR05MB7281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 8, 2023, at 8:56 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> !! External Email
>=20
> On 2/7/23 22:34, Nadav Amit wrote:
>> As you said, I guess the change you and Masami proposed can be done on t=
op of
>> this patch, which is (and was) only intended to fix the bug, and should
>> therefore go into 6.2.
>=20
> Nadav,
>=20
> To fix this issue, you proposed:
>=20
>        p->ainsn.rel32 =3D *(s8 *)&insn->immediate.value;
>=20
> But, this is, um, rather obfuscated and potentially less correct
> compared to:
>=20
>        p->ainsn.rel32 =3D insn->immediate.value;
>=20
> I'd appreciate it if you could update your patch to do this simpler
> thing and resend, unless there is a strong reason to do what you
> originally proposed.

I thought it makes sense to make this change for all the other cases
in one pass, but whatever makes you happy.

I will send v2 soon.

Thanks again,
Nadav=
