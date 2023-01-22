Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C856E67703A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAVPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjAVPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:38:41 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118A2222C8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeqB3jAldxj04N58MBZF2Kf9CqLUCBOykGrb+E+fVZ/+73DDFTMDPy9KbGlZz3Z8NdjrRNgU1CGUC1KBmstrxnCpxPWBkRJDqGE9wO75K0PxV/uMeYnkWj+0AAnDsXnS8R0OsVIETxBwX//NSxe8myqXEr3BPWeh5s3ejQ0Cdw3YuH8UA5VzCHVTBnrdiXC6saMpoAe3EnkDkZZzPbI4JdDtWrh/FCNikakBUjyhhAzdeOf/LGsRIHlFEMUjCxWqox+VX+J14im7myzFUBwtP40y5YTNgdd3l2yXD9HuECLePVuzlElTTeJPACsXDR6XbMVV4UqimO02CiJ49cLnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xU88Qgp8Gk9+VsEUbTvac4/6+o+e0MtIneaxHAfF3Zw=;
 b=OKQiWc0LQsiMXAj0SPgCfErghXY6WqX+mxa6fhOp+vy3NzBwYuANMnYC6SapQ+w5iIH3YFALYmX9fVjFyXeGORInB5VY+Fbvk2x+po0hlj8hgb7+8cqgGAvYgnsQc5DvyQNMbtyTZ1DytZoIzzxXWNT18txPUG2X4hlBJ48ie59c4XKsPKM+HjtDqSEGdH/UdRvTHORSAsP3cJZwCIm9raIcbrf/i29ed/hH4ZoFF1VTSJRble443DsPcAE2Z6twBcom2DoWbPoXKMk7MjxjNCeNuYxkJSYkUpRJkDz6xZL0f0InAV3/5ZUlK5FxFpGbk9Yewj0Duc40NQBqk0jFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU88Qgp8Gk9+VsEUbTvac4/6+o+e0MtIneaxHAfF3Zw=;
 b=VAzvjA5oPAKbiXYuDB0q5c7PrH5ieBp+cgmd/ImaXhjRChp5DoIPzXV+vDJZd38Zccelozl9C2qwswkU1mVehEphLkGCaVzMEDvYml8rA5FxsAfyjIu03qGGpUHJjSTomaxvOapODEg/DxaYJR5Sfxa708HLH5BoYPDGRAYcgkCbNsFW7uS9LTPGQif/ErGTUS9jsF9vrwsBzqjV6/GsWY8zEORgOLWHcNKjxz3mwp0fr6XVkKczYTG/Y921q1D7wRyuDWh0zRyqFpWmFdRNUn8jBq9sWtL6W2qA0k0Zs2owWtwFGVcAxoqb41HXB94eWgymN43mftj6YU4I6R73jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4297.apcprd06.prod.outlook.com (2603:1096:4:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.9; Sun, 22 Jan
 2023 15:38:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6043.009; Sun, 22 Jan 2023
 15:38:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, terrelln@fb.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: f2fs: add F2FS_IOC_SET_COMPRESS_OPTION_V2 ioctl
Date:   Sun, 22 Jan 2023 23:38:26 +0800
Message-Id: <20230122153826.70865-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230122150049.66607-1-frank.li@vivo.com>
References: <20230122150049.66607-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: cc620f0f-c944-492f-31a0-08dafc8eb997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7X9apMKXbMUvNq1afAS8h0llHWfiVdYmY+xdpzaaZ1APazBgWoRY4BmAkCl7afGmQ6+KyvXzVUXh9A+4+/LaP3aM6POtthB5acYlUc2aKP5Tr6BUOssNcTBbDlmUNR12nopQtZy7ILvWfKofsbLq4uAJ0XPwOHb7/HuzzfBN1vN/qfUzXSq613cHoAfo/BEqOL3nx3fBoRc2wv4H7pVzcnzVPUAUzTJIuMShL9JNqryONimsn/IMIFUFfukr8K7fMNG8aL5AHmADWKiMgoQBjYJ7CY43PPRSwUfkLp/K3H2kvS+7Kv0Q4neI9bxiTpSdO/ifDjgIwr7DsUeZUb7PNjrJ5QKUvNwLDoIxiS6rrBbCxURO9zhzaXipo3B3kegQiYyCo7s0Jci41GWlHrW2EoIHqUVsUCgwJXM7gDiyyghMIMbw+/Alu8y0zizz1pYm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(451199015)(38100700002)(38350700002)(558084003)(86362001)(8936002)(6486002)(66476007)(4326008)(66556008)(8676002)(2906002)(66946007)(6666004)(41300700001)(2616005)(1076003)(6506007)(186003)(26005)(6512007)(316002)(52116002)(478600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j7b5wa7jt9lQroeEmE1d6QGAMb/7VzoQ7MwFQcesZFFTjdLetwKcZH3nCjXK?=
 =?us-ascii?Q?kvmSTmd47aQ+dOAauYHXDrOClbU7S0r4f++1dVSNofUgC4BkEPlj8aLR9DZb?=
 =?us-ascii?Q?bywFAuqBgj9BTw2EAotg1Sahk5QkUnvh01ZunNZg6wF4uJT0SivnFqMjUcjj?=
 =?us-ascii?Q?BJSrlPjoII3DeU8txyZFVlR8UiNzOlwJ3Pn3FECfGvpieIr8agXQlUEHllNv?=
 =?us-ascii?Q?HVKlvr7ofIkleSEM5E84HwlQs9AwSXQRIjf8uSZIEinsqqWM3FD5JP/FFujr?=
 =?us-ascii?Q?b4jarX2nQ6kPqB3o7qSiJQFWOS4KXItnqeY4uG66CPYAx83aBC/nyoH6ZXUu?=
 =?us-ascii?Q?01FO7HI8gygOpO89tE2vwZFH9ZTgs1o/nSKwmHAycKzneglKNn7i43Va26jK?=
 =?us-ascii?Q?sr7psOF8+UFVYtSwm32ZzHd6hk7/3I+taUUYyg8gukvhBaBE4PtVCI1kbHWv?=
 =?us-ascii?Q?Kuy8PvccrU1X33NZFinA+hSgkkR94jAk6xclFjxVCQApERTq9BOUtm0776FX?=
 =?us-ascii?Q?paj2zCrr+/w5VDck8QoeAqx/UsPqC5cnvORA9THM3zfLsYhDnGJRTH9ljMS1?=
 =?us-ascii?Q?SDFZGrODDuYytBgG2HO7OveIn7gbc+IvPhPe6/pj739p9ARd9faGUEXZBZf4?=
 =?us-ascii?Q?xJjT2dz5MWrkPIAIkg+03c9txkPHykz4Rp8YDUyP3Pfivo/DYliqfzRrZloK?=
 =?us-ascii?Q?JvAYYoJtOiFHs0NL9S2flSdPihEvTTwfnQKHQxW8b2VCARLeb16NROHmU/Uh?=
 =?us-ascii?Q?uFlni09jnA/sfqcQrRQqOCzxFZulvSLMFd+W/0XtA28StNpt4fzh8B9fkEJH?=
 =?us-ascii?Q?yfIE+cbphlZ1Qk0MHFvTt4ugIx/oI+WY1NGw8LrHbEQfmHfjqqRkwFGJ5TPJ?=
 =?us-ascii?Q?2cXVMOB11cdaRp7A9y/wRjkpJB7Ez11Wrnr4vHTOqygyA5MhCMvN0JmMMPkT?=
 =?us-ascii?Q?us0CwYYfjJSrkQP/AeI8ah1bTANrVapt5pxvvLA+1+YD0JXc3wtnSQExiesK?=
 =?us-ascii?Q?EHkBndiTTiCYnEZM4BMoU50J9rNaNxS9DVceLto1TzbNi03UXE9Ij0QcA4LC?=
 =?us-ascii?Q?lFYLOBLpjqQPSJmYtz47RXe+I+iOWBoiuJHlt+Ljuzw+xC3zT+GsRZAoDBep?=
 =?us-ascii?Q?tGtOnT5TmkfOTe7UoOQIRMJKOyFIK7eHO+mqoPVTvfIwE2bZMjNuRlVl8A6e?=
 =?us-ascii?Q?LWviUHrMnqkxXVZMGx1Fm2qMEzVOFDyKVBDfPFydwmmCiJ4fdIt8NyUb2/JF?=
 =?us-ascii?Q?jJzFdRGDMOP7x4NPlisIdb3L6zYQX5/SMsSpzkvYIvIuP2wUH/3oOlBqSBTD?=
 =?us-ascii?Q?otIecaEyctAaf9UqgMBshHufZyBP6W6YqsoSwzlezQFWkouwn9aQU2v7RHa7?=
 =?us-ascii?Q?yyRh035/9IB4aznLtUyF32I2xI5Vj0dRBVKkzj6zjQyWx5myc7MtCkCEKgN0?=
 =?us-ascii?Q?5UXHjDqqjgX1Nd5NsSDRiN2CDoup2vkkkLisa79bhl8Ed2Tojr048OAwiwxT?=
 =?us-ascii?Q?OUpBy7tarkqhQHNcNbRz+JCCcnItQnnCyoqOQZcwoIaCyN1fxwVLPUE+yjlJ?=
 =?us-ascii?Q?QUzF6IeG/FSLiFqfBBzi838xdlRjqdOgoRLozOAZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc620f0f-c944-492f-31a0-08dafc8eb997
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 15:38:35.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTeY29N4U6R47g0bXDubUQ8u4iO7FDxU+vkMH7Pta8nyd6BurZDbTTXgJyLWXfLt711PhyGEciWnmfDQyVtBQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Nick Terrell
