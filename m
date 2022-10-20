Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23AC606A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJTVun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJTVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:50:39 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1C41911D9;
        Thu, 20 Oct 2022 14:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApR1/0Af+cCFDB1KIupirC7JfSK7vCbJbt7o6E15opeUUAcfXvH1yvR9AuJyvWf7ufyyOFCf9Aabdj/S6KN0GCczOYR0vLduf8ebMSSxAzB/acH9k9d8aJCkhiFfw7hfnzrxnGyXQW4wCgjD0/dyOltlxRz54zrY7lXOpgsBeAYjSSriKgw/ROYGQBSQ8KY6ArPBRjidjhl81n/psSYk9ubErDBr4+vFOgscPh8yDwPwQCfcCP8BQZs0Uo4zp1ju5vD8XR6rPh00jipFm5Maz8ojQYPmvXJGWSmj7vG2zYMSJVbxGCzVhXsCGa8dINzBHrKP+6DfM0C91p2usjVdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLAbihbHvV/gpkyPrVxGpKqs9cLdpKRC3I4Ovi3D97M=;
 b=Lt1KelNfJZifVp59eqSTNC32URJx55PBK75ckOY+VW6ljkZTFtczV/H5StYVa2kqNXqqU5S1AL9/l0TAPQeUhBOQZwLDFjMWoFwMENxZnT0/BFnXuR8pznKmKbUCA5qEYzs4scYAr+yFsWanzYhwYVvxmbkGEkp+A5BkTQL2NJyh3WQs7+MeKm22YQgXsDFeC22nTwxXOXfHQ0rlvjYWk8/Z3AR93hGOEQY3xDYOn2CnEZoZGy8Wvs+Tjov4kwWskrGSDRgGrFn2yB9bqQuwaiEm1SgM6/WydUUtUe5d6YuUQNOf/VL1qGOPZVFkY5RDzQiSZBWtLA2uAhA7I8r3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLAbihbHvV/gpkyPrVxGpKqs9cLdpKRC3I4Ovi3D97M=;
 b=v/viAK9WyqC7KVG4qLICz7IBSotG9n88uUZpCP9Po+WdHpdC5mOeGUO6V+blbRKWyEW40pisx8g8skpeWvhBJ0fIBD/jYZk0YhX5fzZx4mm/zBNNhMlzKf9u8LXfGv9MaUO/gCHjyCqsaVT9A5SAxH6h+0DSHNdquWQx4CnAKlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 21:50:32 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea23:1c31:9580:cca]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea23:1c31:9580:cca%4]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 21:50:32 +0000
Message-ID: <e29a0dfc-b8b0-ace7-0db9-d63ea6e635c3@amd.com>
Date:   Thu, 20 Oct 2022 16:50:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC V2 PATCH 02/11] cxl/mem: Implement Get Event Records command
Content-Language: en-US
To:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        yazen.ghannam@amd.com
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-3-ira.weiny@intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20221010224131.1866246-3-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 4605ecaa-dd0b-49eb-6706-08dab2e51cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3JLb7oCkqOObyUIMnDvt6eGQnrqEGRpLfGTtWxNzMjWx1peWCJJmlxZoZZ28w6j21bodDP2BvGDzJSgW81A/BjcDb0yQHe/Ybr573nAxY0m7n24xKjH4kSX9Lnh5wO0KhHLKXmHWblQoPMkUoKJcies4Ote7AT3GtYiYQak7CN06eA1wxEQBLtfLGuAXIv898CedlBLX0X3lVNym9HkXjejZSH2QeMqysZ8WxiHGDr+kKLqqATeqO2T9wN+ZuuY9QT4l9RqhzY796FUpPgwMGcM//iEKoEqNWhgZlIV1tyRMlqGUJdN2iFlvfE+8abwuxoLNlFJ330TD8UKC/Nae5fG53DpK6qcOPLcBgv6aj7v7wG/jRGE//tA8R2yxhSu62pM7d7eevR2J1MERpbufsQFkaEB82YMtIh/O3V3/ROv8i/6yHQQNuabwp2D1npVHj67ZcRtqNvDpHQN7+7D7+7aMtGLG21TUAgsiOcq6Cx8uSJDtgNx5l6WkT3HBvcgwcOW/jyn7WLliPiEKYXpyFEYauEernzQcn6CPGirUBYU7BZok21b1cwd4DHSXMtl3q0oQu0qKtcsZlS311+O0BRSaQPSr08diQKS3AP3KjNz79qFrAJWiN9Rb+fC+BzBJacAfphfLmUUcolFxOXtI5lWP+vkHIzhjrYWrLoRRmco/eILem4oP/Zhu/Pyw8oOKJKrQVk4PDnZt2qdgCJXxTjoNKhleTOz9Db1AfBAoqmIMbhuuovvMG2Bkm6IL7ch7HudqCl6OP77j2icGNK5fRQcFWPExZAdzE7IwNhulfR5W5ry+sMrUMKbmYmuhh3Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(316002)(38100700002)(86362001)(5660300002)(31696002)(6512007)(41300700001)(66946007)(6506007)(66556008)(53546011)(8676002)(66476007)(4326008)(8936002)(6916009)(7416002)(186003)(2906002)(2616005)(31686004)(54906003)(36756003)(6486002)(478600001)(83380400001)(43740500002)(45980500001)(47845001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZNWC9ad2E4OFhWSHd2emR0aHVTVGU0M0tlemRObUhqQ09LM1VVQUhnQllH?=
 =?utf-8?B?cmMwTjlsb0pQT0VNRy8xNitUeXVxL1dWeVhSdWoyVDF3QW8rTmFDTUIvMkh6?=
 =?utf-8?B?ZmFwdXE4MExEWTFLcEs5SkJta3VETmZsckMydHBHZEhHNVA3YlIzcXBGUUlG?=
 =?utf-8?B?MmJpTmV1VVdHZkdXakhucVVQQTZVbCtNM3ZqdVpIamVPTnlVaW9nQ2oycEY4?=
 =?utf-8?B?bHR6eThTdnpFUXlWM0RXM3VLTUk2WFlXblhYWkZNTGRtbHhKYUN5b2NvSE9s?=
 =?utf-8?B?RU9RL2xFV0VtVjRVTTZYVmtZekplMWhUQmVBaHkwaW1jTmFNTDJHdUI3REdT?=
 =?utf-8?B?OG5FQVVlMTZabXJmY1B6SmZQSkZuSktNYVpTd0VLbDdWN2lMTy9CeGNZRGFX?=
 =?utf-8?B?ajA1UWYvSmQzSm1wclZNSEpQbXNwRDdhRWVmanBWd0N4UUVpOXQ3RTVIclR2?=
 =?utf-8?B?Uk1JZEN6M2NmazJreExkQmg4UVRqWlVXMDFmZHphaEp1RW1BUk5qZk1pdXgr?=
 =?utf-8?B?WXc3Nk9SRnRLVk82UjdkaEUzUVVXeEdmdk1PRzJtUmhERTZKSC9CdENVSlZN?=
 =?utf-8?B?TC9sYlVDZGlIQkZ1bEs5ekpGVVVzV015Qm56WTJIZ2wwN2tvcDJ4eUQwOC93?=
 =?utf-8?B?SG84WWYwSDZBL1FhV2UxcllIZjBxem9ZV0IzSzlsajQ5Y3NUOUFtLytlSkc4?=
 =?utf-8?B?SWlsWFUxd0U2SUZiVDVIMVhOK1lSdS95Q3dveEM3dE5nb2Jlc2dvV3NOQmF5?=
 =?utf-8?B?VFNkSjBCYUhMSzVoaFhiR3ZWZEhacGRvdjJZTStuSEJrYnJNeUlYdVFTTUc1?=
 =?utf-8?B?aEMvR0xtdFdPTC92OWxwMmpNRmRSbisvb2dkQklTU0d5NWZ2blpGZVFaN0x0?=
 =?utf-8?B?WU9Rc0RROVJwcWd5VkYrQXhwVXR3UnlsVmY5MllxU3N5WEVyajJJTFdCeEcw?=
 =?utf-8?B?dWdzYllWUGduUEdERVJHSzNuM0ViR2xic0wvNFF6MlRJQ09WMUo4S09DV1JD?=
 =?utf-8?B?QkhLNHMza3R4VWRFbS9kWFA3YjdDdmsxZ0VOZTJUd1VaZitQK2pQTnk1WlZP?=
 =?utf-8?B?UG9hTWxTRGVtSXZqQnhHcWdEZG95S0MrK3didmdNSi9tR1k1aDczc2ZGMm9k?=
 =?utf-8?B?UHk1ejN4ckpKOE5WclBrNUQyaFFodDBlTkRXR09teEFLUVBnQ1o0Mno5ZUtn?=
 =?utf-8?B?RDJ3WThOcmRmUTc4dVlDWHFCSUd3RERuR09tdHRUcnZWT1VnTlJxU2xkTzlI?=
 =?utf-8?B?aFRoLzc1aUZUZkltV0ZZT1dIbnQ2YUhxT1FJRHJjanN5YWVmNmlrMjQ5WW01?=
 =?utf-8?B?K3gva29qSVlkR1hTQldXUzJLdVByWFU1U0k4ME1IeGFMYkE2a3V0UWY3bmJr?=
 =?utf-8?B?LythU3RaRHdkT1BXTFdqK0FmWmxjK0MyazVWcEZCOStTMVFvRTI3ZC9BQ1kw?=
 =?utf-8?B?eHV2R084SlpoQWsyQzdma1hKUDBlV0VkQXVQejNEOU04Um9oRHhORU9hRUwr?=
 =?utf-8?B?b1pDTDUzSGhaVVNwT3pQUWFiNXlQVWQ1a1RDczhVSWxNT2dMVGFSRkdTQXhj?=
 =?utf-8?B?aTNpQWZVeitYWVhibFZVSlpDMmJhM2NJRG94MVM5REpTb1RaNDhIdDhPK1Nj?=
 =?utf-8?B?aU85Y0pNdXhWcDFnNlVWK3FIN0ZQOHd4b2hSVlFVTWoxd2ZSdWh0cU9DUG9Z?=
 =?utf-8?B?S2pkc254dUhMTUY2eGJ5MHhNcnFaUS8rQlhUVjd5NlN2aFA5Q3dBdkV6SkRa?=
 =?utf-8?B?cDd0UWEvT1RYQUxCYitCb281bkt4TkYycVJHYTE5c3dFMGo2RFNTNm5QaWZu?=
 =?utf-8?B?eDhaU0lSY25WaytjdG9GMFBkTWlyWlY4bXdYNzg2N2pwL21Jdy91QmxJd1k5?=
 =?utf-8?B?WkRubXZiU1JGY0hYNi9nSUxoMTBGUUwxdkU5N3hWeE5IK2h2YkhFWk5YaHRF?=
 =?utf-8?B?Y0dzdEVnbU1ITEJnY0tlTmdmMFRObHJiZkFIdWczeW1VV3RLcFpYYU1ud2Z4?=
 =?utf-8?B?dkdmbFZoK1d5NWVMejBLQWl5Y01MdW0waEpJRDdsbm1OWmFPeVJIV3N6VWtn?=
 =?utf-8?B?c0V4aklidVpDNHYyTnJldEg2SktRem9MWHJhOS96SDh3N2FLMUdXRG96WkZG?=
 =?utf-8?B?RHMvM0ZLSHFEWmRJRk9Rc1Uvb1dob3ZPOHpKM1NzWC9hQmpqenp2bHF0ZWc1?=
 =?utf-8?Q?ILVMnSHZzLtkV8YXWrlUUi+5AAPykN1SLDc0HL1ENps/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4605ecaa-dd0b-49eb-6706-08dab2e51cd4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 21:50:32.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxYpAU3wAvbHr5FMzccimyHUjdRXXtez8CRY5Ytv1uok+B+hcdwfw3xr3cOa6M9BiBUqpB5YkMCKsrGMVe9uZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

On 10/10/22 5:41 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>
>
>   
> +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +				    enum cxl_event_log_type type)
> +{
> +	struct cxl_get_event_payload payload;
> +
> +	do {
> +		u8 log_type = type;
> +		int rc;
> +
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> +				       &log_type, sizeof(log_type),
> +				       &payload, sizeof(payload));
> +		if (rc) {
> +			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
> +				cxl_event_log_type_str(type), rc);
> +			return;
> +		}
> +
> +		if (le16_to_cpu(payload.record_count) == 1)
> +			trace_generic_event(dev_name(cxlds->dev), type,
> +					    &payload.record);
> +
> +		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> +			trace_overflow(dev_name(cxlds->dev), type, &payload);
> +
> +	} while (payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> +}
> +
> +/**
> + * cxl_mem_get_event_records - Get Event Records from the device
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve all event records available on the device and report them as trace
> + * events.
> + *
> + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> + */
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> +{
> +	enum cxl_event_log_type log_type;
> +
> +	dev_dbg(cxlds->dev, "Reading event logs\n");
> +
> +	for (log_type = CXL_EVENT_TYPE_INFO;
> +	     log_type < CXL_EVENT_TYPE_MAX; log_type++)

Why should we loop through each event log here? What if the event
record doesn't exist in the event log?

I got some Mailbox error messages like this while bootup..
[  346.387010] cxl_pci 0000:7f:00.0: Sending command
[  346.387181] cxl_pci 0000:7f:00.0: Doorbell wait took 0ms
[  346.387197] cxl_pci 0000:7f:00.0: Mailbox operation had an error: cmd 
input was invalid
[  346.387205] cxl_pci 0000:7f:00.0: Event log 'Warning': Failed to 
query event records : -6
..

Can we just read the "Event Status" field from Event Status Register
(Device Status Registers Capability Offset + 00h) 8.2.8.3.1 in CXL Spec,
determine if the records exist and just query those event logs?

Thanks,
Smita

> +		cxl_mem_get_records_log(cxlds, log_type);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> +
>   /**
>    * cxl_mem_get_partition_info - Get partition info
>    * @cxlds: The device data for the operation
