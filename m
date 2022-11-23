Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FE636591
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiKWQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbiKWQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:19:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918C28B13D;
        Wed, 23 Nov 2022 08:19:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyL53kSFRv8rbyxcbL9gcZiThBuDhkMFvtCiWQR+sbx7zRvVMX9J4w77bbHCMhdZD+3fAID6OrwqE6/irhmSQrCfcFEcs42i21lz7cP6s3sD/0oCbpIlLYIWjewkQyWoOOkV7lY7NQt7ynYjMmHRiSlEd80OJk8DqdX40r9qPRfFx34J1kPBWNwqJtyI21BC/ts729StcAHzCJr+qgv9sVvuomS0GUt05COIaBrMgUzb9omwAvm7AZ5ax5HUoJVy22BV7bfHJCabA57s9l4FC59Lii+HBZlh5MsHbWqV37cz5JFENzA6//rsWZYi1kYNDtvqfEu2ZYdjMVcXw6Gxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi3sE1lmkV3Qq0qmhsvhucNPbidJI/VQpJlpOjJyQjQ=;
 b=elfcM5oAax1uUvJhqCTWb7hler/3HGRywEsdZEEgSmPM7wMYmc/r44vMk66MbHOUet0AbDc+iEkurp34qyQ0mBh0iJJ1ZIrxkA1NMqd7rsvwtxyQtxIJdf6UFq7RrfJ6P5+3DqLauYr++fHaDqAwVikYbaft+e0Zf2p+TwsFORcYxwh9hUtVtn+lBacsSQ+ORaqeGbm0K/Vew1ievuNb+eIa53SR/DpPUD7S4Rxl2gm3mX6wGzhDkve+AGx9o10UqBlC8e6VIWSJc5o9aPo56JXvbCPisOPUXuXUczACtBF5O7qCR76s1J8Dt/vfREMhQY0FwigZPUyBkSoBHxnT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi3sE1lmkV3Qq0qmhsvhucNPbidJI/VQpJlpOjJyQjQ=;
 b=DWTnWhOJhsp7f6EmL8rYcnCx2ZTXwyVAXNiz66XKzziY/PK+ycutnEd2uyzPdgw1PfgSFqvN8p78PrO71te/KUog8GQDcTpUCWWiGMDeB1nCHaekX/g00vg7RU42LoZoIldv/axxqM80uz98f07TOF5eOjKP246CGMM7L17ISXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 23 Nov
 2022 16:19:43 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 16:19:43 +0000
Message-ID: <093907af-2e4e-d232-1eb0-7331ff2b9320@amd.com>
Date:   Wed, 23 Nov 2022 10:19:40 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] kernel-docs: New maintainer and Spanish translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org, lstoakes@gmail.com
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
 <87wn7o9g9s.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87wn7o9g9s.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0180.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::35) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b69331-1e91-4d26-0d57-08dacd6e8795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgnYm7HxTs5QMw4hTmaOiVWXaoZoV6QDD6tcnG2rWx8bNQIF3dwNQjTB+DtWAhl6KPQXhj0B18DuDQVgkYX4+4nIcpyLtWOKQUuuWtZNZ1/dwA24NhUjgmX5g1MN3CuMwYEBkSY7xiANBwk2VlNXKwcrDudZGiM2yXjdvJTkrpohcUUFTI5cWOpqZvetl6ATOfj60DbLWepfwEOHqDpXOobrpj+QuqGNxFFr8ADc29y+45yjzTgqx0cgHTXuy98MGtsNHbQuWSfov9rNZzpQPvb16afo7URhvVwM1XPZQm8vgPVs03aOQ1LQw9FeBYJ1CjsVnsSPKO/dET6xKrKUhBKaRuy6L3wNwLKELHcWVq7L6Og6hvXxRdhzr7oVnxyRaWbMHczdRL+gVobNbzu+yjaFYSZwG9tMMUtLMDurta//tBvS8okmWAwD5KExmrdXbce9DSel0zYQYF3IY8wJBXpHt72x6mCnWuclpP23Q/pHQHIQer7O2tr2nqSxHakSFv/+P8MoiAWITQBHCoNaVLpsa1mtS+aLsYjAOtMg5XA0nubjIlQrMMw3bSmVs+Wc/zzHI9s2P2xqnllXP1BSKMiu/Y6Rw8H3Dqz+28bmG76iykPd4iRYgm8dkEGqsgbdC9ZiuERC+KL/uIZIvVzaWjSKBQP+JMS1TroYdoHk86Kbvcy9WPVEXYLpFe0jQLnIg9yccp1AcEpwenxHq1q+kkbxiag5OxiOgAOonyN1yy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(5660300002)(66574015)(6512007)(41300700001)(2616005)(53546011)(44832011)(6506007)(316002)(66946007)(8676002)(8936002)(36756003)(66476007)(186003)(66556008)(38100700002)(4326008)(83380400001)(86362001)(31696002)(2906002)(31686004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2FqYjRCUW1KNVJKeWRsbEJ4VUlYRmxSS1dYWlZsOGkxeERmbC8rd0dsdzly?=
 =?utf-8?B?a1NVQlZzTDZjWVoyOFcvRzNCdGxuWHQ1bEpkazF5TE9wWFYyaGF6UDlDcmRQ?=
 =?utf-8?B?VW0zd1pNbks4VHVDckxmcEhEZjNiV0h4Y1VkcjgyT3hNWXBBSWtHemZoS2d2?=
 =?utf-8?B?QWR3YndZYVFGbDVQS3FYdkQ0aHlSTGpjbGp5dGN6Uk9ZZkFXek1qVlMzUGp4?=
 =?utf-8?B?NTdGUzZlM3hNeWJUVjFYT3dyMVRMOE5CQi9mdW5GR0VtMnlsTVFTWlNFbVJo?=
 =?utf-8?B?ZkErNmxReVZaMytMVSttY3BwOGlVUGFkVnk0L3VCekRFRGhrNXBneU9TY3Yw?=
 =?utf-8?B?Y1ZhZk5VbEdHekFYNXpvemNYaEtIM3lERVF2RDZWcTU4eVE3R2FlekNRNitL?=
 =?utf-8?B?bVc3TmZsaVhtZlJOQ1FaWmRaK0VBOU9UTlpzNWRZeDNieC9ySzVuZUlLMlNN?=
 =?utf-8?B?ek5ZZWZGejYzeDhzZUZiV0R0ajc0QmlidVl5UC9ZMG5LbE85YTBXU3RmcXov?=
 =?utf-8?B?MUJUQUZSZHQ2Q3NuZ3BiUy95QWVmMUJ4VmVhZy9JSUNCaC9DNjZPZFNYMnhZ?=
 =?utf-8?B?UVQyUXhoR0pHcTA3RkJrQTZuaE9NYXRkQWFFZ3FRbWdpWk1DTlBsZmdieURB?=
 =?utf-8?B?WStZeGNsUHJiWHJlWnM4dXp3MEMycHFRYSsxYXAwMlpJSHJBRWxHeXpjNFY4?=
 =?utf-8?B?WVVVb1A3Z3I3emtpbmJlS2l3aXY1MTZkaVNoQzJqMS8rRThxZ2w5K1UwZHRw?=
 =?utf-8?B?U1Flblg1RDVTbXl0S2JDSU43V2N2UXpZbHdzdGF0QURyMGxDYlg3cm5TS0RP?=
 =?utf-8?B?NW1aenJTYS85Z0EzUVl5RmtSdktDNUtMZld1WnFhVWlLWTdsU25kVlZUZXBw?=
 =?utf-8?B?SktSYXVsblFlWXV2TFl2NUt2YzQwa2dDbElXeTlIU2dTUEVvNzFNbnY0OWVK?=
 =?utf-8?B?MlRwOXo3T1V0UzdaNFgxT25vSEJIdU5RcFB1ZjdGZzFzTWlzenJXRTJtQUor?=
 =?utf-8?B?ZmxaaDYzN3hncm0yMGZHYWNIOThKRXZTSVQxYlg5blNtSWVVZHlwZ1VqVVUz?=
 =?utf-8?B?RzNUNlVPMUJJT0E1N0VzTlBRdmdJLzVWT2NzaXlIQlRLUDhaYzJ6bXZWL2w4?=
 =?utf-8?B?aU8vRzBCb2pyajVZSjlDeUxMcnU1MlNqdjZ4ZTZEMUFRdW85YUVXcFRtVjBE?=
 =?utf-8?B?NTV4SlRnNE9qVjErNmpudXZrNENRaExaVFA4ZElkWWtUbENXcGRIVGJDNmVK?=
 =?utf-8?B?MWVKQ3JsMU9vTFBuMTJyOEVZU3BxbTN2TXZpcmRjbmVVV2tGdEFIVmNNOGEz?=
 =?utf-8?B?RmFadmJ0bjN2eXVNRytkMEJEbFl4UVVJdHZEdEJSMTE5RDBWdU51K1lvdkVk?=
 =?utf-8?B?VmJEVG5saEhKUXRHZit6aGk3ZTdScEJudVVXREwrZ0Y2cXhUYUVMVGtnWDlM?=
 =?utf-8?B?elM2cVJod3Y4cE96bU90Z3lnQUJsV1NsRmdLbi9IM0pKWloxckRxQjgzZzBk?=
 =?utf-8?B?WXBsRk5nUlR3WEZZRzc1M1MyTjdFMEZNdUtCUXQ2d2dzVnlqVkZySFZNWDlC?=
 =?utf-8?B?clZzMnNqaVBMVjBhL01QM2ppZ2ZHV0VhOFh6SlZ1ekJtQSttZThOUFlESEVT?=
 =?utf-8?B?UXFCakZKMUFtRmxMVmJ6WUV0dGFXZGwvZnBPM3hXbjExNyt6V2xxSFhkNUlR?=
 =?utf-8?B?RFZpZHRSd2hJT1JpZVdTcVhjUGRVdEhQTVBPcURyeDRULyszV2xUaXh1UEwr?=
 =?utf-8?B?ZmJnRWYyVlZZaCtFNEpZSEZySXBUSlBjZnpJUFh6dCtqK3R5Nk5mMHk2NlQx?=
 =?utf-8?B?aWtFVEVheFV4dHVaZnVBSmhTbVF5NllQNGVFNnRPMjh1L3loNFZDRXgzcDNJ?=
 =?utf-8?B?YWh2b1lnSDBjQlV3KzVTM29Mb0M5ZExZVFNvTFUwMm5JdGk2bFcyR0I3aGI2?=
 =?utf-8?B?b3lVTFRmMkFEandDNGhKTzdQSk1xZTBsaUR3UFhVVHFkVmlwcTFqUVp5aXBi?=
 =?utf-8?B?bjRyTmh1ZXNZTFhHM01aTVZuL1c5ejFTSG5jTW1zeEtXUW1sSERjeHcwMGQ2?=
 =?utf-8?B?dWZGVnZYRVk4ZGMxNzBlQ0RtZS9RcnBLWGxCK0hGSjl2RGU2MmljTUVxdWYw?=
 =?utf-8?B?Y3B2ellxQjJoYmwyalMvTkRjSzc1WjFYM3cySFBBODFCT1dYcFJKdXNFeFNl?=
 =?utf-8?Q?+y+OpVdsUJTjjeLjKjqeihs7IWaFFJUohXlTSnfgFEFC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b69331-1e91-4d26-0d57-08dacd6e8795
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:19:43.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQGrrzkxWhGZx9MoePCsp02JQIWcHMcQ9j05i7Izy91Ufy+v6B2MWBqoCFZa75hX9kT8xjFwqiohXtXNAUZNHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 2:58 PM, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> This cover letter is also a call for anyone interested in adding new, more
>> up to date references to kernel-docs.rst. The document has been abandoned
>> for a while but its original goal is still important.
> 
> FWIW, I made an attempt to update this document a few years back and
> concluded that it was pretty much hopeless.  What is there is
> ancient...what do you replace it with?  There is a vast amount of
> content out there that will go obsolete just as quickly.
> 
> I'm certainly not going to stand in the way of anybody who wants to
> update and maintain this document, though; I'd love to be proven wrong
> on its value.
> 

I gather there's two issues with this document:

1. The resources listed become obsolete, or dangerously outdated.

2. It requires periodic updates. Relying on some maintainer to keep updates
of new kernel material is a bad long-term strategy.

so perhaps we could try the following...

Regarding (1), old resources should be removed. We could set the retirement
age of a resource to 3 years, except for foundational books or active
websites. As maintainer, I would have to group old stuff once or twice per 
year, and send a patch to get them removed. We could use this patch set to
perform a first purge.

For (2), I think that a good way to make this document stay relevant is by
making it appealing to content creators. So _they_ want to be added here,
and ask us for it.

For example, Lorenzo Stoakes (CCed) is writing a book on the Linux memory
management subsystem. If Lorenzo reaches out to me when he is finished,
I could add his work to this document, and also send a note informing
subscribers of linux-docs about this new resource. I imagine that would be
appealing to Lorenzo.

So basically, if content creators reach out, they get free publicity and
a spot in kernel-docs.rst. I imagine there's only a few publishers of
books related to the Linux kernel, and that they might be interested.

As maintainer I would still have to update the document. But the hope is
that, with time, this document is better known and book writers reach out.

I don't know if that would have any success. Worst-case scenario, we end up
with an equally outdated list of resources in a few years. But maybe it's
worth a try?

Cheers,
Carlos

>> By the way, Jon, I read in kernel-docs.rst, regarding LWN.net:
>>
>> ":Description: The title says it all. There's a fixed kernel section
>>   summarizing developers' work, bug fixes, new features and versions
>>   produced during the week. Published every Thursday."
>>
>> but I don't think LWN.net is published every Thursday anymore. Let me know
>> if you want a third patch updating this as well.
> 
> Well, we do still put out an edition every Thursday, so it's not
> entirely wrong...
> 
> Thanks,
> 
> jon
