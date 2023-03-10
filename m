Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA06B4E57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCJRSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCJRSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:18:39 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36038584BF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:18:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUHaQn83jjrmrQcO7G8ErnoXnXPktG8m0s/raU/p2e7OMj0m0MHtZGETBsIZyYmgsXn7jwQVE4YKQi8QPcdd+0A0RQ0DWVIIWSWqtH8/Ln1AJ52evfKCfRpPi0na7lnAXtknAQum+aa2t86LLsvOKC1dCCrzBkLWy2rzFPUoj0d+tMmrHCh1td6t9nYEvqYBmqdWA5lpjpnwR4+TJWRca7fw15nJqg6WL30H8vsxrKD5fVrfrg0YqQhABNvwXcWcYTbVjnUBKMas3nGiONZAeJe7GrlTjKiG6BzPSYcs5i6dpg8Ksrog9HQ4wiCOQ2ZCEtB0zq079+5WwqHelsFesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojdKHXaxhFovWRZwa+yG2D64u3AtfpFAaxly5+BZCDI=;
 b=Tu8blbpjBPmODWKcjFcSD56VEMDZ105FarV8A8qbAIW9p0W8bhiW1vYM+VH2EMm24IENbZBFYi5EhRd8FDO+k4j00dTKcHdJaJIHaqWk/7zBpD47ROISRN5YkEJNqKxQAnXOEsACe82L+N6S4nznJcTQ7+YVXJANpA6S1cPsTDVIs7k2BCbfB4flN3f+DUl17ItnNPhgTRg+RCLhtKmtEYlw9cI905NYknaCYE2dQ82TLYmzXIbRoJ8ci3gNWgrXUs1hPCnuZ25y9kIyya5Jb0w3VGjya9EK7S2sjUXb6iub2bE44aFWfssbLR1eX+al+xd1SwqrlrUEiaH6a7xz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojdKHXaxhFovWRZwa+yG2D64u3AtfpFAaxly5+BZCDI=;
 b=DsW3JazcybkUJsYqhFc3YkXp8V254Fg7181g13fzqBOtqEUMfnEov//I6Jhoc/sxLNz99w0rOPZWvoND4IPFlq6qF7Plr71loJeIFPwxBud/iS/wfv6xAVKIjNu1zv8BZ1lcBnKcu0tYu4bttnY5qZ0ecvcEMlFF8vKGgcHUJOdHQel8KidDVcByssjIPNY7Kc1ueX+Gs0+jj7olV4gY5DEIDynCtT1coVNy/RIk7S0FXpfvosJlhW20Ca5QQhxuRC2inNfnwvFAD/JrzfUjmSRtvbjcJ6aKWXwD0yyQNGhZsi5Y44WTfBepc6z91zOHgwHThsIIdy52kom3PevBWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:18:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 17:18:35 +0000
Date:   Fri, 10 Mar 2023 13:18:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jonathan.cameron@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v8 2/5] hisi_acc_vfio_pci: extract public functions for
 container_of
Message-ID: <ZAtmZZp7YrbEl15j@nvidia.com>
References: <20230217084831.35783-1-liulongfang@huawei.com>
 <20230217084831.35783-3-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217084831.35783-3-liulongfang@huawei.com>
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 824946c9-2650-44ab-33a2-08db218b7b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5s3ijFJHjcqPHe/Bfb/LPK8c9lGOxs/n7IACmWMlgUsjCaTdK2AcyyxsD7Z0PdiZ29cas2kelsMrsnLiRDb4CT1vL8qbUrszI81mlxAMtg7zTW2JNS86704+k6UG4xdZHL02+BlqcHYisK9nNsZMnpRHGD3I9SEciqTYb/dO74dNvHxcvUEJeLoFYwCsgE2YtV/PELV5tPG6XgZODu9infQQTLqWKtQlQJr0xSScsNt1B7VpuMiDXxN9TBmxqHPRBLTMz49kubWfR4zLW5h+SdATwaNDN/vdCX3ABg8f6ymL2JOrd8EUSsDCMmV8wZ39repzofFfqEnpHxhA7U8ErzVbCqgV3fiCFdZP+TmlY3/U/eEm4swfVguoAFl1zYakH+xProG5E1vZbSfrpt6JY0i08KnW3OnLUfZ6DmKju0BN6BiG/RtW+P1Wixgp6g9GDe/RWdPNU0SihNxKQS3YYRdGR4RCjqDQZq8Hp8nRBNmozlMn93t1e050LB9QxVDOhRzq1mkZQkdehSJmeW1ytb1K3Fr/NUALm7XertFT1/Mt1AfTPIwTNCNY4jjkhaMsf9voniYC2cEvsXAdwyo1KbBgLNjtPFVrqePWBuMndGPelkekVEwmiomoSi0kZvpWst9pKrmUsO1DKXJcyEKLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199018)(36756003)(6486002)(186003)(2616005)(6512007)(6666004)(41300700001)(6506007)(83380400001)(2906002)(8936002)(66556008)(8676002)(4326008)(26005)(6916009)(66946007)(66476007)(5660300002)(4744005)(38100700002)(316002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VjEXBygXy1aSce81X3xIxiASOA27OX/NH8kGWwHRYo2NSCyDyL6MlK6o5YVF?=
 =?us-ascii?Q?ke4DYAgYznaBBnv5P3FeZ8QDr0FpYx+d+aiWGOUzPD+hL0NujR5rXoYaKdB5?=
 =?us-ascii?Q?DYAuf3rn6W5x7vhJqT8tAujcJy3H2ZHSwHsRaPjeurnw5nDVurEqeGinWh5x?=
 =?us-ascii?Q?h+NRGiFLOMZMBdJGZmIIGaxQQKIdrzjqz6K/2ZWLEY1NHpKobw2x6R3hEPhg?=
 =?us-ascii?Q?wJjTuxelHEHxNdZpj5m0nENYxVmJ3BkXDC0jX6Qq0DPZ2r+e98/+9zFHtUUn?=
 =?us-ascii?Q?KBU2itaDsk1/mDT1PcK2ZSVlPO1oX32auRReLW5Qf3R6MbXtZI5J/3J5dDHM?=
 =?us-ascii?Q?sFrG8bYLf6RrarBEn3eCT0ZJW5tETButX18hzkm6kHZG7Qb5TLMtdgDwRGOG?=
 =?us-ascii?Q?HFMRbdt3YYUAv7d9ZUOiUtjRGD9Dve6segMJRPAw9h/hO5vREv/7gQWZy3gi?=
 =?us-ascii?Q?wAY7UoJgz4mvK79ReSjjJLad8U0Bt/FA9DDCqNyWdQHyJAlUxihqOn2g0fIj?=
 =?us-ascii?Q?/UT9t+c3PsKV7RKNZ+utVKkg9ybY0yIpPKVGTGAQXvzFdY5pZQAeG88te0gJ?=
 =?us-ascii?Q?sEC7hP9RVzxh8vBtaGGXShVXjh2mNgggFKswnFt0vmGnRfD87AfXN74W1Pxx?=
 =?us-ascii?Q?VAKv+S34K4oI2ysfxOeXFr6TQG2m2cHpKmy90OtdtXal/34+s7w4eW2mzvwA?=
 =?us-ascii?Q?k7Y7m1ODqXP/Mj1AQ6CbNd8syVBAfr8MVCSGrQLx67NQgAVGaNiqxHRJNn2v?=
 =?us-ascii?Q?hSoRsD1GkKXAJMEQifSWZUdt9lt0XZh6ElPtw7rfFEsXgY9aPOVbJhf5ROaz?=
 =?us-ascii?Q?9JqsNpp4f7QIcFn4mA/oDT8Xzf713bEIUMP1RQ2F/Ctiw9lOqNmxwspmdPDp?=
 =?us-ascii?Q?2aNSFMqy+RigU1yirv+AUTEXpgqvjIJ0n+Kg0n9+UjmlFXfOJlpSzgoaCr1K?=
 =?us-ascii?Q?z6qE2BGGCgKQfKi8vyIfJxPhdRChzG9An3Uboyy5QtoyuTbVUgGUhAfVoO0r?=
 =?us-ascii?Q?xX0CL1YDuBPxoB8eL3TP4tlzzHu9lAwwEAmEW+vZzVlqQgrBNOLMKZxFvkfA?=
 =?us-ascii?Q?gUzF6Ne7NMFDzLV7EyLtTaK68MEPELIE5VtMflXku2IzYMDs6akSooso9sI2?=
 =?us-ascii?Q?hqM48iPlPdPwe9O0Y2qSEBtm6hyBOAdlGQ8Wvnlm9OnAYEsfkDJy9J8jW7Ix?=
 =?us-ascii?Q?xuIYfC1YLobI8WACF75HCvkLv20fH8NVhudewigwAmovhNtdCQXhgCVCwJG6?=
 =?us-ascii?Q?yU2Ep6YPvGMmj6Ba5sbpGnHR3wo63PymBsKF3rLpNtMNZDd4Kc+2ac6au3XJ?=
 =?us-ascii?Q?VRVhSS3vYEXXH9QYi+pCf4qKBL1FE5RmYtPj9xz68CzgCnZF8qdhENDz3x2q?=
 =?us-ascii?Q?i+Qkpw4HouQp+DsHJGvB+7ijNLENJIUR4lqtfuatzcaFEgbscBT6MKOnH1Cy?=
 =?us-ascii?Q?WcdmF/DeTLvIn5ReJ4ni/AjnLRv/oxd2fOP5QOBJNyu1P2Zn+nLeCTtWhM0t?=
 =?us-ascii?Q?15zkifguTNWM2BNPvK2zOc9CXZgU5JYiIm2gLqgJTuXlcur1p9f6ZAVPOMOm?=
 =?us-ascii?Q?2j+YYgA2BRnXmOOhagAJFm/6UT49ScE6aeTfxUWb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824946c9-2650-44ab-33a2-08db218b7b2b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:18:35.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnSmkm+KIqRBVQK64+fMVN9m5e8qOQiWQHB8A3/RSoY4puXu4LFTMjhOzEG/hPZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:48:28PM +0800, Longfang Liu wrote:
> In the current driver, vdev is obtained from struct
> hisi_acc_vf_core_device through the container_of function.
> This method is used in many places in the driver. In order to
> reduce this repetitive operation, I extracted a public function
> to replace it.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 21 ++++++++++---------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
