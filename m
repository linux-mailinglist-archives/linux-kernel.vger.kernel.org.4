Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A44C6A331D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjBZRMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBZRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:12:15 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021019.outbound.protection.outlook.com [52.101.57.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF341027B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 09:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCJU/dnsKH1hPLopScwix5GWV49ISM2I7oSuZTgYQYPWgqW5YH4yzgWbzM6wsydT+bo+7AaicEg6ZnC7rxNmoZHzeK9nmQxFujGli9leTGc3PquzvF9ZoDWQv5xolcg7PXhWFMaLW+xFQOiDM2e+OjXTNNf2m69zxpCYw53yUDnvWZgtaF7UuKaYASE8s0EDMktzjrAc/V88BcWFxMtgs7oHPur44eMhPtIkVQm/mqFwfZpsCKezhH8EXOtB9LiE4Gx3LUN/9btljEfUvqqkw55Zji32UP41xlH7diZh1B5hHxaQFY2xMS7XTLh6QSAXViSrlZgOAb68mGupYYC9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymmv/eJQA+/rcE6Qvzx+DH2ouv4B3mhROg/Os8O8JJg=;
 b=LXQg7PkxWuSX+wYIDDCe3sJoI5niZpO7nCqQS4TEOUqrWbJeAWxgNvprR4VRqY3jp/7zBZxc/zCI8dpl28ukspFHTuSOaUsHbvdUsmF6T9Uz/a279GhlBhDg+Nw3QCgrZJUPLSSnGOjsJ1S2iCCPdxwJFALxW19uEbmVVdMVwVKBsyrB+8G5BJqWfIvOzwTqJg7HLSrPaeoC5nruJe9hdxluGb84tvaqwBPinN8dGkdExyG6OUM7D86kJu1zqw8Mf7RY8UnfjbPJWCdJhpXok9K4p64p1+frl+7HIT8HiJQK89RQoKL5+MKHjLcmst3sK6fd/Rc0+ZSmpZwpVkLn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymmv/eJQA+/rcE6Qvzx+DH2ouv4B3mhROg/Os8O8JJg=;
 b=KH+/sufKpMHO9LyAwGhoUP4tpTtEZXnffsgNhPuOU65qy4edfrdU9ofjiopjQdg25GYNllflHKT0qRUqIXxbS0SrzzVlsCfCSI57E16ffEMfTZBvRbrDYmYIgv1tIqKwNO1ngCjrg9cK2FxTERjoxdCQfXzdsun2+zAem+04piM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1325.namprd21.prod.outlook.com (2603:10b6:510:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.2; Sun, 26 Feb
 2023 17:12:04 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%5]) with mapi id 15.20.6178.000; Sun, 26 Feb 2023
 17:12:04 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v3 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Topic: [PATCH v3 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Thread-Index: AQHZR2nnhOZsDyaWZUmDhr/1dokMPK7heQUw
Date:   Sun, 26 Feb 2023 17:12:04 +0000
Message-ID: <BYAPR21MB16886880C8B115233F48C3CFD7AE9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230223093243.1180-1-jgross@suse.com>
 <20230223093243.1180-4-jgross@suse.com>
In-Reply-To: <20230223093243.1180-4-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=74cca6b7-1017-463b-b6f0-40de8baaf816;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-26T17:01:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1325:EE_
x-ms-office365-filtering-correlation-id: 721a8b06-31ba-46be-176a-08db181c9535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+61XHfsLZPAnZJeEfDoXfWNDshlU/+NHj2N2qs8jJ4jGq6p7+nH++MFIUnAttMz62/dgtAfL9Ccda4aBlU94dbV8lRBMtFaCQJSXorJiiM7q04Zm5PAHWTFnaJfWIkYBv+sAPXkHje5CsErnu+1oYmt4OmyQYq12YrqKQ6N1yNsxVbev00nrGY3FX8FImAAFZHjEilsUvBhA8SJDj88qEBT++bhMyMWkj/hTS7ueaOmPbI6QW7tlg1BmuNvx0MWpOmALId7ITzokyeJLsTwYr6wOAybAAZ+vROcfqLiPhsCyeSxsFcofir3oET3RWVD84dq30ewfhhlfz5K/flOJAJX6dXWJyuMuNXDIkD7w6lZHVkfYtTzT5dNdu5tGDD+sLJuqqY9Rb7c3qaLE1K4hRmbKw+/alB7RdAiPbJZAmhUgZrPYzTpNdepzr7TufCZziQ80S7tQ+4sQdOLKXep8bHuYWQA+oxZaTqFCtqVbXoXP+3d0OJElooMvF4foV9t7kYEPrDFZVVwjnzIHU3ujkDY7j9Kh+yCmdQqePPy5k9/WCaShKF+5i/or7l3lwIl+TtsM2qz7XGO/fb8EfDoKBL+Eo9kZUnzwaQ2QLJ/AqAPvk47kzsBFuUE82poIdVPNMN0X95qSecEgptVzGcgTFb88Ex0MBb6YJvC7YiRo3UENYxA53PBucg2UruB3SJVioJ1HgnnxJjBxPgnUsa/Bb6Kj/s3S9Sn62GwGFfzXxfUoFYK+c2nnBOLClJlv2HR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199018)(5660300002)(8990500004)(83380400001)(10290500003)(7696005)(478600001)(6506007)(9686003)(186003)(26005)(71200400001)(8676002)(64756008)(66446008)(66476007)(66556008)(4326008)(82960400001)(52536014)(55016003)(76116006)(8936002)(66946007)(41300700001)(38070700005)(86362001)(54906003)(110136005)(38100700002)(33656002)(316002)(122000001)(82950400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e1U76Fj94aKFh3Xfkf8NcNuFSceGADC9443sxc53KeJJ6+zx61lFg0oTgexe?=
 =?us-ascii?Q?zBJEahalrdt38YYGnpI65VUVPDfqDUzY/eSg1tH+j2PjC2yjTh6rQiUhIkB+?=
 =?us-ascii?Q?qXgNCpabMFbeGjpd8xNUTo1pl+muupmDqfK/+t45nYn57O4E/S23urbjHiKI?=
 =?us-ascii?Q?Ys/3+DBSk2CGMlEWtE3fl6ME93RgjC/kIBMMEeHw4t806sVaZrlo+rKcygt8?=
 =?us-ascii?Q?58kgZEP8Tt+zV15IU4WPUiEFITKy2ou+7tVPT1ygyYIxzEbF9q8oJOcgvxSU?=
 =?us-ascii?Q?s0D/hl359i2yII0wM11QoXnTN170el/8h0szFhn4s4KaC9n7ddhpyuf/QV7Y?=
 =?us-ascii?Q?86vSOXmEpB6lhmZiV9hjdm1pDgc5ya64giIE+lkYeyX2AD9sd0GmrIoQ2RJJ?=
 =?us-ascii?Q?u3p2y7RXcR0mC75J6tBJzHgYcLfXLsjHhwSzzFQuk6zyhNXFUydZ/ZRX4ggs?=
 =?us-ascii?Q?9twc6sUAKzvr7LWXO8ohTOalbsepVcWdSz2X61hFdHqKGuDVD1LPzZgMHgzP?=
 =?us-ascii?Q?ok7ZFIwzkg2+4UULw5X8lRJxMqmafPs6lGWNO5x0YQQCxd2JL8/1qlCNUfii?=
 =?us-ascii?Q?haQThUqamQvKq/7JikIJ6a0GLghRdnZ4nNUTDIZTG7TQCggeAvB36wbr+nVb?=
 =?us-ascii?Q?JYkbRz0yNEUlmp5hVpOtSrhAzwbo32XsYodn78WrCMIcvj8D7dTV36z6i2gU?=
 =?us-ascii?Q?KYdHQzDYwUR4aSJ4ZvqebguCoLcEAXBevLZA0OqBmyT9EYzStSa8KnMfUgOW?=
 =?us-ascii?Q?r0+2EMwJWapfwfSmV6yEpklWvho560eD6andOla+nXWgf3xqkKwtg2pB0kBu?=
 =?us-ascii?Q?QMyqniQDnDKgdhTyjwdWp4TxuTrIRHLAzUmVfW4yPQQ1c59VIoJfoapUs/3W?=
 =?us-ascii?Q?ZZeWUXf+mVCWeVn5FvrhdHXpUdiHBcbriY9keVMtqcouKuJAW7DLHexfrQjA?=
 =?us-ascii?Q?ZFjdwILF1hWBgiSHr1wNhCoF3bbSV+78tm8JnjkfTw0lppt8nEonHRrBLdez?=
 =?us-ascii?Q?aBlV1Z+wjl8XSEECaYpmTSnPyunxZCuiyE5orLYTc3kGhZ5qRSZHYAV9/ZNz?=
 =?us-ascii?Q?SzpyMH5aXW+QA1WGV4vpFCK73cMS+ZCtCnLVtSRNQTPlGORdi9TvPeOm33BC?=
 =?us-ascii?Q?kK+3VVHFNPg2xWexmyhTPjOj3oX0wXORwxwhclABBw+DDy/+SPHcte3w5wau?=
 =?us-ascii?Q?x4F7FtiP1iSxStw2qMbGc+wIGVITUvBnmfi2cxu07vqDyMPd2eZL2Do3DmCA?=
 =?us-ascii?Q?EEBBN7od3ESCzVUNDir3DniFGvzmEyq2IyK8nYZIlUvS74VSXTwYCMd7frdp?=
 =?us-ascii?Q?nLw07DthJZuMF9gPLXfPJAJeToLWk25CzLfH2tUwH2x8pmoGjDXnMjJDVjBR?=
 =?us-ascii?Q?fIpRNGpdKgCRwsmK0dfKDnHs8UzwL5YVbSbNyr8tmXdHFj+ticwT+Kh0k2yO?=
 =?us-ascii?Q?QF84Sl0UBHecHsqd3SpYPf+IIRPFjYsDfKmQfR2STK73dtFiWaInrONkzrRU?=
 =?us-ascii?Q?LTKOSd80Q3fsfY7iczlNp/Qmt9YmQxXNfTl68rS3jokmzXVBl38hOyRKTV+q?=
 =?us-ascii?Q?rJoSfmVL5u32rG+5NNyvoBVqdYHRkrf7Z02W2fphthrCH5R/ss3ISKqEFKtd?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721a8b06-31ba-46be-176a-08db181c9535
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2023 17:12:04.3867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3juR8pe0lR7hbtpLt881n3l/ja9ij2SympJ92xT42UIByI7GVO1EMw3ceuvTi2S5GA3gtMO3+ebeLJfw2U5uoxrvc3F3fxz3JrI2sufBWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Thursday, February 23, 2023 1:3=
3 AM
>=20
> When running virtualized, MTRR access can be reduced (e.g. in Xen PV
> guests or when running as a SEV-SNP guest under Hyper-V). Typically
> the hypervisor will reset the MTRR feature in CPUID data, resulting
> in no MTRR memory type information being available for the kernel.
>=20
> This has turned out to result in problems:
>=20
> - Hyper-V SEV-SNP guests using uncached mappings where they shouldn't
> - Xen PV dom0 mapping memory as WB which should be UC- instead
>=20
> Solve those problems by supporting to set a static MTRR state,
> overwriting the empty state used today. In case such a state has been
> set, don't call get_mtrr_state() in mtrr_bp_init(). The set state
> will only be used by mtrr_type_lookup(), as in all other cases
> mtrr_enabled() is being checked, which will return false. Accept the
> overwrite call only for selected cases when running as a guest.
> Disable X86_FEATURE_MTRR in order to avoid any MTRR modifications by
> just refusing them.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - new patch
> V3:
> - omit fixed MTRRs, as those are currently not needed
> - disable X86_FEATURE_MTRR instead of testing it
> - provide a stub for !CONFIG_MTRR (Michael Kelley)
> - use cpu_feature_enabled() (Boris Petkov)
> - add tests for mtrr_overwrite_state() being allowed (Boris Petkov)
> ---
>  arch/x86/include/asm/mtrr.h        |  8 ++++++
>  arch/x86/kernel/cpu/mtrr/generic.c | 43 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mtrr/mtrr.c    |  9 +++++++
>  arch/x86/kernel/setup.c            |  2 ++
>  4 files changed, 62 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
> index f0eeaf6e5f5f..f1cb81330a64 100644
> --- a/arch/x86/include/asm/mtrr.h
> +++ b/arch/x86/include/asm/mtrr.h
> @@ -31,6 +31,8 @@
>   */
>  # ifdef CONFIG_MTRR
>  void mtrr_bp_init(void);
> +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_v=
ar,
> +			  mtrr_type def_type);
>  extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
>  extern void mtrr_save_fixed_ranges(void *);
>  extern void mtrr_save_state(void);
> @@ -48,6 +50,12 @@ void mtrr_disable(void);
>  void mtrr_enable(void);
>  void mtrr_generic_set_state(void);
>  #  else
> +static inline void mtrr_overwrite_state(struct mtrr_var_range *var,
> +					unsigned int num_var,
> +					mtrr_type def_type)
> +{
> +}
> +
>  static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
>  {
>  	/*
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtr=
r/generic.c
> index ee09d359e08f..40c59d522f57 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -8,10 +8,12 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> +#include <linux/cc_platform.h>
>=20
>  #include <asm/processor-flags.h>
>  #include <asm/cacheinfo.h>
>  #include <asm/cpufeature.h>
> +#include <asm/hypervisor.h>
>  #include <asm/tlbflush.h>
>  #include <asm/mtrr.h>
>  #include <asm/msr.h>
> @@ -240,6 +242,47 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 e=
nd, u64
> *partial_end,
>  	return mtrr_state.def_type;
>  }
>=20
> +/**
> + * mtrr_overwrite_state - set static MTRR state
> + *
> + * Used to set MTRR state via different means (e.g. with data obtained f=
rom
> + * a hypervisor).
> + * Is allowed only for special cases when running virtualized. Must be c=
alled
> + * from the x86_init.hyper.init_platform() hook. X86_FEATURE_MTRR must b=
e off.
> + */
> +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_v=
ar,
> +			  mtrr_type def_type)
> +{
> +	unsigned int i;
> +
> +	if (WARN_ON(mtrr_state_set ||
> +		    hypervisor_is_type(X86_HYPER_NATIVE) ||
> +		    !cpu_feature_enabled(X86_FEATURE_HYPERVISOR) ||
> +		    (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&

With current upstream code, this test doesn't allow Hyper-V SNP vTOM VMs
to do the overwrite, as current upstream vTOM code doesn't participate in t=
he
cc_platform_has() mechanism.  That's being reworked in a separate patch
set.  Can you add this test to cover the SNP vTOM case?

		    !hv_is_isolation_supported() &&

This is the same test used in __set_memory_enc_dec(), for example.  You'll
have to add #include <asm/mshyperv.h>.  There's already a stub that returns
'false' so that everything works when building with CONFIG_HYPERV=3Dn.

Once my other patch set is accepted, I'll revise this to remove use of
hv_is_isolation_supported() outside of Hyper-V specific code, and use
the newer cc_platform_has() instead.

Michael

> +		     !cpu_feature_enabled(X86_FEATURE_XENPV) &&
> +		     !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))))
> +		return;
> +
> +	/* Disable MTRR in order to disable MTRR modifications. */
> +	setup_clear_cpu_cap(X86_FEATURE_MTRR);
> +
> +	if (var) {
> +		if (num_var > MTRR_MAX_VAR_RANGES) {
> +			pr_warn("Trying to overwrite MTRR state with %u variable entries\n",
> +				num_var);
> +			num_var =3D MTRR_MAX_VAR_RANGES;
> +		}
> +		for (i =3D 0; i < num_var; i++)
> +			mtrr_state.var_ranges[i] =3D var[i];
> +		num_var_ranges =3D num_var;
> +	}
> +
> +	mtrr_state.def_type =3D def_type;
> +	mtrr_state.enabled |=3D MTRR_STATE_MTRR_ENABLED;
> +
> +	mtrr_state_set =3D 1;
> +}
> +
>  /**
>   * mtrr_type_lookup - look up memory type in MTRR
>   *
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/m=
trr.c
> index 7596ebeab929..5fe62ee0361b 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -666,6 +666,15 @@ void __init mtrr_bp_init(void)
>  	const char *why =3D "(not available)";
>  	unsigned int phys_addr;
>=20
> +	if (mtrr_state.enabled) {
> +		/* Software overwrite of MTRR state, only for generic case. */
> +		mtrr_calc_physbits(true);
> +		init_table();
> +		pr_info("MTRRs set to read-only\n");
> +
> +		return;
> +	}
> +
>  	phys_addr =3D mtrr_calc_physbits(boot_cpu_has(X86_FEATURE_MTRR));
>=20
>  	if (boot_cpu_has(X86_FEATURE_MTRR)) {
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 16babff771bd..0cccfeb67c3a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1037,6 +1037,8 @@ void __init setup_arch(char **cmdline_p)
>  	/*
>  	 * VMware detection requires dmi to be available, so this
>  	 * needs to be done after dmi_setup(), for the boot CPU.
> +	 * For some guest types (Xen PV, SEV-SNP, TDX) it is required to be
> +	 * called before cache_bp_init() for setting up MTRR state.
>  	 */
>  	init_hypervisor_platform();
>=20
> --
> 2.35.3

