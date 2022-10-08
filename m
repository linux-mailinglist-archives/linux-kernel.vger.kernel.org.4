Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A045F852F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJHMQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJHMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 08:16:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2048.outbound.protection.outlook.com [40.107.117.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99741B3E;
        Sat,  8 Oct 2022 05:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AliXNVBQW1Uz7UQsRKdS5/OyT0hl6ruKCg72dHbe+wcCjJNsiC2NXjmkY2Bte2zjWtjt0DTdsuQSqOQKaZ4MhDut6B16JWtFazHx6KuDTbWJHmdc+VIF1AQ5GR6SX/FHUqMdvqOzACMCsoNFBybPGt6Uop8Zg6XgjE2ApBSidAvzHYvXuWZUvgl+6GZN1zlJJ5BmPADna5miOeE0VqD3aO2NFWlbCsXgwZJmpimw4qwr52YqRipbe9mICFs84t4Ne74BCKhPfymFVeoJcFQjZBZQL08mHMakj3XjlUzL3687Z58dc5iyEnqtFD6W1eP2T+VwMDYzNzlvXLSKczTORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsAwbiWRcEqytpqy1yxD1PXhAwssN94OthQsGV2eSrQ=;
 b=l5rGKjWCat3Y+lAT45+pt0LbJTjVIIldA/x3Epsu23smbkB2xhXcArZvdpSVUcpfMHVFtzPv7WPwTocrNEhIZQAgOZ/1mm2ej4btJxxWrvck4HUEacIBYpLuAB1HEDT0wemMy+hcazbtka0cXYqjdzRxE9tsLgP93IkcMGWaN0xX70YnPjKZy25A1HiESGF2M+xRYE6hlklUq/NsHiw12oa5Amt7uemg6UX69a8gAoExjX45suqOXIFjW+wr1YlR5GLviAH9ZZifQjcuJxiDdBokPEJeceF/um/yORNLIQXOD4Uls4loFBPWWxwocus1uzhxY03FBCvjVo8yqHEbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsAwbiWRcEqytpqy1yxD1PXhAwssN94OthQsGV2eSrQ=;
 b=rRTs9Yat2AHLPPRUHkcXoftuARB2q+1mqkG06lbpu/aumWuKyTCJl63Lj2iVZqi8W0ePqBeHzj6PhahFb1cGRsiZmiU67tz+bpFvlLa9RZ3hWOx05iw4gw3rmDrB6JfrzJXeci/GAetQkvKHJ4TfDNlEsjYFS+eFEVjv0Gyn01A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com (2603:1096:203:7e::13)
 by TYZPR02MB6107.apcprd02.prod.outlook.com (2603:1096:400:25b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 12:16:43 +0000
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::9908:e73b:e847:8033]) by HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::9908:e73b:e847:8033%7]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 12:16:43 +0000
From:   hongchengwen <hongchengwen@oppo.com>
To:     hongchengwen@oppo.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhengding chen <chenzhengding@oppo.com>
Subject: [PATCH] ANDROID: cpufreq: times: record fast switch frequency transitions
Date:   Sat,  8 Oct 2022 20:16:37 +0800
Message-Id: <1665231397-115755-1-git-send-email-hongchengwen@oppo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::8) To HK0PR02MB3379.apcprd02.prod.outlook.com
 (2603:1096:203:7e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK0PR02MB3379:EE_|TYZPR02MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: aaaf7923-86f8-4ad9-4f8b-08daa926f617
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5I9fwXYQuRcsbhYCiJ6Y47iQ0xU7ui8f93ZFKvPGRiAan4GE62xp16TlRa7x3mKdNDCEoHVPzgKMpFOQHc85iXb96qO8n9ZR4iUGZ9QnflD8d51U+ssyKR2tTZQhRKoc6v/bm5ciNVyVK8qTkk/IndJw9juUGHGKqWsZHuMIZog6fwek0/xGalLBjNFBFjqRwlorYJjxJuzWIkmUEgCiiT8JgUxgPI0+xn6GVkrfwC0hTOeJNSlYxenj3B8tyEgcvZuw645g+xYCSuCt3r9ZYW8TnQ+IIkM2iLT6VCyKshXE4BXYtiti/x5G2O2jZPWuimLCPEhhmCfj/UrNQktNy7m6pDHposwi2eTmrv3yvrga1oC2Wx2RjbvVZb6yRMoWo45/aeakD+GymRj5hFpqsp3/DNe0WA3p4RIVSJ0fNXClVrE9fJ6eWHS1+i5LRsD2Mg9Khu515hbwRzMgjGDPbjwrvXQciFITicajOuoPcyqcogdoAx9wGjx0Nh12CwqkLttkdZYIuAgdKQH3JzY5MoACoXKOvjiXGGF9nXr2atSdGVwa7xODExAe2D5x9PiIk7ptDVmYXKHRg47L53c7xWXAbqnUQdwBpbe/LPAkc3UlHofZwArW727TFPKmgZVmgn+vwRU5QVNc6SW94JL01lh5SkQX+xrcm7fJPW2tUEedjTQ08S+x/D1fFTG+tDzjutytPnjk9a0s2z1pyhbc52WyA27H3mSRZ5cTgCDL8TXLbopgzEwtRR0d1TNNSe8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB3379.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(83380400001)(36756003)(107886003)(52116002)(6512007)(6506007)(2906002)(26005)(6666004)(4326008)(66476007)(66556008)(66946007)(8676002)(8936002)(186003)(2616005)(41300700001)(478600001)(6486002)(86362001)(316002)(5660300002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6RWsNRwGXZCPUWQt2rTza6JfrTYKIrLvoNnk8+r3KXhT+OqYWpCvQcM99FhL?=
 =?us-ascii?Q?b6pzWxduOAl/tV5ACQcdk8HBHHkGhZ7nxLOlJeFCtDIR6fRI/HQj02eD4eiN?=
 =?us-ascii?Q?JVl5lHYkIOBdLu2XJgAYjXdmDr01+qaI3mITkklZc5mKQnhGRMsS7Ten8tyM?=
 =?us-ascii?Q?BP7KgeXXgHP5lKwsOV3fGCbY3wdmjj02TOsijhqDBw1P1ZPL4jzA4L1P9Gfz?=
 =?us-ascii?Q?ExIu7DFfjzgGDqkfob7/9pyb5G+0gxCp8Np6Mriqv/Lc+SCaPSnLjtYEx+4P?=
 =?us-ascii?Q?pO0OetpsNmoSqWIGv87SHVGf5xUjzHzuc3rpPRTxdHhR563//N6kxyzIAzBZ?=
 =?us-ascii?Q?mGsgBMJbEJOJJQvO8ajYO1dQal5M2N21ET6J9vM2l1RjkbGsgGKXYHNaGv+q?=
 =?us-ascii?Q?glxpG0MkCQGnFUeUWw8zYdgK7NibTOGEavb/ac/dHASf699AyZMUmFYsV9Cf?=
 =?us-ascii?Q?v8J5MTPG3TFK37JSO6zModZ18gEft73YWzy2uZhyhI+DCwbOuFPnXNqPKO1p?=
 =?us-ascii?Q?5OjE2aA61Ja9RoRXU2lilmiOaDAnQlYMFJ1+In2tXllKLJrLyaBT/OC/QMel?=
 =?us-ascii?Q?zcdF4WvhUI7lPSOsQGMzq4dDcs46zouAFW0RpymusPlfX2tOKhWnCAmISEaG?=
 =?us-ascii?Q?L6CVxkVLWeRdp/Oalb2bEXc+QrcmZ73FF+veOtuHHvm7N/yfDMqUY4acv1IZ?=
 =?us-ascii?Q?kgRpS7mEi5HzQ1UY+WJ+y+THq7qkJBhYUYd24tPjs94nhb5hZzadq/ncbiJa?=
 =?us-ascii?Q?qFrZz6rejKylrxe4n0OCXlbQ4J+i2PGCnb8TAMdYsup89U/S500vRrHhsAs1?=
 =?us-ascii?Q?mgUz95pbuBC4+2XRzjGE1xxHaqHQGUUWphc0HSTMZ0D2rkSNTJOnfosKDoKJ?=
 =?us-ascii?Q?Vyiyc6jOjOc4oy+yHCb71HTjb1ZuoyGzH69H8TIouSjgHqcfraUM5vHCOuYI?=
 =?us-ascii?Q?znKWmc1wYaCp+S5S/iu87L6roA1+TQ4I58LgfoFlc/FlIFzLSn9SGplS1SPR?=
 =?us-ascii?Q?dLCa/nSs7dQUkOiQjgVPYvKbk+uoG+UYRjhnOqERghXp6PpHJ16TJ604zSab?=
 =?us-ascii?Q?bE3F1ihN9ayqDE32J2g5p9+oNXbRTLyBNwv1kNXbO3QmAjG3RdkznjjZOU6C?=
 =?us-ascii?Q?md+D2a9wnfOyiysVXU/uSZsdRnIELt2bBSA0pkUbzDNeBNSgUksYMaNtlmGX?=
 =?us-ascii?Q?P6j/C0DIRO3Nt+4wYNIdpoPwj3XDw3uwS9h6CBnk5+CphpvEZawmZKD+sMON?=
 =?us-ascii?Q?bghWM2f9VZ70aW8qAyqieId82UrFFmltV+u1RItuVPSfVATEHhF6MdsCTgeF?=
 =?us-ascii?Q?UiMlVlw/5S3Cfik6eOFygBhmQasfQego5v5yFg22EPfKdVTQoVacKuYabiV9?=
 =?us-ascii?Q?MJF/MoIwyxAYpYoeso5Cm3B6W21icgXTbOp+xW13hrFiUiZ5twlQSaZyrvGP?=
 =?us-ascii?Q?sNTuBLqlBmwPAnpO/NmKQYx0CzHgJbHYiI2eszwNFgC3j8P6oarleFKF1rov?=
 =?us-ascii?Q?OQf53Iwgjvs8HRXNSLjIolEPg0g5MauCudNVlpFQP02zTTAOujz0yphJxcMV?=
 =?us-ascii?Q?6Xbof8mc0KAZjWVuPzl/eFn+vIwYlCoi9EuW3cKA6hPtRiZaf3ZvmqF7oqQM?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaaf7923-86f8-4ad9-4f8b-08daa926f617
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 12:16:43.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2abwEv5DNJZiI/1D4Te4sAqY9YMmF1hPyQYP1ht1ZGeFBHxdopJesc5kj8PgdjrGs6yUxCdzRk66SDdy8zUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6107
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengding chen <chenzhengding@oppo.com>

cpufreq_times_record_transition() is not called when fast switch is
enabled, leading /proc/[pid]/time_in_state to attribute all time on a
cluster to a single frequency. To fix this, add a call to
cpufreq_times_record_transition() in the fast switch path.

Test: /proc/[pid]/time_in_state shows times for more than one freq per
cluster

Bug: 204726690
Signed-off-by: zhengding chen <chenzhengding@oppo.com>
---
 drivers/cpufreq/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b3d61..1caaf63 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2128,6 +2128,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufre=
q_policy *policy,
        arch_set_freq_scale(policy->related_cpus, freq,
                            policy->cpuinfo.max_freq);
        cpufreq_stats_record_transition(policy, freq);
+       cpufreq_times_record_transition(policy, freq);

        if (trace_cpu_frequency_enabled()) {
                for_each_cpu(cpu, policy->cpus)
--
2.7.4

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
