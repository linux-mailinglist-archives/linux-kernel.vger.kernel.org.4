Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6465F06C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjAEPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjAEPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:48:11 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7243D4BD53;
        Thu,  5 Jan 2023 07:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz3IirHmOtNDI0NhiuZPWFR7DaX96NBIgdNXVpzvsbYUwcOYTncirO5u+mu/dhXgx7xztkjbTecwMDjNOVunSO/k1knf+RK1Mnu3iL8g2S1FMXDFm+Fj38ATUDISNFz8d3l0VhcB9g012mu+G2HF+gL8bDol/uKpRHFcbWl7ysXb27L7JiqO3Jyu3E0oyND3egN/lCp9RIr7QbRRqi118c1YK4n2oXVheunCvLeXXYifrH+G9eCr4djnwhLnQnaC6kXlVaUZMX9U3O1g+SDitUwI/hYz1lg/UAIlVPui2Tkawx73uIW1WkSy0VfMusBeRTpFSp/hCrFuSaDKsKCIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5r9lGxXP6BQrqXdxcrDMl5DpyF6cQ2TheS0mJeP5KE=;
 b=BVykO5ir6kECG+pNh6UmGvC+nNgu9y4hOcgc4tEOmT1zhpRxQlzMdsmJ6CK7+DE7F6YC/Pwh6UfJTKEnwIavQWDxGStJZrJ0VYWHDzWWERlK6LoRBkzvUI6OGAHTd4FRk4S/M6Ni0JNeFs+Sf0xA78fV6PqDGcEbJzXegtj5+zy3ylmpsOaSzZyTR+9FTZWkV8N5W5vMd8U+1SJl46vtVTWyK9WJeToLzFt4AaGLOykEtULvP8g2z+SsHTl2aQTKn07vf7MLgnzMZzDF0/gtmcNqy9WfGRZ0s8m0Dx1XFiBoJis9sgAcwZuNeYiMDXVXmvLYoPKo1+P/kSMGSwj7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5r9lGxXP6BQrqXdxcrDMl5DpyF6cQ2TheS0mJeP5KE=;
 b=5R+ArscMiwMHSX7/XwQvx+FZWcUwtaubqCjWa9WNRiY8iHk67vX7/Hjaw0vMTJB1LduRa2i03Iu5lg9Qp1xVvndYHcvyqefyBf6NecPI55HO2OvNryepoa0oCiZVu3xPI2UzywEz05AKR9Q/dJ8hKjBQwmyD4A2Zycg4l7qz1DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:48:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:48:07 +0000
Message-ID: <d6bab266-c87a-0fec-443a-f608714d7e0b@amd.com>
Date:   Thu, 5 Jan 2023 09:48:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for
 resctrl groups
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278361325.34228.16916982678071203069.stgit@bmoger-ubuntu>
 <IA1PR11MB609764AC3E09E0A1F8A8FF7E9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
 <58d53ab6-df0c-9e8c-052a-a8b60c9a8258@amd.com>
 <IA1PR11MB6097E141C8C207EA527B992D9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <IA1PR11MB6097E141C8C207EA527B992D9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:208:23d::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 2649f40a-f802-4fbc-726b-08daef343d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiV1lYhyJ+PqDlasaR1mhgQHEGTr26cGXE9WB0ZU60IAkqLJyJgehkAv0SmW454uuYeNywsE5vUB+1giW1eQSmR82UKfzxaQSLf1RsLCef7O+5aX+LtNLLTLld4kwipM1lchGK6VLUQx7bdgmii9Bj8KRfpf+k6dtcmPUlkKbdUFoAzdZJ8vqbbqcIrTePGRWIsuobGSvIOC5btqja5Kd5zzjq3Hph6BHesE8NHvwDpVukFsYXQwQ/RkJUz/hOwMbdRsMKGtpRwvFgTDeZWeCY64cjM38ah6FVawl3MkdGhATz6rADEdRlsaKQ/TPsnPQLJtcNGTwhAHg0Y/x7ZJzYfkVgH2renf2B6Jwh3fw0BoDGCcxc/3uf478Gu40HYpkok8JJUBt7jKdUb/9o5nVd3N3rt+ZYJ6yle963od+U7aVHdPS9fOKGSViJrcQL550lfk038k30CUzHfSGFKW/twAuoj/CWZydtzC1XIx09yWA3LozEhbDO2zHcPoNMv1U3WcycB6Ysa0IzbJBgpRlcKPaL+QEdVwQBF4FytMkvG0IgueXUHOpiRF2mEYLudYxx4Cnz+G9eiH0usJVOW5TJEGkfUnpgB7+65liuALpAE7ZoH8Wb+pcruJSxs2YW7B8Swod/ZZWiezu509OnGHtXE01aaMZp4LtxCId3VujPj1h5sdhsUFZnOWaFuC910mnbkZ9ub/43Lt7SARRWs33NnPwYxsb0Noc/HIS7Y8ckw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(36756003)(86362001)(31696002)(6506007)(38100700002)(53546011)(66946007)(66556008)(66476007)(6486002)(2616005)(6512007)(478600001)(186003)(110136005)(26005)(31686004)(54906003)(6666004)(316002)(4326008)(2906002)(3450700001)(8676002)(8936002)(83380400001)(41300700001)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWoxenFVM1dHdS9aUG1ITS9sQ3pDSHdmWm9DcSt6Ylhsd2FCbmVWcHd0Rjd1?=
 =?utf-8?B?M2lpc0ZtenpHbTJRVEJzOW16eDMwbEQvYlA2bmFtNFF3ZHN0WXArL1FqMGhG?=
 =?utf-8?B?UlQ1bksxazFSYjQ5cDZVZGVRamJaSWtuaEpBZnQyYUFKRGNuR3ZYWXZXTVg4?=
 =?utf-8?B?ZjJ4WSszcW5XSFozMCtiajhjcXdnbmt2SVNPVVVlMnNKRG0wWjNLT3l2MVJs?=
 =?utf-8?B?MnBJZVIyY3NqcTlHcUxheEo1NzVhQkVJOUE3KzZNTi82cEoxMFp1cG9ITVF1?=
 =?utf-8?B?cVI2U3Zzd3cyMlpJb2VkUVFDek5QclpvYm9WekxTQTM1SzM4YTRJNnVHYzJR?=
 =?utf-8?B?RFFYaHRxUjVXdWo3QkQ5K2h1THovUy9HeHArVDZLOG9UNUczNHllcHNncW40?=
 =?utf-8?B?QWF3SER3V0pqQ2M4T3ZISmpmbDI2QUZjS0swRmN6MkM0aDU4eCtqaXVFaloy?=
 =?utf-8?B?L1phbnlqbVY3RDg4ZEhjMlFBK294anRiMDhBd0N2YXpBOEZ6MVNDZ3NDV3Vt?=
 =?utf-8?B?Y0pDZ0RQWWp3OUVvTVhsb3R6ekdoc0tkYmh6ekd5bytVdjh0SHZjTHBKSjBY?=
 =?utf-8?B?UXpJcG1tU0hrUmxMQTNrNFR0ekg3cDNXS1lpeG9SdE12cGttVTQ3YjhiQXBW?=
 =?utf-8?B?S3Y3TFkwamoxUmJWdlkzT29KbmhIaXR1VGlzWUF1cFd6TlJpYmVNaE04eDhl?=
 =?utf-8?B?b08vWFc3S1ZuaGw0Ui9hRjR2elVsZHhIUWZzcGxWWE5qR1NvdTRaT2t0Wkxa?=
 =?utf-8?B?VkExRUJQNjhSTVVleHE0UmdrOTlUb20yc0N3L1RUeUZJeGZHai83bkR1U21K?=
 =?utf-8?B?NHRKNjh5R1N4UHk0NDN4aHFzRjZBN2E5WVRNQmNISjBUZm9Qc29mbEdYTHgv?=
 =?utf-8?B?b1JXbkRsQjlBVS9hR2Y3M3RsZ3VHOHlVSnFIbEFVVVhWY3BXSkJPOGxvMHFv?=
 =?utf-8?B?cGQzbE1qd29xNkoyY3VoQXh5cWd5aEpzQ1VabWNoQzNSc0hLVVFMK0ZUZkdj?=
 =?utf-8?B?UW1XcWVHK2JyVlI2Q3dyRVh0MVV3ZkdhM1J1L2ZSMEJLOWpsWWd2ZFV0Vkxy?=
 =?utf-8?B?L0p2S3BabUM3VDNzVzRUUTZaYnN5Tk0zYjRZaGUrVFVGZlJQTUVlbDhsU3Qv?=
 =?utf-8?B?TUhTc3cvQnZoRjhiYjVIVVFIdGlXbmVhOEhqM01tUzhxTzJ0d2gva3VQVTVx?=
 =?utf-8?B?ZzVBUnVPaGhqcGdjbjdaRkV6dnNYTGMvdEhZakx0bGxhTTZJKytwa0I1d1Zv?=
 =?utf-8?B?cnpTaXVFT2JTQlVkS3A0OWp2eWszSWFpTFJxQTJxd29UZ0ExWlIxcmpFdEpm?=
 =?utf-8?B?ZUxnajFlYmtpR3hFczc3eHQ4K2VER2Uzc2x6K3QxUSttdlEwYXJ1dUdSckF2?=
 =?utf-8?B?aDdXTXFGS0hUamxXQVg0cGwyUk5zWmFZSHNUNkRMVnhtdnNIRWkydWFUamIr?=
 =?utf-8?B?RzdacndiRTZJemdYUzBlYUNwK1QyczF4OUVaZkdaeGxKdkRtd0g2aG9UMFMv?=
 =?utf-8?B?SllPWlFSeDA1c1F2VFVUOCtXTnIzMmVwcXQ3SG96NEVYMUc1eDZ4M0M0c2x1?=
 =?utf-8?B?RG5MWFlYKzhjTHJmZFRibzZtUHZQcTBzTjc4UkZQMnk5SHFhbnZXbEgvT1p1?=
 =?utf-8?B?d1RndjhQd1ltcmgxSDAzVm1vMDNaejAwUWdHbmI4OXI3TktENGZkdmhzcllM?=
 =?utf-8?B?anZLQTdwTFg5T0Y1c3JRaUVtMXFXZ0lBcUx5blZxY00zZHRNNkpoZ0NOMmJR?=
 =?utf-8?B?UkZySngvZFlqaGFWM2lLbEUwWDhoUDlvOWlJZ241ejUzL3dDeWIrQ2sxZVhP?=
 =?utf-8?B?Nkt3ZHJlNGVoZGg4UkdVTVdBRzBGTGY2K1I3RWRXSkt0NUdnT3IvOVQySWMz?=
 =?utf-8?B?ckNPZ1kzMVZwVzdZME9nUTM1RFlpUEtCZlhjajlJeFVFQ2hKQnNCZVB4dDdS?=
 =?utf-8?B?UVh3UWJjTjRGV3A5cmVJMFh2aXJmTjhJMTJJeVZ1WTBHTzByTHhFM3ZoZXlN?=
 =?utf-8?B?QzVjTk1XZmVJWVMvc2VIaldCQVBvTzVWZko5THdoczVwMkRqSXNycnluUUpO?=
 =?utf-8?B?Q21GaWFwc0s4MHFKZGZrbWhvVk9aU1kwbnVZanlyd0ViUTVCWTU2MnFrOEQ1?=
 =?utf-8?Q?uji4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2649f40a-f802-4fbc-726b-08daef343d53
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:48:07.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwsx6HT+OipLWXaL8xJf+reFOE3mKZLSW3175HTA2yIF2MzPwDlhGtc4jo1cLVvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 1/4/23 17:54, Yu, Fenghua wrote:
> Hi, Babu,
>
>>>> When a user creates a control or monitor group, the CLOSID or RMID
>>>> are not visible to the user. These are architecturally defined entities.
>>>> There is no harm in displaying these in resctrl groups. Sometimes it
>>>> can help to debug the issues.
>>> Although "no harm" to show them, it's not useful for generic user
>>> either and may cause confusion sometimes. CLOSID and RMID are supposed
>>> to be invisible to generic users.
>>>
>>> Maybe introduce a new resctrl mount option called "debug" and show the
>>> files and maybe other future debug info only in debug mode?
>> Actually, test team feels very strongly about this. Whenever there is some issue,
>> first question is what is the rmid or closid are you running on? We normally don't
>> have an answer for that.
>>
>> In my opinion, adding debug mode just for these two fields seems way overkill.
> Yes, they are useful for "test team" (quoted from your statement) and developers.
> Not for end users.
>
> A debug mode is useful not just for these two files. I'm working on another resctrl
> project where much more complex hardware info needs to be dumped for debug purpose
> only. It's obvious not to show it in generic use. It's more obvious to just show the info file in
> debug mode in my case.
>
> I think these CLOSID and RMID files and future debug files belong to a new debug mode.
> It would be better to introduce the debug mode now rather than later so that it can be extended
> easily in the future.
>
> Maybe we can enable debug mode in a separate debug mode patch:
> 1. Add RFTYPE_DEBUG as a new file type. Files with this flag are for debug purpose and only be visible in\
>     debug mode.
> 2. Add RFTYPE_INVISIBLE as a new file type. Files with this flag will be invisible/not be added in resctrl fs.
> 3. Add mount parameter "debug" so that ctx->debug=true if mount -o debug is given.
> 4. If ctx->debug is true, in rdt_enable_ctx(), go through RFTYPE_DEBUG files in res_common_files[] and mark
>     fflags with RFTYPE_INVISIBLE.
> 5. In rdtgroup_add_file(), if (rft->fflags & RFTYPE_INVISIBLE) return. So the debug files will be visible only
>     in debug mode.
>
> With the debug mode patch in place, it's simple to extend to any debug files:
> In your case, update this patch by just adding RFTYPE_DEBUG in fflags. Then the debug mode will work
> for this patch automatically.
> In my case or any future debug files, we just simply add RFTYPE_DEBUG in fflags and the debug mode will
> work automatically.
>
> Does it make sense?

Yes. Sure. The debug mode needs to be resctrl mount option. I will take a
look at this further to see what can be done.

Thanks

Babu


