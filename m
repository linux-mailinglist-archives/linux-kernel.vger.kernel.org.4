Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D257C6DE849
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDKXrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDKXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:47:04 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C54E49
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCkrm3wntLUjyQsQ1dSlImKVyTF/J2Sd5C2g93dXr8WFMYSFschc1y43r6gqGPRWn/PFTB+KFXGzl/8wnlwW904kiMl5SZFLEL3rKKkV1VPm02b+lp9vi742VMuOevN3iDi2ShPj2ibyM8d26c6PNMLQJMGE7DQm3ioRMt2YAdLZ4DGdZwc8P/DFD74n4OENeTDRcyEZx/GCJDuXRueNh4ZHg1VWk2RDbosWmaQFaaNqyhfIY+F3HJRlEg1s30mQzaX26zvE21fWViloA9dv3wsuQuWhay77vHlL1jVTKWJmBV3epZtUEvaEZbLrPALCIM2Pevh3HmWVj2xbNs/fhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxQ0gR6/qcuPJGEOMIIpijW3DNGWxdS9yb4OQlnXi30=;
 b=U576evMGahP/BMM9iaIhkCgAcXq379FX1FDNwGcNYjls5RP+UjCyOlFmlAXQPTo3rvkI+r89/zq2Kr7wCHWV0HAQ9W4Gt30y4n5WCPcUo+LR4GrmJgmLZv3YcB3ipqIGXLLkxHNWWqxyPlN+t2gaj94f7G9bXdZV55A87f02BcZQiLaeic/u1J5YtwdxuDbSqSDetbu3Ty0RiprZWSeOjgLaRzQ1oH1de5xUvM/FhLb67cxAzNdR65dDf4Glv0fWZKXzklQWtyVlvDMcmpxUjoPFJ/J7APmc2lCRjOTL0OG7gbz/N6jOs0AmiD3e/kjMQXQKMjhPCEq8rUEt7+QDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxQ0gR6/qcuPJGEOMIIpijW3DNGWxdS9yb4OQlnXi30=;
 b=UQ7ZjAWbIvDconn04saWc79ztkiFgffrnYnNKK7p2wCO5WzA332gDURj1V+vqgYSHxjtF0JzDQSSsRjSJlUqJLla/zrPlrcsqbnUEA4P/qj4VYquy7nBdyyOeNh9Af11Uo2omsOAkXHxmEjbmuhm6sGU2kbyQOSF84W9BAFf0Xb/EmW81X6G0vDvhHhTORHmzCBLm1sOuQYKasWNzy2I2IsiiVmBgG8/oP2dOnh4fo1LPorJZM3BZzRZ9Syw1wUNXwyTWd4U5fggJoYYZUdCnfYw3wOC3nF+ruFjPZpxjZtmGKkBOOpXrTBH1xOz6kltHnqwUXt2WzaTzHkA3zY9PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 23:46:51 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f9e4:206e:75c3:eaa7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f9e4:206e:75c3:eaa7%6]) with mapi id 15.20.6277.031; Tue, 11 Apr 2023
 23:46:51 +0000
References: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: find_get_page() VS pin_user_pages()
Date:   Wed, 12 Apr 2023 09:38:03 +1000
In-reply-to: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
Message-ID: <87mt3ehti4.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0130.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::11) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bed1f2-11ed-4746-03fd-08db3ae705b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyXgxzo2khM8fCMkjz6feEIt7J3QgclBoCR0gTT7kglbNitBW5DG8nYjRuq2yNFyiC5APrHa//7yBCTLiP7LnccA06EPdJumy9LN4Ei6yBr32xD+9RrSOg/A4bd3oKaeRLQcjEXhH4fYCFwGFAKFEoS2EzK7VjwgKoSKDx2avpOHwUcYl8rdOeDM05XODzrDAwCi1NKBV2zd6vPEP8C2TLhOg6GaYM8E//XZbqizawUgki2fruYN0tETlFBAQfBoF/mcTSB70VpCYjquouK7mhVwNA3xDMvWWPeH8IXazstrTRX6Ky4w9PNPauqh5Bp3NGaTXA3vzY/fqxHnrnbIs/XU4bFE37yZVG9rlCpH8UHlsemQ4OGb83iFRt+/FPNTlvpKU7TPQxWUhkK2RpRsrDqInGNITa6nHlm/hhMxCscz2Q3+Pgn32w6Y310EfPbmUwNW0eKttGY+aQZ4SfuoUkaGH7qlqbZTMby9Lx8vMnUXuf7LsFDUDikxQ4W0ZbMSud6SkgBC4gSyl0AdPdeexsVVQxUTYSdXJRg25LObNHB8ibaJx2TtfoHJkAXNqDG5tEGrkON9NfgaPsNrLGkqpbXyDYvIgqiX73TMdmQd3tA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(478600001)(36756003)(83380400001)(86362001)(38100700002)(2616005)(966005)(2906002)(316002)(6506007)(54906003)(26005)(66476007)(6512007)(186003)(8676002)(66556008)(8936002)(6666004)(6916009)(6486002)(41300700001)(5660300002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJboobORoUsTkKfSaakdqWxOAPVnVeBJt/G9Rk0RaHSTeVZmRlU6oRsMXasB?=
 =?us-ascii?Q?daWKdU6NPpwTlL90rEwkeaCbyvtAq7K/Zd+ENm0cbMEVyUFmv1zIzIEj9rjx?=
 =?us-ascii?Q?xbUDbc+RMKU2t/FiJKq71k5IZ404YxTgwAn9yhNycDhBRlY2VP/dwUUA+/C4?=
 =?us-ascii?Q?XHcnc6AqRpVLLCQdIaPWKUwHkOV2sCV1AlrJhfCVdPcpC4at6mfwl5LvI0/5?=
 =?us-ascii?Q?YpbhBjZjWnWdQMR7H7/Xwp9das7MBKtLAtcl5IdgLnTcSwiVbP4u4bXHR6pB?=
 =?us-ascii?Q?yD00NgM8KUwsB3s9Xl3f+JldXTI/mt2ldDGeOC9s/LIC/S+EeyHK9VIYPKII?=
 =?us-ascii?Q?Sb47BVILKOAvsNqooRpRxshe4osP1qnMNaEwsnMmxwt33d+lo6uRrGXFSQ6F?=
 =?us-ascii?Q?Wr2O6yT8U2dyDGykFe/nmAQRS5DG1AbA1nzFlKY29VaxtyzaMhr/g3a4a3SL?=
 =?us-ascii?Q?AFAEFqsb3WeLSPjhAZablnAu9g0o5Vqw+M1iRRQ7oRcabJ2Pt9pARjuHHyWL?=
 =?us-ascii?Q?tzXwfqPzDZ6mpvWo7v4B4Bz9n9Wgnu4ZnZ5SrpyfRIrHJKyx6oLekwA2IBdr?=
 =?us-ascii?Q?jhWc6g8NQ4ph4teXYazd4uGHd2E5XxoKwlsAReUBWBe6zZCqkm3peh7+slXn?=
 =?us-ascii?Q?7pjzHmP1QUT7+kMFl4WwvmrVzwy+kOVERp2bOHFZAk4bhyMunbrC79RBkUKQ?=
 =?us-ascii?Q?4R6yyMbYfRel76CrPFNp5u/hqVeZmpxz2IMVnmFOu+OzwZfUhuVAcf/fLjEz?=
 =?us-ascii?Q?h93z4sAEEQ3cJLpjKFiZjttpbD31FDJ3TJ2ACyqeIFvRcFd0QPVDK1nHzGAR?=
 =?us-ascii?Q?h2cqrP64//1h+YoiAieTdA8l0vJQAQq6AyO48cFFY5syINeb9wCrdY1PV21I?=
 =?us-ascii?Q?mq8LWKvKzshS4JOks7iHe7nXdysBj1Bxr3T3S5BdsxJ+qWybBiOQT9dpViKs?=
 =?us-ascii?Q?87w7GmPFaITxStc5N2V6Ry8kIg4pxrp41JB9y1wdKibG73jJ4btOPF0rCZhR?=
 =?us-ascii?Q?RXEayQ1R/tpK+Nj2DyJ2sZ6CyF1mL+a/mPH9S7m1s3pCRpVw2/yiPTbcLXLY?=
 =?us-ascii?Q?yEckLxnrUHZK/HXAKuFwQO7krz27YC83+Ep1dr2ZOP23ChnexrRgsUldPNZL?=
 =?us-ascii?Q?bpkIYYEcyJl3fn4GoIYjJLPWM5qOEiNFWn3AdEAHxn/zQZ+toShj7shv5dOq?=
 =?us-ascii?Q?SBY6h7RFg1onNJqwUsv8l1SAD+15wA6UGmJaqgF6YERQPDN7DogPIbxi/xU2?=
 =?us-ascii?Q?vbWvqEC5Umji8MgIJKQnE6DWzclsyOZUmkM4fve4InNg5/Aw4KkJwb2QY7h2?=
 =?us-ascii?Q?gdjEhm/WaTf0o/IpqcJtCRHvPB9BtSf3Hq+HI0mzQGMxlm0oezUXtv2bqG2g?=
 =?us-ascii?Q?ERGVyRYuSv4V209DxedtlHa3gLXvR8kuAne+g/1qx9/dgZQnVJl97CY1/YBp?=
 =?us-ascii?Q?jsFPAvVqT3Hnu8hkdO/pnp+ZflJh19ZLtf0H/DWpUaZbDwpZxURW1JINqwon?=
 =?us-ascii?Q?YJu6S9el3RzylPybmXddksF0iAyi4lWpiQRkY5mqFBUl33NbH39SBRwhQUOX?=
 =?us-ascii?Q?Jig6jfWcm2zxx84vp/9VWNqXouIjeT38ThLoHSbG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bed1f2-11ed-4746-03fd-08db3ae705b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 23:46:51.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1XQ9Rpwx374NIMeUgfZNYzWcywO5CodK453aZgpc73/Sxeh8mmTIqwll9zINMf2KRkl2CWUX1xdAGm2m0pwAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Teterevkov, Ivan" <Ivan.Teterevkov@amd.com> writes:

> Hello folks,
>
> I work with an application which aims to share memory in the userspace and
> interact with the NIC DMA. The memory allocation workflow begins in the
> userspace, which creates a new file backed by 2MiB hugepages with
> memfd_create(MFD_HUGETLB, MFD_HUGE_2MB) and fallocate(). Then the userspace
> makes an IOCTL to the kernel module with the file descriptor and size so that
> the kernel module can get the struct page with find_get_page(). Then the kernel
> module calls dma_map_single(page_address(page)) for NIC, which concludes the
> datapath. The allocated memory may (significantly) outlive the originating
> userspace application. The hugepages stay mapped with NIC, and the kernel
> module wants to continue using them and map to other applications that come and
> go with vm_mmap().
>
> I am studying the pin_user_pages*() family of functions, and I wonder if the
> outlined workflow requires it. The hugepages do not page out, but they can move
> as they may be allocated with GFP_HIGHUSER_MOVABLE. However, find_get_page()
> must increment the page reference counter without mapping and prevent it from
> moving. In particular, https://docs.kernel.org/mm/page_migration.html:

I'm not super familiar with the memfd_create()/find_get_page() workflow
but is there some reason you're not using pin_user_pages*(FOLL_LONGTERM)
to get the struct page initially? You're description above sounds
exactly the use case pin_user_pages() was designed for because it marks
the page as being writen to by DMA, makes sure it's not in a movable
zone, etc.

>> How migrate_pages() works
>> ...
>> Steps:
>> ...
>> 4. All the page table references to the page are converted to migration
>>    entries. This decreases the mapcount of a page. If the resulting mapcount
>>    is not zero then we do not migrate the page.
>
> Does find_get_page() achieve that condition or does the outlined workflow
> still requires pin_user_pages*() for safe DMA?

Yes. The extra page reference will prevent the migration regardless of
mapcount being zero or not. See folio_expected_refs() for how the extra
reference is detected.

> Thanks in advance,
> Ivan

