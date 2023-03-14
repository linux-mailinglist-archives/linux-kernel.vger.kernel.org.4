Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495996B9F34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCNS67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCNS64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:58:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41B1F4A7;
        Tue, 14 Mar 2023 11:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfEDZGeo60igwC/6z6ZYDiY3QGwOsOH7HnEONwDdBSDwX6Jir0lLCmc/8NwTdd2y5A1nWVOBBZ1Z9Tgjoc0NUV5PJsR6MF2cW3BPt5JRwtWYe9v/92tF4893YTMARGmeIWqMBwRaObEh2hCy+g28K/G4tDPUbI43bcrBf0joWMuokQDqDrwqDcjezQXrDfDzgRr8tRP3e4uL2bO3bK8sQf3ASca8tGBqOEYBlu9CaTyiutU4CuYY3Rp7/8wVzgDk99SiH1gPFTj3G3pBRQPOJuWI8S5NwhisO9cSFDXZE7KDYGm9/J8/RwjIO13+RZLSCUcq3m6SgpX4l+8ZzjsZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvrC15YF0lVufsBPRQ0RKKyZVFN2PCR4Ixl2YdydR9k=;
 b=eMoJpUtlsQtZ6lDW9eg302gzQj3viw+lapMu2tFgBoP0JeBnEtVT7vV0GtfPUXuFKrdPb2Mj1BOCoSqDofgrjwlPy7AN3JjZV94FgvPzzkmT/wfZPFT5/qcZLa1tcSso3UStPG5uE1hlh7fHHlhLlVUxUU0tg9+IaHpDZJhCP10idKSmg3Xg1vXIPIs2dKjQr3G6hc/51+GgJt7JOfaOl2zTI8YSlkD3gpvzCkF75Dxo7uvKv8csBtePvOvv65BJehhE4qFxDEAiAvt6oXRD/LP/V9UmV3LPcQNeQ47ca+2QUpQ67vfVQ4lbozUmKCEuVKDlq5Swhd4ia5ACFJFdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvrC15YF0lVufsBPRQ0RKKyZVFN2PCR4Ixl2YdydR9k=;
 b=GL/nNcDt040+AvacFGhyt/C1rtQGZPdIKD3LfM+lfDhVl1Rl2ulvUGVuhsM4eL+/Th2ua4GCmmydNWYIJTxpFePqWhnsJOT7qdZhKcuXerN4EvfdSy9qaAsfqjGKlY8KJYGdoavlXLMjRXEVmitBAepigK+GYyfV6AAYRRAWfCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 18:58:51 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4%8]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 18:58:51 +0000
Message-ID: <7c814d11-1545-867d-afa8-1f11913eb134@amd.com>
Date:   Tue, 14 Mar 2023 13:58:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] docs: Add relevant kernel publications to list of
 books
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     kaiwan.billimoria@gmail.com, rlove@rlove.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230222183445.3127324-1-carlos.bilbao@amd.com>
 <a577b165-1e18-e689-7580-cac3f37317f8@amd.com> <87jzzjqhym.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87jzzjqhym.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0028.namprd20.prod.outlook.com
 (2603:10b6:610:58::38) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbe7b3c-1577-4a10-8499-08db24be26af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHQsCMM4qnAEDxoS3KsOzU5NzUPxIfQGps24qPatf5bmmikn7hw/ncKW/F4dqLwzTn0COFnN14xqrU6jkiki/KNVoLRhMwlgiXJjbUiNstqtB4gX/SPiLtO1i3DBXLv2xixBpm/nGMKEKzEkewgA0PJgS6xOD/5zUtnFrDos0HQW4VjNXPSewPgoYyjeiBLGT7uLthG9f6QYLCvxcqJKjo0ZZA8UWSC+NcYxrPy6b/Nznp2E3phQDDFfv4EO0g6XYvHsU+9uuNucr/2Yn9VOB1c+KX45egn97+6rHVPvsT1uQGuFcDOqi4p7/8jBrVDSK6I5j482pD7AGrEwBPfZm1Zu3U/08+nTABNLM1Fpqln9hO+61Q04yHNGdMM5B4pYsDBOJjxANtDdue9zRiJQHS79CzwVZ1wuK5yp+MHDn2WMHJUxO4pjeuLbMQVRlL/UnMtKZVcDJFYGqJx9DSJ1chkv8j1CkfGI0mv0avK7wf/mdKh4zFoDvqITUU44WznB3BGdanI3jBurQvmVwxl4zi75XEnkHkHCzbcJouZzecZNVINe545NlbAE5FUBPMcA+Li8C7TLNe/SLfayi9XLnapErrvTz5aqVpI2466GRRRGY86HZmgYtwHv9qiSQTJSfZcfvXokBfWaHaiuCQJKq2ooqYrVuIbki8D/Zom+VCnJyRq4LU2t9BGjOqp0K6OtzBUNWM8dgL+pHo1hL2t1yT6dCjRrnU1i+XO5rNmrKds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(2906002)(31686004)(4744005)(44832011)(5660300002)(36756003)(31696002)(8676002)(66556008)(41300700001)(66476007)(8936002)(6916009)(4326008)(38100700002)(316002)(86362001)(186003)(478600001)(66946007)(2616005)(6512007)(26005)(53546011)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWRqUTZZNUlObGJacW9IaytjdkQ1ZEtxM0tXdTl0NUZLMk40ejNFd1hMMnVO?=
 =?utf-8?B?cWVKRE54N1AxSnJHdERBVFMrbjhLbnhBbGdsM3ErZmdUNFNMMEdWclp6S0l4?=
 =?utf-8?B?VnArRG9nOTgyc0I4OEJQZXBwQzdPeUVzUEttZHRlbGkvbGtVN3k2TjNNY0VZ?=
 =?utf-8?B?OGdsZ3RaY2dJWE11UlRSU3h0NnpwYkszRFFETW9nRXYrT1VyQm1rT3pBcFdH?=
 =?utf-8?B?QWFDS2ZxdnNSVDVLRkNkSmN2NXVaR0JsQXpVOUVGUWhOZUc4RFpIZytiWFAx?=
 =?utf-8?B?L01RSEQzUWhPNWdOLzl0MVl0Z3dqTUF0MWhNK1BheUdac0hXdWx1V3FwaDhr?=
 =?utf-8?B?TmQ5Y1VzbmpwbCtnZExJQVpWK2s1eFh0NCtEVzJwNytYSmlOSHRTanlxbEU0?=
 =?utf-8?B?ZHM0Y1VhOGxLcmJWNGhmcUkvS092S2tFQVptRlMrOG1ycElVZVlKcU55RURH?=
 =?utf-8?B?YkwvRjc3ZXJFNWhGVGlDc01kdGpEZS9IOFJSRVBrTGVKNmV1ay84YjNQTkRh?=
 =?utf-8?B?R0JOZmc4TUhadTllV3hIM2NNUlVmUkg3dUM3MGZZUFNPYlZGOVFjRjM5d25B?=
 =?utf-8?B?cnZPaXVLU0NKcGhFRXFidFNhUTFNUldEUXRvaUhkcEdjWU1nM3FNSEZWSXpo?=
 =?utf-8?B?VU5qR21EcGs4MHRrMVBreXAvZ1pkT2JETGNzeGRneG92eStyWWtJVzNEdWx4?=
 =?utf-8?B?cnoxSWlaT3QxcUJ6V05MbElYa2gvQ1V6a2JFaFNGbHFtMm9hTDd0TUEreERB?=
 =?utf-8?B?dVZXaUFZcXFWSk1oWnZKZlNQcFFLcDZMMGlsSmpBZUdMb1JuWUdOTmRHa2JM?=
 =?utf-8?B?NFJ5TG5UL2Yxck00clFqaFFqcitmVFlpSWZtM3Y1MlkxMTNzelMzQjJjWUh3?=
 =?utf-8?B?WnJVYml1dXF6RHlRaFF3WG1mc2lHNVlpaTIwUmRuV3RhMnN3cEZjWWg4Yktl?=
 =?utf-8?B?aEM2dHpORVI0MHJ4R0dmekN6azNZcTlUQks5a3hRejV3dVVXU1AxbG5JL3JO?=
 =?utf-8?B?TmRaWGpxVm9wZW42QTBuU3JrWndsZDFZVUFrdDZnbFV2dkh6MGxQVHcyLzdG?=
 =?utf-8?B?ZGwxeHpZMWR0NFI1Y3pDZ3FjMVNCUGZSbjc5NkR4TVVHdG1TTWZQa3pYbGsz?=
 =?utf-8?B?MFpXQkc4SnpVNlV2a1Y3NGxQNjRjVlRsSUMxTCthbFd3QWF4d1JBcTA5d1hN?=
 =?utf-8?B?Q2F4b1A1bEx4VDV2dW1scjVSSTBvRkViYXc2WXlBNnNTaTF2dkk5ZVJZNmFU?=
 =?utf-8?B?M1krUkNzWjR1MUVPTnlaQnJNd3lqdmhsaHF6RTJsbHlhcWZSdVc1MHFqbllE?=
 =?utf-8?B?cGdSVXVkbDg0VmtzcmY2THU3bDhjSWdSdmpXSmg1Vk9peUs5cFNFYVl4WUhz?=
 =?utf-8?B?OUYwM3ZaUTRLcHd4SXhHeWFnbjNBVUthS0U1dlFJYk1iU2psYVJ4cmRoa0Uw?=
 =?utf-8?B?N29RWFkyazFwaW1PM1NzTEdvVW9kSlRaUDV0N2RZNTV0ZVcwcVVlT0hBNWhB?=
 =?utf-8?B?Tlc5NEJoUVViTmRFaHpJR2xaNlB2bGl3ZjdaVzZxWmxUT1V6a2RkK0puMUlv?=
 =?utf-8?B?ejRKaXJXZ3ErMk9wM0VOeEs3YTUzanM3ekJpUHNqdEkrdXlLY09NYWdCMVRF?=
 =?utf-8?B?d1p6OVhFZE5PSFJmdDIyelVVd3RndkkvS2NiUXRJSWVkQkNhVWMzZ1Y1NnpJ?=
 =?utf-8?B?V1Z6UVZucmtwMkZRWStLMjQ4REJjcTBXWFY5VjUwblBwRFRXOTRGNWw3TzlH?=
 =?utf-8?B?Z2dLeWtDVzg3dDZxRFhFTDUzQzNuRnhkZkR2aHpzdmx0czEyMzBIRTF3ZjZ1?=
 =?utf-8?B?cEFkZUJqVUtBVzJBcE5heDVlYzhPMmxyc3J6bkgyK1puSVpQZThkUDB2VHY1?=
 =?utf-8?B?QWNYb2cxR29DMFhkOXhWSUlxSnF5M0VuKzdWdVRQYXdpTHNicjZyOExCZG1D?=
 =?utf-8?B?ZFk4SUY1bTFWZnZOdUlPaEtsUXFrOWdmWFZlT0hmWDFoMGY2SjFObjAvbWly?=
 =?utf-8?B?bG1KT2NqZTNaa1RaakRJQzBueWxUcHZ6QTlZcTVNZmpZdkxzdmZRNEhtN2FS?=
 =?utf-8?B?ejJFMzdIeGxXMUdJclRPS3ZtbFUrSXk2OW1sNGFQNmgvT2hCeG5tUEtOYzJY?=
 =?utf-8?Q?Wr+OnD3JqHz6uTIJgmvEt4/RD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbe7b3c-1577-4a10-8499-08db24be26af
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 18:58:51.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqZVvx1OLVVmKVCJi2UndgSK5IyRlWcI4MWI3d9dJojaTK5vTR3Bds6vTEFdCl8Srgn1Sh81MlqJL5zZG5QoiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 13:57, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> For the list of kernel published books, include publication covering kernel
>> debugging from August, 2022 (ISBN 978-1801075039) and one from March, 2021
>> on the topic of char device drivers and kernel synchronization (ISBN
>> 978-1801079518). Also add foundational book from Robert Love (ISBN
>> 978-1449339531) and remove extra spaces.
>>
>> Co-developed-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
>> Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>
>> ---
>> Changes since v2:
>>    - Fix SoB chain.
> 
> So this showed up approximately 4.23µs after I applied v2 ... I went
> back in and tweaked the signoffs to match this version.

Thank you Jon!

> 
> Thanks,
> 
> jon

Regards,
Carlos
