Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB7677427
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 03:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjAWCcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 21:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjAWCcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 21:32:09 -0500
Received: from outbound.mail.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B087E1ABE1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 18:31:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocQIFpw5I8tDPZjsGGtZ3+pvzsP0/l0TnbmXgdzB4Hg5OUjDFFKXWC6OyzbAtk04o1v6yRbrrQYAJB88yADYNY4ScmNleZilP9yWFgsLUbDxMvOXH7cooQ7432Dmgvsnd9JxYnywHvlH91pVoZdZigUcFcvThdTQ9OeQLSAsEgRvB0uwEjFiyYXWwIpx5QuPhfGeJz64hgFFQbNQwMukRmSJFwlKYjA04RlTkjONM99DpQLihGEYmlKEbojZqxWfxnjUdsYm0MTku1P1QIwXLvNl+RkJTbGGv2gCWxB1fG7+Lyz4WyeIz+VKqGd+KXBGj2cbOfirrYES0csANrOyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+my8ctBev+0Gm5yn1gu7KV/Sq0IsNA2CzmqUyAVabc=;
 b=KDU1GACqwdCZRmAbYt/j9Pqa8LaHNSAHg4eerbW9eT70C2krUtEtOiIGeVaCjJUaRTLZ2ckOleXluYDM/I+PHJvAzfBP5Th1ufuDBemA7LhSJkWPBazy3rLzKWYZLUbaFl4aj1V/ChyKSYUrqcSh03dz7auxr5nBGy7APzXkDU6bRXsIUlzVFGbP+wpWNyIypshgRQ452yXZCcli3PPdmbohYh7ehiCBerToYfmrv49I1G+lZqdrH53ALNCD0iZrz6i/oGYj3itpPQUgF8O2LgfJYmSn2cxpsk6LkXpRmj7/qgFbgoNvP2SjkekXksOQ5gWZDih2TLmaudwrG8oJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+my8ctBev+0Gm5yn1gu7KV/Sq0IsNA2CzmqUyAVabc=;
 b=acXXanzEyqc8FbmKBVXp9D4P6ChcLqepZHpDxhvhYtxOFOzQCnGo9lNUg9YyPDvIaN0QO0frOjrjkfVHFIxS0RC29VE41k37NkcxZkR5rvacoNDkVxS/PtNync/OisDugRFvqzMEqlsdK7tmzyDvcbBY0a5irarKmUul6MAUCfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 02:31:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6002.028; Mon, 23 Jan 2023
 02:31:45 +0000
Message-ID: <982bd736-6b09-0ac4-e421-903f6a4baaf0@amd.com>
Date:   Sun, 22 Jan 2023 20:31:43 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: amdgpu: suspend-to-idle on a 4350G desktop
To:     =?UTF-8?Q?Rafael_=c3=81vila_de_Esp=c3=adndola?= <rafael@espindo.la>
Cc:     linux-kernel@vger.kernel.org
References: <87edrnu9mk.fsf@espindo.la>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <87edrnu9mk.fsf@espindo.la>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0096.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3bdc3c-3331-41b6-20f5-08dafce9f88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mh+nsiXD/4IDIqm0i9MqnaRYTKlOct+TrGYbSxQyy+Rqne2KzGdKwdvtWNn66fxGC0CcioQuCaGl7bNKuIygh1xoiqx0VT4zbopb//Z2QxYwlV11CA3ArYKQwnvh0SKO3u478V+zx2HwYvrOorfEgH/1xkBWi6ySV8KvEL5jiAHIK3THiKOMK2U3JhRb2OG2wVj/fP2gWR7xTGNqBtyWpK2X7eP3Y6GpcGV5gmmMucasQl6A7DG4w61HceHZko9TTwrsHfj5PgmyLb00+ARTDMWvo5tnTLlxGHUVGe9R4UZrAFgm7hdVI/G/AVQxfd3KK/BrCH6rETE1gmr38KdnYY87oKi1RC3vQTGaYTpra12GvJ3RYm5qsYUs1DS3Q/+e1/TtIRYRNhpKFxREM5yB75sMpSClxibbO36AO6YKAJt3Z1ya5yCAQEVaLFZmRzhqSfPq9ao0iHl7WG4pAY8/NOH1xRKu4ahk/BggEhFTq4css3+UjZSvm5uTMbPb5u1i5YsK/1IjS3WUwwqDzoWhP4jE8aOnsOR03SufUKZgi+ZJxxciVJaUeO94XcMm4eLOAdoIEkbPUjjnafL1GGJ2MQbEQHdZokhDVVrBsHOku13xoumiMzNIPqPiaPSDQuK3GvpXpaanakbQbCl3JHwb28W37va9GdtiA3Aru4NhdSaswDQbZennD+4IG6IiDU7Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(83380400001)(38100700002)(86362001)(31696002)(15650500001)(2906002)(41300700001)(4326008)(5660300002)(8936002)(8676002)(6916009)(53546011)(6506007)(186003)(6512007)(66574015)(2616005)(316002)(66946007)(66476007)(66556008)(478600001)(966005)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnlYZThJbW8ydW8rM1A0bk1VU2pIbG9GOXFhcW1KaktycFJIVjR5MFJ1NEFF?=
 =?utf-8?B?bnZaNmRWQ0Jxd2F1SjhuRGpYV1FTQnJycWhjOVZpYnNFNEkrWnRONmIwMk1X?=
 =?utf-8?B?Ym9HcmpWOGxoTDFvaUhtVmVPTmpVd0tNQ21pSzI0WWhuV2Y0Zm5NQVM2a3Jv?=
 =?utf-8?B?WWttY0h3WDU0cmtVMnJvTTRjRXN5WWRPaWxxMFpVa0FucVVOQzU3OFVqS2p3?=
 =?utf-8?B?V2J0NmEvOFdZN2pNYWhTQkp3dUxobHFob0NTZzRkMFAzMjdnTTd2cW9WVlVH?=
 =?utf-8?B?QURCVGIxeHg5N0U2VW45VUFnQllZTjk5bEF6SWtDOWpJSjB5YnM3ZVNFSllS?=
 =?utf-8?B?QkxSUkdaQlBadlFrVlNLSDVnV0d5VmpCRGhiQnkwMHdaWmU2YkNOM1hBQVVM?=
 =?utf-8?B?SHRJQW9iN2NtNjh5YlF4TGJuYUtXRldaRGw3ZElRNGx5NzR6ay9WR3cxa0RR?=
 =?utf-8?B?dUZxKzVZMXgxTkgyYzZVZkQ0ZndYaDhaNmhWNnpJempudFNGa29LRkFIL3lE?=
 =?utf-8?B?Y2xOQ0plVGlYVWZ0QzdBWjlaOUMzNG81YUR2cElmQVdEc0VBQnU0U2xyWWZW?=
 =?utf-8?B?cDVRZXdhM3lGSGdSbzhHeHpqR2xSUzh1NjJyemp0cVNSNWIvalMyZkN2Z3p6?=
 =?utf-8?B?TncwbFdTc3ZnYytjS0hWMU9sL2dacGt6RHFoNDNKNXZFNElxREhtWm1tUisv?=
 =?utf-8?B?Z1pmWW5BVUtKYmEvOXk0TVMzeEJ6Z3M1dmZFL2pnZTl0WmVJaFJINGxEL3Nv?=
 =?utf-8?B?OWJWYjRNQzZXMnI5dEF2c2ZMMWtOLy9LMmZleXJFSU93aUhYdURQTVpSMTJq?=
 =?utf-8?B?MjljUVFiSHpzOGFtYmZxZ2RPR3NLS1doRkRpQWg4VEpLMXdyK0tPWXpSOEhG?=
 =?utf-8?B?MVU3Q1dYSkRFUXVzZ3N3MWtpMjZla296R2QxamlkdWdMWlRaVWN1bnFHUUNE?=
 =?utf-8?B?bG1DVHhBV3E2bklUZE81TkJqRzRJZ0ovVXFCY2xHeFFmRTNZTDlhaFNyWEZF?=
 =?utf-8?B?RGd6WElOMXJBSlR1eXJmWlowSnJHLzZ0b0hYaDhiQSswWFBodUY2N3pqVkF4?=
 =?utf-8?B?Z1hIZy9ZdlBHMmVXWU8zczgzaGFsWUFmbCs3Z09aVHUvekh2YlZtUHBZNUlF?=
 =?utf-8?B?cHllcXlFZDJUQ3o1dnI2ay9JK1ZiU3pvNGtERVVZNlVJNkxnRHVyOFlxVTBU?=
 =?utf-8?B?Q0xSNmtydkYzZ2dRd2QzRjBRdFM4YnRsb2xGRE5pZTBQWE5qbGt1eU1EaFEr?=
 =?utf-8?B?S0Mzc2I0ajhFREF1T0RBeldSVmlYYnJGL2ErekpjdHVPVW5SOU1wcldSNThn?=
 =?utf-8?B?ci9Tcnc1Zk1JQXpUNU00T0VQQVJuQjB1VG15Zmo0UnQ2ZHFNQjk0THBKVllS?=
 =?utf-8?B?WEFBMkU4RlRqd000R2NiMUx3Uld1Q0FMVzVudm4xbUVuTThHRTRCc1oya0p6?=
 =?utf-8?B?aUhsMVJzcnIvQUpFQnBaNEZ1M0tsd0ZrUHd0QjJqQi82dEdLQ3RCUTZrb0ZE?=
 =?utf-8?B?cWtpMXBIMWFNdjE4SEJwSzI5d05EalE1TTQ3V2lQUU1DWHFBUXduaUFTQnV1?=
 =?utf-8?B?MzFKS2tod2k4WjhUZ2xxMGFQNS82bWlVbEJ2Smp3dmFic2JkTWk4dEtyY3lC?=
 =?utf-8?B?emtnRlZlMHdQeFFBUUF6dVFIUkNHRVI1SnJkaVR1dlN0UU1ZK1FFN3lrenoy?=
 =?utf-8?B?UW9tNUFnQjd6K0xCaHliRnFhS0JXa3l3SmJpR1lkTXVuSlhINDRxTVNMeGJx?=
 =?utf-8?B?TDcrVHdZMkh2aUs0ZlpVZ1FzR2VZSlpBVHVHOWpFa3A4OTdwM0dFVDBXbXlW?=
 =?utf-8?B?QUJ4UnZXWFFVUlU1d2ZZT3V3clRFNzE1c3UyQ2JZNEdLQlhkTWNRc3VqYU1R?=
 =?utf-8?B?eHM0NW5xOGV6N2FWUWk1MjdpODhycmlSTzhFOWIxenI5LytzMHRjRGV0VUtF?=
 =?utf-8?B?NmdhSEZ0cFJnRi93WW1ZS2F6YWN4V3FhdlEzUVBuMlMvSVNENmE5YUh4UVN6?=
 =?utf-8?B?ekQ0QzFTYzhKVVNLeTVJdXJHVG9pcEJoU0t4V280T0c3clNjQW5tRC9CTG5i?=
 =?utf-8?B?aTE1YWV3YysvYzhTdFI0RDdLRjRDRWFaTmdENUxyWmJhTDNEWTVkV3dhNDht?=
 =?utf-8?B?ZVd4OUJDMGlleU0xeXh4VnZpVUU3MTJxOGE3bzQ1U1NncUNTL2RYc1JPRTNs?=
 =?utf-8?Q?TQCEis8ECFk+4g8t52Dki3U5ESBymnF+T+DtKFreI5IP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3bdc3c-3331-41b6-20f5-08dafce9f88f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 02:31:45.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yamcBjzxeyFlDO85P9VjLGVlEl58qCu/Wk3i9nlkazGJx1MLOSSumyIYZ463Fuct2BFduJtLLFPdppHcjMLghA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/2023 10:37, Rafael Ávila de Espíndola wrote:
> Hi,
> 
> I have a desktop that doubles as a NAS, and would like to suspend it
> when not in use. It works, but when it comes back it is using about 7W
> more than before going to sleep.
> 
> It looks like a6ed2035878e5ad2e43ed175d8812ac9399d6c40 is the
> culprit. The system doesn't even support S3:
> 
> % cat /sys/power/mem_sleep
> [s2idle]
> 
> And looks like the vendor decided that they should not define
> ACPI_FADT_LOW_POWER_S0. The MB is a Gigabyte B550I AORUS PRO AX with
> bios version F16e.
> 
> Which systems had crashes when ACPI_FADT_LOW_POWER_S0 was not defined?
> Would it be possible to limit the check only to those systems or at
> least only to systems that have S3?
> 
> I can build the amdgpu module without that check and see if the problem
> goes away if that would help.
> 
> Thanks,
> Rafael

Rafael,

Can you please open a bug report here
https://gitlab.freedesktop.org/drm/amd/-/issues

And attach the log from:
https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2idle.py

Thanks,
