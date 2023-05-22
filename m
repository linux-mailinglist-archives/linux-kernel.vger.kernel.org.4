Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5538470C1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjEVPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjEVPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:01:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6C9103
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAg5G+NkWBWaMl9R0t5S6AlENac79W6gfC1Xs50144Sor4JXVUkzYSu7uDMxPZ70pvZPWTJp75nVWcVqsX+jCmZdyGql5t0b95ePHmOYN0xk34Px8vjP7RZnlKk14osyh6/z143zl2K1WoCh6Wv3HaUi2275SmoDQqLFycUhHBrseqAHNqLuijjoucg6jBC1KRpFzIur1z618o6mh8wCPrQlRlp3pG92mDYgOSEnOgsWYsQq3dv+kZIQvBb6RJyMb1S5JGlrlsdOnXlKSZit6A10CTJxn4r9cwHtw8hFa1aXJVlFlg8H+hbjxiHIjrTH35hjRmkE9V8tOwO3a75mSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mU6HDcuX13Sy55YOP8BJRebNRBk1nylpWDks58PD34=;
 b=aP2zGZT8JN9QP8pr1vlt5q/6hPWKUMleB5xi/F22+PXH1f6Np8XOJ41AXOcCnfR0+K9rYe5vDO5n6ZHte9Ew+klbpwi3wjVhVvXENQX3o12uS6uPY2n/Ra58IGlqaI7WMngkR5ojH6N6XagpNOB/ojHJco6QlkAdn3lCAttIP64PezSJdTi6ePi4SRPspasLmBJ3YFfYsvECyXX94QyRyDu3c/Szj139Pwv7I09Z+0pG+/FRhvyuH+wkSjUm3Go2cxLg7ji3u7wKr+wvk60FJuFqrPghgy1HCv8EWXHSN7pdd76Z2Y8MHITuFunc5Y3mKE+2u/jGjxdHwKVmwmXaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mU6HDcuX13Sy55YOP8BJRebNRBk1nylpWDks58PD34=;
 b=xHUa7F5TrK3J2xtO4lsFNxqwlh+0maqcu3JZwGEFm+aAwU1Dbeu/9ITQWWvnW2/Lq6ZSfHduWsTTr3Um3adel+Tftcan1TdFnBNKdImoyzebGFJ/Ork/5PoHK2pz02agPuLFQKjtOE0uGHaO0FPo26l95ly2Xb7HcZAB17Pub3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:00:46 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 15:00:46 +0000
Message-ID: <8f44cc75-71d9-4a9c-8910-e96fedc6a550@amd.com>
Date:   Mon, 22 May 2023 17:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer instead of Naga
Content-Language: en-US
To:     miquel.raynal@bootlin.com, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
References: <c3ff76cb5e861500efe784f9f74ed93db08b2eb8.1683103414.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <c3ff76cb5e861500efe784f9f74ed93db08b2eb8.1683103414.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::12) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b98d704-e060-4bb5-7958-08db5ad55274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sU+QwBXBOGJk5C1cmC1gPfFFnGz4445uNfbQSjmFpQk8ptyNxGY7AbF7ri5v0syN09cT884rbWTqZ6Z785AxUGqGwhZqjT29EvLuaQuZ1pQPQkWkIhRy6CL7hezN1QIa9wmDe1Bc7Zm38DSZ73VM2leQtXU5qG7CCXSmefjjQdssYaYnX1PgtypMFqMKRX6REc++/Lk4t/hRokIv0eq0wERqcIdVXaCJi2O3XmX5BoyQkQL35SeqOsxyZ5guTftucRpiookpGKMOLBkrvH1uheksHM504rx8Nvxiip5lOmUz6GL30Zt23+5Qb1LZVo668OmnQHS6dsreR2l4py6zEV7G0+A2NK39F/0qe54IQjbHht4+38Qzhwu2oR3bZ+sZdsj1l567QqLik82LeNoEb7ZOkekQ03PdAL9o33om4crXvQjWTqlZStwNz+23pWP19479ikgSs/HfudmO7pC+gYaGQM/D+/Uo4AkrHk5rqIH7e64fGPdU4WUd/9DWebhl97bHTGAkz071ORzdP/MzutmCLJ6Xlp3fAlvJvRfobPK4mngDPo0SGvh53i65/ypIKc4N5Fo8Qz5smct5oXYCSdfEkTuaL9yoKl9Ftrq9YAaCtEWi9F79wwlzWlW5B5lll5Vso4+/r2vz4yC8LMAr6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(8676002)(8936002)(44832011)(5660300002)(83380400001)(53546011)(186003)(6512007)(6506007)(31696002)(2616005)(26005)(86362001)(38100700002)(41300700001)(6666004)(478600001)(66476007)(36756003)(66946007)(66556008)(6486002)(316002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RytYbzhXaSs2K3JDL01BZFRzTVZpTHA4a0RkSHh5Tm9Ya0VhNVkydlNQNWw4?=
 =?utf-8?B?MXB3OFBZYlRHVURDcGpkQ0NnZzFvSStpYnRiakpCVkNoa1dJZXdsYTVJZFlB?=
 =?utf-8?B?VzhRNnBWVjhqSFJjcmQzS3JpdklSV1dZK3VzZ1YzU0JEald5blQwbmQzWmtP?=
 =?utf-8?B?eFI0SHFEZzZEd0VaWW15a09saFpCQXN1ejA0RXB5L0tBYlpQTVlCekc2STBV?=
 =?utf-8?B?OHFZYzdrcmRQN1RxcGFzQmYvRnk2MHFaRzJFTDZRb1pNdVVDYU5Nc2N2M3ZZ?=
 =?utf-8?B?NXB6VnE5Ukl3UUc3czlEN3RsSE9UNmtmNzdta2Q0b204cDVGU0NRWFhOVzVj?=
 =?utf-8?B?N2lFek5qMmFTNDV3Z0M0VC9sWmlDcTgxZkhVRVE1ZHpqL1VwbEJLallhQUNO?=
 =?utf-8?B?VXlDK1VReUZRdzNJWU5RRVJHVTZRNmdDU3ZwQ3ZHZUlaQ2FvVnpqM2NvcmFl?=
 =?utf-8?B?Vk1weGVPOFBwSFZxVkhPcHYvNlM4VmtORnBNMm53TnRIbDltN2M5eS9MaHg0?=
 =?utf-8?B?RFlEbUlPQmwrSTVUU1gyQ2ErQVIvaTJIT1FEQXdxR3RiRGg1ZDEzeFZvU0la?=
 =?utf-8?B?TUZIMUFqMVBXeWdhdEJqeExUNjBpc2J6WXo3ZGlsMjMwK1JuQXM2K3BDMEdY?=
 =?utf-8?B?cmJ0RkZGalMwcFlELzhBRW1DaDNHbWZER0FDeTBmN0Z3OUJiWG5jR2RjeGx0?=
 =?utf-8?B?RmtzOGgrNzlpUWw4R1hEdjN1ZWZGNHVuU3lubC9VaEhhcnM0b0JkWkUrWVoz?=
 =?utf-8?B?dHZROU4vVE9DaVdCeDlXNUFDNmUwdWxLTXR4UVV2bmNadXZwSmdyRXE3N0NO?=
 =?utf-8?B?YXlmU0thWU9GSGV0eHAzRGFZeThZRS9ra3J4ZkZiWWdpQVJsMW5ZRlZIaDZS?=
 =?utf-8?B?Z2RsV2NqYTA2bUZiREJ1VWJLcnF6eUJiUW1aTS9mOFc5ajVsa3djRnV2REJO?=
 =?utf-8?B?L2lRSDhKT3NYMmVaM01samtJL3hzanJJem5wb0x5ODZCd1dMcWgzVnI1a2p6?=
 =?utf-8?B?c2JkczFOeUNHd0lteWM3WlVONENqZllqUk5hK2M2L2pQSDk5b1FYbjhibnky?=
 =?utf-8?B?QTk5N0k5M1J3ZXZ3bmRkaTY4bE9tT1lFYVhVbk1EZVgwWnE3cGFJUXdiYlJQ?=
 =?utf-8?B?TjFVc3dlODErZGdNblF1MmxsdHBycDBUTVhxRUhZYzc0by9ucUxtcHgzaXAx?=
 =?utf-8?B?TEdkKzY2cXFzbFNsT3M0MThkK214ZUFQQ2NpY3dGbDJleW5jbFF5U3BiSTRS?=
 =?utf-8?B?cWx1bHM0VnkvQXQvY04rMFlvSG1hc0lIM3ErbzZkcWFqajdNcWhiWm1sRkcx?=
 =?utf-8?B?VlJKSG9uN3A5dU5aWk1jbGtNY08wZ3VLOTVHeXkwcVo5eFRlWGhyV21LSjh6?=
 =?utf-8?B?QU5ZU0VQTDV1dVdHTWhzbEh3bW1ZR29namU5ejNwUEswNnNIalZRWHpmTFIv?=
 =?utf-8?B?QWttRXJkemFhTlprWk1LaUdDOUk0azUvK2ZGU1YzSmZEOExQaHJMR1JaamVW?=
 =?utf-8?B?Wi9lbnRZVEoxYi9Fb1lxZEhEMDYrcmNLMUNRNHNFZGhMazEyUnYwWng1Zk0r?=
 =?utf-8?B?QTgvZ0htWnNVMkVKL2Zud1gzR1Q1eXl1Wlh1WjFpWWx3WXlKdWRVU0pFeU9C?=
 =?utf-8?B?ZlNQRGdxamViZ1NQODF5WjVtamRJNTFSTktLZ0ZodWtpeHNZUWxFSWRaQjhn?=
 =?utf-8?B?MHpqM2VLWTZwbDVrSmY1WmwxYWlqQlZud2xnMzhSZU5rYTdEaWxLeHBvQWJJ?=
 =?utf-8?B?K3NrU2RVcytmVDVDNnNZUzJNME94RTBLKzRyUXg1UnljbkQyb2lDb21od0U1?=
 =?utf-8?B?dzZXbUJVNURPUU4vbjRtRk11OTBlbU5WalJpT3FGd3ZRc0Qxa3ZkZldxWGZT?=
 =?utf-8?B?N2E4elU0TUdaRmdpd1VkWTZVNGN4VWVRWDR2N0xKUmhNbWs5ZXdFWlphUmly?=
 =?utf-8?B?Unc2SGVwTjQzQ0hPVHovbTVWODY2b2wvQ210TGFzM1h3UEhNdlB2emtWWHFR?=
 =?utf-8?B?UnVMd0JzTXVtUUcwZHRaQkJPMllqYkkxUEQwR09aU3BDOGRraGJHWmFBd2V0?=
 =?utf-8?B?Zkw4emthYTFQOXVsTlZFZjIzNVk3Mm8rbjVYcjl1NVNHR2dsM01JbE81MDFE?=
 =?utf-8?Q?lHlyzYmOqdddnUBg4XUYWLBhl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b98d704-e060-4bb5-7958-08db5ad55274
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:00:46.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ylxd0Qd1d3pNnLN56mMjadVGWPe1xGkN0o1LNXXjq54kYDT9ysjmzkeuw9+F7H3Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 5/3/23 10:43, Michal Simek wrote:
> Naga no longer works for AMD/Xilinx and there is no activity from him to
> continue to maintain Xilinx related drivers. Add myself instead to be kept
> in loop if there is any need for testing.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 643f9feeb09a..104f1b8727d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1600,7 +1600,7 @@ F:	drivers/media/i2c/ar0521.c
>   
>   ARASAN NAND CONTROLLER DRIVER
>   M:	Miquel Raynal <miquel.raynal@bootlin.com>
> -M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
> +R:	Michal Simek <michal.simek@amd.com>
>   L:	linux-mtd@lists.infradead.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
> @@ -1740,7 +1740,7 @@ F:	include/linux/amba/bus.h
>   
>   ARM PRIMECELL PL35X NAND CONTROLLER DRIVER
>   M:	Miquel Raynal <miquel.raynal@bootlin.com>
> -M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
> +R:	Michal Simek <michal.simek@amd.com>
>   L:	linux-mtd@lists.infradead.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> @@ -1748,7 +1748,7 @@ F:	drivers/mtd/nand/raw/pl35x-nand-controller.c
>   
>   ARM PRIMECELL PL35X SMC DRIVER
>   M:	Miquel Raynal <miquel.raynal@bootlin.com>
> -M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
> +R:	Michal Simek <michal.simek@amd.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml

Any issue with this patch? Would be good to get your ACK on it?

Thanks,
Michal
