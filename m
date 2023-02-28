Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C537D6A58F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjB1MX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1MX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:23:27 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CA41CF48
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:23:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXPI8wR4Em8sfwK9Xt1ny0gp3OO6xvXa9Ygo9ShP6EqyHwauXFuvjwD6HJ6vX5kbDZnzb/Qh3TfiwG544p5xX2/e7vl33AjW/fX685VPi/zrVPcWr0Wte2AU9/i2RZvHUaio/nQatvXsjzgmO9CwBePy4d7AyCPsFyr3NUNAGHFWe+ELuw+Z0a2JlNivT5mOsVVV7iF4pvOPvWqrov33lHC7ZVZGWQoUfEvvi1hQTKOZcOdPyXS3eLromOF7ls7CYIVjlkBRh7VLV6y72S28AQhYktvz48nzp/1d5l5sIi8VQ9ISXCtBMWBDvq5T+MuuKhoYbPNzNxnRy3QHPSxvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBRKiS5FHAlivSLDit0HLO1qImNcFamVMPQD+abZwuo=;
 b=GE8lrMLG85/F9B40nuRYJTtW9ihZr+EiEdiXG9HJjXuLsXs9HFe8YAzFkQTUGbhd0ouxsWJJK+l6WVI5cAenBy1JIMysCriFI+Nvce0MthoqP+L7WxIUVoKl1IQvSEu3EPka3HmfH/ZHKw+6r9SngvavbHPvQ1zeb8DrYcCcLB5KGbzK6p4X354Lv9w6yDxriChkbO7Sbq/lfxgedF4THtE5M2sssNwV/d+4H2qFiecrUFAkbM4WwspsugURXTIQyMxIjAmsD3pOQX1pc9MEBaWdJDvtEg3cIpV0eZ0trGHyIH6kaOD8r7JPkBI56EmMEHYwcyxSAqbpj28/vFPSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBRKiS5FHAlivSLDit0HLO1qImNcFamVMPQD+abZwuo=;
 b=QUnqZ7MY1YMgnLBS4QCMO9DrgoEG+6w3Xn8bRnTRv36iLQKhObtLTBC1aEAOVO3qXrfM1GzHB0esWPfXYXX4T73TOSMMSIUGmAtGsfrsrKb5AsLG+aSCa62d4Q309Y23/0k0dZjiEYXRal/71vc++f/PZcwl85z1R0+u9g3OtFNS/VwUfiW3h+2agbOP3CqSxY+WnHzdt7mj4QV4otZj9rff14XlQRmColmYVBqFnRpM5nZA6y+ImswoGKP7DMHA57zlEZ1hFC2ck5uCEhCF6E/ON4Dhn7IiJFR6+6BDTS6CeUVmLUcWCwhuivtHfFdddoum/PFMUJi0WCgkK+qOkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Tue, 28 Feb
 2023 12:23:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 12:23:18 +0000
Date:   Tue, 28 Feb 2023 08:23:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Message-ID: <Y/3yNaQD5Pkvf61k@nvidia.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230228023341.973671-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:208:23b::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: dc396c8d-f469-4cab-0bdc-08db198692f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqUCYHqNO0JB4MNaSPH0SEmYupWLqZIhaL6cwU9JaLHUxaHNJ9c3ggoblRPukaqcooo39ThK+nZqqAdAgMaJtrvxBRetuwTRfmSnB0QPnpBYIuMlIQGzQznoecsPOZhevAY/CAjy83UDPNLFk9CT87AClu+cUxqt5ussOyBO7DhPuH2rhEdtldoCRg/tcn9v6ExYUcZNhnxTMx3pTL8vOtRzf/zDCF6kXCiZroW9TAEKaZhXD7guKoIJ9dag9Lh9D34Hn8Bx3szZO8nwlhSoIzAx2syH5wvfWwVSb64EuZitcdtF4EB+Z8fMOX2Tip+o5mDeTDzss+dqgt/qXTRmNC/xi1xUGvx9P5Gy/Dpv9M7f0/hN7voYbfjRJ/gZRXyuUx6ECLc02sJ/IHDrByTynb8ndMJq5ozqsZ5Tfl99Ai/ZVqajEGe6yGz1oNRXkzxZrxlw+XPkhGEFXVNzepKS/XYSv9nDRIBrfWzKiC1mT7HvoMTkx7oXz4N5eo+l7nn9ypxmmDqHyRVhq+KqUPuslpOnOPbxga4v39LqQHtmnD3TI3JJgfJKIiENO2k+S9D5R74oaSWX0WQQnuv+Ae+Mi6Mq70bnn53peuIt2cN1xiXdDTNNTA/YNAz1aUj6xtOf5T6oHXtNDKqJ/5xhk6amkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199018)(6506007)(36756003)(83380400001)(316002)(38100700002)(54906003)(86362001)(4326008)(66556008)(478600001)(6486002)(8936002)(26005)(6512007)(186003)(2906002)(5660300002)(2616005)(66946007)(66476007)(41300700001)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllIRGFVNlNKclNiR1ZQRzFiOG9IM2lVOUIzWXVsL1g4L2haMkhrU1owVWE5?=
 =?utf-8?B?bTczRDZPMVkwYkxhRkNVY0JZTHJTMkU0ak5JTGE3STVZeFNnRitPTkVsengy?=
 =?utf-8?B?TnRKTTRWdTBHOFNJMDZ5bml4ODhFS25hQXpVUFBqV2FsNDR0ZVFBZlhCMHZi?=
 =?utf-8?B?ckg4RkgvTE9aZ2JqWmVJcTBiN2x0RlE5cFZ3eVVJYlNVVUMwUm5HVmUydmNL?=
 =?utf-8?B?c3dGT3FYVlJZMmNNb3UzRnNKQThKU1JOdXhaRDhnQ1B0clVpSElpMlpKblBT?=
 =?utf-8?B?aldqYUxJZW1jRy9PdFVyYXNGV0lSeVJXVG13N3M5M2dNVkdXTmpBZ0JPRkVB?=
 =?utf-8?B?eGNieGdNN0E2MTZvVDJyRG5YY0J1cnlkUmdoeVFJMEw3NzFGZTVFQUZnR0hG?=
 =?utf-8?B?clpMUXpYcnAzZ1Q4Q0QrVXZnM01CLzJDK0FwaXRicWFNdzI0Y2ZXNGNDVDBC?=
 =?utf-8?B?WFBNWHlWVlhlRzNjcE00bXpxOHNSbFJFNGwvUThZb3lwZFhXZ2V0MHlRWUwy?=
 =?utf-8?B?WXpXTXNlRjhsZVZ3SnR5TXhwL0xMUThCeXo5ZTNYR1FDT3MrQmJwd0w3SlNW?=
 =?utf-8?B?by9zMk54VnJFeGFOM2NMWDR2Y2F4QXQyd2FQLzdBekR3ZzNpVytSZVJNRURG?=
 =?utf-8?B?czFBY2tsRE5ZNlZBUTBUMWk3Z2VaY2VrR2E4cGlHOWk5V28weXpsNU5vWHNY?=
 =?utf-8?B?VkNzMUdVKzlwblU1T3YyYnU5ZDR1T0Rra3JXRGNodjRDNlF3RkJLZVVicFUx?=
 =?utf-8?B?cWkrb0tPRXhoUnQzdGdET1pnTlowU2NVZDBvRDR1b1lmRkpJdTROWUxIemRR?=
 =?utf-8?B?Y1dSQ1MzUUlPblBWc0xpVWQ1ZXQ2cVY5TUxaQnErRWVmU0l4c3VrL09oQTRr?=
 =?utf-8?B?Ukl5OENvMHRBdWdHTTJ0aDRNcnIxM0xteEI0Ym0rWnE2aUdSY1NZNjIrbTlN?=
 =?utf-8?B?ODRMUnJCZlBpbXFwMllXQmt5Y3o5UE14aVloM2w5NjVvbU9rMkQ5OUR4MTdO?=
 =?utf-8?B?VDlzaTRDVUlWZkpDeTRkbGF5TlE3VXNEUDRJSWlhaHN0MlpjTzFHbHg1d3Zk?=
 =?utf-8?B?VndaWFVuZnk4dk5la2hDbG5YY3VqQm8zekkvSm9KWmdsYUVxdU5iQzZ4MGps?=
 =?utf-8?B?cW90NVhjV2M2STUxaFpGTC9qMTJVM3dtSHRWcWZLeE9aRHlnbHovRDhVNlRZ?=
 =?utf-8?B?dExmcC8wa3I0N1ZOZlFpZE9aVEl0aXBReUNkVzdmMng0WTJYdnN6WTBqQ3pN?=
 =?utf-8?B?RC9haUJoZWlsbW95bFVXWEJpWmx3U3MwWXBZd1lrTmphczh6bWJhWFdEWWN3?=
 =?utf-8?B?ckdvSXlZK3RKaUp6UHdMMUtJS1R1T256NEtqYlRSMTV1ZFZ2cDJWMldBb29T?=
 =?utf-8?B?M2tES1E2Zll2REg0ZFh3OEVJSEJLMUU0eVFyLytjTGl2L2RZL0pzVk0wTTBU?=
 =?utf-8?B?REtKOW5sbVN2cVJycnRqbGRISTJiUE10YjI0NGI2RW5iU20vcWFXZ2lUQ1FQ?=
 =?utf-8?B?OXVaSzlVVytaZDE4OE1IbTJvNHpwVmgyajJkN2lEbDVMV2FucEU3QTU3WGNt?=
 =?utf-8?B?Wlo0bk1Na2FLM3VtTDNydTM2QVRPY3h3ZVZtSTFteWkvNVFVSzVSTmJXNllH?=
 =?utf-8?B?SUNkVi80bTgyWEpmaGQwNncrUlhvbk5RRDczRDcrVzVDa0M3enJlM25vNTZ1?=
 =?utf-8?B?YzRUK0lOVDRPblR4TFVzWjZuRWRQOU5MWGlLaHlDR1F2NE1DbzNVN280ODdt?=
 =?utf-8?B?U0YxLy9MOWMvaFFkWU54bTArT29TMkRuaTkvT3lJdWg4ZXFydDYxS3NtUysx?=
 =?utf-8?B?b3JnRXRhVUM5cHRjZER0ZkYrVUJ5SG9TQXB2N2dLU0NKMjJnbFJwMkh5eGFy?=
 =?utf-8?B?bEZuMzFTRUxkYzhtZHlKV3QxK2lxV2w0dXhCc25LWWV0TDc1ZXRvTW16R3ps?=
 =?utf-8?B?SVNNeUt6ZWdpZU5nVlFXQW44UnBKSWVJZGE2VDZwemsyTjN5QXdXRjk1RjRx?=
 =?utf-8?B?K0xNbGo4MjVSZzQzdW9qbmJyaXJVbXRQN1JvcGlMUUt6OXEyTS9pN1d2WnBz?=
 =?utf-8?B?dDBod0VqUjBMeHV0bXN0eUNZeEJmTzJ2NVQ1ZUxxei9sQWFuZE9nZ20rUEpU?=
 =?utf-8?Q?xOG49rgEsP+4xbIH4Kk9Pp52K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc396c8d-f469-4cab-0bdc-08db198692f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 12:23:18.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTU76yed86ocCNpk4NBuqzccRqiCRa6xqjXlq1Rr1bGCn398eAwJc1oDAy5e1JWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:33:41AM +0800, Lu Baolu wrote:
> In normal processing of PCIe ATS requests, the IOMMU performs address
> translation and returns the device a physical memory address which
> will be stored in that device's IOTLB. The device may subsequently
> issue Translated DMA request containing physical memory address. The
> IOMMU only checks that the device was allowed to issue such requests
> and does not attempt to validate the physical address.
> 
> The Intel IOMMU implementation only allows PCIe ATS on several SOC-
> integrated devices which are opt-in’ed through the ACPI tables to
> prevent any compromised device from accessing arbitrary physical
> memory.
> 
> Add a kernel option intel_iommu=relax_ats to allow users to have an
> opt-in to allow turning on ATS at as wish, especially for CSP-owned
> vertical devices. In any case, risky devices are not allowed to use
> ATS.

Why is this an intel specific option? all it does is effectively
disable untrusted? Why not a global option? All iommu with ATS will
need this?

Also, why doesn't a "CSP" set their ACPI to make the devices they want
to use ATS with trusted instead of this?

Jason
