Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81DE68E85A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjBHGej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBHGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:34:36 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44629442F8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnO3cC2rDC+oIYzuXnCDSgaKKH/ME7BRrDtMOX2gBZDpj/oPiBi5PXc0J6mC/FHjPgHmPZ6UV7zwt/UhylFXnSL0auv5CklAEyoWxXmmeTqKcyWrqQjHZV9kk4O8PSwMVsthEgz9PcBOaLhON48t5KGONU3qtOa7izQORWCjFwb3iyX2N8NvAgPuFriw5KlQxaQD75ewpPfceZvIeTq/BhGtVSaCWqK7ki4FrNhQJD5/E5jYH8dq7gWHn7Ie1tkpE6Zw32hceswMv5gEPOqRLUYUU9nwYG6QkVgGPNIXVh3skYrcCgU2PXe5VQbyrGoeNDmDFZuG9mQSxX1rXnkSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGjNKgBCp3nDhA8mrzjbRypCiJdr3k1JO2/qEfsz27c=;
 b=GN7JUvio6fObllaAlKuMIAsCZ0LZKy+MI8arnng725V68b4kfgTn3dX6RxYw1spZL2/w2VfZ5XtB/5JnQwBnv50rKUgMgGd2+FMvUd5ypkyIL1WU2RYKUmuc/EcxtPGqzHxXotAOFk3X+vlaNtyuSjRL9DXPloKGgKbYgkFKSj4O82eSGruai46QAGdBseHLC49AV+tfEs+F5SYFLKEi1iAdzy41m0eBdVRX8cVBAeW8I/MSJIcZkRiLL9b0t5A8R1Rq5ps4jJpp6/OFu5IH5Q0k5nPbLgTLdrOXD3R6MtWJ4gja/52aZRjvaJbblYXKmPn4VCTr6KOXd+F1ZTnPaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGjNKgBCp3nDhA8mrzjbRypCiJdr3k1JO2/qEfsz27c=;
 b=kYVMR2r6EzeHmD+4RtbKSQP1VtlryYd7ShjnBYqBJrerANj4Awii0NyoniMZpZ53rUYtz8uY74NNOTS0V5KDKxplPNEr9dQvJcMYEjqefHFIYsLxmK3KQNNHg1tVDY7uvQqwIvzO7/g5wS5UOsIDu6/cY78nsKRW+r7VZS9e79U=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BL0PR05MB5187.namprd05.prod.outlook.com (2603:10b6:208:88::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Wed, 8 Feb
 2023 06:34:27 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::624:f4e4:128b:fa0a]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::624:f4e4:128b:fa0a%7]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 06:34:27 +0000
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
Thread-Index: AQHZONzOlqQ9zgLH5EacMBCbCDIQPq7CQ9CAgAAGPYCAADuhAIAAJgkAgADyRgCAAAN3AIAA+40A
Date:   Wed, 8 Feb 2023 06:34:27 +0000
Message-ID: <B790D31A-A0BE-4707-BA01-398B5668C3D8@vmware.com>
References: <20230204210807.3930-1-namit@vmware.com>
 <a75c134d-8278-b17c-e05e-409b70ad15b0@intel.com>
 <C4863EDA-106B-4AF9-8D39-D603EEE4BEDC@vmware.com>
 <dc964552-dca7-dd83-52a2-283be7f51555@intel.com>
 <20230207095424.42f4c0147f693a8cef25757c@kernel.org>
 <20230208002132.63b70cb9d6e5badad45fb828@kernel.org>
 <9fb39b3a-2edb-7fd3-2b7c-3a347478083f@intel.com>
In-Reply-To: <9fb39b3a-2edb-7fd3-2b7c-3a347478083f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BL0PR05MB5187:EE_
x-ms-office365-filtering-correlation-id: 2c802ae3-5f96-40e6-a256-08db099e86c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWq/EMxnUmYzrXcnvKhWvLMmRfEZ3PhICCWo/9NT+gtQQ5SUlJ19koiml9VCWzMkPgvIe/swkQpU7k5L4dBqLxmkeaM1KR7B3Zqp0jl38uyTmyZ80JJhvpitDpaNkv2jyoDHXDuawYHyZYgyuE0FBiN3eavgTVA+osw613rgG0cE7HtrjiX/z9h6jiHlvyE//EWJUSksyIskqY0O2u6QPtvwVRxAYAM143zlLQaEFMrD2fDchpgVGEPoLKf01ZjLxwD0Gq77eGb/UHeopTEicZd93txQPyP419P8ZfWKZOryRiSlsDMAC68JWTi9P4AnXEd2wuxt1dx+w8moyZ6PxLzdhQpoJJPFwKCIPlJ9yrnGndqhSn9LuCs5eA/4e1aL16FMcOxTSj3IA9nI2wZTrA+t++Hz7C2xQhNgQUuy4MHNQKncgGVPGI4UjaNyGUbtoavNBnfU3KHKO+uJv7zSsem9jMCQL55mnF629PwzIegiME9w+FsInJxKTSV6qjdSI23szVf/npa/U+/xNONiWvwqp8sZ8bhIZEIePhKpV0wKmhGSKduvdFbeM3X0j2IWbAYF7hli+S1WzRZ0fxOqu/3il5cM4o9aG5a9ImFLjMS3lJ55CJcizgalQFcKrN9Z5UtFQ84WLR8KKbgCFdiJs9POtxdk2HT0jyEBd3xJDZhQB2ukXU4aQDLE8bLq8N0RctBdJkVbdHFhw/Aa6VjcuaWVfQd4N7kZ2YK8W4v7F7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199018)(83380400001)(2906002)(4744005)(8936002)(4326008)(54906003)(5660300002)(36756003)(33656002)(41300700001)(66946007)(76116006)(64756008)(66556008)(66476007)(6916009)(8676002)(86362001)(316002)(66446008)(91956017)(38070700005)(2616005)(6486002)(26005)(186003)(6512007)(38100700002)(71200400001)(478600001)(6506007)(53546011)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pdi3fvcmhAjqBLbQbTyyq+sl6T/0OKlMLg79yGYu4QevmgGqUnMTk7bsPgiD?=
 =?us-ascii?Q?1xgm/44zrJwy/2qGZ666u52k+K3QCvvnGixUYESWCEvTACEg9iBsvBp0epqA?=
 =?us-ascii?Q?Wp9y1d1FFhk0A/oGqPp9o7p+CpAN/ZwFguiwglqYGtgPaqwR6UKambqdBdg4?=
 =?us-ascii?Q?DU5MZRCeXHFq5s0cGnXSO1phTFIVsdcQHYRFB20vGOJpmQtM0Hkj3TIcP7F1?=
 =?us-ascii?Q?urIYdMj93Sqbtds7+Z3EZb3QWNunWr8TnxKDz9WYduCXVjbEvnvPkS//pdlz?=
 =?us-ascii?Q?1KcIpJxbIeIZbU4vuDfVy3M51IHUP3/Vg99Fam80To25maQP4kXc3DHZ6RhK?=
 =?us-ascii?Q?PzEFvGhz9JS/onPs9wvQhLII1DBidjudBYdW3luk13r1OsPe+0QjI+kTc7rr?=
 =?us-ascii?Q?/iiINzNYdx334sgx9UfIOP+VhGKPhWYnkJy+feqzOeRIFZYIfUXdEz8O6fmS?=
 =?us-ascii?Q?ZKlRXdxR4MlVP5cuQj/o2bKVCfWzpYou8b/l99VP245g8c5qh6zxEdnsXTds?=
 =?us-ascii?Q?Kd/XI2RVpoYqLXeo1OcNbS5oxhlnklHBLWF1v4VI4wqVjoQm9a25NrnvItdq?=
 =?us-ascii?Q?EPu9tO63h44cyTfJ/WvrJP86S/VGsj7IcbsPiFeCfb7Wc1c7o/9lDvoXo8XT?=
 =?us-ascii?Q?F/tTdQxn2o1TLFtr30oIhbgGTS04eRjFvxKkyodQpM8tYGef5Rsq8sjJkVX3?=
 =?us-ascii?Q?F0kctxtfp7W7oFePx3yZtH4zI6Gf3ToJh3e/X1Hq36gWJ138kdlOLfd8TFid?=
 =?us-ascii?Q?Cg5pybFhRtJcrTQmGpy2ARMURujjfkS4XrgU2Rf90RfSCyqLnZpf3vKtq0GI?=
 =?us-ascii?Q?SPZ5Vy58bC+cdVhbHOtZSiYOumAgkVBkkpLNpwWN5mMfk/RYJk4j353NY20X?=
 =?us-ascii?Q?NWGHGZWTAdnN9KaMGpkY/FQyo+Ld3zMNOTIj9oNAFC0jGrWOrKCIZNB8J8+I?=
 =?us-ascii?Q?Y0bV/i0UJmM6eziKHlT17/EVzVxCOF6De6YGAnRV57/wqyYXCxKsbZFF0y9R?=
 =?us-ascii?Q?NLym/V77ouA0uHv/OwUhVRwwC/gut6D9vcy4vAcgVOypyjan5l6pUyVyPSKM?=
 =?us-ascii?Q?N2g1cZI+ylAOzuqh3RAYShiXNwh8z3BDlzpvYcuU3u45NzU8joVAkPjpZFwA?=
 =?us-ascii?Q?fVpiPqTOckkV3dl/DHtN/CgOuJk4z1ztGmXhES0sxUlvvikX6W5Zfgioqd1J?=
 =?us-ascii?Q?wUP/TJH2claBb6tc3edy3EzGLookKku/3jV6TiWmKtum+z4ty9isBVGJfOpI?=
 =?us-ascii?Q?NH15CwfNOgyDTvR3jzPJEKEO6Yef2boizXLoDOQ3i3qOidCDqYFpNgdV4WQE?=
 =?us-ascii?Q?imfqxWhsNlqvoVBrg5waQaA/SK3ikeL3k0901U7t86rHgbunItLiTl1bM5ez?=
 =?us-ascii?Q?DekXNDr+rjZ1PP08ih9mg6CNmqaTQEqK1NoIm1R+HkB+aV86r3rTXFiVEb+5?=
 =?us-ascii?Q?6RlCm0Kkg0cFFzKFjMlNp339Qy+fpNLpKat+yAe3PorJcyLR9HEGMFsE/xEJ?=
 =?us-ascii?Q?6ico9Z8dEDLSV3vGIY75Q/8WoecI7y2+Vjdj7I+CfT5vn/SNiFrbwGiL8qkW?=
 =?us-ascii?Q?5kcjZunHWI6+qWTcnugh6VnYS/ox47FjKg2et5nC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01749E6DF2FA5B42B334C61FF118ADF6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c802ae3-5f96-40e6-a256-08db099e86c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 06:34:27.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ve0PJ6vHXlLG4l7lBDnPztkzkTZyhzlCFueniF7nQ4agBBTvPRr3ArxCaAWtILVfPkHLuA5FuBIh59JtrXniw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5187
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 7, 2023, at 5:33 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> !! External Email
>=20
> On 2/7/23 07:21, Masami Hiramatsu (Google) wrote:
>>> Nadav, can you update your patch to assign immediate.value directly?
>> BTW, there are many similar casts around there. I'll fix those too.
>> If we need to be more conservative,
>=20
> Let's focus on fixing the known bug first, please.  Cleanups can come lat=
er.

Thank you Dave. That was my take too following your email.

I certainly did not pay attention to the fact that sign extension has alrea=
dy
been done in insn_get_immediate() before Masami pointed it out. So, the com=
ment
in insn_get_immediate() should also be updated to note that the immediate
is sign-*extended* in *all* cases (instead of sign-expanded in most cases. =
:) )

As you said, I guess the change you and Masami proposed can be done on top =
of
this patch, which is (and was) only intended to fix the bug, and should
therefore go into 6.2.

