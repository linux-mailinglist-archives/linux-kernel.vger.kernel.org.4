Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF99E6917CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjBJE6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBJE62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:58:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581482F783;
        Thu,  9 Feb 2023 20:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFG1MKSphuLkif4b4ZUH2sOp40FbxqrYz39/HhZGRmRWHUMyYkexAYYhjYaP7cz/Q4ddwhDuy9zqtqNNxMWX0zzCDKX13wzqRmHV/YGMSMmK9MMxuszC+/IqfCcEnZ2cGryqIri0WSyZC5PyjeicSlq06do7sI6d+lNOlxaWJBr0SOPzmHdSm8ns6y4qNB+ZaZbaYY7EfOUrXa489iUQeLNuO9oBzRY/XInC5uUS0lb8oyYOzfdnGvFiSzuqd+IBh9yRdlhQIDnXOy1hdlz3zJipCZags4Ex6VsnU86lk5wS8uYeVjhBjMTrsW4MfUE7ODQTDOc6U6iykUwh0HKlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJnTL4erVwsF2HP40iwReEsEY+8wLkUeZ7c5iGIB0lI=;
 b=DN9Hhx6W9PMrKad/pCfvbYCKShWbC0wLUi5ciobq7lK2Si+CXmC2ggKUfwCVg5GY4yuHHP1+3iiux6NtFzqvtL9PLAsrtjdOyGYnLZr9ZAxMcCh+BwFZSa/jhCQOdlO6RHxAn8zbPoTe7klCu4q0BM+Lr8pyZKtAteI+m4EdVTlJyhYp7RvwiI6/Qdkzck6MtXLeyFmZ9Yzspad0Ug3UyiqESJ28t4zIK0UXowrlj17m+X6U9OxwQm6pMkHCkeR+KQpa8cW3CNN+tqp9rHX5IpN11emd3lH0vmncq+BLjjIUgVk8QqJx+6a8gwgqFKoYUJLBCocxw1u/2OstWu3zBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJnTL4erVwsF2HP40iwReEsEY+8wLkUeZ7c5iGIB0lI=;
 b=OFZuXiINOeQ8wCqn6vWX70awlN2t5AfNnnv0YDaaKveC5mAC8XYC83fPM1W0gBD2lJdnGMKjEoAMNOBhQ1TSYGlkx3FrDzANFiI5IyLUqOkFt4RsN2GyJ3vyux1jm/LaYnQpovGyITbsplvPVDTai8WQKwFDRFtrYVRMe5DA2v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by IA1PR17MB6073.namprd17.prod.outlook.com (2603:10b6:208:3af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 04:58:24 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 04:58:23 +0000
Date:   Thu, 9 Feb 2023 20:27:51 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, corbet@lwn.net,
        shuah@kernel.org
Subject: Re: [PATCH v8 1/1] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <Y+Wdl6D41jSdhK9J@memverge.com>
References: <20230131144458.1980891-1-gregory.price@memverge.com>
 <20230131144458.1980891-2-gregory.price@memverge.com>
 <87edqy1jzf.ffs@tglx>
 <87bkm21jxa.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkm21jxa.ffs@tglx>
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|IA1PR17MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 80664179-0d10-467c-3f41-08db0b237001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDMDgKwfeERld9RGtSeg3ZlfvzE8lkzRSL0OY83ULc9IcATPVxg28Y9Jl2aBwxjOceVQGCgUH2rSAteJvEBIiXrpsCfmw2QwvDB5Nmse6tb8AZcXy0MaXGWaJO3T8xGQyOmvKdK8GA/y1hMPyXfii/oX3Lo7hiWjps6WEMdyPJ8wEDnmemFQYbxSva9bkef+xFBIOzhtRbpV7b/yw48ZsPWRVctKZJv4AyaF9HmaVh7eV07sGJk8xwuV8a21LVZ7RZ03SUZffpTNWLdZtETTJFrS+bxyZdp45z7YKQXQ4K5CLPPXjbRYXgrnCLe5z+k/qySPzGYsT4TMjcCUlmBwobVjXO8i66QW+nX1IvJpqHqwa7zaxeBo+/+nD/dmTrqa9yGb36wg8RJmfxjRsHSlEfdPFjf+Q6dLA1/wAFOVfsX4b7uSmDO49+v+Sxk9lT+sDGqzcnxDm6+Or0nGC7s2z20EvDkIpEC3qzQNT3DMNSGq0X2FwbFhzhBEVD5utcnBhuYUYean6OxuCZFBkiR+LjxaCalYkPSiM7A2AisUald7XpCX7K265ayWEm6LRBgBopJSeBm1HDQqov7gK35KiT3oGP41QDiLNYDEcOQeonRv4wQd9Ej1ofuI+4XQD7z92Tz37SuCOP8wHbuXU4XUsjWAx+VJypZ1/CCYlnq5yym/fph09ggPlp1L3qtxCoGv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(39840400004)(376002)(396003)(451199018)(36756003)(558084003)(83380400001)(38100700002)(186003)(6512007)(26005)(6666004)(478600001)(2906002)(316002)(6486002)(6506007)(7416002)(41300700001)(5660300002)(8936002)(86362001)(44832011)(2616005)(66556008)(66946007)(66476007)(8676002)(4326008)(6916009)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzSPMzcfwbgzHg/IBXaoWH9JxQ1MBhXiivH5yqODzHeUxUbSJGtZRot872Tr?=
 =?us-ascii?Q?928ieD2un8uKPA9UPD0se6bQ4TaJleKFCq7H5xNcA0RtxABGK4yQMj3qbHew?=
 =?us-ascii?Q?lGMb5DkQuXjMxYeQZIgszIUDCsTpGf25n6ZJICU8erBd/9nvvixVo78N2XrS?=
 =?us-ascii?Q?sVmSkkEeigAirwT1bB7E8dNcvwFMJaJGHBUwUwqIezoBMdRgKPgMVM+NjMfM?=
 =?us-ascii?Q?kq1SJa7R70yPdQ2Kx8IZKSsoa+oBOpf40KV71Wt5ODYW1whu5niisxMC+rZh?=
 =?us-ascii?Q?+26uIWGlc2WaHlhVlWZQrKXnLGUD83BuN1dU3QCOEYVgpCO/NJEfNXxaYkwG?=
 =?us-ascii?Q?29CRbqAWPGUu9Hg2mVTF9a07aGwsDjY4FTrI9eiQVopk7yme7WHZmwl4FjcM?=
 =?us-ascii?Q?SExqHZNdPKrGq3XmvTtP+tqdm5G+xVe1oaSyvQSP3y8pZKnOADaL2Ykg1y4B?=
 =?us-ascii?Q?AjWnKK3zxcqNSoZE/qsA8DXychVBDBAywmlwrjKk/0tEaSy8N8fIDrPHuNFz?=
 =?us-ascii?Q?J5eTPNdxLxJMQApNSMTR2+Ti18zUEoTIEpHA9hCqXPj1EBb3VFiORiKU2fc1?=
 =?us-ascii?Q?9uCiI3LRfttZSWzGCLv6MrABRtpdPpP5+VpkSni5DG0mx211U6qBQMnF4prI?=
 =?us-ascii?Q?eoIinHwxcbWo+iyIdHI2/LlQeP3TUVltUHqFyfTN/0fZz0Ly1H1SiFTjt7Pa?=
 =?us-ascii?Q?YLLNpj2gq2fZqgTJ6kT01uL6VYWFpZBiRPvW00KyFbb6iUQ1XNZldPSd+WoL?=
 =?us-ascii?Q?wkCftgaw41Py56W1VvVNA8APozz7QpaitqYPfkil2punaMCfFmfBXPJyYcH+?=
 =?us-ascii?Q?3jPk7UJsmQHHmdcbb82qwUf1cwU6njugT0xXQ1GYAps8WVm+hzoUZKQwwATk?=
 =?us-ascii?Q?asn6B9iDV7r8yX44ONShjI+w3wjBJgarWUDGxgKtYpWCuJT1BfrpXxRSji/W?=
 =?us-ascii?Q?L4ixtxO4E/iatlJST6poP+x6+SptM3Efh0oqFxFP4/z+V7QZZNkU1mypCewh?=
 =?us-ascii?Q?5ByNE8luh0mo4iU5435hHvdUdWTKWnrGbOoK4x+hHP6IrfswuRofGo0OuhwT?=
 =?us-ascii?Q?l44WPjYzcVsbmhZmfedqfu+AkzuNSWgNArcAO4t3ABN8WDRPAXhISukC7P42?=
 =?us-ascii?Q?Fn3pdr8fMNm6dbRuIQ6enBKClFyMrAhvcgZioX+athhcO2kp4RnAgI74oYPo?=
 =?us-ascii?Q?b7++AFcPQezTPGfcogNKdgHXHItLWJzb8Ck7JGNhbyqeEJ2mwJghS7M3h25t?=
 =?us-ascii?Q?OxiRxQK9q8C5fbH5C2q4F55aO0XTvy0KhYwFAnW/1/XzNB5mjwDLAGkJ539m?=
 =?us-ascii?Q?oIYD9ScCCQRRG7S7tslr359ySJTM72dOs02d2vbGmK8jUd6cJsFgTVOhPWYr?=
 =?us-ascii?Q?F2BpBcVkIpdQzx4pnEmSlbrXr5FafVba4v3P9wqLv4LuS++dq/O5nbnAALDF?=
 =?us-ascii?Q?mDOKS8GVK+tzFq7nMqPKGkCtMmYe1jmv4oXMOFT6qezczVHmp20MkGbz9gUT?=
 =?us-ascii?Q?qLklMogAbk7L13hxwmgytg9Mk7mTmt7C8om0hPadij8/T59zpTHT1PTQC37V?=
 =?us-ascii?Q?DzeG7MNRWZKN7Z6/cKPi6pTLgwZBPNTWdGQV5K8hChISYCixOJoVXq/40q0Z?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80664179-0d10-467c-3f41-08db0b237001
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 04:58:23.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie6qbxcC46uC+ipn/gkwr5ZTMPjXu2VHDRBnGRKFkRiB98kUdB9cc4db5uNhef+o/BPmPsTWVVEVeyqzeWmkCylhJk0QQPqxvnPsDOvKKE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6073
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:46:41AM +0100, Thomas Gleixner wrote:
> On Fri, Feb 10 2023 at 00:45, Thomas Gleixner wrote:
> > I'm neither impressed by this patch nor by the reviews.
> 
> I just noticed that this is V8. I'm truly impressed now.

I'll address your feedback, thank you for the review :]
