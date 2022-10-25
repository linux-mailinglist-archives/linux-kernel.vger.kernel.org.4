Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240D60C464
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJYG5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiJYG5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:57:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2049.outbound.protection.outlook.com [40.107.117.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17073C00
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhp+HIsybUGxFcJRh4PkKPb2aLHdApDX9eKvsvnukip8xOlBjhsGsh9iPsoIyBNa3B/xOu6lnNHigL+y5EO6+bBH7raHrHFeT3kUlVOR3AbkybFsZJVroHEDsJx6fCNA7mcBRZ1hd+08Uvr8M/xg2/gtGfcMRyJnt9r8SnuyhJcxTTn6yGPn6X+6vte7P7bxcUgTEpR5Pe878/YVTP8bJ1kXZg05E3b4JOFvvDmD19Nw0e8uawQDwqb440VHMZa1UYOUbhRK60jplQrOpI8AbvMvRaMJSrfW9Sz04c5ljOBA5Pgby4ZhBtXWh+8J7gGHpCn2jYdjKUeTmK+e9OsIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QBoIcBV0ym/ZW3SRDwZrRx/PJPD6EmYXQ8snYK9Wzg=;
 b=As4DQIy/+/KDmQd4Arkc7KT4iHYMXHeZGZ4RY2PJsUhUyjq5dvEL96idNIcfAPDTIzzjQw/78t7LSF7C//e2KzxCuLLsb/1G+MTN6PHLN3d5b9AH2uV9LCaILsy5oTOzwBlzqm+SOe1PiF+a3RtyzIsvSZORyxHxUTxkWjvqyYnwlvTFV5WJDpr435YFIaQ+pNxMpE2oIxk++7DWU5JOFuZ6hKlbqk1T3ClTNbMEiUVUMW5z+ePDCMhCfeGO4/EwyYBUck7pLLKVkfXBrVlHfRHbYCjc0OzkRxLAbMJ4Y6mZrgZr8P9I+qAwF3ai1Rdbg2W25/r7aD2Lrfl4qgho7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QBoIcBV0ym/ZW3SRDwZrRx/PJPD6EmYXQ8snYK9Wzg=;
 b=QbN0ZjMuADQPBOQbSsMdqk877cps8oBCjeXc/rB2+piLHJ280eoQ2sMwjFw8kINFWGd3JkHJBDFz3d7qcwcAW4RZ85t7sM3r49gA1yHPhfj+qzYGKApi6WE+hPCGU8clRomsTmCGaFW30j42iwUpmnSv4rMCVMjEBkURs5Qs3eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5129.apcprd02.prod.outlook.com (2603:1096:4:15e::10)
 by TYZPR02MB5246.apcprd02.prod.outlook.com (2603:1096:400:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 06:56:45 +0000
Received: from SI2PR02MB5129.apcprd02.prod.outlook.com
 ([fe80::711d:e5bb:1951:139e]) by SI2PR02MB5129.apcprd02.prod.outlook.com
 ([fe80::711d:e5bb:1951:139e%9]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 06:56:45 +0000
From:   zhangdongdong <zhangdongdong1@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        zhangdongdong <zhangdongdong1@oppo.com>
Subject: [PATCH] f2fs: fix normal discard process
Date:   Tue, 25 Oct 2022 14:56:22 +0800
Message-Id: <1666680982-372975-1-git-send-email-zhangdongdong1@oppo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To SI2PR02MB5129.apcprd02.prod.outlook.com
 (2603:1096:4:15e::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5129:EE_|TYZPR02MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 574f92fb-43ad-4e6c-0d5b-08dab656144c
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rD4XS5nWLW/SogifjPRUzm6+l+BilPdc14FhVInkUtu/n9AfYCP0zupc0dJDoxDCIAoHwJBR8x+iCDj+KAtQMqMZQKqjSBL9nEiODzM0ls+vhNV8E1uDTS378bQm89zmdR+BH225GdASLmRbNEgla3wGPpMmEcxNuynjfZvPjAsvpcmfoFEIZS1boQwEepXMA4ttB9tw37dXjchz98y3JnKT+zWFEy9WYQQlbNA/LqsyH4Th3oPocRPBDYJu7hZpJJz3NzxNp4sCmlesNtU8ePb/UFu1HlmacXW56QptLoQVRQ5P30fCpe8dqHCORm7DoR/hZGjmkX3Ixa+/xkynmEwiFRPkRORxifb+zGDY8NqgUvlPgEylu2PT/+SeaJtU1u/R7Q8RUg54sG1beWs3gdwpzYnB8deO7NwUhvZf6lUmpeGfHIOg0G21Kf9TMn/66vIBS2sfRAoesVN8B09LxpFYl0RS5PgM+QZwFGz3X6pxYdhQL43IiPVnAtd0pLcEz4qmIP1V8v6Q5ww8Nn4FF0o8fC5jedJFP0HJ/ohZSMJUTBw3zzEhn2Wug5fWQvToduhAA0yb+kP3BBBpVlxaR5Fb3VTkMOFnuq2rT6pr4UBCK6gMm+COTAqGfEf2B9sWUAsJeNU0F0jm09B7k1BYJNhoA8C1dFiAMq+kkT2Sshhf421PgV3xXNYJiMY7fAS+D9bBEJJvAkcm54vUsDO9fq9wLkCNsj/5gLZofN897dR7LbYOGqLnaEKs7T1U8YhxbbIfUYem/LQa14VwBvsCbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5129.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(38350700002)(86362001)(38100700002)(316002)(2906002)(8676002)(6506007)(5660300002)(8936002)(66946007)(66556008)(66476007)(4326008)(41300700001)(83380400001)(2616005)(186003)(52116002)(6666004)(107886003)(478600001)(6486002)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NhNTh2UmR3bGJGOXpwUDBXVDhmSEkwK1Y3bk9OME1EK29lK1A2OEZFM09Q?=
 =?utf-8?B?alpRSVV5MUNqT3U4STd2VGgxNnIwa1FLSE9sWkEvOEN0eTlLM3RWYU81TEQ2?=
 =?utf-8?B?UUp5RnBhVlcrM1RTNVdiS2t0RCt2Y002YmRPYnFidm5BeVNnanVPK3ZiRm1R?=
 =?utf-8?B?UzFmT0cxa3NianVyVVBYSks4Yko0THpnYkF5dXdhZlh2bk5ySGEzSUpuclg4?=
 =?utf-8?B?U3B5NS9xNjdJVjMzOUtTTmUySXNYSEwrNVJ2dXhhSnh2ZEIwUXR3NUhQWWVx?=
 =?utf-8?B?Z29Qak5qd3MyeFZvSC9DTUJxVnB2VGgvYU9rdVBqWFVXOGJyR2VIODFOQ0N2?=
 =?utf-8?B?S1RvSGYyeTQwWFM1K3Vqa2QrZUhpRUc3UWEzK0FVNVFDVTVQbmYrWGI0clk4?=
 =?utf-8?B?ZElYVVI4WUVsMkd6Zkp2bnpaMkVlV1VRbzBKWEZkZjliMFo5WVZ0Z3ZBa09S?=
 =?utf-8?B?a2Q3US9mZjR0UDk1TW1BOU1xRW0zcUVPcGk1TnhjMzVMR0tPMGlEU2lqUndG?=
 =?utf-8?B?Ykd4ZDY2Mms0Ym0vUjlBSlJmQjlnSmtYbGh2UXh2RmNQSE1SU2F3TzhnUTZE?=
 =?utf-8?B?N3haTHNaWU5ySXhFVk41b21kenBDVGR2MmVFc0UzRkVLOVZCZ3dxRDE2blg0?=
 =?utf-8?B?NHVRQmhNYXpLKzBBYkRsQnJmWVpnVG9pLzJuNEppbERYQzVvaEZNck5mbkNh?=
 =?utf-8?B?b3NXSGlpbk15M3BGSmVnT2c0TWVZakxrVUlOQUVZRGZFMzZ1Q0dkK1V4S05D?=
 =?utf-8?B?TnRYMWVCVU5uVDhZdVhuTEhVYThtVEsxUEJJdVdvN1d1T01WMi9hdXBhWnc3?=
 =?utf-8?B?WWlIeWlpWk5qVW5CNVR6aDhpeEg0SXgyb1RaRFBSU3Z5UWtFWGhrWWw3c0w1?=
 =?utf-8?B?T0VnQUQ3cDMxQ0crbStOODhVVDc3R2xTZTZ5dGFXSGQ0cnpkcWUrMSt4b1JX?=
 =?utf-8?B?cHNCbDgyMWhQc2pWWFEyL0J3V01qbWhRSml6WVU5UkZBeVlUN203OWZRTUI5?=
 =?utf-8?B?aEdqNnF0OHQveU42WTk2blRHb0hMNFI5U1lpanQwL0NUTmpCYzc3V0RRTG9s?=
 =?utf-8?B?L0EzL3dYbHB1ZGdsSGlPU0gxWVNzNk52RW1WSE43Ky9YN01oWFIzUWFhZ3NS?=
 =?utf-8?B?cFN5WFhxRVJ4bHByTTNNSUozTURVUUIxWTVLRjY4clRROThrTEZDNTlVazUz?=
 =?utf-8?B?OG40ejJsUzMwaFl5Qm84OW1DaE5KNExSTFdpcGRpUmtNUlFhSzZxR0htNHRj?=
 =?utf-8?B?cTk3b2gxcGdEb21HR2FhcG1MZ1dCZkNRVjlXaG83UTd3SEx4ZkZhanVES2pj?=
 =?utf-8?B?Tjdpc0V3RW5tN0JOTWtub05KYjF1a2w2cFp0SVFtWUszOXkwUlVrK0tIMHBo?=
 =?utf-8?B?N1cvekxmcXVLcXM1UEhjNUhxT0lyR0FBOGY2MEhjdHA4TlZMVWlqMDF2MFZJ?=
 =?utf-8?B?dWxUdHF1bjBZT2tjdHJFZDhoWU9UTzlxa1o0L2pHQjZCR3RMNHJXUmw3VU1m?=
 =?utf-8?B?R0IzejJOZE9IWnZpcEx1d3hoN1IvMTNVRnI2aHV6cDlSMWJ1VzYrSDFHT2xE?=
 =?utf-8?B?blV3VXZqcHhzcDQzRDVYbXFnQ1RzSjdpQ2FBMFlET0pwNWY0TldDai9IWng1?=
 =?utf-8?B?TGdNalBLUWVpejZNSnFxM1FSeERTSVNRMnFJN3ZuTFB5dVBpdkx6SnZ3TXFO?=
 =?utf-8?B?ZnVXREJGLzRQSzV1cy9KalE3anl0M001eXRNbmZpa2xLTzZydzhicVRGWGQ5?=
 =?utf-8?B?ckd0QmN0TlV2dU1nSXR1dVdJeFpKSUJyOGQyRmNZb2t6S0lYYVpralBBMTFq?=
 =?utf-8?B?WmRod3BUUE9MaDVucCtSRXorVXhFL2xnaDVHSWdjV00ySlE2THdsRlg2ODFa?=
 =?utf-8?B?ZWpqYk5GZHcxc1UvOU1GOVNmYmpuSlNpOHBHR3BUeFVVZnljcDliem9ybGNt?=
 =?utf-8?B?dFR4RjBzeVlmbHFwRjY3UWZwaHU4bVRRK2lNclRXQUxBNW5Id29WRjd2bERO?=
 =?utf-8?B?QjUyNUxMSjBlc2NYN0d2a0JMT1RRb3A3NW1CYS9RRUZ0RGoxNmpycDRpZ3kx?=
 =?utf-8?B?cUxZQklNMkNibEJMeVFJQlo2NW5jV0U0OXFvWXBUdVBJS2NIcldVd3B6VXJ0?=
 =?utf-8?B?Q1dmZnZsUGsyaS9PYmhJZlA2cjN2R1phT0c3OG5odnhWQUxJWHQ5VWN6dzJv?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574f92fb-43ad-4e6c-0d5b-08dab656144c
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5129.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:56:45.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysgjGMmeF3CEq0mCeCH5E4x6e6DOhqhrMe1jSGU5RDkEzqrS0sBzscIJffbD8g2P3eemqcsI2vMHmf0cOZMVUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5246
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in the DPOLICY_BG mode,
i + 1 < dpolicy->granularity and i < DEFAULT_DISCARD_GRANULARITY conflict.
if i =3D 15,The first condition is not met, it will directly enter the
second condition and dispatch all small granularity discards.
The restrictive effect of the first condition will be invalidated.

Fixes: <20ee438232> ("f2fs: issue small discard by LBA order")
Signed-off-by: zhangdongdong <zhangdongdong1@oppo.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3f..2fcb140 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1448,7 +1448,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *s=
bi,
                if (i + 1 < dpolicy->granularity)
                        break;

-               if (i < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
+               if (i + 1 < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered=
)
                        return __issue_discard_cmd_orderly(sbi, dpolicy);

                pend_list =3D &dcc->pend_list[i];
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
