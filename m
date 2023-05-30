Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0498B7170E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjE3Wpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjE3Wpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:45:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94345E5;
        Tue, 30 May 2023 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685486734; x=1717022734;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=X8SzJddpHLQ0tlZHlXqTOzwA8CmOY8LK/Om9RCYg+Sk=;
  b=goLIxUU7Xz+29CyL8VcjhHaE2j7s9QDtHMivVLGSUvDVZ5R8hbc/86Dw
   uakbL1frq9Rug2oi3+yOKGcIOafcZKJQD+pRiDkM59Jm+wuoVMDQk9ty7
   ytYBiwFrgkFCpDZ6xvxz0PkIeFvRVFWwCklhpsLoyuYiqIDLUKflxxMPc
   TcknENtxpsCPltOKFIphg0NvSKURPlAI824k6ANkBPfnblp7AI3Ga2ZP0
   KsGaCEG/vknm2feChi3FQz6JiQT1L9smaIzAHnQBjEyLvGdusihOCp9qI
   MldhCzh2DmvhG3ywtuQ47M/HiXcGDCJXi/ECzO7RGc3TrjFOeOAjhp7As
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="334685806"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="334685806"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 15:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036780141"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="1036780141"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 30 May 2023 15:45:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 15:45:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 15:45:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 15:45:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 15:45:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkOujx25zXodyPsTKXdZe5s3MTmdOQVPUNjgA1ht3fEIis0W+XvMuMNwhwmEXJ9VnrAffflNyOYqpEX0xLD0wmND/6wCHtUQC/EIe8UE+h5lkHtojndLIzHKsZM2PmJbDw7EIf6zBJvHEq2ATT9aXMpFjSi0nV3IiBYUc9YSJ79jeXa0CNTxv2KJUKEmiTaZ5yE5AxLZ06jYiQiDWv1FfsytqvLNWc35IZrVCDNAn/ykKWKAFwoCOuN+o/4pmVuiaM5fx9bT6y+b9fNIYTYW56ZEkRECCxscOGKaitjYkhkZT1qdQjBc9AoDQaPfUI+M9ATt+LLf7AsPVOK4vyqezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJmoz6LvPpqmnwHSei4VNS1SWHIfqsi5Gno1M2/lTUQ=;
 b=XkW3ffiO/bjZDO/sBe9SRlZ9BuT2rZHBXEJg5VYZBYHqjgNhfiyn5syc4enBmJVssy9CRu4XQRMT5pNpQeN4/MM1mv5GkTZrq2M+B501CzQh++oqGOuvrAxsLq5FT8YW5xz4EauBl0p08gMYm1u9IWVn8huyH4Erj6wqQfulJSaJ5cf1T14YoBTM6z8W8OzFV1Kwq5+yB40leAAsmzLoVCP+Llm1AnHOPDg4ZEs0bFBLEV2FYlgqD/vmGKcoFS/EZBRAkIjBneAXozaAeoeZfJ4OTvX+oIt6ZYc8N/Hotwbd/5YHA1E0R3Gu6G9WUrdt/a+3yqWML/tq0qzbyaqw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5110.namprd11.prod.outlook.com (2603:10b6:510:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 22:45:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 22:45:27 +0000
Date:   Tue, 30 May 2023 15:45:23 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <song@kernel.org>,
        <lucas.de.marchi@gmail.com>, <christophe.leroy@csgroup.eu>,
        <peterz@infradead.org>, <rppt@kernel.org>, <dave@stgolabs.net>,
        <willy@infradead.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <dave.hansen@linux.intel.com>, <colin.i.king@gmail.com>,
        <jim.cromie@gmail.com>, <catalin.marinas@arm.com>,
        <jbaron@akamai.com>, <rick.p.edgecombe@intel.com>,
        <yujie.liu@intel.com>, <david@redhat.com>, <tglx@linutronix.de>,
        <hch@lst.de>, <patches@lists.linux.dev>,
        <linux-modules@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <prarit@redhat.com>, <lennart@poettering.net>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <64767c83b8999_1c5f6294f9@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org>
 <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efd6183-cd21-4390-0d7b-08db615f9001
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVrllrl3ngjrNo5+bfdLaQKTPtOSecI9PYiqjoHdseKT9EuSOe6cSYEfrA1ikox3DFBJezhhU+cI0z/TIAm8vUrC7XrpsXlY4Qc5+q6Fv6SL16bLY2BRpEXxcE+dD9AK7LW7gBhKYRoZCfMx9+p4E2yaAi2mV3Bx/JA1wjXM0AyWdJR33wDYXzQfL2Cf2Io3QNuO7o3s5Q3dRKINv3fr7Gat+JPG8dL6ie7EdT5kvtRz19gjgZWHLluLDOTYcMBr4UwzB7pvx3ZilTACbCXQqDYFHw+h2sG6PjKNnCb3LG9De2OIps6nn/UEg7TJeuwNX530leHfyrrsD77qKUD39Eo3AOshyrZLycedh9ISFFLNEirzrGtf409V8LWLFloK4DSXoPyI2M4kiYSuzsLGbmsCgJjHZVhKiiKkKr5ovxnkzOiKo6PQj60Bl3vacxjgzSMV7HbmMFN1r20vosYjIh8MmzvvvDONv8G/vOnrQqVyvjeBLCXDPRuKgnzh70sXWoQyPCalkZcbqvJFuw2Iv4OqMLbJyER+SJ09HDx/q1XTsahkIxU76GwYBcNOODkH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(2906002)(186003)(26005)(6512007)(53546011)(9686003)(6506007)(5660300002)(54906003)(8676002)(8936002)(82960400001)(38100700002)(110136005)(83380400001)(86362001)(41300700001)(6486002)(316002)(4326008)(66476007)(6666004)(66556008)(7406005)(66946007)(7416002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWhJR0NzdzgwWDJWaS9nUlBpS3o0czM4ZlVITUl6a3NoVTlaZGx0SFZlTDZa?=
 =?utf-8?B?V2U1M2tUZlFiWkJwWnNicjJ6RGJ2TlN4VndqRTBHQi8vL3BvZlQ1c2VOdklN?=
 =?utf-8?B?amI5QldNTHZuOU1lc0ZvUHBiVkNScmhYU3BzYzVuTm50MUt6MVU5dGltbGhu?=
 =?utf-8?B?UVR1Vm9Ub0E0VXdFc2xjTWdJWVBPamhBQXVvZFJuUitGQVQ5K1czQjM5U3Rx?=
 =?utf-8?B?TDBDNUFya0FwVHQ3dHRvYys2UDNPTjhxdDFYR29oSFpmOUFiY0R6aVZ6bGJF?=
 =?utf-8?B?UzYvNk1qRm5XTG5rcVJib21LQ2pCNGRaUUVoZkUvbVJLRWMybFQ5bEhwWHdM?=
 =?utf-8?B?c2krdlJhclB5WEcvcnl6ekpxMXI4MUxDSTRKWVc2U056ckxkM2JRMU5ZdTRL?=
 =?utf-8?B?TXBlQmJncnhpMnBoTnZsWHQ4bnRNYVZJRExmeFlucGdTQ1ZiMC8xWGFYekJ2?=
 =?utf-8?B?YkcxZExCZXJPNkJ1aFloaVRIL1RScXlOamlmTVFuLzdQQSsyYVNsWjRPZkVa?=
 =?utf-8?B?ZUZRa1NaeDJDK3NaaFBrSWh5UytnUGZqMGtRUk85NEp2VmxzSUhQbnBRMmZW?=
 =?utf-8?B?ODFuRXBQTTJOZmxiTTkvdUFtZjlhdHRJS1JVVEF3WGdQcVUzeUtVVjlrR254?=
 =?utf-8?B?TmFKZFZxL2ZadFBURFAzVUUxWVc0a20zdWY4MFVRZjlPSmx6K3ZiRHpZd0JZ?=
 =?utf-8?B?blMyVFlLbXlvMDlLcXVjdERZd29WWW9hVVJCRVpadDlKeWs3cC84RDA2TVRw?=
 =?utf-8?B?NmdldUVJbjFZSXRmWmxRa2s3MDcyZzA4TElvQy9MeGthSDBnbjRSSEU3UzF3?=
 =?utf-8?B?MGM3Qkx4Y1dtNERYWkhkNENTZUc2Ly9pREYwMmQrY3RpUnRLTlQxekhqVjA4?=
 =?utf-8?B?RWNSOTJFSEo1TTNZOHg5SC9mcHRrcDQrMEdzY2Zpd0oxeUYwMHExY05nY0Y5?=
 =?utf-8?B?RGNmdEljS25mVUp0YzYxVzdFZWsxSGorVkwrNENWYjMvSGNLbE9sV2lPVkU2?=
 =?utf-8?B?Z3lmWGl4U1dpNTNQaEdPS1dOc0ovY252cUFKTStlVDNLL2xwZ29jMHBCVkpi?=
 =?utf-8?B?Y2dIT2svdi85V0hMdmNYUGo3K0FwU0Yya1pQQ2YxUmtpQmVqYUpZTmRlSEJa?=
 =?utf-8?B?WjBGK1owVk9KdEVzeDdwb3lUT0xmZjlGOVprT3BMdmIyTmk0NzZYSlVReUFD?=
 =?utf-8?B?MXRjNXJ2MFdFRVNNUDVaaVpVMGNqdXJqVTB3N3BwVFhjWUVEekMvVkFPT0gz?=
 =?utf-8?B?SG1ETHZnT2RNYS85Tnkwc2hibmhPYVAyTUxxUFpyL0lreGxoMGZFSmIrK2dR?=
 =?utf-8?B?TE5iRm92ZlRqR3p5OEhzTFBEK1dUeXRYb1ZtZ2lpUk53Z3dPYzM3NUJ3MVJW?=
 =?utf-8?B?UGxmaDlSVWJia0xreEd2YnI2U0JvSnRPM3dVbkdTcW95TUtlMmY0ZzM2SUxr?=
 =?utf-8?B?MW5NMDhRR3Q3d3BMV2Q1dFIxTVRNRWwwR3dJeHVFRGZ1b0ZqTzhSUk9RRU9C?=
 =?utf-8?B?REJKMHFzSTloNHBMcnZ4NnREL2w2ZEU5ZGxiWi80aDVydmVKdkVtTmpValhi?=
 =?utf-8?B?amJ3cXV0ZGg2cUVGYk9paldJTjRhYkR1M0tJSTErSjFadkR1R0hVVExNMDVv?=
 =?utf-8?B?cDc3bXRmcFJsWTlhR3A0Q3NqR00xVWFCVm1RZTJGblBvZHUzVjMxQXcxTGR6?=
 =?utf-8?B?VFZMd1RmOGhQczNWeWxNTjYwY3UxNHlBV2QwcEhyQTJneEFkUWJkQlNZNHc4?=
 =?utf-8?B?eElpb25XWlZXVW40aE8rL3ZBa1U1UlErRXhmZ29GZGhZdkN4MUJENDFYYzVS?=
 =?utf-8?B?ZkpVeElvMUJ3dk5Cazk5eEpseGllQTVQSTZOdS9QU0xZM2dWWDQxN3lrSlJY?=
 =?utf-8?B?dkQwUUZmODNURm11bVpMNXBTenM0ejlnQW1TWHY0THdabGE4Z3ZYTEpHSy9O?=
 =?utf-8?B?dVlURFVsRkdwYTRQQWlTME44VWFpODRCckowREJWTlpycndZTXh2QVN5QlpG?=
 =?utf-8?B?RCszUU5nV2NteitTUTdFMXBxdkcvRVZjM3NyTVZmclY5UWlvUUlxN0drY3pX?=
 =?utf-8?B?U2FyQTc4di9KVkR1TmxYWlBrQVB4QzVKMVUyM0pSZ3FuVER3NytPUVBHcDF1?=
 =?utf-8?B?NW1VN0p2WWxPa1lhRFpEaHNwUWtxY3Y3Y1NHT0s0ckIvQjlFSm9uZU5CUW55?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efd6183-cd21-4390-0d7b-08db615f9001
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:45:27.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfAdVAyMJCJr+5mQc1xyb3hjCJp2bEVnZMsipS2xvvKQedTnWXMmKFtxZWdfm4YNi/ENxYV+7PlH6MpJlFk/pOzxi7wFb9JBJ+nH/UkyMT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5110
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, May 29, 2023 at 11:18 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > I took a closer look at some of the modules that failed to load and
> > noticed a pattern in that they have dependencies that are needed by more
> > than one device.
> 
> Ok, this is a "maybe something like this" RFC series of two patches -
> one trivial one to re-organize things a bit so that we can then do the
> real one which uses a filter based on the inode pointer to return an
> "idempotent return value" for module loads that share the same inode.
> 
> It's entirely untested, and since I'm on the road I'm going to not
> really be able to test it. It compiles for me, and the code looks
> fairly straightforward, but it's probably buggy.

At least for me, these 2 patches, plus Johan's spinlock fixup, are:

Tested-by: Dan Williams <dan.j.williams@intel.com>

...on the test that was previously broken on plain v6.4-rc4. I have
these cherry picked on top of v6.4-rc4:

 Revert "module: error out early on concurrent load of the same module file"
 module: split up 'finit_module()' into init_module_from_file() helper
 modules: catch concurrent module loads, take two
