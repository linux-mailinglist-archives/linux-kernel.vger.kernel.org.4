Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7173D88C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjFZHcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFZHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:32:09 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D381B3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkDIKHvB1J7RNVbMriFiJ31nj2Vc03cXOFa1oos77HW3kzOQZZrMHzHUPQLLKZo9ElRoiT/dRxnjkLrsPuh+ryPgUtEEA3MWsf73D5LZK+ZzwKcg73o3l/wyH25PHsmWrn6j9UrHvxdJhd6QVvTsMhyyhJpZLUxc1P6UJEPZKcMSrYS+sSU/db6M/BdsVuqKER3Oo7h0fkY2zmJFARcnVcEyyXh4Fs3xhk5VdEMA4WDW3M7G7OlFN32AToUInSNVLrYpExp3Mm32BGyok8wjYf1vbbFTp4M2KUMRuG60yo4W5LW5h2p3VQQNp8uTIRWpbafUnDeAZ8eZpNjuYi0B1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha1uwDE6m2GtN8FjyYsy4vFa2EaLQJteSvuBLj2Gz9U=;
 b=jwY3UK16ALV4tvhngamGQjU/u667ESsAACTW991BfPxErB62kHAuYjHUAK3NW2w4m03Ec9fETaoWHw1aba7YCBE/abDCfAxg8YV2okhYLQ+kHEMT5MiOdw2dC+G+QwHh1PMeaO+MWBbwh+Og0NCdnYuuOLfDLbl4aQvcVaVcipnqdse/uuptkwR3ayans7y52hGos2VXqnMnNdu2uLdkt3EzLqQe2fiBFioRucTfwHeJpw9hCeyuItkcLzWFVsG2gx5U7Z7BRg4bVS4ayAcYyke5v27bQyoKAbxC+jSNGc8/89q349lw6lHpTQo3NlmEI8v1Wk0z/1WRw4cLzbwQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha1uwDE6m2GtN8FjyYsy4vFa2EaLQJteSvuBLj2Gz9U=;
 b=GXAbZFFG0z4uIZDi0FDyk8QDEspai7t+8/YnsoUqbNWYpgf4nzNpos3YtKovHUd1Emr5qkKyhQnKFDfxvLMy7322zu+F6qjgrUxbmZxFMSGbdJUAYcuxOEHGLw+cpMJYr8xuEwVHRXlTxNvMJIYTn+5KrwWDRq4yvcMJR6k8VWi2E8I7Oy/BfXRz23KmNKp1Ha8JQNtMaZTNZhRfFe54Ks7gm8aKKzJqQbB7ImU3aCuSJ6BMQjoD58PamWJz2R+rjyRkXME92vyYtDzZErHe27esTsAO904mgPuMLJKdEBv64NNrfuVkhvZeB2qUpZzMv+hQ8yne29boSujGATXrZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5078.apcprd06.prod.outlook.com (2603:1096:400:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Mon, 26 Jun
 2023 07:32:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 07:32:03 +0000
Message-ID: <953510c3-4bcd-1426-3527-09d5cbdcf8cc@vivo.com>
Date:   Mon, 26 Jun 2023 15:31:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: f2fs async buffered write patch
To:     Jens Axboe <axboe@kernel.dk>, willy@infradead.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
References: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: b6129108-fc14-47a2-6928-08db76176f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLx6O7bxKs5ZYsswArxeFERYRfMFiCGOMP+DyrtbHU4JC0vjgTYlzUcsv3Z9cUIAGSqTqbIZ0dTW9kBLG8d0ofJ1j42BsNWPppQ+k+1qc7c+iKJ5afbed5uDbHetHelieK/g0RgSPFdGjd5EJy8Hr0PjFaS3YG5Kqs3uxlmmPmlkpA89Elac3FSPqY8aaXd75f0COUtTV7vPbeGj6+NlfhzrGEwgigluQZcYddPVhTVcgzhPA97UJI9JJpugBkgy28H5G28N5w/XsChV00Zb/1caYJhXV/Whan6cqS45tBCZkUx662MEQOpMiccmBrtJOTSaWtsEHM/MCtEZ47vyAiiSboNkeSLGNx+xn8qjbAMqOzQfd1wuKJJQb7S1grVXYS4DsG0+XBh9MyEVwgV3AKSNkgshvqUpSuuBMNTDCODI2MOtnexNdH3Wx4bmnmWn6asiGVD/G+w93mAox8wvbuOYD/3EbrF7nGIzstdqD35frXPbvhXEUWlbOa50m5QLQmHBvihSKbhzh+cTvd84haFm4Qnv4jZtMmaQ8z/bOj2bdqix/wNdzAcClIKvbrNuHEpz5iwWV3xCsVapyJb2sORusSPjEG8SCZUsu7uCUa0acX9hrvoqaECSc0p7FF6TcAcnnH/82Z/Ya7mcLCnVT0YMkdGo4TVxGWFBTsXc1PYsJTEfhLZROky0Lr9JNjE3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(31686004)(6666004)(6486002)(966005)(54906003)(478600001)(52116002)(83380400001)(2616005)(86362001)(31696002)(66476007)(53546011)(186003)(26005)(6506007)(2906002)(6512007)(4326008)(36756003)(316002)(66556008)(66946007)(38350700002)(38100700002)(8936002)(5660300002)(8676002)(41300700001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXJyNHlobHpQbmY3NzFvZVplSUt6T3dxRno2QWkvRjFyQnYrQk1uNHlOSUhZ?=
 =?utf-8?B?bkJ4MnVaV05tb2Y4alJLNjF3NGFub1p4MXE3YW5pVXpHMHhSbHZ3YzV5R2hq?=
 =?utf-8?B?NnpIZG45VlBRSjI3VUUrZTRFQlJxQ3VpWkVTejY1QTZLTWpxZ2NPUUFhOEZQ?=
 =?utf-8?B?Ni95L3plL05CZ0YyWXRBK0doREdlNkVDWU4rRGlMbS9tTVM1cTd6ejFqbm9k?=
 =?utf-8?B?RlZBQmcwdjFKUkZnaWlhdVBGQjZiL2tsUkVucVN5MFNZWmx4TjM0NlZoRGdh?=
 =?utf-8?B?TzFxZkM5RVYrcnpNVGVwTW1USE04R0RTVTFuT2pWWk1VaU1mb2xqZEVETVc3?=
 =?utf-8?B?eHpWZWZZOS9YMnF6bDg2NGpGcE54WFhDMjR4L1B2YkdOMDNHK2dPMmovbW52?=
 =?utf-8?B?ZE1RTnFkbW5kbDExRnVBcTdldUtiSExILzF6Rk01WmU0UjJZRGh5SjN0RjVl?=
 =?utf-8?B?QTZpdnJvRjhoUW05WmRQTHI0bVNsT1hSY25EQXBIS3VNU0lydDJtWXg0Rms1?=
 =?utf-8?B?cVZ0M2dXTjZCUEdlTC9LQTRocDR1a1VqSUNlUmNmc3FzdnVHMHJqUEhXeGN5?=
 =?utf-8?B?OEdVZjBGT3VzVndqcG1YTWxqVW40dkN5N09ZcVdBOXJOdEVuN29SWGhOUmdm?=
 =?utf-8?B?dnpzNTN4MmRzbGladlg3Z2VQcTZJOTNWOVppVFJzWjdJNnBVQlRIWGN5bC90?=
 =?utf-8?B?STZVSGVkcDREYXdYUkVoZ1dySGliVlFMa0VaZWlIMUp2cENBOGtTSWtuY2JR?=
 =?utf-8?B?TzFTTzJXRVFkc0JSTVdRbzVCbzRyZ2RIWDF0LzlSYzh1R2o3RWQ1RzNQRmhV?=
 =?utf-8?B?ajFmV2JFenVHMEdJM2NqalBJUW5YbWVYck51U3d3VTNtTE9ySUlnV2szcjg1?=
 =?utf-8?B?ZEtKM3RBNng0amt0N1JYNUJpZFFGN1RsSGFxSG85SFV1QW05Ui8zbXA3bTlN?=
 =?utf-8?B?dzFhOWFzZUdvRE1RdzQreWo0ZTl1UFZqT0pVZERmOUZBSlh1bDVPUXZuVkkx?=
 =?utf-8?B?eXpLWG12YiswdjRYdkdSRXNqU2wrRWNqSjBEUkpjU3l2TnRXZ0w5MC9pMlRm?=
 =?utf-8?B?bFpOczJINzZqQm5laHIvak9yck1BaitmSDgwdmF2M0M4TTlidnlpSXVjVWdx?=
 =?utf-8?B?a0RaMjYyVkNoUkdpMUtDRVMvR2NqNkNlNHZQclZJaTZKc21GTkEvdXNFZU9z?=
 =?utf-8?B?OXUzYzhqVDFqcW9Gd1VsVlgrTzNqWEpWcmVqQVNzS21HR0V3T0lWbllSRWhD?=
 =?utf-8?B?YzhxTjZDYWl1NjdXQW5aYXJMTFdFQ3JuTUZsOUVGTytjSVJwWEJWd2E2U0xQ?=
 =?utf-8?B?U0FjTk9PR1BCK2pabWV4MmlSZkZ4RzNzSmZIVmhMT0lNUzR1TVo0Nm1yL01p?=
 =?utf-8?B?M0F3a1NmTmk0ZWhXR0ZmVm5JY0RtSURLSnVrejlhYWIvcis4U0tQOEJTNmhG?=
 =?utf-8?B?V0QvdDVWK0NsNEpjd3VYYWRwTkJxbm9tNUE3bEZSaFdyMkdDQWtOTjVSalZM?=
 =?utf-8?B?ME1wTVo2bDNqVXd5M0VNdmhreEVTNzJyKzMwSEEwWlY2R0U2SU9lZTNyUnUw?=
 =?utf-8?B?R3p5Rjc1SStINGhQS2Z2YU54THYrS3dBWEtyeEZNeDJMdUg0TjcwbzA0Wkd6?=
 =?utf-8?B?a2lSbHBYUmIrRVpNR1pYRkJiNnhHSndnVDZmZFdDS2xzams3eHB2dU1vcU5J?=
 =?utf-8?B?NVRqdHBLRWRnU2FUOUw4Ym9PTkdLbmlSSGlxUGR5ZUtoNHoycWExZDZvZ0Zr?=
 =?utf-8?B?c3NlMHBkcUo1d2hXaXNleEhZMVNxdUV2YjU2MzRRTS9CbVk2Tmp1OG80WW5i?=
 =?utf-8?B?WExzelVQSVFoYk5jOHhsYkRjbE11WVIydnIvdElxZ1BKeEdsVThkN2Q3YmJD?=
 =?utf-8?B?UWczREYwdnRJbnJDdWxlK0ozUzYydGVHNzNKVFY2MnZ3dTRLMEdwcHRwWjZj?=
 =?utf-8?B?Ykl4ZGVCeUJZQ2czOEhnU1doZlVIVDh4UUw1OEtSL2owRk5xM2FPcXpZdzJs?=
 =?utf-8?B?aG1YK3VoaS9SUU1QTTRlNGthR1VPZjBKWk0xVE5JYlpwN0xKT0UxbWVpdjlz?=
 =?utf-8?B?My9SRExwU1VKKzVoQ1RNUzNWRVBOZWNNbXR3V25rdGd4SytmNjZQOTBxNWd6?=
 =?utf-8?Q?4hcwr1mSXx5b9iI4wjQd4kyv9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6129108-fc14-47a2-6928-08db76176f2d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 07:32:02.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVEPbQWFXli0rPmlLs5xJTE8ieVRa5ipgrkNjzJsCuDPL4mCLIzV5Ony5sNGsBbEwXa3UbDieuJMHZUJQmqJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5078
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc willy@infradead.org


On 2023/6/20 4:43, Jens Axboe wrote:

> Hi,
>
> I came across this patch in a news posting:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d618126911829523e35a61f4a5a4ad159b1b2c8d
>
> which has me a bit worried. As far as I can tell, all that patch does is
> set FMODE_BUF_WASYNC, and then just hope that the lower layers handle
> the rest?
>
> What happens if iocb->ki_flags & IOCB_NOWAIT is true, and now we do:
>
> generic_perform_write(iocb, from)
> 	...
> 	->write_begin() <- does this block?

Most file systems have not been changed to the iomap method,

and the generic_perform_write method is still used. So it seems

  reasonable to make IOCB_NOWAIT be handled correctly by the

  generic_perform_write function. This means that we need to modify

  several places mentioned by Jens in the generic_perform_write function,

  and need to pass AOP_FLAG_xxx or iocb into write_begin.


I noticed that Matthew Wilcox removed the flags parameter in write_begin

in a previous commit, maybe we can add it back?


Thx

> 	...
> 	->write_end() <- or this one?
> 	...
> 	balance_dirty_pages_ratelimited() <- this one surely does...
>
> If you look just one level down the latter to
> balance_dirty_pages_ratelimited_flags(), you'll even see the 'flags'
> argument documented there.
>
> This looks pretty haphazard and cannot possibly work as-is, so please
> get this reverted until f2fs is converted to iomap, or IOCB_NOWAIT is
> handled by generic_perform_write() and below.
>
