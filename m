Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C4A714131
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjE1XHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjE1XHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:07:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2CBD;
        Sun, 28 May 2023 16:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+pWCLnJctL3m1MSYxb8kWaEVK9c2K2N1xbGupzyrLS3YPyVcQUu8tnQKhaQr9mDkIh52kgQJ4xE0/Q8zpKVAU5tqr+/ABgSa4xb0ccVXHOo1K0hldyX8WltMqn+OlLlmB2bGRGplLzyRRdnERohD/qPWlk4YKrVMAa6lBXgXmfAzbal8nIpuECJV/fb0Kl65lEXPAmLtC7KV2l/MCdV8UUcvnFD4791LMuaqMAXRRwpQQr+SCq1gNIBjvz4+OdC+08mCgqvSl5BAl4n34inW2SlWARrdyHlHklzJVKLgsRSH9ZW7aS4QMzEu+rY3pwLkrXIVYrbpda9nbfy2ZNkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whttZjuMLBKtK4pt9ivmDU7tlWZnt6gbrj4fax/kmuY=;
 b=h/xd0EMOZA7ohNTnYVonf6OPp9o/wD466JmaT7yhW2ipjpoEcVJKXA3T7rsnbN5k1MzX+kGwJcN34wLIUyEX5Jbp4reZYuAEmcN3/Mu4az5OYwf4BSDEZjUXcwmwTrEt6d7HUcm1A9SBjgs8TGlnL4ayCWxVHbjidcDiDDdgUQIMbxSfTYD/b2J2+x7iSsFrLTUppFZh9+XH3uD9mfU92048+DXHNYtBpiOZGCv5/7drK78zcG1F2R1FO+XRCPs60WWz0nIdHsKAI490//LRzXsOwFsklISXEdtOmRgrVqikn2bygQYQx3jaXx05va97+ylfT7xb9cFPlg18WaOg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whttZjuMLBKtK4pt9ivmDU7tlWZnt6gbrj4fax/kmuY=;
 b=c4eBu5zjgyQvzyYup+0EDgREO/HF7KHqBoSVQ9SSjCt/6M6sfc6knQvtukcRjI5YZsKD9w/mWeTd+huTQ3Y8r48NGjcNpFuPhG96f4+qsObbJGIkqCwzHQ4OQVsIuFCgcbBlxTkmKqFWOufuyallJoRrGoSrDK0XWUj33RlSPwyQIJ3a/VXMN97JqdPw4zDs38XM2vnTWU6qfVXOyQN59UlVl166Upv5Hkt6QdzS2IZJ5hh0i0312KVvlqWtDtqLNunV3q1VbMxHAb/5cdqkqA0ZeDYZypGki1fBq6m03Hj6fWjedrrXOL5pk3+ZgOK0VsTcUJSJp/732Cd066bh5g==
Received: from BY5PR17CA0045.namprd17.prod.outlook.com (2603:10b6:a03:167::22)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 23:07:42 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:167:cafe::45) by BY5PR17CA0045.outlook.office365.com
 (2603:10b6:a03:167::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21 via Frontend
 Transport; Sun, 28 May 2023 23:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.20 via Frontend Transport; Sun, 28 May 2023 23:07:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 28 May 2023
 16:07:33 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 28 May
 2023 16:07:32 -0700
Message-ID: <0dc304c7-c11d-d4ce-a6aa-c0992ca8b9af@nvidia.com>
Date:   Sun, 28 May 2023 16:07:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
 <ZGf1hV7iEQyqAim5@ziepe.ca>
 <1ca47b8a-292c-47ab-aa6f-ca24fdfc0d3c@lucifer.local>
 <ZGiEEPXdAMnKqkqx@nvidia.com>
 <0bc9dc2b-0da6-4d5c-96af-e21aa287eecb@lucifer.local>
 <ZHHSwRzksE+KukTK@nvidia.com>
 <617c2e26-8450-4a35-9b47-c0482921f030@lucifer.local>
 <ZHN/u5hefVwsIdDN@nvidia.com>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZHN/u5hefVwsIdDN@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT035:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2d4b8f-556b-4c69-999c-08db5fd05764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0muwWiNaUzfubMlgf+VpwKWd6tyfw4ilPQ0J1VsT7Y2dyX3eOjZ26DIaK19jV/NU0GZd8dFjFBCx7eyFneb3EFK9zhznmnYW9btMIyTgwpeJznZ4PeG1wfS60l7F95BR7AAbsyyYRs4sdIdDGYQDglAJL01Lt8V8iU38vz0eJ/vZHBXm4d5nt9rcvzbyezLkgkiRYfEAasmP2OKlsW184bRehAWEjURfGM1RmECJksUFUPy/gvSBOksjWtiriPPgSaeUdSdBEFAYw8u9nPmL7kmXohwOoVWWZkTDsi4QlSPIuDYkN/+atL6sZbf3R16sf/i2zAKPTXM7dKRolK7zYJnPhAVYnYmQxUB6RgjPq4aO4U4AiAg9Bzg8/Mx6CQTOtxHibazRAnbcRBBLq/DhidB1Chqtl50gccUyhnYRlMCTYiSFV2NEmqpnI5H+K/n/4GZLQWZyUgyqNix9cUI4fVzSraqvxp87ogOqXNzIw9mCeBrBuyHfz48YKWxnYcFawbTUSCSUxXoqyKQ8a23QtGmp4tRI76tuH6k+J4QfiFduFlfLzLtFrMs+gD/ExxcuEdMQhmmoGhPeJ5+m7QVerxAaKUnZxaOf5KGc2TW5AvvksY88WUwuQYewr2RO8WgFx20NdkrR7qns5eab9dm8Wt19EhSY0awFwSDEVj4P7WNb0dU9ZC8wmce0WFtzaREbsVZKL6WtRxsHbe5gU1ds2itCj145DIWlVbuuvladLW9+e1VzyQhBJJlOfFFaVgrnP2EGBsLj2cktG0x+XRuO/Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(186003)(26005)(53546011)(316002)(2906002)(40480700001)(40460700003)(5660300002)(41300700001)(36756003)(7416002)(8676002)(8936002)(478600001)(82740400003)(7636003)(356005)(36860700001)(31686004)(16576012)(54906003)(110136005)(426003)(336012)(4326008)(82310400005)(31696002)(86362001)(2616005)(47076005)(70586007)(70206006)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 23:07:42.5697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2d4b8f-556b-4c69-999c-08db5fd05764
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/23 09:22, Jason Gunthorpe wrote:
> On Sun, May 28, 2023 at 04:13:44PM +0100, Lorenzo Stoakes wrote:
>> On Sat, May 27, 2023 at 06:52:01AM -0300, Jason Gunthorpe wrote:
>>> On Sat, May 20, 2023 at 10:12:40AM +0100, Lorenzo Stoakes wrote:
>>>>> No, this returning 0 on failure is a foot gun. Failing to pin a single
>>>>> page is always an error, the only question is what sub reason caused
>>>>> the error to happen. There is no third case where it is not an error.
>>>>
>>>> The uprobe path thinks otherwise, but maybe the answer is that we just need
>>>> to -EFAULT on missing VMA and -EPERM on invalid flags.
>>>
>>> I think uprobe is just broken to think there is a third outcome. Let's
>>> just fix it instead of trying to pretend it makes sense.
>>
>> Sure, will take a look at that if I get a chance. We can at the very least
>> adjust get_user_page_vma_remote() with this fixed.

Great!

We've had previous discussions about getting rid of this pseudo-tristate
errno in gup, so I just wanted to mention that I'm also glad to see the
movement toward, "return some pages, or else a -errno". That's progress.


>>
>> Do you feel that a partially successful pinning for other GUP callers
>> should equally be treated as an error (and pages unpinned -> return error
>> code)? In that instance we'd need to audit things somewhat.
> 
> That seems more deeply ingrained at least, I'm not as keen to change
> it as to get rid of the 0 return result.
> 

Yes. It's not just "audit things somewhat", it's more like, "change
quite a few call sites, some of which actually gather sets of partial
results in a retry loop". So some actual coding changes there.


thanks,
-- 
John Hubbard
NVIDIA

