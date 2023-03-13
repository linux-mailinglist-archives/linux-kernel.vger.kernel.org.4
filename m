Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A692F6B7C38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCMPl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCMPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:41:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4C474E7;
        Mon, 13 Mar 2023 08:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btRpvVtAqAdo4cHeQz2ufvyWsnMU+Z1KdnIMGYvvMk6kQDKhaO1oQPAgWTqPCEuiSO6+0LkvhSMbCTf16jG/iLrSdGkdNKWzyTdU05NG2Bz6GUcdbiyglY71Zg+Qg6baTn6VbgKuzjNer1f5TvLgZ62p7Azd89/O+0CpoNV3OnmhlUrN8baVg0sbasEfzqQDfa1eBOFROK5XjwPTp7LB7SvD0pbGlkO/TnyHtPclVtp4DE0IzlF8wB5My8VDgu6cvaH0mk3DOTVCDZdWViSrxlHR1YlJtmsTTsiiLZg0WFjXyMQ/DlCXD/TiYVjeXnyivFEKKp8ZgbtbCvI8ABzTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYIfbtdjMRmzARo3S5LAImFWIrCDDihUyGboHIb96bo=;
 b=aa1KpaC8cdhJ+h7hj/mn8Kfh33m2+b9rdKtdmZ5wMbdi2MEzN1pFsLZojAkJ0jpV9ZGQNja6CFoWGO11FQSqPohjqvH2BbP3eqRnaxPR1fSlcsY8m0jx4o3hLbCiL89AMgSWzJxea4SRyAwjB21ECUdTBO38uRHORNjSRx1ZzpPg8jUabG1ktkTtDbpBGpiurJqY0W9SEpK1+C9wfXq835LxKA2k1w5mi172VgbTizNKGFxMOKQ2TK18GZyb7AkvDrcsFK83CoVno1uUFikmoKMThzbhcG0Ts46oMHWbD5WG8rOk/qPaJrkAAq7Lg/F38Xi32nnebBc+vFXNxi+iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYIfbtdjMRmzARo3S5LAImFWIrCDDihUyGboHIb96bo=;
 b=omUDjMDxA5ug8cuH1PdwATEdRVaLIN36P6HHloqRkmUdo1l3FK5BdqP9NCEmk6/ONB+NI5w9rlDZp9+Dx/ENWqVUh8i4zq7Apdod6sggLtcAeq3AWfYj4O1MKn46Nbih46B+Qsy1cIRcMENvQ56HtauEyXfChrio1kpOXpajiKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 15:40:48 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%4]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 15:40:48 +0000
Message-ID: <838392a5-0b60-4b43-6d5f-b97524f6f157@amd.com>
Date:   Mon, 13 Mar 2023 21:10:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/3] perf/ibs: Fix interface via core pmu events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230309101111.444-1-ravi.bangoria@amd.com>
 <20230309101111.444-3-ravi.bangoria@amd.com>
 <20230312145426.GA1757905@hirez.programming.kicks-ass.net>
 <45de7e62-d951-1019-990e-6df285a64cf6@amd.com>
 <20230313142156.GL2017917@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230313142156.GL2017917@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b479079-f325-4338-3e4b-08db23d95151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIYrAX5DG51SalXaqimwm2SgpBE8zplrXaXdpzazKc5CRJTtFFJG/6SVZbO0n0i4zPl+L1i5ZBDR98ZKI6qsFKAQ2ShMrXs11L0u2TsBE1sFZ7igUp76ceHQFsQMkotTx/n7OVUHea5wLNtiYrXTKZ3z6PY69qRo+cMJ7/rQmBH8GF43Bl7Hx2/i8e58clbayTXmJ7nOYXlZdbGmJed14gxLPNPfi2Yt3d9QXR6L4i5DkfjQcaVT86ZP+8DJGIn8pYO3WW/j2+NHFSB6mwUuaZsqoyGrkxIjUuj1UJP8tj1lD66EWUQPfsElwsIRiDcNvI1RGAJuzGTub4tMY3+/+XOzSga700m78DmhXuZLWKUpOY4L9PrZzZhedAoyyyh5dUemdiyPWVwePlETusEUirnOx5OcWUMlth/tcuriM4qs/IL11OO+5zOCvtCeLr19QkMxqty/zbiMAYxpZ8IKDRFu8G+pDhLQlLFTzuXwg2CFG80fls/eCnNDqRHuDSP5mxppsYiXOnG5e+iqoczN5fDe2xD6utKM9oitDW4bH0yicDGGlBz9b8tGLeL+QTe1Jy3I/SnSU3IUp8CFqejEVVMefzgdfV9HSXs68c6MDcrsESze5DAkDTWmaudtKrB03ailtmyPnfdVAKOMf3Upo3i2+JwCAt4tteK0528sHbGCYbfhZ/vkXpVU9sEB+TpgSPxKw0JuZrShoZ7EmTDMjZgKpe7ZBSqQtw4PYAqrhtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(5660300002)(7416002)(36756003)(44832011)(83380400001)(186003)(478600001)(6512007)(6666004)(6506007)(6486002)(2616005)(26005)(53546011)(4326008)(6916009)(66476007)(8936002)(66556008)(66946007)(8676002)(86362001)(31696002)(316002)(38100700002)(31686004)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkpWbHNXNWRnNWQ2VlNUZU5hRXY0YzIrWlBLVzhTYnlPTUZPUy9hdGh4NTE0?=
 =?utf-8?B?Z2pJMmx2R2NrRWxLdnQxcjVMb1Z0S3JMMWdpVEdhQThQTkdQMEtmTTI1UVR3?=
 =?utf-8?B?eTdrVkdFWVlPSTZMZ1BOZTM0bVlCejFMcE5MMk5PUGluVTh6YnVpbnFqd25p?=
 =?utf-8?B?L1BSZThCUE1Pak5YdCs4WEVFbHpGajdLOHJrNUlRaWJNV0J2elJ4bS91Vlkz?=
 =?utf-8?B?THZjUUp5WDUwZHNRVElJNzBlaVIrQkRhSC8zWUdUNTdVVjJqRGhRMmRtNDRn?=
 =?utf-8?B?bUFvSkcwbGp2VzRlUXFtRUpQc1ora2dleWIxRHZsR1c3VnQ5K2JQT1M0eXhJ?=
 =?utf-8?B?T1k1V3doWXFIeUJBSGIrNE5Yd1J4c1Mwak9weEVGSytXd0t1a25tYnh0eDM2?=
 =?utf-8?B?bXZHdG5WYkloK09aTGdaN0lnYjRtajZwR1FCcEpOSlBLODJoOEw5dUNQOGhO?=
 =?utf-8?B?TmdObmRYMGphZXh6aHRtZmJpY29hODZZT01RbHBETE1sS09SaUt0ZmY3SW9I?=
 =?utf-8?B?bmgwV25LUmp6Ti9DOTZocUl4NUZXeUo5VTFFUHpjYzdZNjNTWWhQUDRuK2NY?=
 =?utf-8?B?bjFabUxHZDhiYTNKSFdsNmJwK24xVTFjd0s1K1Nzb0ljWlJ6MWYvYm1WRkRi?=
 =?utf-8?B?NWFJbGM2NTNlZ0V3b1c3S0M4UVRBUDJncmVyK0pTSVdRTmhaekZ0MnJPendj?=
 =?utf-8?B?ZVdGNXpqbThySWt5eHhBVVVVQ2lnd0lMQ1ovenk3ZTVuRmgrenJTc3hReG9B?=
 =?utf-8?B?NS9IeW1zNDVJZC9Tb1lzcCtnVWlySVBmcGRxUzl1Vi9EYmdrRnYzNTlSYkh3?=
 =?utf-8?B?bWl0TW1FVE9NRDZsbHBhS0lBemtja0hrVS91aHpxU0pvZk9VRG9ZeTU4bDMv?=
 =?utf-8?B?TEFiWXViK3ZmUHUzV3NOU1pVa0FweWhpQW1FS2ZQOHdoZ1RNR0xuSW9WN25N?=
 =?utf-8?B?WHROZHJMbXlBYUJvclE1RjJBZDVUODJIQnQ2MnFXbDVSWDRXVGNYclUrUUNF?=
 =?utf-8?B?ZEEzeWYxMHlyZGdVa1g5VnNMcnEycWp3a0NRdUsxRFV2OERwZk1Yd0hleWZp?=
 =?utf-8?B?c0RDelFzS2xPVk1TWitUK1ZsT3ZDR1ZGeGVUcjhUVEc4aVk4a1c2ZzM5VU02?=
 =?utf-8?B?MjQ1UXBZRkNtWWV4emxKbml3S2F6RXQxS3lIQ0o1eVVhM1NCWTBKcGt0MlBY?=
 =?utf-8?B?ZXlXNXl5aWExR3hZM3BFUlZ3ZmN3WDk2aW10Z2VZN0M3VUExanFDdFNYbXM2?=
 =?utf-8?B?eGdraUNvZVE0eUZaVDJZUDY1M05xSENkVkVSbUlUSGYzNm9PVlNiNXlXdmVs?=
 =?utf-8?B?bWpqb1FOWEdiVE1tK3VuQzNmTzFFTm9RelBqbHVHdTh0YVhuV2dvWUZqcytl?=
 =?utf-8?B?cTlKRk1ESzdjZEJNcWYzbWJlOEZrWEVqU3VYbjRkVlowb3R4UzJ2b25wU2Jm?=
 =?utf-8?B?ZW1DbnNEZzdLRUlTYVJ3aVNUQ2NNNjRRZ0FhcGt4QjJ4SmI5UGJ4QmlQa3Rp?=
 =?utf-8?B?OVR6UTMyQTZhNnpacVBLMVF4ZE1nU25DQUVxbVNZaDBKbXBFRktWSndNZG1E?=
 =?utf-8?B?NzBMMVNWMERrUmExZVpwOUV4VG9wbW1tejgyNkpmOE9GNjlybFROS0RJTXZ4?=
 =?utf-8?B?YjdDL3dMeGIweE0rUDdXRkJKZmxvbGhHRzNvTzJ0NjZsRWdIdUdpNnZaeDFt?=
 =?utf-8?B?WGxkQ0RPN1BabmNLeXhCQVJLSFB5RURiaGhVUTNjUEhGWktYRWpKc0NxbHli?=
 =?utf-8?B?WWFERDFlWGpDa1hiNDFUMEp2R0FFR2pxY3ZnRC83SVpMMnY4bzJsZDBBN0JB?=
 =?utf-8?B?U09MZ0RnVVpWSmttNm41OXVvaGl4ZUVxbithTGVGTEdnT1BJUjJ6WVQ1aG55?=
 =?utf-8?B?cDlvVm9zeTMrZ3N2TmtYV3hGdm1ZSHE3dTNGRWtyRW9OaUFSdEhmN0tHSnJX?=
 =?utf-8?B?aldrdXd5NExLTjRvUmY5N3BIOFBDZG1iWDBScjBSWStPSHVsajdZRFU0R3Uy?=
 =?utf-8?B?cVZBRFV1UzJybGN1MVdVZmZQK1IzcEhybDh2em90MzFwZ2RaeFVpNDNyMGxl?=
 =?utf-8?B?bFFSREdFelBNeEJZbnpqcGRUSGExbzI2V3FNMjEzUVhDN1c0S0dNMi8zSHhL?=
 =?utf-8?Q?wLVRXunr5cSUptsyrIYk1XM54?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b479079-f325-4338-3e4b-08db23d95151
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 15:40:48.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdQ+6K4/cHr/Jzmd+m7UzGowMIG9QQ9S4eWN1cVka5gIH6y2rZmOA3leznJsmX3X0zD9YNn7JNang3TMFBdgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Mar-23 7:51 PM, Peter Zijlstra wrote:
> On Mon, Mar 13, 2023 at 05:59:46PM +0530, Ravi Bangoria wrote:
> 
>>> Now, we already have a gruesome hack in there, and I'm thikning you
>>> should use that instead of adding yet another one. Note:
>>>
>>> 		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
>>> 			type = event->attr.type;
>>> 			goto again;
>>>
>>> So if you have amd_pmu_hw_config() do:
>>>
>>> 	event->attr.type = ibs_pmu.type;
>>> 	return -ENOENT;
>>>
>>> it should all just work no?
>>
>> IBS driver needs to convert RAW pmu config to IBS config, which it does
>> based on original event->attr.type. See perf_ibs_precise_event(). This
>> logic will fail with event->attr.type overwrite.
> 
> amd_pmu_hw_config() could also rewrite event->attr.config I suppose.

This might work. Let me try.

> 
> I don't think we actually use/expose these event->attr fields again
> after all this, do wel?

I'll confirm this as well.

> 
> The closest to that is perf_event_modify_attr(), but that is limited to
> TYPE_BREAKPOINT for the time being (also, could this be used to cure
> your in-kernel IBS usage woes?).

I think doing it transparently at the arch layer would be better.

Thanks,
Ravi
