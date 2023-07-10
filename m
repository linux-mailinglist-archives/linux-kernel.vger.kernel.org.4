Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80D74D731
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGJNPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGJNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:15:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47004BB;
        Mon, 10 Jul 2023 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688994928; x=1720530928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H2U3xYAoYBbLGAPbjaBzZyUoZJdahvQV91ICjtgQJjs=;
  b=muBmTMxTiFnEhvN/wrGTQ47q0Tbnj2AtXhzRSA5ENku1EyPaV3ICTMbL
   wioWXUzIdEW2FXB+revK05MnUMI5NfOeCpz3nIchWc3W1wPVFf+hI3cDZ
   JcKeHiKKrAjqQb4kR6lMuU03IzXgUy7Ji9oZtyUnp2A0MYPGj629NY6Vc
   csRMTkH+00950+LJtbDHpa3eikxI+h/GQ71B8cRoFfB0adAGG4huJ6x7w
   dMUreP1UUynhZ53Qzi+N7W75vHAW/+pslulGfcsN2RWFw6LC4tqy33Tj0
   vg164MhvgHBSUT2/MM42IHR7vsNXknukB7vB0yQYXY/nLgp1Kz+rKcokP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349142508"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="349142508"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 06:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="1051356235"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="1051356235"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2023 06:15:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 06:15:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 06:15:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 06:15:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 06:15:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEmZqdEjj9ZinjEQnGdTJt/XZLaZaamLV5jswNNkXbfAmUNqoWF3IwgvdJ+oD5MzAfBMKH4PRnBMRfWqTD4xF7KalHfPIjxVI2gUXVsuT1TmxBJL6MxCLmv2Tm45Zne6qWcym0l0Bo4ySsfQk6I3BXTUHdwlIZM6a3YFm8JD3jqq75JujRRDZNaKplJuot8lnYbt2j+JSDKNtxvnIyOYlzVbCRoaaNn6Yt47UUsFsdDHOH7ynOAnCFy9IzpfU53JuTDRa07cnrg26hvq/tTpnYPcbRi45ZYGobqBk80JaThrlMd/ZocdXB5ZSOrrZK6GkypilYMWwhsHSXHLulwSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7u7R7WL0MYdkTkRrvx1BpHTi+eol7YlCQV0CNB+RRk=;
 b=dLGZ/izO4uWLbO5EDja3Dib1+TtEqowlb/S19d94bmrElrbtYreIe0TD+XRPTNuRNrBQZ5Rq+aLihvLTPTQi5NOTdodtxO+7FJ8HXVGrJDiROcrlkraJbOZ/6tUCi9vhtjwDyhgSOd8AdKKBeYg3+rY6egdmhRgPjtsftPCjIOmOiStiPn++dM09EebrIN6nslKvIqGk/ErBrfDq1BuDZfe96ma24ZwpmiFQpjit2cSM86wEfBltwXVe/47Kng4IU1otfWWjycnchIspnxKYLFu2FGMnYO08SaP+6eYXT21F2588bkl9AyF/sZO5Ipf050DYsc6T8uFWyLdNIGzzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 13:15:24 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:15:24 +0000
Message-ID: <f73daa0e-c201-5fba-8232-2107bc8e24de@intel.com>
Date:   Mon, 10 Jul 2023 15:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 3/9] iavf: drop page
 splitting and recycling
Content-Language: en-US
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-4-aleksander.lobakin@intel.com>
 <CAKgT0Ue+VvnzNUuKiO1XFW6w3Ka9=SSfGBP_KpkbvR6uzqvg5A@mail.gmail.com>
 <6310c483-8c6e-8d34-763a-487157f6ff0c@intel.com>
 <CAKgT0UfLBmzhshM5ZsvLaBwGtv2AvXA3n+kbn9FtBWTCocsiDw@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0UfLBmzhshM5ZsvLaBwGtv2AvXA3n+kbn9FtBWTCocsiDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::27) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9c8e87-bdfa-4744-e0f4-08db8147b853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qozcSrCTZpIzXExY/WRS8BH6+ElGS+YH6YL1gAH6LEMWd8LY4XB0Scs4KdV4kjj6mRTOjBzYQfYNqO3EuwFw07Qd0Qr72yxgHVERh1wRsYQsoIo+4NQCPGMjDMTXIbP3gDe0CNgXbA8eXjyGcDQVbuDOc7o7lw5a33PPD1SJbEvRi3W+GE+38yW5cnefq0EJGb8GhLcl6XOKeBjhddY2zwEPMb4AC9FBjPK0viHk5lqJfX/gZrGi/NTpoxsJyGKwOdqDr/mdc/51mqkXGGCUDw2UhKwUKWeHry/4rNeGHi9iQmBh9D3jKd10gKNeUdSON32hn2PBaZ9L5EGmezG4ohULLnrwmg6yGTA7drlOnfdKoYkaFLOkSzZQCZGvWjUwuekNTcyrRiCWhxla+wkrukW1Xz3kQNRS7LBL6l04hYWw+7H7IUdApSLnEknG+ETsMO3Gn5hdA1JQVjn0fj4t9aDS3Ap8IPTmMgNZz7m1NHAemTJ0usXZBBg134gefZ9fifOPxwlEnfT/N6BJzvh3B7yvLIX8ruzQ1OPKHKOQUbKgrgGAAzW1XaljoALp+t1WkTPABLc2v9zylOzf/sqL/cdoL3OCyvp6gSYH+/8QmSyyaCtWBOWx2VFGTednZQmSqm82OwKEkXiYl7Wwc6UN3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39850400004)(136003)(396003)(366004)(451199021)(6512007)(82960400001)(38100700002)(26005)(6506007)(53546011)(83380400001)(186003)(2616005)(7416002)(2906002)(5660300002)(8676002)(8936002)(36756003)(6486002)(478600001)(4326008)(6916009)(66476007)(66556008)(66946007)(41300700001)(316002)(54906003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkdTaFJFdVY3YnNCTVo0SFljcGpZcTdEVW1HTFl2cXg4NG4yMnpqQUxtNWR6?=
 =?utf-8?B?SmFRYnZtem41UjRKUmplTnRhTTJLaWhWWmR1Znd4WnBwSGdjNDRoRmtSTll2?=
 =?utf-8?B?ZWF4c0xMS0xKSDNOa3QwdmxJZGR3dVFUM3BJa25iQ3BTeFhHM25aR1FSU2ZY?=
 =?utf-8?B?NjZwemJQVFhSS2p1Nzh0NDNpL0hZUFFDWEJ3c2t0SlJJUUpKV004YXQrdHFr?=
 =?utf-8?B?a2ZlL0k1aHRYUkplVEZrUXN5WkpXREdzdVlCdnBnMnJXYjdSbFlyMWErcGl2?=
 =?utf-8?B?TmNNbjZwUUlrZFhuSkRDdnRGTnBKN2xKdGtabm9CWWo2ajFTSXlLVHA5elpH?=
 =?utf-8?B?cHVuZisxUWRzT1hPREZMYUlFeGJlM29Wdld4cDJJTVd0RW0wQkpCK0VFUmpP?=
 =?utf-8?B?SGJveVZDQVhTTXJoWUNMMnlnbTJYZno3b2lVcFJwSytTR1ZEU2IwOXZ3M0NK?=
 =?utf-8?B?Yk9kaTZ5VWRPSU5IZjJjcm1FMkdvTC9DS0lOZ0tyUDhoYnY5aVVXRlNWT2oz?=
 =?utf-8?B?amN1L3BibStTL0s1ZkpCWVJFKzUvbnVaVWtpdjRTbGE5M1B0dVJFcFhkQjRy?=
 =?utf-8?B?WCtFNTBpOE1UZWcra040czdveGNaV1dqOVl0SGdZWGJCbWhwTXA5eitvTEFH?=
 =?utf-8?B?Q2p5VFpYQ0hJcFMyVi9RTlZKd1g0ZkNnM0FkVzRkcUdLV01Nb0gxYkxENW5P?=
 =?utf-8?B?QUlzT1hnMmRQZisrci9Qd2g3ZVZoQXlWSUttM0hzT2NwaUVFRzJZWDUyUE9H?=
 =?utf-8?B?RGpZOXBTRi9QWFN2N05aTU5ybGFzb0I4OGtIRkhhSWNkVnBBbHdVVkFUMmJv?=
 =?utf-8?B?U1ZqaVhyTlFTNjhCc3ZJRzcyeDUyMi93L1lacnFlMXBGSFFMTjNSaGtXelNt?=
 =?utf-8?B?ZGU0QXA4NFF2aytTdjFMOWUvaTFIMjFMZjFxNXpzMFFzbkdoZUphWk0xaUV3?=
 =?utf-8?B?SzhZMitKWis3QStYb0pkdDM4a3h5QzN2bitsWkdQU0RHRUxnaFZSYzFadTU0?=
 =?utf-8?B?WitSdWVOOGgxRTVFVkF2WGpaN0dJdkdRaU5ncnNlbmFVTTRBSHU3aEg2UnA1?=
 =?utf-8?B?Mm15S1M4SFVWMkZDcEhOZ1h1R0hjZWxidXFVek1LTnlzb3BLcitkYzlkd1pX?=
 =?utf-8?B?N2dxQW40NVVaWFk2K01EY3JKaXJoU0xrTG1sWGpLeDdSY2Fjc041aU9nWUJn?=
 =?utf-8?B?U3lNa1FsRDNtQzkySG9ad0lVSzFITGMxa3N0VDA2ZWQ2UUNMTWhPRVZqM1hp?=
 =?utf-8?B?NVM2WDJ2Vzl0QlpIUkJWV1FIK055b2JOTDM3bEYvd3NOMUNiNm56Y2RtUHlr?=
 =?utf-8?B?MXZTU3dCUWkwN2lUMk8yV1FLYnVNbGNRc1VYL09oczJBaEhQN1B3UmdlRXhJ?=
 =?utf-8?B?MnhpMG9iSGsxUlluQTk4Tm5EelpHd0hqL29wV3YySkJ1YVRUUDRaNkRxNEZ0?=
 =?utf-8?B?NTJsNTdwT0d0Y3Jad3ZSNTgyOTNoOUxXVUNjbGZleXRCWDhkUWJHd1BWZkUy?=
 =?utf-8?B?Ly9Tbk9QaTdFVFlOKzBoNDZrajMyejZMUndyeVNLZC9nNkp6VWt6aU83ZUpR?=
 =?utf-8?B?czdUZTNmMHRDbzZGaDMwWmF4RkZESTk5ekdaRlZUeXg3V2R4Y3JnenUyMjJ1?=
 =?utf-8?B?UlFqcnZWSmZJNHIzK0Y2SmRlVVRVVXBoUmdiM0VoSVVmbU5kRlM3M1pUM2JE?=
 =?utf-8?B?ZzgwSzcxTU1CNkFIZ1c5N1ZYRmNTRDFVQ0tZaExwL0Y0RklGNG1hZGhqVjl2?=
 =?utf-8?B?dC9Ub0VpSkpkaTFOcDBxU1dIRkJmOVZIbjliWlRzV3NmWUs2TzJHSjBSVkFk?=
 =?utf-8?B?aVlQbVFpZmhjZTFLdjBqN3pDTUREaS81QjhOcFFuM3YvcXVLMTg5SWQrMWgr?=
 =?utf-8?B?T3ZQbklrQktwT3pRQmlRdXFuSFlwTkc3emhqNnlzbUk4b3g4dEF0TW5oQy85?=
 =?utf-8?B?Y1VaOStGVGlvVUpFQ1FFTUlYR2RNVlBIZTAyczRsWHVteEprejc0dEdCVDNW?=
 =?utf-8?B?TlhWbVdiV0NjSDBnaitZYUpKUkdQQ0lReG9SSnNxYzA4amE0VHJzTDczR1RB?=
 =?utf-8?B?cFBCVk56OHd6WURyZ2ZQdVBvWm45ZnpmVy8zbHJKYTVjQjFWQW5HWDBPeTMz?=
 =?utf-8?B?OUIzeXk2allrWDg0bVNoM3NEN0tFM0loRkl4czJtTlp3U29IVzY1WWw3MzNO?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9c8e87-bdfa-4744-e0f4-08db8147b853
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:15:24.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2MGT5aJuGPh2kcl1icQ7LADhaqWgHRVkm1FFwH20mmpx0IMlHGeGHD+gB4/l1Obl45GTwrLznC5oSiYqSklb4ja759vaIleHC3+lKlF3us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 6 Jul 2023 10:06:29 -0700

> On Thu, Jul 6, 2023 at 9:46 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Alexander Duyck <alexander.duyck@gmail.com>
>> Date: Thu, 6 Jul 2023 07:47:03 -0700
>>
>>> On Wed, Jul 5, 2023 at 8:57 AM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
> 
> [...]
> 
>>>> @@ -1431,15 +1303,18 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
>>>>                 else
>>>>                         skb = iavf_build_skb(rx_ring, rx_buffer, size);
>>>>
>>>> +               iavf_put_rx_buffer(rx_ring, rx_buffer);
>>>> +
>>>
>>> This should stay below where it was.
>>
>> Wait-wait-wait.
>>
>> if (!skb) break breaks the loop. put_rx_buffer() unmaps the page.
>> So in order to do the first, you need to do the second to avoid leaks.
>> Or you meant "why unmapping and freeing if we fail, just leave it in
>> place"? To make it easier to switch to Page Pool.
> 
> Specifically you don't want to be unmapping and freeing this page
> until after the !skb check. The problem is if skb is NULL the skb
> allocation failed and so processing of Rx is meant to stop in place
> without removing the page. It is where we will resume on the next pass
> assuming memory has been freed that can then be used. The problem is
> the skb allocation, not the page. We used to do the skb allocation
> before we would acquire the buffer, but with XDP there are cases where
> we aren't supposed to allocate it so it got moved to after which
> causes this confusion.
> 
>>>
>>>>                 /* exit if we failed to retrieve a buffer */
>>>>                 if (!skb) {
>>>>                         rx_ring->rx_stats.alloc_buff_failed++;
>>>> -                       if (rx_buffer && size)
>>>> -                               rx_buffer->pagecnt_bias++;
>>>> +                       __free_pages(rx_buffer->page,
>>>> +                                    iavf_rx_pg_order(rx_ring));
>>>> +                       rx_buffer->page = NULL;
>>>>                         break;
>>>>                 }
>>>
>>> This code was undoing the iavf_get_rx_buffer decrement of pagecnt_bias
>>> and then bailing since we have halted forward progress due to an skb
>>> allocation failure. As such we should just be removing the if
>>> statement and the increment of pagecnt_bias.
> 
> The key bit here is the allocation failure is the reason why we halted
> processing. So the page contains valid data and should not be freed.
> We just need to leave it in place and wait for an allocation to
> succeed and then we can resume processing.

Aaah, okay, you want to try once again with the same buffer next time.
I see. Makes sense!

> 
>>>
>>>>
>>>> -               iavf_put_rx_buffer(rx_ring, rx_buffer);
>>>> +               rx_buffer->page = NULL;
>>>>                 cleaned_count++;
>>>>
>>>>                 if (iavf_is_non_eop(rx_ring, rx_desc, skb))
>>>
>>> If iavf_put_rx_buffer just does the unmap and assignment of NULL then
>>> it could just be left here as is.
>>
>> I guess those two are tied with the one above.
> 
> Yeah, the iavf_put_rx_buffer should be left  down here.
Thanks,
Olek
