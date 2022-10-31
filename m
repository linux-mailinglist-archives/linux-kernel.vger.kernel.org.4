Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20945613B10
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiJaQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJaQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:17:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E81276D;
        Mon, 31 Oct 2022 09:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/r0dv7ojsZ8e8+zr8P18u8bVsO+l35/NYFy/oZ6nO7H7vDAhqZ4YIdz6+S21YaFdByk2R/L75b4d4ITQ3eODFfRyrjLro0xk4ZMgaG2swoQ5O15ybtFAuzpYzpCZWyAknaLbpaV3jqIlpWDEzwY/2/HpqSTnH/f1wuUbr1FPPCmKzGA18VsFbTx1THyl45K2pGiEA61XvAD56iDDhkKh9yAeLJOANDFe2+34+I18nFfKRlRzgHRel0qzHawiiIdpvEq/7TQNm8lk/WWvlL9RU4IaazjsOWz+9zTGXXilF4nLY0X3F/3XRnUTNDP0di+/NxUvoStGwYt5+yOOth9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiAHDhmeAayQ1v+Ox4i/jGzzKq0R+52/OD12yixlVFA=;
 b=P/P0sPYkDbBzH7ix5+slfSvNj/bqWmKQZiuOAfES2jr8b0rP5mYYJ2p+W9+YhVKWFQ3eViKn8Hbml0P4N/BVR0VLq7L6K0+bAYgLwx6WGmYQEr9tTteaLXEaeIM+meQck/wLaGwJw2tStiODHVGL0AvA8kzhj79ScTkKDHvT1C6hIU9VHP0Y6ELusnMoDyUsTXqVHXiR8TqlnSIpytlPMMK8BdoCOo/y6xXSZAaChsdcWOBgOXBsi1kHyhxj5M6SLg15TPoeCJfnlCA2N0TEG41DyUU7WKFmde1vX2xV3A8a/H2ikDpfQwq+NwtPjAnzSHLPvRd/ivjBJcmQYjRVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiAHDhmeAayQ1v+Ox4i/jGzzKq0R+52/OD12yixlVFA=;
 b=acuM7reLxR+EP6bj5XQBrdm7zqgkz18wIswgvlB76Ch0lPWQS5nvNaTC1qCvoSRh6Os2ZbzsPTJ79SMNrliBEv/RP33WIvFzQUwEgX76oEqDRZYwMTaJc4tDTNJ0zGSVGpeaIKVb2xRjGFjPyBMnF68PK0xFCpcN+F4Amd8OlQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Mon, 31 Oct 2022 16:17:06 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::191f:7d6:2182:dc89]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::191f:7d6:2182:dc89%5]) with mapi id 15.20.5769.015; Mon, 31 Oct 2022
 16:17:06 +0000
Message-ID: <8172394c-1077-a6c9-f346-e5f10f8362c5@amd.com>
Date:   Mon, 31 Oct 2022 11:17:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's
 CXL RAS registers
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-4-terry.bowman@amd.com>
 <6354725122f2c_141929457@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6d35dceb-a414-7d3b-722c-5507d27b7ce4@amd.com>
 <635aeac3a74dd_1172229431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <635aeac3a74dd_1172229431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:610:60::14) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BN9PR12MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9cc186-9d9e-4ae2-42b0-08dabb5b5a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IY58WUgjKSF1hkwB6Oh8JNctTybiT+xUOpB58zZ5glVXOpDN0zBniPQoq5AShjYmIL9yaXVPYRlYlYMhr3YltvCfRKmORSRR83PJeu0HYKUrsflecait3TePtOV6rChM8bBJI6Arm66roCr3rNFPXPw2sH7LLh+0S6e4xY2sS8wvR0Ch8zR0ql13q1wkLJAO4jZlJ1JmNuW50/BNqCoOGYFfYRyXmmQpMTLnTxnZyeawdUEMiiW3AiwaLByANIMleT28NIbDhv8ZznNr1E+m6YWoKdqwzEfN+AjUHOD/M3E9NHAe92aaRcr9lmWA9DvbzP8mAiQCk5S2r1k5iRTEYK1kP2mf8zAHDTF1ABeJ608gpGjB7+6EQr83PcOCS4EgQgMf+yslI11GQ/wci8TZoifEVaYb1ipNo2PMb9ChpOgfh32JFqprye8IpidOE1kpOBKDoFC5Dl6Td3NhgzBiTI963Gw7LLv1qpb1LdlxHJ0ClXXorv47iZO9hScxTwXvTtmIkMHiQLANzhAAbKzFuPS6DK9im1UkgNfxBX+dVu2cYr/n0d82cS/ZStoUOKb87ksSWr22GgYi/mkNfu1+K6PTqqBzBdwxgp+5ZArxeum2YFDsYSKH1PPXSx4lan4u0o6yiLMIBmypVswD/MuGQPzO5Nnl4i2KptOzYLlzgjC8rgHeinyGf9hXxMotIQre+3rSIw4dp/7es7BiLZ0GNoUl8N1kX4tv13kW7Mj6WyXZXxTE+hozVvHP770qYGRrRHpKPZZkiqjZsesjHwzYKyq2joGY1HHYNXAJ0Y1YkjWA84avxTP4+BqceOzHGuk7G5JGnu6UABZXZM71/jXgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(83380400001)(31696002)(38100700002)(86362001)(8936002)(5660300002)(66556008)(66476007)(7416002)(4326008)(41300700001)(2906002)(8676002)(66946007)(53546011)(6506007)(26005)(186003)(6512007)(478600001)(316002)(966005)(6486002)(45080400002)(2616005)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhFL3VhMTJmY0Zza0wyYnBiWTdiRDNOMVk2TkxLald1ekp0b21uVHNGOEZU?=
 =?utf-8?B?aDdkK0hGek0zWTFPUUY3RCtXa21XcDUvZXViNUh2MjhyRmpid1IwcjdaZlQy?=
 =?utf-8?B?Sk1RT2M1M09EZW9Hdk03NE9FUUsyTUNaOGgxM0gyYWhwWFovcTQvdDNqbk9u?=
 =?utf-8?B?K3BabjFRaDlCRkw0SjdFUWpMSmp1SzFLSEZxWks1ak5KZ3U1aWdFekpSTWl3?=
 =?utf-8?B?aStES2ZvdTRMa0d3Qm8vSGgvZlhKc3drQ2JsY3k4ZzhwUktFMmlIbWxQMDcy?=
 =?utf-8?B?SGhDR2xyeEtOdkxRUHVPRHhpNlZFaFVvR0gyNzZHVkdHK21HZFJaL2EwZGZE?=
 =?utf-8?B?b2wwOWdtODluUzZXbFBkbWUzNU1Qakl5ZUdXTmxCcWs3YVlSelRRbXpqQSsr?=
 =?utf-8?B?RmFickthQzZvb2VrSVhqdzdCeHZvZDc1T3pURGZ0REVuZlY1R3ZGbzM4ZkFQ?=
 =?utf-8?B?TVJWcFcrQklzdWYySUZ3N0ZPL2F5SHk1MVpqTW83Sm9IK0Y5TVdRSGFQcGll?=
 =?utf-8?B?RmRROSs5ZGd5MzFhYnlzODd3WmYwUXhZcWhoU2wvOHgxRWZIOWNFOFN5dHJL?=
 =?utf-8?B?M0xYRFVyWE1aeTQ1TEdrVEdiOEYvY1BqcWc0cTZvMUtRaHpZd3BsZ2t4eHpu?=
 =?utf-8?B?STRzdWlwWG13VmhIODRpME1lVkliRGF4Q0xCazJObnJLOVZBcmE3QTZaL2pm?=
 =?utf-8?B?NERva3IrV0FKcStlaHdLK2NWRzBINkZQVHZEcjFkWVVQWWFZM09mdk82NGEw?=
 =?utf-8?B?eGgrSWR0QTVjN29OSkdOeHNRdkREWGhJZ3pibmY2US9XdjJQa01zNDI0RWx1?=
 =?utf-8?B?UFBUYkl0eVlCdzZIWTE4eC9mNHdWTWNyMzZYODBKcEhLZHFtTFFtajgrUS9G?=
 =?utf-8?B?ZTdLUUNDM3ozV3FJNjR1MnlkYnZPSk9MVWhwUGVYMWp5ZnpIR3hVUUpQZXdi?=
 =?utf-8?B?WXdWSzRtZUZrNHdZeHFSTFZNb1g2VTNIVGdBcXZDWkJadi9sYndJTGVxNkFV?=
 =?utf-8?B?TytwOUUzZlFaV002cG1SWERjZ2I1cktpOGsyUFBJZWlaby9pZFNOamQyWnRU?=
 =?utf-8?B?ZUxPTnFicFNGdHQvSEZ0QklvNlAwSG9nUUtWRkdjVU10RHpTS2JrQkJkUUIw?=
 =?utf-8?B?OWFOQ25TTkFUUkRVODZTVzFNNEVlQW5xRTJnai9HTnhaVmJKNXlGYlBsTXV4?=
 =?utf-8?B?eXhsRHB3aEZoSi9oMjN6allHR3EyTXRUamdUMUMrV0p1UUhYRDdSMTdWQVB6?=
 =?utf-8?B?VkNZSDNtaEorYVB2a2FleGRDcGtva0hNWTlRS0hmYkxYdTBrazlUWGZ1T2E5?=
 =?utf-8?B?WU5Ua0U3RzBNOFY3VEVlbkZrL0V6NWduOHhUS3BSN3R3bWp1NUxLYXNZSVQw?=
 =?utf-8?B?Y0xuVEtab1hVMjlqaS9iVnNDUzhEckN5Y2hMaVFOeGdhVk9BODR6QVBlMjJw?=
 =?utf-8?B?RmM0ajhlUHllV0VQTTIvOGFUS2t0K1ViMDJuV2Q3OStyV3EzRUhtQWZkY1p6?=
 =?utf-8?B?dnBmS1puOHZZanF5czdobDh1SXZIaVh2TUxFQ1FySFA5d3V3eFd0SlFuMURm?=
 =?utf-8?B?NzJGaGFUTHk4VFVSWG54NTF1RUkvNGFOWVVmT3BMeCtLOVhpSkFzeVM3Y1FF?=
 =?utf-8?B?Yk13RXU1VDRxK2NSSGk2bXE3Mm5lelZxcHpseU0xUkQwcndLWUw2T3lKalRx?=
 =?utf-8?B?UXFRR25vYWQwd2JWSzlBbHpNeW1zTU5BcjdHWmpOZ2dlYWVLR3BQRGt1ekkv?=
 =?utf-8?B?MENnVTVSZGROZWxVMXpvNlRubHZ4aXRFaS9jbGIwNmUvU0wvYndvYmFES3d1?=
 =?utf-8?B?YmNmRDJ0VDM3SW9yYUhUQkorTHJ6d25CVE04MzZPS1ZFWWYrWlo1eUdxQkgx?=
 =?utf-8?B?UG5ESXJDV1pVeGM3NWJmQ1IvcVJDb2pQNUhmS3gxUzlhdUdSTHpPRDZReC92?=
 =?utf-8?B?OStNRG8rZ0h0WEtBV0RWbUQwYWpRU3hjQkFrOHVHZHZUUStjTGJIdCtzT1lD?=
 =?utf-8?B?Vk1rM21EYVl0V1hJWDIvT01PblBiSmlBR3A0djIzR2xra3hoaU1TVmxHcFda?=
 =?utf-8?B?dEQ0aG1pSGhuVzVNa3hWOGFGWUQ2dXdPOWNybmRBT1FCWGJzN0liSlFyYUVv?=
 =?utf-8?Q?tjIWbgISejQLLLR912Xslyk9W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9cc186-9d9e-4ae2-42b0-08dabb5b5a89
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:17:06.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yD0BWaDpkXb2YR1WFAKy5Yrn+RnQsmPMJNcSK0tdnAX3T0TJCxJhilMj3Avk67GjTEtZsQx0ucl88r6I9e11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/22 15:32, Dan Williams wrote:
> Terry Bowman wrote:
>>
>>
>> On 10/22/22 17:44, Dan Williams wrote:
>>> Terry Bowman wrote:
>>>> CXL RAS information resides in a RAS capability structure located in
>>>> CXL.cache and CXL.mem registers.[1] The RAS capability provides CXL
>>>> specific error information that can be helpful in debugging. This
>>>> information is not currently logged but needs to be logged during PCIe AER
>>>> error handling.
>>>>
>>>> Update the CXL driver to find and cache a pointer to the CXL RAS
>>>> capability. The RAS registers resides in the downport's component register
>>>> block. Note:RAS registers are not in the upport. The component registers
>>>> can be found by first using the RCRB to goto the downport. Next, the
>>>> downport's 64-bit BAR[0] will point to the component register block.
>>>>
>>>> [1] CXL3.0 Spec, '8.2.5 CXL.cache and CXL.mem Registers'
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> ---
>>>>  drivers/cxl/cxl.h    |  4 +++
>>>>  drivers/cxl/cxlmem.h |  1 +
>>>>  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 77 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index 7d507ab80a78..69b50131ad86 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -36,6 +36,10 @@
>>>>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>>>>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>>>>  
>>>> +/* CXL 3.0 8.2.4.2 CXL RAS Capability Header */
>>>> +#define CXL_CM_CAP_ID_RAS 0x2
>>>> +#define CXL_CM_CAP_SIZE_RAS 0x5C
>>>> +
>>>>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>>>>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>>>>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>> index 079db2e15acc..515273e224ea 100644
>>>> --- a/drivers/cxl/cxlmem.h
>>>> +++ b/drivers/cxl/cxlmem.h
>>>> @@ -243,6 +243,7 @@ struct cxl_dev_state {
>>>>  	u64 next_persistent_bytes;
>>>>  
>>>>  	struct cxl_register_map aer_map;
>>>> +	struct cxl_register_map ras_map;
>>>>  
>>>>  	resource_size_t component_reg_phys;
>>>>  	u64 serial;
>>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>>> index 2287b5225862..7f717fb47a36 100644
>>>> --- a/drivers/cxl/pci.c
>>>> +++ b/drivers/cxl/pci.c
>>>> @@ -586,6 +586,78 @@ void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_pci_aer_init, CXL);
>>>>  
>>>> +static resource_size_t cxl_get_dport_ras_base(struct cxl_memdev *cxlmd)
>>>> +{
>>>> +	resource_size_t component_reg_phys, offset = 0;
>>>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>>> +	void *cap_hdr_addr, *comp_reg_mapped;
>>>> +	u32 cap_hdr, ras_cap_hdr;
>>>> +	int cap_ndx;
>>>> +
>>>> +	comp_reg_mapped = ioremap(cxlds->component_reg_phys +
>>>> +				  CXL_CM_OFFSET, CXL_COMPONENT_REG_BLOCK_SIZE);
>>>> +	if (!comp_reg_mapped)
>>>> +		return 0;
>>>> +
>>>> +	cap_hdr_addr = comp_reg_mapped;
>>>> +	cap_hdr = readl(cap_hdr_addr);
>>>> +	for (cap_ndx = 0;
>>>> +	     cap_ndx < FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_hdr);
>>>> +	     cap_ndx++) {
>>>> +		ras_cap_hdr = readl(cap_hdr_addr + cap_ndx*sizeof(u32));
>>>> +
>>>> +		if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) == CXL_CM_CAP_ID_RAS) {
>>>> +			pr_debug("RAS cap header = %X @ %pa, cap_ndx = %d\n",
>>>> +				 ras_cap_hdr, cap_hdr_addr, cap_ndx);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	offset = CXL_CM_OFFSET + PCI_EXT_CAP_NEXT(ras_cap_hdr);
>>>> +
>>>> +	iounmap(comp_reg_mapped);
>>>> +
>>>> +	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) != CXL_CM_CAP_ID_RAS)
>>>> +		return 0;
>>>> +
>>>> +	pr_debug("Found RAS capability @ %llX (%X)\n",
>>>> +		 component_reg_phys + offset, *((u32 *)(comp_reg_mapped + offset)));
>>>> +
>>>> +	return component_reg_phys + offset;
>>>
>>> For the RAS capability in the cxl_pci device this patch needs to be
>>> reconciled with this effort:
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-cxl%2F166336972295.3803215.1047199449525031921.stgit%40djiang5-desk3.ch.intel.com%2F&amp;data=05%7C01%7CTerry.Bowman%40amd.com%7C17f2392d8abc4fcc3d0608dab85a586e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638024995411582774%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=d64IsDCPTyPaBmsUYXlvn0rBMyaG8AxYHMuKHTSTOs8%3D&amp;reserved=0
>>>
>>> I think we will want RCD and VH RAS capability reporting to happen in
>>> the same place, and that can not be cxl_pci because cxl_pci has no way
>>> to find the RAS registers on its own. It needs the help from cxl_mem to
>>> do the upstream cxl_port associtation first.
>>>
>>> Given CXL switches will have their own RAS capabilities to report it
>>> feels like the cxl_port driver is where all of this should be
>>> centralized.
>>>
>>>
>>
>> I'm working on merging the patchsets now.
>>
>> I'm merging the following:
>>   Dave Jiang's onto 6.1.0-rc1+, provides RAS mapping.
> 
> Sounds like I should add this to the RCH branch so you can build on it.
> 
>>   Roberts series ontop of Dave's, provides RCD discovery.
> 
> Robert's series is still pending the rework to drop the
> devm_cxl_enumerate_ports() changes, not sure it's at a state where you
> can reliably build on it.
> 
>>   And this patchset ontop of Robert's, provides AER and RAS logging
> 
> As long as you are expecting to do one more rebase on the final form of
> Robert's series, sounds good.

I found there is some work to manually resolve merge conflicts between the 2 base 
patchsets. I will change directions and submit for review using Dave Jiang's 
patchset (using the URL you provided above). 

Regards,
Terry


