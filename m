Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3546E6F12D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345676AbjD1HwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345665AbjD1Hv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:51:58 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8455275;
        Fri, 28 Apr 2023 00:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0y8fOrjh45ZuI7/J1Mc1uNmyXxH1xLfd153EpWcEAPt804rmskaiVG8zeLq84ntdIQJOnh4yIeYisHOud0ZbBZWUwfrF1KKBp12ESRHEKwMSLFCZJaMQJ0SAkyporskcdLUfXNWM9CuKFwLGxHTU00L0i2BjUSQ8wl4+HfdGQfhyKRdZ7Voa9YcVuYNZOQYGHQvGJGgHdLeAankjpTjQZYuY+al+zMYdJoN4HBArV6mrsQVIc3rjqQJ+mAKCvuiFCDFt5zu6HYP41iJ9IxtvPCOiC0HUfiSMVa4KJsrw26QHskVivSQpFGiMF8eQkYXWovsxJL7DaSDgSFsA6vlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFng4f0TiIZd9OV92ZDSNGtY3pehtUAkX9U8HaB5V2Y=;
 b=fgx6R4U+XADD2BqR1yYFei24ID54F70IK0eNbzqd7UaLKA4daL6j3OKpiG1AXKYvvYbjQZWCzyzWNpuygFpZIFCy1kG54K+YTyYK5hYhffKMenNBomRInTYigu2MDSbnIIjjZPpDvn2DHBjYyf8OvtYvcx6IXprWjFieu/PB42rxqfqS1R6GZI1+l7WcEEq1OACu5buQ7us5VLxOJqejocOqIA92PBCLL+TpCMvrjGhsSmljNK/pamt9DTlIS8WQy5yIiIiAH5ROWAHCOyQx+QS9HrGSBM7gVHRN4O/UMqGrOOzZ5/5Ko8o0CMgFt7x0nKD1+6P4xdaq2ptCRTI4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFng4f0TiIZd9OV92ZDSNGtY3pehtUAkX9U8HaB5V2Y=;
 b=Qsya749XTMiF45Jz2d6VHePRIItvUlmPdLTv0G4dYwgeV3f8FsgPNg/g82RKQWsfsTYTD4YTrlNtyZ6CG5D08xakQtX2sX3oCU69eJb+TMvO3T/Mc8FeOUJ3EzcDKy8jFCX1a1iokJTN4royAyyJLnZXORcviSu6ziJSevHqnM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7728.eurprd04.prod.outlook.com (2603:10a6:102:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 07:50:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 07:50:29 +0000
Message-ID: <dc0f2863-d5d5-5102-eb8e-ceea92c03fda@oss.nxp.com>
Date:   Fri, 28 Apr 2023 15:50:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in
 'imx8mm_clocks_probe'
To:     Zhou Shide <u201911681@hust.edu.cn>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bai Ping <ping.bai@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230413032439.1706448-1-u201911681@hust.edu.cn>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230413032439.1706448-1-u201911681@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: d2988b0e-cceb-4853-cd0f-08db47bd3c0d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qI33Bk3JesqUj07kNRHsP91A8fDsjnaVjNVSAjxPYU8qExOonVnqQZiYg+TPVXea9eagkNxfEjj324KYH+TTTIplTCWTggP03kt9aeBiunYDhyxKvSWOwX6r8GqpEnhLgxBgfTEcRU3STYtYBDc37xbRWoxfSozVE14mQSsBPwQNyPOAW7M9C6384R5Mf+hvQwl0EFxS4VSvn61nOcXkOg8MRrkNCt+/ohzPMoySo5UvOFsWPnweiqyxSogi36lvxLvg303Zhey8CSFlRxFAafDFsvny2eQAq6fFjDsM1UaL11f/Lp8AVV5p14gmlvyHkrpKVff1dbF1xvkbMdVt20oW7IT5w//io0J8a51BJtLSCkehlFpTST56hb3sNaFWYzhqSKLTbwNsC+e4G3FW644Tuoso15wbs8mmMWn8Tlm0ct05TAY2RrUS908+7zaQ7zj7pKcKQKF2x2ED1Dmuh6pwt8C8ZH0dUaLLwp2bK5hdSRG/8Ds7XuPx2AMS82D5qHCdJwzetxPJzeBz93pY/IiCy3eQMdP6SuSNhEvSC024wD2nKRKJtFhDeyPgs3cGxj7gFic+4NSE0RA9Pe1y6dXFchrGmlEQWKJNYA5ryS7KfWBs3SRTSxzEgYs8Haie0mvvIaJtIDoWoWuKsQJ8m/Wzmae9HV/CRauNEU32PaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(26005)(6506007)(186003)(6512007)(8676002)(53546011)(6666004)(6486002)(8936002)(110136005)(7416002)(4744005)(316002)(4326008)(86362001)(44832011)(66476007)(921005)(5660300002)(38100700002)(66556008)(66946007)(83380400001)(2906002)(2616005)(478600001)(31686004)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk1BTjhoek1CK0FvMTFwK2haai9Idjg3Q1JxRTNFREx2ZFpGSElOYVUzbDhv?=
 =?utf-8?B?UmNJL1ZrUVRHeXFoeWxWQzRtL3ZZTVlwTnNKbG9PM0M0a0FOYkY5b1BvalR3?=
 =?utf-8?B?dVcrOFBLODlvUThLYWFSMEhGa3ZRQjhsMjBIRzlPbzJRWTltRzBFUG5Ja0h4?=
 =?utf-8?B?b1lGcWJ2TGRjV0tYY0VNYlZHTFY2ZXQrc01uMnNwYzFRL1dWeG40ZmVBaFlk?=
 =?utf-8?B?WEZwZzZtY2RrQmlEV0J2NmlYZlE0cUhhTTNGbDdJUURMS3FUZklRNlpWeHNO?=
 =?utf-8?B?U2VrTmZ0dGV3YXNkcDN5WjZGQ3NHQm93QnpySUFsbnhKVHR0MHpoZlk2Z29k?=
 =?utf-8?B?alNFQmRSY3NSVEVHRFNqckNvZDVqTnZnU0VITStKTFJwczJpVVZScUhOMDJH?=
 =?utf-8?B?aWRsV0U2RzhQUDg5MDJPKytmTGJ2WjByT0VOcnk1Y28yM0JqbURXWVBFWlBL?=
 =?utf-8?B?QkoyYjJ2QlNScFUrdFRPN0VxTnc3SFJXaVk1clV1RE5MZGUrb1Z6WTdlNW9V?=
 =?utf-8?B?aDU5T01EZ1lhU2xLR3lVZ0hjQ1MxYWtzMjltNmFIbXZmclBaTS9EOU9rUmNF?=
 =?utf-8?B?R3g5eEdXU25DLy9DYUxzOWNabTM4U1J5UkNZTG15QXlrSjdxajZsL1RqKzZV?=
 =?utf-8?B?VHdpN3AzcEVPRE5Vd3Z6ZFN6VUhVVlJERHg1ZkFBY1JEOFUyRk1nQ1ZZYUlq?=
 =?utf-8?B?TU4xSmpTcnZxSDdyeDdVTTRXRDZudDNEVTdvbHNQWWVmVDRRWDlOVjlpemN3?=
 =?utf-8?B?UDVwQnZjVDJGK0pmV2hZR3hJYXE2RlF3VEVVMjBCQ2JhU1I3WlpESld3bjZv?=
 =?utf-8?B?ZjZOYXYvUjExQjdtZXZXdVBJdVBDVllMMDR2N0J2RXQ0cldpNHF0S0h3Q2xK?=
 =?utf-8?B?dzJYcDV5OTFQVTQyYUMwVmtMaTlmdWRNNHE2aFNmRmlVTlFFU2hwd3ZQYmtG?=
 =?utf-8?B?TVJnYnNxakc4UE5EbGM1Y2h3akFQZmFTbmVRNjZJSjV4dTR3RVF2bXU4cDlm?=
 =?utf-8?B?SnZvY1FERVN6eCt0TXZTc3RZcWZkZW5DcXAxZjFUQW9UOFdIR0I3M1AxSkZN?=
 =?utf-8?B?WHpDZm8wc2tLRkJWOG40OGVOaS9ISnR1VHU1UHViakJCVEhBQ3FxQzg0cXp1?=
 =?utf-8?B?T3dMUEZaRVg4TTBsbU5uK2xrWjJQSG00cDlGaDRlaW52RnlnbVJzSTZuZGwr?=
 =?utf-8?B?TmZybTd5NzUrdFArbDE0MCtTQWVJMHpKNE5CL1JLbEdvdjVkSHlqaXZLRXRz?=
 =?utf-8?B?RkdiN0d4UHhsSm1BNE4xcG1kZmkzclFySnluZW14WlNlOUVkUU9FSjZoU3Fs?=
 =?utf-8?B?ZUhycGxHeHV1eVBteEVRRVJLdDJpdzBUYkVEa25zZzBOemNRWnhUMk9kMGRw?=
 =?utf-8?B?emE3UGtGMHNpenp6QTBaaElBUHhNejBQSVoyNFBSNU5HZldtRkkvWHVCUVA1?=
 =?utf-8?B?RGx5dVlEbk95MmM3Y1JFdDY5anVTRExqRzI3SVFvUnNxc1JjY2xiOGRPRXFq?=
 =?utf-8?B?cGNvbFhFcUx2ZUdMczhTTWYwYzJ1MG8ydXdtTURSaU1pU0hJNjFtdkp0NGpK?=
 =?utf-8?B?dlNxMDJPZG1oSlZVYWEvOVdYWFQ0VDlYU0NPNzdPRExWK3FMQjhmazN6MnBv?=
 =?utf-8?B?Rmd4MXdWR08rc3dONUFSdEN3YzB6d0N0eXpiQVBRM3pXYjJwbWUvaEdNbkFo?=
 =?utf-8?B?YlRtZXB6eTVpT0ZIbllJTDJZNTIyejRMNGdEZUNPb3Q5MUFMWTlHajVibWUw?=
 =?utf-8?B?SFFnT0RIK1krOVBlZzR2eTNEZUY1WVNHZkNNa3FyYUFWcUNSdjVIdkphSWJP?=
 =?utf-8?B?NGtieEpUamRLQjF2L29qU0JPNENjdEdOMVBQQTNYZEN5SzBmUTdXMjhzSExm?=
 =?utf-8?B?am0xS3FsVWVtRTlka0pqV0ZDWEpkK3FXYzYraVVYVEkxeU1KQ1RtUlFrMFl1?=
 =?utf-8?B?TmdDTllPZkJ4a0doQ21zTHk0U0U0eXpPWGxEVU1HNFh6RVhFSEMxMHl1OXVU?=
 =?utf-8?B?cTdkMFlhKzdFdFVRRDI1Zis3ZmQwR2pYOUVsZUxnSG1OQUF5RWowdW5ybjF4?=
 =?utf-8?B?eHFmYVpBV2NvZFlMVVhxY1Z5clZTbDhUcTB3MFZIVFZQamhDejRrZXBnRUhw?=
 =?utf-8?Q?KioRjZHvCt20eJqNYTrPfaNwc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2988b0e-cceb-4853-cd0f-08db47bd3c0d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:50:28.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+ePjCdhtzZYBodPWilT5q7pxWuqMxyuKb7cxF8EOr7XsC84FQJiO5t2ynQYJmJAybbevX8E8lgqOxg9juQpyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7728
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2023 11:24 AM, Zhou Shide wrote:
> The function imx8mm_clocks_probe() has two main issues:
> - The of_iomap() function may cause a memory leak.
> - Memory allocated for 'clk_hw_data' may not be freed properly
> in some paths.
> 
> To fix these issues, this commit replaces the use of of_iomap()
> with devm_of_iomap() and replaces kzalloc() with devm_kzalloc().
> This ensures that all memory is properly managed and automatically
> freed when the device is removed.
> 
> In addition, when devm_of_iomap() allocates memory with an error,
> it will first jump to label "unregister_hws" and
> then return PTR_ ERR(base).
> 
> Fixes: 9c71f9ea35d7 ("clk: imx: imx8mm: Switch to clk_hw based API")
> Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
> Signed-off-by: Zhou Shide<u201911681@hust.edu.cn>


Reviewed-by: Peng Fan <peng.fan@nxp.com>
