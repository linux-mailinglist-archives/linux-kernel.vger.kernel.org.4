Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AB63AD2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiK1QBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiK1QBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:01:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B83766F;
        Mon, 28 Nov 2022 08:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ujvlcpsd+UkCx/aJLuZmBzJ4YIaCfQFsawGplA2XHqwNj5xM3P+0cy63+EOc/33lv7stZorUNM2vy1jFyer8SdATh3TRtK0d806MYMTLkWVd+IYB0+Ms+LwxLQlltYQz+alilxdWUyhCT3ykUViyoQV8RpGoxlmXbjlwYyv8bgbmG20x27EV4riavyokVCp6tMJU9qdrANGSb8Skp7rPGdljJezPE5CN/TM/MXgjyh9oodBokyQ+WPp4DVDwa3IXCNxdUaEchChBJR2xsJAuRvsaLEIu9JVjyKDyMyrWYhS6FmU3wA4GTOJKjUmE5pT4vAI4CQy+2PrOVSCYw19s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDYfx3RxnaMfeRwo3mbEqiGlOLNhOrJk+2CvjvtbKiw=;
 b=U6YuII8Ir1a99h5SwzraAFHBZzSt0XpiR68994IMbyygAKudU8qdmYj1GYgLSlVmQLFt0R5HV3FiC4O/vT4EsvxdFAYXMCxF2JYB3aNAFs2Oh20RUsa4RURs44II3Sby+qfHipYBOnzTZXSJ4PzroIUGE1IddGLkLWsjGUjkFYO8qLPzzsGwxQ97oJEuT85YCgAUnGQkPqbk/S987QwWcf5mYUa8mL72GA61EFuiAlf3dgD8I2lzz43Qa5FctsipLyl+GXuSdItZKpIQY29nW1FwKG3gw19SjA6+mVWR3feyGiB6fv/uzxZeVPrLxrcqqRkziMI6dCE3ecRCpxNRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDYfx3RxnaMfeRwo3mbEqiGlOLNhOrJk+2CvjvtbKiw=;
 b=hdb0cMRdVWrnFAbKN8aP6BS4SSjjy50pNO0C8Px4xZbhaZzu886Z62vjECryuN5N5RAnQJYueyq4NINX3mPWBXH4EL3htgTc4yJxaV82Y66WRHRxCHVilzivRtYW11P9Dg0Kl4TrmyV/HA5M+lX8Y/W6KtxMNoGXK1sE9njLTes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 16:01:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%4]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 16:01:28 +0000
Message-ID: <5342b787-9f74-33e5-7edc-f65fa2afb893@amd.com>
Date:   Mon, 28 Nov 2022 10:01:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, Sandipan.Das@amd.com,
        akpm@linux-foundation.org, bagasdotme@gmail.com, bp@alien8.de,
        chang.seok.bae@intel.com, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, daniel.sneddon@linux.intel.com,
        dave.hansen@linux.intel.com, eranian@google.com,
        fenghua.yu@intel.com, hpa@zytor.com, james.morse@arm.com,
        jmattson@google.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
        peternewman@google.com, peterz@infradead.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        songmuchun@bytedance.com, tglx@linutronix.de, tony.luck@intel.com,
        x86@kernel.org
References: <f461c201-8ef2-d7c1-0fa0-35b10a89039a@intel.com>
Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Reply-To: babu.moger@amd.com
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f461c201-8ef2-d7c1-0fa0-35b10a89039a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:36e::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc178a5-485c-400f-981e-08dad159ce5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StxIqafJ3PLlUMg8zwOE8I4CZNhIh7ExWmyGYb26vFSe52jznXE6pamJ3/nPUAaFHJ3qrATO4BcOLcuvBb6c5+qaasApDHHBO75P2fn//OfoH2UM8Tk2PSDN/ASvKfJpc2QDp9Jev2kCIPwLuVn5SEHxJggrnFs4fzPd66+WdXqQTK0LD1fSIYZI+OIekOutQJ7bUmCB52C3aT4k3Ikc6LhQSmmw2jAYM8cu49SEu6WjobS7KBK+JwOh73CdLBeAVr8N4cbQN1VsfnaXvKQC8kcuSI1cVtG29cZ6MiXJyaoHf6QyOt1pP/kpzPmuExpVhiWtjUK67HYOlmiQJji+LCFxljEWBLgMGPtpdmsJ02EiP/PcmeRXeVU20x8NaugAUHHqkt0RAUBK2uTggIpvG6TjCzP9KCvlik6zPGj7H2nTrQDYGldwLjC2j0PpPRPfCWt+zO2OtLa5CbJ0Md0Zk6VeFxSppiBBhflexGomSfcn9Zr1Al1VxzGAi7boy2X+NBsxbHd6VMO7fWtzZbyA+l/kHZDn8+YWTdUTPBhDAqcK6EaUlpov0fbBjZ/knt2xNkjLGbBtqpQ7K+PEMr21MUHwJhR4PYUGZN1QTw36TL1oZXEtuXZSJmhFvH73ukjx/TCmRNvdm3EXMGGcblQT6rVMLvrwhcdum3hcxjZ8EV44WhmfV4wJnpvejsz12FHekrigcj+7yYHhImgGW4k8m7z8ENa+2r23NpmhxGAscJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(3450700001)(478600001)(38100700002)(6512007)(6506007)(6666004)(41300700001)(66946007)(66476007)(66556008)(8676002)(86362001)(31696002)(4326008)(7416002)(316002)(6916009)(5660300002)(8936002)(558084003)(186003)(2616005)(31686004)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T201d21GUGdXNGc2bkp1Q2dsY1AvS1krWGxDbHhjTnE2cGhGV3BndHJtM01z?=
 =?utf-8?B?Sk10b29ZQ2U5MzArVFBrSmdPSkdnU3FZeTNjVnJtWkNqVFBKZlo5bERkRVpQ?=
 =?utf-8?B?bFc5QTN0UkRDZi8wcGFwY1RkazNOeGJ6YzNvVE1PaUdTN21nRy9mUFdtREsz?=
 =?utf-8?B?d2piTG9mMFFMM0FHZnZFTGNsRUtEVDhsWGlUUGVJU0ZBQllQWlFVekxYSzFr?=
 =?utf-8?B?M2pack9SMVZickU1dy96VVNLTDBQUGlRVUJBSTN5aVBIV0FtaUtHV1lJcXNK?=
 =?utf-8?B?MDF6RzZwRnp2aEJyWW1QTjFLSGhjOVZGOHBXTUV4S2U0VUVTQ29VbytxSXAz?=
 =?utf-8?B?cXppeWtFSGRWd25WckI4aHdBbTRKNngxTXk1L1J6NHBmWXlLdHhaRGNkQ1hK?=
 =?utf-8?B?UTR3Zm9NTElINHAzYUFYbHZ0YVlxd2w4VUhjU2h5dXZnRWlKV0hoSm93ek5P?=
 =?utf-8?B?SGlzMGRpL095K0QwM2J6dDNyQTNUY1B2d3pxNEszcVZWV05CaGp5ajdqNHVM?=
 =?utf-8?B?Y2ZkQXlRNFZjYmYyRnNqbmJGbDdhRDJLS1RrUUY1aUJVRmo1djRrcG1aZEdv?=
 =?utf-8?B?VlAzVFJFUFRGSktycUoyeVRPNTRhdnhnL0NGMXFONlM1U2JtQnFEWTZCMGFV?=
 =?utf-8?B?YWd5YldiRzY2bHY0dW5JdUZuZE9MM05hR0ZpbEZxTTJMRTIya1gyZnoyV0hh?=
 =?utf-8?B?UGVyQXNWdkVmZFZqRU4vbHR3eTNVWFJBTXEzMTltMXRrRjZ5eXhoTlpocVpx?=
 =?utf-8?B?YTByVjdnd1djV3dwZUphTFIveit3SStLbTlYcHBmNjlUdUw0eFFrNDNSbmgv?=
 =?utf-8?B?VTFXblJyOVdHUVlnOGVEL3FvS0ViZmtvdEZsZE5XRUZlalN6aGZOK2lYclZw?=
 =?utf-8?B?SzR3dHo0aGhuenp3OXE3T0IveU9MWFhYQnNUY0ptY2xNWWVyTFBCSlpEUWpR?=
 =?utf-8?B?WkRGdUM1VmdtVnZsVEZRYjVFbkorbGpWWmRvbitIUFVyaDNXMGZyU2Y3YmN3?=
 =?utf-8?B?WTV0bnlBTnp6dWsrRzJwMEJhUWNXbVV6TTJWQk1Vb2Vqc3JuQkRtNXl3d0pn?=
 =?utf-8?B?RlhORXk4a2FUbS9sdDQxU2hBMG02Q3VjazhyeUE2QVFQYVhqY0Vra1pySXBL?=
 =?utf-8?B?ZmdKRWE3UVdSaCsxS2V5SzBOanh2QjFTQ1Fvb3V4MUVraWpMcU15OGdYdCtE?=
 =?utf-8?B?RDRwb00xTkZ1WUNaNmpYdnB6dDFzVjBQYU1iSTlrMVlmcjk4bktidDY4eUtp?=
 =?utf-8?B?Q1kyZTR0UkgxUTZOZkd6bzBrTEgyNS9jNFI1ZFhuWWdjNEhqS0xYQ2UvVVQ0?=
 =?utf-8?B?VU9wTFFmejZlbG85MWdWYzRtZTduOTExZFp4Qm1SZ2ZjcUlGTWVReEFFWWRB?=
 =?utf-8?B?QzZJa1N1NDRaYzU3N1VtY3ZxNTVkS1c1QUpScld6eVVJRUYxeVl1dnF0eXpp?=
 =?utf-8?B?blpxR25HQ3h6KzZwT1c1S0FaanQyUUowdXR2N1dDOGNKbHVrdzlCb3BMZWhh?=
 =?utf-8?B?SlQ3UWxtaGh2b0xjZXRQSXZMUGYyOUttZXdnWStaRWEwZk5lTTBKd3dEd1pL?=
 =?utf-8?B?RnZUeVkwV1BaZnpZbXdBbml3T2tZQzZ6cXlSWTIxVnoxQzQvUEJEVVVOalJs?=
 =?utf-8?B?NWdOcnpNeWJ1RkdNSmtROWpFYit6ZGJNcGtYK21rbXRiZ1dwbVcvM3pLSjV1?=
 =?utf-8?B?cE9qclRJbnI4azA5b0RvWVc0YnhTZHphYUdsQWM4dWhPYnNXMndIcS92cnho?=
 =?utf-8?B?bGIzdmNSemczSnhaYmdwY04xY05DTWFobVE2bjVCVnI1aVplNG5sMXZmK2sy?=
 =?utf-8?B?c1hXVE51NlRSTFZYWDF5aFJxSHFWRWU1UUVjYjhnMEJzTExZQ2R1bjIvQ3Z6?=
 =?utf-8?B?ZDlVcGlHL2w2bmhaVmhMajFBTTU0bXFUTU1OaFhncld3MTlFbStYWmJvM1lh?=
 =?utf-8?B?Rm9hSmdGNDdxNmhLdnpJR0VxRWhKdFNtZm54QWtKMklPdUlHVFMzMmdTcnVq?=
 =?utf-8?B?eVF0SEg1U1ZxMm9hdDhHK3dHcjEzeUZJK1ZSa1J3Y2pRS2Zpbm0wNDF1b1V1?=
 =?utf-8?B?SlI0L09ESUxjTkhsNktId2xKWStxb0JTR2R1M09CTUR4Mml5NlRHWkhFeVZD?=
 =?utf-8?Q?cjzk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc178a5-485c-400f-981e-08dad159ce5c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 16:01:28.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4ZpNkRTmo180Cw7db2/c56fU+OzMHORW2FN/7vmmzoD6WJH6e7Iyc96MSTjcKLG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This thread did not land in my mailbox. Replying with git send mail link.

Ok. Sure. I am fine with these changes. Thanks

-- 
Thanks
Babu Moger

