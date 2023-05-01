Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6926F3856
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjEATkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjEATkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:40:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500F9B;
        Mon,  1 May 2023 12:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofEfcWysXNq5KPXUC/ZksbUJNceD6obSdH5oHAgQU8S33Fwj0CkeAfRueWkIrSXgBR4oht8nIPN7fmkVFo2ShCKZt2zVoe2MTVUm+Er7y7aCWaqyxXfX5znBYQc1lQy2quulztldlxM3qA8cHuKFuXNDvmNDBik/tijAvUV74GNM6n9NgPbLuvrabdt8kEhgb3O35QehQQEIww6jJVoclRBstlUbnHS9+oyYChfjt1yqvy2xgfI6+PTHIhmEHidvFcauw7G4xACQEzh1GS3YBI77z4fCwsaxXAo+lkK9xj9HPyDgsB4laJT3RE1FG+F2ydeRCvaInC5ibAYMJ5hduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpnyBZALYkFLd94qE2SHi+YDueafdJqKBiaEOMeAuw4=;
 b=dRN4mWvp/4qE7D4koiUglu5n4mlkuCOtbTnEFZrheGBiViEZr+0HNqPMtXkFq8n2hjU3ma5rnysKrJ6KXby5HllWeKndYVJqSKEw/JEsXczwW23mQ4U4SjrkJQZNW61xvEs7JhEVH4zz0YzDp5ToRIZ+Mqph4vUAeLN1f3PPciIw5u1PQEAt5Z5U8rRU6g34uquNWa76Bb8bDbtbIPywiwmXDdd2UaHyJXDp5lPOt8stquZyXmJIyKAEd7ZHF6UIOGZby+ze7E5+kXAquh2qnnr0PpdSGLov1NfMvLi19DUAQLlS4UmSbY+J7KzhPuFaId+WeKaLYltiq9m6kQjG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpnyBZALYkFLd94qE2SHi+YDueafdJqKBiaEOMeAuw4=;
 b=f+9ye5+jkyw2SbW150uJ6u6OUIbI4LVEDCcqrfALE6UbVcUbFsiuH/envJW9TPdGXrgcN24sQO5vZtqopFcZjoMxrm8qujJ4Jak5YXpOM4wO9KS/5OzVPULIomsysitPGu2XU6PWeN05UN9+Xjf6JxnuoFma9OwV7n5IFuTJk7mozPIBsnG/5Wni4ZEfw3x47Yhdn+7efEDOyqL7Zx0lU6bwjaFXVEQbJ9zjUEDRJT2C/JdWsIY8T6BX0bsAx5NT2rqtAGCB/xK7u2i8mYttX0OajChJ8skTnOI44BUhBHhlYxnWpHeHNznQFKbPN13nnWdlPqYiUwgyj3X1+5WoYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 19:40:22 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%4]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 19:40:22 +0000
Message-ID: <14a6bbb9-aca7-750c-e004-2b11abf05926@nvidia.com>
Date:   Mon, 1 May 2023 12:40:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Missing signoffs in the hte tree
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <143a3e5b-ddc9-4ce1-88ea-9e4d80761cc1@sirena.org.uk>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <143a3e5b-ddc9-4ce1-88ea-9e4d80761cc1@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c423676-3add-4e20-9098-08db4a7be6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJxCC4OxxtrG62WaNgIHiHLqttOnLOxYetdaw54tO37zP3tONQy8xycED+//x4htyrmzEB5ntWqGtnW+KFDHbhGq+WjZ469vtzQQtfjqDNaIVAkcDuIj5G6RDE5FdtaGDQaq+MvJEU4Dawim5k1O/3c48q4fYLSPEyc8KkW3fXPly46n1Nh+VoHcwTp8PzU6pIW2IEvm6YkOcWZETqWBhIQCswg8cbtYSC0aDuJQNLPQTDJcokXZplRtUpXuXH1lrGDlGI6uksIQonnx+Q64621ngjOiVEFg55O2mU47/+DXhuuTXN+RBpP4aoZB/nC7YtHEKp2uJUPjImMcinp7dGbVrNCynE+b3asxtpzegPqhO2LIQWg09Ax5kUt2OGX3GPYOlJnjjtcbkLOj4Vdvvp0Z8XsiWcMtxHFWD2KPf9mpqzGdVuyBKqfnUDW1wyrQHMLUhinm3J/NOBVCCAd1Se9w66iWTRQTaYwzRhJM26HYCQiyNxoPsBUGnhv9mFAy+p7csl3ye+3mVSmrawJuvV5WOGcDNsLH6SB6+k30N8bSqpzlaNLKNphjjDMdn238DNXH99HMryEsWMMhnd5DCoDN2znmqaeP4aDHq6jSbmhdctsWaLTM1pg4tqKraeRezxX3/d+F4FbL/sYs736iTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(8676002)(8936002)(41300700001)(5660300002)(31686004)(31696002)(86362001)(38100700002)(26005)(6486002)(6666004)(6512007)(2616005)(478600001)(36756003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(4744005)(2906002)(6506007)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmpMeFRJaHdlbEVyY1hsWnd5MWM4M0E4encwUjIxYjVvUm4zUHhQaElYWW5E?=
 =?utf-8?B?dkk0TzhDeFRwekVYVGtPbGhrR0NzZ1R2YVMxbjIrbFd4R3dsaUZyRWlwVjRZ?=
 =?utf-8?B?S2FoMEc3U040OXltVk8wcGJ5UTRZTmlQVkNRcWR5T0hiS3gzTHQrdUI0aWg3?=
 =?utf-8?B?VHJLWGFmVWxuMzhRRWxVNE1laThkenJTVkszTkkxOXArY3lCclp5Tk1Qd3R5?=
 =?utf-8?B?dzRtK044QkNncGVFYWFqZWZJNDh1dExST3Fqc1BUTmJXOWxNU0Q0Z0ViZzhh?=
 =?utf-8?B?QmZEWXlTbmpKaGdMaWJTK3grb0tYcC8xTzdkK1paWi9uZ1dRc2c0aHpPMFl6?=
 =?utf-8?B?NW1oclhicXZNcGtydVJJdXJ6d2VSOTMzOHQvb1BadkpEOGhFY0hpbXZnd1BR?=
 =?utf-8?B?L3laZTB0RFAyN1ZSRHJrRHVtb0licTVsc2M4d0hzajltWW8zeDN4d0hsK3NN?=
 =?utf-8?B?T1R0MHJNdy9lRjJrNnZiT044SzZwSTAwbGZZb2dYNnBEUzVHK1RkZVNpbjA4?=
 =?utf-8?B?UHpTMDIvVXpIRm9VcWdEV3VNT2EvQ1FhdlQ5ZnVubTdYdmwzdVAvemQyRW40?=
 =?utf-8?B?aTg0dnZKYm9sdm01QTU1bjlvZ0dOVkl5UnVpWlV6cEtneU1EYlVYdktUL1d4?=
 =?utf-8?B?L283UTNxNml6Lzk4REoyRDVDekVFVTVUbWlEYzQ1SDFaN3A0UVcrZG1QNDhT?=
 =?utf-8?B?eWVQZDRuQWhuZlNKendoVnFwRVNyc0hlOHR4eG5mTEc1aFZTUFgwZFBqd0FE?=
 =?utf-8?B?Zy9ENUwvd1ZsRThMTHdoNGVQdzU4YXpjcVFZZ3NucUZUSkhBRDl4Nk1uK0Y3?=
 =?utf-8?B?VlBkNFFubHNseTh5aWRyQmJCaEZ6ejBPYnY0bXQzVWFNL1hIZFJrbDFHL0w1?=
 =?utf-8?B?bm93L25UYkhERVVvbEJMa1NkY1JNd0dYdHJuZ04vbTZKMjdUT294djF0alh2?=
 =?utf-8?B?S0drUGJRdUFwNnM4cEQxMmlPN1BwekpWOVZHSFZxQnhXYk1HM0c0NDNMMlM5?=
 =?utf-8?B?OGdUT3F6T1pRcXZwM0ZubFJwdDB1R2M0TmdiQWhQYnZaSVRjSllPSFNRODNx?=
 =?utf-8?B?Yk9seWc4R1BDNGIxaHNMWm1hUU94WlNkVjY5a3h5cHdZbXFrNEdYcitkbEJk?=
 =?utf-8?B?N3FzVVNxUXYzVkhwTkdUYk9QUlZvR1prQkxKTVpITEE1c29KSWFUMURueHJO?=
 =?utf-8?B?QnhYQUQzRWhzZTJZNm02WTVGK0FxbGFxbEJSZGV0Y0M1OCsyYVVrNk9uNURp?=
 =?utf-8?B?bHhNdnV4NDV5ZjhOSkNXdHZKU1haYjRIMEltc21WU2RGNTZNeHYwamRUUnFn?=
 =?utf-8?B?T0FsRnBrVHc4dmdXNmk0dC9BTWJKRGhNLzhwdjkyZ3EvcUhFWGswS3hPN0Yz?=
 =?utf-8?B?REo2Vit6bnRxMGJNUFZXUkxZUlpIVFVXeVZRcEI4YWF3MGZjZDFBUmkzTkdt?=
 =?utf-8?B?cXBvNDV3M3ExZkJJVEIwN3FDOUphWWJtNG9ETDV1dzFXNjFPTFR3VHp1REJ1?=
 =?utf-8?B?U2NKWDFma0llYTZJTkswYXpxaGplN1BxNEszVG16L2NVUUZKcXY4UVZvVzYv?=
 =?utf-8?B?NjZBcUMvOXliU1E2MzJZc3F1UlppZVdXRmRYaDNLSWVoMkVaMTRrRTN0aDhH?=
 =?utf-8?B?RWdPcDVRRWU4ditMbHM1T2EyUDVnclhEUiszZ3dsSVE4SjlQNS96TTZVR0tz?=
 =?utf-8?B?bHFuUCt2WkRyYklXOGZTUmpkbTROSUozdko4UTdJbHFsb0RJSy9idVNsZ3ZI?=
 =?utf-8?B?RUF4bU1JYnVocG03M2ZWc0JsdnMrSWVaOXNhV00xSVZDUGwwTTBtcXkyUmVQ?=
 =?utf-8?B?U2RlSmE5R2VHV3prWHFpWlB6WitKSHd1dXVPRDB1dmtML21KOG1kR0FiWTEv?=
 =?utf-8?B?LzEwbnhRcE43bE45MFBMRUw3TlpLODExRTcveEZmelc1YXZNMDNuNHNRRTRB?=
 =?utf-8?B?bVpxMzV4c0trU1lLWXgyMzJRYW1SWmlVemJnbE01eEJla2V5ZG9KUi9Sd2ZF?=
 =?utf-8?B?dmpSRTZERlVBUDFxQ2EzZGY0WWh3TXNVdVltN3Z0R2Q1R0FMSzREWFRGTHdl?=
 =?utf-8?B?Z2thSWZCK2ZiNE1JQ2ZVUUVoU0orVXVsbVIzK216ZGtQNjFPOGpFNlpKMW9m?=
 =?utf-8?Q?AbAEp0tANxhB+3YczlPMVC2Qp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c423676-3add-4e20-9098-08db4a7be6e1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 19:40:22.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Fo+0bjdCGLMnugaE90v57lVmVhgLiHMoFojTsYZRuowFJpGWxF7hgjYG9UaXUC9cvUQ4yNcijrJ9NE7EhlzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 5:07 AM, Mark Brown wrote:
> Commits
> 
>   1af0f6b5060cf ("hte: tegra-194: Use proper includes")
>   3798a6e3b6a89 ("hte: Use device_match_of_node()")
>   981501927e482 ("hte: tegra-194: Fix off by one in tegra_hte_map_to_line_id()")
>   58e1189d075a4 ("hte: tegra: fix 'struct of_device_id' build error")
>   499c35fe9bf2e ("hte: Use of_property_present() for testing DT property presence")
> 
> in the hte tree for today are missing a Signed-off-by from their
> committers.
Shouldn't Acked-by tag from me (maintainer of the HTE tree) enough? I mean it does imply signed-off-by, right?
