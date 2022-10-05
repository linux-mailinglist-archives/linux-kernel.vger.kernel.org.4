Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179B45F541A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJEL6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJEL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:58:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76E21265
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 04:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+MlmnGiF2wcyDAhfrw9RZgLhkIpz3NX7GxyAi4VKtKcj+N0BzU8BlugqPtUjlCW4OUZMad7O12+xYxyFURAaAjyTXQoygIvdu8k4Svw9+rQ3q7ELbBdi9ah9NeQlwo5sWR9WorGNMYdyHEsTrR4fJhWJDWJM5jjYgZSohOXLm8pXBYs4BvAQtvjQUOSmBMHOUHyxWdE2xh9JUJXCqqVk60g7W91R9ekiEN/KTAgQZtGyobtZ9gLht1OASbnwrDk+h+wQJmup8Nva4MU0CuaHaSFmKXwul9AxckT1lw3U8KEWEf0NN7jpFkyZ+2o9nM/3/Pa0Cdc42ZdNJ6pLHO51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92gEudYViPSoFHFVbUAJYNnmR360+JuOA2pl7iiDTfo=;
 b=X7As866p+RvaX8SEvJudBqHVnjaIBSNIz94mhLx6h6yxi4ppkmcvy0vzHWCqDsoGBOidDjvpQ90nGMTBzstjkWokSCZywSGDk94vOmj2oSAGzkPfOs0jmyjoKNi4fhK+thNRcT1X6tzZWCDHGedhAJgRXnJp2uodo7jpOwxv/OXUizncEM1FnYkaEF2Ewafnngrt2EShtptgMOluaSQZfzgX1VnW745u7t/HJDX3TAhOQERkSoKuCtzf1iWjKcQtQTyrfqyqG/7lGe+0xLrLAQ/xZHXetVI7LI4CWRL8QYkhrbsSkFkTAsgIzU9nUrSK6RM/V0FZiGEJxG45+uNLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92gEudYViPSoFHFVbUAJYNnmR360+JuOA2pl7iiDTfo=;
 b=XHFrUX68ijXvKfhQbe6xAgSeCbqEoSaPybgujOybuEyg1AJyd3w0gYA60s5h1sXCVU3HvGMDcJDsuwg86NQ6LrK4v6OMqWlVDVEVpAvqpmBb7uhbdc00q9gg5TC2LGM7zLFBWXkStIZo286tVMWHlh1rKoh1FHEN0Qt/xB+A0BbBro+u9VRfqOoFeJGIhQiAUVYMRleosG2CryE9nBiwkNRxB2HL9jl+OtkvBct63Ui8FwhWKXqgHW5E/9HOh4TXuaYoSxNH34Xg3UXUN8bK++Ts5GSKY//0+dTN+MyIYl9pV60GHlFWhG3bkpFlNZ8S1bj2frh8GiPVo+w6Zkqbkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PAXPR04MB8990.eurprd04.prod.outlook.com (2603:10a6:102:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 11:58:44 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 11:58:44 +0000
Message-ID: <1ed567ab-6f1d-996e-66d1-da1e6b7ab8d2@suse.com>
Date:   Wed, 5 Oct 2022 13:58:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/4] xen/pv: add fault recovery control to pmu msr
 accesses
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20221005110302.13455-1-jgross@suse.com>
 <20221005110302.13455-2-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221005110302.13455-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::31) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PAXPR04MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e61fa7-7a02-47e1-78ca-08daa6c8f3a6
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdtB6Q6P0ye7zgiYIN84AHG6S63c6YNfhQNXc/RYuqB1CvLeWHQ1iirjEtmN9VC9I8v8c0/es31CYHKk7lL50KoeFOWi/mZIPoe3+30IiP+Mai6yfBx+FGQuuEHnQnsqYyx7qCE9pjj/6YplSYalTYJxoLoYNzMe/xKxwVIHJVP2zecrvlBxMTSAGIk8vhwO0PcMEVOKLhL1mRs1a0Rdl21U6UV2rkOvPdDKt3WqzxEEgGu6qzl8TNplH8rclBak3GCOd8v85TjfH00xWdrDZtjWHhVxAnpgMsOQP+o2M+1CLzqfVLHlmlesTkmgpsns9nZfuATuxVAQqdTSPcBpRIvP/Gej4qiBry15c41ewN/Eg+CHlT5QPQqAYeBzPMkSrKWMqNtnk04utT0QAs8OOQn8a6A76YW+0V8uWymyAok4kTCv/v+GxDKEqvc3hVSBiv3m3ZE1ke6AhZDSXUKrbq7/GuZnXgUW8rkTinOeitEjEkEwhoVk1+ONB2EnG+6oykvV7jWQHmRkPGxPNs2N4DqWB0hAMa6DWlAydqxkCAy8Dam4UbsUDnTgKCn0OF2xw9ftJTxOYiJhh4OEcDYsjwB3uMF40VIIlo3qu44AhMUdjNi9Vz3n6UZjBJrZFHZvT6b1319t08SzP6qIzvpOuqQ64Z4ImW6FB+TOpBFl8t3Yp0e52kZfowFasRfPr+H5EfnwWSI08ClU9zInWsi3uYBj0qYnP7CHnmv7tCFeK68le/o5m1JPNzx2xp6lA8Ncw0d07dp/HUf3MLLovyZ8xj+bqhzqWzmNti8wg5GNbsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(54906003)(83380400001)(186003)(2616005)(4744005)(38100700002)(5660300002)(6862004)(41300700001)(2906002)(8936002)(6486002)(53546011)(478600001)(26005)(6512007)(6506007)(6666004)(8676002)(66476007)(4326008)(316002)(66946007)(66556008)(37006003)(6636002)(31686004)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRBU2xmcUxxQTRUczY5Q2ZlSEIwR1RyMFZUMm5oZ3NUejBnU0M5Q0ZIaWlG?=
 =?utf-8?B?bHArLy9EQzBPM25PRjd4NzVzMXZpVjVTak1aNDFLVSswQ3EyVTM2OTZvaUJC?=
 =?utf-8?B?OE1rOGV6dU4wRVExM2I3NHlCZHVNS1AxNWtmc0lyRXZod2hxaHVFYWJTbitu?=
 =?utf-8?B?SGIyeEtKQ3A2Tk5uNjAxeEpyM3lpVnlLMVlaR0pKbEhML0Y0REhMUFVCY0Zs?=
 =?utf-8?B?N092TlUyWmhadkR1cit5NFRCTklVUFdDY3VQQ3hNTEk1c25qSnQwbkJTV1o2?=
 =?utf-8?B?ZXY1VVgrcTlDQ2RBMnlzSXY5MEJrRWd1RWorQk1scysxTGZ2NXZudEJGQUNr?=
 =?utf-8?B?TUVDa1JGR2syZUVvUkpyVG40NkI3SVJ0Zy9BbHNkVG92Z2s0TkpKQ2pMNWJh?=
 =?utf-8?B?UStucXY2TzhzZW92bkRVVXFtMklTYmhtRW1IamFjQVFEM0p1UW1GY0JTYzV0?=
 =?utf-8?B?VElhS2ExcGRlY2NYN081cVBGRG1xcDZvQWFCQm91dTdELzFpNTQzVi9jUjNp?=
 =?utf-8?B?clJYUHE0VitDZ3JCTVFwUkRYa3N3eXdDYTJldFRJNm9UTUFpK2gxNEtFa3BY?=
 =?utf-8?B?VjBsNlRrUmtHL3BOcHFhb3NoMW9YYkpRZW9GVzF4Y1did0h5S0xEN0plUk9U?=
 =?utf-8?B?Skg4YTluZGRqZi9sakgyYi8xNUttQWZLdk95SU1hYUlaZ2hnd0J4RThlTUlo?=
 =?utf-8?B?eXBhV0djNHJNQWFaeWwzK1FVd0dRVjJEcktiQzVkLzUyWlI4SUtKelF4Tk9I?=
 =?utf-8?B?QjNGTTdoWnRsM2JmbkVSYVNvUzM1QjY1QzFqK0oveW9ScEJNaGVYa1RtV3lW?=
 =?utf-8?B?bHVETUtlN0lZMjd1U25NNzVvbGlMZk91aExvVGRPMjJPMUhHTzZ2S3lOVWRQ?=
 =?utf-8?B?aFdXcHFuWkR0ZzVnaXM5cFB2VTU2U0VCR2pybUhXcmVRd1pFaUNQOTdqQWVS?=
 =?utf-8?B?VDd0N1ltMWQ1THlVRFh1Y044WTdtM0pwVmFodnhtd1BScmNaREJaalAxanMv?=
 =?utf-8?B?ZzVJUW9GalpOVHpTaXdIQzRoNXhidXZIUWZzcXNVbkxDajFwRi93a2lDVDVZ?=
 =?utf-8?B?aFJ3bVcyMzRBSzRBeU5xc2x5b1VZUmlSckZ6c1BTYXViWUIrblJGd2NlbDB0?=
 =?utf-8?B?YjNpQUJYSnNBSExYZ0FldFhSTlBwb1NDVlIvT0xGU2UyVjRJek1sL1gvVFZs?=
 =?utf-8?B?WUI1am9iSWgrSTk1djRoRkhCc0tPQUVoUUk5Ym1VaXcxVEdlOHpIZEtuc3pW?=
 =?utf-8?B?QUxpK09QWGZkQTBleDV3WmlEb3VmZnM5RFJha1h2V0hvVzgrbEJzN0pZdkNM?=
 =?utf-8?B?Z2RFZkUvRVR2alpDOXd0OXFlek9FRUYvK1R2SzlmeVJlbmpKZTJuU0RETjVx?=
 =?utf-8?B?dTRKZFBvS0RqTnRNdzcwK3VRUThYN2tmQXVROUtUM0czZXNLSm9WWGVmMFRw?=
 =?utf-8?B?UXJsUXdMMlJudGdWOXg3VC9hUDk3K2EzaXhUSk13QUxVWkhYc0xLZGJyNnZG?=
 =?utf-8?B?NDlPMUVkQkRnTTNJK3BPWkdGcHFMNldqcFhjR3hKYm42a2F4aC9qOG5lVlov?=
 =?utf-8?B?bW96Z3FwWXY0QllNVlkxdHIzUUMvUzFTZDFzTWxadEIrNDRmcDNVSlh1T1Vz?=
 =?utf-8?B?QStlSmdsNU14NGhETmNrNmJ4citrVEZ6bnFVQm5ubE5JQWdHWEpRcjdUNkJD?=
 =?utf-8?B?anZSYXZpeC9OODhBMEZzY01GTHhQL3hzWC9ER2hzR3lmd0dXcGUwd3BtUmJ1?=
 =?utf-8?B?cGZmaGkvSVpJZGZBU2lwS0lxUmxnY3gvWnRCZ3RTcE5UajNaRDJZM2pONFpt?=
 =?utf-8?B?S2l6c0V3Vm9rTm1RZzY2aWZVOEtsbllLQ1hHY3J5TENVYkgwNTRXQWplUHZ4?=
 =?utf-8?B?MEc3MlhGMWRBVGpCblVkUjJiZFlacHNwaU43TExpY0NLcjF4ZEFzclExRHFu?=
 =?utf-8?B?dU9LTU1kMkhOdHNYNzZ4R0dUNXVvNkVwbmRNaGlCL05lQW5lVjRqYjQ0dDZI?=
 =?utf-8?B?cVFFcTZuZmRxM0d1blUyMXA2cSsxMys4cWVkQTIyaTR4ekgzZTVuV3NDL2Fu?=
 =?utf-8?B?a0ZobU56bkN2UkhoUzBvaHZBb3d1MXgvOWZGOFhGMlA3ejdVdjgzTjdicjRp?=
 =?utf-8?Q?ZFyqYifuGgvvl8O+rYfoSAskf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e61fa7-7a02-47e1-78ca-08daa6c8f3a6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 11:58:43.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvMw+u1YU6ueMJhXqnCrvVHZujnINUH3CiUhAw21AisbqUUn15M248WkyNbedhrlaWw5mq4N3PHL1Nhy3a5Pcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8990
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.2022 13:02, Juergen Gross wrote:
> Today pmu_msr_read() and pmu_msr_write() fall back to the safe variants
> of read/write MSR in case the MSR access isn't emulated via Xen. Allow
> the caller to select that faults should not be recovered from by passing
> NULL for the error pointer.
> 
> Restructure the code to make it more readable.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>


