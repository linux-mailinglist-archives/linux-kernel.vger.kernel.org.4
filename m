Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3C72761F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjFHEbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjFHEbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:31:41 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ECA213F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j139Us+Fou8OMIJu6Z4yEUuZkUM9PKTQ1iG8UWWbSuODjkwrFOrLLfQpKyvYS1zfqRIDIGHnjPBvKXwKEPt0xo4s0ShKGBN3gTrgkDLYGpO54/knsg10mML1R9FFK5j2xaoDn98/iKyjNg9+qu7GP9M5qqVs3zSfxCKQjaAyhE5F6kadHgvd5dQS6/+uzHI0CT0pXxx1aeR8FyTc00ZKjMBahA6mAcDhFJ4TkDdD7nxpI7/2jMUiuQKExuzIoJKYi/JBVgQ5YUapNcfTcZVA6naH+mwNm3+F8SbzWwemh7bpPh5h1HKRdZJAD+49ul2IPY7xetBYj9o30EGNTLNTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxCCK/H08GdTxXo2JLMGoTrmgDQEhlA0ijUOhs1ffMU=;
 b=AIwXK5uJMTVASY1ZE/KegxTBLzqmD5LAMnwSwd/wwI4DNq7q5Td/R5YuG815aD5BJjFz4qnYgn7RDaD6s2wTNPx8YrM0/i3iVjo85uBlviVdtUG4wZTyw0qAve+o6tB0ndK5EU38M8avzy5eYYDXQWkDtx7LcClt72HU/Y2EOQ///bbCGWDtu2pBEbsjv1xBVV4ACFaUsxD7gBPM7SbnRX2SnfO9++/tgFbmpa+pCec1K2VKmD3bcCpBhI8gN8A82ZDXCVjZXnv6ILb8W/Hs4oOE60LmonHbTeXAvzUrQhsGZ22k5dRD09yDUpndasDT2H2xvlZMHOCHbxaEblBoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxCCK/H08GdTxXo2JLMGoTrmgDQEhlA0ijUOhs1ffMU=;
 b=i/GqBkrcdtAfprEB1JfUxx7Ytj48MV0Jygl2QukDSusxQXLvzIwgNHFKPZJPQu9d2f7G+AAmvxm+jBexSCtEW08JfARMkJYYAZFj9/E8SZ6KJfCbFZF7MdP1YVmPyIYtA6Zyh+rhl4uMyl5OLiptrDWxfPi0mOgAP6VvHVhoXwk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN7PR21MB3887.namprd21.prod.outlook.com (2603:10b6:806:2eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.2; Thu, 8 Jun
 2023 04:31:37 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 04:31:37 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [tip: x86/mtrr] x86/hyperv: Set MTRR state when running as
 SEV-SNP Hyper-V guest
Thread-Topic: [tip: x86/mtrr] x86/hyperv: Set MTRR state when running as
 SEV-SNP Hyper-V guest
Thread-Index: AQHZl7cwQU3J5unYnU+MocLccDpYbq+AU68Q
Date:   Thu, 8 Jun 2023 04:31:37 +0000
Message-ID: <BYAPR21MB16884217FD6686C1871BFA20D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230502120931.20719-5-jgross@suse.com>
 <168597409682.404.2522096676257055244.tip-bot2@tip-bot2>
In-Reply-To: <168597409682.404.2522096676257055244.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4a1ffac-b69d-4907-8c41-9388760f66ac;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T04:27:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN7PR21MB3887:EE_
x-ms-office365-filtering-correlation-id: 638ff927-7fac-4cee-16c9-08db67d93f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lCFVOK7swNP0Hkx2UHEjBAC6yj1X6VKa0fJDiGMkGhZctloxQc0jitraUP1ahksZ2zFyrGMRjL/tQT3pkvg9gInqo/0VZ6chIM/errfMsbWkcLQGEeGdV8u9W2zwYICgTf9qbWVw8hCy8q25eGBsDFldTydYr6488TZMYBbKrlsYC+fJR0ZUEvOV2n/BnMscbIhMEz9dZaRmx64qVlpZEviKvE6a5r3ztLdt+oSgqx9ZaJkjlca/+O+NouVeLHUMdRJy5Vf8315eptCGHSrR9OxuZtlapi9AK2PGjendFDhiUHi6FBUGg1QfPo97W9eZFxQO5J+7zvDo5ueic3KR1SSHXEs6aaJm60mOHu5y03FWgugUdouyBi3U8FEWQYPW76Yd6p4j6q1BNyQ0LnC9nFmDr4u9GqnnAZw58D63XFIUgI4vcsQjtLTyYHb07G+0Iemc5cuSvA0BH9LCQvv2pm/HKvfyI0MNRjr3nUCJRJ5tOTRedGeqKDQWU/V18fwuWQ8CRhigp/FGTBMxy6CDKCc/gn10hzXLVlbzb+a/ELIpi3amrou9GYoemit9oCt0+ErV74JrmuQzHfHU4Xar91Z89ieZuvEjehh+KT+cZ/5cpM6BIf9sLej9DmSrjCK4VQ6DukLSXcPFB8OCM/sEQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(38070700005)(52536014)(8936002)(8676002)(4326008)(41300700001)(66946007)(64756008)(2906002)(5660300002)(66556008)(76116006)(316002)(66476007)(8990500004)(54906003)(110136005)(966005)(71200400001)(7696005)(9686003)(66446008)(6506007)(26005)(186003)(83380400001)(82960400001)(82950400001)(10290500003)(122000001)(478600001)(55016003)(33656002)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+1/+WqZof2ti4jlfYbATIvdJR34D9Ebd2CnOst3iguMvQ5nBLAqTctBoWM5w?=
 =?us-ascii?Q?ue2EQqPBYIQmtLt5bVaD2Lln30Xx9SZrnp8fYdoOcczvKSAs+MiVrOV1Er1n?=
 =?us-ascii?Q?/pgnytjn0C02NllqeF+GGY1rFckM1xQsZmgh8aRBrnGcbKnlDJHPVVpv9ypP?=
 =?us-ascii?Q?t7RqwBbUL91eS0Je62aElN60kVk8wRwss/oYZF1hSrNEHvZ8CYkiaDRO0UEM?=
 =?us-ascii?Q?3z0d9yqYRmbGCM1W3iNXhotIkDOtJWx0bYosgZWzh6GWB0qVTz+p9sZsTMrl?=
 =?us-ascii?Q?sQWzmFZ0MU7x6c29souwtx7ALwfIB/HGNUqL8LY6zidxY+NOYrqXWKH/Oqir?=
 =?us-ascii?Q?IGZPo3dc9K/Cc5IjyAOaNGhXNyzaE0+43ahLPdxVRtUkItrSt8EcZ9UvVlSk?=
 =?us-ascii?Q?2PZkCRGeVRsPPRV8QqHYvgIjT9UbfedSDcEBCm/9Af92ft7vzFE1cIr09MoY?=
 =?us-ascii?Q?6hp9ecD7gVMAkNzeoca0uG8x5dAh3w3bR+D8rjUgPDOqw7t7N2vmfXr4QQZ8?=
 =?us-ascii?Q?+Mvhgea4TOO3msu4tABN5/I9vmh777mkxuM7sM8tkHBLnc/RDdAt2CnI5v/K?=
 =?us-ascii?Q?5Ib7xDN7kqlxinvfNRmapfFrDwPG8w8sQMcNOUJwIepgvFC1tKdJw4tqEVw/?=
 =?us-ascii?Q?HCf/FUsgz45Y+Rfx/h1QgmqktvQNOaPM5K0hPCZx+LEHRxZ9gaA4daNzyILF?=
 =?us-ascii?Q?aw7bOOd7V/7Cs6zgDBamnPJDKcq9t9F2mD446JRcbZWdUnEJXAtraaogOkOC?=
 =?us-ascii?Q?qnE/+AYB6Xa0cGmWyk4BenIyJWlPpvuC5ybA2394zpPjqYN3hRXk5tNv4URU?=
 =?us-ascii?Q?iNxeowq8wPIwM9KHgrEL2442gRHATen7fTaBKxXK3AQ4pjP0yIHaHS8fou1N?=
 =?us-ascii?Q?aLQpiO04cNOsXmfgdTXk9QG19nhMiqROl4tCaN65zbgup8ZZVu1iAAPlBJEJ?=
 =?us-ascii?Q?oYEievInihwAhQj2RUL2HrthhwweZeQSbIQjsBzNvpJhigLuEvKq9BAyj7fp?=
 =?us-ascii?Q?QiUvsq/XD/rsRWGset4+8jRV9Rm4IPgMtxrZ+9pwG/ioBmUnOnxYW/jeefDc?=
 =?us-ascii?Q?wr4h1a/qE3fO1ZwnJH0+203KUNWSWXZwuRlmEwdbmogIlCjBA/0ia4XtC06+?=
 =?us-ascii?Q?J3mVWDOLM0SJsm2hjEbwJIvLFoFlolntnAiutfrTtcnbuADZI5h6HfmPcrO5?=
 =?us-ascii?Q?85aiEfo17u4kQM1rhhjtSuAbDb9ENVq1TzZ4bRa4CzU349AjsnR1FtBT6qNC?=
 =?us-ascii?Q?T0WJtIIj++N/QKCVybnDpmi6LlBhW1DovkcLUd9LDFL24UbtMwqz0duLruTB?=
 =?us-ascii?Q?X2jnAOOcaPtRV0exf9OZtwOpQauZR2p1A+b5dFcNUub/bggsC341IvR22ePX?=
 =?us-ascii?Q?PzsIlbeRdNifMgeF0Luaj57+ERRE8oUjQ5iVaEUmL3yvxAEwiovB9eUOQBpu?=
 =?us-ascii?Q?PomIkRm6TEY9RvZJjtaBzW997F5bqHwAWER8cOlQLuJRXJTumsPJK2EVkhyy?=
 =?us-ascii?Q?BvU9V9C0gTlCAQ0TGH/U24q0OjirI1+VsJPC2ECHqu0I1+/N2j3c/8NZ35RY?=
 =?us-ascii?Q?bzHMVet5YJR2Fr4xrgpZuWNggLvmoSQ2S17SFU0Va9/gIjJITXT0euui7RJl?=
 =?us-ascii?Q?8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638ff927-7fac-4cee-16c9-08db67d93f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 04:31:37.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9miQyxzZ9DGpea1wyFFmTmo0zR15vULucdeE4v77m/wDV3gVf+EOSwQgkSGKCP/TZSTJZlmxqUrOawCMYZ2JSSSj+pcqvnFBkUXupL3EAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tip-bot2@linutronix.de <tip-bot2@linutronix.de> Sent: Monday, June 5,=
 2023 7:08 AM
>=20
> The following commit has been merged into the x86/mtrr branch of tip:
>=20
> Commit-ID:     c957f1f3c498bcce85c04e92e60afbae1fd10cde
> Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.gi=
t/commit/?id=3Dc957f1f3c498bcce85c04e92e60afbae1fd10cde
> Author:        Juergen Gross <jgross@suse.com>
> AuthorDate:    Tue, 02 May 2023 14:09:19 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Thu, 01 Jun 2023 15:04:32 +02:00
>=20
> x86/hyperv: Set MTRR state when running as SEV-SNP Hyper-V guest
>=20
> In order to avoid mappings using the UC- cache attribute, set the
> MTRR state to use WB caching as the default.
>=20
> This is needed in order to cope with the fact that PAT is enabled,
> while MTRRs are not supported by the hypervisor.
>=20
> Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled ca=
se")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> Link: https://lore.kernel.org/all/20230502120931.20719-5-jgross@suse.com/
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/hyperv/ivm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index cc92388..6f7c1b5 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -17,6 +17,7 @@
>  #include <asm/mem_encrypt.h>
>  #include <asm/mshyperv.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mtrr.h>
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>=20
> @@ -372,6 +373,9 @@ void __init hv_vtom_init(void)
>  	x86_platform.guest.enc_cache_flush_required =3D hv_vtom_cache_flush_req=
uired;
>  	x86_platform.guest.enc_tlb_flush_required =3D hv_vtom_tlb_flush_require=
d;
>  	x86_platform.guest.enc_status_change_finish =3D hv_vtom_set_host_visibi=
lity;
> +
> +	/* Set WB as the default cache mode. */
> +	mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
>  }
>=20
>  #endif /* CONFIG_AMD_MEM_ENCRYPT */

FYI, I've tested SEV-SNP vTOM Hyper-V guests with linux-next20230607,
which includes all the MTRR changes.  Everything looks good.

Thanks!

Michael
