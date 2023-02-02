Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FB687EE5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBBNkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjBBNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:39:45 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31D88F02
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:39:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMGj1qpTcKGT+sUTDwv2gJ9UkJZ8vtD7yqaQw9zCC8vZXt8azZENniIOQzAa6tXnukyNJ/7zaOdUVpWp8KvQcl0x1dd+8Ngh/0uXetDaE9CwuJqae/4Nix2JFuwY8WDB1rNQihEeHHV11sBgIlI+pG7dWLwBclwSQDPWqN8E0uYmfe9s7vvSDKAee+ITB+XddLfkfzYWLa+EhhyA43gIqarHxuGSJDY2f05LvuqrX+GIm24jk66elVUzN6pYB3Qp6NDdjWbEQR7QaAXXKhcsoQBJEbjrzVvhpEALBDPT2RJTJGvj+9viLPERa/LfSC1AQxBaFuMdkFBLmEgPo3MXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXz0NLyOdeSnttQSUz0LDQI2NwhdCO5Edd2oCzv2gn8=;
 b=jD3aD41YtNOUNMJ3f9CzdHuFkwWV0DjhNmETJAmPz2x0GESHPh71zN221IAECS4D9/+af0hHvZmismKn6WuVAOKap8ThOkz2MqUGqnrVFahF6DUDeIgarlhL3RqSnR7z4PaWNnwlx/q21iVjAJzSO2KBQ3JwKI6ElPN8pVmBDqQoK2zJmc9vR0z0diG+AEk1b2jqBo3OpKUvGxJo60w9/PNGaIoDaAvu3Qobbb/F/iAD0mCOfmoSPlk0lu7y/QbXDBISzDWdu+Q1heSIPPzNKT5RP6MrPM72crtcrnxiu4r5kA2KszbAs2a5afQS33mQeQqmVJl3S3qGxMxgQp1d2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXz0NLyOdeSnttQSUz0LDQI2NwhdCO5Edd2oCzv2gn8=;
 b=LEc90BtZ94cJwTyRGYdfPwMEhYUCFNMOgSQV0VV7lZV7R6d558SgbjfxBukMvjmAu4N9fg89GBoxUWGTJTDey+1e5gGI8CO+DD7z3Tw7xdv5O4xSe+vQUIxtUXKwYherVV6ZGCVu8knxxyU70ThOLluA3yxO1ZUkA7u8Urx+/q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 13:38:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%6]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 13:38:57 +0000
Message-ID: <270a6bf0-8774-2f0d-9b0e-4f1eb9a986e6@amd.com>
Date:   Thu, 2 Feb 2023 07:38:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        linux-kernel@vger.kernel.org,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20230131184653.10216-1-mario.limonciello@amd.com>
 <20230131184653.10216-2-mario.limonciello@amd.com>
 <Y9uhkEo9INU0IPEr@sirena.org.uk>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Y9uhkEo9INU0IPEr@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:806:f3::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: f375d802-93b0-4c66-577e-08db0522d5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgFHPlkmp8nk6JjPNSdyW8ww0qpKvnBSRNEL7ne3mg8Aoz4lAb6HGYzgF/5znBzXYmFSwsvr2KWAhqGCfPp2w+Wfeyl1xEfvppyo8mnaeIua8+YYf0F9xAq8QjJ4ztAZgz/lIaiXYaDKIgefP1bQF9h7bueWMYsAE1NJ+scMyOCfVRlxiFy6Qe9OrMyvtrXJmk2c3EjfW7J1EO+TQ8Je2tHkRTgxZfCua8YYmMSPygQDu8Do4GAnYt/PLP/Moi/Z+4QJW6IwJUboepb0AW9Blyz5+emeTpL+FaMWxhUa0U01QDLbgDbkpzdNBs2Wi4rDH3opA7y7/eD1QxaB77Gj7EInkT82KA4U3FOWbQu2pmzYt2fIkqrqlSGhs668FQzBHiQr9oW2q6jeV/hr3OBD+wOylnPu3FtchREDvAWBEdAOCCIxnZoB0/SInkh3kIQK1BOoPuqTw6n8lGb2lvoMZe/3OLuy8S3oUCzYL4MlodXXGSpx15Rm8SdbWV7xKUPfTrO7m3jx8lwpdHU8B80/GZ763kmMDioYK2LvYhx9LsQ74RcgYiBPYq88DRqE2OKmwHIzymFTL6VxCCUUVWsmEm3Z6jKZYwuCWbLa8emUtjf5XP0vnIVptFUJSkV+NzVAeFEMLx0raal9FKzlRYfgiDuHsHuTsaEGAHMS4eHXcfbDWua+lDcjoAaA7gs6MBXwAiR4nS2vw+aC9pDLjA61rumGqjFBjwEyqZIKjNCucZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199018)(8936002)(316002)(6506007)(86362001)(53546011)(31696002)(478600001)(6486002)(38100700002)(2616005)(6512007)(186003)(4744005)(5660300002)(36756003)(44832011)(54906003)(2906002)(4326008)(6916009)(8676002)(41300700001)(66476007)(31686004)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WldDTmtFT0ZJSG9nMlcyTEY0YXp2TnM4YjI3eTRlQ2NjMFRDVG5MUElabEk5?=
 =?utf-8?B?YTBkTnNJODNzWW1GbjNkUTVCMVJlNU80VEw1WW1NdXcvczZvOEVJcUFXQkVR?=
 =?utf-8?B?Zk9zZWdTNjNTNFpDaXJwbWwxbk8xcGowTURFSUZOYnJHYU0zV3RWSGkrSkdz?=
 =?utf-8?B?Tjk4eWRrcVpFWDIrTC9zWHJNRjIzQSs0VVdpd25SNWVuc1hndEhDemg5WEhU?=
 =?utf-8?B?ZWZkNVg5UElaYW1NNXZudGVrb0NWbm45NFJ1Yi9Oekdra0pXcjRxRWV1ZDNU?=
 =?utf-8?B?VDRhT1djcForUGxhd1pCQ2grVm91ZUdObzNKWHZkTVRlaFRQYTZweGVMYU9l?=
 =?utf-8?B?bGJWWERVWkJObWxCc1Rnd1VDZlp5emY2YmZjUG5QZ3M0YWxtTU91UWxEc3l5?=
 =?utf-8?B?UmxHSDlxWFRsU1ZmY3NGRzNicnVWTGxUTHNkZ2xva05lWHk0OXpVV1pqQUVE?=
 =?utf-8?B?a1ZYNlV5NU9ybDd4R3NEZWFxcEtlNngvNVk2YzFmVVdEMzhXRS90azFLcEZh?=
 =?utf-8?B?VGd4ZGRtNkpzZklsNWRLbmg5RXk0Q2Vsd2FnMDRCT2tSbFo5bEF2YlphYU1Z?=
 =?utf-8?B?Z2tNZ2x4eHRQVmN1eWpOVWlCbmEyY3h3bnlHRmJtY1hTNWZOMU94eVVrVklt?=
 =?utf-8?B?bTVJNjdta2o5dzl2QmZnMHpBTUdCN3hGcFE2YkRBQ0Y0MGFVWWk3UVlzeFJF?=
 =?utf-8?B?QVNSdlRKbXl5bENVRzhlalFGR2EyblIwSCtwbW91TW1MdThza2llNmFSN3Np?=
 =?utf-8?B?WHFFVGcrNjM3aWdyektIWnlwOHhrRlNhY1cwYXc2dnpBTmZjR1NuMGd6dEd4?=
 =?utf-8?B?NEx0MkFjQ08vYVpKa0dRL1NpRWNHTlI4YmdqUGVoY1g4d1ZXNjdKZVN4ckZE?=
 =?utf-8?B?aXdtY0p2ZlpnSUliNmZIMzNGQ1dhbEp5U0htUjJMRkhtengvYjYyb3NaZTNF?=
 =?utf-8?B?SFQ0cjRyNzdmOTJySldOQmVXdUJSSTVoeUd4M2M1aVJYcWlOSks2dnZtSDhX?=
 =?utf-8?B?cjNyNVh3dER1V2sreU1jNEQvUXF3U2xWWHVoTC9tTldIMjhtVUJQRjVRb29X?=
 =?utf-8?B?WnJYdUx2NzEwZFM4RllvUHZ2Q1luT3dJSzUyK1VLQ2NqTG5CMFdidTgrcTlU?=
 =?utf-8?B?TVhYVTk5MEw1d0xNTmdycXlwTGhTeFBna2RZQW9XOEdqZlZRenk4QjhHdVJD?=
 =?utf-8?B?REpieHRKTmRxN0VVUmtyejkySXhKN2lBeGV4Y2hYMjYzVlMzVTVuY0xvZUtP?=
 =?utf-8?B?TDlTY2crWWdDamNjWTltNG1OSXUvbVYzNUVhdi9XdGlhYXZOT2ZyRXV3MW5X?=
 =?utf-8?B?NkZtdVNCbDRVSk1BSkZFVG5MRDV4MWpiUUsxVUs2YTdGajFwbXJEN1hDUWRx?=
 =?utf-8?B?ZmVkSzVsWnFVNmlyTVBkNzFvWkZNem03a3RYL0hiTnVsTE83WlFxV2EzdW1E?=
 =?utf-8?B?ZmV5ZXZoUlh3TnJ4VkRRSFkyenpzYlhTRGhJdEN6TWxXSFJ3VzhUN3B2WUgz?=
 =?utf-8?B?MUFFdXljTkIvZXJrbzMxT25PemQzV3RTcFZxMlc0Y2IwZC9aRFYvS1Axclhl?=
 =?utf-8?B?Y1JkNmZhVlZjSFZGZm5HUG1udXVodnQveGx1a3VuNjB0ZlBabkVESk5LUml5?=
 =?utf-8?B?UEJOWU1aVUtjWFhnTDlGb1FTUUtJSjdFN1R4OXU1NG5ScnFrL3dCZHRjRXAr?=
 =?utf-8?B?b0IyY3pmUFZJaHZSdEVYR21leG1LNkZNeWxjaDlzVzJlUXY0NHVxeVVpbVN0?=
 =?utf-8?B?V0pla0FGc0pXSlVmMjd1NDFyYzRUUjNhQVRlY2g3L3JROWFoUmppRFYxd2g3?=
 =?utf-8?B?Z2VCNGMwaXZSRnRJbFhBOTBWd2dtNDE0K21UYUlHendKa3ZoZXZhbytIOGVP?=
 =?utf-8?B?T2UvWjRUQWlTV2pYTVNYeExjTURkRDhPY0ZmZ0NnT2doLzNISXBCbHZDQWdr?=
 =?utf-8?B?OS9GYjJYTmJ2MDVmZnN2TjRSYjN3bXBlYWlNalZDanJGQ0RaSlNwOGZYRkt2?=
 =?utf-8?B?QUtMMk9wT1VyNUlzbmxySUVMYklyLzRwRUtCeHZPYktkQnVYNnBNTG13WnVB?=
 =?utf-8?B?RWxsRC9oM2RYVWJ3bzRtUkJHamRCUUxISDRHbnZncXUrRlJkczBnVjNHSm9j?=
 =?utf-8?B?UGVjaFZWQTNuemJ0S1lJTnR3MXdaaVFaL2FaaHRDTEp1LzVTZ1g1b0R6RUVi?=
 =?utf-8?Q?ntXNIyeC9YFH0RGRLJRbCLSSk3yjIMbh9OUnoJdxm/Im?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f375d802-93b0-4c66-577e-08db0522d5aa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 13:38:57.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y19njyzzly6rMbcQSKpiykKq1Bgz1sqnSx/35vdNnnAHwHoi7kG2gV71EU4n4LTcQnorpAE0DEtmKjup73yHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 05:42, Mark Brown wrote:
> On Tue, Jan 31, 2023 at 12:46:47PM -0600, Mario Limonciello wrote:
>> A number of users for Lenovo Rembrandt based laptops are
>> reporting that the microphone is too quiet relative to
>> Windows with a dual boot.
> 
> If you're sending a cover letter for a series you should send it to the
> maintainers as well, not just the patches.

My apologies.  My scripts to get maintainers to send to sometimes fail 
on cover letters and I didn't do a manual fix up.

Would you like me to resend the series?
