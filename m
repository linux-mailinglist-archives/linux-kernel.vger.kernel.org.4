Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9442B5F4216
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJDLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJDLix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:38:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5622AC61;
        Tue,  4 Oct 2022 04:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf+YP76ghgtHojQQloj/V3fPCwG3H4ElwYzgDdI0XAR/by39Okah4UtrL2LD0dNg1KVobr19Tuq094C2v52mWPxrbaTZjzfQwizM1MllpTM2GckTB9hBPlG2nezXUQAbqwtPNzRjSUxTbmfbZLJkiLn0KFV2vTtKETKBpIlDRcIwC5Ht2GRX1LrRwRMtQh2ChI2KCjtXj/Ws6XBMl7TcARy8PhHRjYasY6YBP4QTU2tb3jNAKQ4WOhwAlYCIxiRHD5ujF5WaWnq/KnkhD3VUigiLjRHVWPXmir9EtsFUYVep7MimIlIV6vBChMF2wbnq6az3jZ9HziGrC+AtL5qe4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF8SL2JQ7cKfBWjtvB/aqqMtgfaWhrfuO/YAh62zw30=;
 b=mm3QMuR0XN4tx/WbHW1mH8UCgcZ8u7vOslzdHO8TA3hs8+QvYAqOqoaJDnpy+4JxO2+WZOKQphG4ziL8C1dFfIBCBOxo8tVHB7aO59nzdCgm8RTamNrz/H9o5O9q0PYlZq4qKaDtp5YOz4A3saptF0D9kbCBUlzfWihKdH1Wb7uSPrKJu2Oxa+iC9S5SiSRi+aK0SOzW4csxTlrzx9Atu79i9cdf9VZpmtAJC0WPcX73MIjZZUeU4L+Vj6XS6CoRJFAyWiNMh3UZrN10CnCwOzjRJUn9GD10T3zd6nBgaVj1elAB5E8HLh/hkcoOtW3+BQQby+ak5/f3B0yV1PtW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF8SL2JQ7cKfBWjtvB/aqqMtgfaWhrfuO/YAh62zw30=;
 b=UWY2y3FXm/HgpWisOsHR69b0nIHDxKIvkjUX+i1FgB9VaNigCReZTODa3XYVXnYdY/XCl7t0I8bvcNQKX78FOELCxuWg0ViqTYxjmCpgWhaIK+2QusKatTPnfzU9wAvbBzxnLQ98szmF0z48trwjiWX62BkSePMj9nA6LHSZES0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 4 Oct
 2022 11:38:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Tue, 4 Oct 2022
 11:38:49 +0000
Message-ID: <d2e853fe-6e58-0056-ba3b-d04a2f97c6f1@amd.com>
Date:   Tue, 4 Oct 2022 06:38:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC 1/3] thunderbolt: Allow XHCI device links to enter runtime
 pm
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Sanju.Mehta@amd.com
References: <20221004041225.1462336-1-mario.limonciello@amd.com>
 <20221004041225.1462336-2-mario.limonciello@amd.com>
 <Yzu+yq07pIfpEbnG@black.fi.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <Yzu+yq07pIfpEbnG@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:610:cc::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d52c688-d175-4652-31ca-08daa5fd0120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KaRBLu2rCmLIF3RrgjYBYf5cVjARHBGtjSjfr490AaCXaLG6Jvu0+RhnWWNZoQUQaMkkYPYnJetIP8yPeGGkcF3GVoB8qrPceabQ8EE02fBj9I51TYUHeaev3R4BLze3qEslQxUSj3zznGp6iEjBQIgETPFn//D/QGgz2vJQ0DasmW87lTF2Jwa5ri5Hhg24n3IngZ/jEA3WDrZ4aaW3idJSG+e//SkAcIqWMeHyy7cUW5giKYH5oGUXFoHT2Kpfxn/m/OtnZcI1ALlOp/b2BzMkCAdbydsMsJ5J2LWjL5MqoaMOWpzavKH4u6oS2kSylGv71BzqLhxvIDnGXVN3vayQAw0ee/68SiGoDNaSET+Jlb2nVtyo99I4MIoiIpucs+KI/OBqoDnPE9YBotLAzXzMUqy0YZBv5/qHtZ9rOV2RsEoYk/NduOHRkIwuyYOa410zdptWsq+5M2TJeZSFRABj3jpGoKFtT2/QBgG4pXsG7VOQItaIzzmgrbFeZwa6RPKe2TNkiOke4Kv36aBZl2wIspswuyWiFgU6txyzdSRZ+ePozFtbYBi62RF+ESO+qA/zs2s9xnXA5ewsdMRf0pbDE6N4B1HmoUs29T8/NCyr+SphM3bPJfaaBTm3kA89TujG/foo5oLD5OfFgz0veC8WgOXksR+u0B1ssvHIs+QnmuEhNehRb30k9MJS8oIq4UHX8RwuTilfetBDa9q6eHdAXlCq5yJ+qNkmIn9zE3XdmrqYFj1OC1xrDUNBBXAMOLZ0oGjJxY8+4mqCQKanVLi7HhIoLjW3oPzwlRJ2lTZ2kAx472nnVfTue0LXpZ2FQT75vpD4cM8kLZkABms9dUByE4b7BHhLBFhj63KHQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(31686004)(36756003)(31696002)(5660300002)(186003)(8676002)(86362001)(66556008)(66946007)(2906002)(38100700002)(2616005)(8936002)(4326008)(66476007)(6916009)(41300700001)(26005)(6486002)(478600001)(83380400001)(316002)(6512007)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFEb2Y3enRmai8yeW90eEo0RnpOUUNHZ25iU1k0RzQvNWRGSlNiUlFENUhn?=
 =?utf-8?B?ZlhIV3lyUjhGZ2lNcDlRQmtrSmhpMUN6NHEvRUNhT0I5SWZ4S3E4UWNUUWV2?=
 =?utf-8?B?MGJWMnd3ZUk4bGE1V2lpdzNGaitZT001NkxjZzNSV0VKdHZJTUtxU0N1OENF?=
 =?utf-8?B?OU91QnRoelRGTU02MUdNZkU3VWJmSHJ2UWxjNHFmYmRyR2MreWwwcGJ3RFNm?=
 =?utf-8?B?b3BVWEtnbjBHMHBYdlF4eGJXdkE4eGs2aE9QeGl0eUV1alpzNlBaZnUycmMz?=
 =?utf-8?B?V3pDTHV3bmpiL1ptRU9OcGNEc3RGR3NqK1l4S250OU1leUZLYnBCbHdIOGFO?=
 =?utf-8?B?ZjJBdG9UMWQzVHFET2RiNHJYOEZTWjUrVFVzRG1DbFdIN08yb3FrZzNXNHVI?=
 =?utf-8?B?azgwbjE5ekdMeitBc05leUMrSVRlM1hsUEp5YUprTHJTUFhqS0ladEhJMEJh?=
 =?utf-8?B?VzlOQzFZcVl2QWNhSEpOWU5sQ0tPbk1CVGp1alVGY2JIYWVYZkUrYlhxUWI0?=
 =?utf-8?B?dzJWZVFyTGdxOWxmVlBncC9zK3B5TzZ0YWZzQm9Ic004M0NpWlNwMVVvM3Va?=
 =?utf-8?B?RzVSVG1qTXlaRG5XbTFKMmhhZTkrcUhKVDdOZVR4cFAzcEszTVErZmUrdjNo?=
 =?utf-8?B?bkhwNCswNGI0bFdkQlh0eUlTdEkxd2RIUUgrakZzRUxBVEMwM3BuTmJGWGMx?=
 =?utf-8?B?OHdXcUVGZXU2ZWhvOHhuOE51enFZdXM2YnBsT1VtT3oxc1pzR3lENXNCdDJx?=
 =?utf-8?B?VS95UDVqUFRQZzVyaFN4NE9hbXJtL2x4MmplaC9kSllMYzk4cXJtdnoxTjFq?=
 =?utf-8?B?NkhtUFVaTGpONU9aN0JTVEx5MzBVTVl4VllHRVkrTllHYVdCelJJZWNDSHlU?=
 =?utf-8?B?UUVSMUdqN1FvNmtyN1FLcXBvMGs3YzJIS2d2aEhjVmkvVDd4QmcrWXZ0S2J3?=
 =?utf-8?B?Rld2NEhBZFY5cTA3WVlCakY2aEgvU0J2VW1GSW1kZjNlVWRCby82bmpiTzVo?=
 =?utf-8?B?bFJTZHJTLytZQXRVMzRTdWs5Wk51a3orUUFNUnVGV0xTbVB5Z3FyKzNlMmZm?=
 =?utf-8?B?N3E0STZzYUk4Mk9mOS9Bb0trMHRyWkpUaUY4QXRYeEZyU1VKN3BUb0pseDk2?=
 =?utf-8?B?amgwQ1FoNUJ0Q2JHRVhCSWZieDg5Sisyb2NYYTVNKzFvVE4wYkZ2alUwMi9Y?=
 =?utf-8?B?VmdLbm9JNFIrem94TU1OTXpuOU1FV2crSTA5NTM1RzRtRWEzS1VrSVlVcG5a?=
 =?utf-8?B?OThLaDdGb2ViMkcwdlNGYzVEUDE2SjNTU2VvbmI3YnEyRmpzWU12MWV0aHlk?=
 =?utf-8?B?T1ZpSk1WR3ltT09yelhHWTZPUFJXTTZLKzdVOFJLWXdSV2RmZllIUVRLVTQv?=
 =?utf-8?B?anlmU2VUOEk5eDB3WmhHZjlXYk9zMytBN1dVWTBxSHJzR2JWYTBLVjV6QkU3?=
 =?utf-8?B?NUV6QVk5bGJWeDVEN3ZkM0hrbjNFbkNEdWU3VEFhN1RMdUlBcDZNWCttNndW?=
 =?utf-8?B?YUJJdjRVWkt0b1N2NWwzM0ZjMjhReUhSN00wVTFlbE80anF2TUhBNWZYRFc3?=
 =?utf-8?B?cmRQamxhNE9ZbTc3Ym54dmxHcU5ZQ01ldTJoenh5Y204MlF3anFFTlhjVjh5?=
 =?utf-8?B?ZHY0Y01MWnh2MXdmWTJjeGdlakt6V0hpYk56ZXd2c2dkdFpJcHpzZzJ4c0FX?=
 =?utf-8?B?THJudnRoSFA3eGJuQjk3cUU4QktPODF2QllrVHhjbEdzMitJRDZkMjJ0Zm9B?=
 =?utf-8?B?cGNyaVFOVVJHRXlIMUN6WUJDZnU5a0FuWnN2Si94S2JuZkdONUYwdXZMRk9o?=
 =?utf-8?B?U3NRR3VuNnRqNnk4NWlEZDBaV1ZZM1hRSnc2TjJwSnpvMzZidXVZOExrRENN?=
 =?utf-8?B?NmlkOVhTcU9WWmtxTUE1OFhrOWJRRGIrdHFTeW5GM1R5d0lYVDlFNnJiaHRQ?=
 =?utf-8?B?OXdHcFZoQVN3Z2tuV3ZrbVk1VTZTS2t3UUxWNVFsNFliblFzS3hCMit5RG5J?=
 =?utf-8?B?SXhkbTF1YjJZaU1kWUt6QXhSWDNZOEFGU251MkUvM29CWTc3aHQ1K0I1UGN4?=
 =?utf-8?B?WjBIekh4SkkrWEtjeE9wRGYzSVhnb3hzbG9PSHlRZ1loQ3ZOaWtmSUxvUXNy?=
 =?utf-8?Q?Mc9dUZkrYeL/jZPLVPh5Kp0z4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d52c688-d175-4652-31ca-08daa5fd0120
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 11:38:49.2104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWiTjrhJp5RcHoXRfPbWvvLrcjsdT4G4E18dR2g8B3rcq/43TDBB0y65UEed5GCbQRhpWvjBA0BTIxE12MI2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2022 00:04, Mika Westerberg wrote:
> Hi Mario,
> 
> On Mon, Oct 03, 2022 at 11:12:23PM -0500, Mario Limonciello wrote:
>> Both on Intel's and AMD's USB4 designs it's important that the device
>> link to the XHCI controller used for tunneling is able to go into D3
>> for appropriate low power consumption features as well as for system
>> suspend states such as s0i3.
>>
>> Historically this is accomplished by adding to a hardcoded list in the
>> XHCI driver, but this requires a change for every single platform.
>>
>> We have a very good proxy that it's safe to do this since the firmware
>> has indicated the device link needs to be made.  So opt all XHCI
>> controllers with these device links into runtime PM.
> 
> This is good idea.
> 
> However, it misses the fact that we have FW CM as well in Intel
> integrated TBT platforms (ICL, TGL and ADL) and with those you don't
> have the device link (I think ADL has it for both, though) so we would
> still need to keep the list in xHCI.

Can you double check the firmware for ADL for me whether it has it for 
both?  I'll respin the series and drop at least the ICL and TGL reverts 
from patch 2.
