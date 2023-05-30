Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E4716F75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjE3VOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjE3VOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:14:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B61C0;
        Tue, 30 May 2023 14:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kX3oYEn1eJZW+MdPVb/T4I9QBTeQl9DLbkUEaWkzM0EFqcwYaanjKTRv/e7z+I9GvZs66wTYEHIS66AJnvO7+O+4E4+CeSobikUCqRtQOKMYfonLdb3IO1EEokGRsWchAt/Z0x1yB0/+8hqSIK+I63CjTS3qyetf2h7wRnyOLrrLpdE70WBi/EMZHCKO5TciHWlAmi3HZgRn5cFUYkibo16juUWHuSOKMzO3rQnx/khUxXqkkntFdatFyCu9wz7e+lINEQvZg4jgt0v1dGL8vckFYE2ptzN758yobpkLV4ijqQqIaplE52fqXz68QDhV5D8wC7tjCcWS0jYZe19Hxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6toczsQlbG1rkzV+nTlLC50bGtvscaDHUpYbpwR1Xo=;
 b=Pxhf1O1qXodg7ZnVUHOBMdvfQOMzKF82odyf1kuFpO7tLm6SkTXsXv9sGMyNTOgbwGcJGPUZltdFcx0MhYAvESNN6WVhm1pOkI+GBhLDDubfKDzIETR44Ti6bDwRJIhaVUdGOFUPaJBbtvCZAIU4VcIEQyRwWXalsShNQYAC3nhJE9v+GaVLvxEu++nNnjfP4sJRo2XwDecDdZeYq41pYBvxzDnrCSISqf77B2dyKT54pp+oUBH+fe0cLR6uin+75WkqnoOv1XzjV+TR2shvUzSVNNxJs0n40Izp95VMmJ7eLm6h1ac4DmtRF/hx3STnMtWL+COFRswreIP9Li2hUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6toczsQlbG1rkzV+nTlLC50bGtvscaDHUpYbpwR1Xo=;
 b=DkNPdIVhYf4Z1dMzjAsH0Ry4f3yr4FJVeuuu1KGU0IQFmpJsrghc0TKFyjB942+h5t78vwRdMCpWr4ZnMaUt6zgUTWGzoerYfaO2XTTElHzdtUVeBdHwyOUwI0q7lc9zk9pnEP8PcR1vu0zEcjeJJfwumIVqGIjji+JX3ihherg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 21:13:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 21:13:56 +0000
Message-ID: <b6323987-059e-5396-20b9-8b6a1687e289@amd.com>
Date:   Tue, 30 May 2023 16:13:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [patch] x86/smpboot: Disable parallel bootup if cc_vendor != NONE
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name> <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name> <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx> <87cz2ija1e.ffs@tglx>
 <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name> <87wn0pizbl.ffs@tglx>
 <ZHYqwsCURnrFdsVm@google.com> <87leh5iom8.ffs@tglx>
 <8751e955-e975-c6d4-630c-02912b9ef9da@amd.com> <871qiximen.ffs@tglx>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <871qiximen.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0113.namprd11.prod.outlook.com
 (2603:10b6:806:d1::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 799bb5bd-33ed-44cc-5d21-08db6152c763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFLVxiKAD+s2TQVrxVh9W+xT774o3ABmAbcW+zkmJGjfU+e5LN4TpekvRUcMa1ONp1+yaXgL2t0McaDks8/j+sklNTSApoAMByaEw38LIV6zPNFYHgJSQ723+BnqFYZAY97ExLxLla4Ws5/dRRVoZmlRD+RHZLiDhwuBGbX0QXTldrFmSeOORWaIUbvZdHtL4LLavHUId7Kng6wiD5xddXSIvMuL7xinPPzAO+N0bmK+whgAlLMlOtGoJ+/8Txr/JOA1ggafEIR5ydpOV+L+z3OieMyaSCJqICfpd7wHcGnAtyuODHzupqc2NKxQiLwbIykPRCu/79p6gsLD3vBFp2QC5M+I4Iw61Jj0Dl4Bax+wM5w/ZdLywb2jxyXvaMWZYlWAVxv08h58SA67l9lYKUYVUHtZFJoxcEnI/IiDOAu7atv1Myp6eaCBYMzkzQRWkb33A9XtphOZ7AMhgE6FGY/3YlUWkmr668P6HlPwz2cY06BpT/uvwG8SiwcfmRC+i+Np4XfTt8mWEdy5fgpXHvFIYGPiHtc78n7OXfyQNktr43qJKVKgoXNkof2fApAeqZGRK6wQiSzp6VPcLeCvAJxoi7OUvNuyHHvQQHtcDxW2ucWqS0r/+R409uv1SP+xocYiarPfseswetlVoERu7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(2906002)(4744005)(186003)(53546011)(31686004)(6512007)(6506007)(26005)(5660300002)(8936002)(54906003)(8676002)(110136005)(38100700002)(2616005)(6486002)(478600001)(31696002)(86362001)(41300700001)(316002)(4326008)(6666004)(36756003)(7406005)(7416002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE4zdjdIVDFoMFpWU0NiTW9Zb1Rob2ZwUEpoR2NHaVdDd0x5MmxsWi9RejdN?=
 =?utf-8?B?dDBydjg2SmlaNUNJTUxrVDBlV28zZldsN2gzaDNYYjUwN2JsdEJ1OEZsSGFE?=
 =?utf-8?B?SGZNenp1a29rMXBPZk1DTzhLNVBhZzBOcUJaZVpObmlhNE11RHlWbHEyeFdQ?=
 =?utf-8?B?S04yZWJNeTJTazdRR0NISW5GTjQrWXRRQW1yYWVpQTFqK1hTbHJxVHpjcTRS?=
 =?utf-8?B?cUVCMlQwcThabyt5cWk0NTB2YlNuY3JLcHY0TGJhTFA5TUVqRkZXRVJXVjR2?=
 =?utf-8?B?c3N0eHFqYTBOL0lYVE9xMnFvUlRBOC92Sm91VGs0b2ZGWCtOVVpzQ2k4NUdr?=
 =?utf-8?B?WDBka2hqYUlEUVVpN09QMFdia3ZLc2F4VDQ3a2pHUkM4Zk9OZ3JUOExteFFa?=
 =?utf-8?B?R0Zoc3ZqaGNvb2MxbVp5SGtyTFV1WTMraTd0eGg4N2hwK1J4OUhVVW5RMmlh?=
 =?utf-8?B?ajBDK3grQUNXZ2dDK1J5OS9Zcmo5andnMHVuZnBJVTJnT1Fnei93bVpva3Vp?=
 =?utf-8?B?d2tSVHI5L0plKzNMdHlQeVVPRGhNM0E5L0JnSHI4T0Y5UFFkRXdhTVNrM3JN?=
 =?utf-8?B?WkxBWHpBSUtITm1uc0M4a1pzRklNNy84R1lNRzNuc3BSUlZQdmZKbXF2ZE52?=
 =?utf-8?B?Z1kwTWgrdVh3dlQyR2d1V0RiNFBKaTVoTzNjUUk4QnZDOUw3YlhwWDFNeGlk?=
 =?utf-8?B?UFhQTDZKRVp1VWVUU1dqQ25aaXFzYTBVM2tmZTRLWEQ3dlNZRTZFRS82b0Zs?=
 =?utf-8?B?dVFINHEwQitnYTZXelJ4SFVTbVI0QU1teFB1dm40MllURHFNOTE1aUJRSU11?=
 =?utf-8?B?RTZjNXpYV0hzclZuUFFsd0lidkhpVmc3NVRsaUlNYTJhOHE3bkRPTmZqb3lU?=
 =?utf-8?B?cDhNbFBpMFZiTnJBbWIySGZOaFovcEtVOG5xR2phZ1VZRGRFdWgvdG5nT0tM?=
 =?utf-8?B?bnJMcGlubWd0STdVNDdIaTVzNklMa1IxNjR6eklsWjVVZU1PbHhCSW9qUFNI?=
 =?utf-8?B?eHBJY0grZXNCMnJ2cXNET2xVYkVXTlQ5ZWx2L05EVnVUa3N5WGlIeHcyUERC?=
 =?utf-8?B?b2NBYUJDSjE0S1JEM3Bwb1hpRDJEejFZZUxxVDRWL25zaitHcUVMOHJVdVhh?=
 =?utf-8?B?U3Y4Q3hsVExrWlp0eW4yTVFjdWhZZVZCUGwxOVhPbWwwcC9mUWtTR2M3M3Rn?=
 =?utf-8?B?aXExTXIrV09nL2t0ZVZGYXRUWElXbW04MkM0cEpNNmhNR2I4YTNGTCs3cVJM?=
 =?utf-8?B?WHJFL2VCTWZkRVo4L0dHaktjdGM0RHdleU5BbVRmbzdyVzlDNW85WWhzckRp?=
 =?utf-8?B?bG1CeWtLQnJLUjV5NWdWVTVTSzRQNlZYMEQ4QnB6TFp1T0didzF6S3FxUEpH?=
 =?utf-8?B?Tmg0cWtyWm8xWnhTRC9EUVFYZGxHdkp6M2p3Yi9nczdDb2MwR2I0NnA3Z09p?=
 =?utf-8?B?YmtqNndEZkVWdVFqVVB3MUhTWnovbjk2TG1wN0NxTXlxZEg3NUIzK29vaE8v?=
 =?utf-8?B?Z0FpNWRVWmVidXVjdWUzZUZ3aUxweS9yVEpPN01yMURVSUx4U0xRaVRQdHk0?=
 =?utf-8?B?VHVaZmxHV1FnQlpRbERpcVRnd2N5Y1ZkMGpOZCs1aXdVUzA0VTV3MktXN1Ns?=
 =?utf-8?B?V3V3SkdiZDhhYVE2Wk5COGtIWDRVUUx5VGYvU0hRR0JZSS9WWUgzM0JSNytn?=
 =?utf-8?B?cmhteU9KYjVTWFJld2lKanBpZURheEFPSUlaWXVLWnR0TmkvaWU2UkVhZGNF?=
 =?utf-8?B?MVlFM091RjM2bWJQOGpxeUROb3JraGZpU1c5Qm9LbjA5dVp5R3hoQVg0Y2pH?=
 =?utf-8?B?QS91dWZkZ3hVTGZkNnNGMHliWlZkTTFoOVM4K1JIbm0yZlkrVnR5V3MwcGt1?=
 =?utf-8?B?K29jYXFoalB6UU90YVV2R1A0bVg4OC9JRllGZnZ4d2lzaE80dVU3UlhHUjNq?=
 =?utf-8?B?ZTROMnROMnZnOWNPV2lOeksybDk5WWRVQThZY3hOaEZzdXYrSktwSklPZEc4?=
 =?utf-8?B?UDNSelB3VmpjbVhDV3RuZTVvZExOby9kRmFoVE05bVFwMDM0eG5aV2RSeTYz?=
 =?utf-8?B?aHo1L3FyTnNhNlBkcklraTNLNlJKemdLTGNFRHNMQTRJeGNVZGNHUmJlbThy?=
 =?utf-8?Q?mw+mRv+QhNzA1yApTBVic+wZb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799bb5bd-33ed-44cc-5d21-08db6152c763
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 21:13:56.5884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUSTBXcn7JkFzDZrO/ByTN4Z7z+v5t9uM1rORzgNtni36bEIKJ1yVxfi9qi2+YdX2w+UTsbOrsApCghf3SlmZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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

On 5/30/23 15:39, Thomas Gleixner wrote:
> On Tue, May 30 2023 at 15:03, Tom Lendacky wrote:
>> On 5/30/23 14:51, Thomas Gleixner wrote:
>>> That aside. From a semantical POV making this decision about parallel
>>> bootup based on some magic CC encryption attribute is questionable.
>>>
>>> I'm tending to just do the below and make this CC agnostic (except that
>>> I couldn't find the right spot for SEV-ES to clear that flag.)
>>
>> Maybe in sme_sev_setup_real_mode() in arch/x86/realmode/init.c? You could
>> clear the flag within the CC_ATTR_GUEST_STATE_ENCRYPT check.
> 
> Eeew.
> 
> Can we please have a AMD SEV-ES init specific place and not hijack some
> random code which has to check CC_ATTR_GUEST_STATE_ENCRYPT?

As long as it's not too early, you could try sme_early_init() in 
arch/x86/mm/mem_encrypt_amd.c. Add a check for sev_status & 
MSR_AMD64_SEV_ES_ENABLED and clear the flag.

Thanks,
Tom

> 
> Thanks,
> 
>          tglx
