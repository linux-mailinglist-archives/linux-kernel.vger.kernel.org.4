Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFABF67A3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAXUMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjAXUMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:12:32 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A94ABE9;
        Tue, 24 Jan 2023 12:12:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2IC2jBzsooo9ydsyBzSDgGF4i8O49QADh2CHkiwQ2UuK4Fg98JgeM+Qa0BDVO/Xuz5nNFvvrjMw5mdSf4X4m/bcgtcahd4ZODW8RC38QeMNtPlrrINGTIIIjvV2DSTeHAjQgrhsUHTDJFs0/VIdBFeZaZCHcx0kfafrg1+UjuMyqbU5yleYC5rKIlC31KTPZypKrQVsiW1qgIQFB+jNuN3WkivHGj8uxvKtXML3PELM3tI/iRT304yFJP+ypC3MWo4ByEx5a78LZ7y0dmoCAicoTuTtjVL2UYOZAnxpZEIxU4y8KoKdNj+seOSKENg+/Krmpd9fMRKqSs4WajZsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgsADNOLTm59dRLDpuwL8SBh1phfIT44g2ApwDVHZYg=;
 b=ZJkrHXIIM63uI/M7Vt18ISszhIYVA1T2HqmHk/Uglxg5lLkzlIQjdoXqVSgvoY2k4bzAV6MojGgNazls2McfBq5HYTq6D489BdGAt692kcihNUC7wRE9pupB/FDDX7kI2r4iu20C1H3i8b8TH4fMyZw99uvGRDwNUVBqIBxCdHqzi8nz22z/G1+aEp3KB6jUpOaoQfZ3/1JTI3w6uS16JfLfWqPuqtirPRuDDGOKBTffftHkUNe/o7zjiGz03fJBu+tUrBi59mLcsnErQGq9PrplM1Vrb3NlK26R+8ybvxeG+emRM2VYJdV2K5dQ2mNFQeQi2adyxR9bQ0SB8qldcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgsADNOLTm59dRLDpuwL8SBh1phfIT44g2ApwDVHZYg=;
 b=QkUUl9fUkxPubIHDLmG3/kk84dePmOyuk9d1nHOTr0k1XrL5JQd5GcAHPvAop5ts25+W4wadWjl6Cb+JAbtSYvTHms3Xl0OPYZrKqzXut3mKWaVNM1vZ7EnFRcUX8xS14j3AYgSfhvu80REhJ5aZm/fwFFJT3nLrQ1GQVY9kQME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 20:12:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 20:12:25 +0000
Message-ID: <7ad9281a-11cb-f656-f7ec-afcfe94e2b11@amd.com>
Date:   Tue, 24 Jan 2023 14:12:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
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
References: <20230109164405.569714-5-babu.moger@amd.com>
 <Y7xjxUj+KnOEJssZ@zn.tnic> <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com>
 <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com> <Y7yMbQ8hI9MGl1w3@zn.tnic>
 <MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <Y8/CSrU8Bo298VzO@zn.tnic> <72cdefc5-1601-5c43-9ea4-4b637f5fafa5@amd.com>
 <Y8/07cV+t0PrqWX9@zn.tnic> <4ac38b77-77aa-f2c0-36e4-5e482013091d@amd.com>
 <1e662209-93d7-2247-4212-8c78748c69bd@intel.com>
 <12f98b80-38ce-5912-fa10-33d6b8a2fa81@amd.com>
 <f6e24e38-31d4-e2f4-4dc1-13208a427a77@intel.com>
 <2cf1380e-ed98-d943-e492-ebbe9238b51c@amd.com>
 <8e9dfbe4-ae16-5813-379e-7a958c90ab92@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8e9dfbe4-ae16-5813-379e-7a958c90ab92@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:207:3d::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: db970a71-9b0d-4c8a-cfbe-08dafe474f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lb+yVxJRHo3/In6oY8cC0diQee8g9w+nOvZoNB9SZXAnrWVgFuU9bByePoimkJ/24m1H/zckgQ03qzuEFrP32SoINwVW649iyEHALgoBl70mH+tZ7NHB1RPkFA8Aj819gOr+FSMCQglDcWAYk6oRlQF80bkiemMwXQ2EDKZ2xmkeIZgCYgsgzJDOHx2wxZB3UpeDXAvv8NpkshSZhEPQACGQnH93HdnYAOj5HGHMcg3RCwmEos2yIDlcIc5/A4gP3YDzpLsKyqxT6Wor7kuU0U0iadYeDiLuia62+NHYA9PFl/J1r4ir+877cf+LsjKEGvWlzFFZNvClxw9tm+a68mDKm7Zz46XIqn27fik/v3Ldi9sfyICVmmtzN5W+wLRom2CN6KXnV/lQoupAeY9KT6bYu3Zbk3xmyLhhNwfmbhtClPhgs9pWVxyUCpSgVvgia1O+yrIuwIYi7lVotCSBBOQALl5lyqdYZYRIuc9ot9t1Qnrr7+cseouHmhMFjFLvpbknf/JvVJJWNgl0KWY+cpG7sQGmbX0Uh0+XXqrTQORs7HnbTMpgJYIvMF7Sl90dQPdruTrwfskir4IgUDy9jHqMAdS8KyN+veY0wKI0rlVpRrWK8gkpArfV0vmX4q6ru04j7VxiwpQBquKpeE4g9x+WWHq28jt1xBjNiE8PknpQkHt0dRO9j0ILGmg60jlXzbklykg9TiigwcFsvyl5CbQcKM45+tK4aqatkeDDe6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199018)(36756003)(110136005)(4744005)(66556008)(38100700002)(2906002)(3450700001)(6506007)(5660300002)(8936002)(6666004)(6512007)(7406005)(26005)(186003)(41300700001)(7416002)(31696002)(54906003)(8676002)(6486002)(86362001)(478600001)(316002)(31686004)(2616005)(53546011)(66946007)(4326008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJ3Yi9QOFJORmdaVXpldllEVGhDR0tGS1pPNUtkZVNUZS9NNmRrRnVGc2s3?=
 =?utf-8?B?Q00yUjk3NlpES2k2ZHF1OVBTQVg4bEhvOEtHb1Zqdmp4SXVjYjlMc0dFQnJQ?=
 =?utf-8?B?N29pQTdZM0xMRnl4ZndJWXlFNGtyQWY2N2hQMENiWjljblV0eE5EaTZpN3Nw?=
 =?utf-8?B?eENsK21lU2xCaHBmbCszTXB6ZmFpRDBTNGM2ZTh3ZkhCY1BjdHpFTTRqdUpl?=
 =?utf-8?B?cDlOSllEamlPUUpOck9sWlQ4M1U0SFdzRlkvK0wvb0t5ay83T3ptY0cwNlZz?=
 =?utf-8?B?dXcrLzZSYUVnSzg5SU1jb3ROYnd0a2p5Y001NVFVOFkzY2I4am5CbUtZK2JV?=
 =?utf-8?B?U0dxVHNHUHE0RTVVNGRtSm11Mm1ZZUUzZVZTYkZOU2V2eWF3WGFaVmI3aE92?=
 =?utf-8?B?ZStYNncxN0RhYkw5Smt0VzA3eGRFQ05OWlVkS1VsU2hxZEpab1pKNVBFU1Br?=
 =?utf-8?B?MjI5aUExMEc0RUtWVVoyMXgydjlqQ2puemd4bFpjZlN0QVdoZ3dkcE9TdlJW?=
 =?utf-8?B?bkxiK1VNS2VaMWlJcXJaNFVIRldnekN6OTlRODJQdjRlZ05NQ24zaksxcUZw?=
 =?utf-8?B?aGp4cHduRWVpUmYyM1h3elFmZkdJeDZZRjJ4Lzg4N2NtQ0Q1MUtHQ0dRY1Y3?=
 =?utf-8?B?Q0xzM3NMYlBUdGIzdU9SdzZSNG9jZldtWEJ5SVo2MmppQ253cSs2bTkrOXVG?=
 =?utf-8?B?OFJVMUo5dUhaOHdHUVJpKzE4R3lXZXhVVkxtK0V5QmVHQjBENW9iYU9OTFFU?=
 =?utf-8?B?QlBMZURhUDFDWTRUdW9BNGZycnM2Um9oVXRPY2VrT2lCWGttaEVSRVFvc0ZO?=
 =?utf-8?B?eHhPU01Yd01pTHdtZVNqRElzWENTRDRkNmNJVlhUVVNjWUh2OWxMZkZkUzhu?=
 =?utf-8?B?Qy9TZzhLZjFiTzJBOGdTNERSVmpDb2pwOWk2b3lqTU9GVkM0aW5OTjNTNVE5?=
 =?utf-8?B?aDQzR2c0a3ZnWW5ndlVYV2ZWbjRCcDl3TXlKWHgrb0dsOXhRYWdJN2RscHRw?=
 =?utf-8?B?U0dTRGIrczhWMjNVWkpGenRrbmtDWVBxbXNUMFpzbXhUeDdJWU8xUjlZVVYr?=
 =?utf-8?B?MUUrK1Jkbk4vK2d2RWpHdGhBTkJGZ3FHSHNZYkhyOVlsT0FjL1lSYnpPdk92?=
 =?utf-8?B?a2lmM2QvWmlqRDNzR2ozZm5IU2VpZ3Z6NjBYWmNBVzZVU0pQUDVKRmtlSmYy?=
 =?utf-8?B?ZnNiR0tRMzJjV1kxTmpuZHRKTFZhNGkra2JMTFRzSytoSitiM1k3bE52dDFm?=
 =?utf-8?B?Mi9FbXNGcWEzK1ZUbzhqbTN5YzNLNkI0RVQ0bzJyQ3A3QkNQcWFqWUxabm5L?=
 =?utf-8?B?bFBsN2QvaUFXckMxVzM3ZEFkaUU4MWlhVVBXbHZDTkNMTit1azNIejRQbDFN?=
 =?utf-8?B?UEZFMzRkVVY2SmNzRk00R1NqbEJ0amk4YjI1aDJmQzlvUFRONjMrd3hJZFFU?=
 =?utf-8?B?YUZsQjdXR0FEL0tvaXVFdHB0RGMyVmg3Q1JDWDNTQWo2b3QxdVdFWHA4Z0Zy?=
 =?utf-8?B?VVZSQWI4ZTNRYTVSUW9wRG5mV2FsN1V6bVl4M0JzRUtQQWFiTTMya00yckhv?=
 =?utf-8?B?TzZWcVZheUNQNmsvL0ZJYTlUd1FIMkREc0VYWHVKNEQ2ZzYvQVQ0K2Fzemta?=
 =?utf-8?B?N2pPZmlwNmUrSjYrS0ozOElZY01jNUs3NzlMMUdVUFJ5WG9ueCswbGhNMlhB?=
 =?utf-8?B?NnNlaVJ2Yk1yYUtqYUQyUFZvNFFRWFRqR3lXclNsN2tteHRHbzBRQnlkYy9C?=
 =?utf-8?B?dU5RbWpQeVZ2MUxydytETEpnMHhsRmRETXo2QlVhNzJRdXdXWiszQndlTm1O?=
 =?utf-8?B?ejREMVNKbmR3dUN2Y3prSXlrbnVxbHZ3bmp0elVLN1RWc3Fpb1ZSYUd2UWth?=
 =?utf-8?B?RnBBclZzQVNuZlBzNXJvczU5U0YvcXFGL2pINmN2eXNSV1RPNlJJeTUyNDVQ?=
 =?utf-8?B?M29NbnpiUGNabkRudVpBNDJpbmdML0FhVnBlQzczSFROanpDR2tobXNOR08w?=
 =?utf-8?B?RkJXZ1Vwbm9ySVBKSnJleS9wYk9ySU9CMEE4Y1huNkpyT0gvSjdDbVlERHpx?=
 =?utf-8?B?bTZNdlVhWDhmM1FCQ1ljM1VnTGtwSTdFQTFTU0trNlZyMnFSU1YyeHNGT1Fo?=
 =?utf-8?Q?8H68AAciIWxROj6R+cvGjGpgz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db970a71-9b0d-4c8a-cfbe-08dafe474f31
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:12:25.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtN+GSmKgn74Q7bq3TYK6diRDy4xelu9xXLS5i09v84v7oVhZccRbnVqJPMAb6Q/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 1/24/23 13:23, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/24/2023 11:03 AM, Moger, Babu wrote:
>> Yes. It is available.  But, the feature BMEC is not explicitly available.
> I think your addition [1] to the resctrl documentation explains
> well how user space can determine which parts of BMEC are available:
>
> 		If the system supports Bandwidth Monitoring Event
> 		Configuration (BMEC), then the bandwidth events will
> 		be configurable. The output will be::
>
> 			# cat /sys/fs/resctrl/info/L3_MON/mon_features
> 			llc_occupancy
> 			mbm_total_bytes
> 			mbm_total_bytes_config
> 			mbm_local_bytes
> 			mbm_local_bytes_config
>
Yes. Sure. That works.

Thank you.

Babu

