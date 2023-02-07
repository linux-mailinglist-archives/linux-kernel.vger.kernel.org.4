Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6874468E186
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjBGTxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBGTxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:53:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389494489
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:53:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfuLHpZTkBJStD7QAeZ3nIdiYdkvZGh7jzv5z0S5DYKLUqdsUmxMml9TdRDldOP5B94XDfU33uaJ1gPryGIbVAxUN+mHcwmBJP2kpYodNUygj1WtUyNBn+zkV+nuit22vqZwCFAziaXzkoQYD5koltRsW1ZwSUYB840iXujPW2gtUGDeiJndSWYyVNyuR6tYuFp3B/buvPfJ5WPBQjSYfxSrAfnq3ESjQfFdzqDwuxKcXF0Cb7SBPDLnN7fcCyQASGF+/bgeKv8HC2AQaWEI1bh8zsChdTfUVCmZNHYIlUW317LBPYKX2Du3copfFybLNngMpcdDm20oU/8jhlXAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXljrw/XX7QOAvZ2p8Yem/Qe1IXw1UYx2TD2c6FJUPA=;
 b=JZdVpllpeXpNc4yzJF/HOfEFFiOsS6gFilna9Px9yL6C+M9ZHu9n1zNY+YEnBzzby1XV5qTTYzGXtl3OV6j+nPPsVI2Yw7W4he8wVv6xGmC7/XPjAY4of76YmB7PaM7M7axZxlB7r7t72fN8Z1Mu35SlwB6XJX70gxlOHFDMOjMGPjl6IUdDcGA92YJEX+as6spdzF6R2J1ph57Kx+qk0R1qj42zEgAZbkBuPF/b2px7iXj1meMzXeABF5tN9KniicFO/y90RhVAIkehtpRVLizHioLpIe9QJ2JcmWTUnZGC5hQJ7+NVHJYo0mbw8bvoh/wR3THj40SnDJL8Ls3noQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXljrw/XX7QOAvZ2p8Yem/Qe1IXw1UYx2TD2c6FJUPA=;
 b=bzsxS32J7zo+acdRgovIyOQZ2eIOGUdT4XyUfr7C7mUiorCx3WEPIvG5vS74pRnkazhkfBTv439bX4M6SirwD8NjziRbqju6xU81wlsVluJ871zND3+M+RmwlU9mpTFnjF/dKhrJUB5uIldh1M6kajiz2Ce2NWnmoay4TRh6fW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 19:53:37 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24%5]) with mapi id 15.20.6064.032; Tue, 7 Feb 2023
 19:53:37 +0000
Message-ID: <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
Date:   Tue, 7 Feb 2023 13:53:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Linux guest kernel threat model for Confidential Computing
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com> <Y+HpmIesY96cYcWQ@kroah.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <Y+HpmIesY96cYcWQ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:5a::39) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: c472ff94-4832-4d05-65c8-08db094500b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdRl6icDvD1iT5AKESHkD8/edWZ4iZhn2PoS/mYTtOYdclKlYYGWrDe2x3G7zUe+1TYksH4iNnYSzPRHvaN3oaTvZgoJTQiDMOfXBjk/N2q2Eq6JBzI08Ia1zYbVZMxrzucZ2oXR20UkphscQguRjBx9++u3mlP02/g5ccJTtGmhHljaPFWmrVWaHA7jRR87oJBydijq4rW/mXO3T9+OKuuD5/yPOl9Pe+LvVEZGfDs1KYDO/PF14Hh17noIy0bDLLgVEvvytyeHJ/3vpj56LilXOY5DoD6PKS/6y2251oBlqlBgREkeHxN9k+8Ioa6W9MlP26rfTKEfAoFdHkdDXBf5+UiO1zh57lgHBZiDSvrBjecdzfhPrlLG992MqLzbw+P8t42qhsU9eeIIjNOGLhTr/7wLQFrb+K06+X0TilJoEXr+xvT/TEFKJoTeVWGHPE6+dSUFWBpMGc0I+fDvRL2afpi02kK59esblWNrzINle1rE2TB/2SDBIehzt8AFgxWgIGRZKuTxu5gx6LnR8umcfN47FPAEx3v9B9wCeu4+6U2L0Wxep/WpKXficVBdfFm2EEhzwMVvvpuuctZbvozhihO8Hh9jTCG2Yux7SV8TpLSBMeGH4RhWNe9XFNHQCQd/2yE0Lf6RJ59sTUVzVoIGSJg6H0ThvOqWksa8iS6ljN9qKIPykTeRdRAp4Y3hApdlb5ZJMTTPDOU/gFjzGKZWiLxUQeHdw9hfAWkdfL2g27v5nS+/bpX3/FnOnQmO+gaazDIAxuB+QsVI913oig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199018)(2906002)(36756003)(6666004)(83380400001)(53546011)(186003)(6486002)(6506007)(2616005)(478600001)(66556008)(6916009)(66476007)(26005)(6512007)(66946007)(966005)(8676002)(31696002)(4326008)(5660300002)(86362001)(41300700001)(316002)(7416002)(8936002)(44832011)(54906003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVKazJ6WUhHUWpjazI0bndydGVUL3hmUndoVXQ3SDV5V1hYbnpqTWxJRjdP?=
 =?utf-8?B?UzJFTDRRbmhESThvZjNJdzdCOEhWWE9nRzFwVi9GV3VlYkV2Q1E0WVA5K1ZN?=
 =?utf-8?B?SFZPOGhPRFlDWm16dUxhTWNOc1dxOWJKZmZpeWtQeVZ2YXJqcG9Zc1Vwbmgv?=
 =?utf-8?B?YURhYkx2RWo1eVZHb1ZUdk9NVmZ4NWM1TmNybFowOUJFTmNlZTRRWTd4YlNB?=
 =?utf-8?B?Z1k2am1VRmVOWlFsOUFwRC9BZ01KanJmS1l3bGN1V1hkZ2JQMHlzVlhFSkN0?=
 =?utf-8?B?TFkrY2NYd2VBZVJGUzVmU2xjQjBQWExGZFVNbzd1MGFjMGlKOS9CMFdIb2ZT?=
 =?utf-8?B?RVZoZVZ6U2V6R3ZWbzVzdXZUV0RiN0NSQXpZamxNSnR2ZGpKbW14Sm02aXVF?=
 =?utf-8?B?R21FZVlqWWo5Vy9sZGdLY2UwVTU0WWZ1VVpsN2R5QUhLUWNKTXlRaE00cHBs?=
 =?utf-8?B?cHpHU09qZm5xZUZxcTh4RnJoU2RsL1F2ZTFDL0xudVRRQUFheU9WdXYvTldT?=
 =?utf-8?B?c3ZsM2JtSXNyZFUzcjZwRGhZNXdVNm9HdmhVbEVEUkt1SHB1UFRMcGdFdk9x?=
 =?utf-8?B?cmV5U09EUWp1bTZRRHNtMkt3UlFteEJsZTl6aFZiVkd2WjIrUXZEb0JEVHkv?=
 =?utf-8?B?N2dXKzQvSk5LTVVvUDNuMWdJVnBsamNmZlpnNEZOYlh3bDNoVk9JK0RHQnRt?=
 =?utf-8?B?RXYzLzRTZDl2eVh1b2l2UldUWFdpZjFpckF5Y2ZLS0xkV2lPdHB5T3lycTRR?=
 =?utf-8?B?K24xU3hkZlNYQVlDeXVYZ3lhRVRpTFJXSmM5amVta2V5WjVoaHBtQWJFTDgz?=
 =?utf-8?B?UkJYMjBmZlFkZ21rQ1NuRGJpSjk1ektTTjdpRjBtMkY5RkRrNHVlTE83Ulht?=
 =?utf-8?B?cXNObzVCWVdIcEdGQ3BXOW8xdThxKzhrVTlBbmoyQ3c4c1ZjR3Z0cGtiYWR4?=
 =?utf-8?B?R0RVOXQ4dExzeXRLSlF5L1c2VjdlZzdWOWU2UnY0ZkMxNU4wb2JGY1VTWG41?=
 =?utf-8?B?MEpWUWRSWFFkblIyRkNRalBjcHlDQ1I2cHRGanFrQ1pvSXhBQ1FkUGk5RktQ?=
 =?utf-8?B?aXc3OVdMNmtSWlJvSklTYWdONG4xbDhVSkpnaE1QSlhoUUUrSEdndWZlY1k3?=
 =?utf-8?B?TEJ6RS8rTDZpcHE5Q1NLWXJManBJWnFSeWY5dUptK2RuazJQdHRmUklyaWx2?=
 =?utf-8?B?am85Wm11R3hJdFhYejA2a3hVRXVMazhyL3BmSlM2Nm4zYnd1d1FNNW1Qbk9C?=
 =?utf-8?B?ZFFPTG9XL01NZURFOThXek9pUW5OWTMxWkdJcjBPdERuRDNDWG9VQnV6RHd6?=
 =?utf-8?B?YUQzdWJ0Tzg4WGJ6N1p3Si9URDNLVFltT2Nvc0lQdC82eXRUa09KT2Fsbkt2?=
 =?utf-8?B?U0FUMSt1WEVzSGt4SWpTeE9DNFZTUUdZRE9mZGI3YlhNZ3FacnNEK2hBUjBa?=
 =?utf-8?B?WURCRXJBcmxKa29pWTc1WndaK2dXU0N3MGFZa014bS9obmZhU1pLY2VyZTNr?=
 =?utf-8?B?M3VBSHE1cW50RFFkL2xGc1Mza1VxNnpwWVNtNVNMRnNQRFNlWHdiK1BvVEZh?=
 =?utf-8?B?UWhleGNqQ3JOcnJXMzUvZ3pMdnJhMGFLTWhyN1JBYjVjWE5GcDNvcFdhKy9C?=
 =?utf-8?B?SG1uMUw4NkxyUlNKQmZCVkpod1FtS21nREhmZFRDWndQdjU4NlFzUzkzZ1pK?=
 =?utf-8?B?YXZyaVNpd05QN1Fzbmw3djRLbEJSWWswTmxobDk4eW9pS1NKbWdDbVlGRzZL?=
 =?utf-8?B?dXNoc05sSkY1c01VeS9zbjc3bUZpSjg4WncxVm1qQUt6dnU0QUg2MnpjbVU2?=
 =?utf-8?B?K1R5WFFHUDcrK0xnTDJmQnRyV3BLRmNpZlluZ0ZHeVlBbEpNYkFyYmlNZXZI?=
 =?utf-8?B?VXBRS2xJWlhEMGRoT2JuaEZYM0VQZCs0WGNxZjAwS1JEcmk2MDV3c2Q5dURF?=
 =?utf-8?B?NnJxVWpiSVhqbWtWYUlGakFGVGkxaVRIZFMzU0pNVEJpY1c1OXFmTUE2MGha?=
 =?utf-8?B?cnJNcnRTOGQrYm1WcFlvVHd5RlFxM0xMRlRtTXZkbjhtSHRQbU1WN280SWl0?=
 =?utf-8?B?VkhqdXZTU2RPU2xmT3cwUnVEanA2cVgzYUNCd3VkQWpuYWloeE81LzhhK0xs?=
 =?utf-8?Q?rEurtkuBz+dKEbNO7tcRW9BcN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c472ff94-4832-4d05-65c8-08db094500b7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 19:53:37.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETVaB/oPQkmn8fe6SLib//3vPU5SyDsAoQURBIoUkn4533x8EbWJTFMFx3AseNBII8XzBPCRyLtRuBWFDBQaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 00:03, Greg Kroah-Hartman wrote:

> On Mon, Feb 06, 2023 at 06:27:48PM -0600, Carlos Bilbao wrote:
>> On 1/25/23 6:28 AM, Reshetova, Elena wrote:
>>> 2) One of the described in the above doc mitigations is "hardening of the enabled
>>> code". What we mean by this, as well as techniques that are being used are
>>> described in this document: > https://intel.github.io/ccc-linux-guest-hardening-docs/tdx-guest-hardening.html
>> Regarding driver hardening, does anyone have a better filtering idea?
>>
>> The current solution assumes the kernel command line is trusted and cannot
>> avoid the __init() functions that waste memory.
> That is two different things (command line trust and __init()
> functions), so I do not understand the relationship at all here.  Please
> explain it better.


No relation other than it would be nice to have a solution that does not
require kernel command line and that prevents __init()s.


>
> Also, why would an __init() function waste memory?  Memory usage isn't
> an issue here, right?
>
>> I don't know if the
>> __exit() routines of the filtered devices are called, but it doesn't sound
>> much better to allocate memory and free it right after.
> What device has a __exit() function?  Drivers have module init/exit
> functions but they should do nothing but register themselves with the
> relevant busses and they are only loaded if the device is found in the
> system.
>
> And what exactly is incorrect about allocating memory and then freeing
> it when not needed?


Currently proposed device filtering does not stop the __init() functions
from these drivers to be called. Whatever memory is allocated by
blacklisted drivers is wasted because those drivers cannot ever be used.
Sure, memory can be allocated and freed as soon as it is no longer needed,
but these memory would never be needed.


More pressing concern than wasted memory, which may be unimportant, there's
the issue of what are those driver init functions doing. For example, as
part of device setup, MMIO regs may be involved, which we cannot trust. It's
a lot more code to worry about from a CoCo perspective.


>
> So again, I don't understand the question, sorry.


Given the limitations of current approach, does anyone have any other ideas
for filtering devices prior to their initialization?


>
> thanks,
>
> greg k-h


Thanks,
Carlos

