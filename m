Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD4C679B35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjAXOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjAXOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:11:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7442DCA;
        Tue, 24 Jan 2023 06:11:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpwekxedMehIGzmw+VcqzSSnceXEIhlwSUW/fZxfXGe2RENtdURPwofzghZnk8QqG5jUSApGE7dJBJmSBIsJqDxyLG0PrkKElO2nqecWqArr/oiOsuVgNkcWSJ3F0mEr9b+0jw9W1m6onksDRXMm0mtPhrvx2VN7VkWBGwe8fuCZY0ranQv3ydseep4eeHRLJttRvrRsiH1yttBP3Vf1gcNOMdfHVbHpB/xz0KEIDteBLOTEm83JQcpbhN6qWodUEQUDTRDuV8LCXYic7Ep1HVptmGCrXUFAcSudEVgCmygtUmSXbCPfAkBQkIIw+Pvd9WgpV8AYQJ/dQjOLNIQyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZzA6mY2esQpfQbEFaHM/Dk9RtOalsbVX/JDFWrFcSg=;
 b=NgbYWGVaNz+f/DVXAxqluLQLzpAbo7hQzF8l+MQbNOhWZ8GQmbpWQDKrX8Eouu/yhCYEzuDX7CkUlDjoomoA1X0wRyO/5AYl9HS/ROXyQAjq6jq2GQzCDrIA4H8AO7QZgfA/uPfSjwtqsnuaxvaccLRQN+EK4mBb/tJWwpqHxpTq0eUYYX9/N7A3RDPoP/y5C20AOZpivX01n8ryM97GC4+h2rmL5l0CUltHSdTsGWAgwQ9nKzXUKSeWEAkCNr/kTDpqcX7O50KQcpeQJdEAhZusGw1nN+CPHMneUSIDEKq1FaubaEXKFQpbwfXbTi6Vjv4zjneq4tSFRK3meeTJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZzA6mY2esQpfQbEFaHM/Dk9RtOalsbVX/JDFWrFcSg=;
 b=XXr+vo/Hs/jXH2ctaVQzeCX3MCdl8xEStl1eA6rKnDdIpxHj5UwqjvuLstLnidSRn09VBRt+KmxWc22AaEMAgCwQ1zcTO7AhSKv4AN0wtO1uydTXTL2bBay+tBqsavWJCJ+Fe02wvJzep1crNtsXO8UCMiNHp8AFgOiY84Pv5g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 14:11:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 14:11:28 +0000
Message-ID: <72cdefc5-1601-5c43-9ea4-4b637f5fafa5@amd.com>
Date:   Tue, 24 Jan 2023 08:11:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-5-babu.moger@amd.com> <Y7xjxUj+KnOEJssZ@zn.tnic>
 <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com> <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com> <Y7yMbQ8hI9MGl1w3@zn.tnic>
 <MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <Y8/CSrU8Bo298VzO@zn.tnic>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <Y8/CSrU8Bo298VzO@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:208:e8::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: bc88aca9-9ccd-49be-c4f7-08dafe14e272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjiA+cR1GNar8ES9UPdAcEroq+b3MWSi+iAbhk78NdkTP2xQCqk1Ro/DEu+t5AKzr2uIm8Id71sVAhdZrvadv85v+Jjz25TsdH0mTJjyrauPJBYrgUBdzw4++9nM5O2u9EW8x60ZYpkCQ2YqLvTJvOrqqx0U6ACl8GIJkeVdK8v1VdcVVgycMlMEgaSiNq/NcNN7c7RRyQZO5cOnDloi4PVJmeubS3GBDg+XNBBE0xPkAUtqmOkDMBjeku63ADALf6GcZms9uS+lmT8UGkHJ5A7x/dPozbJgGbG4OBiez54uqecRoLbIA7fdTe3YbHQAqhfXKmEnpwWLF4CojjwNvJ/jUOFxNNAwOClMuakEvPaRwaAjhjS5jkkwKFawyVaBlodDmHNtxCVYC7V17tK4bunbOeQRYMWLZHjXzPNJ8OElJlW9JogNwTzT9wGwSV+XM3bVXLbe9wYQm7tbFVY2a/0mj6jFTMVged78nGbwa62hijGnzgcC0SePF69iWnJDx6x45xq2emAULSq+dTPEYlAy+Ur4TahzZ0TfnzJCXc47Gu74VtWVC2HW7QiaV8svV5OEurDOd69+npj7Oea0gRs1Pwmyrwc5huTOCb/CLXJwwypn2/PTFeHJFmi10PSPK95z5jtSJjsuN6r5k+M4m9twv8RKZ7uWLDO0aiYx02pJg1cYgbe9DeAxcjN/CHAqC4tWwbX+LcoB1bp5n/Q85r8z5nLoGdlgPPhj8l6tHfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(316002)(41300700001)(110136005)(54906003)(66946007)(4326008)(66556008)(8676002)(66476007)(6636002)(6666004)(6506007)(478600001)(53546011)(6512007)(186003)(36756003)(6486002)(2616005)(31686004)(8936002)(7406005)(7416002)(4744005)(5660300002)(31696002)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FXcGUycEFaajdsVm5zejZQb2FtRmZNZmhxaEJOdDBoOEtnbUFoZXQ5a0Jm?=
 =?utf-8?B?SFk4QXBEbHFwSSswcDY1cDY2ZlM4YXdoOGJIQ0hQdTNzdXVkSWVqUWYrSno0?=
 =?utf-8?B?bU1oSkREQlJLL0l2VGJmbWZQNU9rTEJQUEpGODRMVVVkczF5ZkRNbHFzYm04?=
 =?utf-8?B?T1c0L0I2UjUwMVovNEZxYkdwME5uc3NIZytRK1ZpQ3d5OFZ5QmhIWnBGRTZE?=
 =?utf-8?B?M0V5Z28wS3VQWWtJNUVPTFE2OVk4MmdzbjZyWHR5dGNEUitrOExWWDBpWldy?=
 =?utf-8?B?RHBsOGlqLzVRUFhVV0lYOU5qZTVrbjNlQXJZTVJScVNjUWEzYW9FTWNnQ2NC?=
 =?utf-8?B?Z3pWNk1KL0c3aHRuL1BybldiWXlDYTZEU2V2SEJ1YU9MNjE0UWwyamNlZTlJ?=
 =?utf-8?B?aUtjZkdDWkpqV0U4ejBvZk1tL0s2TThheEVGSkZtU285K2F0SDIxVktxQm1Q?=
 =?utf-8?B?TzQ0UlhZcWRUdis5SWM0WkFZOWQzTlFvU2QyU3ROYmVrRGNZQVFFSWtmdzJU?=
 =?utf-8?B?MUkrR3lidWdIbVJpOHROZlppbVpDa25jYjNqM2YwY28yVUI5RlIyNm1yRldN?=
 =?utf-8?B?WjU2cDE1Z05ZdUFKVEZob3pTWmI2WkVXUUk1ak5mZHdxRGk4UktNMlB5azdi?=
 =?utf-8?B?TFUzRXRHeGplYVBRL0NqYUZDeGErVklIbFJYcTZIZ296cGdXVTZNZHJ0Mkt6?=
 =?utf-8?B?aVQ1czJtMXl2WStYSGZwZHRraWNRUytIRElTVnR2WWlPWDVKaXVEejdpUUhU?=
 =?utf-8?B?OWZHa0piZjJJSkVkdEVzUU9IRnFRR0E4QW1vTDdENC91dGMvWlk4aUNxTC9M?=
 =?utf-8?B?NFFPakppRFFDQkhhVjd0THFrU29sZTR4c203dnorcC9iaW1wODEzVDlOMmpV?=
 =?utf-8?B?Z053NVJxdkM5dklvQnl4TWhNRkhZRmxaMndtOC9PdWNKRGNSWnR0L2tpSmFv?=
 =?utf-8?B?V2QyVDl4cXV0aDM0clgvUjNMZlZ1dEhmVnhyQU9PT003cTd1L3cyUXN2Q2RJ?=
 =?utf-8?B?UUtUMTY1WGZma2c0eVVEeG5kQ3RBdCtkK2FiMU1naEQ2YndmRHFwVDRoblNa?=
 =?utf-8?B?S3lQdDU5L2ZieTBMNHhoN3htSjlVemh3UnRlWU5jVHRGQ2I0ZnN5aHJmRUZh?=
 =?utf-8?B?RVpzSHduaEIvcyttcW1uM0xSVk1DVzhQRWlFS2grcTZqRFFZVm8wQzlZVHZF?=
 =?utf-8?B?Q2E1V1B3SGFpektNL215dmV6MmlmbDV4eGUySVVpdW9pcnczR01VcG10OWQr?=
 =?utf-8?B?T3BsRUlEd3dRRlNjeVFQWm9nZDd6U0NUbFc2eTNySTFRMzRsaWlURzBVVXFh?=
 =?utf-8?B?ZWRocFlJQ09jVENzdU1qQ3dtREJBTzdNNVFiL3ZnMWJYTU0xVDArQ3hIZFdj?=
 =?utf-8?B?am9ob2JPUS9QV3BINjAyWUtJVmViOWtIWGp3SE9lTitVek1CTEtZcnBjVTVu?=
 =?utf-8?B?aEFxMDBVSjNTZzg2eUVQamh0cGwvVHhzM3NXK1l6TGhBY3FDUkloVkdzVFhI?=
 =?utf-8?B?bllIbkF5VnUrUzBQbW9uU0pFTlRUZXIwclhVN29hWHkyV091VGRLU3FEMVMz?=
 =?utf-8?B?VUdPTm9NQUUvMklPR0o4emxYS2puTnFnaGQ0aVBNc1JHTFBkbHQrSWNvNUVr?=
 =?utf-8?B?UHZHN2RyQTdXUUxNaWZFd1diTk5mZnQvb0NZdERvaXZ3Y2VWS3Vucm1wY1pW?=
 =?utf-8?B?RTEya1JEYlNLc09iR1NPNVZldCt2NEFVdVRQMDVwUjVNRUtwem5kdlhkUlFU?=
 =?utf-8?B?NnMyMFg0bjFxNWhqNTNyRUhEZ2dTc1dvVUR0cmpva1I1Ni9rSGYvZzE4aDEw?=
 =?utf-8?B?MUtJazVqVk5JNFJhaHhpbTlLSHhLaUFYenIrS0lKKzVndHZOc1RIejV3UnBF?=
 =?utf-8?B?ZUh2dzVzYVJqZWFtOGQrZ1JYaGY4TEtwWkxXeEwyVzB2T0NjNmgyajdrWWpi?=
 =?utf-8?B?c0lOMTF5MjgxYXpYNXBGOWJtM2hDUFhjNGFSL3R5WGFMZ3RDckhxSUZRUWNy?=
 =?utf-8?B?S01XaWx5L25SU3hDRG5aNHFWNEJMRVZNNXBubHIyYmpnQVViVE9STzZleHVT?=
 =?utf-8?B?d1FoQzkwNUN0a0R3d1Z6YVVNL2NwZVdiOXdFVXBlQit1N0JwNnQ2Q1JadHdS?=
 =?utf-8?B?WlBFTW1oL0g5UThKTWdxUERzdkNtSS85QWZrNnpmeG1Ub2xicGltK3daeWRp?=
 =?utf-8?Q?cUXlUvwHftk6AsIwOg3LGvqTCT++E4KigIht7/ESmGFH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc88aca9-9ccd-49be-c4f7-08dafe14e272
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 14:11:28.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+6ZSlEQilAxrqfxcOOnnkCJ24amYzhDyFvTfQZIA7CItUntqjtTQf+hN3G/9+6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/2023 5:34 AM, Borislav Petkov wrote:
> On Mon, Jan 09, 2023 at 11:10:40PM +0000, Moger, Babu wrote:
>> Yes. We could.
>>
>> But at this point we don't have all the features listed in /sys/fs/resctrl/info
>> directory. We need to add all the resctrl feature bits in info directory. How
>> about we take this as separate task and I can send separate series to address
>> it?
> See my reply to Reinette from just now and lemme know if something's not clear
> yet.

Understood. I am planning to add resctrl feature list inside 
/sys/fs/resctrl/info/ in my next series.

Thanks

Babu

