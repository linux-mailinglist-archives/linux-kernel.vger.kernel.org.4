Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B86D0CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjC3Rcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC3Rca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:32:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE1CDF9;
        Thu, 30 Mar 2023 10:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeiE03Xpdwou7drOQnStWeUVLYjxkIGD4ZvrbVtrsysmaL5OMPLGCu1cOgJx+vlKA58vAPISx1bGwxx0glYBewiBn+4PTPusPl7pAhRpIzsgrO02PNZwQlU2TxYbbPwOGYVMPMrg7soqVyBl+/TcMUQEBbFDTHzI9TuLlxwfElK9C+hRWHL8PD46GueFV3ua2GqJgK1JDiw67fR5vcvjkL4+UPHhrf1LwLtYe70NPL8OgPYT4o4Jq/3whudNLa9YJG76rFdt6eIK5HEF/223x/O6TU5075zrezUYGlAoRGsubvx8RylTNy4BuDkkwPsKIcFqlIrd2XSuMMa32qyuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAJ11c+extkywp1tgWjA0xpXyuJ4k9z85jyc2oU8eeg=;
 b=crh+rjq33V7kD1FvQ75BRulZmvwSbGQHmJ+qyblChrRdN6XeaQZ0/0HXArumXYJhjMNeY57Bq77iYc8EGNl59QCQq0wW6tbI+Yir2tHJXssjmKC9PveZ729hHTFaCSssWIYKwuSVbGjRKxHevwroPdlnTrI1iipsKDoEarotS+gZAGCPadJO9XNCgXJa3lrO6qKa2fgjFo7QWkjUY47UfZZ2W/Lh3hiyrnstAP9g73TPOcTJ2BquZLf/ZbsaN1h5fqL25b1EGOK0KyGBfyXZrMggVRJKpyvIOmPy0Id2xIEjyO0rHENVFdLK/B5nmtqEjJdfBCzm/2DD0oSLA+MueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAJ11c+extkywp1tgWjA0xpXyuJ4k9z85jyc2oU8eeg=;
 b=NuxjRXnsLVf+vL497sxjrFMDul/7ds/vvIZl7BUigqsdPpBRlAtz2ekvXIiRXjcu425C1yfFy+8CG7txMJ+PvUr0M1OewStlDDWh7+8VGSBl2YO6456GMekzaS1CkadefoBFhveODP6CUg7Vm49+u3WaePvOYdOpP1iUTHN1HsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 17:32:25 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8511:7da:3d1e:4db0]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8511:7da:3d1e:4db0%6]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 17:32:25 +0000
Message-ID: <ebae6595-1904-a12e-d964-ec3da7217b49@amd.com>
Date:   Thu, 30 Mar 2023 12:32:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZCQVmIKXWXX2xvo-@kroah.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZCQVmIKXWXX2xvo-@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:806:f3::19) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f887e66-bd52-4e97-2695-08db3144b9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KmXgLqbPNW5fIwD6g27XKHUr1VCjJQDsmpr8BM2POggZsiJvopGXZOrhJV2xNM3DYfCo7YSJyuW7HhqScp1cxKSyItZC4mkbPeqrXL5Y7CZcg9KZ6O4AzUoVT2a9Cyjszuj+tHW1HX7qLr5QQ0c2wewBbJAPOqCOtFU/RyrSxc9MYbhj9dzHOVtPCjvWna/OVpDwqJZicfKBmIg5g4PMFo/P70dQQQRbZ9tNNIAxm8K8vBHrXIiO3woFeMnYmWqHP0ZIMnBEn+HztxBQ39vsQ2AbYxbUEZIhULuIAgypLLLk3sX4uc/5+R+SUv4CIhnUekaWWhqB6oHB7MpozBwRWjl8A07IZcyJW77vklXWohWqYw9HjsWIJvwq439p5g9srjVV4YCTGbno9PSwVr50KCX1rDlBjyE8OhtCZaplzq10nx1bdkpfka0O+aA6lYf7Ph73owQZnrvubKMmWhOAwKaaAFqQhuxBA4uf65h38czXSh7nYmMBV19lwHCQ7WBAEppYcSymd9DPrrLsXfrQ2L7x8v0/AN+IiAb+BFsGFJHwVkFo9BbC+4zwvQriowzNZMvtvGhlFJoDNAg4APe35O4pfWiLymekmy3OmhWeyk6JEd9MlzrjZlyH3p7l79XJJjE+7ExkSu9q6yV97qOsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199021)(6666004)(66476007)(83380400001)(53546011)(966005)(38100700002)(186003)(6486002)(6512007)(2616005)(44832011)(30864003)(5660300002)(2906002)(8936002)(15650500001)(7406005)(7416002)(36756003)(478600001)(316002)(41300700001)(6506007)(31696002)(66946007)(8676002)(6916009)(86362001)(66556008)(4326008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNRRkpoSzdmL0RPcC9rVmtGY2NlWmdhQ2pOekJJWWVKOWNrNy9vTDFSOWRJ?=
 =?utf-8?B?UDJoMjNDbVBsRFpSb3QzdFR0WU9yanF4a1E1ckFxZ3hOWVVibm5WTFpncTdk?=
 =?utf-8?B?MnVsNzJHVDdsZXdBVUs4dFQzQWJQbVpsdGh5VXREU0ZwOGlVOGpKeG9jRE03?=
 =?utf-8?B?QXo3U2EwUjRSWGpncDRYR3kvUmFIY2ZKZ1JpQUpYMFhkVzdHaGFBcEN4Mi9j?=
 =?utf-8?B?Ri9YL2dmQU9wSXZYSE9UMEJCV0M5dVF1YXJGb1h4T2VoQXB3UHk5eitEZFhp?=
 =?utf-8?B?R1diaTRZeXFFMXRGTlJ0cFIzUDlMK0N3a0NVdDhYdWhVVnhFK01xKzVVeXhJ?=
 =?utf-8?B?OWVoQ0tTcmJrZS8rdVNzT1Q2MG5DVW8ySmx0a05nUm9PVy85ZlY1QlZuQUxt?=
 =?utf-8?B?cUxKYk43Nm9UMXgvZldtUHVSSWpCN3lhQ2xZTjdZWEZJSWdGTmpTcmp5RDF3?=
 =?utf-8?B?QWpLQjlqNVR1MVFMN00xbDVGbUQ2TldrU0RIU0VhQlU3emdOUnBBSDh0RnJ6?=
 =?utf-8?B?UXdmbWZEcTN6ZW1HZFFxMzVaQ01nTzl1ZHN3VERSV0pzRG1RM3lMeUI1cHp4?=
 =?utf-8?B?dXFER3dzeklzZEZybTBvVUczdFNZTHdkajN1V2J6VnpaUWxDQ1Z4OVhjK3RO?=
 =?utf-8?B?SkJpSUlsK1JlMDh6WkNlcmljSXhMS0VRdXdHMm5xaU80M2hFN2xNVzQvNnI0?=
 =?utf-8?B?VkQwVzFGVHh2ZTZ4VWQvMzFPWHZYRTQ0d3VHRFJaSm1LVjFsU3NRejRXREdR?=
 =?utf-8?B?S2ZENGlLbzlROTl2d0E2YUswbW5ROFNTM2tmeWlNRlkwenVDV0MvcDZyTTRk?=
 =?utf-8?B?TjQvY0lqWUZGQUZaMXpXV21zQWp5aUg1SGptejdxSWVUbmZRblBFa0JxU09M?=
 =?utf-8?B?cjBYdDRxdkpkdVRVYUxORWVBK2p5SjI3RDhxUzVmMlA2dzNnVWFlZmRxQm9y?=
 =?utf-8?B?dVZpRFVkaEpmRXhEQXVzdE5aaDRXK3U5RlBFRnNnc0p3REFKV2hLMmZGczRO?=
 =?utf-8?B?dzBwV0tmdW15NkJJc0tOZDNGNkNkajRmQndhL0s5UXlsd1I4dVdoRVBHdjdT?=
 =?utf-8?B?WXJsZTVPNlhSb3hkSjM3blhLK1JVd1F3Tm1CUVZBdFFuV0FWM3V1V1loalg1?=
 =?utf-8?B?b0puY3BRbDJQYkJLREJDUXRhVXcxMjd6NGJQYVlzNWNiOGh6TGVYTHRBYytL?=
 =?utf-8?B?ZC9SQW82bXdpSWVvT1VHK1VwcDRIZ3RzVk1kbEt5OTRvUDZydVNyNGNsNFNo?=
 =?utf-8?B?QkdHSXk1dENnQUtPRkwwZW1UNjNwMUpKckhoeFRWTjMrVis3VWxGZHo3WTJI?=
 =?utf-8?B?akZPdGl5Vys1U0F0K1QyWEExTm9XRVRnYWlVRkZwTzdUL0krNDBYTEpmMDho?=
 =?utf-8?B?bktRVE0wbjV2S2tLUGRmZ1laQzRIVXo0Vk5JRGEwaEsrU2RJMjYrcXFNcHJW?=
 =?utf-8?B?bHlNWFcyN1U1amRzMUhuck5hSnF4bmRnZnJ1b2RwbVNhc0RrbVFwSDFpYzFE?=
 =?utf-8?B?dnFCNEoxTDRENExLMlQ1Z2JoTk1qUGY3dFRzYmZDVDlpdExjanU5RTBoVUFo?=
 =?utf-8?B?RHEyWWZWRGY2ZnVKTUJjNSs2aE9ZSjc1RExnUHMyNm1FdTJIRk1kYXBvV2ht?=
 =?utf-8?B?K3pHTWFLY2E5UWZLRDRCdzJSbnVxQmFVb3JQNEhwZTM4VVhpdmdlUTJNdjZh?=
 =?utf-8?B?SjdBUUZVV0puWU4yMmc3ejVmNWpXQ3U0ako0UTZuQ0l4TkVLN29ESE5DOUNW?=
 =?utf-8?B?bHpEUkZxb24rcDBWYWEzZnBZa05JMlNPNEl5K3d4ME5nZ1hDWFNwcDdmZVdv?=
 =?utf-8?B?ZEZaVFpLWWZKaVBFY21RTEZ5MDY1MG5yaTZvcy9GK1ExcFlha25adHkxallh?=
 =?utf-8?B?b0dHcGZQYXkvVHlqZDVwL2ZFdzNuTjZmTEoyZkxseWpPOElQSkVzSDNpdS9C?=
 =?utf-8?B?Q25PTzZsWTJHL2dkck9Oa2hhNnBDa3FxdnVxSU9RMUFaVmxJeFRXTkFXYjAr?=
 =?utf-8?B?ZGRBVVZ1RXJscDlKb0M5TFZIVFhyVytjcHdESzF1cml1b2ZwYUdZUGkyODJk?=
 =?utf-8?B?WlY0amNSRlR4eUNoQ0VNNFF5SU85akpvREYvUkZOejlXQ0FxRU14VE9xZHg0?=
 =?utf-8?B?N3EyNVRZZzVVVmV6WklCT3dLbUlkQmhKNFV4VDVYbTRQMVhUempaSVNOc04y?=
 =?utf-8?Q?JGO6FVUDsaJb/972qhVWOfSIy11ypASHUK+oVfX+U+Zt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f887e66-bd52-4e97-2695-08db3144b9fa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:32:25.3424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAx1ypWhCUasKE11roSLXbIdVpMekWS17f71kPqRisM1X6yoMydn1Xhsjsti+NCqihNzQLvXuA0xrqbbm9x+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 3/29/23 5:40 AM, Greg KH wrote:
> On Mon, Mar 27, 2023 at 09:18:16AM -0500, Carlos Bilbao wrote:
>> Kernel developers working on confidential computing operate under a set of
>> assumptions regarding the Linux kernel threat model that differ from the
>> traditional view. In order to effectively engage with the linux-coco
>> mailing list and contribute to ongoing kernel efforts, one must have a
>> thorough familiarity with these concepts. Add a concise,
>> architecture-agnostic introduction and threat model to provide a reference
>> for ongoing design discussions and to help developers gain a foundational
>> understanding of the subject.
> 
> Thanks for putting this together.  Some questions below:

Thanks for looking into this!

> 
>> +The basic CoCo layout includes the host, guest, the interfaces that
>> +communicate guest and host, a platform capable of supporting CoCo, and an
>> +intermediary between the guest virtual machine (VM) and the underlying
>> +platform that acts as security manager::
>> +
>> +    +-------------------+      +-----------------------+
>> +    | CoCo guest VM     |<---->|                       |
>> +    +-------------------+      |                       |
>> +      | Interfaces |           | CoCo security manager |
>> +    +-------------------+      |                       |
>> +    | Host VMM          |<---->|                       |
>> +    +-------------------+      |                       |
>> +                               |                       |
>> +    +--------------------+     |                       |
>> +    | CoCo platform      |<--->|                       |
>> +    +--------------------+     +-----------------------+
> 
> I do not understand, what are the "<--->" lines representing?  Function
> calls?  APIs?  something else?

The "<--->" lines in the diagram represent bidirectional communication
channels or interfaces between the CoCo security manager and the rest of
the components (guest, host, hardware). It's a graphical way to represent
data flow that I think will help some people.

> 
>> +The specific details of the CoCo intermediary vastly diverge between
>> +technologies, so much so that in some cases it will be HW and in others
>> +SW.
>> +
>> +Existing Linux kernel threat model
>> +==================================
>> +
>> +The components of the current Linux kernel threat model are::
>> +
>> +     +-----------------------+      +-------------------+
>> +     |                       |<---->| Userspace         |
>> +     |                       |      +-------------------+
>> +     |   External attack     |         | Interfaces |
>> +     |       vectors         |      +-------------------+
>> +     |                       |<---->| Linux Kernel      |
>> +     |                       |      +-------------------+
>> +     +-----------------------+      +-------------------+
>> +                                    | Bootloader/BIOS   |
>> +                                    +-------------------+
>> +                                    +-------------------+
>> +                                    | HW platform       |
>> +                                    +-------------------+
> 
> Again, what do the "<---->" lines mean?  there's no talking betwen the
> bootloader and the kernel?  What about the kernel talking to the HW
> without the BIOS (as is most of the time)?  What is "Interfaces"?

The "<---->" arrows here also represent the direction of data flow, in
this case between external attackers and userspace or kernel.

Yes, there is communication between the bootloader and the kernel during
the boot process, but this diagram does not represent it explicitly. 

The "Interfaces" box represents the various interfaces that allow
communication between kernel and userspace. This includes system calls,
kernel APIs, device drivers, etc.

> 
> And "external attack vectors" is odd, how can they get to the kernel
> without going through userspace?
> 

It is true that in most cases external attackers will try to exploit
vulnerabilities in userspace first, but it is possible for an attacker to
directly target the kernel, particularly if the host has physical access.
Examples of direct kernel attacks include the vulnerabilities
CVE-2019-19524, CVE-2022-0435 [1] and CVE-2020-24490 [2].

Anyway, the main point we aimed to convey is that the kernel is
vulnerable to external attack vectors, whether they are direct attacks or
rely on userspace privilege escalation. In either case, the security of the
kernel can be compromised and this must be considered in the threat model.

>> +The existing Linux kernel threat model typically assumes execution on a
>> +trusted HW platform with all of the firmware and bootloaders included on
>> +its TCB. The primary attacker resides in the userspace and all of the data
>> +coming from there is generally considered untrusted, unless userspace is
>> +privileged enough to perform trusted actions. In addition, external
>> +attackers are typically considered, including those with access to enabled
>> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
>> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
>> +of disks offline.
> 
> I can not parse that last sentance well, sorry.  What is in addition?
> What are you trying to say, some hardware the kernel trusts and some it
> doesn't?  Note there are different "levels" of trust for hardware as
> well (i.e. we attempt to accept any USB configuration header and treat
> that as untrusted but the USB data path we totally trust.)

Yes, this relates to my answer above; "In addition" is used to introduce
something beyond the primary attacker residing in userspace. This extra
stuff emerges in CoCo because the machine owner has access to
components like external networks, exposed hardware interfaces (such as USB
and Thunderbolt), and the disk itself. 

The paragraph does not explicitly state that the kernel trusts some
hardware and not others. But yes, that happens in CoCo. For example, AMD
has the AMD Secure Processor (ASP), which is part of the TCB of the AMD
Secure Encrypted Virtualization (SEV) tech. In addition, the kernel may
trust some hardware if certain configuration is enforced.

> 
>> +Confidential Computing threat model and security objectives
>> +===========================================================
>> +
>> +Confidential Cloud Computing adds a new type of attacker to the above list:
>> +an untrusted and potentially malicious host. This can be viewed as a more
>> +powerful type of external attacker, as it resides locally on the same
>> +physical machine, in contrast to a remote network attacker, and has control
>> +over the guest kernel communication with most of the HW::
>> +
>> +                                 +------------------------+
>> +                                 |    CoCo guest VM       |
>> +   +-----------------------+     |  +-------------------+ |
>> +   |                       |<--->|  | Userspace         | |
>> +   |                       |     |  +-------------------+ |
>> +   |   External attack     |     |     | Interfaces |     |
>> +   |       vectors         |     |  +-------------------+ |
>> +   |                       |<--->|  | Linux Kernel      | |
>> +   |                       |     |  +-------------------+ |
>> +   +-----------------------+     |  +-------------------+ |
>> +                                 |  | Bootloader/BIOS   | |
>> +   +-----------------------+     |  +-------------------+ |
>> +   |                       |<--->+------------------------+
>> +   |                       |          | Interfaces |
>> +   |                       |     +------------------------+
>> +   |     CoCo security     |<--->|   Host VMM             |
>> +   |      manager          |     +------------------------+
>> +   |                       |     +------------------------+
>> +   |                       |<--->|   CoCo platform        |
>> +   +-----------------------+     +------------------------+
> 
> Again, I don't undertand the layers or <---> here, sorry.

Ditto, data flow/interaction.

> 
>> +While the traditional hypervisor has unlimited access to guest data and
>> +can leverage this access to attack the guest, the CoCo systems mitigate
>> +such attacks by adding security features like guest data confidentiality
>> +and integrity protection. This threat model assumes that those features
>> +are available and intact.
>> +
>> +The **Linux kernel CoCo security objectives** can be summarized as follows:
>> +
>> +1. Preserve the confidentiality and integrity of CoCo guest private memory.
> 
> Confidentiality from/to what?  Itself?  Someone else?  Userspace?

Confidentiality from everyone that is not explicitly authorized by the
guest. Not itself; the guest can access its own contents.

> 
>> +2. Prevent privileged escalation from a host into a CoCo guest Linux kernel.
> 
> But a host has to have privileges in order to create/destroy/sleep the
> guest, right?

While it is true that the host system requires some level of privilege to
create, destroy, or pause the guest, part of the goal of preventing
privileged escalation is to ensure that these operations do not provide a
pathway for attackers to gain access to the guest's kernel. 

BTW, abusing KVM's ability to perform these operations to somehow gain
access to the guest would be another example of an attack vector that does
not go through userspace.

> 
>> +
>> +The above security objectives result in two primary **Linux kernel CoCo
>> +assets**:
>> +
>> +1. Guest kernel execution context.
>> +2. Guest kernel private memory.
>> +
>> +The host retains full control over the CoCo guest resources and can deny
>> +access to them at any time. Because of this, the host Denial of Service
>> +(DoS) attacks against CoCo guests are beyond the scope of this threat
>> +model.
> 
> So all resources provided by the host to the guest are trusted?  Or are
> not trusted?  Confused...

I think I should clarify here that by 'resources' we meant things like
CPU time, memory that the guest can consume, network bandwidth, etc. So
the notion of "trust" is not applicable here. In this case, we would talk
about availability, which is not a CoCo guarantee.

> 
>> +The **Linux CoCo attack surface** is any interface exposed from a CoCo
>> +guest Linux kernel towards an untrusted host that is not covered by the
>> +CoCo technology SW/HW protections.
> 
> "not covered by" is an odd way to say "we trust lots of things, but not
> all", right?  If not, I don't understand again.

We trust anything that the host is not able to manipulate (e.g., dedicated
CoCo HW) and the rest (e.g., bootloader config) we validate and/or protect
from.

> 
>> This includes any possible
>> +side-channels, as well as transient execution side channels. Examples of
>> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
>> +and DMA interfaces, access to PCI configuration space, VMM-specific
>> +hypercalls, access to shared memory pages, interrupts allowed to be
>> +injected to the guest kernel by the host, as well as CoCo technology
>> +specific hypercalls.
> 
> So all of those things are trusted?  Or are not trusted?  Again, I'm
> confused.  And who is trusting, or not trusting them?  The host?  The
> guest?

Same answer. It's worth noting that it's not that the guest does not
"trust" ACPI tables, it's that the guest does not trust the host that
provides them. Depending on the interface, different actions are taken,
and that's where the mitigation matrix comes into play. 

> 
>> Additionally, the host in a CoCo system typically
>> +controls the process of creating a CoCo guest: it has a method to load
>> +into a guest the firmware and bootloader images, the kernel image
>> +together with the kernel command line. All of this data should also be
>> +considered untrusted until its integrity and authenticity is established.
> 
> Who does the authentication?  The host?  The guest?  Through what
> channel?
> 

The authentication is carried out by the CoCo security manager, which is
the intermediary between the guest and the underlying platform, in
cooperation with some external third party. The security manager is in
charge of verifying the integrity and authenticity of all this (firmware,
bootloader, kernel, and other data loaded into the guest) before the
normal execution of the guest. The verification is usually based on digital
signatures or other forms of cryptographic authentication. The specific
details on how this will happen in the kernel are still an ongoing
discussion, AFAIK.

>> +The table below shows a threat matrix for the CoCo guest Linux kernel with
>> +the potential mitigation strategies. The matrix refers to CoCo-specific
>> +versions of the guest, host and platform.
>> +
>> +.. list-table:: CoCo Linux guest kernel threat matrix
>> +   :widths: auto
>> +   :align: center
>> +   :header-rows: 1
>> +
>> +   * - Threat name
>> +     - Threat description
>> +     - Mitigation strategy
>> +
>> +   * - Guest malicious configuration
>> +     - A malicious host modifies one of the following guest's
>> +       configuration:
>> +
>> +       1. Guest firmware or bootloader
>> +
>> +       2. Guest kernel or module binaries
>> +
>> +       3. Guest command line parameters
>> +
>> +       This allows the host to break the integrity of the code running
>> +       inside a CoCo guest and violate the CoCo security objectives.
> 
> So hosts are not allowed to change this?  I don't understand the use of
> "violate" here, sorry.

The host is capable of altering the configurations of these components.
Attestation can help identify these attacks.

> 
>> +     - The integrity of the guest's configuration passed via untrusted host
>> +       must be ensured by methods such as remote attestation and signing.
>> +       This should be largely transparent to the guest kernel and would
>> +       allow it to assume a trusted state at the time of boot.
> 
> How can it be transparent if the guest has to do this?  If the guest
> isn't doing it, who is?  Can configuration be changed while the guest is
> running?

See prior answer.

> 
>> +
>> +   * - CoCo guest data attacks
>> +     - A malicious host retains full control of the CoCo guest's data
>> +       in-transit between the guest and the host-managed physical or
>> +       virtual devices. This allows any attack against confidentiality,
>> +       integrity or freshness of such data.
>> +     - The CoCo guest is responsible for ensuring the confidentiality,
>> +       integrity and freshness of such data using well-established
>> +       security mechanisms. For example, for any guest external network
>> +       communications that are passed via the untrusted host, an end-to-end
>> +       secure session must be established between a guest and a trusted
>> +       remote endpoint using well-known protocols such as TLS.
>> +       This requirement also applies to protection of the guest's disk
>> +       image.
> 
> So you trust all I/O into the guest by virtue of it having to be
> encrypted/protected somehow at the data layer?  So the guest kernel
> doesn't have to worry about the data contents it is receiving any more
> than it does today?

Right, if there are proper secured control structures for the communication
channels, then the payload should be fine.

> 
> I'm stopping here, sorry...

Hopefully I was able to provide some clarity.

> 
> greg k-h
> 

Thanks,
Carlos

[1] https://www.appgate.com/blog/a-remote-stack-overflow-in-the-linux-kernel
[2] https://google.github.io/security-research/pocs/linux/bleedingtooth/writeup.html
