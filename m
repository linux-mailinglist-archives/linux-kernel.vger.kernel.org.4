Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C875E81E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiIWSls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiIWSlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:41:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621E11E0EF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmTmRU6Oq+pjAv0PUP/N1iZ+0fEUjmDzCCgNf0yU5g+S6RAQAGgqS9/lnGdRd6ftBoNDeK7H8x3NxeNeAd3chFut+IJ6pUC/V3KvNefyMgouFnXSYFSzBXZUfuKK0WnxPxWplqU/pSuTeP2iwt2xcZQd9bYTWniPUrg8M/YVdKXZH17fUyObemGB8Qe3b4Em1aaWhFPC4cq65IAyrIX5Y6K9OgYyparPsrbInG1T5V/k374Cz8B/PGmgUlsvVfHN1KWH8TQDlods/z+pYjrh/z8KmbeZYtGqMfbKrxSP8X9Qcmj7b/ZsXgNQ+iUICu7jqVa5ZPwrGNny3DkuBXWp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFwVOL9inWJJb9Enqc4UN+Hg0as0EqraWcepjWcLdAw=;
 b=bhy8X/H43JzddkhwWHdO91EIg/JqfQHP9sREhQC+CvRkKvS42f8stAE8fLPoRxeLIk9LKmYnv5csm+krv4LgZg56SRO3cixd/ZQEEZXUXMvEtB4huFQpVHJEcxfkCv17dP5jqM0xid3Y23Y4JYnPcATjGnm8dqIOo+b8WJfom9KvRFlhJrd9xO56EdHf/FSX0sFxkBEMhIR438sakQ168jDWOg67zEQffkq90CNuUQyLMyU7VKtCDkuU/dDdZV7nATbbhWoiN3KNBtxBwo3EDe2zNfWTQbArgDFNI5cWGhCKzdpMvTuioVPWf9Vnv1WCpFPjKuwPAAUUNrKNFOcnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFwVOL9inWJJb9Enqc4UN+Hg0as0EqraWcepjWcLdAw=;
 b=EbeWpa5hEYnQWnamvMqmmKA2jdB1c0w9iX6alNs8GgYu1B45KF+na6uDY9o5uzRyTJsTgphW5fJwsugMaPqEdkvZy4HSDsIMiDu8+851CEbLdZGFKuNWZE0URhPobzcuxHC+0Sfy0+x1FpGRiMg4gownUZvID33RkJy1Pu68Q6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 18:41:41 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 18:41:40 +0000
Message-ID: <f4818fc3-7015-29ed-95c5-ab6a18da33d7@amd.com>
Date:   Fri, 23 Sep 2022 14:41:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [REGRESSION] Graphical issues on Lenovo Yoga 7 14ARB7 laptop
 since v6.0-rc1 (bisected)
Content-Language: en-US
To:     August Wikerfors <git@augustwikerfors.se>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        regressions@lists.linux.dev
References: <c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se>
 <eee82fb8-0fc5-98cb-e630-f86891574f21@leemhuis.info>
 <CADnq5_PRP3ekHPLhdXALxt9GL3aHHZQUw5TNAwm4t+ggimUq7g@mail.gmail.com>
 <33cf5071-3157-a3c2-3252-3a8ab926c60d@augustwikerfors.se>
From:   Leo Li <sunpeng.li@amd.com>
In-Reply-To: <33cf5071-3157-a3c2-3252-3a8ab926c60d@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:610:58::32) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|BY5PR12MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9066d7-62f4-44a8-34a0-08da9d9340ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FoAsusvof2zFN1FtSmuIHJ2MGF3umh5/9omQcFNPMvY9l9L4bjEEpzvY7zV5LiPPMjHgU+3fEiHLJBGatLoB/Yov+eH8pidRPhDaVKcvuzVGbRfUCSjH18GHi3rfZIJTDivsnLsHBORKMXgDzv51vAm/Km+zpxZf2M6cQISMIc3HxlXKX7dj5jndy2kVrLmaXxVOa6fzqRdPVzii0OrdGD8LFlopkEsKETn7W5FUNsZNzarifLvtS9fHIp2EaUNbQkQWeWEJSMXzQkWJhXHXscjYQ57V+wUyCEllj20kJ7QshmTmFW7hal6m6P/NHfO31Zy2772owAktNkM91fa7M/lj1qfOpBvehQI1kv8pFSqaWE4ljOmavFMDftbFH+oXYgx5XwUCEGyGqXtCtVT0Gj+JkPUC+cDm9JsWRfBMUPxF3H64U8zsDtLHPosrgQXq3Icj0aqN+Aw0i7rZy2f1JKNijDa4stkMviLV/O6NoKTlwsRO+Flt+OBC9lKyKTmHedR34OgxxpCHqH6yny8LRrguldfPpykckYZ2rv92GVRTqRdwlxkG5+Gt/Rs21KSxSDt9VHqgI8SffVhO119B2WXnuiNPxvNyvvUzJRcVYX8+HCmLblVmVwoD4XndB+DiOya73ztpilor2wa3QaZ/vym+GBzHX/rlCKG1lKCSE16yji0gM/+8r3WZcpnr1yCMqkxq1EiloLfm/PUf+DLdw+/PJn6iw14yhggWJT19se/rlvt2LVJifnGpiwijsCD30Bi2j7gh+WovRCfwhH92XBklE6/3M1liQA3B5v/Y2PuL9v6T4JpeTEMK5vUiq73
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(316002)(31686004)(86362001)(31696002)(36756003)(5660300002)(66556008)(8936002)(4326008)(2906002)(66476007)(38100700002)(66946007)(8676002)(966005)(41300700001)(54906003)(6666004)(110136005)(53546011)(2616005)(186003)(6506007)(83380400001)(6512007)(26005)(478600001)(45080400002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRodTd2TGRzRXkvV01jWkg1dVB5Uzk5VnZ1L1lmb0o2S21EUXM1SmZqRnMv?=
 =?utf-8?B?ekZMdy9sbTRtVmVOTml6MmtTN3A0Njc1dmtIT2dQT3ZsZmhpaE10bUJDTlhI?=
 =?utf-8?B?dTdjYzlaay83N0Q4ME5paUtEaSs0YnNwK3lGdFhrMnA5blR6M21QaTRkb0xQ?=
 =?utf-8?B?M3BkOEdNcFpaWEFmOVh2NEtqTEtWYWxENUdsZGhyaEVZcWVGbUJVc1pFTU9v?=
 =?utf-8?B?ZWJ4NWtJOGtKQ0t2UU9tWUdteEtqMy9nc202S0dMTUpOQnB1TmtKK0pzdmsz?=
 =?utf-8?B?Qkk2RGFpOGZWZXpQVnpWMSt4THFrWW92UWkzcDN3SllIdHZhTHJtS1RGREhN?=
 =?utf-8?B?TXlYMHQ1V3hYNlp3QUdEcFh2YWlOeXZKbUpxekE1b0RpWnFodlQrQ1RpbEsz?=
 =?utf-8?B?RWZtdnBqamRHbVhRQStjeGt0MU40VEhYNDdmVEJOWktJU29pT3BnZ0RkMnBo?=
 =?utf-8?B?OXQxcldrUVd5MkJBWEZNUjZwVmVlc0ZkdCtiRDhlY2Jmb3RwMHVIUHZFL2JX?=
 =?utf-8?B?TkwwL1VIMjFWWmhqV2dSY2l4bG1CRmFURmdjdkZZKzBMUUw4NmR5NndiZjRV?=
 =?utf-8?B?dnNzeC9raTdqb1NhSXltVGlmbWdCNjE5OXlVN2E4bzVmTGpwMlhoV1NTVGk5?=
 =?utf-8?B?UzdZUmtrUUhhUXgyL08vazdCa3lSbGdRd0d6Sm0ra0xCQldqdFZjNUpjSmkz?=
 =?utf-8?B?SVhqSVl5Nmt1TDVTYjU5d0piQnBYRjgxcjJKMVYyT0p0Mm41clVyZDhaSlhG?=
 =?utf-8?B?Nmx6MjJiVXBIMHRGV0RrNWVGMUdmdGhsUWhVbVFXdEJ4d0Z4UG96OVN3WGdh?=
 =?utf-8?B?MVdJZ3kzVjA3M1ZzV2QzaVErZFdYN0RWK2JMSW9taWZUY292OEJkUlUxYkFL?=
 =?utf-8?B?UGpXanNmVzdOcXZkU1UzQ0E2bHBUUUVENFdaT1pHWktHWi90R3lDQmxvYmps?=
 =?utf-8?B?MmEyWS8yaHZYcVFPdGRDWXZmbkJTb3VuUUx6dUZkL2oxVmFnV1o2MnBHaHJT?=
 =?utf-8?B?T2ZxOXVXdWJrZmlRWWEwbm1MZUVaZmRId3VMTkhiN3NxVGlqSWRWNitkKzFp?=
 =?utf-8?B?RGpWQmdMUGZ2eXp0U0plWVV2YzFHVVZtN05CdmxOSXRCK2c3ZmphVlFPQVdo?=
 =?utf-8?B?VldScnJXa0lUZXZCZkdnSDNELzFabVdsRlBBUjI2OXB1eU9ESXhUMHFPdDI3?=
 =?utf-8?B?V0l4bkFBVG9xNTg0OEN2UzdlZDhhK0YrSlBuejZQM21vQUtMckxWZXo5ZnZ3?=
 =?utf-8?B?eGtiZkswU0JLaHF1MHp0MGd4UzNRUHZJclVBdGY1TGlqZlNCMlZuUzBtWllH?=
 =?utf-8?B?VVo5RXRrSHUvSjVPRTdrZ0VYakNOcElRWkk4L0ZIUXQySS9BcVM0MXV4UlpS?=
 =?utf-8?B?TFd6MjAzeS8vcExMb3I1RVJRcWVKNnlnTS9ieE12bnZReERRdUYzYVNTR3F2?=
 =?utf-8?B?clcreUVoRlZFcVFmdU1JRWpON2kwTmtIRlJiRHdPZ1VpRGhRdHpDZ2FMeXRh?=
 =?utf-8?B?Mkpwa2RZWWVFRTN1dFVRK1hSRzZ6T0VpWjQ5WnJEL2c3N2tOd2xscHE1blVq?=
 =?utf-8?B?U3E1czdHMThhYkhNdEpzKzRHUGZMNnoyQnVSL2RDK3dxZXhCS3NYZ216VnNO?=
 =?utf-8?B?SnhmY0laK2xNL2t2U0NEcmdKWWpkclZ1UWlsNDBHdkhPM0RzNWdRaXVpd2l4?=
 =?utf-8?B?MkVySndibUVscEUycDVRM1hudlNDeSswL2kraWZBT2hFSkNjRnlmSGMwYmg5?=
 =?utf-8?B?emFjbUFReG5OTmpwTDJzdy9nLzRsMkwvNUk2QUF4Q1lmS3ZGQVYvb0c1dlVG?=
 =?utf-8?B?V1B6MUFZOWZmTTNoSysvRTVTbktEa2wvOERvU3A1eE1HcGQ3VW0yaTlWVGJO?=
 =?utf-8?B?VTg5QmZTVXpqWU1PM1FJSEhBMSsyWmd3UmdPeVpUdGwxNlkyaEYrbnlXV0wr?=
 =?utf-8?B?WmhablBSeW56VlBMTlF1NFg4MGlvRktLYUlYbHQ0L002bWxrQS9ZbXFzWFhJ?=
 =?utf-8?B?SnN3SnlOR1gvN2tIM2h1RDczZGFBZ25DbDVOaXZ4V1ViNWhGNWJWRnBEQmUz?=
 =?utf-8?B?ZzY4Vm9sNWkwS3R0cFJZSFRnM1JhUGh5Z3lyVmtOS3BUbjNmWVY4aXFTZ0Nv?=
 =?utf-8?Q?C2NA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9066d7-62f4-44a8-34a0-08da9d9340ce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 18:41:40.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTzC5uMW3EKtDOoX5V6Frc0/08Tlg89ji1KypJG5xg6hNlQWUfC24CFQsrO4MKt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi August,

Can you provide a dmesg log with drm.debug=0x16 enabled in kernel cmdline?

I wasn't aware that there are currently psr su edp panel + rembrandt apu 
systems out in the wild. In any case, psrsu + rmb should be working, and 
there might something specific to your configuration that's hitting a 
corner case. The dmesg will shed some light.

Thanks
Leo

On 2022-09-22 14:13, August Wikerfors wrote:
> Hi Alex,
> 
> On 2022-09-22 15:59, Alex Deucher wrote:
>> On Thu, Sep 22, 2022 at 8:54 AM Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>>
>>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>>> to make this easily accessible to everyone.
>>>
>>> @amdgpu developers, what up here? August afaics didn't even get a single
>>> reply for his report that even identifies the change that's causing the
>>> problem. We're already late in the development cycle, so it would be
>>> good if someone could take a closer look into this before it's too late
>>> for 6.0.
>>
>> Been a busy week.  Haven't had a chance to look into this yet.  Does
>> the issue still happen with this patch:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D66f99628eb24409cb8feb5061f78283c8b65f820&amp;data=05%7C01%7Csunpeng.li%40amd.com%7Cb3457b7e83df4b2c7d4308da9cc63280%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637994672320000021%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=a0EMjX6L13FaQU0mqxp5vO9vRe0BEDBDJ5emOdCj8gY%3D&amp;reserved=0
> Yes, the issue still happens with that patch, and also with the current 
> git master (dc164f4fb00a0abebdfff132f8bc7291a28f5401).
> 
> Regards,
> August Wikerfors
