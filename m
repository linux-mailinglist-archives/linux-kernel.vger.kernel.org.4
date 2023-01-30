Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2F681685
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbjA3QhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjA3QhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:37:02 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065BC3B0F9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI/1G4zhBR3do1A/MNOdvXQKjsYRCQh0xNxr7AR4+nNqh/CagrvvsJKn/+55bzEnqFtCaLTmmOQ+Vv+3nB5Qn243zhxDtAJPqDjrIBF6QdziVHQlMysSlAP7d9Vw/bR33PVQtGk7PqOPrOJIVyFGcxWC+ZH+CfFE91xURsxYT2d6fsKMX3NepwanfFOvvmmGaTmWBTsR7JfK+64CsZCa7hFVdZJIax9WsP1sOa8vsZXMNvSrzHIi9GiV4N/mPOUbhxvA4qJx4vSzDCrbH64Ufu3hKmMMC0+5g5v3C1JO0MmM95Nqjgr2dDjGI97HPQ4haYNNPQ6qSWE+UGY/kNlF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yltb0bXeGBdfrMLqmuvefDcBjciIwfJTdPGOQrUOsbQ=;
 b=HWPlwAAT9gpCCtJtSTi1j4mb3Pc5CJkvs+7EHc9ZShUUOUD3HUMVfqnG1p+xJA4bqdeVvbZ/bp01a4O4Oq/X4dTY2w3rp9vZJd7KEZAnpEA6BxhtoT1xJ7frIedP6YSA7jpjvkDYmq98t0qORp6Z5XJK05BoK/8Z2GkZjSXDSWeVUZHRoZ20rAeCjXQaz/ySzhCEIYCrTxTLkZirYIoo5VCTx5BWNvFUHUcnuPOPXNMBNslkh/a6WAuoi7iqcil35CQoFS/kpitAKSZ28rer1wwVtbDxI5h4vRuwOFgfbF6tmEZlQF51kypfv5Z35589+IeWhWk+fsSa5gW6lQlvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yltb0bXeGBdfrMLqmuvefDcBjciIwfJTdPGOQrUOsbQ=;
 b=C0OZZ+V9H+6ntnp0B016yUwKB2G91QK6nKyFofstLvAbn+axbRbq3ZwuydaY38kVnoP1AzuSNmzOuUnEejyCXEnyNQj8GFsoJIAoMOgzKlCD5ldSxnsuanY8KoVJCMmcGmK5xyR5lJzCftBFZwfOe5dtETCSC7fYnkvAu8xTC2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 16:36:59 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 16:36:59 +0000
Message-ID: <e0d52194-d478-b33e-851b-d5067f4a7669@amd.com>
Date:   Mon, 30 Jan 2023 10:36:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
References: <20230124211455.2563674-1-dionnaglaze@google.com>
 <20230124211455.2563674-2-dionnaglaze@google.com> <Y9emVjoTBrM2+Y5P@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <Y9emVjoTBrM2+Y5P@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0413.namprd03.prod.outlook.com
 (2603:10b6:610:11b::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: ea68319d-3600-4d1f-835a-08db02e034d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2G63Nzcv27Yn1itIV+e774DyszglvWV0b3Ov0c2l/7SqciQvgpPoJ2jtSWaRCc1vBwMohqIq5PlH5LSVJjb+NrPk+Mo3hq794dOTwK1DOrOwvEQ7FNFZVWVvVF4ygHs4hvOl9aYC1OFuSFly1vmQvrnWvlSKql2WG3/Kgt6QPR/QHz+Cg8Fv6QlAZY0LBKalp4ak2YmyYOjvG7U3BPuHoa9nUy2JLP4YE4IpU1AxWidMveiYtkBPLq63QhU6k4KKnYdWKvOeJd7bSx43Oe7wI/ZNiKg+HDbLwwImCtgO89v1BuySom+XSQfP4YixprT/22nbNalFNNq3ZSSv+4Rf1PMDfGcY/o2QHRn0MyehFg59ZMXE9+ai1KkpgM2YvzoYjthQXyTtoRKmNsXVxwPoXTyccaE9Jwdvgr7X7mlY998O52aFMN0X+PDtFLqGqbgCRe3hfJZpcGy58DfKdC5/tOM0WAS06yAG+dcBNoE8nYCFO64m2DcnbS7a4BiBoCInuxSVWO9hLj/B8aK6pTlvj5zrZeZA4TE9qb+ohXCpGHGGuNVmy0sLZI3eu95SOh9SK5uyudaodDhQxyH2E60gSvi4lnkDXaDb+B4tGhjkuv1yV5+GyHVhB8OeMbKDO9AenQTS106+O/fIUvpx/NURTuGoW4KOWRK+VwRN7TNPvBV2nFn3AxNOkNoCcBuZiOGR/EqFQO1xOmJwxGSPiCjjJZISZBx8WPt/FKqBiKRG7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199018)(2906002)(316002)(186003)(6512007)(26005)(5660300002)(6506007)(53546011)(36756003)(110136005)(54906003)(2616005)(7416002)(6666004)(38100700002)(6486002)(31696002)(31686004)(83380400001)(86362001)(478600001)(4326008)(66556008)(66476007)(8676002)(66946007)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG4wRGVkb1h6NFBtZTloc3pNVDVVY3V6UHJNUzNtOG5JaVpydGYzcFVpVEgy?=
 =?utf-8?B?ajgwRWZzQ0Zrd2JPNEdHVExmdXg2OWNKYzNuL2dxRnFwTi9yVk5wVkkrYWdM?=
 =?utf-8?B?SndDRUVwQ2xDc3VkekZhYUpPMWdJbVkxRnBJa2oxWnFydkh1ZllpNGlGVi9D?=
 =?utf-8?B?UGxCS2NWbm1XaW8xOENVSjJ5blFzeDFtYkUybkJrUWRXM0hySURHSldNcytX?=
 =?utf-8?B?eGYzekFWMDJ6ek1lM1FQZDU2SEZQYWxyNmtFZU41VC9tK3B4aDdUSWtnUE5V?=
 =?utf-8?B?ZGUrS2cvR3A0dVlhSTcvSjluMFNqRGlMRHR3U0dKMW0rT3BTbGxCZE5FVUF2?=
 =?utf-8?B?UHk1bVFpYzN3R2UwYitEQmNLak9JdG9JTThNVzRtTTh3aDhEQ1BackMyS3RT?=
 =?utf-8?B?czkrUThaVkNHbUZQQW5uSnBxSGRudlBBZkwrUjVNaWdZZWZmYlJWa1FWeGlU?=
 =?utf-8?B?TUZMc2sxcWxHY2trUVkweWFuNDVlVTVHVmNoOTAwRkI2ZTQ2VTNIaGhIU3Rz?=
 =?utf-8?B?a0hFcEhscHhFNmdhT1E0NEVMZlNxVTg0cTJad1JPRTNzY1NKZisyNzZiQS84?=
 =?utf-8?B?UG5KVzluaVVOcm1PVGp5ZDRxTElnckZYUVJ0blA5WTNUZlB4Mk14T1NoVVpn?=
 =?utf-8?B?UCtUc3ZiUUhDdnJ5WkxjMnNTSDRGOW9Dc2hUcll1UGFZZWh6R2NBNlJ1eXJz?=
 =?utf-8?B?em01VEZCbkpCSHd5RE53N3VUenZUUHRqcDRuTTVXRDBJSENPSHZjVkJ0MjFH?=
 =?utf-8?B?dHNqeDRFQkd2VnRhSElYZzJXMm5Hak1jODdKVzhzdVkrSFBxcEU1d0hCL3ZY?=
 =?utf-8?B?akd5cXBhZWhyd1I1NkpVbVVET3NRcW43bmU5UnZsQm1ZUXVlK1ZSWGVsYThj?=
 =?utf-8?B?aHV0czZySjF3dnEzamtaaVhjaDljSGdNZ2FOY0piRzBHK2o1MG5OMyt0Wkg4?=
 =?utf-8?B?VTZMK1drWEpyRWFJcHJ6Y0p0OFRKZ0FSMVJNbG1jTDhFcytzL1VHYmFySkox?=
 =?utf-8?B?dnFnSDlqUisxZ2pNWnZYU1dlRys4Z0dRellLUy9pWXg4WC9Kci9pb1FFaDJD?=
 =?utf-8?B?QSs3STJubGNwcmdESW1IbVMrbzJQVDRKenNoakVLKzhVcy9lYndnWTZXUkhv?=
 =?utf-8?B?YjZ6SG9FcjI5a1cxUnpOY0tNdlJuSnc4SEtOaThVWEJacUJ3YlZvbEF2YUFC?=
 =?utf-8?B?ZUwwVDE4WTJrbHh5OFF2c1c4N25BODlGSzZEajJ6d2h0b3ZQUEtDWVpkZWFt?=
 =?utf-8?B?d3NZb3QwWWxZTFBHMzh1ZGVNT3Z6MjJoekZvWjVRcUk3ZWN4b3B4ZDlVUDZG?=
 =?utf-8?B?SlNsUk5SaEUvdDlVeEFMS3FwT01aZGxPS3pJWmlTK1hJTXBqaUhDUGNoTkhp?=
 =?utf-8?B?SEhPb1Baek9zT1RVYy81MXdDdXlKNzloTWZIQUFDZGhiQno4YkoyU3BQWFlU?=
 =?utf-8?B?eTZIQmZjenRHZXhRWm9EYURsWXlnOHRIVEpvMUkvbGx4bjBtOVd3bUdZVjZR?=
 =?utf-8?B?dDg3V2RQTmV1ZFJKLzU2TGlwK1VwdmFUMWVBSjR4QXlyWGlQWExuemVrSDRI?=
 =?utf-8?B?UGZqMEVFelIyandXb3V1QUlDZDBFYUR2QlVxUlhzRkpleDIzcFlsTytlb2kz?=
 =?utf-8?B?YTZwbE93NUlTODFFM1YvazNQZWpMWWFHdjQ3djRSaTQrTDgvVHBWWlR3UWRG?=
 =?utf-8?B?ZG1mdUlEdXl3OHVnZ0c3YWFKNTBDRlNOSjVMQzFsbWxqL3grbFNFWUVyQXB2?=
 =?utf-8?B?TTJPNGZYN2xMMlJqVmFYb3BFd1ZhSnJlaVE0MXY0YU5LQ2NTUDRrbTlSeGNP?=
 =?utf-8?B?NWRWRVhlRFAvYlh4eWt0S1pDRVVBRWhXWDZrdUxrN04vZDgrM2FqMVA5WDUz?=
 =?utf-8?B?cGpHcmZLejRIRSs2ZW5UOXRCUHlaRnB5UG56bzdNbGIrM3VRSjlQblkyeHpa?=
 =?utf-8?B?Mk9rTENrQ1A1aERKM3pQMldpS3lhWDZhMlR5cDh5VDNoTUppaHU2dFhlOGlE?=
 =?utf-8?B?MzFWTWFNSGRmc1l4aGkwS3JoZE1FamRrWDBvd0RwRC9pVUVXM013a0ovWENn?=
 =?utf-8?B?ZXdkV2xINTN5K2I1MUJZaFpkd2lna3ZwK2grQm5PUDlvdTNtb2UxZHRqbE96?=
 =?utf-8?Q?Qc/kQechpBEteX6RB7ckr96U0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea68319d-3600-4d1f-835a-08db02e034d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 16:36:58.9104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9B2GpcrZ/tdZQiWjnAo8YFB95U9ablwDzE/PRSmrTi2t7c7HgOp39V2T31OiOERpprjFLKqTcbPYsmTngrF1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 05:13, Borislav Petkov wrote:
> On Tue, Jan 24, 2023 at 09:14:52PM +0000, Dionna Glaze wrote:
>> The host is permitted and encouraged to throttle guest requests to the
>> AMD-SP since it is a shared resource across all VMs. Without
>> throttling-awareness, the host returning an error will immediately lock
>> out access to the VMPCK, which makes the VM less useful as it can't
>> attest itself. Since throttling is expected to be a common occurrence, a
>> cooperative host can return a VMM error code that the request was
>> throttled.
> 
> So where is this concept of guest throttling documented?
> 
> It sounds like this is something hypervisors do and it is all fine and
> great to do that but where does it say: yes, this is what we do and this
> is the usual behavior that's expected from guests and HVs to adhere to
> when accessing this shared resource?
> 
> Tom, is that in the spec somewhere perhaps? Or was this decided upon on
> some call?

Yes, this is part of the GHCB 2.02 specification document that is in the 
process of being published.

Thanks,
Tom

> 
> In any case, I'd like for us to document it somewhere eventually if that
> hasn't happened yet so that all parties are clear on what is supposed to
> happen and what the protocol is.
> 
>> +retry:
>>   	/*
>>   	 * Call firmware to process the request. In this function the encrypted
>>   	 * message enters shared memory with the host. So after this call the
>> @@ -346,6 +347,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>>   	 */
>>   	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>>   
>> +	/*
>> +	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
>> +	 * throttled. Retry in the driver to avoid returning and reusing the
>> +	 * message sequence number on a different message.
>> +	 */
>> +	if (err == SNP_GUEST_REQ_ERR_BUSY)
>> +		goto retry;
> 
> I don't like even potential endless loops.
> 
> How about you turn this into a loop with a sufficiently large retry
> count which, when depleted, gets this request failed with a -ETIMEDOUT
> or what not?
> 
> You could also stick a cond_resched() in that loop so that it can take a
> breather between the requests and doesn't hammer the hw as much.
> 
> Thx.
> 
