Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB60674A84
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjATEQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATEQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:16:41 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01E893FA;
        Thu, 19 Jan 2023 20:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzOKWwOEQAXKWswgzfzWlUsJio1tKQvlCgzTYFVRynoBJez/akBbR9bnAfw45k5D81H9P910hf7FThD+SeHX5zCThlaRnq45jU0zYIXnCuxZTaJySGGq16ETEGB88ly/SIKNbnJ1S87/Fv2i+z4oGjRsVV/8Rh9L9TK8WKM7VVHU0hwRegiYXBcrgnvS/pcJPo2poUuLaKvGhtEuDlczusoMyQX/vcckzz6cBSk+7OBUD4n/CuIjzt6sXFDoAYX4EaP64Agu6+i1RUghl4qytg/U1FGZuscYD13naKTcSPZvalPRwraB9Jj0jgBfr5vEtVNTZ70IPpn/iTMhfO3GAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoGX+A8j37Lhz5LRM6rbNdW0qABbpt+z/tE8Ty8GPmY=;
 b=JAGeZsz+yLjGkZ/P751vAi3DFXnoYhSyFBujzqYKDecWU7AkWI/zcHz6sVJ6Xdwm+rGFr7LBvL57FeidG3ZdmrGJmPM/uT1jx0957dasDXtzUwZtyBj/f5PhsSCIuCZ0OUPxAkC+Q6Di6QVXFxiDaYwo4m4FegenubsQ2qtzpHcSh/LgLrfDqwLDnFW5WeV+gWkKXDJZUFAZQdfwlvTj0GW/Yie4qgtSZ/SvPY1C86GTMLRAna9a/EYE89qK5V1F2cdLeDcqpS4w4ScZkYDMeyirzlQCk+67ZvzCxEBxFjInkMtBlS7nn/wodTmWRi6qtY6XrUSlXa8RVehYR8M3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoGX+A8j37Lhz5LRM6rbNdW0qABbpt+z/tE8Ty8GPmY=;
 b=Dt8XsfRtKx51w3xcBW1xsKOybklYaytPtskwblBJnp53ETCVGJMUphZdr1qm3Jw8iIL8gAdWxfNVo0r0fwUZ2IlR0JwPdT79GQvJx9kmTQHxjmJm5ZZWKW2wTs2Sfas7EQMZ0b5rlDUMIIdYxf206zN6wQB+ueQkNp1OWjlaAts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 04:16:36 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Fri, 20 Jan 2023
 04:16:36 +0000
Message-ID: <39061ae2-e8a2-c3c1-7909-9bcb030a16de@amd.com>
Date:   Fri, 20 Jan 2023 09:46:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 6/6] Documentation: amd_pstate: Update amd_pstate
 status sysfs for guided
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, santosh.shukla@amd.com,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, Perry.Yuan@amd.com,
        Mario.Limonciello@amd.com, Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com
References: <20230119115017.10188-1-wyes.karny@amd.com>
 <20230119115017.10188-7-wyes.karny@amd.com>
 <13f7a493-d1b6-481b-63a5-64080a4aee90@gmail.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <13f7a493-d1b6-481b-63a5-64080a4aee90@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::11) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 31603a1c-0740-4681-d9d0-08dafa9d1e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzOsjRhkKk7981uUs8GweWcyQzbptaR28d3/imHf9AUvdMQ8qga88o0goEe/I0+jBgZasjNppSHCK9rG2PSqaQZk9yUUkYiyw4xRgqaINQtxgSF7aYaIZKu+MyzUDPOJlwvYKt+sv9p+5EgWTWn0NA2eDNft2yJT2uTWUTdxk5dNwseyzyo3qGeppRk2TjRalpxZL2HM00Wpx1g8NN/AuaYeIXjZSek2WV+OVFqq0NIS23L1estfCPcaqDyVqnAkfO3A8PKKhKmvbZoyeEcZ3AAKWZOqzD0E/NpsXwh1mHgKsiWX8NxaxANFFQ8fmdW6LKKYzywzJzpC9VJmQZqZVNxSFeakIpCfOfXJ2R8WrBhC0COX51uKm0dB0lLISkBAzEVE5oEypl3Rn2JAJGjhW17jBDzIhjXxLjg1YG2zUkgPaAOM9QTmEjvPManUQ2Mej1j/G0oN2mD4vFpD4++04JGGRonr00DgI7xHTeXo4KXjTxND0m0UR7YDi0BmIM0POS4zN359gOHUiSbsVYUK4UF28P0svDWCWZeELAjAEVcYLcJ18ui03qPgUaGBIYY+/yRzjSXS2DsIFMiZyAoIwYkqNBCQB/iW/bPzLBdm3RnQ5g9BDPFopFXLeqPrGXEVkHeO8UJhvQ5JDW6MXQTAolmLk3Pf7hkHnsi0rig7KerrFDSGAgAorIjgpXDpuDTYQSRc73G4j2F2SktXBH1w8uUiT4EAZ3SaQ5Y10QIi8ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(36756003)(31686004)(478600001)(86362001)(31696002)(66556008)(66476007)(15650500001)(66946007)(7416002)(4744005)(2906002)(44832011)(8936002)(5660300002)(38100700002)(316002)(54906003)(6666004)(53546011)(6486002)(6506007)(8676002)(186003)(4326008)(6916009)(41300700001)(26005)(83380400001)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNmbWxQeFpsSnBoZHBJejJHSCs3TnBrekhtTXJBOXZRM2RVOTQ5bjVZZnVN?=
 =?utf-8?B?RUNTVzhqUFprRFdZMVlIcG5OaW9yYzRVdnNpMlBpd2tvQWxpMUhGMWhxbW1v?=
 =?utf-8?B?b0l3bmhTak1hcFFZK3RXS0owQkIzUmx0SGN2bDRUS1QyWEVHakhHSUVxcnRi?=
 =?utf-8?B?VHhHTnlaWi9GTjBiSXVpUFJBTlFrMmNoNnpDK0VQdG5CWWhFUC9uUlBFY2Z1?=
 =?utf-8?B?Z092Y3VWMWM4MHZsRlZxMWRXK0w1Q2dNQ2FXN1kxNCt4dU1DSHpaUzljMFRt?=
 =?utf-8?B?L20xaXk1MmJzaTJId2lUNnhLdmRIUzZObkpwblpwRGVWK1Q1dlRDWkx6UW1p?=
 =?utf-8?B?Rys1bzl4TmJNbkhDQnIyei9NbjI3cEcxMEFRWTlIejNYK255NjZWeldSZ1ZN?=
 =?utf-8?B?WDk0VkQyWjRYd0ppcFlRS3NFSlI4VWRxZHFHaUJpM1d4WWF2cGVjQlEvT2tj?=
 =?utf-8?B?UjNPOHdhZzBIZW1XZFYzY3N6QXdZNWszM29uTnhjVHhFVUl2cDc4Tm5ueEhO?=
 =?utf-8?B?ZXR6N29VdEYxZjI2THd6VGdzZ2VxK3RqU0hiYUtyTzg2UjM2Qm95a3V4ZEN5?=
 =?utf-8?B?OE4yRThXS1FCR2sxV0RXU3ZuQVI4Mk1LQmhvMDVlQVFBc0E3ZFJxZGFLcjUy?=
 =?utf-8?B?ZGJ6NFBUb0J5dkZKSFNvbjNHWlIza3lGMlBKN0U0V3B0aGRxWmhla01MWnNh?=
 =?utf-8?B?VDFxZ0RzWlpib1VGY3ZITEl1bWdiUFJZNFBrU2N1WE1SN3pjSk9uY2p4WURn?=
 =?utf-8?B?UWpOVlhiSmc3aklqVllrVnBreFpKS3loakVLSk9sRThiTzVnSDBIbW93REp3?=
 =?utf-8?B?cFN6VFhLYWxXQlU4VnFHM3kydFJucGZTeXVBYU9YcTlOZWREWTVRV3FEcVIv?=
 =?utf-8?B?Z1p2ckpIYWZnR1I4Q2Y2a0NWdmFYdzJqWjJVUVZTRTdOY0xOZ1pHUHBIZDJu?=
 =?utf-8?B?bUFjeTdPdGhCaGxHdDZtZXM4RmVtNGJzd3dvbmdGOFNaVjBnaHpnbzFDSDBF?=
 =?utf-8?B?QUhaQU1DcDZrQTFrUFNZVWI2YnJndVpsN2d1M3RUL0hzZ1FCYVN3bjBOeVZj?=
 =?utf-8?B?VTBxZlRZb0s2VmtCKytJMlVGdE9pWlFXQUdmeldLNEJuNlVkT21MV0VoZFdq?=
 =?utf-8?B?T1BGcTN4Mmk5V1FnYVI0NVhTRnI0clFWN0lHOVBxMTNLNjRVUEIxanZDYzVa?=
 =?utf-8?B?NFBNd2xBUkc5NUp5YzRvUmVDSVFsand2d0hXTEFDdkRJVWpHZlJXT3hPRmJs?=
 =?utf-8?B?N3JsY3VZNmJNUks4VWRxQVdJUlJ1c0ZpbmFSazY1MUtkRk1NcE5xaXl0SlEx?=
 =?utf-8?B?d1pxa2ZrVnhKSkFQTlBlKzdVaVlRNXV0K2E2VGJ6Tk1PcVZ1bUZrTXVLdzF3?=
 =?utf-8?B?MHhpcGZIM0dsZmMrNmVYdS95S2JLY1l4TjlXRGtRU1ZLa2hzSVBWdWVXS1N1?=
 =?utf-8?B?SDZLbko2Ym44OWo2NXpmNTc1ak5TV0FDVUtYekZoVnV1eFRTTVpLc3hGY29I?=
 =?utf-8?B?VStNdldQRjh3R0E4YmJJcU1QUFF5bUFiVncvMFJMS245YkhDVDJjWnZuWTRO?=
 =?utf-8?B?djZHZ2FGUmp2ZkZ5aXlaYXlZTytEQ0VzQVFzOHhuMGFRQXBkWGhBVkJlMHlx?=
 =?utf-8?B?M0phTU9oZmJhQU81YytrbFE2Y0tsSllxeVJ3OS82MkZLUFVhUGpCVDl5T1pk?=
 =?utf-8?B?Ym1lQ1Y1WFNMZGNjR0dUWjd0RFlScTRLWUFoTTliQ2w2ekJFeXJlWTViREpo?=
 =?utf-8?B?SEJPclc1QUlrcG5xSzBwSkpxSEhUNDk1Sjh6TEQwQWhUbmh0L09EQUdXTUVV?=
 =?utf-8?B?VDR6NHM2YjFjd1dOb3VndXppbzRPR1lJL2ZYSXJOMDNlMjMzbkNkbjdSZUhz?=
 =?utf-8?B?OXozdmllcXVIUFhlTUMzSS9ud1FESmR2UjE0YmtFWitMb1pyN1lBMmZHQ0Zn?=
 =?utf-8?B?WjZKcTBsU3VCbGo0QkdTT292alB4M0o0bjlsUlBlVDIzL29tVXNYQU4zSWxH?=
 =?utf-8?B?b3NWbG1IM0ZZU2kzcnpKQnp5R0VBS2R1SUg1cWZUTmdFUWpvbGFYQVg0MnVV?=
 =?utf-8?B?Z0NDMDBlTnlqWDRnTWhuRU1sZWhrcDZ5MUdDaitablNzSXlpZFNNcjl4QmJR?=
 =?utf-8?Q?bThuo5S55Sl/2Y5BcDEM9eIsW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31603a1c-0740-4681-d9d0-08dafa9d1e81
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 04:16:35.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EF8q7vd0oOHZ53kC5lQZUsQeD0Z6+Xj/CupUqseAWRcTJ9o3Fwcd2w5uINH3w1j4mvo7+PBbwWqOL/sVRZ8D7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 6:00 PM, Bagas Sanjaya wrote:
> On 1/19/23 18:50, Wyes Karny wrote:
>> +- In autonomous mode, platform ignores the desired performance level request
>> +  and takes into account only the values set to the Minimum requested
>> +  performance, Maximum requested performance and Energy Performance Preference
>> +  registers.
> 
> "minimum, maximum, and energy performance registers."

Thanks for reviewing! Will update.

> 
>> +- In non-autonomous mode, platform gets desired performance level
>> +  from OS directly through Desired Performance Register.
>> +- In guided-autonomous mode, platform sets operating performance level
>> +  autonomously according to the current workload and within the limits set by
>> +  OS through min and max performance registers.
>>  
> 
> The rest is LGTM.
> 

-- 
Thanks & Regards,
Wyes
