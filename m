Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B05E801D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiIWQoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIWQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:44:36 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C6EE1F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh2EhHwnCwv5wkhN5zNBzgsfBSX54Q3A1taY2fG2dBuqKnz4Pvb4JKEsKN764Nlp8yyyatxFjcIHS8gkPWVYqmbR3ZkTLyKvo941SyrEV+NmXH2eaoCLJzixNBmG0dFP3EaQg4a3+hzc7zDhOLXco3NNzIgjm+eiEnDal+A1HB8svj38PGu0DI0emaOaC/IJUjoBGui84I7q7fcMW90ZDsSfsyOrfdhSOLgf5gHx7pmVXTVIN+RWQajVmwkvhJqbnsGpPlxbBps1sZQ/mzaEUeg1o62OPxn0kmz7Z6v7a42n7R1WZpbcX+ZtaOcttCrqwdA/EFU42lDCQvrpQs9OwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3u5UCXdv4NBiOu8wbQgtCF4UFJyVZDgBqG2DEFLgffI=;
 b=BtwMPtiLkxNt3InmjG9iizU44ZrCF+oWnt6ZmL5UJOD0stleZPUXUf4Zv6j7IId/aEoAmsP0QFmOK+UmSjif9mVuhpDHQwZjt8onMdzIxAI/bAu79yL3E/rLV89A1sZ8Nc9lCKDR4fGg4ifVgcgfTVxHTtvofmdnLwvqMETBEv6j4hlDwjVwMSo9JbJYU3TutuInHrbHDsaoagtoizmyjCceElR+MaoSu2xyaTIkA2kSDkZWhs1F4EveRzKmvi9N9JNzNJZ86ZuF00hNKtqIlAmsBfJs6vcyAxZIMA+tnrWb2EgVj9V5ApyihFEjecuZW9whBV409rRJLhTPuiatAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3u5UCXdv4NBiOu8wbQgtCF4UFJyVZDgBqG2DEFLgffI=;
 b=eRJFYkJu1ZnTghI8P9DaquwPE3F9QdecbAuDB0wFYEgc4BTeqne9lONxFDmtLS5blYYQr842r/IE1VRZQKTzTZEPyc8Hq1jH0s9VzYvLZdGm5Bgc8ix2IzAhj1nMMDQsKD671Ov89vnuzQ5b45BuveQDrxuCEAfoL1DGyILzLR91jYPrMPZLOO9GzBWCbYPA+3hzxqKbwN27V+fWbRv9c/bjj2lSDcxKJkrPszNp3KGVF5CsUGHWazNin6/Ig2LmHjL8xmz9+QzD9aRAd/QZmVfRG3mmXImWOX2Zyy31iDjaXbDOYdH3ac6hyz9ReYBW98snmXyBSZMWgb7kOJ2tDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 16:44:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 16:44:32 +0000
Date:   Fri, 23 Sep 2022 13:44:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yy3ib21g/7QlLn0W@nvidia.com>
References: <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
 <Yy2cfppqkf85hPT7@nvidia.com>
 <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
 <Yy3QpOnsNJQ6MykN@araj-MOBL2.amr.corp.intel.com>
 <c3fb5e4f-a906-bdee-7b34-533f36ba59f7@intel.com>
 <Yy3UWTLdIldKIfgu@araj-MOBL2.amr.corp.intel.com>
 <21e4a613-cf21-6d90-17e7-91aa960bdafa@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e4a613-cf21-6d90-17e7-91aa960bdafa@intel.com>
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: a389635c-76ed-4d3a-3431-08da9d82e3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFVVJSSq0ikNCASlK67vWVU9k1n8dhlz+IPJiSzn+Mtz+Wv/2FPoko8OfNexYmkMCiWdew3ACKswUYjmf/sWRCCWn7/9aQofdZNpFwq8rnoaAcvD526t7w1eo8sykYBXLfyWLpwK0l1Nx41bfDpSX0yHBdUIbx9mBHp1N7dfcIiJ0nvfeqz5qyMOV5GdP0WmkVzAgpRrCYl4xGTvXHoyf3dA44DRWEgRY38BY6DSXIa6dSGehsqPawYvzX5YGoaoAyvEJhOKVDiy4BT+tOG4SQmCpevbv25QLV+d49Qhzz7pQveb9pmZfMCZ2Ahg/xPChl5ykOK5R4erMe9Smw/IHfZh7obZ9e4vGd9uqhiQM1avcH/M+Rxfq+/RoShsBSObs6SEQJ0x5n3bc02yGEQ//Qw/knO5pMQ1jGthTzneqAyAYmst6AILBnbkGpbgLY8MTKp1SH459LRcJcU77KGH7bDZQTKcR1w7hf8kfEivcw0uNHmcS/kTy01zdHxNBsBXqjMdg1Y0xfYAVAGQol0IIUPZnB9CrUH+eBSLDxihTIURo+e53nV6f6DrHtMxqq+zBahnwefmJXCSzQAMvnsQtXNI3xoPvOnxq/Qy6miTh2NWwG4Fp2G/6SJnLoFTgkt24c35M7MlURXbEfbx+DDM91aMw9Qx2A4sDUYsoEvCbAAHg4ST9m8pG/CmmewvnDoNAmlsYd+6uItSDTmy1mjslA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(38100700002)(4744005)(6486002)(478600001)(66476007)(2616005)(86362001)(186003)(66556008)(66946007)(4326008)(2906002)(26005)(6512007)(6916009)(54906003)(6506007)(36756003)(5660300002)(8936002)(8676002)(7416002)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enBTnMfcxECB7Rp/YQqLyo0awajBgGSiYKlhubfXfrDfnHB6pXc0ptYIyHAh?=
 =?us-ascii?Q?bZnxccQjMRp21FqRBp8cF4CYdRQ7mHDfOsED3XXLCEBoWWj1GboLPshQS6xR?=
 =?us-ascii?Q?tVWeemvrqjnQq9w+vqL2M3QIDM+fACC2FNpxlm1iMAfZBgCuEXC4sCa0EQdr?=
 =?us-ascii?Q?232HKilCD+gCL3h3V3jL2t6sL0h+uwgG/zxcs0olh/zmlHez2IsLFRutEjRQ?=
 =?us-ascii?Q?3eFCF/dDaPy9NKKjlm6ChvxPhfq4gHOZy+Cla+3MklGrROEl42i7PhKLCcY6?=
 =?us-ascii?Q?0tRPZStuJcLGh8l1o68Cu3tTt7wpLg/48tzKwYvyrbo7Hu5fYrZqLOvnv+jU?=
 =?us-ascii?Q?9ymeLRTsd+x1PZxBViTnMhyfjQ6TAWG8FlJdN3xAsU5bu+b11ZZSWz+InoFO?=
 =?us-ascii?Q?E67xATcFwqNMZt1dUulHWpz8VDq4vzwn162K1rfPzaDzxvaHdfw2c8XGuo/q?=
 =?us-ascii?Q?9RstLhFl1gnK6yiXWY//TTrBRD2HqT0sj9m/0TEbwNsiZqy/5PiI173crzig?=
 =?us-ascii?Q?kaiQJiqiihQvPtEcO84gLNxaJe0FliSZSAB6V0A0VCeuAx0Ck8/uvSd9K0rA?=
 =?us-ascii?Q?jAOWDQpWVwS11A+57Yl7IM/sD5uRyVhcbLP+dvz7CVPcIxp2rXXvId3GREaq?=
 =?us-ascii?Q?Kf3+ODc1apvZ3AbRRTIwEOEeO95YJDhChRMIhWG3/3PuJzzXCmkGxCw0z3tE?=
 =?us-ascii?Q?nhkkNn2wTKb20EbTP2Y4hUh3ogWbweVX1e80xwAoSkYeZOC83yF1TLLPpJkK?=
 =?us-ascii?Q?A+2jtpCXqgC2uZA0pPaJ8m4/mrP1kvzmqJHEsZtXZtuJ7uLZLp1JxRNucU8U?=
 =?us-ascii?Q?vV5X3efMt6y2q+fB4pjmuIMDy+r9hPkMRSUInRjdeyMsqr5gk1m/QuwIa5EG?=
 =?us-ascii?Q?nu62vn3/R/moZd+qNUlRLZSN/4icg69hhgoZ01KiCTLenrj1dY54jRRyLsaN?=
 =?us-ascii?Q?nuVD7KtPnASZnk5Ij1ShaYLumVwxLjFjbiVbEmZMUBx4nIcpNpXz3v55l7/k?=
 =?us-ascii?Q?7L0uVEWprCznwoKkuvxMJr7gLCDEIz3buDD5aTxwjP9oJHlJtW0aDJ2A5FMu?=
 =?us-ascii?Q?60sRzyA2DU+qbNZzsbRkUEnh4b2UiZ5YBbq6AMhHIRsJbxjinCyu84nsBEoQ?=
 =?us-ascii?Q?he82OrJM4vFCLf8DnT3MJfB2hnP5XdMh2yS4pddDt6C23zQ5wP9nbJbcRk9l?=
 =?us-ascii?Q?hLgqStJY87fcVquJzGHGZI6LZMLPbKx4osoFiBRxOtoLxt3s+5OKBaGH2nNw?=
 =?us-ascii?Q?3yYHzsvhisJU3gf8nexRk+iUpaTrYsNcTv/ITkkooIktfjWY9mLkdFMj4yAl?=
 =?us-ascii?Q?SeyotTLZBQfNWyj0pCPgAsxssuveL6ItFecPzpSkXn1G6K4smRV/I/XvUVLF?=
 =?us-ascii?Q?iZWS/4nvW8aW6UQOfsUj0EiNXSHNKu0MYniTJrPnP4xGTxzUYrH4th8UfAjx?=
 =?us-ascii?Q?n9rQQDwRNqPcaiXXOZ3tfi5z4O/Rjy7PrPohqFmE8wf83Iyp7KKd/cH5nkoK?=
 =?us-ascii?Q?RmunV36rZhwPENlaKRXGmeL2Flrd7O2g5n/Aq3XepWHNkQ+NU9l7GOnIj2g8?=
 =?us-ascii?Q?Uu6X8iGO0MoZhv3MHsjMUN9NSTkKgORen00QOocz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a389635c-76ed-4d3a-3431-08da9d82e3f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 16:44:32.3700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6kuWVBk/wz+X5vMZ/TlZHNQa/hIIY8uqOlS23xFxIMJ2QJVV3dh1e1VE+Zl1AJD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 09:23:40AM -0700, Dave Hansen wrote:

> After our private chat, I think the answer is that devices *have* a role
> to play.  Device-side logic must know how to untag memory before asking
> for translation or even *deciding* to ask for address translation.  But,
> hopefully, the communicating that untagging information to the device
> will be done in a device-agnostic, standardized way, just how PASIDs or
> ATS are handled today.

Right, that would be my hope, we will see what PCI SIG standardizes.

Jason
