Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A6B607E99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJUTCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJUTCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:02:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC6A2958C6;
        Fri, 21 Oct 2022 12:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrsycQg9XlsfIyOSVctNpPqnpzVWcq8c2m1lTrhMVPppenXAcsAEKTFLzFhqW3Vc93Tyg7okTQ4azpd+vmRLSPU/t5oWoaRqWljyenTQ9Me1TL0vB3VT8R1EcU5iDZCypwjD3WjKYHrpvupaa8bZr2hbAoGKLNpHWmAsmEO742Z2ltLRAtMBQQ/VAkCORclxwlpfZ6w2AKEplBZIf5GSs/iArEm04h2jXLgg46/ffVz2HhFHTmI4hNUT8ik/CYrpJ1CLrR8UMFvpdxSOwjxqIKJHN4KARJFY9ICN4CitpEn4K30J1VxSa1pMVPn/JvF5EcoLCI0B6VOdnGNDaNcgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du/lkRYx7qzS4sCeIMpTE6BGebkXmYzn5Low5WZlVf8=;
 b=mm/rnScOCdc9wesyIy6BIcwlq5Y+pyK2PWdA2bLNmlwzfp41jGlA17t3l5c1+vnn8I7vypk9Ms4t/8yGdRhrO1sl8x1gJF+umeGeEBwNS3MQaSdgaJIZb13k5dD3b+68ePiiB3rceKO/gj6+kVI0GI1y4+8OQkGaakx/Ynor0uaftmF/7lALqrX4HfTnh4SJgP5LpIpxiCyFa7j+Bvx+y38/uL6H6++gZwNxkFfYtdFdzufUnvaxytJtyO+RFStMd5dGl5zUeEt0BLvHW6OVd167eG2HmsMTx/Y47fUuN5T9jrqzRo0ksjUj/IOQz3ou+OZyDLi0FH3u0T1jRXdR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du/lkRYx7qzS4sCeIMpTE6BGebkXmYzn5Low5WZlVf8=;
 b=PpsyOB3teV9wI4W32bORwsdFLblSc0QbB0JTwdfUY6zgrqg0xOvkG3qL0HRTkIIW9OTMN7AxJTmNo/U3QLHUm0qCMdx3ChxvUvGhn0vKfX7646nOXiZ4fn1fajxcK5wCJ/1xiIe9ivBIClTe2ubmS7i1fhSoUhYeUOuI+6dR80A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 19:02:20 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::9f18:a40d:54b7:7275]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::9f18:a40d:54b7:7275%6]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 19:02:20 +0000
Message-ID: <48abdeca-3a38-6893-f375-5e50b58a2d44@amd.com>
Date:   Fri, 21 Oct 2022 14:02:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/5] cxl: Log downport PCIe AER and CXL RAS error
 information
Content-Language: en-US
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
References: <20221021185615.605233-1-terry.bowman@amd.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20221021185615.605233-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:256::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 532d72a7-7f2e-4b66-4471-08dab396c76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/6xtytsNM9RDh1LFLp9mh0DkquFHqF1sOOBO9x3gL3N25nX3l+kw+gGg2j5n8MyxeJCZ+XumZ7yMat4/AzvROGQ8mgvovXKZThL7UuerkRhRX99IF0pbufBOZNk62SSUjJhPfOlJCUo3KZfyF/OyaG7gjp8l8W1ma9SrSzU0r53dZ+XXiKUYNKjIAhlO0TIGXlh8/eVox7sbBkLU+toHk1oCmFVUXb13SCVljXCtRlUWardt0LnA4SYzV14KBOBg17zZoDDpabRpEVyJcGJEY1gMDelM6CyrqVVUIrIFWjagD/tGN8GuHljyEsMtEX4Fjfs3Rguczi8oWzw0h4ttxxB+47bPVibblO1ybMiasMJ3imbQLAMnn4LBnwDceBV5YEJLU7eX8Icth+B17GWvFabjpn4nRvozH9xxZcTEVRkq0fwN1QnyrB+ga6WmrUK6zDv7gqdMzD12P83C7qHmYUp+bBP4JZZ82+C7/bIExXqXKkIKjCSZp8qasY2yxq/AWovjgwHYCVEdyy/Qf0r/x07hZ2BfyMCUK77/TlRsLwZCrN0XnxOXGpk4T43tJMDqxTTPLHrgObHXyPn/pS7t9HGEQ/o7tRg6kFFCsGk+en8gukyrlrIkCcoDmFC0TF75ApssO/XE8ezD9J1F3yKhdBrdq+KomeFr9EWk39XR4u786j6JAIjzP4zg62irO1mLDc6ZnzhNRJhmYjXXmk6tWfzIuIEErN36sD81ynrYyGD1tuDs83Y1UsAoWuXJzCBYfw9+dhH+jSrClwk5GpVIBUdibjD75wvJeZ7ooX1zDfLXZz4dYUtRzaD7qqp2FZdZ+1hGgFTJ5XekiPsYUMzOQ5xlzlCgP50Rryl32Zvm7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(6666004)(31686004)(2616005)(6512007)(6506007)(53546011)(8936002)(66946007)(4326008)(41300700001)(8676002)(186003)(2906002)(66556008)(66476007)(316002)(38100700002)(7416002)(5660300002)(83380400001)(478600001)(966005)(6486002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDMvU0QvMlQ4TXlNdVlGL2VmdGRrMkhTMXFpWXlSTUUxamJwejNEb05XdUIw?=
 =?utf-8?B?M1FLeHQ2Wm5YUE1VYWs3QlRERnZtRzNMK1lnb2lNU3phc29EVUVyZHFHU2Vr?=
 =?utf-8?B?M0o5VWVxa0lvay9uS2VyWkdFa1llRE1ldGRKOXJqTzVKTjF1dFd0eXd6RUN3?=
 =?utf-8?B?UllxQU9zWGNSVTZsQlNjNXZqa0hpRHpiY0NyNjJ2OEM2ZStybXBTZUdWSUww?=
 =?utf-8?B?ZTM4Y01CclpHVCttdkJ2MUVDQkk4Qzc2d01vRVlMQksxWXBLcGE0QXZRMjNV?=
 =?utf-8?B?N2s1VHRTVkJoanB5YWxEZlJObmJ2UW93Y00yRkVBQ2JhajJCRHhraFR2cUxL?=
 =?utf-8?B?VTJzRDFmd2VWVEQ2d3k1SU83Y3ZQcVBVSzlhanpVTVQ0TkJEN042TDdhNXRm?=
 =?utf-8?B?UjFqRjcxZ3VQL2NJYzdqVEZIUDdIUnI1NjJmd205aGZWSkRqeHBXK1c2bkg1?=
 =?utf-8?B?d3dwM0h2MjlwZlltejIwMHREaVBEYnFKbVFTWlkrN1NTazN0M2lIY1dpYzYx?=
 =?utf-8?B?eHhVWHloR1VSUzREdVhVMWRkZFkxLzdOYXBEclJUOURMYm5VTUdmNzVyUHhx?=
 =?utf-8?B?RENsdnIxSmVYY091ZjBYSmxtN2RlMHBrMUhEZ3NGdkd1NThBN1pJREdmcXFS?=
 =?utf-8?B?YlZjeW1ySjRBdEY1UitwSDN6R0tSYlE3SSs2ckNYRitraDBERk4vcGRUWU9C?=
 =?utf-8?B?WUhuU0tUVng4c0RudFRPYlA1YXkweTZJSFk2b1hzQVpqY1NvVS9kam0yYzI0?=
 =?utf-8?B?aW9hUnhsamEwK2ltRVBKeERpUDNDMkZjSWh5T1cwUDdJMGZiSnM3Y1p4eHFI?=
 =?utf-8?B?d01KZW9odE5taTB6QmdkMG1IM2tvN1Y2MUxGM0JNS3IwSHV6ZHgyRTRTcks5?=
 =?utf-8?B?Q0FvQ0FtQkhQK1hYaXU0T0x6ODJ2UWN6ZEI5N0pZMjhYbzFtVUZRSE1KNHdx?=
 =?utf-8?B?cXMvVkVzZjRHNGk3bU1JOTZLSk45REFhVXV0aE1mZzRCc0p4S2Z5a3g1bTlW?=
 =?utf-8?B?a3VRZS8rU0V4dk5KcXpNZ081WnAveCtXL1g5cVA3Q09iR0RyUlZaOWh0cmdT?=
 =?utf-8?B?dU1UckoyUTdnVDErWE1XRW8vOXZ1dVN3dXpib2ZBa0ZkME5KQkZvR0k4VTVo?=
 =?utf-8?B?N0JMSU5mK3BtMUVucDlHWVFjWEtBOFBiWHF6VWdFQ2FBTWttbXlvU2dOQUlZ?=
 =?utf-8?B?bWxaeGp6MXBqVHYwb2cxaEJlOTc3TDRJR0ZsY1RwQ1hxNG5BWmtLNTBpUEFB?=
 =?utf-8?B?Nzl6WXVwRDNoSWwvYXhFRXAzVTZjR25CelBwRTd5ZEhnd09VKzIxWWJuQ1Qw?=
 =?utf-8?B?OEc2Uk1GTEpCUjh2dU5ZbTJLc3I4Um1FSkUya2JyMzNneGt0ZEV5a2E0VEw4?=
 =?utf-8?B?NDNvQjJOZkpxZWRrWlJ6cG8wM1kwNEttcElKdzg4UDZyU0UrVzZYNG5OTlg3?=
 =?utf-8?B?OWlzVG5GVUtLNXdPamFuYlA4bTdlTCs0NWhuNnI4NHhSajVrYzlzYjhkbXRG?=
 =?utf-8?B?VWJsQ1JDL05wblhRN1ZYVFUzaUVUa0UyMExHczNvUWcwUk1Hd3M1UEVDTWpY?=
 =?utf-8?B?Vm5uN1EvZm5aNWEvM2I0KzZTVUtjemZBOTVyZ2xvYUJhU2tDMkR5a3pjajJa?=
 =?utf-8?B?YjdqS3A1eWF5OFBxVmZkbnluQkNZa2VCTUpScmtOazl3MnR0R3M0b2VkVXlF?=
 =?utf-8?B?b0N3WmI5bDBqOWNXMzhUa2dCYy9hczQyZGh0VmZEb1ozTldMKzBnU3VJZHFT?=
 =?utf-8?B?UGV0MDFqYkxJcnpxSmRETXBObmUrVFUwVWVSM3NyY0U0YTRQdVZaOEVzUWNV?=
 =?utf-8?B?RUpQMDBQcGh1NG1ZMFZURGZOSS96ODYrUGtuZHJVK0NMcVUrMXBuNXhJZVB5?=
 =?utf-8?B?bTExSUttcmFyVE5IdzVGWVpxT1ppS3Rmczd0RmY3TUN0VVdITlhCWjdtbzFE?=
 =?utf-8?B?aHNJK1o3SGlDNnQ2YVE4N0FRK2V0Uk5YR0JCTjBaUnZlS0xCaXBxRUV1bGpj?=
 =?utf-8?B?cmZ0bTRTdnBpa3BtbzZ6YlZxdE01aW9jdU5MT0tLd1B5SHc3aFhpckJZVm1v?=
 =?utf-8?B?a1p5Q2h1azZ1aFNWcWJrc2JSV21oOEVDVG51cFJxb1FCaU5jK21XeWxkWGFX?=
 =?utf-8?B?UGVuaFB2bENOR052QU44QTQ2clVGdktqRUFXemY3dVpvT3k5NHNzT01MVVhp?=
 =?utf-8?Q?TcLazku4ugb+oXifF+2+4xCtN2nQh9j06tmATTBh/cbg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532d72a7-7f2e-4b66-4471-08dab396c76d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 19:02:20.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61pJoXb8BN/DK7n4igGlaKTfNXDzqkX7zUGIHtyETxnOmKZdhnhDB/uQZSS5Lqv6UfS1vWb6FyOjpErjKutfDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/PATCH/RFC/

On 10/21/22 13:56, Terry Bowman wrote:
> This patchset adds CXL downport PCI AER and CXL RAS logging to the CXL
> error handling. This is necessary for communicating CXL HW issues to users.
> The included patches find and cache pointers to the AER and CXL RAS PCIe
> capability structures. The cached pointers are then used to display the
> error information in a later patch. These changes follow the CXL
> specification, Chapter 8 'Control and Status Registers'.[1]
> 
> The first patch enables CXL1.1 RCD support through the ACPI _OSC support
> method.
> 
> The 2nd and 3rd patches find and map PCIe AER and CXL RAS capabilities.
> 
> The 4th patch enables AER error reporting.
> 
> The 5th patch adds functionality to log the PCIe AER and RAS capabilities. 
> 
> TODO work remains to consolidate the HDM and CXL RAS register mapping
> (patch#3). The current CXL RAS register mapping will be replaced to reuse
> cxl_probe_component_regs() function as David Jiang and Alison Schofield
> upstreamed. Should the same be done for the AER registers (patch#2)? The
> AER registers are not in the component register block but are instead in
> the downport and upport (RCRB).
> 
> TODO work remains to add support for upports in some cases here where
> downport is addressed. For instance, will need another aer_map to support
> upport AER ?
> 
> TODO work to support CXL2.0. Should be trivial since aer_cap and aer_stats
> is member of 'struct pci_dev'.
> 
> Base is from: https://patchwork.kernel.org/project/cxl/list/?series=686272
> 
> [1] - https://www.computeexpresslink.org/spec-landing
> 
> Terry Bowman (5):
>   cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1 support
>   cxl/pci: Discover and cache pointer to RCD dport's PCIe AER capability
>   cxl/pci: Discover and cache pointer to RCD dport's CXL RAS registers
>   cxl/pci: Enable RCD dport AER reporting
>   cxl/pci: Log CXL device's PCIe AER and CXL RAS error information
> 
>  drivers/acpi/pci_root.c |   1 +
>  drivers/cxl/acpi.c      |  56 +++++++
>  drivers/cxl/core/regs.c |   1 +
>  drivers/cxl/cxl.h       |  13 ++
>  drivers/cxl/cxlmem.h    |   3 +
>  drivers/cxl/mem.c       |   2 +
>  drivers/cxl/pci.c       | 319 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/aer.c  |  45 +++++-
>  include/linux/pci.h     |   4 +
>  9 files changed, 443 insertions(+), 1 deletion(-)
> 
