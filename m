Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB13F73C6ED
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFXF3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFXF3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:29:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFB426AB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687584555; x=1719120555;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=hLAG/c9hqcxByC8R5rDWpA8KXY61tPVRJPm8rRmUj9o=;
  b=abhZzkEi0w4bfGqJs3XEjO2OcEy+xFYibqjbCdOS+G6hzoSM1qXVv9Xg
   4ucb/1v7Y9uOv5h0sHFAdlFcCVEAnvflcHCpNpFLL4Im3C1SQm2mn1aPJ
   pma+c+rdaqVk+v4AI56ZGKUWFt/O5LexOOvVgBYqoiusw0VdoN/m196yU
   dEzrLIpMP7jY3Hr4EBE/eC4gCYV8xZ92zst4YREq6Bj6MXdqZqrcAQCI5
   3Tb/ErZ4a1JM4UqOundF8IEbq+Hso9L+o4zf/cU8tu3i0yM8q5aKJg5Bu
   ILiTmgBO1lYBGNdRgwEhNvzbiywJt3p2zr35pc5KrouA46XDfYxKkN2Jj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="341260133"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="341260133"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 22:29:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="839674925"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="839674925"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2023 22:29:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 22:29:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 22:29:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 22:29:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 22:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYfahDzH+yaoj4UzHVZPhyWiCprRqU6zCFFrcrllI30ypGnr4kJo21TD6abq52Hvmt3byndCj06GEjDwkpXXasWd0T9QLAOxpMk6HV+0TRKjSUVXA30jl2Q1o7BkOChQkaexWw8Iu/39guCKtHCaBeH/Y/K4sA4iJOaHuoiQTTCDAbnd9FRZZTvokB74Q3QcxKPw/muNeUEpOao8RES6uDgbL89Mfo33CZ3ZOJxrMh9bJ0GsL+dG5t5ePtoYKFPpzV08h+HjmEPrVorZaowDyiGgLWY3PBaTgpTWSSmIdP9VD4WOr52NpJFpK6AsKNvtbmR1ZTapSO0m0E4k70BZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeUhMQlajfHheWfjJJhEX7YYPhxvkTiamDuNq1Gxpvc=;
 b=a7FuxibJo2cd9Qv9holYu7qp2GCLVqRtLCwE30XWVeDq3rTnl3EhqHQHR5aiejYNdN5OlDjgq/WHY+ndU0KzvMTfNBW7+5NgHrw+Zz/xN6RfMvzHDw+bu247/jVt1NH03yW5Kgmi498N/xAhtNYZQQx0PyTWm1FnaTAVwoDkDLMIwhwx9uWRQdEYRne45b9yHL42EWa6DUCPEGnSykraTN3lrltQ03wh/73q1ghMFM0NPHGtgrZXkyqDe2OvKdz57wYDufXnU27WEqSFbr/N0t15IHzOlU6vAFb16KUfBQgvpZdbqq8xZ3Gb9MezpygdWgnvcgHCT51ruGUrU3Cobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 05:29:10 +0000
Received: from PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::3038:74a:aa16:8225]) by PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::3038:74a:aa16:8225%6]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 05:29:09 +0000
From:   "Preble, Adam C" <adam.c.preble@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: acpi_ns_validate_handle's code is modified and triggers IBT
Thread-Topic: acpi_ns_validate_handle's code is modified and triggers IBT
Thread-Index: AdmmXK1uMMtxKUZORYyg3R56dn1BuQ==
Date:   Sat, 24 Jun 2023 05:29:08 +0000
Message-ID: <PH7PR11MB652307D2AF565EDE7EEA8A22A920A@PH7PR11MB6523.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6523:EE_|SJ0PR11MB4799:EE_
x-ms-office365-filtering-correlation-id: 1da43615-10ec-4bad-b435-08db7473ef71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9VZCOfdQPh4QN+/0U5yLT0TykfVxMiiK9PeFsUkpgH2LZ7QPk/xeWELW0Kf8tEI9UVpdVHamc2sMkZU4VFKuMAN5kzXOflXk3eHWSMK72gKN5MT+a+2toa15UqQYWqqM9QPbPFkzawScLofvekfUWBatbJ0l8gI2kPz5wrySij6jNbpoF0Kw9nBH72HEukwqqecAtY5lSijHsnh/nbn0NPqE97q+P0m4qCaNhZ4eFu890k/vcHwpQkk2BHHE9FDpmUqRRHgtGD3zSDjlZhf7qfKTR/QXX50+DmlxiDh3Ju5KuO3H+pdIDsXnNME3e9JWdblru+J+j4YhokVzYX1Cm9UHXPz0dPYzXEp5bMy2kah6e8xZr+7yPiQd8R3mZ1RxWJkjdPRym6Uu5bjf9Zrm/jivwSNNmPYo2hqnLqzSyoWBq+ilE7zGCYWUxc0Yybqxu/ssRdou941wc8+m3BIkrO0IonZhIRLlipg4sdcIZlHC5chNHufSSLCDH6NcSU9auZYwaNAZ4ELaY6ulQH6nAQMp9J4gbU5lS2+61FfcE38RYp5ZlbCj7aYLSM1Kc+2ymGnpQRGnaXM9QvpNcbcPQOJ35NcLVYF6PAfGzg+SBts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(122000001)(71200400001)(186003)(966005)(82960400001)(26005)(76116006)(9686003)(33656002)(2906002)(55016003)(38070700005)(86362001)(8936002)(66476007)(64756008)(66556008)(6916009)(66446008)(7696005)(66946007)(478600001)(5660300002)(6506007)(52536014)(83380400001)(316002)(38100700002)(41300700001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKw+B/phBHbGZ7v6S8dDuGKL7YoxgtHZzKnKE5CTfAnxVrDGdhDSatkuwE8+?=
 =?us-ascii?Q?zVTNWL9JobuPW54pMDOCdeirk6ThontgF9B6gaj6HW45tyM683H3WSZV//dj?=
 =?us-ascii?Q?wCoijVjvDBVVg7mCu9knUqnvd2QwacuuBZhkSN3ua4sMHftr6LuTmMLnRUAX?=
 =?us-ascii?Q?EV5L/2d9mg3RHvjszD9hJC+9IohMcWWfXtBfuy19gXRHLyIDkt9LCgQc07+c?=
 =?us-ascii?Q?z5iwqKMZOTanErUeusRqUzmr5nP6tpUjVDUqg6i+yZrdbYd1jJcUkZBlRL3i?=
 =?us-ascii?Q?HvZfBM3H7D9hCshr7B5Q4cGgypnD0slaNgm2VGNvRrHU0GJBoZGqdLj1U+1/?=
 =?us-ascii?Q?Wl/L80FB23JApaCAVTlqYE2M4JLe5FXd1PMK9+IebIL0ZpbplBc9xv5irCWw?=
 =?us-ascii?Q?QsIMmrWGXbu32b+TGzPxyzQ+zNlq4/RjAMy7Ui/GPO0X89WXuBhYHE2ZKikY?=
 =?us-ascii?Q?2rfAI73Qpg4O/bK8dL5PhBfJNe7SG2U52z1E4NH/9uq4ETc9AP/6YUacTxPq?=
 =?us-ascii?Q?XRjXFHHjvQZU931EQgu7J7oVun/tl9hGwmK6PfojW9n/zIT4/sU6dzN2XfSe?=
 =?us-ascii?Q?f2J0fPgY2R5RvqobmTvQC8ZfTojBzXSiBV2WU4A2GAqOJVoXS4gHBTP+DZG4?=
 =?us-ascii?Q?Tti1J6ucd/6QE146Mh+Ncox082j5jtE2FNFXsxIAESMF7EMeQyIDAeAZT9ut?=
 =?us-ascii?Q?QR/EViPeOjWxVez8U7/2u3SGsByDOMDjEhOKYpDVssTdITBvdkGGIrkI9NkB?=
 =?us-ascii?Q?/46bvBMxA5FoZyHJDfSoi/4+rrkKXvNzRDg1n0A50Tz31GFeP1hhV585ahVU?=
 =?us-ascii?Q?uR3nLDB63+3t8DUlOs8ANbvKAcbXPF2+PWKwc7jc/8l3abZk70sOqsgQ3iya?=
 =?us-ascii?Q?Jdow7BNGe8P661g3XtRm5CVRpFECxBiGeVAyvJHfsZvKnq7Un8StqyxHyqdn?=
 =?us-ascii?Q?FJOyKp+8ihN+DO21P8HVoeH7ePcUTP9zL//E09mBkykVZLwjqXIv0x1Wz2U/?=
 =?us-ascii?Q?vXyp4pPNHX1p/hFe0ybdOxaC7IjttjUhUfYnFYXbO4l5ywrjrWs+if+WgeBU?=
 =?us-ascii?Q?tNiQ5VCy2fvT7EgttPB/2EaasfQHinqfbY8Cfu4Q8lCtbcSt0ajK/bPuTE0l?=
 =?us-ascii?Q?U3W8oxChd9MW/ibF2ETT+evBZSY5va5BXa2ikyqBqIZXDmg0ttqwiVH277e6?=
 =?us-ascii?Q?tErIs2kA6qd82KhV+mz4jQsYbhtDezwtS97PHhSdiQvd4qu/CGx0cxq9ZxAP?=
 =?us-ascii?Q?MUoSXcadLX2Vw8S+x1kiXZhWLfZk+ZxWULTvivlM1W22RQI53pXlSqoWd54l?=
 =?us-ascii?Q?Bn6PwVyqbjS1kkj9sSQ6fLhVCj00OxAL4D4qvAeIF8p6pmIEX6BjMGPMvCIl?=
 =?us-ascii?Q?PpE0WKlu3xSv2xzwunzZaG/Cv25ttA42KXHlPZgtDZip93vyfJuo0EPzuzlN?=
 =?us-ascii?Q?v/Na75zD9o4eeTdzGOt7QiNKADfTAAVl9nWH9d5+3QKa7bavdDA1cGjAHUvY?=
 =?us-ascii?Q?YV1RN1DwgTE9huJWVotKHeDslIQJtT77IYCDQndJ3iKkCVDvJRXgF8qou6Fb?=
 =?us-ascii?Q?VogRBq/MHo+fV8IhKn7fs+1jXcSyiJHZsk7oXYMu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da43615-10ec-4bad-b435-08db7473ef71
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2023 05:29:09.0203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvCZBoOLkJcO+m+lKC1O1BXLyTlc585HtMVRrzFOvmw/IU8ZlC7Iy9G39xBR6UmLgWs7GNEKvN8ZidzekuEBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When IBT was finally turned on by default, I got nailed with a missing endb=
r when calling a kernel function (acpi_ns_validate_handle). We're dragging =
that function out of the kernel by dragging out kallsyms_lookup. I understa=
nd this kind of thing is frowned upon, but I'm not in a position with my ma=
intenance yet to decide on what to do instead.

I eventually discovered it even happens with a 6.3.9 kernel running in QEMU=
. Note thought that I've only tested this on 64-bit Intel platforms. It loo=
ks like the first nine bytes are getting replaced with something like two e=
xpanded no-ops. I think it's a 4-byte no-op and 5-byte no-op. This then bug=
s the kernel when trying to jump to it from a function pointer in another m=
odule--clearly an indirect jump that can't be compiled away.

If I disassemble the vmlinux image and look at acpi_ns_validate_handle in t=
here, I very much have an endbr at the start. The machine instructions are =
getting mutated after the fact.

I have some code I can share for this. Instead of relying on having IBT ena=
bled, this just looks at the bytes and reports if there's a mismatch. I use=
 the assembler I was seeing from disassembly as a reference, but it'll just=
 print out the delta for the first 16 bytes either way.

If it matters, the underlying distribution has been Debian Bullseye for all=
 experiments.

Anyways, my question is a rather ambiguous and exasperated "what is going o=
n here?!"

#include <linux/module.h>
#include <linux/acpi.h>
#include <linux/kprobes.h>

// If you're not resolving acpi_namespace_node, try this include. The 6.3.9
// kernel I was using didn't need it, but I think I needed it at least in
// 6.2.0.
// #include <acpi/acpica/aclocal.h>

// kallsyms_lookup_name is not public any more and anybody trying to use it=
 has
// to do something clever. We are doing our own clever thing to expose it
// courtesy of this smart method:
// https://github.com/xcellerator/linux_kernel_hacking/issues/3
static struct kprobe kp =3D {
        .symbol_name =3D "kallsyms_lookup_name"
};

typedef struct acpi_namespace_node (*acpi_ns_validate_handle_t)(acpi_handle=
);
typedef unsigned long (*kallsyms_lookup_name_t)(const char *);

static int __init init_acpi_ibt_test_module(void)
{
    acpi_ns_validate_handle_t func;
    kallsyms_lookup_name_t kallsyms_lookup_name;
    unsigned int* as_ints;
    unsigned int expected[] =3D {
        0xfa1e0ff3,
        0xa13c67e8,
        0x894855ff,
        0x894853e5,
    };
    int i;
    int bad =3D 0;

    pr_info("Loading ibt crash test module. It will now run the test\n");


    register_kprobe(&kp);

    kallsyms_lookup_name =3D (kallsyms_lookup_name_t) kp.addr;

    func =3D (acpi_ns_validate_handle_t) kallsyms_lookup_name
            ("acpi_ns_validate_handle");

    as_ints =3D (unsigned int*) func;
    printk(KERN_ERR "Expected: ");
    for(i =3D 0; i < 4; ++i) {
        printk(KERN_CONT "%08x ", expected[i]);
    }
    printk(KERN_ERR "Actual:   ");
    for(i =3D 0; i < 4; ++i) {
        printk(KERN_CONT "%08x ", as_ints[i]);
        bad |=3D expected[i] !=3D as_ints[i];
    }

    if(bad) {
        pr_err("Mismatch in starting code for acpi_ns_validate_handle!\n");
        return -1;
    }

    return 0;
}

static void __exit cleanup_ibt_acpi_test_module(void)
{
    pr_info("Unloading ibt crash test module.\n");
}

module_init(init_acpi_ibt_test_module);
module_exit(cleanup_ibt_acpi_test_module)

MODULE_LICENSE("GPL");
