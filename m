Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C391D74D57E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGJMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGJMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:31:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC72B1;
        Mon, 10 Jul 2023 05:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agxzg70z6gNlplrh3c1scPMGGvtnmYideCdkAMm18ScDFjBxhrH0HP5eVPP+Fp7Y0NysoXjdNpTrBuqH+H5t85RAzolnPw6cW3d6LWEj4tNDNGxvjViumdSw+5SHYm5Q0K+5iaj2GARawsW7X4ZU+RQ3p8WuIEPQIZKE4ldvfbx41OcCiR/TJfMFML0JIm0vFzo9Kz0miA5WEOtiJoeJ7lq8Ji71rCHsBNQWIKGRq13xnoBIEzW0OSfA0klYJkhkrULQbbMgp2OEQlI8RNJQPuDrBPnq6SFJ/KGo2kGtOgzjOuyal5KPjCg86X8jkk49RgKpQHmS3KdcwkEI1vg56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN2Eyhwx96PaFivKgWWFdvxJZ/3EHW5wVRqY4WTiq1w=;
 b=D9ru/ScgD6ST8Aqhz7t+kwJO5zDKq4MFLFjpB13HMwcydz0IGbkopvF0NTsmEg/b3neGonj3v7bP7r0ZhtbFvmJgSIUGPdOfQPRtlWX2zo46bIZvdDO9bS59NaS4lkQrgEQ7ykF8LzNkMS/fS/b4YN0i+fzA08fYvb8J8s6ADFS0PVDKKFvjTR4p2d/obhETqgOtpnuap9xemTwimLI49Tk3XXpuRLdFwX2wsSuZbIUTc/DlG3gvDYaWTDLFIcsP7dNcpdSA2Zr6DZFdmBSyFEIzpjjEnGQyqiVcubRp6BDEg2Yzk0EoR34QHj5zr9RAhxTfywyU4xhk7sVvAR606A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN2Eyhwx96PaFivKgWWFdvxJZ/3EHW5wVRqY4WTiq1w=;
 b=dglpp650Ju6yeOwp1QnAe8Rp0OPDK3i9txICWRO+yar3WU0ME3RMeZfJtS2ipz9FBdA9Bez4SnwnIIHLZZwMsNMBz3jsP9MFRBLvzbM5Cg0WJ7Pb7T3olQRdiC8j7DPpqcuP8zOEKNf6Tz08UQOgtiQsLmUL4ybyGUx+tq3CfpKs+64EJNPRiweukqIv1Ittfq+wiqU4jqTplJpvp4WLIRLFXnlQiOXDj6PQgW+4Pu8igeE8sUDJaNXJ73xCGXco33EUeIfbve8Xb/jTU7yU/bQsN0WLkYYc1dRvL9sosGGz0AqzEjLoZHWQHGn/tnFjuu8ULJgwvWpuf3yo6YajPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 12:31:30 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 12:31:30 +0000
Message-ID: <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
Date:   Mon, 10 Jul 2023 15:31:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
 <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
 <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: bd402104-1bc4-4aea-e43a-08db814196af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMbYoE7dAPT3uF6G2prq0VyEBcbQ4OQP2QdGlBqhgGslBbKGOKPcO9pHzH7E4idpbEPIwrtTqYc0Z1/eZXT3qpyhnsNyRVAKxSt2mulfvNExfWJTgI11W+f+ub1E2xqQS9U+uZYkndlAbEIIbuyrMpy8e13GDCgSUzPR7EJnXMMhsacrCgiMEkPSx2ERPDR5Nmh9Nv1uasHTRIsuWufBn2xqQZltTV7Z5Z3x9DO2sLpDgWdgE0Ftm06pvDkiY+CD94+/kou/Fl8aoSSxQrFvuqJF6DaYtondoEBIdFhZio4AtBFgfYGDbA+5DWfRFOMbdpmXIv/iQHu++ru+17rBpbqpp8yT/P39xwL/9gweAIzmTWPkFho69CLJVaqkszGup73EtwLIckTt6j0yfrZRmrNnqllnxs9wFILz1ykQjsG+ftHqSHOEtiVkL+ztYqi1IMkwsW6pMng9e2zf9QeaZvzEvkitRyIyw+SADDKnFLtBxU86cyLeJuHyO0wRv7WKi9a0qeBHCVgUqPGghFXDOVeR95cXDKT9ZEerzUUL8KckQv6JcaAbRGHjKMG0FZguabzGOFgLk/7GeKMuT9CiAIS0pgURX/x1j1G/bQdQZMPUCmO9hLLsCpMxeGIa3XAgO3z44DjC3xB4RUfZP1xMug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(31686004)(6486002)(478600001)(6666004)(54906003)(83380400001)(36756003)(31696002)(86362001)(2616005)(2906002)(66946007)(53546011)(6506007)(186003)(6512007)(38100700002)(8676002)(4326008)(5660300002)(316002)(6916009)(66556008)(66476007)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpqVEpleSt2VnZkSzlpeFdpNVUzMERZR3NuY000aGMzeGhXdXJXTW5GcWdB?=
 =?utf-8?B?WmxZekdWdlJuZGhkNmdYUThsTDg0RmpEVGJhNlBIamtKSkZuRzgwczV1M3dn?=
 =?utf-8?B?OFUyQ0tFc1gzWmY3bHBCY0FwdG51cHRKTldocU9CeWJmalBkWmQzaHY5dDZK?=
 =?utf-8?B?Rng4Tm5EejVMNzVOMWlOV0RDYWN0d2ZHV2lwR3RvcUtScVJhNVlUTVdvL3pU?=
 =?utf-8?B?Z2FTYWxTNzRPeFF2cTlveDBRT1hZNlRwT3BmZGtHbkVUWU9hUlBXWWF5Kzlx?=
 =?utf-8?B?NVV3QnBocWMxbVRZR2t5VWJUSzQyNFh0MnU4dHRzeU1kVjN2TnUvT1pkbVZS?=
 =?utf-8?B?dklzYkFiTUpSNzNsTmlPMmZML21lYWRXT3A1c2x1d0I2U0dRaEJLRW0xREE5?=
 =?utf-8?B?RU9qbXNIejQrb1FtZ0Zhb0JTWG9UUEpjVU0wcFV3TklDc0RkOWlPRWVKNUFJ?=
 =?utf-8?B?WEZleE5ZREpubjlTaWFIUHhEblRrc3VqNTl2RkpCUEV3VVozZmFhQzdTQ2o0?=
 =?utf-8?B?TXhibzZtSjQxZEdpN3h5OS8zMHRGS1lHYkZ6d3lwQ0IyRWViTkpyQUxEQTFI?=
 =?utf-8?B?Q3pTa3p3ZXJNWlg4dkg1NHIxNVNlZjkrWlZnSUpqaE1KYys5MzAwRURKcjRS?=
 =?utf-8?B?bGZjaGpHQUR1aHNiM0R3UzZucDZxSlVXSiszOHVRQ01MdkpySHRmNExvVTdZ?=
 =?utf-8?B?OXdRRWEzSmFET3pLSWlvbWtRUTRSZ2ZxOXIrZXhBUFR4VHJkeUYyYjZnTkwr?=
 =?utf-8?B?VE50a3A0cldzaFo5OGFuL3VBTUdZcmpwajBDREkxZzlGRzkyY0hTZE54THBE?=
 =?utf-8?B?UU5wbG9JUy9XM21SNS9TOEYwYmtmdzNOVjJDNGtOUGtyTnFlMklhV2VDRVJi?=
 =?utf-8?B?V0NtV0ZpRGU1ZVZWSWx0bDZWSi8yRTZyVzFEZjZOS2IxRG1xMFFyZTVWSUVF?=
 =?utf-8?B?UmUzUXhkVHlZMUdoQ1Jod1M3OUxsL09WUFpObkRBU2FPV1krVE9jNWxUSG5q?=
 =?utf-8?B?L25GZmZibTVKZ09HQVRUNUJWU0o4ZksrYXhRNWg0cUlLNEFqUjRiejlzNHFi?=
 =?utf-8?B?Z0hmVmZpakRtT3oydllCV3czUFF6bWFUSjhMN255Rjl0dE1tektmT25Ca1hR?=
 =?utf-8?B?K1dIbXZXVGhsR3RTMlc4cWMraUlhUG5EODZHRXJJcm9mYkJlWXpvNnozZ3RV?=
 =?utf-8?B?ZjF5cUxXT1hiRmtGeitoRVBCZzlua0RZT2EzTmF6bTJGODdyc1J6VlhNSHh3?=
 =?utf-8?B?ZE11Wmc1aXQ1Mzk2a1dXZFZBTmIvbkVhck12c0lBR28rY3U0SElxU0k0M29I?=
 =?utf-8?B?ajNpenVpZHNseDIxUmNRZTZ3ZE5OcG81U1gvT2NCeXZ2ZWp1TGovWm9MZjVV?=
 =?utf-8?B?aWFUTjBWUU9tZnlCZUdxWGkwdEFQR3lLdlFDZmh2V1hpVmdGbXh6SXRENjg2?=
 =?utf-8?B?MFQ1QlJLVHYxM0k1V05uNTZ6TzBoSzNmemxMQ1dyMmlLUHVQbnNzUXZOcHRR?=
 =?utf-8?B?N3FsN0FibFVEK2MvUTB3dU9tdFh5azJXTG4ybkRlUWZYUDFCMmdLVGpVWk93?=
 =?utf-8?B?YndpczJweW8vb3l3bXdNS2hXOVBEVVJnRE9NMVFxUW50b1dWUlVlREpPdzdv?=
 =?utf-8?B?VXhaUG9wMjFyRU9VZS9aQW95NXI4L3VRMmRuS1gweDR2MnRNUFRXaURmVFE3?=
 =?utf-8?B?V3l0YzRRWEdKL2orUHhXZ2drNktBQjFEQ05Ucy96cUp1Uk56TWI4R0p5eVVu?=
 =?utf-8?B?clJ1RjlaTWtma2VJUkdySDJ6RGhnenRORVlOUmwzdVd6NWpwdDk2R1dLa1R5?=
 =?utf-8?B?ODNPMlhrcENXWGw4NUN5eWVhbS80TWxhRVBiOEUyTENVNkl3ZmN4SWVpd0Zr?=
 =?utf-8?B?ckwyZlR4bGhXRlV4ZkJBMmU0anZHTmp3LzRxdElWT2xtYUtlUmxMTUd0WVBZ?=
 =?utf-8?B?cXQrdXZKY1c3UU42ZWJJUkFlTUh2dzV3SnA3Q2lJQVEza0VzMmU5NkRJajZt?=
 =?utf-8?B?cWVXZW9HbXFFdWpIeDY4S09Ebmc1Vk1YYlhlSUt4LzVqRWxlczYwcnBvYXlt?=
 =?utf-8?B?alEyalFjZlYwendWcWszRmVmODNMYzdzT00vZ1FtQk9IMFZadTBGc0lhSG8r?=
 =?utf-8?B?Q0NJc2tneTNvNXVrd1p4enJIOFFZYm1KQmtRN2U0U0VyVERqY2I0YjRqcE8y?=
 =?utf-8?B?UE5ISytYK2t6aHdCbnpnQjBuczN4N2prVUJKc0szMlNSMHFHZHhkaUt3L3RL?=
 =?utf-8?B?QlhhbG82amRzSUdTQllodWg5R3d3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd402104-1bc4-4aea-e43a-08db814196af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:31:30.6908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNUNhUZCWRITcd4OcSIZ3PP2Z6EsUqnPdQNtiSNSNl7Osz6YrQmcx3WLrVscaNkHMD5GgJ86FSb9QO9XH+xcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2023 13:19, Daniel Wagner wrote:
> On Mon, Jul 10, 2023 at 12:53:17PM +0300, Max Gurtovoy wrote:
>   > > Agree on setting the hard coded values for hostnqn and hostid instead of
>>>> reading the /etc/nvme/* files. This should do the work IMO, isn't it ?
>>>
>>> Do you mean that nvme-cli will ignore the udev trigger when a different hostnqn
>>> is invovled? At least for the well-known discover controller the hostqnq
>>> doesn't work. Though not sure if I understood you correctly here.
>>
>> All I was saying is that your issue would have been fixed easily by 2-3 LOC
>> by removing the usage of /etc/nvme/* files that are usually configured by
>> system administrator and use a default values for blktests hostnqn and
>> hostid.
> 
> Okay.
> 
>> The usage of --context in blktests is redundant IMO.
> 
> Right, I made a bit of a mess with the commit message. Sorry about that.

I think it is more than just commit message.
A lot of code that we can avoid was added regarding the --context 
cmdline argument.
Maybe it's worth cleaning it..
