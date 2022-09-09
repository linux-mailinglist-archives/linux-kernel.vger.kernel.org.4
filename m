Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A555E5B3BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiIIPRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiIIPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:17:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B7146708
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662736633; x=1694272633;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2JJq2/UqEt9LBdSoYnGsRmInCJSHjHz6Qnbu0Dn69x4=;
  b=nYJmb3f5o7+iEcZ2brtY2fpxfi00emDeMS8Q/xdDqy+Zj4avQQwGu0H7
   RN7ET20EyRyIZwJ1PmLhSncD5z0zXYgujnKsW2k1aIBSROVu7D+UPuSo8
   KsGV3xg5rTKUj2qs1eY90khhnGtyyfh6fZM3r5uug92nkaseg593ZtR7H
   XHwPvrqQ9/G0V5L+vwCpn7f16dPFyjiMnAXtULnB8tUC+RNv0P68dNsss
   3yLU7qC3lG7cU3bSWceVuc/JGCiCzOIXdgEQi7/y+Zh5TBzFXrqorm/t4
   F/VNthX1IDIepVcQRpWraLEBHfZWNA/9IsT/Hr++OFjpfLkbXaE692aZ7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="323707657"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="323707657"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="704433317"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Sep 2022 08:17:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 08:17:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 08:17:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 08:17:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 08:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLJVps5F8y/lENhM3u/nm5cQX++N8GNPvxjLf9Ev41sIxM3LjGsLVGygMzKLO4QgkQsmULs2P8ZWfC4ldaNCT70F08v7Sl+v/1EzNTQx3IQhZQKigEtAGZ+oAmYWZer/ZwNyceIZFwvOf3Yz/G6dhrcas/0nfAHy4GGSGjaDNieefV4c6UXKQMm319EITWbMxCtgJvQAESvVyIcljyXMPAk71LactDQ8GCHX8Io01Mws5pFw592PQ+XndaS5LtcOPS+UGzHh82HdyeyFeSY4ZewfK366NzO/GftuBDAQCwY0L2mdITFkyqN8dIlEESxHQ5IkWltiZtVidPaBh8pZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E1BfV//EeYnMzrwI8IRUg7LkbvmIIidR/fme4/7COA=;
 b=LH3NKtuhfwyjPKnuQwP8+eQkt7TwtD8TzeVBN1noaVPIDv4brl5JQ5m6L03QnCsnwBcqIG6XdqnQRPkMX8AB929YAW7yFMwm4NM8iTxppcKNQWTOxPKPbN6sJ3xsU8bdIaGF9VATsC5MEzTVhu4nbvba3IgbCIgBatM/LvDjmOjelDEf+LUVFphxJQsEX7NL0HwcPP9zOLHdS6YPU31AoG6/X9QovoC6U222drBgROst9f24LUZBGJlDgeNQC/n3DI4XSsOwIxheKsE07IHKI9waX2ClvDbe4skJ6zQaeqePCBfv1HLf01f3NiBHITsvc/ls3VlJCvYURT/zKE20EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 15:17:09 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 15:17:09 +0000
Message-ID: <b959d485-5986-4524-8a84-6086f1076cc5@intel.com>
Date:   Fri, 9 Sep 2022 08:17:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v7 00/15] GSC support for XeHP SDV and DG2
Content-Language: en-US
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        "David Airlie" <airlied@linux.ie>
CC:     Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <YxDLFWjIllqqh9de@kroah.com>
 <166271909777.4265.10724483511179344068@jlahtine-mobl.ger.corp.intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <166271909777.4265.10724483511179344068@jlahtine-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:a03:167::35) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5488:EE_|SJ0PR11MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f96c27-7dbc-4975-24f9-08da92765cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vH3vO0JMrR2ZfHegUZj/jWpwXJHWaBPR976/FkWxInSd6tdBUfXhWNJD21877ejcQM3WGSM3tKHMKYtENpEtJbkk4WA4+tA9d2Rx8M+dTm+rI4VyXXOjvCmhOFdYopWd2suHAEhqqzWV77a8F9yOTtMf7d+g20sk6TZx7SU+pY5lAyLyaGsjIqCuNxBOk1kpGjuFgCg0DHOh0JO2S5bLb88ToS6JdiXyKFQvYoPFqnWKCM8YP3XCUO6dIEx9A557Wlo4RqIBDfAgi0PZMRx0u7iqwMVDFgO6QI9K3h7qNwQkeFAOMAkKCZp+C5KYqOupF4uE82DgWDx8xwZfW6TACw/7ZdYGUsfTVbAEsXez971ZKjomgXOhayBmGfW2g1K4ObISGP8xrwnaBNmyuAsMbJBgr4YxYFGQRbg65tTmpRUl2HTTYnhVuFn623Zl6QJRydl2eFGrdJYZtpO7DG1cwP2lVr2qOtHEfZVaxFAHUdYwzIhsj16O+4wwf+nCemkmin4tWqHvYvj6KW9RCcgX74d06PkfZ/1y6U7WjFga3TghvUhJieHqzLsIvMv4jVR5fZS015pGFqAluMJp0Bbq0hjxf0RRP9YXnAlR4m4Ys+hzMa1zZnChRnhtKKfw2P3iILxvSV6ehRfsyehgdiVhXFr+T9H01FJFCyQ5pYTijaessSfCDvyf5rRiq82ZlCa+5s8ma9vr2eVppCxvPD4p+68Iq/z6Ey+QOjKMnGKYrW6UpvIFRTsrrNtB3+1hbbf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(376002)(396003)(366004)(6486002)(2616005)(186003)(966005)(41300700001)(36756003)(31686004)(478600001)(2906002)(5660300002)(66556008)(8676002)(82960400001)(8936002)(66476007)(86362001)(31696002)(66946007)(83380400001)(26005)(4326008)(6506007)(6666004)(6512007)(38100700002)(110136005)(54906003)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHA1Z3EySitRMUFBREtPcWxKRjNlN242d3NWbFBjVGUxaUVnTUU1U1FEWnBk?=
 =?utf-8?B?OXFxekRIQzhRSnRwNUhVMHZpV1RSYTZ3VllCNXlqblZpTkRDbWlFejdlakdr?=
 =?utf-8?B?Q09KVU5NR1ppeWo3YTlXakQxVVRiYkVYeWRCQlZFamtvTjUyT2ZGTTkrUC9C?=
 =?utf-8?B?alJHbWIvVUdYTXBhbkNZWlI2WDFIN0lUeWJJMDZHWStPUytPVjIxZjhmMnE2?=
 =?utf-8?B?YXlOVm0zYnN3K3NWcnVNYUJRQkRXYnlBUmlWWGh4aDdtWjhlcmVIS1lNRUoz?=
 =?utf-8?B?TkRDMWFzajV2dlF6VDkrdllEUlpWRWRzZWtnSnNEU3J5NmRucHJET29scGto?=
 =?utf-8?B?M2xTZjR4U2M1a3ZybTBNVGxqRnhxb2t1ZC9EVGF6TCtEb3BUMjZMN3dUdWFz?=
 =?utf-8?B?NUtReHJ1Q2JPSk5YQjhDSnlCOVBHODJMbTI0ZXNQcitFc1FvSDl5cDhUY2xy?=
 =?utf-8?B?VDR0N01jMHJocG4vUVpxamlPZ1pkQit5TkMwZW1pbDBxNmV6ekFJZU4xUkZn?=
 =?utf-8?B?M09NL0xKQkcrbkMxQWROalNuM055WFFVZ1FmdDl6WVdNWUo1VlJiZ1NleXBo?=
 =?utf-8?B?dWs3ZDhvL3QzWE1uOXhiejZCeGtXNHBZZ2xtQVh0U0k2RWN3dTc1bk82a1BK?=
 =?utf-8?B?OC9lTmhJdXVNTW03d09USGQ3ZHRXaVpWRE02TE1wa1VSUUZmZU05aEkwVll1?=
 =?utf-8?B?Unp3a2NhRFBsbUZlVVRYUlFCMHJrdjNPcGVFUE5zem1oWUMxaXk5dzBFN0xa?=
 =?utf-8?B?Wml4YVIrZTM0aURYWVJOTC9CdER1YVYzeEdPSzR0UURYSnl6V1dhK2NabkZx?=
 =?utf-8?B?U3UzYzg0TUxPd2s5cnczRkhCOGRDam92R0paKzZ0b2V3aWVpR0hBTWVUZ0c1?=
 =?utf-8?B?UjNHa0Y4WEVmdmVtRjlVTFM1UXlLM1VvdTNaUGl6U0lPR2VFMVBKb291V0ZN?=
 =?utf-8?B?eUtMMUJ4RWtmNnRFREl0ZnB3eUxrbUtEMWlMMk9ra0lxSE9LN3hjamVKRnZD?=
 =?utf-8?B?SkZCdVp6a2h3N2FNY1ZkRktNUW5uenJDVHRKRitQazhtdHVFeUtmTGNGRGVl?=
 =?utf-8?B?WjlhOUt6MnE2c0s5UjdoQzNOZFI3WThnUnc2R3JTc09QSHdVelVWbTVsK3lp?=
 =?utf-8?B?UEhyeWo3QXhOVmNmZkdGeTlvaDdFWXZzcGtzUGZEdisvTG1Ub1RnVFFpTTlS?=
 =?utf-8?B?MHFzQ2MySkkwQS9wc1dqUUlsblZteDFCRE5rMWVFTy96QmkrcGhMUnQ0WDFk?=
 =?utf-8?B?UzJ3L2ovU1FUR1dyUDdIbHRGT3NYaGsvbnhsaFdCOFN5MHJaUlJacERkUFRw?=
 =?utf-8?B?ZCtWZ3BGMUZiNlMxT2RPYXI1dFJ5N3JobEhzUWdIMFgvNTRMTVVqaDkvK0Rm?=
 =?utf-8?B?Uk9XcjlSeFVYL3Z4MVJkS2FXSzVMc3VrbHB2bWZvbk5aV3BtRkc5Q2pyMHQw?=
 =?utf-8?B?TFh5MU9uRVFjdUJlcDVLenpUYkR2SVZQVVMxejQxYnJ3cjhvbTlzTGpraVlS?=
 =?utf-8?B?K3ZvU1VFWEJEMlFHbVV0N095dWowRUhBQXFXQm8yN05QbzMyM1FzcFZhaGRu?=
 =?utf-8?B?aFdKRUhCa1VOWUZNUTVXMHJWckFxVVQrZjdxSW5iMnowWTVweFV1bmxqeFNJ?=
 =?utf-8?B?bkQxQzJFaFZTdHh5a29uRUdvbmcydjlUVktEdVlUZmZWK0pTdVFHYU1qNURQ?=
 =?utf-8?B?U3hhNnlDakpTNjdGUlFNaHVoVXhWRWF3dGJQRkUzZjF6dFlxbEE4V0dUOUI5?=
 =?utf-8?B?QVcrcTdWM1JZdFRucFBOMGVDRTVEUGtFTEs5Z2kybzJUWWdTLzVzdFQyT3FO?=
 =?utf-8?B?eTdHWFhjZW1NZW5LZUY3VDBtQTA0MG0yZDlDNVJUQ2VuL2lKVkN3VFFUVTAz?=
 =?utf-8?B?dEJMWS9zSHh0enJic3ZHOXB6OG9GKzh4Y2UwaTc4c1p2RGZvUEYvVDZaZXRn?=
 =?utf-8?B?VGN1clMwQWR5SmN4QWpGMzBOdXdLVWlGV1JranRObEJsZThkTHdPYjBaVEd5?=
 =?utf-8?B?akcwNENhRmdZZDYyODQrcjVJREI4RTU0RXc0VWxmeVYvbitzWU9VT094LzJD?=
 =?utf-8?B?aEIreHVKaFRLZ3hjL2kycDc5c3VqV24wWXhBYTZ1alhUUlpJSXd3allBWDFX?=
 =?utf-8?B?c3JHcjlXNjhpSFN4Y2xCNnBsNzFlbld6TWE0V0NEY3R1ZXJ5clNGdVRUNDlr?=
 =?utf-8?Q?vF9oPcwgomxdzDKZzeD3X+A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f96c27-7dbc-4975-24f9-08da92765cd1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:17:08.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iOwDy2iRXHr8KVyYePtwxrL/nu8UcxaGqsLufnF7xzsQzCWxeuPHzwHTmiG3IQj1mDZjNHJ93YrniPHYeLIuncVVNX2uSV+SadI9ITcraw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/2022 3:24 AM, Joonas Lahtinen wrote:
> Dave, do you have a preference how to deal with the mishap here, shall I do a
> force-push to drm-intel-gt-next to correctly record the Acked-by or revert and
> re-push? Or just leave it as is?
>
> Quoting Greg Kroah-Hartman (2022-09-01 18:09:09)
>> On Sat, Aug 06, 2022 at 03:26:21PM +0300, Tomas Winkler wrote:
>>> Add GSC support for XeHP SDV and DG2 platforms.
>>>
>>> The series includes changes for the mei driver:
>>> - add ability to use polling instead of interrupts
>>> - add ability to use extended timeouts
>>> - setup extended operational memory for GSC
>>>
>>> The series includes changes for the i915 driver:
>>> - allocate extended operational memory for GSC
>>> - GSC on XeHP SDV offsets and definitions
>>>
>>> This patch set should be merged via gfx tree as
>>> the auxiliary device belongs there.
>>> Greg, your ACK is required for the drives/misc/mei code base,
>>> please review the patches.
>> With the exception that you all don't know what year it is:
>>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Daniele, why were the patches applied without this A-b?

Apologies, I usually rely on dim to pick up all the correct r-bs and 
acks from the ML and to warn me if something is missing, and I didn't 
realize that it hadn't automagically picked up the ack.

>
> I'm just preparing the drm-intel-gt-next pull request and now it appears
> like we're pushing a lot of commits outside of drm without any Acks.
>
> Please reach out to the maintainers *before* pushing code for other
> subsystems. Unless you get an explicit ack to do so, do not push such
> code.

I'm assuming you mean the i915 maintainers here, given that there is an 
ack from Greg in this email? Rodrigo was in the loop of us needing to 
merge this via drm, so I thought I was good on that side. I'll make sure 
to have an explicit ack on the ML next time (which is coming relatively 
soon, because there are some more mei patches in the DG2 HuC series).

>
> Quoting from the committer guidelines[1] the first rule is:
> "Only push patches changing drivers/gpu/drm/i915."
>
> In those cases, please ping a maintainer and don't rush things.

Will do. And apologies again for the mistake.

Daniele

> Regards, Joonas
>
> [1] https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-intel.html#high-level-guidelines
>

