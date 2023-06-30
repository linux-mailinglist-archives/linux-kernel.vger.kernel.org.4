Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095D3743CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjF3N11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjF3N1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:27:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2105.outbound.protection.outlook.com [40.107.93.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA413583;
        Fri, 30 Jun 2023 06:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRdIn69zEPAWgbj/EeZfW1m2FZoCoYZX/UKnCk7vc66iAykjCMzmB7e5GivUDsF8cNlz7G+0geYpGMjJchlE/Va1RV2dHbfS8JSoY7fwxuOYGEfl3rvkwZRrfntlyYGxaneYDmpsOD+R1812PBGwiT/d1fhIZPkzRN4pe7BjwMoW+1HSvLXDfbBFqgzr5OxFI9O7WODugcQC/cf24s6s2aqgh6pT/uMyyVEMXcYW7aG110eDT0oMTcL82HsdrB/HMKdJIsFN49tndy3WwmSpN+B9oO5c+reGCsLqaHipHTAtUScPjaaw2XFwymd+LGhtEwnvr3YhhN5RFC9eEYpfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1bZjNipFXggOQZXW63z5zQBr/zHvyZHyyDtl9csP7E=;
 b=faX2WYhIvhW9maS3HAmjEdni+uRgJjNZXg5eSS6jeMrAoBtudnjU3nUlkHajbeVX+K281cIfC978bUTBJI/4S0R4CGWkYzp51WIWAlSI5jOXYJ8n9cgge+wvDv8g8cZKyKZVdo1imYvUGgfyObRB4vGTPJQnp09w4OhrQlKyvtqbV9kiXnRBklm4yUSr3Z3Nb3eSHWR8re4CYfbT2XIQiWNI5peo/Lkygqsb+QJXnzDy7WPTpVaGnIN5+rpB2GMCwEPq0tDjxqBsyUXCvhJrGLJjQLzMGdG0/wK0hexSy3yvytTqmEK4pxYSeQC6yrydXHUGuO6OOQusomD/9UXBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1bZjNipFXggOQZXW63z5zQBr/zHvyZHyyDtl9csP7E=;
 b=cPcDNXSHpqlYd6Tpvr/7xbClXj/o1L1MSR9e36sSBtotT9gpji0kbcJAq5h4YzhcWdg2RhTI0gAKY43mW+UOtXcjulXeHBdaz2ImY+uIBLkgJF97urj/CWKTHVyf/hZtV940WxG2A4GZFpjAweEVcE1q8MrJhBpgEkvDP0e97hU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB4527.namprd13.prod.outlook.com (2603:10b6:5:1ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:27:17 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:27:17 +0000
Date:   Fri, 30 Jun 2023 15:27:10 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, sgoutham@marvell.com, lcherian@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, sbhatta@marvell.com
Subject: Re: [net Patch 2/4] octeontx2-af: Fix mapping for NIX block from CGX
 connection
Message-ID: <ZJ7YLmRbWBPEFmj1@corigine.com>
References: <20230630062845.26606-1-hkelam@marvell.com>
 <20230630062845.26606-3-hkelam@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630062845.26606-3-hkelam@marvell.com>
X-ClientProxiedBy: AS4P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a046d98-62c5-4a04-4e1d-08db796db98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6q72snrtxgSyZNGp/xV/r94kXRFUU0IsZDsofzPDXzW7r0vawDxthp3cEmWPd4kURepR3yqMaNXCKHqlUEZvkVL6SgGGAZqDVjuAjS2bgCvarP865MxA41iUMasXgK5Ql9my//bUE8ObCLGKLfvKyGBHGIwAsBt4HN+p1cvihZ3Kb/WyrXGdpmEGaEV+oEjysxRen1Eh37QcDOJOXM4S8HDVvgyhyOj22TT1+/PPAENb63hAxMsHSCylfZIzP6bW+n/Rdq76EslWY9TdeW6PIa7Kx4QHa9rRWUR18vmCk1YxCg0j/n6+oz+ytWbqImcua9gSTy56l2Koaw5tj9mHgHo4rGZV/1sxPyE0WwuutCY3oO2DI4E0eN8ZBA1mGY1LS6c5vojiy5MaM+ztl46ZpaLQLWLbuUap/3mnWr6UqsxWJvdWTmntK+g1zcA+RF66QlS42CkRamTh2CilqL3goJi6eCQ+vECl9MmRfXcybCZN9JuW8SIxMjnyYkV4a2Z7lUtLFna2nfdjsfxy0sTXjfHvQno0o73VThZIJlNcZFPcZ7H1hoqlGiVLIs/4xpxpEdweRk9mkv9MhmAQIvgJROcAv9eP8d6+nyO7pC2p6D0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(366004)(346002)(376002)(396003)(451199021)(83380400001)(2616005)(2906002)(4744005)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(6512007)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(6666004)(316002)(6486002)(478600001)(186003)(44832011)(6506007)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yTV+Uc+wrOXNGqjQfXu68DZslOVCU9pyqioAI1cKnggYCvp5rHiUwZl4NkMG?=
 =?us-ascii?Q?wmxJpYWcZo2ZN/GXJzjJswHQ+uFm5PTlZiktsbZrBp376YesNaEnBmEnbBl5?=
 =?us-ascii?Q?12HpsquaVEL1P+yv7xcC9IBwMKLasDhRihRAWXMGo0C2z7XtLipcJxvqKtue?=
 =?us-ascii?Q?utJcrIXdp4o8uPesrT4ygYJpA+KW4TuRRFmxPxw9O3imIXWH+nx3J6NAvq/X?=
 =?us-ascii?Q?rlxCy5sRHM1Tq4nighYpgKBmFn4obBoyKiixsNka/97qITNA/xaznKq4xwUZ?=
 =?us-ascii?Q?iHuinXHksZ5g03PWu2cetSXse4CcnLB/2mF1jg46DTEsQK8DHs+9W3NJwZAx?=
 =?us-ascii?Q?/1A0aVoSvlwiGvR322+MnV2eyC9L8qR20DY/jGxKULNm1/8WX2sG66UotgLy?=
 =?us-ascii?Q?z/M130eGvu2lHoD8F/pfp0chXPuOXtCLfxf1Ty23ikacGzhBg1vgHtpdUjjo?=
 =?us-ascii?Q?LIOiIIotsd1KYotVMIUP8hLYc1cq2R8Y0QXhRF8NKBGr38jUk5xwDM7edEAJ?=
 =?us-ascii?Q?jeTfUxf8Wluz1LxV+NceLATcELGnlQa+H5v9LXhc3CROiDTcLzEkFYhBmB+C?=
 =?us-ascii?Q?M7EeLnwrRAd8T8dLkWj6xUwbfxmoa/p+nq1p4qFTCONZ/vsQ+A1lJ/5t5qqH?=
 =?us-ascii?Q?WHNMC54O6b8bFZ1Vc93zHnu3RxA77hI+NRIcLM/znDqGtHdhTmR0KEU9Xw7g?=
 =?us-ascii?Q?Y/FIQuLobJpp/XRlixAcv0npCoN+gw+jlpptMVBk6vcxK+YtPATxEv8LzT1W?=
 =?us-ascii?Q?WJO993XSIxN/UPnbf/SqTBX2+qGLxxZUyxeY8Bc9TbUCM9CbM4RGTf2Yavgq?=
 =?us-ascii?Q?olcHBGyCVD9tuCjU7Kv4iODwWCM83FwQo3Wvpjnl++WW8yOdwD1uJ4H2A4sL?=
 =?us-ascii?Q?fl8VjBaK5UFE/YGEKbXrnq+PJUJggcvb9fLrtD7OQkRCB5RzNVY6Y45uoS8Q?=
 =?us-ascii?Q?vyLG6sHvcpAde+YNLwIDL66WXLMaqqD0BXUBHeSYi3XiadRe88fkxPjBoHwr?=
 =?us-ascii?Q?cP383Uy4pZS8YojgaWXlsWdM++3RndWf5WehhziycfQ18AbTy3Tc4dbr1EWp?=
 =?us-ascii?Q?1ofA7MpulQ/CCqXId1JiBk1lXXxMGsCclY4c6auljmg5zpMso2hjr1li0KTC?=
 =?us-ascii?Q?yZvW1YIm/nfWagy+ihioorg/WOMqWfYp4XiXXiekjFbpX7Ffr2PzmPK/Yx87?=
 =?us-ascii?Q?1vjkSiCEjVt9QuALYagMoa+ViOYBzKTi6+bXWXCqcLwCXWbEdZygMxMZE7Hb?=
 =?us-ascii?Q?QiXQy0LWvaRg14Yp4Ru2TnwYvsX//C15Vw2YKJjElDO/Z3SZruxnGX088RXL?=
 =?us-ascii?Q?4HW1m2kB/iOwO4gNjbnbxmrawwNw2NOWm+cbvH+lHw3+L6sLn+HdC3rVNrj0?=
 =?us-ascii?Q?LNDTt773nV9m/I2mYefyi4+o5720mlA23FUFr0wHkdIwvtNIvnPGB0U2mSpM?=
 =?us-ascii?Q?mCSPvou2gk4/+6dACZiNqbC9c/7uKLDxdfgSzaBUaRzA5FVggZm91B1t0ook?=
 =?us-ascii?Q?+V2M2Ilp57z3RcJOtHAZooICTuHfhxMtGUp12XWroqg4C+tFHGOlguTJk4N+?=
 =?us-ascii?Q?+wFTI/la+9yWCDtmUbWik4//VzOVqRc9qcok0XdJ71HWZEerVLLaLByrTs6c?=
 =?us-ascii?Q?HSpnFOcoorVGBlplJGYhsyDDHfq8XG1i+bBZhF6sKzzsCQy/DaenJz2SWZSP?=
 =?us-ascii?Q?HAuwpQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a046d98-62c5-4a04-4e1d-08db796db98e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:27:17.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd5cdqKzG1iFxo/NoTyq5J3R/jbJ5lVlNWVCMPIyjUQNh35m4BmQx/LMCgbaKvUWhpQXVrva1qnK6XdOtX2HWYZ1Kj0xyHM2kB/r2m+HWiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4527
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:58:43AM +0530, Hariprasad Kelam wrote:
> Firmware configures NIX block mapping for all MAC blocks.
> The current implementation reads the configuration and
> creates the mapping between RVU PF  and NIX blocks. But
> this configuration is only valid for silicons that support
> multiple blocks. For all other silicons, all MAC blocks
> map to NIX0.
> 
> This patch corrects the mapping by adding a check for the same.
> 
> Fixes: c5a73b632b90 ("octeontx2-af: Map NIX block from CGX connection")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

