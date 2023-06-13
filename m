Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEEE72E730
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbjFMP23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240767AbjFMP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:28:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F9109;
        Tue, 13 Jun 2023 08:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etWhYSUh+M1L60jz3oOsq50XMSuepVIDAgD6CaiLOl1G6acmJIubhQJveiPwIrU6D/Zlvakjp8TD7xtHMtfgmSAngqmGZHaR5FuSNZ8tQys9T+HTcyHN9lFC0OC+gSWZyWSbO82NXf3WcNBrsqTFPBt3hCDw86OaB4IDmj57W8KSUsdnTPfN0PifmHUo/Fxc/lU0aePbNoodc1EkUQjgDli7QF7xGjcSpu5ixTa0vigk5PoLZM0LSePFt1+UhcETzY9Lo2nPdVpBiESlAFD/DlZ0o+kC6RJrVeWpuJA+id/GjeghGwuGCTeYxqApHku/xlZ99piTIUMu7t4V7cWfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVa0L9vddp0RWFpA16RLm5GMp1IIM2yatz+G4nz5G+I=;
 b=Vnt+Tl3I9wazPv6UgYYQBXMpkNVUT0XAalkbHykOZ63XGZmCCw7e8AlqaWPmkmbqA/gWxA78faeftZtc3tmYnx8GJMN0EfbWQDI4HHqBmrwf8PPvLmgpyestrSXPvwou7RucpLHUi1rzx2dj+ujndQFYs9wh5RLUpXMw7CRWpnRfzzB6vhn+O6ak7mpHTKO2LHbHi3tCoU+zMD8cK6eefGRsYZNvxKpzjtv/Cr/gnrskRgOjOx9fJtNYfn11nPiUireed9Z/1PJeLnyAiYwCy2w1cbPEbR/DlT+r54k507C+o5FhpN+daz28MJ/KBJTDmEYARL9it6Vd9inP4kLicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVa0L9vddp0RWFpA16RLm5GMp1IIM2yatz+G4nz5G+I=;
 b=xITPw6c/7SiuC90axXxNALJ53nuxitKyNmpgoFJSQ7sh/Dv2Q5v8TZ+0zkjUuVjAuh3eoqgoowx1/V1cgpbadz/BBPXvjj5sUFUC9XiGKkf3u5MH7pu+7sqASmMr4MWEMWqYgHQtVu99is2xCL1SAKoolnJSfSA/I1s3Xs1VDMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.41; Tue, 13 Jun 2023 15:28:22 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 15:28:21 +0000
Message-ID: <b17db058-c59e-8014-81ed-0bbd9a1564cc@amd.com>
Date:   Tue, 13 Jun 2023 10:28:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 23/26] cxl/pci: Disable root port interrupts in RCH
 mode
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-24-terry.bowman@amd.com>
 <64878016974b0_1433ac29473@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <64878016974b0_1433ac29473@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::18) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: bad8bbc3-78e2-4796-cd59-08db6c22d25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tw4zOJkoeGc1i8OsKWcgmOxwLd90icE8g81tGUmUcoLy7Bv/JDUZkcZBCB2xS8IIAriOK4GSGMZmlgmuf+CJ4hFO5emlyiJRcHRcaG1C3HFA1Y5xXQqPlctt9fEgxULZmcyKGZkqglpWnAcHK0YeRnbDoyPUbbwnDM6MIs2Zo9l94Fdxe/mcdMLuC2M6DqRrKRdBjk3tcQwykZl/Uwcm7wg59/1wKsehTZT0T6XI/cPPpQXuHWXQTlSvPnj3Dxj7ZYzkegi+Nr8pFWeDnXZOD90SJ7rL8EhCi0UDpqM+kxqIDKMst4GXAH8KyL7KGiYF+yeueeJ2TQjM/aeRUQ5TwPaFphU+GuyzubL6HUy0nydbosG5YI8VQs0ym1ANFA+wPFZC26Y9wAWPqGZR7FEsy5dpFdNYye6nTAYZvrsEjBpeKQujhrTrQ+nR/JjPKmn2HBCng3T/fu8QCqfjsHj7ITvwXo4qexewgd5Ajn16oqDkXQSYyzuStuOctxknSzKPuZoe0GXAmaJm515PT3VsMiJSy7D8mEJil1cWq5o6pmEM/cuH6SCH4lWv8u2kG6sammOohsETrkhMXQlFbNESkBGgiNqS7hxTUtZYaIU1F5S6G7881supr7MBt3DN5MD47MssuEsT4UGNfIEU0CEwew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(7416002)(66556008)(8936002)(66946007)(66476007)(2906002)(8676002)(41300700001)(5660300002)(4326008)(478600001)(6486002)(31686004)(316002)(6512007)(186003)(26005)(53546011)(6506007)(2616005)(83380400001)(36756003)(86362001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NZMm5wNW00cm1wbmRYNFF4ZkpIYmZ3Tm9RZHkreEozMExJK2FLWUo3bCtC?=
 =?utf-8?B?cG8rMS9XZ1N3Rkw5cDhNWS9BMTRVdFY2RGNRNUZsWFo2RzRQTmRJOGpEM2py?=
 =?utf-8?B?ckcreW05MTlrTzJYa1UyVmhlTC9kOXdkcUpudEtFYVh4bDNYc0s2c3dlU25i?=
 =?utf-8?B?eFp3MVF1RkVnYi8rY3ltMzl4SEZ2b2tCTlp1TGZzNEFCdjZocllLNWh6MXMw?=
 =?utf-8?B?anVleXRTa2duMHdteXFCYi9VSXRHQXBZVC8vaUlUMzZha1M1UmdUNlFKbENa?=
 =?utf-8?B?OUZhY1dPdnNFUm51RzR4TTg3MTdmVUpvbFIvUDdmZnZldXRNd1J2cGt3R25j?=
 =?utf-8?B?d2dRMDA5b3Fabkg1NThjbVFUMFUxYzFRbXlCUXJFUHRUOENkUkxJc3lNbzRy?=
 =?utf-8?B?NitTZzhjQ203cUtOSnFZbk1MVFozV29DVS9BYTJCa1NiWXVUTGRkR202Vm1n?=
 =?utf-8?B?Z0hiTVY0UW5zclFkQ0tNSHhQc3RURXpPclZWK0s3dm9JckRtUGtMY3BNS1Iv?=
 =?utf-8?B?MCtuNWFRbzlRbmhCVTNuQ3BYUEZVL003cTIzR1ZRRVVLdmlpL0tkbkYwc1NR?=
 =?utf-8?B?SVU4cTBYcUh5OXZuVjQ1VEFuZnVUOUJJcFFKSnYzb3hPbzZsUXpDc0FJcjZX?=
 =?utf-8?B?c1hSNVYwT252dFNBbnJZTklFbjhtblp2dE1CbTFXV0dIYTlINXVQNDQzcXJV?=
 =?utf-8?B?Z1hhVTNxMkVlSUExb3djNGJTT3dpQVJ4d1pHV2V2N3p0WHlzQVE2ejRjdkh1?=
 =?utf-8?B?MFhUa2haRmwvcUIvdW1PMWV4MkpZN0JIU0t0YXdtMm02Z3Q1Z1p0OU5DWDVZ?=
 =?utf-8?B?SXlzWFlYU3k2aHRmTkZBbkhtbTR4UTBCdXBlWU5jbXE3a3B6NjFBRjkvUG5Y?=
 =?utf-8?B?eUh6ZjJsc1dmOG1GOUtLU0s4eC9yOFhYdndkdGFFVm9waVc3V0M3Yy9weTF6?=
 =?utf-8?B?bkpwNTZxNU5LNDZsaVJjZ3E0WkN5b09Sd3ovdmRUV05kSWJPWVhpaTIxUHo5?=
 =?utf-8?B?cFRET2I0TDJ2cEJtK3pRTzZ0bFRsSDZZL2F3N0lWSmFidmsrQXY2Q2U0cTdQ?=
 =?utf-8?B?OFUyRTdHYzFjQTkza0xXNjBZTkdqL0tEa01QNFFNdHo5dDhPZDArNm9PSENv?=
 =?utf-8?B?cEU0c2tQcE4wdzlrTVhzdlVFT0x2TE52dFUvd1Z6czlWb0hSNkNCUysxdlBS?=
 =?utf-8?B?Z3E3QWRQQlRWWjBrWWZEYmoyZUp0YVF1ZWZVYWJFVjh6TVlIZGhrOE02UVk5?=
 =?utf-8?B?UDJJTkg2a05zN2hUbDBTZFhIa0M3VXl0cEw0SVVLdDFtOWJiaElnclVXVHdz?=
 =?utf-8?B?TmdjN3FvTHo3a0hEVytRVUE4N0l3eTY3YkRmQldmT3JWMWh4aEtDYWhOckh0?=
 =?utf-8?B?dGtobGJ5Z3Q5WFZUeVhtTHZNSENmYmpaV0h5cDhDb29IYzVuekJoeDdzeFVN?=
 =?utf-8?B?eVQ2WXZUK1pnNnZCUmFITWkwdFIxNUpUeXpBUjdBeTRBdjd2VEhLa1RjWVpQ?=
 =?utf-8?B?Uk16YldnQkwyY3BnNHdQOXNOVmgrSUgrTEhwbzVBQzcyd3JYTStlMkd3QUor?=
 =?utf-8?B?ajVxU0VUeFFqeDk0WkdjSHE1dXQ2b1VtSDFWZ0dxejRwZXRZUkViT01aRmMr?=
 =?utf-8?B?bWtIYjQ5QXd3MUlVSFlxb1ZuaE5rWDVHNUI0ZkkwZkt1Z2Fkd1Q2blVZOU5Y?=
 =?utf-8?B?SHZSS2RYU3pDYmpTTlFoU3ZGM2JmMXpJTnVyRGpZN052aXdKSWN0MEVDdFBu?=
 =?utf-8?B?WmZSV2xUVnFyQmZteDNQYjkwM2N5QkJUcDM2N1NobklvVXg2Mjd2N3FiNHR2?=
 =?utf-8?B?WURUQmR5RE9VQVJGakRlUFpzenhoSk8yZGc0N00wUVp3a0t1WlFuWjBGR3ZN?=
 =?utf-8?B?dXNlWnhUN3pzc2tFc0pWOHd1TXFYOHo5QjdCVGl6ZmVJNzJZbTZVZ1BGb1h2?=
 =?utf-8?B?eHBORFVLdFI5QWxSdDNvYlM2YzFwTlREZTg3TkJWcE5VU0U1MVZEakpzWkc2?=
 =?utf-8?B?SjlVWEE1UE9Sd3VWelBDckhJN2dtRUUvbVZremdYak1saXJOeXNvKzZ4ak5N?=
 =?utf-8?B?U2dEck85emhRUCsxNHRiTVRJSTg5N2ZxTGxKa1JldHhGWXFjN2dGWHhReVh2?=
 =?utf-8?Q?qS+NwB9C2nzUpHwQqMIjRm/FQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad8bbc3-78e2-4796-cd59-08db6c22d25b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:28:21.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIrzJf3lpvO5URfq9uv2xnke5l9hPls73IcHAB5WF8J9luodfEYeTHmoBzzScpfAX7ucRIXwJL+lQ8+vn66QgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for the review.

On 6/12/23 15:29, Dan Williams wrote:
> Terry Bowman wrote:
>> The RCH root port contains root command AER registers that should not be
>> enabled.[1] Disable these to prevent root port interrupts.
>>
>> [1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index bc5d0ee9da54..828ae69086c4 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -981,6 +981,30 @@ static int cxl_dport_map_regs(struct cxl_dport *dport)
>>  	return cxl_dport_map_rch_aer(dport);
>>  }
>>  
>> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>> +{
>> +	void __iomem *aer_base = dport->regs.dport_aer;
>> +	u32 aer_cmd_mask, aer_cmd;
>> +
>> +	if (!dport->rch || !aer_base)
>> +		return;
> 
> Does this need to check ->rch? There is no path that sets
> ->regs.dport_aer in the VH case, right?
> 

Correct. This can be simplified to only check !aer_base because 
aer_base is only set if dport->rch.

>> +
>> +	/*
>> +	 * Disable RCH root port command interrupts.
>> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>> +	 *
>> +	 * This sequnce may not be necessary. CXL spec states disabling
>> +	 * the root cmd register's interrupts is required. But, PCI spec
>> +	 * shows these are disabled by default on reset.
>> +	 */
>> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> +			PCI_ERR_ROOT_CMD_FATAL_EN);
>> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> +	aer_cmd &= ~aer_cmd_mask;
>> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> 
> What about the scenario where @host_bridge->native_cxl_error is false?
> Should the driver unconditionally touch AER registers?
> 

Right. The driver should only touch the AER registers if the AER control is OSC negotiated to OS.
I'll add check for @host_bridge->native_cxl_error. 

>> +}
>> +
>>  static struct cxl_dport *
>>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  		     int port_id, resource_size_t component_reg_phys,
>> @@ -1038,6 +1062,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	if (rc && rc != -ENODEV)
>>  		return ERR_PTR(rc);
>>  
>> +	cxl_disable_rch_root_ints(dport);
>> +
> 
> It feels odd to modify hardware state within an object setup helper. Is
> there a reason this needs to be settled before __devm_cxl_add_dport()
> returns? If not this feels like a helper that cxl_acpi should call to
> change the state of the @dport instance it allocated.
Sure. This can be moved into the caller, add_host_bridge_dport(), after calling devm_cxl_add_rch_dport().

Regards,
Terry
