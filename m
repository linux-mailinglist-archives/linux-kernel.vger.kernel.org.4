Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DAF60CCFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJYNHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiJYNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:07:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259CA26AFA;
        Tue, 25 Oct 2022 06:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juIQ+3YUVxwJ92wr7EA/RA6ifXZjs/o+ZS9knbZtalx8usupwYZzPgu6TaVva0DZIeDuBdKhdACE0EeIYpDfxQHOrMwI0Ey/U08nC3lyXczHfl8AnIDkU3O0IcXgzBKD+APZgMyhii36FWy3+OtrizZL1Mw/E4L7hW9gqUfHHWZKPh9a59EpiMchGZYrgZDl1l1xwyuQndodD/xwPyax2meURMW6KLsERlFuPt+ufVjr61Wsr9JR1e56poyCoktiZj9M6au7MONqAEGKnYi0TYXOhk16Lzr06vrbIz0ZZQS4W9/8Orz5U0h6eylSlf7AE7pMZOeL+h0KwV63ZZJBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeZEfp6i9AIFm3Et71jHn9SScpNXSRc09vv1TiS4fJs=;
 b=og/lnRFmC1L87L7L3EE3t+cWqHUaepWkF32YwRQCI5vhRbiKn3qYuSbhE/2Y7kbBv3vSjuHSPGpQxdDdtaLaiRPoleKB8OhQfOOeu2ipFAndDD5rD4I8Fk4ojpi++fIjXfhuUn5DxgFW3BPKrmT010fUOEzbsYzSCZsVon1Koy0Pmh4gwpM5ZjqLspNXLvNQPWupR/JjadCjnyQ+W5dulO+ET8rpXD1hXVzTCr8xrSi2Z7HzS4bY+qNTTXjqQTDG4N9YYHVMYdWWJh+d0by7h9xH7ufXl6sxqvAjwJxLLxTDB5T2tsXs/EdihcjWm8/h8ixC5+ULcyqTyR8FCarTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeZEfp6i9AIFm3Et71jHn9SScpNXSRc09vv1TiS4fJs=;
 b=pDT6DoxW8VWuWtH97ht31nlHfoEbGNNWSggoZA0y5iC9kijzbCmDboNnE9hUXE73PBtVw3Uxd5FermDnbrvqEZqFYNbSr8I2TBiVtt8xjC5XVniyMKVwN4J1yd5CBYCVUS/C+AzZfDsfTeeD0MAQJ7vQnhUQ7UXgMGZQ3sLiVWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 13:07:04 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1%9]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 13:07:04 +0000
Message-ID: <d577887d-b86b-82be-8081-f7bebacd8067@amd.com>
Date:   Tue, 25 Oct 2022 18:36:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: Perf: BUG: kernel NULL pointer dereference, address:
 0000000000000198
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
References: <CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com>
 <4429582f-155a-04d2-d139-a834bb325612@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <4429582f-155a-04d2-d139-a834bb325612@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::30) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: 87945682-e052-45a2-84b9-08dab689cffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/xWd/E/4J6nS/JqoRTVN2tBLdI4XdL8DDFSFg2pERQJD/a5CxLQFj9bqrADq7ZT4CAF6oCcHzDmLYEgEavFDH9e6HpcxYQWTSuI7mbAdtErasw520T8mX/+nwt7btL0UTCqKud8KzKQ5SYFOEBrMgvWW4vEG10SwlI+h64PdgiHrAkOQGEbjXXJeIXDr9JjQAOhprCZ3ZtESkFIxXSiZ/6DvFdEQ2uedhp9a6hUVo53ma/W5JLaWjVcu9tH4ue9ThqWkfDAzQLuij43eGSRZ7EJMV6I26M88jQ3LGgNhhvQsvx5xtFXKy7/x0KZak6Z3RvrfnzbnNg2d5P3MUeq5LDYQz9PHE5M9OmY79tXDQ8y5v3T7/KLkgKlosIPyAa3+94odCEH9SrXMgwfGFQtlNTzp46FjOH1voGnMExggFhx/XqUXScNRB+Mr6wHV/CIejvLdM7F1NC4iRVXB/ueNDCv17tZIOno7UQzmWmP70EJ/DnJZ7uvum49jGILXoVFXlbgUxT9GPuMdczs2lDHHxh0sZzpQgTtJvQebP/95y97MeqZL2GDFVqkgu/0SDq1zoU8iLznYEjeOmihsnOb0CdIEUU9W83bbiA6i4bsjgZrH4i8H1ZyM5Tyl+4y+fvGKKftl6XgpXQT7NpSLjVGih+pxXGTs46czozi2YwfxaZLxbvVkl/tkg0wUVS8GwcbsNthuEHw3FcCQDZ8DXUpZQDGrCGxTg1mvD5lEAH5zHgaT9dWwwht7tP7cff1PXPtn03ZAp2kBHEWYr4VAJ+zIFowc661AjHhJtVFk+l1bpZtumU3NuaayGDItQyKR+DKfO2DawS1kseMRazQGbplSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(6486002)(31686004)(6916009)(6512007)(316002)(53546011)(26005)(36756003)(54906003)(44832011)(4744005)(66556008)(4326008)(41300700001)(86362001)(66946007)(66476007)(8676002)(8936002)(2906002)(31696002)(5660300002)(6666004)(478600001)(83380400001)(966005)(6506007)(38100700002)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWo3OXJaVXBrVGdHTFAzcG56d0syTGQ3Q1p4cktmbE1MYm9qbkNxVkpudEU2?=
 =?utf-8?B?LzFwbmRoMEtKWjI3em03WlJ3UklnUEliSE5ZMlM0YUVjNVhCRC9XQVo3Qmtu?=
 =?utf-8?B?cHg5cVFtMy9lNEZocmgxK2tSaFQvS0ViblIwNVdPcDF3OVdNck94YmVOZjNG?=
 =?utf-8?B?am53VmZtUWF0VStyZXpkZXEzZTBSUU5uTjd5WVVIeEJWNUpaVitlN0NjY1lX?=
 =?utf-8?B?ZlRoMHY1VG9BcnMrYVI0OEFhWWhoMXhSUGd0UXk2QWZOZURsU0YzRmZVTW5t?=
 =?utf-8?B?WHp2WU9nb2J5MSsrZ3R0cTFTanV3OHhKcUZIdHVoRmlNU2U0c2NUMUtUMU1j?=
 =?utf-8?B?Q3ZkMEZPcWJMNlYxL3JrR1lnSDhOUTdOeUZuZ2IyQ3IwVDhnSDJjYmkxaFhv?=
 =?utf-8?B?R2ZSeUUyZXhIMFVqSFY0aUZyQy9Wa1l6QnpyV2VOLzFBaytTRndsOUpoVkZn?=
 =?utf-8?B?VndpL0N3alhpNWQvSTBHT3psZmtQUndQNElpWGlvMThZQWg4UHpUNndKMzR2?=
 =?utf-8?B?b0hsWlhzZ2ZQNVJDTjJPMDE5ZmV0cTAyRG9PcUswSHpxalNjSFNnUlU1SmRv?=
 =?utf-8?B?SlFIbGlFMXFta2JKcU5KRkJPYXJxTXJHbjdCcDVzRFJra2VLcWVtT210amNF?=
 =?utf-8?B?SHhseTZLeWRacVpmMjd0YkJFUEJ3dkJETFc2K0lTcHkyM3UxOVZVMFFrbURT?=
 =?utf-8?B?VGFBSkU4a0N0MkF6T1VaMVJIWGVRaHd2eEZFZWNmd3Bqa1hPRlZPVU9mNHpT?=
 =?utf-8?B?RUNVOWZoZW9VM0dIc3dxRnV6MTIxTHRHTmpKeEFIby9QYXdqWVZHM1h4TGpY?=
 =?utf-8?B?Mk1VRUUxSzFMRTFoRXlIZjlmVTMxbldHZTZrazNoOGVnRUxwSkpqNFhYNWI4?=
 =?utf-8?B?RHgyRTRkSG5qMXBObERqZUMvdmFzVmxwUGRkYkM3RGRMbUJOWG42c2ZCd3Uz?=
 =?utf-8?B?WGJueHhOUSt1WkZod0IrZUN2ZnVwYXJYaEhLQWJKa3dERzdLT3EzWGlWNnJ4?=
 =?utf-8?B?T0FjVVRoWjRkNDkrOWNnMTBrTU5WMkp3a0NxR1pKMENXYzhiMWVHOG9ocEdh?=
 =?utf-8?B?bm9tYVBTSXZUV3BJZE9NdFlWeDVnQlRXY2Q2RmdZV2lOdm9zSytqeWhUSzU2?=
 =?utf-8?B?SXp1ejRvbE1tTktKNmhxNmxoWlpyVUFVMTZmcG9YRTZhRTZrT0lnd0d4MHAz?=
 =?utf-8?B?dXprcWxQR3VuRnUvYzNBcisxTnVGUVFEd1laT0RqM3NQSXZZSVB6ekU2WENS?=
 =?utf-8?B?WDZPU01QcDFiMDNYcUZKZS9sUTBMdHM1V3ljUGtnZTFpampWV3h2akpNa0lG?=
 =?utf-8?B?VXlDa2o1YlZlQnJqVkdXdExxYlFLcFJYZFplTENVdDZTTlB5eDBYM3craTB1?=
 =?utf-8?B?dVJhTjdoRVcvMm90UVpuRXB2YjZwMEc4bGlMVDQ1NVZ4TWZLdmxWSHlsZmtT?=
 =?utf-8?B?Z1ZmTnBmSjFodDZnRnY1RkhXbTBkd044dnNuRGJiNk15WVhjZ3dkWXF4aWQ2?=
 =?utf-8?B?L0tqbDZkNFNiWlJmYjV1WEdMVk1kZFM2NkFzRGc3bG9XUFRyK3hUdWVLdU55?=
 =?utf-8?B?cmlrbkdwRUhpUXI5RDAwRVVUelEzUTl5REloeUFGZ2xiV1FmVzk3SXdQREpt?=
 =?utf-8?B?eVJycE5rQmt6bEd5dWMzNkl3L3d0dTZJZTFFemdKRlJ2Z1NWWXorV3ZqanVz?=
 =?utf-8?B?QzNhMVhJVEs3TzZSSTNsNDY4MEhibkoxczBaWVppY3VwZExRZEVtbTd3U0k1?=
 =?utf-8?B?TXZkREtXa01uTE9lbnU3Y2dyNEZUUmI3RkttY1Q1T0pPL2pldjFBS0hxaDQ2?=
 =?utf-8?B?d2twYzlud0tZVi95RlRUdkVUMklKM1JQT0tNeDJxRDRiN0w1NERSWWlrQTh2?=
 =?utf-8?B?WU1rWmpIditvaTN2UTVaNUsxZGNrY2NONW5sZXJRaEFUVTRoTUNzQ2tHdE9x?=
 =?utf-8?B?K2kxY0kzei9hSmp4bzVEMHBuNGtTSUd6RXpXS2hPTDhibHQwYzBad2UwSVpZ?=
 =?utf-8?B?Z0dNRGRRWnhLMDg2R0EzaUNxdDdKQnRTZnluT1hEY2Z3QUpOTXo5T3pFYjdZ?=
 =?utf-8?B?c2JyYlJLRENSUlMyVFV6L2g4c0E4b1hQbzhUc2ZCS2E1RndaL3F0OFE2Nmxq?=
 =?utf-8?Q?Slw3ZOmj0t+4djgLTvWLd4mHg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87945682-e052-45a2-84b9-08dab689cffd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 13:07:04.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40J6DNhyxrRl62xJuNo+zUlzXOlhUzPNdUdDvd+blRt0oQJeHLPjUYUab0b/F9chbJjn/5ox74+mEIVLAooa+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Oct-22 9:59 AM, Ravi Bangoria wrote:
> On 20-Oct-22 12:24 PM, Naresh Kamboju wrote:
>> Following kernel BUG noticed while running perf testing on qemu-x86-64.
> 
> Thanks Naresh. I'm aware of the crash[1] but haven't got a chance to
> root cause it. Let me try to spend some time on it.

I tried to mimic https://lkft.validation.linaro.org/scheduler/job/5708609.
However, I don't see a way to download lava-guest.qcow2. So I just used
rootfs and kernel:

  /usr/bin/qemu-system-x86_64 -cpu host -enable-kvm -nographic -net nic,model=virtio,macaddr=DE:AD:BE:EF:66:20 -net user -m 1024 -monitor none -kernel bzImage --append "root=/dev/sda  rootwait console=ttyS0,115200" -hda lkft-console-image-intel-corei7-64-20221019172733.rootfs.ext4 -m 4096 -smp 4 -nographic

And I ran perf test inside the guest, which ran fine.

Would it be possible for you to redo the experiment and see if you are able
to reproduce it consistently.

Thanks,
Ravi
