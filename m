Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A25722B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjFEP32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjFEP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:29:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E515F1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqQh+p05gRKKApJxe0bG6RuNWDteLpkClGEYAj+EtVl9n9EY1AqzliEowJ+RkPUTyfSs6FPmoRJPLgurQ5AhjsjMpzkJcZdtImURlzxHdMf/rSMsoEo6RcduduFNhfVmVVnxbNJhnTWAcCz6mV2rkvv2U6WfKVcOn8wCvGeUjRJx965QWMqlm+4mupZO4Q5GcnxLrlHSqBIARomsy0GKO2bg7ujEZfOoDhZBOffokZ5fzOfI+q+ks/+BWHqayra4le6YwGkGNVKDpV/HAkBjK9SAKMD19l2EY7+KhMTE7ob6OulJ2kU/4jPJEc7+/NtwdLt9YIbTj8oD4xttCt/ARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf9b9k/5wNVh6WuC2Q5pgPgBzyy+MHPMXIKQrRG7NCw=;
 b=EK8RJ28wRtYzjvMDH7euHFpoxTOLKyx3Gvbsv2bebW5O4dBzhKMakMYY067Msjl9SumQdYataNshhpojfKzAn/KzeJaaYa5JJLLUW6rATqvqdYyrbNDD7wMz6GIZBu0gtIowgQaJdtucW1XT6IaulmiVks2+pBRrn/Ww/QFWyyBw7p5UojRwH160pb2dUsZ2lMO6KppDSMRaYZApGHZ5qkKXK6r8CdUFl3Zf7g7apZxyzRVItrQ5SBPnbA/Ag/J5ltW2lfqBpCrpuqTcg+NE1zL8+OkLAasCgwH/AkNrqv734+w+Vb6U5wxwLx0zLcw2oKejAqoUZYB3qDiQXlbBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf9b9k/5wNVh6WuC2Q5pgPgBzyy+MHPMXIKQrRG7NCw=;
 b=I2UsRV4F8LfirTyzssMsNaaQamJG9XbjVUQ8IEpI/hIH7iRh0wW6tOaD9p5cGIwRyRu2Rg7X5AAlZdgU1uqNtyy2ROm45g6YN84Ba/tO/87W6+e5Vy9y4TPHXEdwH5Mqoa59pwh9kSrqgKy4ooHjKaMlr/xzuNpxUP78EwI9VKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:29:15 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e452:1914:1054:de79]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e452:1914:1054:de79%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 15:29:15 +0000
Message-ID: <dcef3eff-47c0-25ba-a09a-c0fe3e4404ba@amd.com>
Date:   Mon, 5 Jun 2023 20:59:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND PATCH] cdx: fix driver managed dma support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alex.williamson@redhat.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com
References: <20230605131009.6869-1-nipun.gupta@amd.com>
 <2023060533-reseal-glider-11e7@gregkh>
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <2023060533-reseal-glider-11e7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a360a2b-e134-4af2-969d-08db65d99ea0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rstwyQuM7Va//m3kU7DxMVjw9V5jOEwLpikkQYVPrb+NWHU8Rp1kdJM52k5F4Ew0YrC/HwSkwXfwWp3Em9YbeyrBvu/Mi8zFo1F0fcMOKU7lKvpa6FFXdnQK+C3joKlELu84sxKWLfwMpNGApEoC8fRKWCxH4TChPEB7hWNClMgriu/34K159r9OBRefKydAQrOknny6tHMGfQhGJ9dDRS02l8TfLClyQOCJL5QgWcORkuOTrEYspAjueXgPH4zDETNcxvNe5/reKWYvK03tsYZiNpFADzZNsb4lMtn9dSJm2TK2+70aFpo24+lxZIFOkMful/E0H82k77WXl9O/UqgfrcJGdfW5F1UHjOjOisHALCkJAVeAzTPDuZX5PD7abbm6rJgOp40neg7pc5ogr/c758Riy1Hg6qCsng4mw3m9UEtItvIEiNMEkZ/syKDbvk42Edse7wVa7Vk7m31oTQ+6vr5Got81jTUIQWGXTT05Nj0FSqqegBawIhk6UdBKzVVyDZYCRm9p8zN0Kx9cXCLuOXpYH4Cot2GC8Ia4u8R5RVvbiIHdrobjbyLhzPJUA3Ar7EsDQ5xhY/c8obgVIJymVObLNqMkR0Y7wpxR53Nf/2CoDSArHp7OZgdIxFR91d3IFJO3pRDtj2Zvq+Qw9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(55236004)(6506007)(53546011)(6512007)(38100700002)(2616005)(41300700001)(31686004)(6486002)(6666004)(26005)(186003)(966005)(83380400001)(478600001)(4326008)(66476007)(66556008)(6916009)(316002)(66946007)(8936002)(8676002)(5660300002)(44832011)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cURxNnRMTnBVWVhwTGJxUmsvTjkrRzFhb3NVN3BSUVArbFYrRmJkdWxUWUta?=
 =?utf-8?B?c3VEcEZpRTUzeHhJYzk2cTFWWFFTNU5zQ284azNRTXZBVlV6QXlvQzd1eWRB?=
 =?utf-8?B?U2ZFRHE2RklFZVBRZ1JNeW9ScEc2SlFUSmFFNkJHVjBoWFl6eFd2MU12bHE2?=
 =?utf-8?B?dXFXOHpUajZFcUIyQnlXQVFxNmlwcHBPZ05TemUwYUxlZVZBWUpXYitWK1lT?=
 =?utf-8?B?Q2hxbjdFUHVER1RtU3lZbURtT0grL3pFNk10cmhNa2o5MmNyb2pQTWczRWQ3?=
 =?utf-8?B?MEk5N0ZXU01UdGhQVlAzZ1RhemlYVlJ2RkdGZmU2akdTZEp5VHAyWDdKMEM2?=
 =?utf-8?B?V2JpalpPK3VhUmVFQS9wUEN6cURpOExTKzVZWGpjQ1JMdnZJYUpPV05qejhK?=
 =?utf-8?B?d1hmNDk2cFVWdVVvVzhKZXpncjU3RlEyRFVtZkxhc3l3dEF6Mmo0bWx3dnlS?=
 =?utf-8?B?ejgvdk96RE1xYm5qN05WdEl6VkRjR20wcWhTSTc0ZlBneDVUMWdGamV5Q0hj?=
 =?utf-8?B?T0dnTytiVWpyYXRIQm9xTmNTbGwyT0xac0dKL3NrbXNiRyt0Wk1xQmF3OXJh?=
 =?utf-8?B?RVgvL2xnQ3NLK2dlcUtPVU5XVGlwWTNEV2h4UitGaFI3cHNDVUtHZmtMK2hN?=
 =?utf-8?B?dmt3M3hqOHhwUWllY2JlREpvbURiNVZrZHQ5VEhPMll6eTNKanFPZlU3Nndn?=
 =?utf-8?B?Y1JBSGsyVG1zYldqd3VwRmU0RmdLeDF0Ly9ITk1ZREJjMTZsTWpYZzd2M09G?=
 =?utf-8?B?c0U3ejAwdno2YTZnVzcyRHpNdmJ6L0pvbFRjb0Z6enZlMDhTaEptcUlaSVhH?=
 =?utf-8?B?T3R5Z3lTVWFCek96dlV2dVhScklpbDlhTXVET0UwSXVQODdmU2NlUXhxcGt6?=
 =?utf-8?B?M0FSSnRIN3FndVU5UFkzQXpsSklOMXVEdCtBMlFabVVHQnhYVFNpcXY1SSt1?=
 =?utf-8?B?NkszUi9yTzZYZGNFaGJNTGk1cmVQN3UzbGk1NXJvQ1VUZXA4cDRiMXhGV084?=
 =?utf-8?B?WFk2am9IeFk3MVNSS0kzTm83SzRWaEp2SFYxTlpVUGVEelBRdXlQbEdFZlVs?=
 =?utf-8?B?MXpRWXVUZzU0MnMvNW9nRExwc01KWS82dERWVzFrclAwazhueURGa3hTaEJF?=
 =?utf-8?B?VEdsOUpNZGdZWWxYcUl5TGoxSTBXRHV6aXFPZHNnb2g5SXRZUUh0NkRTL2lK?=
 =?utf-8?B?N3VCMzFWYkhvWXQrWDN6R2JDYVlISGxjeGpxNW9HSTNIdmxaaS9NNGh4T3Rx?=
 =?utf-8?B?KzExa1V1ZEw5b05JbkpaR3FVOXVwanA5enlsNXFQNU1RamV4RGVsYVAvNVRP?=
 =?utf-8?B?b3pyb1VUN3pUd3hnRUpqYk44a1UxSGdZRFN4OWgyUm1QRVlxNTduZVBrZUNH?=
 =?utf-8?B?Mkk5R0MwaDZkdzQrTDVUL0oyNHNoV1FRZEdWQ1NrbjlrcHV1MzZMVzh1RmtH?=
 =?utf-8?B?SEZubjZBK3pncmRHVmFUYWIzM1N3UUg4aGRuZWkyYythQ3NMVWhLMi9DYnFQ?=
 =?utf-8?B?dlVFdzQ1SDhZbHVnUWlnWlVudVhDVFRKWFV3UXJJK2hNU3FSV2R1MFcxUDVi?=
 =?utf-8?B?bUZtNUpwSU9HN3hPeHdsdUZzczd2YlNuckR4cit4aUkxYVhLZmwzS2psQUJU?=
 =?utf-8?B?am9SdW9sbk80Sm5tVjBUMEh3c2MrQnFSR3pYWmIyVGl0ZnNiNGxPbWZ6ZTZ5?=
 =?utf-8?B?RUFPb2tkdDVUMUJoVWdDTTVRTCtFOFl4anF1VnZQdlNPemhTc2xkMlNHc29D?=
 =?utf-8?B?bG9hUFNvNVBmbXp3VTBNbWIrdHRkK0lHVFVrdkluZldPUVB6UEQxK2hSdEt6?=
 =?utf-8?B?YkxYbWF4aXh5WTdGb2VUR2dYMEdCNjFaZzJLcmFycTd2N2ROWnVXdW1zTnJa?=
 =?utf-8?B?SmhQZVJnKzliYWFwREpwQnNGZGI0Y3NRQ284dFMvelFsNnM2K1RzOFloVmRN?=
 =?utf-8?B?QjVVODQwMFpXcGE2MkVuZ0lpRjBtL1ZIU1lGUHRXaEhLc1lRdEw0cll1dmw1?=
 =?utf-8?B?UGRENGsrN01nVnpuaENQWDlzMmR0WERIQmpTNlNBcmordXUySzVIUnAxZ3VB?=
 =?utf-8?B?SGRHOXY1OTl5TWpKTm5rVnYxS1BXU0drbjBqdG1GVCs0OXdYSmo4b0lvOEx6?=
 =?utf-8?Q?K0G8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a360a2b-e134-4af2-969d-08db65d99ea0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:29:14.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IbpRidD2cGIICdWyVeJyNI4JVU9l3PCzZ8LmKpizLA18Ne6KPGuB3fRr3fT8G77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 8:52 PM, Greg KH wrote:
> 
> On Mon, Jun 05, 2023 at 06:40:09PM +0530, Nipun Gupta wrote:
>> The devices on cdx could be bound to drivers with the device
>> DMA managed by kernel drivers or user-space applications.
>> As multiple devices can be placed in the same IOMMU group, the
>> DMA on these devices must either be entirely under kernel control
>> or userspace control. Fix the CDX bus driver to acknowlege the
>> driver_managed_dma flag and call the appropriate iommu APIs.
>>
>> Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> Reported-by: Alex Williamson <alex.williamson@redhat.com>
>> Closes: https://lore.kernel.org/lkml/20230524134831.28dc97e2.alex.williamson@redhat.com/
>> ---
>>
>> I have resend this patch to include fixes, closes and
>> reported by tags. We request that this fix be incorporated
>> into the 6.4 release, along with the inclusion of CDX bus
>> driver support.
> 
> What do you mean by "inclusion of CDX bus driver support"?  What patches
> exactly?

Sorry for the confusion. I mean that CDX bus support would be coming up 
in 6.4 release and this patch (cdx: fix driver managed dma support) is a 
fix for the driver managed dma support in the bus. So if this patch can 
be part of 6.4 release (i.e. added in upcoming rc release/s for 6.4)?

Thanks,
Nipun

> 
> confused,
> 
> greg k-h
