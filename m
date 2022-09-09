Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD655B3EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIISTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiIISTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:19:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2139.outbound.protection.outlook.com [40.107.237.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7013356FF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehSWL+g8xnb3yZvKqED+YkJiyntVoobONAGLjchUqLlMdvjyNCDMy3O63AcHT7nLpbiUCCvbrOHvn0AI3GJmM6srIJzklRwuIz5X+wV3g4e/rSQubL6KxeVBuggqcYH5cCjl9QZ7WPBAUNlS54YRaTNRFK4kClYHu1Xc24B7OpNXBr1+Y9g37jgBjsynWBKp14eTttYiY2bkmcWJeaYPslnTZKVgkrDrYG4K8E/GSWtCUVJu0/UjiT3/R9ca7mV90Mf9SPTnfAC1/oyQALg31l6KcIgj1S2rDyUtWURqbgIn/FjvG2yC9gIUiGFN2bjNRcedAvkZVYemAd4Q0W8KNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC256N/JxKJg6vSPSxKK87fMdHdYgA/ZqhyUZv4R2tE=;
 b=TTvp8fdlH8l6MLEz2Avgc7+m4fvz3q1vd1vjXNAGIeFg/bmnqW1WI36vO5k1qyynSNf1XcrkXYuwj2NeiUC/nWw0EacuSUV39cU08fv3HWv+PT65NwEur5zDq9SHRlyk3nXhQe9zz9DsA6jLxX+1U/iVehcZ1exVW3nOb1dXwGjvR+wfZWRzy0cdLLMp6atcr90k3brwC6TJvb0NFWfC6DEeQ9AyMbiK9wsyqM6pqhYzigKZj9h9zfn/u6c0fa1cn6OBnI8GVRigkln6NVLDV7Sa+ILMgoT0HGRzWSWlxQLsf7mATU+JET9kEJdaBsvDASM4f3lcvX39ofrK90OV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC256N/JxKJg6vSPSxKK87fMdHdYgA/ZqhyUZv4R2tE=;
 b=Fa/nWxs+UA+hAEOlJdP+h94nGPfCfnTOHaFqBklcm7CWI/kaeA04OjIi3oI0ufEeYJD7SsHmEjbzIcS8erdd2LLKBpGbdnnC2NBZA9d2vA+phwCsX8yXgVmRvlHJf7grTBIa2N/g6ijvrpglCA3gcNGybh/6/KLfLCEORQLy1Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BN0PR01MB6943.prod.exchangelabs.com (2603:10b6:408:16b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Fri, 9 Sep 2022 18:18:59 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::94a5:3b31:5b8e:b1f5]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::94a5:3b31:5b8e:b1f5%4]) with mapi id 15.20.5588.018; Fri, 9 Sep 2022
 18:18:58 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: Allow minors values up to MINORMASK
In-Reply-To: <Yxr8d3eCoPPldZU5@kroah.com>
References: <20220906195213.2370775-1-scott@os.amperecomputing.com>
 <Yxr8d3eCoPPldZU5@kroah.com>
Date:   Fri, 09 Sep 2022 11:18:54 -0700
Message-ID: <86k06cza0h.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:52::34) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0470477-71ea-47e8-b6bf-08da928fc375
X-MS-TrafficTypeDiagnostic: BN0PR01MB6943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xwpXxsPo6DO8mBfISM6it5oxiWFaO00p5XUXNvTbt3gS9Yi0ddFFur42XnXu6JP9JCbhw7p3B3SoVlaM4tShsoKO7cEJZoOzon2tegLL5BndI1GdMq/F4Wxb2zIBjZyRpu8CXvSkxG7KUH7zv/Ry5rmvSIWFHv9zQMSHt0M6epwfUg8GiNUsqz3QN2Y1OQciC5DlG3oxRGpnl+T8Pr8XhFCK30tBb27tSWq9wkhQ9BfWBfUzqGyHPtbyqbNTTUgDu7rP4zZ3tepwuPpVD1QRdvTUanuwHOhNHju/ynPHmLzFxchxHX8Hl/z7wSyQaSZFJr7ShoauaBbkSvs5iH8/JVZzpdiN369L+Ig4iWxYQfWuQDZAadQhn4z0qDwkYvazgrFHw2Tw/+dWFc8Wbb12TNbkfILznI95qRB2UR5CiQPhjg9Ye6N8PhgTGvArcUBvnbTxK+4Y9lAJM8AE39Oo9KnqTDXyzCV/Oj50F+WchTTOh5aOkOi562EME0Jdt+7qn0oupVePyqhx7A8oEZIbprqK4Bokd3HcQmDi0VORd/RA9lsfzibCgVUN88loZtNdRsMBfxtWor9tN6TTnGlL0OWEcssDK4//Ch4AJtVhqI6Jw27hevNzOx5b9BxarK8QxgH9c5m/2PJArK4u86iQsvV+g0Ui2y/raCb+GLBE33qxcEUEBPR6+LKorvAmYCvf7Qth+bRRFQkSYGnNfLSjmZVl2L0ng/n5KZss4nHxfsuR6OCiq8QRFZBTuJeahHq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(376002)(136003)(366004)(396003)(8936002)(5660300002)(41300700001)(6512007)(52116002)(26005)(6666004)(9686003)(38350700002)(38100700002)(86362001)(6506007)(2906002)(66946007)(83380400001)(478600001)(186003)(8676002)(66476007)(66556008)(6486002)(6916009)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1uVPfjzaa9pShT3ZFK76NlGv4EwYLn0oeMIiYkuTJNkgVXT11zxrOJUU/c5?=
 =?us-ascii?Q?SP5IJWwYigAl2VSk/Lr7pEhuxftrqy31bsZdET9Th2bWU5iVnvo51T/Ks1cA?=
 =?us-ascii?Q?y4ycryYEbpTgc09uYS/PhdJeZnYy5vEhBIRJuZ/zmgBV6rZdTLS50FC3wj5c?=
 =?us-ascii?Q?AiL591tH3yq4OQd6xzMZgMF+kMVbxoF0TLVnMmEarGwU2UaI21WIpG3vb7Pu?=
 =?us-ascii?Q?S/kzWK1YciNHKJ7VOG+FvXUH3nvET9QIINABDArSvK+nEm1FfUga4AUm3IFL?=
 =?us-ascii?Q?qtM9yQnJnCGCPBggNGRkSc+DVO0vbam7SQvJABmZnDWbqO7dM++Rpf4piIYQ?=
 =?us-ascii?Q?FOrNBRMRvrMFK84xm/uQAfSJL1mk15Caj0GTvpKxi+0jZD8zQ3u4azM2d1dI?=
 =?us-ascii?Q?E9n8WutgDAKYek1EqvuKXGP875IhvkuI7ORJqRs2opsfC6NOD5sOMJ2WKI44?=
 =?us-ascii?Q?5fKqXI0y20ITXbRF02PJ7dHg6spS4aUdpjoVvvWF9HWjjb5CnGgnYCEaY/0v?=
 =?us-ascii?Q?JbCzmB5sDOWIqLa3ajzVbtyLkdU7AcaNKkWdLoHmJlc/xTqGSE4sv8VT2JN+?=
 =?us-ascii?Q?cPQKIxXJjnZ25L2yEJNVHYhk9wI2/sKUkMqxXiy+kGH61dVLAN6w1O8O0Mnc?=
 =?us-ascii?Q?Lc7aZomyqFO6QUZA0e1LsZFYjdQ3Nr6wFwfcGYVZjYy3VTBXMDMvJYZ2V90+?=
 =?us-ascii?Q?6oev7afk5uzYJtgzXZmRVkW8Y95fS1sGmbyjD/bfRtPQcgWAd3qgZIHGrTjj?=
 =?us-ascii?Q?bkrvS6GLHPfEebb1egTQp6KkIGo/xM/HnrHa3VUkjcaVih0/NZ0uF+KLaWMb?=
 =?us-ascii?Q?leLACOyJpYk+v0Mwhwkha3qhSotNvxcCnuNHJXMQDMvNUNDLAWPpz5sLn60i?=
 =?us-ascii?Q?zBTpXogblLn/mvkyxmjvXOLRHta4vfBeDITbzBaEBuXomZZmA8Y6UFlTB2Yr?=
 =?us-ascii?Q?4jj3N50qvnLCj5j8Qy4ZD5o7istWsut/s3fOAx68MsAijTvxnO2hC20+HXs2?=
 =?us-ascii?Q?I95HarUVuPLc5t+Z712s92zKOu/oI3oCTDdoVFsIx14W/LxQ9K1VQ06gVgIE?=
 =?us-ascii?Q?CNguRPrOKZZLnrAVPTYLUX+o72yAQLDjGTwjPC4sj7m+pKytNEbbB+X82Rqh?=
 =?us-ascii?Q?mUzTfOKQLRpz3L+5KhuXNzucSXOHds1+OBl/YvGjQAZaOwF1ron8YCp+QSdh?=
 =?us-ascii?Q?8HLRiHAz8qDwtZiK0fHopaFrfOrE1msjHbTzclKjEDJexU/pfd4M1msMAU3z?=
 =?us-ascii?Q?P29RRuwmEPzr4t9m/iFnM2D1jUQ3xUh1hrMt7/lrHAyce5x9kE4e2+7qpSc4?=
 =?us-ascii?Q?p756L98tk9Sg/SajvMU+aNvI7n1TucuRjKn2SLmYfHY4qyO8rs86onrhtMdR?=
 =?us-ascii?Q?xU0PnUJNfKMsOj7uRYAwzjyUFJQYyoSHAOcR+F0LtmcS/ZO1LV/Kzfn/uuOV?=
 =?us-ascii?Q?jzU8PTifN+0bherNh1Hb3cxISo0b1PoYIL5GMbl0QMwlW3a2+kWjazUNPAzY?=
 =?us-ascii?Q?7apXqdL/TOT4t/PQoQ9AQ5Z34p3zs+YoDHjlsAlqik+WTE+wFmiCojOBHgGp?=
 =?us-ascii?Q?9Id2RUf4s8eTx+n65M2QZPl5tAKkU3lXYCwLBVM9nlC46lrC+SzYnWw+cSh3?=
 =?us-ascii?Q?hH1EQX7UpkKpiDUGv1c11HA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0470477-71ea-47e8-b6bf-08da928fc375
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:18:58.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wT3YbX4+ZkuxwvVe5R3w6VOMm6IIPsh0U3Tg8rhl/mEZ1B/QLm1CJCyygPVNRbhjqTYjI7TTUaz+QQVAZVCVWnMuE0ZQ4NZ/0KYpOR8s9ZtROG3N0g4i2pe6yDoS3YyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6943
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Sep 06, 2022 at 12:52:13PM -0700, D Scott Phillips wrote:
>> For per-cpu coresight_tmc devices, we can end up with hundreds of devices
>> on large systems that all want a dynamic minor number.  Switch the dynamic
>> minors allocator to an ida and add logic to allocate in the ranges [0..127]
>> and [256..MINORMASK]. Allocations start from 127 growing downwards and then
>> increasing from 256, so device numbering for the first 128 devices should
>> be the same as before.
>> 
>> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
>> ---
>>  drivers/char/misc.c | 41 ++++++++++++++++++++++++++++-------------
>>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> So you are adding more logic to the kernel for no change at all?
>
> Why is this needed?  What changed here except the underlying data
> structure being used?

Hi Greg, the goal of the change I'm proposing here is to increase the
maximum number of dynamic misc devices from 128 to 1048448. And then the
motivation is that 128 isn't enough for all the coresight_tmc devices we
have on the AmpereOne processor, where there are independent coresight
devices for each cpu. Maybe a clearer commit message to convey that
would be?:

 char: misc: Increase the maximum number of dynamic misc devices from 128 to 1048448

 On AmpereOne, 128 dynamic misc devices is not enough for the per-cpu
 coresight_tmc devices.  Switch the dynamic minors allocator to an ida
 and add logic to allocate in the ranges [0..127] and
 [256..MINORMASK]. Allocations start from 127 growing downwards and then
 increasing from 256, so device numbering for the first 128 devices
 remain the same as before.
