Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4026EF3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbjDZMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbjDZMED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:04:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF91B4;
        Wed, 26 Apr 2023 05:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he4L24kBzz7ff2wqdkOcocC76tu4rnsWK7rSp8oZOTFDzb+dthIxJvRcZkoQPpyLoP8nlO1LM9oxHBa7P/v/tkVv7+HUiMuzjfoLFbHe94r1EytbYzqk4WA4+xkIxyJc5y3vq3COeZmchzQ9yWt09VSyWNvGCeM+bNmhMHBNQHfVagfmgv+tafzuiU6sc4igPZi3gI+C/uKUNtQfI7PD6c3+ag39cvr5wBuIh9b6UFYUljpew3OjN4RgkCFxe1cr/tO0iYD3mt/TbQx2QJckBm+I8axicwg3LtReYlZ9fuA57Df5S4IYDoV4TVDg7i56w/wLHQ2ToHln6KUiMNpzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5JZE/2+zqYLgDJQzb93OAVzZ5bUofpVifyhXKUloOM=;
 b=Bi5L1m89wapbBAOQdq//xwd0Rhzk97lz9j5BJy03bHO8CUwdhbHl2TkN7F0WceiWJrV4pSE9xi8lHKXy29zbEOt8YWzvl5BG91VLoTme7QR4s8OVS0KYrcqbmavrKzTPedRMcxe2Cr+PnfPgbalMCQl5K/p6RLOeaX8707D05qK4mGJ9ACG/cAg7RqkLgtyFmgIE+FaaSuGq/iMpcZsfngqxHLUhuju3W9QHbgd3+cjSjhhTXcu18uIorYAhQpQH226MrhM+YEchedee5g8MjszR2nyWG6MUZ27YGBXhYf/j+mBlxsii+J44JrVhdXMm+7kpuy5lZsYYQNuix93W0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5JZE/2+zqYLgDJQzb93OAVzZ5bUofpVifyhXKUloOM=;
 b=XCDxHAmKtWAIBbl4gUNUU0h/nApwvmES3Hb8X9jJcqzGJPMrd+HTzPiWyELGIxhaxUmFat8iX9zAin0vlVZNanJM8DWDWlFrpEwTbUnuyN3ZAVWN83apD/YkIXdgOFVErgpx9f7RsGc9MokR8zAP92C/labEtvxKsEr4hrt1Sur+pULsv5ZufQEQ7UPZrmV+kykgNVQxSxzQQNXwzrtKvqwywEWA/1Ynrd40AIPIFpy7rf/TNZypBXl2u/XdMnytYMF2o3Kx9DAZ8CNq78qvdb1GthPZ8Kd8NHwC6uidBUi15pAYP/mDYiUZROfMVXZp2ZSpuDlrbPpsBNZeHk75rw==
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22)
 by AS4PR10MB6157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:585::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Wed, 26 Apr
 2023 12:03:58 +0000
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cfee:a2b0:879d:f8a1]) by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cfee:a2b0:879d:f8a1%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 12:03:58 +0000
From:   "Bouska, Zdenek" <zdenek.bouska@siemens.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Topic: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Index: AQHZeDcurMHHnME6s0CFTE/AvBQiTw==
Date:   Wed, 26 Apr 2023 12:03:58 +0000
Message-ID: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-26T12:03:57.893Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5675:EE_|AS4PR10MB6157:EE_
x-ms-office365-filtering-correlation-id: 1caf73d3-5515-41d2-d188-08db464e5104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: InS4uCp49y1vmuHbhC4+iQ73yZP+rH1GTc+4wOQK1MOleOIMDS5tz0jlP/khTSvAQlS6GeL7vV8zIMC7p1Mwc2mndfj94EIPV2oyo20B2DGoJgAlIPyTVF4nptusk0NpYjHIaybHCAQx8OyrxzmUPKmUoTn6lEWqa4njDhHJpcM3fv0LA3H9wjBa5A4PmN8oEf+D8U/mpeqen+M+Sh+H379ZJZ2IpkBt7Q3JYyF47wGfo/vnZ9GOTqgIVBY14V1+m7eI38Gq99iwgVh2+ZhMN3RvHnQYG6ARwHc8Gbh+kith3kRwu/0hjmCFazbe/A41nPogW0xBxylVi0PvJeK6JVAXVo26d1jUZQUoYTQ3aPBqD+a+kIwggx9mTsbCUake+xCs5BhET7Lq8xEItUaSvLl7ZN+2AMcQGmmvT86Pyg8EvXid3bikv1fEWLnxm9wE7NCsX8t7ptcwOI+yLvGvftSyIgCMSBqWykuGh6eGvnAsvEKxKw8HZz/KTH7JDmopNTUY3LCgq54TKtCsIrEftX6e6uiZS0xhCsBSlYF1jRj4op6KmzGes4NcMkotJshPX2m+iZQcuaDoq7ntkarszyuEaIFnh1hMteb2lCMWbTI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(82960400001)(76116006)(966005)(66446008)(66556008)(66476007)(66946007)(71200400001)(7696005)(2906002)(64756008)(8936002)(6506007)(55016003)(186003)(83380400001)(8676002)(9686003)(316002)(5660300002)(33656002)(41300700001)(52536014)(38070700005)(86362001)(110136005)(54906003)(38100700002)(4326008)(91956017)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?MwmsR1yHG+BbENQPtreu+KdBnHUjDZ0LFePxa4F0Z/YrA4TgFb3H/RxBzL?=
 =?iso-8859-2?Q?t1EHk84/OaXject6JyzxpYq5i8f2wBUaIny5MliCwwpzqWF/LMmCfNZWxX?=
 =?iso-8859-2?Q?nJuPGNBGAuc49b/7G5mYJGowXdhPvMn/mQJyEMuMwBugaDESVcq2t1wnhI?=
 =?iso-8859-2?Q?UjhcKHXK42VpL5sr6YTpd/vujbj9nV+O4AYdG6I8ynpWsDDqiduiTq+Vge?=
 =?iso-8859-2?Q?nufwcC9u4ziHlzbUF/nt0pJwWItdosWVsUp6exGR9I83//wcIYeJrfGHw5?=
 =?iso-8859-2?Q?l2dQhLiHSKrrkHo4hTRmcqFeLZc6bPrZNyeWJXonOKkvY2Z0j96KPZy7f3?=
 =?iso-8859-2?Q?K7cqxKB0u0zsLn9lCy2ePMH2Kdxo1obXzqLddYEoE1y+bZtuuav9j6QlHM?=
 =?iso-8859-2?Q?p4q782LBsWSEfXaORKuYwpsTbVNfRg576dZyeU6LRJixB6M0gWVJ2D5M3k?=
 =?iso-8859-2?Q?XhT+SQZO8SZ9t+XHjpDRb33VvmCRj5vyDS8M7s2VUGu9ZEjSEIrPdNLcYh?=
 =?iso-8859-2?Q?kXVumnysSuzGGVNI0MtRSqJXkuF+/L8nHSBQZjrVW2PC6au2E7m3E8JLYq?=
 =?iso-8859-2?Q?axAwhZaY4D4UmsnByz5+3Zydi5SAPUGGccWayG+wRmJWXffAHsgshlyDTN?=
 =?iso-8859-2?Q?nvjLeMDJsDqLLMeW1DPeoPpHPqbErAKqJF8wxBsft1Fi1J6wU009SRH+o7?=
 =?iso-8859-2?Q?eOBXMXXAi3JmPChqaRctDbEeb66DNj76Ds5BSAi1RJuJoR+wAHockULupO?=
 =?iso-8859-2?Q?T7+5d90OMT8Ymr7FZGVZAEAdfEcjQL55h/Rie/ziicUjmimcjvBHGIPh+y?=
 =?iso-8859-2?Q?nCAajNK3WyrnhI8jKa47cqAnXBgVaNU28E9OpZSC5pq27kBDKxSQfDUib+?=
 =?iso-8859-2?Q?mFmegHS3SJIPzEDDSooAOXg4qn2PojgbltAr5Od7MR5HFB22CDHG3QXcL3?=
 =?iso-8859-2?Q?yNBDfiORwQJE6e8wrJdf8SbOz1lRJ5vNMP+2sHuDbu2RiXfmRTHMznWu/a?=
 =?iso-8859-2?Q?8pQf0tofjak92tjUhUzPtl4CvRTlZjCgZ79jQbWAtNYTubH2eAb8LGFnBC?=
 =?iso-8859-2?Q?G47CMFP40VlN23bh0GW27Z5t/z+4jem27X43tRp5CZ/+FN4lveMR06uNFO?=
 =?iso-8859-2?Q?o8jZUy/UZ2r0S+s11fNGROkytZn6J5ljRrm48WMStPxemOFshLdYkeHOOf?=
 =?iso-8859-2?Q?qoN5irVAT2v/73uvFRpQ0hypuRdXFHEPYW6fkHAeTHnGmucxFCTh8niICq?=
 =?iso-8859-2?Q?GOiZA5vBlzTEP8p4vGmhM4KmjLaPAIKbqAXj9J7eKNzdrFrkWpoEcCMGgf?=
 =?iso-8859-2?Q?yHI/bsqYDlrovzBkuTQGF57U2vRlR3+/gmRJG6WVS4RqDQCOE94Irm8iPl?=
 =?iso-8859-2?Q?eQOrHGtyGcRHR1DqvKYXluW+01tfvsMW6ELKAXKpGIsUapU1hH7TLpa2Gr?=
 =?iso-8859-2?Q?NrAMmNCacGn6zi7Bdu/ltUTQdKVjW/dyIGPj+ETDuy73eBSoJ+pavL/qyB?=
 =?iso-8859-2?Q?Lo2LyhjVkETpvb9sUkrn5PukWOYZWr3kvgjVaK859jfNy7PDKEGxvmPWD+?=
 =?iso-8859-2?Q?LRBPLQsNAVwUsq+PbomDqXGGgQ91wOBoA63goVUf6Ar3d2d9c/9u568cyA?=
 =?iso-8859-2?Q?UJHCL6X3ctCzhMh97Fz8baNfVn9WlEtnlKPVRtbRiuh08foEGZRU3IYzUA?=
 =?iso-8859-2?Q?9dcJNuceg9Sz0RgrlSQ=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caf73d3-5515-41d2-d188-08db464e5104
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 12:03:58.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZDDgBpygFJTMiis/0mpBNJt6uyrSednStTCTU4rrlkZEKZQLXOWuYZvFybOL8oH+qg8BPG8HtHccJllyiR905wSfyPPh6g3UTvWZ8KEzw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6157
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
following patch is my current approach for fixing this issue. I introduced=
=0A=
big_cpu_relax(), which uses Will's implementation [1] on ARM64 without=0A=
LSE atomics and original cpu_relax() on any other CPU.=0A=
=0A=
Anyone has a better idea how to solve this issue properly?=0A=
=0A=
[1] https://lore.kernel.org/lkml/20170728092831.GA24839@arm.com/=0A=
=0A=
Zdenek Bouska=0A=
=0A=
--=0A=
Siemens, s.r.o=0A=
Siemens Advanta Development=0A=
=0A=
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/pr=
ocessor.h=0A=
index 3918f2a67970..f3861ab9f541 100644=0A=
--- a/arch/arm64/include/asm/processor.h=0A=
+++ b/arch/arm64/include/asm/processor.h=0A=
@@ -367,6 +367,23 @@ static inline void spin_lock_prefetch(const void *ptr)=
=0A=
 		     "nop") : : "p" (ptr));=0A=
 }=0A=
 =0A=
+void armv8_big_cpu_relax(unsigned long pc);=0A=
+=0A=
+static inline void _big_cpu_relax(void)=0A=
+{=0A=
+	armv8_big_cpu_relax(_THIS_IP_);=0A=
+}=0A=
+=0A=
+#define ARCH_HAS_BIG_CPU_RELAX=0A=
+static inline void big_cpu_relax(void)=0A=
+{=0A=
+	if (system_uses_lse_atomics()) {=0A=
+		cpu_relax();=0A=
+	} else {=0A=
+		_big_cpu_relax();=0A=
+	}=0A=
+}=0A=
+=0A=
 extern unsigned long __ro_after_init signal_minsigstksz; /* sigframe size =
*/=0A=
 extern void __init minsigstksz_setup(void);=0A=
 =0A=
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c=0A=
index 5b7890139bc2..3f4fd24bd4b2 100644=0A=
--- a/arch/arm64/lib/delay.c=0A=
+++ b/arch/arm64/lib/delay.c=0A=
@@ -67,3 +67,29 @@ void __ndelay(unsigned long nsecs)=0A=
 	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */=0A=
 }=0A=
 EXPORT_SYMBOL(__ndelay);=0A=
+=0A=
+static DEFINE_PER_CPU(u64, __cpu_relax_data);=0A=
+=0A=
+#define CPU_RELAX_WFE_THRESHOLD	10000=0A=
+void armv8_big_cpu_relax(unsigned long pc)=0A=
+{=0A=
+	u64 new, old =3D raw_cpu_read(__cpu_relax_data);=0A=
+	u32 old_pc, new_pc;=0A=
+	bool wfe =3D false;=0A=
+=0A=
+	old_pc =3D (u32)old;=0A=
+	new =3D new_pc =3D (u32)pc;=0A=
+=0A=
+	if (old_pc =3D=3D new_pc) {=0A=
+		if ((old >> 32) > CPU_RELAX_WFE_THRESHOLD) {=0A=
+			asm volatile("sevl; wfe; wfe\n" ::: "memory");=0A=
+			wfe =3D true;=0A=
+		} else {=0A=
+			new =3D old + (1UL << 32);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (this_cpu_cmpxchg(__cpu_relax_data, old, new) =3D=3D old && !wfe)=0A=
+		asm volatile("yield" ::: "memory");=0A=
+}=0A=
+EXPORT_SYMBOL(armv8_big_cpu_relax);=0A=
diff --git a/include/linux/processor.h b/include/linux/processor.h=0A=
index dc78bdc7079a..3dc5e3fcb400 100644=0A=
--- a/include/linux/processor.h=0A=
+++ b/include/linux/processor.h=0A=
@@ -59,4 +59,8 @@ do {								\=0A=
 =0A=
 #endif=0A=
 =0A=
+#ifndef ARCH_HAS_BIG_CPU_RELAX=0A=
+#define big_cpu_relax() cpu_relax()=0A=
+#endif=0A=
+=0A=
 #endif /* _LINUX_PROCESSOR_H */=0A=
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c=0A=
index 8ce75495e04f..cc8445de1006 100644=0A=
--- a/kernel/irq/manage.c=0A=
+++ b/kernel/irq/manage.c=0A=
@@ -21,6 +21,7 @@=0A=
 #include <linux/sched/isolation.h>=0A=
 #include <uapi/linux/sched/types.h>=0A=
 #include <linux/task_work.h>=0A=
+#include <linux/processor.h>=0A=
 =0A=
 #include "internals.h"=0A=
 =0A=
@@ -1101,7 +1102,7 @@ static void irq_finalize_oneshot(struct irq_desc *des=
c,=0A=
 	if (unlikely(irqd_irq_inprogress(&desc->irq_data))) {=0A=
 		raw_spin_unlock_irq(&desc->lock);=0A=
 		chip_bus_sync_unlock(desc);=0A=
-		cpu_relax();=0A=
+		big_cpu_relax();=0A=
 		goto again;=0A=
 	}=0A=
 =
