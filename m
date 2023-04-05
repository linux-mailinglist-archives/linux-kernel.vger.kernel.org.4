Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976716D8609
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjDESdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDESd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:33:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6C59D0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkCypP4yjXSzjj5VtWPmtJpStZ9EhbLGKgYBYdWtLxgDmySlV7OrH+WdWeGXALC7zpjbXKH8DwtgC2LTokRf1nNp4r1LipYDgBHL+jbS+riwjlH63R5dVxwEMRpjQjl8L8Je2IyS8HQqRs6g7hDZIFYlUIqYON45aa8QKsjHtSYAgcpH3+Ge3nwZ9gJ3xb+k5wypy32WjFtwfpXkD1B4gZ9QM1Bdjvh+i+KTYeJWOggaqRykGeSccbB+OPaLfr7EBv/yGHFm7yYkZGKg69/OJp5rt3mGaybYlf98q8fdfaifJpvjo0bR8JOf7DJM79pcaeF7TKddARRudAoljt5Z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgwTQQWnt2qvR/p7vNdhh4Fog3aGu00WHNaMikQB2wU=;
 b=kTbehRUR6Lm28cBUpr8X2iY0tLwj6ZhFU7Evlal8cetUy8cGMVEKFr2C8y29b2/Hgd6lM47gJfSMFy1IT8lox5CyiRoAUchD04zQslX5AkPu/RME9h/NTJTSN2BHVFiPFyMNgerUwzCDEsxM5dDe07RbnM91iCstf3LZXtbZ0bB7S5+EGyc0eK5bzWPiTc0y7WSf4vwCSHBVX4DOZp7dN+3XclO5dhkVCu7J8jDBQuWNGBIxn90caYzTzDpPVYBdOGKyY/wONie1Y/nia48Rlpyy1C55CuhRMo1wpY860JcspeaAGnIPiMrDWbpPI2C13XcK4h0RZVa3LR/RPzc1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgwTQQWnt2qvR/p7vNdhh4Fog3aGu00WHNaMikQB2wU=;
 b=B8JQkJjD3XC4c15fXTz7yAL3VcV7EDy/SKzAO/6Bq+ypl/wpsUiPG5uCtV4ef8zXghzS9BL2iUza2aA7tlZrQBMMiuccSlDNlZI659y8fT7Utcyyhi8y/ScY1z9snB1pXqEZ2kIBJdKmveYBfoXOa0rx3sgDc642cbLegDsrSRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 18:33:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b%6]) with mapi id 15.20.6277.028; Wed, 5 Apr 2023
 18:33:25 +0000
Message-ID: <05c682d7-bddc-d990-37fb-cd1779f7e604@amd.com>
Date:   Wed, 5 Apr 2023 14:32:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     yazen.ghannam@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
 <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
 <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
 <a8826972-376a-5af6-8e61-d74520e355df@amd.com>
 <20230405180648.GEZC24uJ+GSMZxczaW@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230405180648.GEZC24uJ+GSMZxczaW@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:408:e3::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BN9PR12MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c15fd60-2f46-4b1b-1b8e-08db36043dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mu0mLSgIzN4r3F1/s6VHKOJPF8EH+UsO34FgoHBPw3geIFbgxdUPSLMuZCaW0ccAMcun81TOjKbbFW9KBudRZnujWuu2xuH13Hn05bNOCxBWDFdmmcmAGGoLbhM1OGZTcB6p9xvIekPEuQNyEZKkphWEdljtzHSNobPTh5eKUqGsj4moVg52ozx/HPQEr6uQvSns7/UpJzCeneOFtrmGfZn2jRohh68+pfJlROOezYJv6WTtItonFJheJO+3CQ8QHd8qpgjWAASfgiVE1aJxnzoHw+1g1RxKAudrZHdLaTxiZM7VE7BKiwyIoN5RvetdnZZuvbZh/nU5WIVV+viIrCL23J4M6URkU2iv/Bk53J1JHbem7w4hdSn4bCwxH+nMC3a5huqlpL/eex/Bn5WIQXQ0knBrgMYaH61X3cosy16wM/LJGexG6+spqZ4jCNkB+108UrfnYjWeQ3kxnIDEFXBgx3q8W7BIAMlL+iy3L9HnRnIDsuN6ck+C2+z569RgL2WBhPjJjM0xdZrVl/KFEuSrVHGvX8sCKkRZaBIet+x50o8kPPyzCYS878/9/e88iwe9bdrfZ217aLy2DNT79Szie47sAj2lPxE5JXACBLmxjZhAQELMtH1koS9q3JMIEfAzlFlnTvyk11hOCD2Tow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(31696002)(86362001)(2906002)(36756003)(31686004)(6486002)(53546011)(2616005)(6506007)(6666004)(26005)(6512007)(186003)(66946007)(66476007)(66556008)(8676002)(4326008)(478600001)(38100700002)(41300700001)(316002)(44832011)(6916009)(5660300002)(4744005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3o5aUVZcGU0dWRFVE9KWUhyNVE0VDFBRFpHa3owVjhaYTM2aE5kT2dtNlNP?=
 =?utf-8?B?c09obTB0a0Y3U1BvYnluTnpIQnQzcnlSRnRwT3NBSkdGTldXWDhoYjVEWSt1?=
 =?utf-8?B?eHZtQmFCZld6NW8xeUtjaVl0NHdVS2VabGlpcDIrWjBFSGphQjd2Zjg1TnNp?=
 =?utf-8?B?OFF4TFZva2ZiRkNHS1d2YjZDZERGT1RLUnI0eXRid3E3dkNzOTQ3N3p0aUk5?=
 =?utf-8?B?aG41OVhGRFRITFB6Sjc4bzJ5SEsvczQ1cEg5UGo0ZThOYjkvcjVQVUJmYmhv?=
 =?utf-8?B?Zk9QK3dmeUZmeFdEbXRvc3ZXVmlnbmZqN2JJQTltL2xPVVBObEVZaHRZQUE2?=
 =?utf-8?B?bFlVNXpsQlFUUUhZQTlGUEllTlEwaG1ydlg1em55TW9SbjZBK0JlR0VwZWlI?=
 =?utf-8?B?cDNCU3BkMlFtZXpRMDU4T0JjTlF5OURER1ZPRlZteHdkUXNGb1RPeDJ6UlIx?=
 =?utf-8?B?TGpwMjlYaE1jSEdHdmhGQ3A1Q0p1K1RFbXF2MWIwVXIyREdRV0pWbWkxL3dO?=
 =?utf-8?B?RTNLRWQyQ1F3ei84UHBJYld2QVdIQzk2bnl1UnpzR0ZObHRDTWxlSm43UXdl?=
 =?utf-8?B?eUFtdjNpWUlRRlA1RG9JRU80L1p4VVpZRWRHZHVvR0JnQzFGRkhCcWs4cnBs?=
 =?utf-8?B?YmZpSGVyM05jYmx0QnpOTUU0d1AzNFVPUGZVdWNCbk91RGVYMmtSSlJzWWx3?=
 =?utf-8?B?QkpYeDdBaUJ1dkhyODNzY0d0ZlBNdzF1WnhLTktNeVFnNUViajFBcWR3enhr?=
 =?utf-8?B?a0Ewei8vbFpzYkQ4dEF0dlpSdEVCc1NoeW15NjQyazI1N25SOHJ0RDkxdExJ?=
 =?utf-8?B?Z2loSklFZVZ5YjFNRXc0dTZoRTFYT3pVOGU4UUdBQnhOTFZPTW53bkJpWjAw?=
 =?utf-8?B?SzliRHdwUEloQXpxKy91OTZLSy9GYXZZa1ZSVW5KZmo3ZkVnSmhvZU9YMUxI?=
 =?utf-8?B?aWwrZXl0QUZyS2tWeHNCcUpXMEs3cUlRR2RwNDV4UDdmNEl0d0xZOWM1WW5z?=
 =?utf-8?B?cmV0bnNXNElzdzhaSmVRQ0hKRXp4eFhaL2NDZUVDKzJycW9naFZGZFhzdHI3?=
 =?utf-8?B?RVE1dkJJZE1BNldZcUdQQjFZVUppOHJjUEtIVnV1am1SNXZYdFo5ZjMwbHFP?=
 =?utf-8?B?OWdhM1hGcll0aGNxK09Hdk01Z21mSnBHWVN1eWk1b1lWMWpWbjRvMXJ1NVRq?=
 =?utf-8?B?MWVGcjhJbk80cWsyY0lGTmRTZlJLd09IQTRrZ2FjT2FMVEtHekxEcTkrOEls?=
 =?utf-8?B?RDZGNjU1U1JlSThjcFhqdUdDTUdSNEZ6bkxneUZ6ZXl4eVEwZGhCWFZxWXkz?=
 =?utf-8?B?VGtzWXRUZithVWI3VFpjOWx3S1VjUHN0WjRLOTJNdTVwRWtHVkZleFNpbUNG?=
 =?utf-8?B?QkxjVkl5NzMzRTNuL1Q0WFo1dTdTaVFJVzh5S01XSkdHaU1BM2QyUXhuWGNJ?=
 =?utf-8?B?cUVIOWdZSE93dVhOMzA3STd1bEswNWFXNjRYS2NjYkxpaW4zR3liRmVHUjVY?=
 =?utf-8?B?T1hydXN5RlRVcUlMYXM5M045Rjd1NXlnZFdyMWJNYkdqVHNmRDY5UE1LMFdo?=
 =?utf-8?B?ditYRjhWc1ZPZDFUY1piZ2xqQXd1OVVtWExzS2k3Q0ZIQW5EQmtJUytKcVY4?=
 =?utf-8?B?eG5FaHhQaXoyNWlZYUIvcEExdFluWm12Y0E3d2VoakhYWnRTc1ZKMzByN2cv?=
 =?utf-8?B?QllFRzh1MTl5WEhzcDJBOEJDWStCdDArRExjaVRiVVV2dEVFUEUxek9WK0ll?=
 =?utf-8?B?OVlSS1JnRGZ6aEZZbzlMOVh6RGY1WGxTZkZCSllqZzF2OHVNdUNDRFI1K3VU?=
 =?utf-8?B?a2VOcEh6OHVKYngzSnBqSE56eCtlUEFLdVY2L1d0UFdoUEtqYnNQelRMTThR?=
 =?utf-8?B?TER0OTVnd0J3RVQzZ2NNSjM5WmJTRXNuanEzVFRmb0Y3RUxHNjZyeWxlbEM1?=
 =?utf-8?B?RUpKcnhrYjUzdzF6UlpLdE1WQUNOYXQ4U0NDVmxVUHVPN05wdklUbEFaL0VL?=
 =?utf-8?B?NUxRVWN0cFZweDA1TTNxWURsTmI2WHNTWCtNMUJNcnRheVdqUHh3YkpDY3pw?=
 =?utf-8?B?ZnRUNmQ5R3RjR2w0bHA2dGVTL0o5WnFYMDRFL2JzK2JsWE9leUN5QWp3bkdS?=
 =?utf-8?Q?WnaIwOCEULKtWnTisqeZWoKgB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c15fd60-2f46-4b1b-1b8e-08db36043dc8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 18:33:24.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEVOejf51L5cyW0+qBZwWKDo9DlYshMKtU2cjbstrqsijkHrvyf9fVgcHLPOosccbtDH0Yy10Y08Kmzp7y4P5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 14:06, Borislav Petkov wrote:
> On Mon, Apr 03, 2023 at 05:36:40PM -0400, Yazen Ghannam wrote:
>> Yes, that's fine. Should I send another revision?
> 
> On a second thought, I think we should do what you said in the write
> function too. Because the write can fail too. So if it can, we need to
> handle that potential error too.
> 
> Care to send a new version which does this check in the read and in the
> write function? Basically what you had initially but with the write side
> check added too to amd_smn_write.
> 

Sure thing. I don't have a real test for the write path. But I'll test by
faking it.

Thanks,
Yazen

