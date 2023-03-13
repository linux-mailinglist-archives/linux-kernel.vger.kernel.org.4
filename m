Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1BC6B77A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCMMgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCMMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:36:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245DC26CFB;
        Mon, 13 Mar 2023 05:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkskjJWHhIEPMF9dWZfDHqXa1KlJBcDBf4FiktmFxwCiTyQX1xgYD4dc2WIl1aLxmzzgY563ni3zXC5jaAN8sjBlN6FL+OTsLreIGRq9G19sU93NWQWqnKh6JFiCLgX1SzjDCICDKIYJsf4l3q2UsLJKwfVYOK0DuF1KkZq/GQvBExmifEvpEJPu8nNJb68hshTlBxbptygYEkpQZpg8KcIeaUTvUo/CXCRHaGbvNxxWrVlKvAH0/2XKU2zfRNGMTXYS7aAqTH2Qlzmc6kLLPtMP1XPOZLGqW+FCe/FmeuCbVlN3et3qfkmdkFHVRw9AvXoNNIpIhGy1hBMwm31+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQk7OHwBxga00UYdysYTanVh0Nx0c6tXYS4vlUeSaTY=;
 b=SQVyk98CZl+NTA6wdJDxLoSLYHJeAVvfxjYBM+ERuOtuJoE21qiNyF5Xy7v/+IWHwEwRNx8hnQ02xCb4xNvxU/rEAMHHnJwjrJKwhchn+O2eRmQHcJMjHacj1ooTE1xVZIbFxZzqnWanpWCw98KbcIG7hRI4hWwnw/ry+IDQgxlJeDqSnhZ0EKtpgXRqvj3P1DRcD8DoZ5mwaEok0sGLio8bpblfTZsbHNBkstAt616tnIU+r9hykveFnUJ7HPI5g9jXAlm7h/mgtVyEZYELSYg8nkMdpLF4C33uuE//nzuzpkDkjXFKBcSiOvNImHUdnAl2hr5beOwEq/miTZZ3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQk7OHwBxga00UYdysYTanVh0Nx0c6tXYS4vlUeSaTY=;
 b=c4KfKtvFDm0AI4tsZ+LhnUEUkeoruMQ5vfyZVLAjlEU3YTB4wsy7rQWE8Y5t+F3pynPl/0K8ot8HdDh9ZwQWTBQJyFA7RbncE1kpxWqzGoVfPIjwNrUZzQ990jEPXFaK2pJ1EX3c/YLeRGQcJ9RjGzzq2Uxwy8QVmm7+Q3+i/t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 12:35:37 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 12:35:37 +0000
Message-ID: <284dddaf-86ea-f8f2-f2a8-5b7c41a4ca87@amd.com>
Date:   Mon, 13 Mar 2023 18:05:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/3] perf/ibs: Fix interface via core pmu events
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     peterz@infradead.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230309101111.444-1-ravi.bangoria@amd.com>
 <20230309101111.444-3-ravi.bangoria@amd.com>
 <CAM9d7ci_dRrjq==hu5O0wD2kdN5tSJRNFf2ZtDsQ_X6UXZM3CA@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7ci_dRrjq==hu5O0wD2kdN5tSJRNFf2ZtDsQ_X6UXZM3CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 23740eb3-b00e-45c0-564a-08db23bf7269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrSXsQl5rx3rOWj49yDLumgmelPK3DTxOkoSRmITgdj/Fq6cA9x74PtyS2JfTIQT7b5o255yE2tctVIFIBYNtfQYMd7uMIJvrKjw+sr49JvyC0DonRHV5o2kh7wlbrinl4lCOtiWln01T2HDi7jxK4SIz4c3OJ6jGhGumH8WeIjtqum5liN6gQqeSplcoIK82jFeq935NwK7yNc24s8grWdgMPVeafPiRFYpTx87PbTT9PzKbES/rHcuQwo3/kbWqN3RL3bUo1P4zioVw5D07ruE5uKVzBR78oC+LFQGZvwrTfnx4jEPNT5KEBL0qyBI3fdu6qLOB/FDquwP1O9L8reRvfESL0kbv0FA/doyj4cb5TCm9qiDJ7hMYMzOQzW3HEmwCcWNQOZrfb/CRNzYYmzu1GB8JEgUTS5EFUyk8gDlrHVInp5fIWSv25AO0SxxUeQ5IAEMN0VzlMi5nFgq48EmjdeqvqmD66Yi6g9oCD4EOnaxRLdY8eJv6bYUEC4mxLjrZkcssORc/P1X+QeTYevo1FMm3Rfe6Z/R7XCu0EDfDpIB0dIWDguFzWP+qpyxsCsQCq66lus9RKMQZN2RNqChbUrUF8qka7KwHGNYvC5lunRloqietP8prJdZtAkcXVPMZsC7BS7UPWqUA12YkhQbud1p6D+F39Q6GMvcQTro2MeK1KsYQnY+oAgOcx4IG/4FvSmS0Zvkj4gaNdogr/tlxoFtHIAEZRETNd5DjdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(36756003)(86362001)(31696002)(6916009)(41300700001)(186003)(26005)(6506007)(6512007)(7416002)(5660300002)(4326008)(2616005)(8936002)(316002)(478600001)(8676002)(66476007)(6666004)(66556008)(66946007)(6486002)(38100700002)(2906002)(44832011)(4744005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjU5bXp1N1FCamhxNkt1dkErZVhwUFpCVnFHRWxXdUpXWkJVaDl1R280Rnlr?=
 =?utf-8?B?cHRaT0dPYTRqb1BjOVRyRzJsRS80NWhGUDR2ZDBHeHc2djBEblJzMWRqNkxp?=
 =?utf-8?B?M05ZYmt5cnNOcjIvVStRV1JlNWxpRU9pNUZEb0xDdXdDaGI4NjhKK3Z0QnRi?=
 =?utf-8?B?dEF1VmhhSGU3QlpFUkl4b25iMHJxa0RzcE9oL1h6bVA1RTZ1NW5JVjJOcmgy?=
 =?utf-8?B?ZGZ6Mk1PRndJOW5nR00yZVRkd2hNdjJPTkVXWEVBUkNXYmwvckRURFd3NVk0?=
 =?utf-8?B?cWZScUlLRElMeEpDKzVFYTdxS1NEcmc0UmVaTHkrVkgrMjhPWlZuSlZjdGFo?=
 =?utf-8?B?UHRLeStLK0QyS08wbmZORFBxQkZwcU5Udk9hWTBkWk9lTWRVQVJmN21paVJ2?=
 =?utf-8?B?ZGZjYzd4NVF5cURqc3NITGdRNVo3ZWZONkdUQ05qd3ZPVTNiR0JCWitybVpI?=
 =?utf-8?B?d2lkZGhkcVNRTjdJVHEyb3RDVWhjVnJjM2J4b01iVGF5Z1BlZjNTUVhvTkZF?=
 =?utf-8?B?WHdZYkVYSXlOSGVJZklIMENLb3Nwa3hjQmZ6K3hWK2M4UFZpWXhPYzF6ZDlK?=
 =?utf-8?B?aXF4alYzajltNU9CM3N4ZUdhQUtFV25QN1V3cjRhSDlTSTZvV1BpNC85NkQ0?=
 =?utf-8?B?WVRDQUplMjU4VWFuaGxWL1YvVGk4dWI0ZkZONnErY2F5L3NxOG1DRDBRRFlN?=
 =?utf-8?B?YWZ5SGY4Z3VtN1NTN3Y1clZjTTBsbXVTRkxuRzdiUGtsTGIyN0lqT0krYlA4?=
 =?utf-8?B?K0NRWmdIOTNWbnIxMnZtUVkzMmgraFZsblAwdk5YOEVieHJZMDVWdFE1Q2Rk?=
 =?utf-8?B?VDU3Vytxb01uZGVrMkJGZURML3hsSmZlNmtwQlpTNDkzdU56VWJWU3AyNG1v?=
 =?utf-8?B?anIzQXh4c2U5UEtlSU1DNVhSLzNyUWYrNzc0Y3dKWi9JQmZKOXRPZVdOQ0w0?=
 =?utf-8?B?T1duaHZsNWJQaWdzU3N5ZEhEKy9QdGhJLzg4N0E3dDRNb0trZHQ0OXV4Mmp2?=
 =?utf-8?B?cnU2MHh0a1ZGQm5xUTJhOEJUZWdRVjVsaTA2Z2J0UGdHMXpmUnFVeXdnZ3lD?=
 =?utf-8?B?SVdKN29uUnBDSFV4eFA2RllJRE9xTHRuWkNHQW8wOTJzcCtHT3BIa0JGRi9i?=
 =?utf-8?B?MnN3TlF0MnF1djl4ZDgwemNWS0RkZk9BWnVqWWJwbHhLNUZvL0FFTXVldjhk?=
 =?utf-8?B?K0NYbXRtbUsvTDlBcXY3MjlFclordXVqbmN5aDFsaWJwWFVaR0R4Qm1CT21T?=
 =?utf-8?B?eWJzUE5rNlQvckdHVDIxOWhLbUNqT1ZpYytlS0tZWElyL25BSmZkcXd1SnZh?=
 =?utf-8?B?YmZsY0h6UXJuRHdNWWZTNTFOZjFmZDlpc3lDazB4aDJrbXM5d0FiQ2o4MjR1?=
 =?utf-8?B?SUxKbjFmR3JyQUhnMG8xZ3MvSm9pQU9MR04wWXViT0lydmdwanRETkxad0Nx?=
 =?utf-8?B?eEczRzQxRy95NkJEUXczRFRSbFFteWJsRUN3ODU1emNQT2ZWNHZvREhUZ2I2?=
 =?utf-8?B?cXQ2T2doeVpTbGRYNm5XRTl1a3prUTJpdkVOaXZXckJXdTdjNTdjSGRTcUta?=
 =?utf-8?B?TjFkbE9rWGszemlpaUdQNU00L29MbWxQOVdSYjRDUWN0ZEs4QkRLSitLanZV?=
 =?utf-8?B?VXErOXU3VFp1VWVzVjhKTUJmbTkxVDRuUkZBZ2ZlQytTanY0V1R1K2Znc3hE?=
 =?utf-8?B?SnJ4SmV4VVBnbDJRdjFSOHY0YnE3MGd6Z2xJUVZwNE5rNFRhNGRiVTg4NHNt?=
 =?utf-8?B?bFRGS0pDcGZvTjlkdGlabnZLVmk0U1F1M2hQM3lQcjJIWDlGVmhibE15ODJs?=
 =?utf-8?B?VUwzVTMzdlF0SlZiN29lRmtENmhLY3JXTmJ3M202eVVLc3FxamNPbFlXb25M?=
 =?utf-8?B?bG9GMVpud2pqQlBZVXJrcGxpbkdYWjhubTVMa2N6Z1JuSjJjR3RqMGE0U0Ru?=
 =?utf-8?B?RFprUnJoT0I2eTQvcytZcjNUaUZOUHlMVHBSL3lJbEd5UnB6c2UwS0FzN3pY?=
 =?utf-8?B?N1puZDlGTEVpNnoxOHE3V1ppaGg2KzRyZFlSSDR6eVNaRUFpMzU2ZVExZkY3?=
 =?utf-8?B?T2lvMG5xQy9ydEFtS3RyN3BPK3IzSXNZTWVoSjY0emFrTnJMRUhKQmNBM3g0?=
 =?utf-8?Q?ji0YQxx3Ke2dqsKN8tTTy7zna?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23740eb3-b00e-45c0-564a-08db23bf7269
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 12:35:37.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQRR3x6qjzBAOXj7Ji4k1XKmHhgHFatFiXhpm4lFARfAk5GQSmpoNC1eVPzVeQuE6+VcDNLij9kw/O7oONcVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +               /*
>> +                * pmu->event_init() should return -ESRCH only when it
>> +                * wants to forward the event to other pmu.
>> +                */
> 
> Can we add this to the comment in the struct pmu?  There is a
> description already for other error codes.

Sure. I'll update there if we continue with this approach.

> 
> Otherwise looks good.

Thanks,
Ravi
