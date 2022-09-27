Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42245ECB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiI0Rtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiI0RtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:49:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB1CA4066
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:47:05 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RB00Ts031015
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:47:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=cAZSYxxs8e98j/+HjVQ215PCaArBb9917JuSnlsJxDY=;
 b=hU+ur7+Dau9+3zzK5O9KANynKnMxFX6KJ2aio9gww63hyYqpWJdgokPGYEkWfY+ukEY3
 dn+3WqzNHttLqMi7+23YkVtdPRKFe+fpvYbB/u9E8XdNkTFerN67oLQDdqkqL/bUwUUO
 0beaIWd2IzY7ztdP6FdNDvJcP+oTn4w7v8M= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jt174w0c0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:47:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcJA7/mnUjJ9eV9ndt+aJwbCwe3mOBdmZnMypfaIqPdbkczIAs79Wc4IOHKuhLln9uYrdWJPUvP/NHbECbaEG5Y2aFac5Op7D/ecOx0L83SWPDSrnpIa18whh+2rMslDw0q9GiLgnRLebS481RdmxhqGMFgD64v1N9vWb8Nl1C4xeo00zq8WZo8QxG32wGsSZFadZ9Ct9XbPm4RGXLfH44f3oQ/TlcZKc8CgB+paRhEg4zXKVqy+j16Ql+9+NTsxWD57D5z8YUq0a+tAGAIzNeIXV1qVF3mkL3ORdEHpQ5+ouPsxZoowdPcYVqnEOxFbC085voU2FqWsXfsxmjOnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAZSYxxs8e98j/+HjVQ215PCaArBb9917JuSnlsJxDY=;
 b=Qlt01ykUVgSuYimUre43oQ68XYXIBIFC4d/UGu7bM0sdsAo/lBDfkosyHCN3JQhZO6hUKpevygrwMBE6XC1OPjEc2S6u/5Sn1e3ScrVetTWZC38809hFdFlLg8PxmBMs14IDqVbLBYzURggVE2+7zSXT+EOTddnFeeFLKIlrQKoYRWjJB0e3LsBYoqEEQpj3NBJZX4v0Ul9AeO6y+xWVYVxTlXzfNBV7xpSf46ohANvH0yjICMD+aKQr2xoV3c6HRMjWXSeGkqZ9VKHoJfKq3C2jzgxHY4kLSzSEvFzDAJoo2gGmWYfBlj8QWFNl6Hg3kWaCWvJH9O8Ym0yyfXt0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW3PR15MB3785.namprd15.prod.outlook.com (2603:10b6:303:44::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 17:47:02 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 17:47:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] ftrace: fix recursive locking direct_mutex in
 ftrace_modify_direct_caller
Thread-Topic: [PATCH v2] ftrace: fix recursive locking direct_mutex in
 ftrace_modify_direct_caller
Thread-Index: AQHY0goDGNOLOiIK50aE+DU+VCcVca3zehgAgAAUH4A=
Date:   Tue, 27 Sep 2022 17:47:02 +0000
Message-ID: <A3E35DD7-5270-49FF-AAEB-C7504B5EF22E@fb.com>
References: <20220927004146.1215303-1-song@kernel.org>
 <20220927123500.76b07f73@gandalf.local.home>
In-Reply-To: <20220927123500.76b07f73@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW3PR15MB3785:EE_
x-ms-office365-filtering-correlation-id: 8fb680ee-206b-43a4-0ad5-08daa0b048ed
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVW96ctowtoG/JIdgjhrYdfCIJncht9SdMX+Bp4MDluLV8YJya4abw4oPf6fglcLatR9YkYviMhs70Up/mEgujVmGRFy0jj7Yj7sJqBvYFaaX/KvvbcyWqOBzcJdwz+B2QMDFlRNOpm4S3g6CerV9VC0V2/0fO7WEkT8KTT4lPs1EFIYu2EpZqRabXrA8Td2QRCvqUCaywWoZVv6OMzlxf5OM1OjNVhbDnhVsHHXiRcgCy3RQw6LenmMMnGERyZAc4HA6YXfDqBRmRC7Xzhw95AkBbLQJEIhAF6EsFdlC2AAMW+7pSm/bAOT8bBGT+1iUafOPdrFhXTwiVaTSZV9njHjx5LVfRWYb/pExzqk87YDIHsGoKm/vFx7zRhlzzV2NQlVowpmQBv9+P9T9bzM/qhio73OO57jg3uHAFDuBS2wPjunx7Q5zZQRcXOsYXm08Lu2I2U4OK5g2eZM6I5D2278IsFUFaIDt4+KSLIdyiTPqqc3WOGiarYSw7hcLPJBojgslKoc8aD4ocip46WNmFIkJWWJ6ahVUn16d9Po2Rq5pkrk/IC9FY3zGqnpMhpLvtW5tAzcNCZURKzBbGB3lk7avobLFYRcVE6KydZp3O7x4Qj7PxHODE9qNf98nSnZrLhwoBAa3zmRyz8HN1DhWHdxZmT8oTdFrJt0v1khxfPZs20yQ3V7AXYuKzoxrgP2TH6c+cCo4u+VNThCVEOF3B94AV47fZLxSprsebocdrYCEcfAHyKTRwJ49KpYI08PNN8QK3fKQj8KtH7ZUnG2NNlvpP/MYsEvXQjSSkSF2+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(186003)(83380400001)(54906003)(38070700005)(6916009)(316002)(8936002)(91956017)(86362001)(64756008)(66446008)(66476007)(66556008)(41300700001)(8676002)(4326008)(6512007)(478600001)(2616005)(122000001)(36756003)(2906002)(6486002)(71200400001)(6506007)(38100700002)(76116006)(66946007)(33656002)(53546011)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P4/f3XDai1jq4k20tex1iVs+2oH3tB17VEd1Pz8fq93GPaea3DPudeTDaLrW?=
 =?us-ascii?Q?k0wyVOYDmwM5mX7CQBkkbugpSX501SqXQd2l+9hY9262ejmIrWjkC/71GTat?=
 =?us-ascii?Q?gfVS2KcDDJRCzC+w+bIkDlW57LM4KifJttku3ijNcSNEHgff9XgvT7aDuQng?=
 =?us-ascii?Q?lS4U34R8W5iFfjPJsRUED9Kc30hHmpDoF7AmGL6HxHVNs2wMeMB+/UncAVQv?=
 =?us-ascii?Q?9UeUeq2QFBWMO+LNgt/5wxpGClP52ZB0GVE9zuLXAmizeu6pfVJ6AZnlnBeS?=
 =?us-ascii?Q?FHXNwd1F0Er3r/3W8R4u4ygxlncHruS4Pyo9W8bSYZ49RYQlRld4Hc00UuxU?=
 =?us-ascii?Q?KewBhSFddoKj2mOAut61bFG7UhBpWfOv5xMAVII5eBwf+k1ZIaARE5g5KH9s?=
 =?us-ascii?Q?RmrXmGyrVtF1ruG6LAciyl1ZauK9RSA3tVMF+bxWiIkmHXUie6I7NavcJI+/?=
 =?us-ascii?Q?XE4fFPKNVdfSYFyl8Fgq/WzC7aXD0DOSiT3aqhZZwMMc+9nsXXl3mccR7TyJ?=
 =?us-ascii?Q?yk0AspoDw8cMCuSI+AzQjv0enIGR+6rUmXvpmKPOROtAq5s94B2NQeJBECqv?=
 =?us-ascii?Q?qzX6E0ngAaJiJXJiqG/mg7HJMhQmv9kk6psvfIk1GLmetU6Tus//wC0lrlSp?=
 =?us-ascii?Q?k7aVgAM0xmXJ2v83liRs2lqwaUjnzKim61pEGjWQbdWgX/iABDbQ5AWOS2wr?=
 =?us-ascii?Q?x6qpiNpKXwYsvT3XqcC943KzoxbewJ7fcC+sH5KklMQK+5NiDMBUkNL7gNBF?=
 =?us-ascii?Q?ElGDtfJwQX8hFIOzj66UcnlHHuOXdfQKT52J1Ie0qzZu7jRPCeNqu7PJyppf?=
 =?us-ascii?Q?jiBd0cLi8uTgfEzV0u08/UVLk+dr78FShdVat13DODJluIWxF7EZxS03qp8h?=
 =?us-ascii?Q?3lIw/1UKjhMPBEqOEHQbrWLYT49XCCiwJFgPFyR9+58BCc/+wQBLo+6fckDK?=
 =?us-ascii?Q?FVsnUaxqfiAOxYHWHVzmav/3hnJ71pKSGKgalJLCsUH5uegEOY8LRzUVrFrv?=
 =?us-ascii?Q?883LewP/C9PWnEtJ9jcYciJC+XOyrkpm7bFV3XlkvCkGKf43wrKGhskxt9NN?=
 =?us-ascii?Q?L+AXXIy1fQtViMmhqo/gWf1WpaYqptQxnFEgQd6+STrkYetxw7N9pAqQy9WF?=
 =?us-ascii?Q?sNObseXs7V1EP3MyXK+WBU+1UPUJfYvrHMmJXuUquGZ3tetD9VGw19VukvUO?=
 =?us-ascii?Q?Eez8RP4Opn+fTnsvCTADGvP9dKjFeWzpuhCiIBeloEIT1kIg3jMqw3BvI7EY?=
 =?us-ascii?Q?9gq8wRQj5970GXIbOSEifMDJEmWUnGnK83whb7oyb4HfWrCBOLGyTVQPqcEY?=
 =?us-ascii?Q?wdGWcU0+g08fy5vGftWhdSUWUQlu8icxYrvn6by7O+tEC4Q8Vrr4r9hBIuJb?=
 =?us-ascii?Q?3YbCqxa0TksbHOVP6dVhdI4GWuVrBXF1ralZPWu/R1ssaOBT61CM9JEnpt2X?=
 =?us-ascii?Q?00R/h0bO/ouZd4VcUC5SsA3PXPFq+FF2672MyMO2dy4TfBNhZetf5KNxCdAJ?=
 =?us-ascii?Q?EnNtEB9iORORwDpHE/YYJ87DOZjWBuy5kMo0NYGYYxjcfypKDd3/h8SRjSeq?=
 =?us-ascii?Q?sNgQx0eSpy5jkISPpdWNtg2rwaUO4sg0JFoRFrUz5XzIFRV12P/4owg54gEb?=
 =?us-ascii?Q?irKbUpjNNBlu70uLOgfcv/Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E68DA580468BF34789B04CD0E85CEFCC@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb680ee-206b-43a4-0ad5-08daa0b048ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 17:47:02.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kg3guk7JJJZnn9aFUcLCsn9HsPqd1TpkQuN8Qn8uDB31OLh1tjLbflSflswbLCER2vgjpPVn8w3uAa2dPXxj/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3785
X-Proofpoint-GUID: Te68EI1jD85pFjTuzgh8u0nzVCP9ry7a
X-Proofpoint-ORIG-GUID: Te68EI1jD85pFjTuzgh8u0nzVCP9ry7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_08,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

> On Sep 27, 2022, at 9:35 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
> Minor nit, just change the subject to start with a capital letter.
> 
> ftrace: Fix recursive locking direct_mutex in ftrace_modify_direct_caller
> 
> Other than that, this looks good.
> 
> Do you want to put this through your tree, or do you want me to take it?
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks for the review! Since this only touches ftrace code, please take 
it through your tree. 

Best,
Song

> 
> -- Steve
> 
> 
> On Mon, 26 Sep 2022 17:41:46 -0700
> Song Liu <song@kernel.org> wrote:
> 
>> Naveen reported recursive locking of direct_mutex with sample
>> ftrace-direct-modify.ko:
>> 
>> [   74.762406] WARNING: possible recursive locking detected
>> [   74.762887] 6.0.0-rc6+ #33 Not tainted
>> [   74.763216] --------------------------------------------
>> [   74.763672] event-sample-fn/1084 is trying to acquire lock:
>> [   74.764152] ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>>    register_ftrace_function+0x1f/0x180
>> [   74.764922]
>> [   74.764922] but task is already holding lock:
>> [   74.765421] ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>>    modify_ftrace_direct+0x34/0x1f0
>> [   74.766142]
>> [   74.766142] other info that might help us debug this:
>> [   74.766701]  Possible unsafe locking scenario:
>> [   74.766701]
>> [   74.767216]        CPU0
>> [   74.767437]        ----
>> [   74.767656]   lock(direct_mutex);
>> [   74.767952]   lock(direct_mutex);
>> [   74.768245]
>> [   74.768245]  *** DEADLOCK ***
>> [   74.768245]
>> [   74.768750]  May be due to missing lock nesting notation
>> [   74.768750]
>> [   74.769332] 1 lock held by event-sample-fn/1084:
>> [   74.769731]  #0: ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>>    modify_ftrace_direct+0x34/0x1f0
>> [   74.770496]
>> [   74.770496] stack backtrace:
>> [   74.770884] CPU: 4 PID: 1084 Comm: event-sample-fn Not tainted ...
>> [   74.771498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
>> [   74.772474] Call Trace:
>> [   74.772696]  <TASK>
>> [   74.772896]  dump_stack_lvl+0x44/0x5b
>> [   74.773223]  __lock_acquire.cold.74+0xac/0x2b7
>> [   74.773616]  lock_acquire+0xd2/0x310
>> [   74.773936]  ? register_ftrace_function+0x1f/0x180
>> [   74.774357]  ? lock_is_held_type+0xd8/0x130
>> [   74.774744]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
>> [   74.775213]  __mutex_lock+0x99/0x1010
>> [   74.775536]  ? register_ftrace_function+0x1f/0x180
>> [   74.775954]  ? slab_free_freelist_hook.isra.43+0x115/0x160
>> [   74.776424]  ? ftrace_set_hash+0x195/0x220
>> [   74.776779]  ? register_ftrace_function+0x1f/0x180
>> [   74.777194]  ? kfree+0x3e1/0x440
>> [   74.777482]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
>> [   74.777941]  ? __schedule+0xb40/0xb40
>> [   74.778258]  ? register_ftrace_function+0x1f/0x180
>> [   74.778672]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
>> [   74.779128]  register_ftrace_function+0x1f/0x180
>> [   74.779527]  ? ftrace_set_filter_ip+0x33/0x70
>> [   74.779910]  ? __schedule+0xb40/0xb40
>> [   74.780231]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
>> [   74.780678]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
>> [   74.781147]  ftrace_modify_direct_caller+0x5b/0x90
>> [   74.781563]  ? 0xffffffffa0201000
>> [   74.781859]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
>> [   74.782309]  modify_ftrace_direct+0x1b2/0x1f0
>> [   74.782690]  ? __schedule+0xb40/0xb40
>> [   74.783014]  ? simple_thread+0x2a/0xb0 [ftrace_direct_modify]
>> [   74.783508]  ? __schedule+0xb40/0xb40
>> [   74.783832]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
>> [   74.784294]  simple_thread+0x76/0xb0 [ftrace_direct_modify]
>> [   74.784766]  kthread+0xf5/0x120
>> [   74.785052]  ? kthread_complete_and_exit+0x20/0x20
>> [   74.785464]  ret_from_fork+0x22/0x30
>> [   74.785781]  </TASK>
>> 
>> Fix this by using register_ftrace_function_nolock in
>> ftrace_modify_direct_caller.
>> 
>> Fixes: 53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
>> Reported-and-tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Signed-off-by: Song Liu <song@kernel.org>
>> 

