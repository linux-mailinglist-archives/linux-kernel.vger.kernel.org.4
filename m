Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842FD66322E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbjAIVE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbjAIVE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:04:27 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA8B8CBC6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:57:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi7YPfOWaQbHPAEFJGgdrpE8zIE6sLc/spWCbRBVMYw6dMQgGpb/JZjYzg7y6sNq2q+Nw2RSu6vUIjXe3BLHu8WINdgG5Nt5Pf/B4owuoa66Rty7qgYZI6RHtNpXTgL/S9GfrSJWslA6BOUY7w1MCzaKFLGQzOC3ZXRZd1adhmxj7hiXUxO+62pMPzMIcrX0t/PdxaDw03te2kdf5U67OVu3SuDaQYl6Krk3hULSRN38am13dpUYFy6CNsP/wwDnCbfbrB3APnl9/e6LenwFA2AT4O3iRVXhXcx/q60EaI1hnp6A/+MBj2NTOqJ0rd4JzVM7BkyQQv7fv3ZWJtFt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMBKunXAgIhUg47VBuYkP82NxdIcodUWEyUroN5nFFA=;
 b=POjyoHvMeYSSpm+x89MJ6FcnYfPK0wx1BKCD/F8snY3MhRe9p3ZQLY4f5fGR/P+yKYuDsAQtFrFRZEUkskqWKDSx6hvqGY1cX+0BbTFudsPg4Yn1+Ac85luKT95EUU1CWfgyWiGy4OpUxiry4179OZ4iSh15mZN9RXC4rIBy3PBbhk3VCUN2gtItLkU9gc+4mGdwiDukjXPorvn79Axkowf72pIUHDJuQbY6XmUo7AxoQwsB23xLmZLh2RLq78yAoeU8Mk0iNDxWTl+bYaUl5lGnRD9EZjWRBBNSmEXe595m62tNTaVvE3im47Glc9YpkHO1s5haSk/zCaMxa1T8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMBKunXAgIhUg47VBuYkP82NxdIcodUWEyUroN5nFFA=;
 b=EcL2DMG6uZihrluyQG6HQG7X57hD4dEXGQTBX8nCZz+tBt/p8iDOC94rnul89WQh/METN99hmZODZcUEfPOILGHvcaCVa9hn90ioZPTYjzly3FU4xDLjjFHxrmH0p/KAUO8GmCDhuRw4Vn2KmWPSbd54O1bMrpki3NVw96WNQ5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 20:57:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 20:57:35 +0000
Message-ID: <850e1dee-8b49-07fe-e11e-76c3bad1ebcf@amd.com>
Date:   Mon, 9 Jan 2023 14:57:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     peternewman@google.com
Cc:     bp@alien8.de, derkling@google.com, eranian@google.com,
        fenghua.yu@intel.com, hpa@zytor.com, james.morse@arm.com,
        jannh@google.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, reinette.chatre@intel.com, tglx@linutronix.de,
        x86@kernel.org
References: <20221220161123.432120-1-peternewman@google.com>
Subject: Re: [PATCH v7] x86/resctrl: Fix task CLOSID/RMID update race
Reply-To: babu.moger@amd.com
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20221220161123.432120-1-peternewman@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0037.namprd18.prod.outlook.com
 (2603:10b6:610:55::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d889af-0a24-4303-ec28-08daf284225b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQ1hP4JpIXaswYo2rO2aJfD4veZ4+Ecrxf8ASKNM3JNGoIH55oBg8Ne53iOyqr85KWMxZj7nRW517LvHNtTbSYhOzJ3WhrCcwHAHYd1TPmJOZELwchsJlwy/FymTFJFvJ+oLGmRMXOsxH5Cs+asBZb9qVZSrCy0nGpl2CY0GSN8epOqIaiYYOWI1v1wxc0om38Hk+wPdOCX0R8G63rKIuQyTRd5Gc6xNh6wy0bPCKcZXHjMOoijCrrvVf8b1ax68Tig/w+rYI9ANCTWT1xBYQNTsqoH5ugz+IG9+65M54SrcwO0By0clXRnKgTRPzZhHcazjY/RvmvRgYjtZnbPpBDVTSZZQfliO8DSMNutNLALA2PVXNEQh+/1xjf6E5IkWj0Ql+KesTba20e6P1fFpHvAgJHEiJ0OUlHUH9hK8ceKEiw6UAr953c0O+dHE34jKOIhds0eO93umPkv3cA8XJ+5eHmx+1LGL0fGEPpp997k1XnvkEEq6tT4M/WCIOrQyDgY7YROo06fSO9gBuXyvKKEaCiZlj8G6T8mqt+wkeAtxriMX2N+nnVVM3Fxkp8EZ9Y1RTl0bY91cKLx/EpqI71jUoggj5yyj912FpJYjUeT/uqEUP3Tz2PY1aHUS+Fe1DqtMFgR8nZgH99rEPcIkO75UdH6Sni/UO5MKpbTlYTqbj6a/adGQsMpZePlN1raBPFvVhwYkaUbKClB2eU0riJESfbLQcWqir5xwBBylKGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(41300700001)(31696002)(36756003)(26005)(8936002)(558084003)(5660300002)(7416002)(6512007)(186003)(478600001)(6506007)(6486002)(6666004)(2616005)(316002)(4326008)(66476007)(8676002)(6916009)(86362001)(66946007)(66556008)(38100700002)(2906002)(31686004)(3450700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRhU3pmKzUwUlZidlVCZnRlSlpGWWc0TCtuK2ZJUnpuclpVY0VmWVpHTWJn?=
 =?utf-8?B?SFNEVUpKdHlYVnRuWFRTWW1kRVAvdnBjNlM0S1NxWnVOOGFWRjlYSHc3cHdZ?=
 =?utf-8?B?aWlkNllQbW90eXA0Y2pBM1ZqOTV3WlM4Uy9jNjB6SEpMaEhKdmtNV21JNTFI?=
 =?utf-8?B?UW1vMjRQYVFHUEZrNnl6c2ZReFVWL3dUY0dFcFU4VFFBR3l1TnRrZ25PZXRN?=
 =?utf-8?B?KzY4OGFnaHh1K0ZRVjlSSjduMHZzSmJNbDBQWEUzNHNSMzI5aE1VMmduZE1r?=
 =?utf-8?B?V1gyQkRjTVp3dkZyQ1oxR21nS0NpM1oxdllXN1NqODIrNTV2TWRwRmovb0Rj?=
 =?utf-8?B?aVdla0t2Um9iQ1ZHc3MwZ2VtbS9tTllKL1hyU2t4TitFd0pZNmZHNFg4VkxM?=
 =?utf-8?B?VzFIbUdCd0NxT3NpUkVMczNlV0Y1ZWZWSUNxeWVvSlJXdHN5ZDVON1RPM0pF?=
 =?utf-8?B?N2hJZVM2RjUyMDlsODdabnZQb1BjcUJtQWRkWkdIKzlUbkdFZXdrTGd6Tk9h?=
 =?utf-8?B?SmlkeXRqcVIra1dndmI3ZGxXRUM4Z2lnSWpTbWQzNFU0RjFTcmQ5eGxNNnZY?=
 =?utf-8?B?NlM3ZEpYb3NJcy96U1NkUjlFSTlCS3paNFhlTFF1a254cktGNDQ2V01FTzly?=
 =?utf-8?B?V2JyVUNkNTl0cmxNczJQVFJCVFRQaFlueXRCc2hYN2w0MWY1ZzBNaVZkVTIx?=
 =?utf-8?B?VHM3UzBtLzN3bjdoRXNTeUdVRjBqTDNhMVI5cC80VkRtUEJVWmI1eFIrVy96?=
 =?utf-8?B?dnUwU1ZtcCtxOWd4SUVBNzg0MndqWDkxYVFFVGRLdkVYekVTaG8yMlNZaWlq?=
 =?utf-8?B?TWJjTVhrQ1JYQ3FmVGNzQU9tZjBoTlRNNHZrSmc5VlBSamVPVzFidG1Mdmp5?=
 =?utf-8?B?RHMycURQWUxwdGV2R3ZXQlMwRk5nRENFczZnRHo5YUpKNDJkalFHVUdGdldR?=
 =?utf-8?B?MGc1Q0NiYVFPNFN4TWJsZDBoTzRQVkJNTWpYS256Rnd0clVMaTIrVGdRMFE2?=
 =?utf-8?B?bW53THJLQjV6dEVrbnBmQ0Y3Ui9TQVgyOEhtd0ZHZGdyeVIwdGJHQTFVZEZ0?=
 =?utf-8?B?VWZ3UEVvQjdHU055MWJzN3N2WUlaUWV1TytBOW1TTGYxc1AwS3dvMWZvdkk5?=
 =?utf-8?B?dFluVlNrZzBHRXhmckpMVTl4ZVA3ZE11L3Roa1RDVGhvc1U0UEF3RURvM0p3?=
 =?utf-8?B?SGE4UkhUS00vQmVFSmtjbjExVFBJSU5QL3dmTjFNUzJacFVmSkZvci9JSURH?=
 =?utf-8?B?SlpJY05YMDhOWHVUWjMrRXN6VE0yRFNmb3R1YXhGWFRuZXVZczdnWGFzY1F2?=
 =?utf-8?B?eE4wQUJ1UWlIOUtJdVhMNkF1bE1UaVN5U2pob3hvWmhWSktQVmtVeENGOGZB?=
 =?utf-8?B?WnZZT0t5YmY2R2E1ZmJUdGFBUkVHcnYyQlQ0RGhuejAwSTVOeDJuWU8vL3N4?=
 =?utf-8?B?Rm4wQlNWZzdQVzN3QUIxcm9HSzNTNmlwbCtFWnY4cDZxdUxZQlVnVnBsRkJ4?=
 =?utf-8?B?SmxpcVhSSXExQlB0S1JjczZaemdZbG81VXBEbHgxTDJTN3BQcUlZc0dheDZX?=
 =?utf-8?B?MmZTVFQyK2hWcUIvT3MzQ25EQXVIYVBqOVZCYnpZVk13MDBGOWgweFlWQkhz?=
 =?utf-8?B?andnYkk5Y1I3bzl5aUl4TFZTUWYwTkVNLzFUL2tBVW13TkNORmllNXhjd1Jx?=
 =?utf-8?B?L0tGRktuYTJ4U0g4Qm9mNk53by93NTA4K1IvMk8vRkVZR3d4T0Y1RUlaWXAz?=
 =?utf-8?B?RjNNU1g0MGZIakJ6TnhqM2FpdTVialdhR1B4WWJhdDhaVGZrdXRBeUZnbjFF?=
 =?utf-8?B?RnR6d1h0Kzg5YjQrZ2xrN3ZKWDYyMm9QanVGU3hKeWRQNVBEMy9Zb3dIN1cz?=
 =?utf-8?B?VEpEVkZzVlF5ekxnSWplTWk4KzZabzV5azJ6ZHQzWDNNejc2UXV5S1VKZUpn?=
 =?utf-8?B?K0xUbFZxT3d3MWFITW5VcDdKbXBSZEh2WXE3VHoyTGxkSXBpTHZIMU03djl3?=
 =?utf-8?B?aUZwUnZxdkxjT055L3B6NDBqNXdYV0ZKMEovZmdFUUlURzJ4M3g0cmJ1WjJT?=
 =?utf-8?B?Y1g2eVpqdHk2dVdiQWY2Q2dyTEJDUm8zQjBLdWVuTndiYXhjVXFmYzAxbndI?=
 =?utf-8?Q?dULA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d889af-0a24-4303-ec28-08daf284225b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:57:35.4744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NMxuttAaeeKoID3jQGTkjIXe9rUQgMSAT505cQYh/8XZqTtO38BpJrvDwsrtqOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ran few tests with this patch on AMD systems. They are all looking good.

Reviewed-by: Babu Moger <babu.moger@amd.com>

-- 
Thanks
Babu Moger

