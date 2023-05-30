Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D69715456
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjE3EA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjE3EAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:00:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798B9F1;
        Mon, 29 May 2023 21:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABF3iGhe6SGZkoGBQvCyT/SPbON7V9kLmd1qNcl4i2Pboiaz0ECa67LFrybJXCOU53milay7wOqt5YmjBjwxcLIA+5SJFZqfJtvhl91uW1QPz+0RqT+L8r8oXLKWRkmcx+dlZN1dDJ8Uz0fB/XY0vdN1hLaCXVfjI5SuxlXu+BMC4cjGxMZ3DkNlW7dOQI7cp31Um2fUnMU3MajM07ptV/1tdzXqYkAfpCfL0QQrOBFVNOTo046igo2zUGioP3kZx4YaTlpn/4mztjjUN5zvXWpKkWhDHvULXgLTWFoXrPOnZoxiyVR8uDP4XonjKAv0s1vxyokHPyHKCHElFfDOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5HiBBQ00meKzAWRSJc6c86d+StCxH6L9z3k9f2hV9o=;
 b=Plr72bvFPUxaK6b8oZUXVZVgsMgLl6FtblDPGAFAJLk5dcNTwUzDzKyS88OQhqjcmkz9SBHDcc3DxBRfwE7mf2drlkDjC6ibg4rtxTWYBVdRgfzsSUy/JpJNUvCW0tE61mOvbFiMLxu/r9un6cjgHLBfzgLH9iXT1A0uAsJeGlSIhALU1Sywj0zo2bVdEkmvHnr2MlEmQfb5XD1jLrP2M6/qowH/eVQl4WmoXpYyA3vPRszLPktWNmPyM6WwFhc5en94FjXb/kWCuOtirSNcgKl/4v8dgNnSzAzL0nMuH0RjRNCPdpCfX7+GXbnB0/psOREluVS59h0FMFLqxd1Wsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5HiBBQ00meKzAWRSJc6c86d+StCxH6L9z3k9f2hV9o=;
 b=YCRoDmbmlokNG6XE4NUBTlY++zD/Fm+Nv5dwLzKYZDBw3Bd2bWustt3PpoPAvVTlFwbXtcOSLkLS9lNZJfcwlAlfUckZV5S00I4y+dJK40GRU+jmRiSVX3rbnJWQBlzmtWn89gUBYycYzvsxTQKXLpF09n5KIv49ieCN0qBzWXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Tue, 30 May
 2023 04:00:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 04:00:12 +0000
Message-ID: <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
Date:   Mon, 29 May 2023 23:00:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
To:     Nick Hastings <nicholaschastings@gmail.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 1036530@bugs.debian.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZG/8cxxTJ9ZzrVPQ@xps> <ZHCYRmD7YeIWoy2W@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps> <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com> <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com> <ZHQhPcKUF76Kplwm@xps>
 <ZHUt9xQKCwCflvVC@xps>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZHUt9xQKCwCflvVC@xps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS0PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:8:191::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa28f62-9b9f-4542-19fe-08db60c25ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHt7eGpvPziekSH1xR69Z74gIJd1TlA5q/dDk6N7CMxHh4qSOX7y4f7+QOaKvM8m+CCXzGEuTgfOfbZp1PYzXE//7veW3+RAzEa4KPuP6skey7ZPyPbxgXUlLW5higqJnJ8Kvtwn7ZV1yuAJGHKxo30J8ND53bH/ii8GKNVGt6Xwc/2yMyAhZAye74SAnlI/6xdoVenwYdai/5pC2rDViR8pZ06imNKIqgjRljIds+EiEzhcVIHCJCMy1c5CKusT/3AMwgXtYR2MVJoecGZvHSS3EmGKoRHlKuziA7i3lMr13u7plLFnaU8xwqprA9OA04niXf4AxrdGmBW0bMB+hDMJB6zcO9Y1xnLwv1ml+OAHGqNHAomL8mhOn/xLWO79SvFfhl7SlrVMw6+/MLYAnkDVd4LrZwiFX70fkR6FFTKmj6Xh57LO3pPRnPuweCE1xOTnQkVm6J10vC8ZMY9pdk9csp34pyDo8S+FIlrUPyBVYztlEb9POhcbmUMbPfbjJDapc5dqii8hdmUSS7YncIJ82rcHu9MJRNVIFWgHXpudNeJtwYZfg6bfGqv1Kr5/4TK/rnqMD+x/NEuNZngfsOw7oWGZSHUME5xlxk5EmkY2jEkM90zzLhNFcDpN7vTG+MyXhjsmMkjrnPipbVJfXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(41300700001)(2906002)(316002)(6666004)(6486002)(38100700002)(8936002)(8676002)(2616005)(86362001)(53546011)(31696002)(186003)(5660300002)(6512007)(44832011)(83380400001)(6506007)(966005)(36756003)(66556008)(66946007)(66476007)(478600001)(54906003)(31686004)(6916009)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDB0UWc3NDlJdHVWVkcvOTV4dm00aEYxcmpmMXNSYWtQcDhjblJablQyb3ll?=
 =?utf-8?B?STU0d2t6UHN4S3VGeGFBVHpHYlZwcGl2YldqVzMvR2tudG1sUC9xcnp2YXdL?=
 =?utf-8?B?Tnh0Ui9HUXFLdFFscEZ6T0E1TlFpaS9GR1NZdU5VdmpOcU5mK3BZS1JVQmdI?=
 =?utf-8?B?Y1pYUU0zQ2NFTWttRHgzc0RhNE1EeVZzanFpdUY5Qm1aNm1kclJDOHdrYU1z?=
 =?utf-8?B?T1FBaEs4b1VQUjlZVU9ON2xTNEJRYkFiRGpTc3paNlFYcEhFQm5GT2NONjhI?=
 =?utf-8?B?ZFRCdGcwQjU0d2JKS3FxUVJsYjFGYlhKSktuZ0NENzNhWlIvMzM3dFZRS20v?=
 =?utf-8?B?UHp2TFdQMmxvMDB1OEFxZFJPNUQrWHVTYnVrMTJMRWYvR1lOOFUzOHI5aFNi?=
 =?utf-8?B?WmZIZEhsellzNVVUY01tKzMvS0JWWDNIVzBpcXZVRGdMMHRnN0lVdnVoeEs0?=
 =?utf-8?B?UnhVRjkwSUxtSzJPbHVQNHRXUVVHUlNJc1p1ZTJ4KzhyQ2VqckI2Vmd6Qmp2?=
 =?utf-8?B?TFZkQ3ZEelhyNjRNbU5PRVlqZGNzbTJHaTc3eDZDTGExakVqNjhZcXNMNnpS?=
 =?utf-8?B?OFVTa1lPRVF4MTVBaWd2MDl3VzF6cGI0UU04RUx5R0E2MGNFU3h6a2R6K2tQ?=
 =?utf-8?B?dmhjdFZpNDZoWFlkalEvK016MGpHdkxiaFlKUml2Zzhjb3hHY1NoQVdGL2Jo?=
 =?utf-8?B?MUpiYXk5TU80akk3VEsrZ0hyVWVBcFpDblNlSmc5c3FvTzIwNEFPTFZsdjIy?=
 =?utf-8?B?QzFWcWw0T21ISG14ZE1XZG9rVnR2Q3ozWVc2ay96WUhZeFlHdGpyVUxMRzkv?=
 =?utf-8?B?L2I3bWNZbnRlbmdETGtkVCs2RTZSMThieDFwZldac01MbFBDaDJUZVM4c09K?=
 =?utf-8?B?VGNkanNUbUpmRjFxbzhvcUlYVXZEdm9TOGtJb2pmMXUvUEpaMnVSVW9BQVZo?=
 =?utf-8?B?aDFHYzk0djBGWFJaY3dZRlhHTW93a1phazk5eVdodmdSYVZjZGlRZUplZnZC?=
 =?utf-8?B?Y3ZiWlhWSlpHOFBUQnRsU2REZldpelpQMVBWZUJzL1lRSHY3WHpIWGNKa3Q0?=
 =?utf-8?B?N1U4dnFQSHkwcGZ2OW9uY2l6UVVZYVNiU1A0bnR4WmU4djNxRW5HU0xSRWFa?=
 =?utf-8?B?SG1nMTd5eG5uZ0grSVdQUjJHQzBvRXE0Ly9rQytYSHNBczI0QnJ5ZTd2MG5s?=
 =?utf-8?B?aVdpeDVNQnlzOTVockR3MmluNmlYRWpLZ0NGaERxWWYvU1FIbGpSZGthZHFn?=
 =?utf-8?B?cnRhM1RFQUx3ZER2OVo5cDZaa2g4VjFGZ1JOb1ZpRGlSY1pUbU1weWVWTjlr?=
 =?utf-8?B?cmtXdmtYM2NKQUE2ZHpLUUFhMHVScU1qYXYwbDk4TUplR0ZtbExRVW4rRnJq?=
 =?utf-8?B?TUZwRkFIUWJnZTY5NkxyN3hVY21NV1E3aTcyRzNjaWM4RENtK3cxOVptZXAy?=
 =?utf-8?B?YU9oYldQcE50Z2lyUWphMjBHTFJuQVkzTnJXVkNyenZUKzBMMEl0cVJYdmdD?=
 =?utf-8?B?S3VwbW10SjhBTHU0UUpuUWlYc2FEdnRkbTZqNW1uQkFneXZMdXdNNXQxeExT?=
 =?utf-8?B?MVB5dHJBcnpqbUFIK1NmdFpvV1paYkNTVW1lMVBzb1pNVmJPWjBiY1prNHZm?=
 =?utf-8?B?OGplK0JwZlJxTTA5bWlURXFrcy8xV0FXc0E2V0pOS0tiNUF0bjBrZXlOTGtE?=
 =?utf-8?B?UVNpR1E3N3RzeEwxYUZxcFltUEhiQkQxc3I3WFY0Ui9XaU0vditHVXUyQjMr?=
 =?utf-8?B?c2F0REh4YXU3MmJ3eGFBNjZDMWVDVDFWTEpSL0sveHV6ZmI5dmVJdWw4V2xl?=
 =?utf-8?B?R3pZalBnbmRuMmszN0JDYkMxciszeWN2bE8wd05GZ2JQeXJJQVNlRXd2RW1N?=
 =?utf-8?B?TXdSQm9LQmNoQ2h4YTNFQmpOWU5yL3FtbVpwUTdOUUpzczdYcjBnT2I3QzhO?=
 =?utf-8?B?bFcybTBOc29SWWZnS0tsYjloeU5KWEZ6Wnk3blJDMzlkTG1iSkRLUnJxT3I2?=
 =?utf-8?B?SHdMbmllQjgwWG85d1lRcmhsUW1VRy9va3Yvc3dsV1J4MkhCRmp1SjBaQ0E0?=
 =?utf-8?B?MWp6NFVOQlo4RzZBcTF4akpyUlRSejIrVXhGNGYrS1ltRXNWSzFWTEFyakxp?=
 =?utf-8?B?S25aK0c1eGdKNXdTRHVJV1lSTmsrdkl6c2RQNktBY1hkNTM5RUdHaThqY21s?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa28f62-9b9f-4542-19fe-08db60c25ddd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 04:00:11.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/OJxf18MZERzEH/Rd3fIZqA80LpK7D67YABaEBzuvDq6I9MByv4j33/hPoDOnqvCSV/Biwsnhp0b7DZWPpUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
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

On 5/29/23 18:01, Nick Hastings wrote:
> Hi,
> 
> * Nick Hastings <nicholaschastings@gmail.com> [230529 12:51]:
>> * Mario Limonciello <mario.limonciello@amd.com> [230529 10:14]:
>>> On 5/28/23 19:56, Nick Hastings wrote:
>>>> Hi,
>>>>
>>>> * Mario Limonciello <mario.limonciello@amd.com> [230528 21:44]:
>>>>> On 5/28/23 01:49, Salvatore Bonaccorso wrote:
>>>>>> Hi Mario
>>>>>>
>>>>>> Nick Hastings reported in Debian in https://bugs.debian.org/1036530
>>>>>> lockups from his system after updating from a 6.0 based version to
>>>>>> 6.1.y. >
>>>>>> #regzbot ^introduced 24867516f06d
>>>>>>
>>>>>> he bisected the issue and tracked it down to:
>>>>>>
>>>>>> On Sun, May 28, 2023 at 10:14:51AM +0900, Nick Hastings wrote:
>>>>>>> Control: tags -1 - moreinfo
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I repeated the git bisect, and the bad commit seems to be:
>>>>>>>
>>>>>>> (git)-[v6.1-rc1~206^2~4^5~3|bisect] % git bisect bad
>>>>>>> 24867516f06dabedef3be7eea0ef0846b91538bc is the first bad commit
>>>>>>> commit 24867516f06dabedef3be7eea0ef0846b91538bc
>>>>>>> Author: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>> Date:   Tue Aug 23 13:51:31 2022 -0500
>>>>>>>
>>>>>>>        ACPI: OSI: Remove Linux-Dell-Video _OSI string
>>>>>>>        This string was introduced because drivers for NVIDIA hardware
>>>>>>>        had bugs supporting RTD3 in the past.
>>>>>>>        Before proprietary NVIDIA driver started to support RTD3, Ubuntu had
>>>>>>>        had a mechanism for switching PRIME on and off, though it had required
>>>>>>>        to logout/login to make the library switch happen.
>>>>>>>        When the PRIME had been off, the mechanism had unloaded the NVIDIA
>>>>>>>        driver and put the device into D3cold, but the GPU had never come back
>>>>>>>        to D0 again which is why ODMs used the _OSI to expose an old _DSM
>>>>>>>        method to switch the power on/off.
>>>>>>>        That has been fixed by commit 5775b843a619 ("PCI: Restore config space
>>>>>>>        on runtime resume despite being unbound"). so vendors shouldn't be
>>>>>>>        using this string to modify ASL any more.
>>>>>>>        Reviewed-by: Lyude Paul <lyude@redhat.com>
>>>>>>>        Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>        Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>
>>>>>>>     drivers/acpi/osi.c | 9 ---------
>>>>>>>     1 file changed, 9 deletions(-)
>>>>>>>
>>>>>>> This machine is a Dell with an nvidia chip so it looks like this really
>>>>>>> could be the commit that that is causing the problems. The description
>>>>>>> of the commit also seems (to my untrained eye) to be consistent with the
>>>>>>> error reported on the console when the lockup occurs:
>>>>>>>
>>>>>>> [   58.729863] ACPI Error: Aborting method \_SB.PCI0.PGON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
>>>>>>> [   58.729904] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
>>>>>>> [   60.083261] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
>>>>>>>
>>>>>>> Hopefully this is enough information for experts to resolve this.
>>>>>>
>>>>>> Does this ring some bell for you? Do you need any further information
>>>>>> from Nick?
>>>>>>
>>>>>> Regards,
>>>>>> Salvatore
>>>>>
>>>>
>>>>> Have Nick try using "pcie_port_pm=off" and see if it helps the issue.
>>>>
>>>> I booted into a 6.1 kernel with this option. It has been running without
>>>> problems for 1.5 hours. Usually I would expect the lockup to have
>>>> occurred by now.
>>
>> I let this run for 3 hours without issue.
>>
>>>>> Does this happen in the latest 6.4 RC as well?
>>>>
>>>> I have compiled that kernel and will boot into it after running this one
>>>> with the pcie_port_pm=off for another hour or so.
>>
>> I'm now running 6.4.0-rc4 without seeing the problem after 1 hour.
> 
> I did eventually see a lockup of this kernel. On the console I saw:
> 
> [  151.035036] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
> 
> I did not see the other two lines that were present in earlier lock ups >
>> I did however see two unrelated problems that I include here for
>> completeness:
>> 1. iwlwifi module did not automatically load
>> 2. Xwayland used huge amount of CPU even though was not running any X
>> programs. Recompiling my wayland compositor without XWayland support
>> "fixed" this.
>>
>>>>> I think we need to see a full dmesg and acpidump to better
>>>>> characterize it.
>>>>
>>>> Please find attached. Let me know if there is anything else I can provide.
>>>>
>>>> Regards,
>>>>
>>>> Nick.
>>>
>>> I don't see nouveau loading, are you explicitly preventing it from
>>> loading?
>>
>> Yes nouveau is blacklisted.
>>
>>> Can I see the journal from a boot when it reproduced?
>>
>> Hmm not sure which n for "journalctl -b n" maps to which kernel (is that
>> what you are requesting?). The commit hash doesn't not seem to be
>> listed. I may have to boot into a bad kernel again.
> 
> Please find attached the output from a "journalctl --system -bN" for a
> kernel that has this issue.
> 
> Regards,
> 
> Nick.

In this log I see nouveau loaded, but I also don't see the failure 
occurring.

As you're actually loading nouveau, can you please try nouveau.runpm=0 
on the kernel command line?

If that helps the issue; I strongly suggest you cross reference the 
latest kernel to see if this bug still exists.
