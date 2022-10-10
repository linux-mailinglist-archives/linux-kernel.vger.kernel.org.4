Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE55F9A01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiJJHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiJJHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:31:41 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2088.outbound.protection.outlook.com [40.107.255.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E2E46238;
        Mon, 10 Oct 2022 00:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh370xZ296JHRhQcXYRq0ttMq2RlqNh982vqbUJRzgN47JACN+ZzXl3nE23oC4u62elv7ZwKo+ix7paXJtD0ZHRJj7VitlTpiVZKUYLOKY2EWhflDk+JiVgrvXsOiWrI6PyfY6auZ1ut7lOCfeOcD7nDcd7nBEQxSSvmPzFXZXUD0ULZ9mCpM9a4SB+UQ5s+BNoNFcgcQADQZLjPT6G9g36FZxR6ZcoU/INXUkSRuF1FwiDb0IGNt/Ru//ZgvwEBqN02m2Le+sVzUqdbPeolJMu2Ka3YzWfTdM+zgyeFCPGGTTwkUTnz709HkmuEgvm4XN3zxWOfYqalyQYplMXdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGNgz5NhBdbGp9k7dLt3a7VOlsNKipIAeQiaSN5OfjY=;
 b=TMS0yRKrum8NDZyJnww8aTGNGbZGnPcnrRm+YItBJE4teJUFttDcfh3aI9BpCiPa4T1ZJKYoTaf52uLSq2HtMQ0KvP0RNXVFcFZpYhZyTpV2nIMI24Z+3yKQ/IlF/wRZ2XFoTrGizA7H7UcGwxcW7bKeKfIZ5eEvgY+cGaxHyOEX+JYE3b7iUlzoL9kSuD3l+bSbzQ/3j1ERg2T5czPuMNx7W5f0bGgwx4O6jpB5cu640NXTSoWqYBgIuqWQX3YKzfMS3MPsP2teawVCBcHhAn8BQDX+s/OATzMgi1GodPCJsgc1nGhH9+EyJyznhE6K3wpq5EIgXL46IwNYqVlrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGNgz5NhBdbGp9k7dLt3a7VOlsNKipIAeQiaSN5OfjY=;
 b=tSQqhzu2ceDZULTPSspY2nT2UPkBdTnjG+tvjtSdVM/y6LnxZPw0ksKZy7jOtzlv/LW6+PgtOcGGEi1+6zvvyD8Q3W7BVMwCXpxvzmxvKabmB7eJqLJaGtNvrt2t/DE+vGuCpqEz6DPX8IZyaI5lcs1sYVL2JsIhs9DnqMmRmyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com (2603:1096:203:7e::13)
 by TYZPR02MB4527.apcprd02.prod.outlook.com (2603:1096:400:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Mon, 10 Oct
 2022 07:24:36 +0000
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::9908:e73b:e847:8033]) by HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::9908:e73b:e847:8033%7]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 07:24:35 +0000
From:   hongchengwen <hongchengwen@oppo.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhengding chen <chenzhengding@oppo.com>
Subject: [PATCH] cpufreq_times_record_transition() is not called when fast switch is enabled, leading /proc/[pid]/time_in_state to attribute all time on a cluster to a single frequency. To fix this, add a call to cpufreq_times_record_transition() in the fast switch path.
Date:   Mon, 10 Oct 2022 15:23:58 +0800
Message-Id: <1665386638-342822-1-git-send-email-hongchengwen@oppo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To HK0PR02MB3379.apcprd02.prod.outlook.com
 (2603:1096:203:7e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK0PR02MB3379:EE_|TYZPR02MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: da987c8e-548c-4031-d5f0-08daaa907bdd
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jnHkKp3LNPN8pwN4AlSGP4+ydTE8gceSCQwAVOxL6CGOEIZMkegL42b8DU+iciHVPU7rO73Ch5hwF2XtoPFG2Sa7p5tL4zWRlxcYp5TlgTK/ZwMet3OQTXsefiXvU9gN+ScS3/vOGOqm5T8ULCW+XVGBT3wwtZejyAnPlUhn3btHxUOz5rG6Xoyq7aMcjIhnQMAsYt5bOEC9j85vRpNhIiq07WZpE1JPY6hMkbk2FnsTrrt80Zofo+SBUmxf7d6kGltD0+9SGveuvb2j8ByRhdK9agvEBZAWZUWC4odfXJqDroXq5wygneMOnHeSXQvwSTmfLcrJA0xD8uIHFNllZIyW79dLdzKsENU5hOp88iz/96P0xWjVC/d6iQTFMevAsQsXRRgxNm3ly4WZF3yaVcHbrPT/2/VrWfwgbHd4ziChovxFq99ondq3aLC9Uo8cc3EAtFPcMLgEKFZyA1JC22Tzmqb043N+cZQWY3cv8m53mIYEiutoGM+rjrKnGJDUhV2VyYfKqFDqmc/Jx0OmbThN+h+7V5ksH14RTV6EaJw6W04lmfUg7o11OT5K384Q/6M2cejkbOXRCN8QF26SF5O0942hn7uiKtvpOVQaVWdOatgtDGQMFfYZCQtHAQgZfWiH50qHbe6zZT0aXS3H2KTmCqsMXk2qFV5Wx0blNKAMLWeeoVvs6JjAnZIWJW55CVkfeyJs1qoS5eY6wKy4QxGx4dHsRx6yQ156eRGjl8wp62NbbGxZhdXPaiqfcWm4szqlAIDW0OdLmj3eXFZhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB3379.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(4326008)(66946007)(52116002)(2616005)(316002)(2906002)(5660300002)(186003)(8676002)(107886003)(6666004)(6506007)(66476007)(36756003)(8936002)(83380400001)(66556008)(41300700001)(38350700002)(38100700002)(86362001)(26005)(6512007)(6486002)(478600001)(219693005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4CD46jSp0RtPu6aVRwwqX4JTQuYLz33l/QQ9Bqpi1cLbS8Nk3YCPRUjTWVD?=
 =?us-ascii?Q?Gv28VNsgLsLRw6nTWmXdDIo54tEu0tKg54uN05OMapuvzGqdhsCyagHnx+yt?=
 =?us-ascii?Q?Hwq6uye0hidoReTINbCXQu8fHnAMhE3knddrAzmkwzn/JLGg/7o0NJ3KemMV?=
 =?us-ascii?Q?9HB/KphCjhx67VtjeUGEYutuiFDoALz+fmoylrWcwkS9yBsmPpwkXskMA2Z2?=
 =?us-ascii?Q?nnNHntzaNgstN/udcMAm6tvuR7sX2H1pry/X6K5TLm4B72+Mczfh+RoaHftx?=
 =?us-ascii?Q?jRuKgiTecrI1AUyP52313lN5Pu73JKQEbTp8zUs0DklVZc2uq2JOaSxPTPbC?=
 =?us-ascii?Q?1wOF/MrQpz9BrB5p0kHeVsIWXSxupR4F+ZqI3U+1AqCQ3CCiyAHcwCyqgK/z?=
 =?us-ascii?Q?S+4k2BQBEO8n3346dDpB6rkbPGFZWlWNRgrMZBeSrUPGvih9N/E66cmfNYCd?=
 =?us-ascii?Q?CJFwIK9miYqmea0fxjVFhqEpPNLtz3DYx6o+rdDMrNsYWYXVpkl2ZiHJRbTg?=
 =?us-ascii?Q?QGPqo5CB7AdvTBTUqDbh1GOxvDLPjy1suOjHfUfuQNpVocseT8tCtRkdKcjP?=
 =?us-ascii?Q?dILJBqqp1Wso/V0knS+yPhWPrW0bmAM8SC9+Dvn8D22WwrqFNjwVgqQuLjQe?=
 =?us-ascii?Q?dH9Bx9UnkvBYOXmCVe+OVsrx9IiZcy9n0/uWqfC1y+YE1KFOltkHaWREFfbg?=
 =?us-ascii?Q?QaiSZLDX1kkj0FTmgXpZhtmqxsAIhNiKe8wKJZgtFkI4lurtBIrK33AYbdaX?=
 =?us-ascii?Q?Vq/Ni+8/adMcCjUtpH1JDW8oZjyvnuwUatGJ2eBECFTW9Ron5bC833WYX95+?=
 =?us-ascii?Q?YuvYc8NMwAo+KWKzZMIt5LhmJI4sAga+6HJ4hcc4fA3M/eGKxfOGBPjtCutY?=
 =?us-ascii?Q?P//IUCkHeGGAZBLq0r5v68P2JUNwLMZGaEWAxnsbVkDb3U79eWONln/awj+F?=
 =?us-ascii?Q?aXZarllhke8Pv2IMQ7oAsQxyPCyFEeUls2s1SZfd6ZrghFfvytBjejUUK7DI?=
 =?us-ascii?Q?djolX2KtfIlq42EY25rh+kNga8IHgHTYEgdYPpIpSx4NtbZ1cq6DDVfBozF6?=
 =?us-ascii?Q?VyJPGJFVhJiy7G3eE0/Eds92cEmY+ZZ/pmiOf7QFNRRPrLiOR/X4wh6L6kHr?=
 =?us-ascii?Q?O7z2HIYXT2EmPh5vDT/JiduduKx2UWoI6dvVRygNzWjCTtbIHrn9fqyVBRzf?=
 =?us-ascii?Q?L09oXXDTb5njEJFUkYE0fTY99DC9JpfwbkgPwdbWd7qJLompg3lJI5ns8Ww3?=
 =?us-ascii?Q?qdv8ZeF4CzkKHso2NjA4GwiE2zlLHvJ3qdf06YXsKt0HvoDRfzCSzh0W5mdt?=
 =?us-ascii?Q?VhaKhRf7zEjf+HlcGcpdn9kXpwc9KWwe65jHh+DIee0wHwNvOQQNAUrotNL4?=
 =?us-ascii?Q?Zb6A49sZZyEkY1Sue2t4BqMAIzvfptC7kii5MSrtNhBZFp8uZFDO1RI60MtD?=
 =?us-ascii?Q?btOpnpdkFreVqiRd3Hy+yoUacc9Vqdp8EhhRZFA+n59jCXxbVlqzKnyTjt+D?=
 =?us-ascii?Q?9z3s/EK0MQ8Fou1HGXJuGiYUqtD3+oYuYjW/8rkpKsow/wfoWWgqJOmntxPl?=
 =?us-ascii?Q?XPhSimoan+bPPFzNp3GIHTU0rAGVcKD/7qxxuEBnGKqEIazNh5huDDqRZJhF?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da987c8e-548c-4031-d5f0-08daaa907bdd
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 07:24:35.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLfjjAHh6g6iXfX4khWrZp9FRo8xO0IpYJ3yy6B516CXUR84TpZj75rpR+rraI86EIAhb1iZnRLDNosuxx/otQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB4527
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

Test: /proc/[pid]/time_in_state shows times for more than one freq per
cluster

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
