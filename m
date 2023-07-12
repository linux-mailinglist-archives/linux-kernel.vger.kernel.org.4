Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE197500DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjGLILo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjGLILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:11:40 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2D1733
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXiIy1MaWqhSzVYejeIXBNoQIoz6HJDF45yd/0uOJNeXQwk2uGbuFi9AjkZbT5+CXhV8/gdsRVjcHotxnYmXEybUNtnUTBDRdb29j1qzVzyg6LtEEECEE6vvdcnTFrb4YxHw/uW+mETvRmZA31GkzM62gqEzcCd3I8iWow4wRb1GPX5164jXmbgszyLng4lNoVjhyL13I30OEL+58rY6xA4vo1XQjA9ZsXwlq+omgRsldkH03lVnfj/cwyLnspYDAt6wX4GkkP3HGaiUVeofVC2/RWVbB+k7Jz5o1P2LlY9wBp0tY+XP8AIZf0F9y7GCYjn02Pm16hIWeHaNexj6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5xghD7RIzvkMk88mdgaLA0/9rQLA1hYGLms3hwxkyc=;
 b=jUxYeFYEEMxiy7d0sAJKSlqWC0skBDkdPkTIuHiul3hWvmeNoi0HjvfIlpZVSVJBRvauR0kYt7SSomzQ0ZSd68Wfa4DYyP59j9eh/dtv23Pnz/AU1uyMKNGX+NiUBjNXXc7608DxoFKIgNLtZIsz2sj2vZE4uFc5BO1Oej2J+ZKMb5UBbfQRVtihL6MeSHQG0b2U3ksscVDbH3EX/EyaCeGGOlPpvk+C9E6BH6mC6Hd6fvIuapdhGewe6hMUGreI8E7ldAPY+4lAUJZL73+U48aZz4zSah+0Qi29wAFozRty6NfyrI/cVvn4ZeReal3KeWTz2FDjnlnJ6ieCb4gAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5xghD7RIzvkMk88mdgaLA0/9rQLA1hYGLms3hwxkyc=;
 b=hD6bhcFBKCiQmUPX9UTdayku3rBZv58iSaYu02oCvPG1dPN3KEE1cL25TT3vQPG8OTs2NTCMs0S4CO6KHPWXK8lQftixGW9c0YEb/jD6GxBBcboMwVxw044YvQvdMdt/6RDlyfPPVBalCWguglL6n1n/XmmPWNeR6Nip1r8+tfo=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 TY0P153MB0781.APCP153.PROD.OUTLOOK.COM (2603:1096:400:267::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.6; Wed, 12 Jul 2023 08:11:32 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::5d43:697d:e190:459a]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::5d43:697d:e190:459a%7]) with mapi id 15.20.6609.007; Wed, 12 Jul 2023
 08:11:32 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharath George John <sgeorgejohn@microsoft.com>
Subject: RE: [PATCH] x86/numa: Add Devicetree support
Thread-Topic: [PATCH] x86/numa: Add Devicetree support
Thread-Index: AQHZqMj18wvdpynsiE6phwVwKFX+GK+13yuA
Date:   Wed, 12 Jul 2023 08:11:32 +0000
Message-ID: <PUZP153MB07491ED0C0688FF9104F72CDBE36A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=090d9506-94f6-4c96-8b2d-f91f2dba147e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-12T08:10:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|TY0P153MB0781:EE_
x-ms-office365-filtering-correlation-id: 7f4d84ff-953a-434a-fc3d-08db82af9a8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8B66im0oHOhIqXMTXFOProYeyZqfu+zAnMj8SMkFMdQM8LrtfcYZflnoGtN7qMGTGjdobHSMNMYaUlZNSQFAZZy+AGmymV+YzKCi+2PjAOejlsHIXoyYfLFUtjKy1LiiLROktBEnEmsD5xp/lZ4BvIy8wu0rsGfPriIiJ+i93lKXX8PYAcNPGqf5BWO5X3pjkAFUdSIDJ7vQCTtLhLCRLHCmjSrlS3z0Oc33Un2AXS9h7ndPVRZNeM+8SnJ54UUVxYAvYPz2GX2BPu5MOzmvgXFyoYCyhxtdDwUfYW+jn2VOUj2Lx1m9WAbLBGayqca0iB951JOFnk8HatCC4bQHGh55/E3fdj9sTjZG/gxOSlxgKIaHGz9+vndGgiRIVAYg9dbh7qSyYFsRbPDj2JXygg0mxAOle7J6f4b8w8ZMqKKibOAuDqJNSeSjQlt4x+LMnLi24/Tem2dTVmmqu4dCn75KfE8ZLqFiPcdBiWsn8O5aUd04sTVUXXuMFiJD40QsvMbSQ7B7Uul8IMbJBHt0C1OpcAtrHLqj3wjebpmPNKaXipib9LNuKBXZ/YvTZf1BjY0kZ2XI/kWfiiP8hC/rH5c2ujdM504YOMY3HgStjj5NL+aXin21Tj1BHHT8ca4q3jL7+pqXqXqORZAgU+rNV/GRqVdiYlFneB2XwxAjirFOrjO7Z1We5pp6vAe1j44B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(316002)(478600001)(10290500003)(110136005)(7696005)(38070700005)(66946007)(41300700001)(6636002)(66556008)(66476007)(64756008)(66446008)(9686003)(83380400001)(6506007)(8676002)(8936002)(5660300002)(53546011)(71200400001)(76116006)(8990500004)(82950400001)(82960400001)(38100700002)(122000001)(921005)(86362001)(33656002)(55016003)(52536014)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l0x5KGMf5578sEShfEzJ2GYFaraiIf8O9lelm8HZtl0iKaMiZU47DwYbJH2D?=
 =?us-ascii?Q?+f3+2sKU/8F96AN2Ik/nbptK269LniOpJsLdJvxqgBBdZngDiS+u1wTAM62f?=
 =?us-ascii?Q?SmITAlPVKF01vroLz87Litb6B/LEO69eo4rdzJpfspP2DNDFRay2XqiCKB7S?=
 =?us-ascii?Q?Me1YX7+nt6vpB+bietAbAbJChD3AF7jiNDrDJV4SDoYetR7ucCcT+Zi/VgIr?=
 =?us-ascii?Q?pfSHFVWh62jWn+7uwmHdGujmIqewijyI+dBSx517kfAEVBOb1E91vTPB3COz?=
 =?us-ascii?Q?V/h45vUFRvbvBohQ9wRWUniDT7YDqrutBN5/hxgg+lqOhHuabNcV5iIcmzVI?=
 =?us-ascii?Q?cbJPysnijzO41JLMv0irWS0Px8tweDHFEjItUfmCtrQBEaAsGcKYEBSlyyB8?=
 =?us-ascii?Q?KOLShdedF1dFor9GZmKFKGQp/fMBT8/Z2OPMxO/jgl1vXAeJyFjBJvEv+mrX?=
 =?us-ascii?Q?sNJTutwyMnc6rrDN9UUeJXfBGX8YLBbEDIAkpgk2nzRiGQR0c5qGH3ASUDL0?=
 =?us-ascii?Q?GslJpFUIJc68dDgRkQHbVuCCL0XR7cBt57hTWr6sw3g94/wArL0OhXR76xzr?=
 =?us-ascii?Q?AlE1R377iRQ0YH9AeyAhrlHAHIGovzKPch+0JyGO2Xtw31PZ883Tv0WLcNKR?=
 =?us-ascii?Q?hO9cWIK27qXIgvotmo3N/DZddnmkLDlfegdlW+mkmbINQsQ0+qmbsOitfRJP?=
 =?us-ascii?Q?iwS9GjrGzuPaIFAQAPQJq9PZQdLqHcUOO/l52LJQl+xb6Jgk8SQYz/x1KbVv?=
 =?us-ascii?Q?T+x52onQkMcSkPl/ACmZDo9oRA9sAfp01DgDi6wjkODNC2S1jEnYUII+4RCE?=
 =?us-ascii?Q?YSmprAzkcf6SD2wtVEmt88IzvI5mSGhuFTzRu1BGp7wkW2QkKxiKEQN/RL75?=
 =?us-ascii?Q?yYgirHw2JJXPqoXbCUn/gMahbzuhrb82MwZ4n8y8Mo2M2rDBNntVsBvtgZcQ?=
 =?us-ascii?Q?nTZzsLsb9QAzIxGYTZuHkQwzlNABxB2lRiiusLGixIimEvmY59ek1Loz7cti?=
 =?us-ascii?Q?zFUoJMHiVCJpl6vGruoLTwlVrJv706n/WkTbcV03PL9CLurH1BvTdnfG7Z9c?=
 =?us-ascii?Q?Qig8gjjBDKsXS7/yLTUlZ2AKSWvFsTfJl9+DwmF51iXRt1qpnxZC3a/ZPjvx?=
 =?us-ascii?Q?OePeBhP0uXKRc95j5aOCobIqr6akKm0x5Sq3cRuMYRAQdOmzuMXedziMuoOp?=
 =?us-ascii?Q?34ckjMtQVH2pydXomJ11V5veEVq8WB9Zw5dM1zZRR7idoh6vVaWMwecv4uP4?=
 =?us-ascii?Q?8fQJLz5OcWGWsHXlrGhtp6VnNTWCSEoBtmvjFx61uTnoutepAoU3lrxe5sUg?=
 =?us-ascii?Q?dV8uOAKVRt9JaeFK7nJcfwjztZ5tJbFjzNejSKQ2Go0LCF/i2cHWemegWn6F?=
 =?us-ascii?Q?Y7xjZQfq9p9mFaMcAnQvN0pePZHYm5HyvSC5x5Xm7pz+s1baGotoFrLG+BcM?=
 =?us-ascii?Q?keMndVAI9Hhr49vKhzuSy3GeooEo2xwCdvGuDBOlKpUgnwHyYFDsi71x9XCl?=
 =?us-ascii?Q?HOMhl9KqD6b/YZQ1CB2zK9AgmscecBgDws+M9TZhfGxRI1Ku8KKHCqphNRxD?=
 =?us-ascii?Q?OptaLQgnJ1ztCe0hQrwYASM+sS0b2nIFhW/TBPa2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4d84ff-953a-434a-fc3d-08db82af9a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 08:11:32.6607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6J3J5tCLyqNL3wc4Q6+kvInTdOS+EOpgMbn70GfsnHcEGAdy6xmYG80U+6KMHj6TQnNFQCqhtflmvV0MYEAnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0P153MB0781
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Saurabh Sengar <ssengar@linux.microsoft.com>
> Sent: Tuesday, June 27, 2023 12:58 PM
> To: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;
> luto@kernel.org; peterz@infradead.org; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org
> Cc: ssengar@linux.microsoft.com
> Subject: [PATCH] x86/numa: Add Devicetree support
>=20
> Hyper-V has usecases where it need to fetch NUMA information from
> Devicetree. Currently, it is not possible to extract the NUMA
> information from Devicetree for x86 arch.
>=20
> Add support for Devicetree in the x86_numa_init function, allowing
> the retrieval of NUMA node information from the Devicetree.
>=20
> Additionally, relocate the x86_dtb_init function before initmem_init
> to ensure the Devicetree initialization prior to its utilization in
> x86_numa_init.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/Kconfig        | 1 +
>  arch/x86/kernel/setup.c | 2 +-
>  arch/x86/mm/numa.c      | 3 +++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c531b16ee0bf..a2ada193b2d8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1567,6 +1567,7 @@ config NUMA
>  	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
>  	default y if X86_BIGSMP
>  	select USE_PERCPU_NUMA_NODE_ID
> +	select OF_NUMA if OF
>  	help
>  	  Enable NUMA (Non-Uniform Memory Access) support.
>=20
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index fd975a4a5200..940c92a6a5e9 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1220,6 +1220,7 @@ void __init setup_arch(char **cmdline_p)
>=20
>  	early_acpi_boot_init();
>=20
> +	x86_dtb_init();
>  	initmem_init();
>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>=20
> @@ -1261,7 +1262,6 @@ void __init setup_arch(char **cmdline_p)
>  	 * Read APIC and some other early information from ACPI tables.
>  	 */
>  	acpi_boot_init();
> -	x86_dtb_init();
>=20
>  	/*
>  	 * get boot-time SMP configuration:
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..a6d3d331fda2 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -11,6 +11,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/sched.h>
>  #include <linux/topology.h>
> +#include <linux/of.h>
>=20
>  #include <asm/e820/api.h>
>  #include <asm/proto.h>
> @@ -733,6 +734,8 @@ void __init x86_numa_init(void)
>  		if (!numa_init(amd_numa_init))
>  			return;
>  #endif
> +		if (acpi_disabled && !numa_init(of_numa_init))
> +			return;
>  	}
>=20
>  	numa_init(dummy_numa_init);
> --
> 2.34.1

Hi x86 Maintainers,

May I get your feedback on this patch.

Regards,
Saurabh

