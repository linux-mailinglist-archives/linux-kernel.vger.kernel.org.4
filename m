Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0B66248D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjAILrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjAILrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:47:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8489BDF11
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:47:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LldrbjKBpUolTukmZ+mld3kNsKKbWAzzLGxSQhv9oMUz2B7zK7279BY9cWDWPRoL4ZqBARLJm3dVhJQT8Q45hTElZTM6jLXNpGxYcDlP6x3xKNKrEUVtJP2Nu4EXBCYEEOLqU5dGA6zuau9B0x/f0enM2GEpIq6FbhSAph4K/KH0nCd1l2tQvyzFam6U+W0hJANUYxGzUDBfHydLmGza8xDQrh8nk7mgE9sqsu6YWhDT8mKYZlCiWReP18KPEe8ncEDXsckPZzSdp9dd9GrTgfZBN4hroSL2O3GAnuCRBIxRx5dS3bPk/cPmKl3MaJlAvRh+hmt0amkigfZB/CGu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFdoytF+SlfZ7UkU87+YfEll6NzGTxfgqnWYZSYfL1Y=;
 b=lowzs0AiwX7cm/3X9nGzv0aF3SnBMLdOyxrXstuQZf19J5+3qUiVAiMB9f5e7qfPWdWULxbKzejsW/XgmQ7LOdx6WM7kzWNsxl5/7X5FlPGXnU5f2RBchtQAMdRkZA9iZzU77yFXXn8uTP8v9fLpdO7B+7pigok+TN7RJMLTXsgLsvdMrzTLQPiAs54ghZKZB42VB+qbLJNvK3CmluXrAaN3vAMUWUvFhRmJTZ8OXz8/AVm0b/+mqNqrZ+DyqYbNhRoLDAtQVe/5H1vH3PHMit9wex43u3idtKAb09P02Rku7AhdLUCtBrjzLul8yzLXlqZyqF9YDpK24FmLrTmfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFdoytF+SlfZ7UkU87+YfEll6NzGTxfgqnWYZSYfL1Y=;
 b=fjBH11mmSCcJUnzFW9hUFrAN28psRPMO1S+75BX0Gk8OzdM5AG4U3yGQJpTA7G1bZhLFBMHO8q7lznRpyaV8gfThlnkTYxUDaiG05lnDreibu8q2ncJZkHtc+wVLZR6YfhP4sgdE8yzeyQZcjj3h8+NbA8IRM9uos3K1I5MDcwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 11:47:28 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 11:47:28 +0000
Message-ID: <33da0e13-ace8-f6a6-fcf3-611410836969@amd.com>
Date:   Mon, 9 Jan 2023 17:17:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 01/19] iommu/amd: Remove detach_dev callback
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-2-baolu.lu@linux.intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230104125725.271850-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::33) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 934a1c70-0bc2-47eb-508d-08daf237484b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6WKzgRc8ZCrhy1H9EUlvyJRvn+kdUHbb+cycDW/lfLjlDJqjVEpIlqPGKKutXxqx8xpqT7Si3Zo05DFnXqMpcLXUMvWz6Ubx+Bj62aSJGT8pAf4X4DDdut1DwG+hjJfyVqWqPZbF3VR/AgFOI80mdaaWZvladucDqmus3FaeBJMY81flIqctM/VPW6fQrabZO58uOrkV6o7D4PJp6rsI/2TsWeAS2fdTYim3QyCeVLIqobiuCHvmC04c8SffJxcaSWM4ZKcIcnOF8/3MUkpb2AJ9Y5fJwlrQsO5EwZZMThdlCR+WnvotS2aeyQIPe/U+0uDrPlOE90fMESGHtom2zOVKlnmI/MpkDKuHoKJ5Fhjfi2qmTewoAZf7h/Ur8Rd94i8k5OV52w/8GiCnBq6zrZHb0K+XtBDH/3u1DOR+L2eVwO5pdjVqRNqQGXl7Fz5xyxUtfPk+faHtmkCL9F9lvUI/d+yfB4cwF6pv4a9bRwQW40qNmc/XfnY5qOFhjifAoiqyBLRFsK00dUKxFMA9Z8w3CYWs2BPXEaIHLfewDLb3PHatcO/CTR3TdWf8qMZdXN+oSKgScYsOqhxbOBxccuB+YJZVjb1HEaovqK/5tIs9bDR5jdzGgbHoOevExnTTwTDY2VqcHMu1YD1bbfZ5cQbREHV6tD/kagAKbqoKBhVG2R/kN0ycnMvRbk8OYHEytfbgyg0e9vKTAdFDqt2pG0AO9Vd5czEJBYjh3HstsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(6506007)(38100700002)(31686004)(53546011)(6666004)(2906002)(6486002)(478600001)(2616005)(4744005)(26005)(186003)(6512007)(5660300002)(316002)(44832011)(7416002)(8936002)(36756003)(86362001)(31696002)(41300700001)(110136005)(8676002)(66946007)(66476007)(66556008)(54906003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0x1d2haVVI4K3FEUHNVODg3UC80OHE4QnVXK2UxMmZlaGt0NVJsRnlxOFUy?=
 =?utf-8?B?NitiQm1TbzV5N3JLc2psazhkSVVoaEpsemNsa1c0Vnd3dnA1R2R2MXlCN2Nr?=
 =?utf-8?B?dDFSZGkyVVJSWlI2TE5lcVNtR2l1NnQzM1J3RHBKMkVaMTlEZUxFZkVyYm1O?=
 =?utf-8?B?MlFaWVplNXMwRjExc0VRMHZ1SngzYUc4T3laSnJOR2RFVTE2d1JITGpwL1Qz?=
 =?utf-8?B?bG9XZU9WL2Q4cGhVZ0JwL1c4YjhCL0Z0aVlzYkVqeDV0dHlEMFNwbmtteGFU?=
 =?utf-8?B?V05lNWNkRUNEQk44QlVtOFphc09Nd1RtWHhGYURjMlJjVlhObnNBaEVLV2xi?=
 =?utf-8?B?TjhGc1lCaCtzUVB4OGdMR3pSY0k1SndIRGhCOGFSVnlhNnMvOG93YUxDVU5a?=
 =?utf-8?B?VEkwczlPM0wzdEU1amZGZi9iZWQyMmpXeThuTDJZU0tQc3N1cGh6Rzlpb3VT?=
 =?utf-8?B?TDdKWlR2cDk1dlZYdkVjWXZBYzJac0dEZU1WQ0ZDS25lQlZtYjV6ay9SenFU?=
 =?utf-8?B?dUtRdEN1eFUwZE5xTXNPQW1UclgvSDlrb0dBNFVkcVIwWk1aWEF0OWpUSXNa?=
 =?utf-8?B?ZGNGeE5BM3dlVkhNTlc0WDM1LzE0K21iVHljL2hiSVdsaVBmS1N5SUhiWlgy?=
 =?utf-8?B?aG9UYTluYUV1dFVXNStScnE0M2J6ZDdmZTNrYXFjb0xSM3pwWFJyNTkwVXR4?=
 =?utf-8?B?VzBJVHB0Nm52Z3pwbVZ6VXI2TGZ2VURiWVVUU0dmbEd3YkRSQTBHU01WZHBJ?=
 =?utf-8?B?bmxZM1hRbFBOM2NORFFtSTlIRjNvdVBUV0U3WVJDS3Y5QWFaRVV2TlAvdzMy?=
 =?utf-8?B?R3B2Si9TVUg0UWVtSjc5d2ErOWlMV0t2bjNEZEhqaVZXbWtOWHdTOTdheDlh?=
 =?utf-8?B?K29YNitsSW9KaHJEcXRyb1QwOXBmbVJ1ZlAvZnlHUjlEOWhpdnpSTC9jT1J1?=
 =?utf-8?B?akJFdXBXRTNzQy9KT1lhay9QQXk0Y091a0psMXBFUHZ3bXU0TFRrSFluYUlK?=
 =?utf-8?B?R2YxVUMybnlveThZNE55OERBYXlsQkt1YWk4RG5hYWJhQXpYUnJGa1hXdDlE?=
 =?utf-8?B?NnZWbnJUOU1KUWdZSGUwdzBSN1NlaXk3cTQ1R05OQWpUNGNGUWI0VEpVMFpr?=
 =?utf-8?B?NmlSUEJibDVqYlZTV29MNkNGSXg5NjBCdmlqZm1JVkFkaU5ZN0NSTmVabE55?=
 =?utf-8?B?TU1nU3hBL2cvQ1B5Umd4TDZvVzhnSmRxdUZIMng1UE52dGR1SDR1dkFDUlFp?=
 =?utf-8?B?Z1ZtQ1VuY2tYR3ZJV3VVKzdwdWozbG9ZYWNYY2NQamZUczJHTEVVTEVpZlpH?=
 =?utf-8?B?UHAzWjBzNEFJUE5sYUxVeUMzMTNuK0IxczhBVVJFVVRvcVhmcDE1YlJrTDhF?=
 =?utf-8?B?UVdDZ0RVOFRrcDMvdlhQNUNkTzFzRTZlVUcwOFd5YjhlRHZwMS81S2RRSWVD?=
 =?utf-8?B?NE5UZXdDdUs5OXBLVHBxKzUvUDQwUVhmamJPanFRNG5CWlNjK29Ydm4vanB1?=
 =?utf-8?B?ZG83OTNyMERYQk53ZGpWYWRFL0hFQzBMNEo1b1Z5dFJEZlBmMGxpL203eFR5?=
 =?utf-8?B?RDdyd0ZEV2JoZEZpLzVqdXNLWFJCUzhrNnJnL3Fuc0psbi9SZHJ5OTZOdDVk?=
 =?utf-8?B?czM3OG9nY1hQekI4aWNuTEgyN1AzQTRaMnlGeElJaVFoZU9OY20vbThaRDgz?=
 =?utf-8?B?Ulh4VmJpVHdZTzc3Smc4Z0VtTFpPTVFSTTZuNDR6QUtuU3R2ekZXWVN4ZWxS?=
 =?utf-8?B?MU51bVpYemFWbmFQTkVRWmZpS1hQY0JRU3NYcnc5VDNPUkxXbGdvcEJVV2Rz?=
 =?utf-8?B?YW56UjNlamxDdzBvejMyd3dTdk9sL1NNUldLaEdRVHNNUTJlUzNCVGJxV2E5?=
 =?utf-8?B?QS9mWHhVS1d2Y2ZZTzRudXhCK1JFQkloLzhXYis3Nkw2WFgwcW1BeXFvYnNM?=
 =?utf-8?B?aWt5dHhJWjFhOThiU3NjTXJZbFErV0NMUHliYVBuMWNRd2d2c05BS0dBV0JC?=
 =?utf-8?B?SERudEtOZ2xCeVFXSU14dVJtdUtIMXFZenpGS2M5ajFTeHZ0ODZZNG9KY0t1?=
 =?utf-8?B?YWhURzZINHpoUld2cjN0dStaaXRZZXFJVm1yZ05DR1htT2VKbk5sZkFUZFNu?=
 =?utf-8?Q?91+jitKclNA7rBn8XpDUvd0y5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934a1c70-0bc2-47eb-508d-08daf237484b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 11:47:28.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIcqI7zt4yH0YZ4bRKeE4orhecba/+nrU8vTLmUHh4NLp6qJYstNtO8boMULZJAL6lwnfePjww7KCyLh6eJ79Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/2023 6:27 PM, Lu Baolu wrote:
> The AMD IOMMU supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

