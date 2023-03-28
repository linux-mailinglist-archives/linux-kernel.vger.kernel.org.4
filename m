Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57916CC133
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjC1NmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC1Nlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:41:52 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D9C65C;
        Tue, 28 Mar 2023 06:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce8lVYXZfVhGAHj1y5HzjPtKkMglwF3mfaGY+kAi0qALINZXvgOGnJKQQTtBMo3SfSYSkZiHXI8JVBwhQ6tnMVmglbg/SNRwr26Ix4X53gYtVQ+jQ844BSe65z7W7g4FcRdO85kPvGTAexBNYWJHJySyVcM7OUuu/SlyDPmIqaqs4wBUN57dIs1XDT4tSqnj7Kk+CnFf4QI6zXz2CCa23PejlQqsiRJiDb+h6hp4+t/3cFLYXSphPSQH7IMaDHcOPe7PncZw9mm574Ga5ykcM1vwN3+/iGk/KN70T0DM3keoeYrzn2OEw4fRHw8StVmyol16TWPqlnu7hU0o2fUOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4SxLtzKX37yQ6BJVk0rZkAoB+KcL8Yj02KhX3ZF7w8=;
 b=B4OKeGFMZKedfcmR16QBJITBASIqOjcEWEKVhhdGhEnxPwtmCTXtjmsOb8XPVhXhURYuLqRq1yTfSZCDyBjVw9cUcrJqa+WQFPUPs7HFMKR1weQwBWncM5pCah5N74gbrFClhZJ853poLNtG017v32K9zpG5fUVG7HdVuvhV/PRC8wXOvB8JNqi5g+K4DqFV6Zi1uhS0nmViUOHuePMf6el7nhPYnzkXuuLKYq82kEMD3t1x/Db6jlPkQTTVl72jClaAQbEJG/y54IPQGp0BGXfLzjIhNF0lUxj2UnspjInWOLNzM45IYb+6EVwC+0WdcecIMgb7iuyARgFMI1XP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4SxLtzKX37yQ6BJVk0rZkAoB+KcL8Yj02KhX3ZF7w8=;
 b=BjOGTEepdVorc6vUX5AbL5HcfxfUU4xG5l1xcPTnYKVqz/5Zo9BCDaqjXIIIduBPvDPwbZvJbT9fei9wxKnDMXOwZDBv/9NkzUB8mNxZAmxqHWIxgUNOq4LYeuMM16cR8aExidh43M2+MtCbiQ5mL3WeRVQwxcQV/qTc4KkY1Xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Tue, 28 Mar 2023 13:41:41 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%5]) with mapi id 15.20.6222.029; Tue, 28 Mar 2023
 13:41:41 +0000
Message-ID: <c03b8d66-65d9-40fc-dd0a-1b8154e24f6e@amd.com>
Date:   Tue, 28 Mar 2023 08:41:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/5] cxl/pci: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230324223656.GA2660301@bhelgaas>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230324223656.GA2660301@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:610:75::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH0PR12MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: a788f7f8-3b95-44a0-f64a-08db2f922950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUsjnQ1PJcLDKhxJRgmna9xY58yxSt6i0Ar0sOlhKWhysfHtAfdy3t0M4msrOafpwWNtm8vp+LEz1kOjiYv69A9+lesxfrOPTaP2UWszl6C4Dn1uAF/e5+HufM9DbHNPds2qgkHcHO/uSO8/vt8YLp0P7gAgvWqws/QISx4AKTMsoYRJeaK8pYbyRXPNsixZLgsmMK4iG/0mIv+2BqMt9zu/kkn3v6kS8zlyLP9D+u+hGNsUh0aDtyMJhX59adXc0kxD/2/zWKFypXOko4Qp78YUOKHEIv/9+jD7fpJThk68CPK55wLc0XJIyU8IEdDyFqCYvcqqHU6Yf7EG03A8kfzc4JNoKddvnGXDIiimPpRATBUQjX7gTAceXeAwk9qdtZxxwOdoOyOzAef6p5qjxPqXBQd8SxiXiG8JU3ik6A32dhqWqoZwP6dLHVQaxZ7SgBQ+0yCQrq5H62KfiVP0wOEYtzislhG5OfZX6SX4PJnty8YYSKSHclF2p8I5tlooEssTqrziupo7wi1FKg2ztieN0HcZsPKLeNxh1mpUnr/xfrsDMqY3l+0K3lilUx3coI9/QfBwSBV5DyEuFv2xyrV5YbwSabkq4PewLSw05hxAggw8no0diqOF+mA2UVptYzS/iLp4VSJQMeUoVyn91A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(186003)(6666004)(316002)(53546011)(6512007)(26005)(6506007)(2616005)(83380400001)(31686004)(6486002)(478600001)(38100700002)(7416002)(31696002)(86362001)(8936002)(5660300002)(41300700001)(36756003)(66476007)(4326008)(66946007)(66556008)(6916009)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlFc2p3ZXhxZ3VUZ0lsd0VPZ01aQUJtb256TkpsT3ZyeFRIcEYrUkZwUU5E?=
 =?utf-8?B?elZ4TEVydFhDUTFXeGZZdTFaRTAwUWVaQTAzd1BBSlNlUU8zR1N5RDJrVjZN?=
 =?utf-8?B?MUhVRmt0M28vVENvdlV2b051MjB4dmF4OGpOaGRlUi9HRlFqQ3RITytyYjVT?=
 =?utf-8?B?bG8yY0lJdFNTZ1RkekwxS2ZnZUtuOVpPZW5UYUVyWjVkcXIwMUZPdVExRGJR?=
 =?utf-8?B?eUVpazhHK3VpWHBYLy9KSUhWZFFmeWpGYTMwUlJheDdlWDlVYkNRa3BnV3cw?=
 =?utf-8?B?bW5EeEsvREdVVXdRbkh2a0RDTi9tVDBFeDJObjNLTU03SEhsUWl4UmNOSW5m?=
 =?utf-8?B?LzlXZHlQUVc1MEZXMitXdXVJSDlFQnVNYWx6MGEzU25ydFRIR0dtYTl6Uno3?=
 =?utf-8?B?cFVXN3FqOEVqNDJDQitJczRQdFc0SlNYUnZ5bkpadC9nK0tzLzF1M2pkSzFI?=
 =?utf-8?B?eGpXbVZrTE1hK3I4VVQ5V0h6THhDaFgzSFBMS2FaUGg4ZUhGaWk0b1ZpMHdh?=
 =?utf-8?B?QW1yUjBuem93U2VyaXoxTjFTOFcxNUc0by9NT29WREpwblVIYVZUOGYwam1o?=
 =?utf-8?B?VWFHTkZTQmZLclA0WW5tdzNYNTJFdTZSUGZmZFhzY3Y0Vk1oMHpmeEZuYUtD?=
 =?utf-8?B?S04yNENzbVc3K1dxOXVPV2w3UVdQdHhKRm5nV3FEQXFKUjhWVUpKekJjTnp5?=
 =?utf-8?B?L1RzUENjNjdzSUh6c21nTDc0Rmx5QXNHSUJxaTJHMm95TnVpVEpmVENkcDFN?=
 =?utf-8?B?MHNqSEtuclJ4WkVqUUJPaERGM1oxWVM2OFRJbnFnL21TcDh3b3dzMWpkdHh5?=
 =?utf-8?B?bUlMNm8veEpNdE5Kckg4N1psNlIvcldTRCtRek5vMFRQVVVzVktxRHg4c2dF?=
 =?utf-8?B?OVdXbXV4a1BkWTZKM0VuRGg2ZmFSWWt5MzMzZXlwYVpBTXNoeWpqOTkra2F4?=
 =?utf-8?B?RndrVW1ub1I3aEMvZlVXaUZIaW5ISmtkdFNMSkhDNENNamkvMUw3Qm4xT1JX?=
 =?utf-8?B?ZDdxOXFiQTd4b21SWElBMkxOQmpnOUdrZ2ZVTk9EZWRNdjY4Zm1oSmsvclN0?=
 =?utf-8?B?Si9WSEZzeU5jbXluajU3UmZNZU9laVFTQW4rcHVNMmt3Z2JwUEVLWEdZZTJo?=
 =?utf-8?B?MVRIR2JucWJ6cUlmMWw5MmdleDN3WDcwdGNOaFJOcWQ5M1NrNElOaFcyMGJt?=
 =?utf-8?B?VCtaTmxqZjdVMlNhTnJmSXBvd3JISUtCZXFlWFBRTjlvOUJaK1M3UVZ0L0RX?=
 =?utf-8?B?SmI4OGRxN25CSlE3Sm9sK0lhTkR4a1NlVlA1V1ZodGpyOXVJdktRcHhuYkFu?=
 =?utf-8?B?ejlYeFdlSksxV3pkbjBlNmw0ZjFXK1g0SHYvS3B5RGtHbHdLUXI2WGFvUzAw?=
 =?utf-8?B?T3E1UC9uS0NwN3BybXRXVTZ6bGNlRjE2NmFia01aTmxXMGtuOFdBUmpGQnVG?=
 =?utf-8?B?RmRsbVAzNzVZT1VGeXZxZTQ2WTc2b3d3Nmh2T0ZLMUFSNmcvZDNhcU1KS1pk?=
 =?utf-8?B?L1JBYloyZEs3QkNqTGFUOGNMaGNwNVVPYzRXSUMzelNieFpKSERSZENLS1Ni?=
 =?utf-8?B?QXJnclpxR0FzRmdQZ0I3Mm1IbFZuMXhhL3VJT05RSlY2YXRSL2NnTkEwWmo4?=
 =?utf-8?B?Q20wWnYwQStoV28zK2VKdWszejlkWFhkZkZPUEZYQ2VFWVNYMjZOeUVpcElv?=
 =?utf-8?B?UUhSbmFwcWZsblZ0UkdDOVBBK0Y2YnBNakk2V2RrdGxvaVAyOFpKOHJRaUtE?=
 =?utf-8?B?K0Z1OXVuQ08yMXAzSzJpTjI1MGh4SnVjbWF3b0VRVlNmMWkwbmZiU0ZmMUdD?=
 =?utf-8?B?N1BkOWozazBJWVgwL283bmlTOVlDLzN4TEVxczNUUGNzbVlCMmdmTSsycU5r?=
 =?utf-8?B?RURSUnlnVFpsNkN0QXRQWkp1SS9URER3OVN5ckVrL3I4KzZSVTEvN1hoQ3BJ?=
 =?utf-8?B?UFZUK0Q1Q29xanRKR0g1WWVPblNnL2k0aWJGYTZ4VmJwazIvZnNRVERpT08y?=
 =?utf-8?B?YytNMC9YMFRIdmE4bk0vUy93V0dDcnNtT29NS0pKYmpRZ1pwNTBROVJsd3Uz?=
 =?utf-8?B?T2RWL0o1QjZYMlRKVHZ2L3ljZ2hiRFc1VVZjc1hnRzlJRXFtQ2ZXRWR5b0JW?=
 =?utf-8?Q?aVmDZlBb2SW3bZ9HQYbMa725r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a788f7f8-3b95-44a0-f64a-08db2f922950
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:41:41.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epRbA1GRyCxzpfQpQZa7+mFW6ByeliSGHGIJp7nSguFhLo4dVRpZbho2nVpdp+ClyNOBmbz0whxCkyXw165SKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5139
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 3/24/23 17:36, Bjorn Helgaas wrote:
> I'd call this a "PCI/AER: ..." patch since that's where all the
> changes are.
> 
> On Thu, Mar 23, 2023 at 04:38:07PM -0500, Terry Bowman wrote:
>> From: Robert Richter <rrichter@amd.com>
>>
>> In RCD mode a CXL device (RCD) is exposed as an RCiEP, but CXL
>> downstream and upstream ports are not enumerated and not visible in
>> the PCIe hierarchy. Protocol and link errors are sent to an RCEC.
> 
> "RCD" isn't a common term in drivers/pci; can you expand it once here?
> 
>> Now, RCH downstream port-detected errors are signaled as internal AER
>> errors (UIE/CIE) with the RCEC's source ID. A CXL handler must then
> 
> Similarly, "UIE" and "CIE" are new to drivers/pci; can you expand them
> before using?  I assume Uncorrectable Internal Error (UIE) and
> Corrected Internal Error (CIE)?  (Annoying that the PCIe spec uses
> "Correctable" in general, but "Corrected" for Internal Errors.)
> 
>> inspect the error status in various CXL registers residing in the
>> dport's component register space (CXL RAS cap) or the dport's RCRB
>> (AER ext cap). [1]
>>
>> This patch connects errors showing up in the RCEC's error handler with
> 
> "Connect errors ..." (we already know this text applies to *this
> patch*).
> 
>> the CXL subsystem. Implement this by forwarding the error to all CXL
>> devices below the RCEC. Since the entire CXL device is controlled only
>> using PCIe Configuration Space of device 0, Function 0, only pass it
>> there [2]. These devices have the Memory Device class code set
>> (PCI_CLASS_MEMORY_CXL, 502h) and the existing cxl_pci driver can
>> implement the handler.
> 
>> The CXL device driver is then responsible to
>> enable error reporting in the RCEC's AER cap
> 
> I don't know exactly what you mean by "error reporting in the RCEC's
> AER cap", but IIUC, for non-Root Port devices, generation of ERR_COR/
> ERR_NONFATAL/ERR_FATAL messages is controlled by the Device Control
> register and should already be enabled by pci_aer_init().
> 
> Maybe you mean setting AER mask/severity specifically for Internal
> Errors?  I'm hoping to get as much of AER management as we can in the
> PCI core and out of drivers, so maybe we need a new PCI interface to
> do that.
> 
> In any event, I assume this sort of configuration would be an
> enumeration-time thing, while *this* patch is a run-time thing, so
> maybe this information belongs with a different patch?
> 
>> (esp. CIE and UIE) and to
>> inspect the dport's CXL registers in addition (CXL RAS cap and AER ext
>> cap).
>>
>> The reason for choosing this implementation is that a CXL RCEC device
>> is bound to the AER port driver, but the driver does not allow it to
>> register a custom specific handler to support CXL. Connecting the RCEC
>> hard-wired with a CXL handler does not work, as the CXL subsystem
>> might not be present all the time. The alternative to add an
>> implementation to the portdrv to allow the registration of a custom
>> RCEC error handler isn't worth doing it as CXL would be its only user.
>> Instead, just check for an CXL RCEC and pass it down to the connected
>> CXL device's error handler.
>>
>> [1] CXL 3.0 spec, 12.2.1.1 RCH Downstream Port-detected Errors
>> [2] CXL 3.0 spec, 8.1.3 PCIe DVSEC for CXL Devices
>>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Since you're sending this patch (Terry) your Signed-off-by should be
> last.
> 

I'll move my Signed-off-by to the last.

Regards,
Terry
