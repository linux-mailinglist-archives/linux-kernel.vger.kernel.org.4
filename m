Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D575B60B5DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiJXSmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiJXSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:41:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70112.outbound.protection.outlook.com [40.107.7.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D256375491
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAaz6YyE9lOGfvB6nT1HMfrm614IOw3TPr4HSbfzx1G4QI7SHro7xgEwmoJ+02kab1nuwsh926XV4HQRFANd+4iEqESyIPbZBMIC2hIuS35yJ/rHfjEbBpw+GQsXiMzpIPom8uUNKQCTZDzxFmi0ruMOKhl2ZKOA6wL6s+gnda3Z+t7savRdtcw3BCnjw4DGFTkHTzFxUpMyLlRehc78U0bM/eIEUjN23LbUyJyaRZZP+ux8Om9Hhz9dvelsFF24HuL/E0kXk+EUSQy0SEXwbUDCu21ovaT1Z47RYRePwHVNtZ37QQC8Q3k8GWfuMZmzFtaa5Q0qhEU/esish3dv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1hX44zi0uUOF6sQB73R9n3Cw7nLei2RyxZQ8/pzFvU=;
 b=RNnvV06tTdRBbGJbuWm1sOwVCmShErtNzqz3JGVliR+1W8/Kcqs7CEvsjsjaecZwwTLhiarp6RQNSJIdirP5d418uJ1A0ovaz2d7+8kUC+xX4w+RTmkSWDwIDy8XpryfV7xeeAHyP6iRpHSqQuq/EPR8vUeJyEb+M/coda5PegHuuP/6wt798SrvxIHigseUy5w467GEOWhle/W7IMIZ9aMWgccAftvFf0lClso58DKvpBHx7BNhiOlTMrUB/hCRV56kLGiPzJplFyViCPny+xUQPOx1yfVHyrfZc7+j2gmeTfxPOjCBnnEolr/266lFJs2fOCVQHr6gPStdfDUm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1hX44zi0uUOF6sQB73R9n3Cw7nLei2RyxZQ8/pzFvU=;
 b=sBdct6MjF/rdf9qBCzl61zamPbGrrWErXBOzFryZHivMDyeYEANqG86OsWQdNJ8y5xJiqoRM+0Ys8VfJefCBTF6fkwfEij1GC16EsGgSkoBVpKJoII3GnCZFGEWkIs9GZnI/mwWJiJPBelJME1ghdUtQV4NF8omMJDhPpg6irMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from DB8PR09MB3580.eurprd09.prod.outlook.com (2603:10a6:10:119::23)
 by AM0PR09MB3601.eurprd09.prod.outlook.com (2603:10a6:208:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 16:54:28 +0000
Received: from DB8PR09MB3580.eurprd09.prod.outlook.com
 ([fe80::c48e:11a3:c89c:f655]) by DB8PR09MB3580.eurprd09.prod.outlook.com
 ([fe80::c48e:11a3:c89c:f655%7]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 16:54:28 +0000
Date:   Mon, 24 Oct 2022 12:54:22 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: arch_timer: XGene-1: TVAL register math error
 breaks timer expiry calculation.
Message-ID: <20221024165422.GA51107@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::9) To DB8PR09MB3580.eurprd09.prod.outlook.com
 (2603:10a6:10:119::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR09MB3580:EE_|AM0PR09MB3601:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f455d0-2031-45cf-4f87-08dab5e069e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOIBbzD1IAb/YAScwotNGXZQl196v6CulxLt1JUZ4TzD8bFkgI9geIMWFDzNBcSQ+Vf2ViyKHq9WnDlZTdiuvcePKLryW/1eipaYoXWuVfAKz6+xDCoXsRnL/Lt9H/xO6x+YiMfdRU0H7+Q9LWG/nKUOUrAqP0+X2ydR2F/pmA6NNI2UjEQUGKBjqEfNfp5+LTbsWRtmIm8NDhj0+rXkOQt9swzKDtVYArK0E8YBmSy1zmjyXBsRzrEUtu+XsVOGzu2HjlkUMc3EgDkVMNZIFpsxxGgAGviXgWNM67Rt+zWzBKEvK3WZZ10urBSB95kUDGI5gPpNJiNa/PPIt5VR3Sa8pqN4h5lUOFcPqvgZ2djt13LON2eLFINPww0uU6TQNrF6fndOff3dd1RFYN+mlsxWrg/k/FNukDhsjMma+shS/6/1ojRYyiYlY2wK1gwApOzZ6BEDpYlpMBKChGSJIjfdS5x7g0Sdig6gpFc1LP+2+gIpdF14/Cke9fHrtW6QyZjzLAG2Hez0hLUztP72h8Z0D9ocHrTMvAY0j8h8ZxJH4KJkkT2Ei9Vd4Di18oxR6eBaJce+l3Bqj0BNU/+sPKJxKRYDpcxfl9SDARJH4b0nCvNz30i7jBKljl7nsGDDj4hl0tGhg+grA2MHRcUPwK/RTJ9uoAvnKuc9cQnD/EUDpe/4HvFJjCvmTfyzSsC1/LDnfgWcjcWjcryfHPQPZaSQuB0kihbktG4SVYHBwmJ0ANvhSKk6uzMbWIgMOidM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR09MB3580.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(8936002)(5660300002)(44832011)(83380400001)(2906002)(86362001)(54906003)(38100700002)(66946007)(66556008)(66476007)(4326008)(38350700002)(3450700001)(41300700001)(186003)(1076003)(8676002)(6512007)(52116002)(316002)(6916009)(6506007)(33656002)(26005)(6486002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EH7TnuW+j+v/nIVWTMgd5xymGgN+rVOm77xIBswWqMCiO4v3vb2SEwNGZpxp?=
 =?us-ascii?Q?gK2M2X3Rrxv4ZnpRauLFMYOrNqy9V66migHdgYpEB8VPGHEOHw7w6hPgq7h2?=
 =?us-ascii?Q?TY2HAIagE/LzKC6iwMk0iRApSdnw7xY+fqoz8hW2Pwi30wx1ynXukUcTV/FV?=
 =?us-ascii?Q?XVAdn6CIW9iH9B+1EMjbK3Q9E9UGhJ2S5HU7gxmSv4c69X9W5dzS+bjMjRQP?=
 =?us-ascii?Q?7FnfKel76KjxqaZbOgFmYyxpv3epWMdJdoHVJEfnCkVpR6hXLua6dDnTHT+S?=
 =?us-ascii?Q?zdPhWoSTQRBfttU+dyqGie7Ly+UAKKcWod4NP8pfk5PdFNWE6GYNA0XqvxSg?=
 =?us-ascii?Q?RfnNnv3cKwof6UG3Rf4cM9BzP0vvK6nsgIBezxyBQyTjGbxlMD0uqR1XrNqp?=
 =?us-ascii?Q?WElvYU4R4r44HnOe1Cx5F5HaSXQbDR+nzgi9UZi+iBVKfkyAtnYEAGliYHnO?=
 =?us-ascii?Q?aBY9P1XlrCl1fUcOYyPSllte1e7oPUc1c7Gn5L/sizq5NeMzuncBvkqabf+/?=
 =?us-ascii?Q?Tdrt7BxDjVZ2xLa8nv1QU+6foKWrbzlRJz+fZq88TlCRxMvm/Ej9NUOMf0NI?=
 =?us-ascii?Q?4jDJTDHL8zowxqPpgqmPwEd+C0tqfox8zbi9d5Wi7f97l5ktxNkyksPiBVvd?=
 =?us-ascii?Q?pctcGB/P9bqHHRhVnTntaiGuz76ER+eCtDkYH7q7T+b6tkAmSs3Sz2j9t63F?=
 =?us-ascii?Q?W3ITgOa2jI8SCt3QK0NKCG7O9ggaQFdVsv81zsKkxJg1SSsdAo/p56Yj9aHf?=
 =?us-ascii?Q?pxa18+HaJwaaUKCUWm+qksZqvIA3hClA5KoNvakYN0ur36zZ136YUHLLltpx?=
 =?us-ascii?Q?jYUmBQcNE2EBbFSzk5P3tL8chf7KejLbW+pgwtO9mY3rHtHfRwVTOIrsQDRi?=
 =?us-ascii?Q?ZpRbgXxCYKI/ETp4H2JYPu4WMc0tQG1kqo/93CgVt+hqka4Oet3I2OgyC8mH?=
 =?us-ascii?Q?fDrvdtFdtPRsN41MxT+mfYdel/gaaonnqgVtwAdJsR9wFcOx5qh3wzHNWMgo?=
 =?us-ascii?Q?PQyyXXiu0xLPn9a6whuxjU2AApAzzvjF2h9ASdkgpY/0myxEXaEFcShDUlFD?=
 =?us-ascii?Q?hqKUUbzJDM90wxW8h9EAW3GMHDdV8RhyfkNHZscsgu030NMLASqJBD2AffdF?=
 =?us-ascii?Q?ISuYJ5aRzrOZ7F1ccYdmSNg4o5A1cZOOsNz+kKy1lgCNQUWfI2moE7kh5h8V?=
 =?us-ascii?Q?KuIP6+3sWJt3LC4j/ayEGhs2z5wxa0EQhGPX4hooxL7fuJJWbNJNwhj7IC5X?=
 =?us-ascii?Q?E88kXjaLLWsP9VSJ61ax6oXcoVcB/E4acVt+WDcJzh1hdx6HFtvr6A0liygy?=
 =?us-ascii?Q?liwuHyDJI5ajzA5eoaOijj4mtKz07WvpbxeAsW1+Md+SnczG7kDYq8R0jyB0?=
 =?us-ascii?Q?BlyW21jDv+ULK8niMPh+b1lK9zVJnrKW0rav60CyTjTloLyiGOGPKlXprD+J?=
 =?us-ascii?Q?0+P6GfoCeYulT9txBYHk1BBZDuYrkOaHTXs/sPzusVfsGjXZ4X+1cd0benhH?=
 =?us-ascii?Q?4e5F6tjV3rutsvKjHQoCs3SsfldTCRuEzEv1CRXcoCmVb6dOPPHarH6xTPvn?=
 =?us-ascii?Q?p/Bx1/f6qvy1LkNrg1epR6AlojFvSAJaj01BSRU19/XOXvVYoiGWMvQBR4ZF?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f455d0-2031-45cf-4f87-08dab5e069e7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB3580.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:54:28.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNjjwn8PM2TE2h6FqnCFsfR8J6yfx9Xq2rSd1fgTJk7spJjnhK31mRvjrfMWwtqdrZPuFgwchL0FA+C7hUYMezYUIcM/wCry72nVbKBpkoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3601
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64: arch_timer: XGene-1: TVAL register math error breaks timer expiry calculation.

The TVAL register is 32 bit signed.  Thus only the lower 31 bits are
available to specify when an interrupt is to occur at some time in the
near future.  Attempting to specify a larger interval with TVAL results
in a negative time delta which means the timer fires immediately upon
being programmed, rather than firing at that expected future time.

The solution is for linux to declare that TVAL is a 31 bit register rather
than give its true size of 32 bits.  This prevents linux from programming
TVAL with a too-large value.  Note that, prior to 5.16, this little trick
was the standard way to handle TVAL in linux, so there is nothing new
happening here on that front.

Test procedure: for some reason, the lockup watchdog is sensitive to
this bug.  When we turn the watchdog off, then run a little 'hello world'
program in each of the CPUs, there will often be one that 1) hangs up
forever, 2) hangs up what seems like forever, but actully contines after
a few minutes.  In either case, the program cannot be freed by a ^C.
This test sequence requires CONFIG_SOFTLOCKUP_DETECTOR, and probably
requires that one of the NO_HZ Kconfig options be specified.

The sequence is, for an 8 cpu Mustang XGene-1:

   echo 0 >/proc/sys/kernel/watchdog
   for i in {0..7}; do taskset -c $i echo hi there $i; done

Note that though the hangup usually happens, it does not
always happen.

Some comments on the v1 version of this patch by Marc Zyngier:

  XGene implements CVAL (a 64bit comparator) in terms of TVAL (a countdown
  register) instead of the other way around. TVAL being a 32bit register,
  the width of the counter should equally be 32.  However, TVAL is a
  *signed* value, and keeps counting down in the negative range once the
  timer fires.

  It means that any TVAL value with bit 31 set will fire immediately,
  as it cannot be distinguished from an already expired timer. Reducing
  the timer range back to a paltry 31 bits papers over the issue.

  Another problem cannot be fixed though, which is that the timer interrupt
  *must* be handled within the negative countdown period, or the interrupt
  will be lost (TVAL will rollover to a positive value, indicative of a
  new timer deadline).

 [ v2: Expanded CC list - jak ]
 [ v2: Revamped changelog - jak ] 
 [ v2: streamlined inlined comments - jak ] 

Cc: stable@vger.kernel.org # 5.16+
Fixes: 012f18850452 ("clocksource/drivers/arm_arch_timer: Work around broken CVAL implementations")
Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
---
base-commit: v6.0
Index: b/drivers/clocksource/arm_arch_timer.c
===================================================================
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -804,6 +804,9 @@ static u64 __arch_timer_check_delta(void
 		/*
 		 * XGene-1 implements CVAL in terms of TVAL, meaning
 		 * that the maximum timer range is 32bit. Shame on them.
+		 *
+		 * Note that TVAL is signed, thus has only 31 of its
+		 * 32 bits to express magnitude.
 		 */
 		MIDR_ALL_VERSIONS(MIDR_CPU_MODEL(ARM_CPU_IMP_APM,
 						 APM_CPU_PART_POTENZA)),
@@ -811,8 +814,8 @@ static u64 __arch_timer_check_delta(void
 	};
 
 	if (is_midr_in_range_list(read_cpuid_id(), broken_cval_midrs)) {
-		pr_warn_once("Broken CNTx_CVAL_EL1, limiting width to 32bits");
-		return CLOCKSOURCE_MASK(32);
+		pr_warn_once("Broken CNTx_CVAL_EL1, using 32 bit TVAL instead.\n");
+		return CLOCKSOURCE_MASK(31);
 	}
 #endif
 	return CLOCKSOURCE_MASK(arch_counter_get_width());
