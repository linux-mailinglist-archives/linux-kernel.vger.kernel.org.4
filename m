Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91A974E644
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGKFQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKFQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:16:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD293;
        Mon, 10 Jul 2023 22:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCUm6t2t1nmfwslh037tmc52JnG3pNBdkIL03yjGmCzR4Ism0LZ51IBLn0K1qChGTmK2JObreVCo1LekX0wXFtJzvu513slehFl52Tb9bf81CAAyo3z8IcOePXDbUOot4GYiMJHB6CKvHXiv0oB7qfzPmafWUVz6b3XwnfejZ4xEk1vsRs7splnEVaA/49+iBRXeoWTFxYTZTTBfdENTWlWwzK24rJzDu5pcsBy4Rz2W43OtXVVMdHjYfUIFV/+qS9TJ/0tr96VIJS8DpAFEFdR1Ryosel5xBxY1vFrPbaIYKR4/e6xraVAQO6zxhpw3pSfXf3rSA0N02zkG3AwqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzgd0n1WuyDp96GshC2OyAo3IIoHwyGfRN8t4xUf2Uk=;
 b=guxRurx8+wAQDqRoguiaOD9bz/O0w+cFSF3kluVeiGkeQqXBDmNRCUfws6+Bg6Pql+EyrUECmzFmP4MYn4wEaf6PkNFETuqvBpPm4j9v652j9qqcAcEqQ4wYPJAXNi0y+t7j2xWAkb0v4Pz0dCWRg5cHsy5F8KFWzTt37M8nqmCJHss9uyW2Ew6DXC/rRW0UrNlwwZup8ax+D4WgdSLwh5T649h1HeL8hpwdJmQeEHwmCFPXJiBkOKIus2+iLP8sdhLOHD9TBCaIB0MUMyo/YtXbRJKwEtjjsUqhpT56y9scWEdC8DbEOe0huiTpm6e49c4fdBWWyiNM1z3laPwUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzgd0n1WuyDp96GshC2OyAo3IIoHwyGfRN8t4xUf2Uk=;
 b=hrem7luif+NU3C8726bJVGtTXTsv3xBlp2FDx7oG7TSj9L9RKTsBm2xWywqhYh10TViL1wGU3Hjc2v+ONLuGxAGCF45HxJ4ngXJ6lNTIDZfeaUO3bYolq0hUhbUghz4uuS9pIr5/svCTXldJYE5jZUKjyvBY0ZWPbrCzWp71KAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 05:16:18 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 05:16:17 +0000
Message-ID: <5acc07fe-d161-2977-29ab-1096afeefc4c@amd.com>
Date:   Tue, 11 Jul 2023 10:44:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Namhyung Kim <namhyung@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
 <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
 <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com>
 <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
 <CABPqkBQVfQFJKCdHXEMGFcupzvy8zq14F52eLW5s9vr2Shmi6w@mail.gmail.com>
 <85822c3c-2254-52cc-e6b1-9c89adb63771@amd.com>
 <CAKwvOdkfEexsE07XXGW3FF+nMt-pR8uv2EA7QzsPbEZsSQBO-Q@mail.gmail.com>
 <85aabdc8-07cd-3285-1f3f-605f9ebbab18@amd.com>
 <b6a503b7-b421-a5c0-1cc8-4f1567b8d9de@amd.com>
 <CAKwvOdmY7qoSG61f7UouWFz+gNN531FhpHbqawrAKCNKNDJHnw@mail.gmail.com>
 <5c077e61-c206-812f-1cb9-d47785e8176f@amd.com>
 <CAKwvOdm9SAQ5i74JUzWP4Q1WW3aHq+3Jo7hqfie+oMxjnKqxSA@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAKwvOdm9SAQ5i74JUzWP4Q1WW3aHq+3Jo7hqfie+oMxjnKqxSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cba8f85-8ea3-4569-da8c-08db81cdf491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAlmGC3NZAa3N1T0uEt7H+uayhTpufGtYNetTlvfWyFI81K+xYWf5n406eSrQ5mvPSzjvAs6s5vXY7SqUi+l3CvrCIkEgU+PMrT2k6chIGcGil6vbYciuTSijuABPHRpXroVs17Yr2bozOFPK24KhyXPLPydR/Uk2WWkugPUM9TtTGctY73JTGjcgVP8Y6tH0mYebXkluwYyCVLQaPl9gMbZXwbyr8AQT6Glkmwqf51JKch4Ls0EISWcZzObImLNv5XDwpWwLriri/NmvL67EkCKvISLu/JTNo4G4VnEwTDVTamkn1wfG0fg95k1WaDeBG5qZ/My0tdYiFfOiHYiriLgCh+GT7bNcEagoffMUMGnvQgB0J6Fyysw7pv+XVyD9vS8DmVXJByHJeTt16Zuv+w6XFwxFe1V4l4UusO9IOPRXthwMm9u770vZbo9SUv/Yoh3XPYWj+FbwTFnK5QJhdtWz9IxekSZHFDN/O8thAb23OmvKTcTtrIeAhMMT8fPqXaGAgG9mfCy1jGCHLc5ipgHo7rbPGR2gcegEhaxFAVH9rL5yHh4GBzLTT1I8efJjJEihpHLUZd6OVpxVIrqCMcI51MBQm5tEKIJwvRT14YddXVu+3zT6Q+M5GetfculFh73U6rP2YFmiAnnVoDg8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(2616005)(6666004)(6486002)(38100700002)(6506007)(83380400001)(53546011)(36756003)(186003)(6512007)(316002)(2906002)(4326008)(66476007)(41300700001)(66556008)(66946007)(44832011)(86362001)(7416002)(31686004)(5660300002)(8676002)(8936002)(54906003)(110136005)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzlhVnNjQk4zcDdmZ1J3bzJQMVJINzZFTjB6dytpUUtOa20yckVxN2tNYnZj?=
 =?utf-8?B?M1hrcHk5amhUNWVsMHhSdjh3Y2JrNXFWYXpSSzZCM05YcU1qNEkvTkNia3ZW?=
 =?utf-8?B?V2lEZFUyeDFwcjEzdTFoUzlPUGZLTmFXK24zUkZOeGZERXpBYUQ3clVsRkQv?=
 =?utf-8?B?QVdrd2Vjb05wbnNmZEZEZkc5NStvZ1NrVXZXcEVaOFNSK25hbnBVZGsxOHkw?=
 =?utf-8?B?bFlWSUdSNDhEU2xOMTdJeDE0MElUbjNaL1FROGY2bXBQQnJZZEtjbDBzTVdW?=
 =?utf-8?B?cG05ZVZkMmNHdERwSFlqR1Q5cUJWeWlVM0YzUzMxQ1E0QU9CeGt3enhaeFNX?=
 =?utf-8?B?M0NnRnJ4VFB2MEYvMmdFblBPbU13cFJwaVYvNTZCaFhwTEVOMGFJaEs1Wnhq?=
 =?utf-8?B?VlQxS2dxUkNhQzY4K2FhckV5N290aW9pNFZFMVBpNTRvc2g3MjJWeUN2cU9t?=
 =?utf-8?B?ZlBGRlZvTmFyeUtVOERYY0daMEo2WmQwcUhzSkRWN1dyR3krMlB5clFDellS?=
 =?utf-8?B?ejNQQk5JeEF2T1ZRZUt5alR3dUlIMHNNRkdFU0ZSaThXeHBTY0RBM2w3NW1W?=
 =?utf-8?B?bWxlYWxsa0F6dWRTbGJpTTdhTXgwU1o4OTlsbituRnlnZ0tZc0hpMjVCSStB?=
 =?utf-8?B?N0JmZmpySnc3dmo2Y05XdXhQbWVjbjhHbVRhL0M4VjQvYmh0aEg2cndSZktE?=
 =?utf-8?B?Zm1CVThXdS85YXJEM2lpeGVyVWtUNFg2blg0N3RISVpXdnR3WFdyOEp2d082?=
 =?utf-8?B?ejlwMVl5N0pQWjlKamxyeStYbFNXVFNJdjlNMTNBRVlPazYzSWRaaE5ZeWNV?=
 =?utf-8?B?dGJWQWdEZml1ZEVoT0dSVWpiM25hbHNqcWpXY3R2cDRyTkZVbUlhTkt3bkhr?=
 =?utf-8?B?djkrQ3lHRC9sZitiWmtWK2RBWWtuRDgvVU4vektCbFJEWVZJZzJRWnQwcEVJ?=
 =?utf-8?B?MVZQbGt2K3lEd25lbStvVjBGZkNYektqd0RqMGdRVUdhYTV0dVlLZU1wUzR1?=
 =?utf-8?B?Y0s4aW1jQUdjLzRnZTVuNURPclRWTWdaMkJsS0w0REpPSFhKS3g2amJLSlJC?=
 =?utf-8?B?eGRDSTJTRTcwODFoQ3JUSnVCaHpFVzRVMUdmZVZQdkl4ME5vZDU4ZUpUVUdn?=
 =?utf-8?B?M0RmWDZJU3I5NE5Vb09VeWtwM0pHM3ppVVJQWjRBNnZCZ2MwbHl5Y3pmOTJE?=
 =?utf-8?B?ZmhGTldaZVVrVWFXZ1B4eGg2WGl2a2xpdFVYL3c0dHdMdnNKMVhUbkw0eXp5?=
 =?utf-8?B?emRBcU50RVF2WHkvM3MreGpnSDhOTHBrL1NyalVIK0lGK3lTanlBRnhnVUhP?=
 =?utf-8?B?dHR3dlVIY3lQOWh1WUo0ZC9QOGVXWC9hWTRwWnRXamxZeEc5aDdmYlc5T0g3?=
 =?utf-8?B?L3BWQzJNNytqbU5CVXErREFaQUJ4dzdNTVowWmpyU2lHK2NWbGc1QnJzU2hV?=
 =?utf-8?B?cXowZmVHNXhGRjQyVnZUVERSUWFJRFB0ZUlBenk4dUp6cGRlanVEcThhdFRI?=
 =?utf-8?B?QU9ubUREVmh3Y2RlQnYvanJTaituL3F0Mm5wZFVSbmFUc3JjdHNaZm9LM0Nq?=
 =?utf-8?B?OHVoTElBSXRlUHh3ZUlOc1B4djNLU2NYeldEcmtvdjVtZ2dhcEZrZXdNS0hw?=
 =?utf-8?B?WWlPM3F0d2FSbjJHbk1IS0pwZDVTYklLenowYlI3Kys4alU2MjNYb2lMb2Fh?=
 =?utf-8?B?dVdTaWMvUTU4NXJJanZrMXFHWXBacDhVSnM2UXJuNWN1SWxWMzF5dEJrYXdN?=
 =?utf-8?B?aXZjRjlabG43eTQ3QWg5M2x0S1VaT2JPUmF3SlJQamNwUXdsSWtTQXVsUXU3?=
 =?utf-8?B?YlhGUGQrUVprR0UyNlhQY3R5YitZeGRCNlh4THZLM1NXaXdnbkFnSGJ4a3gw?=
 =?utf-8?B?WGZYazdUQzdWV0NHTUdHQjI2SlJZaGlSaVpsZWdkWkFSQUt2cElqUjltYWRm?=
 =?utf-8?B?MlVzUWJNNVFGcnYxcEhuSVRha01qWnFRdUIzUXdOZDd3NDN0Y1dyL2dHV2hj?=
 =?utf-8?B?U1ZZQTFVTUQ3U3ZyTUFVUHlyMDBEVkc1cURHOVQxU0trZHhWUm5VT1dMU2Np?=
 =?utf-8?B?OHJDNjdQeWtZRXp2L0QwcVlZdVlWdjhaTE9QekdoSXFUVzZ1SDg2NUxvQXJM?=
 =?utf-8?B?SWRYclVBR1BWdDlwb05IOVFBdytMWVpZM1U4THBVYWVtcFJHUnl0c3RhSlJN?=
 =?utf-8?Q?8EPzGEJgLx5KBDTT8HDuCFfSh297oOrUBC+zO0emrIh9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cba8f85-8ea3-4569-da8c-08db81cdf491
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 05:16:17.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzNrpxHW/tsWKDzKAB72xTKDjf76QLbv3SEETBtfD8szKBNLVgevSqliDrbSCM8kuH8T7yp+82CSufiU0+NpMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-Jul-23 2:52 AM, Nick Desaulniers wrote:
> On Sun, Jun 25, 2023 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Hi Nick,
>>
>> On 23-Jun-23 9:53 PM, Nick Desaulniers wrote:
>>>>> On 12-Oct-22 3:02 AM, Nick Desaulniers wrote:
>>> Hi Ravi,
>>> Sorry, I'm not able to load a custom kernel image on my employer
>>> provided workstation, and I never got approval to expense hardware for
>>> testing this otherwise.
>>>
>>> Was there ever any update on this? I'm on 6.1.25 now and still cant run
>>> $ perf record -e cycles:pp --call-graph lbr <any command to profile>
>>
>> Per-process precise sampling on AMD platforms should work from 6.2-rc1
>> onward.
> 
> Ok, I can wait for my employer to ship 6.2 on our workstations.
> 
>> However, --call-graph=lbr is not supported on AMD (hw limitation).
> 
> On any AMD uarches? Is there an equivalent? LBR encoding is compact
> which makes working it much faster than DWARF or stack frame
> unwinding.

I understand that LBR call-stack is the fastest option but unfortunately
none of the current AMD uarch supports it.

Thanks,
Ravi
