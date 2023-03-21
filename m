Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10176C2A57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCUGUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCUGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:20:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2031.outbound.protection.outlook.com [40.92.98.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401F39CF1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhpszWttysbMCSZP+SoIPBzMWwuerZBLZomB7P+qZoJh904gU/8U/RB41XIumTy+gRb6LOAgYXhkoImYkQtRjEmSiiil+EzBehLORSxA5V1hQ3XpE+dCB7C/KFzrMEDPWfFmv7uOJSS63kaH2Oo8Pae5uFv8E9oDTg3LzQVTC4fkDBUGaweIOAOZxcTzra1eRRwyrVYaopb7CXeHHHQEwk3ksK9Sj6KrlHgCfCcRPo2mn2v6pMTM03Aj/2Wtvbmkml4mXbBvErbB3CsnQ+QzHjhNqEEmV66Te6RKh3CSgfR7Vd5TKjUJmPskjbaS57LHRbRUE/ybRijgS+VuQ15JfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySe1l8LXiaTaDIJtc/Qn0KhLh3ppIoXqK1CcER35mGM=;
 b=VUJ5fug4jhiei26A5RHgVVVE82MLi7cWwab4T7x9eEoCTRtAV30LIcjmekplMLp0UoTW8O5kX1bepJ5u8kg+q6dDB9zUm3LYt1HDkmFLIiErv0vqLHv1PcQfE78I17J2BKRnBHYl1VDqLRTEPxmRkb7RP5sizv7w2f78aSTYwcwf22Wb5z7vGfDdznIuw6fbNxmr4sijpa95CvhZTageiiEQO3C/CsF4Y5kxRrOYAlLaaD79crq+mXD/Xc+WO6K2ipex2njhn8ZCLQzX4p4mqxoRiTSh2l+FJWy590jTx+vbq0wSAPK1vosgh4oWxHC21fijTV/baM0GIZFziiQK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySe1l8LXiaTaDIJtc/Qn0KhLh3ppIoXqK1CcER35mGM=;
 b=GFc6qJOhTzqgqbX4Glav07WhzS1/8OsJeR4iHBUfsfEn9T/WDSpcP9KLebR7E02ZNBv5PGZRB9rbACKw/5cgE71VmtRCAsYOvXJMym9XIF6zFr0yQMlIxU2XnZFpSF8nPXKgBiuifkv9MXxdwhh14d6nA2kIdMGJLcoMcWqZIbaQ37DLfNBOGl6R7IJLePU64KIot4CYgXftkvhW/pYOZbdWTJ9p/ag730MN5ziZ2Op0mBH/Uha9n+OZAFMfNBGQbeF4IDC0wGuany/AlNiHWIwkk9us5txGRtOwnq49aUcqiWTzAd4zOaB1C2tXmc525Qz6m4t/6KvQoLUVtFfBNQ==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TY1P286MB3348.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 06:20:07 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3682:6425:a009:405f]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3682:6425:a009:405f%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 06:20:07 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com
Subject: [PATCH 3/3] scripts/gdb: fix lx-timerlist for HRTIMER_MAX_CLOCK_BASES printing
Date:   Tue, 21 Mar 2023 14:20:04 +0800
Message-ID: <TYCP286MB214640FF0E7F04AC3926A39EC6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [98Tcgg0RWXbZgzGa2mx1HhoZhcSqTbgZ]
X-ClientProxiedBy: TYCP286CA0174.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::15) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20230321062004.4574-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TY1P286MB3348:EE_
X-MS-Office365-Filtering-Correlation-Id: ae62aeb0-d682-40c2-a08d-08db29d4512d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaOd8WLCbeO8DQ0gHQDmQQsBZyFuKgLdozeJZtNrGOi3Ws+PL+HglDbhjrK8AHS3nBgEFuZcoJdlDZ8UoOvko6jvcV2wC1ARSu0LBYstPKNFmu65cJFj+pMvpFvfgBomo/E0/8eMvjVbUTGTPHaKDLR876Wt7KQzF+Ub3R1r1EyniFVDd7BwcNF9HsA5+3iFwltBSjUmunVMFzXQmJep2fs0odBCEq2R61wIsRi9rbScyAqeSnBGrCofkNBE3acoaezuroKRv31KAgZgraRyczBwYJi7A8i5xOOKAhBzl9P/o6xJ4+XAHmZpFMricm18JnaHGlElq5pZVaOTzB9FZ9BWvU05ZCdTFAz4ZgiV63O5MaWe3QDdVoIhSifu0IRePxDzfC8OptrXBxRJRDnvKZn2GG2Ir+y9RHZso8gQanzDBAcbcuKBKk6/RwuDmQN+M5NEUzKZXVjqA5UvvX/BKP3i2zcZfBL5JtizUxtKKqpXNo575i8Zin6YUFIXO7WfW+qv6ivYGzaKRSRYZ3/gPu8fGABwLPHkUQqq1j6p6Ec+qndeL4OZm2q4b3W2BpZvxqWI/7GV5ttOVexoytBJ7Ggp+Uot4TY9jMtpqKALtus=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?50qWtAWUU8OE4ktXPQu4atOW0Aaktj7bqH9Tmu6XVCgFeTlnQf/wTgVH0BWP?=
 =?us-ascii?Q?XQRVgkqPmaWKZxyr0SAZb0itHtgVQnMVggI6eT7guJ+P4ovj8VWEH8Qux9aO?=
 =?us-ascii?Q?gLUuH0Dtw1Hh4gM0XoSCTAWc5VMWuDmvyagDWINf0ZaDqxXhtxnMCyvIc0wM?=
 =?us-ascii?Q?KfEYvdkfxvwkLvHiIWIst9TaDf0bByVQ2PUsfVYZsHTD61H2DvZNNunzRwgF?=
 =?us-ascii?Q?CoXa2PQL81atXPuc1c4irGVHDavY3/uiQFUlgkYb6jdpZdaJYVMFfCAcc5j6?=
 =?us-ascii?Q?y6F9/z4fTbJehxreXdTThGBnrHtMkcwHLcEfeB2VSspZ2zk7T1NO8/SmYdhy?=
 =?us-ascii?Q?q3T0iClNsWvmq27pwRT7P/l+Dq1r2CfMWgcsGXNT1/Vr8JmICLv1WjovMiIm?=
 =?us-ascii?Q?9pbc+BLeo1k2QDUWjFH+mcdgutk+No/rkncyopoG2nr2bLiKZOP/X4YXjMNv?=
 =?us-ascii?Q?ALDEuNJxzP0Z7DxeJmFC/tul7H7qFN/6ONOzKw5SXnoGWUzklFCOZMxExPG5?=
 =?us-ascii?Q?1+8mwrUMudxRGpz8lg5Mq802rT16NRvhZGxOkKuQ5KqM/xE5rJ3aeegbPWWs?=
 =?us-ascii?Q?/kUGUJU3dN72MhU45Pj2qs79Zhu1ZH6P1uhsk/I9QThlxel48QicXpLaytVE?=
 =?us-ascii?Q?bL+M/Mz4IxZVJpKnLk6gsFmb6+o+qEp84kVIXa8tV+6+W8KMUyl/92hzL0tC?=
 =?us-ascii?Q?j2XKbn49CeseQDJGtTgDlCGhEnSTYXnrO0JiOnSTGnphD0WTZ6fQJ593hObA?=
 =?us-ascii?Q?W7YaVr3MfONkTUVwCbHCPBtmujCwu/AAoA6qoZM1e6fO383fpIMQG7Wi+cmb?=
 =?us-ascii?Q?jUzBkmJr2ssODjiUm6EbxJZR+fAxbUdPBvZvMxWpUqwKcVRmme38JLNtWf9j?=
 =?us-ascii?Q?29Osw/ZLiwvHOKVkU99m1H7QC6qSH1Rg2kGra+R1Hl2LDFIw+mOCeN9MbaM0?=
 =?us-ascii?Q?dJwmuF+fmBkoZVaw09YyOFNI/cy52IhZC41zpZaCMYJots8A3RwuWLIm0Sp7?=
 =?us-ascii?Q?8RO68T7ZEA3ETtKa7GAshE5NWKBVsi/GSPfwg0gI7DKo/BHRLvFDnPINPWLK?=
 =?us-ascii?Q?/JR6XP2/RWXQmNnzF0UwtjUpJ6tvdBnFvqDsWyyY714D2vUfbX1P/6N41GND?=
 =?us-ascii?Q?Vktt/9ubNHgLsr83Ra384qCmUtc/75PXwPGDyEvyeda75a5ei+t8iUk3pbSg?=
 =?us-ascii?Q?Svioa75GNV7e8ND/QsLofF2r7kHwFHqhS2LQcviCjUCbq8OLeMpJCi1O+9th?=
 =?us-ascii?Q?Wxw3csTE4ZaPBGEP/RGg?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae62aeb0-d682-40c2-a08d-08db29d4512d
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 06:20:07.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

HRTIMER_MAX_CLOCK_BASES is of enum type hrtimer_base_type. To print
it as an integer, HRTIMER_MAX_CLOCK_BASES should be converted first.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/timerlist.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 8281da068c5b..249f0e804b24 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -188,7 +188,8 @@ class LxTimerList(gdb.Command):
         max_clock_bases = gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
 
         text = "Timer List Version: gdb scripts\n"
-        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
+        text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(
+            max_clock_bases.type.fields()[max_clock_bases].enumval)
         text += "now at {} nsecs\n".format(ktime_get())
 
         for cpu in cpus.each_online_cpu():
-- 
2.34.1

