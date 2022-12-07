Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350A76456C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiLGJpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLGJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:45:20 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1026F3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:45:17 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B79Yv9j018602;
        Wed, 7 Dec 2022 09:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=z3tIElSlKId3LKVR8HWREeqUNyPVBmEX7t/lNhgA1O0=;
 b=XiS1gDhotmIe5Oc30sSE3OLM2f9ei4rrVnzhfL4gjdMLYLK9mGmQPhjzNZ2GABCxTCAT
 wCmWxfRJLrg/emoAuvXSz9bfpUEwBpfm2Lh9H2G66MjP5vry88yh7hKALrixZ1GaFzGb
 H+pjiyU9ji4LkD3hs6zhkmlHD7U7CU3wTuG5wZcJIPK/ZJ5VBIIpTB3ZVLmtUoxWklxM
 M28FuFSEWK2pOUrzI3JadRxVk5apkhOKKAGiTFDlD6VoIdhYkeOlZ/LcHtctE7hMzMkE
 xguGhgpGIkbodMOqMWgAQ9qi+Xtevwrvg957+lsWxliJ2EJQ9GWRj+uoCPit1iMuBHtg tw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3m7we93aay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 09:44:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIHxBEf+rJT1785bk+ZfV6Wz9hsrYtWvjTh0CODs6rsJ4gFOKY4nJo7bPKdNcYC1aZ97TvOvJOBzHhj5uOZkx7mGE1U3jZ/I49V69CHW3p60zx0e4sS/PqBM5nr/9+DCg9ASymxC4rqsNPKTQdnAkph9UiGK7o11ij1KYhCsCzAQvRHVLd+wGdse2JtBdC/H5IeoZfOg5bqdN4cXADaBG+9A4rD+CGxUos2z/sVSId+j2GjgqBxr0q/HXE3IRcyZim06M7+2ZOeuM0ZEC7OSH6r7FMz+9FfZkwAaAYpflW9aC9f79MU52WeJ6FG1r4p1N1FuX818AlWdYzKiai8Ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3tIElSlKId3LKVR8HWREeqUNyPVBmEX7t/lNhgA1O0=;
 b=E+LC90mUSYTRjebwR9zt9lvD6qLuUfIGOez7HOqnWAgiTIMicSuXQdx7DUGTa8N8hzvdZQblwald2cSx8sVbTfFb/jMoMF+4KlWCoP3LeTGxllKc8FVP68h/u2+KB2zAXalmfs+zbXtBChlm4o2jmEQf28N+ylBPZTWRVxHtEU8DY9KmLe1tujfNcqpo7tAuuekEHU10H4yyQh2X1dr8TC6si1JdnZ546Dbqv9uG5zmQnk1hbrSIsNdfCGhGchAfpdl6ZGA6wkzfsg8i5KhCGZPBNs5HLuvhhWcDw04PZTi7Rl2NCSWc5LMRmjHtfdS8+Nm5nSYomaFe87eEaAM6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by DS0PR11MB7190.namprd11.prod.outlook.com (2603:10b6:8:132::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 09:44:42 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::f05a:5750:9d7b:7f92]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::f05a:5750:9d7b:7f92%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 09:44:42 +0000
From:   "Luther, Sven" <Sven.Luther@windriver.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Bonn, Jonas" <Jonas.Bonn@windriver.com>
Subject: RE: [Regression] mqueue performance degradation after "The new cgroup
 slab memory controller" patchset.
Thread-Topic: [Regression] mqueue performance degradation after "The new
 cgroup slab memory controller" patchset.
Thread-Index: AQHZCLlPJRgR3N+NBE2RcqkRsyxPQa5gH6gAgAINqiQ=
Date:   Wed, 7 Dec 2022 09:44:42 +0000
Message-ID: <PH0PR11MB562690ED9067DFC9B16B67CCE91A9@PH0PR11MB5626.namprd11.prod.outlook.com>
References: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
 <Y46lqCToUa/Bgt/c@P9FQF9L96D>
In-Reply-To: <Y46lqCToUa/Bgt/c@P9FQF9L96D>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5626:EE_|DS0PR11MB7190:EE_
x-ms-office365-filtering-correlation-id: c7cf02e4-b09d-42c5-5256-08dad837aa90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRSSIwOwpK04IKKIk+VusbhLyQ046k2FJnN1PAutuKzukGTDiXQHcQFrYLwqleAyi13FL6sp+p4rJnMEcqt1K9B59kGtGvGo+O/M5F0aMDVFMopoSH+DSlVbwiUL0+Xg+wjBmEyzgZx7G93ddRorWZddic5KCemohh0hftcHYkgqTeWDrIEpPY9qUpTxSPIjFs077suxwKeKS0E1p5dVJ//lCxyYeVyCNNrXY1gQUfFzAvroG5bQi5gYzA7tNMCYV1mkN5+y+Ej/C+tWdvIAlpQPfucM5HUBR2tv5CBRPDyaKIpQ5LrzlDX66GHp+7Ji0D8G018LrjXDpKxkX7FelLY9c9Jo7De0zgzZH8PP3OQst7HyVZ6ftdis3F87hMHWgdg/f4OO8cqDdPxggVF3S4gTnxzPog54CsENcV8TuYzrNLUToW5oadH6RD0IUAD3v+wZ7VAXpNXs+oqETZcGiVZ0iiIERM1dzuWTfVKROlcqUZ71D3aYNalQq8Sm33yI/GXJckC0bqu7StaFfMw/L2SaGmU3PovsnErGPvSjg7LbYwi97wehfE0l1zrbz5sGB7Fz33fTgbipns/u8FlfhdeCB0lmf1lFWK9cRy7qze6nctC2jpqpoVtPIK1wN7GnMpRCsD25mRu/Ym23eP5ubusTilhjWWIxPdkzosxRo2DtOOU2RYHqqBJJ52Pgo9mCFpEh6q8D1MSjW6R6g2lDROw8rfvOsoyxFal/NUdg4Po=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(376002)(39850400004)(451199015)(66574015)(83380400001)(33656002)(86362001)(40140700001)(38100700002)(966005)(478600001)(71200400001)(38070700005)(55016003)(122000001)(8676002)(53546011)(4326008)(9686003)(6506007)(30864003)(7696005)(5660300002)(2906002)(107886003)(186003)(41300700001)(76116006)(7416002)(66946007)(66476007)(6916009)(54906003)(66446008)(52536014)(8936002)(64756008)(66556008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7AV0URt4Mbqr68HxJ7HPyxGrHOYfGhOdJaI+48PpNuBZd3AYTDEIFqoo/b?=
 =?iso-8859-1?Q?VLga2eyyzDpG6xAaVLkBd+fSXIZ/I9U+l+dgYzr1o+fSm+rJQGJZazV4yu?=
 =?iso-8859-1?Q?a6jOduSh1d9TlTnMwFLa+uVohg8UX9qS2DWTbp0EPHyFeKyCIHd0EhFM3m?=
 =?iso-8859-1?Q?6g4mctAb3PF1NMnPMKSnj5olDjRz4r8Y0Giyy8N1wjDFbo/wqp6t0QO4Qt?=
 =?iso-8859-1?Q?OPKdUOcPjd80rOCrJT1Su/jvvMxKtz2wt5Hh+KfqBhQW+4bgFOrtiepjva?=
 =?iso-8859-1?Q?YeuAW0CSf9MUI8OyPCSTX5Q0/MxKKXFBfbToc7ifHZk9LcdMOQsb/S+9Tw?=
 =?iso-8859-1?Q?JzecxkefvuJzbsITXnRZmc9sqQQb7GBlfpFZiUMnRaWEY8jWUirQrSd+aF?=
 =?iso-8859-1?Q?JcaMY5Q4HE6E2+pLUM/KhwwfNhP9M3+AqDTuZ/ZW111MCqLFbEqhAMVkq9?=
 =?iso-8859-1?Q?7Y2ZmqKiVy+mOQbZ3RJBmOSQ/kG3tSS9kQ/ZlFo/mq/Xl/tNt2cq67xUtB?=
 =?iso-8859-1?Q?dqtATYvNnRt2s36rHyVCDSoHxE2Nz5+wsqQZaZ4y8QmnS2MHnMv0qg9eWs?=
 =?iso-8859-1?Q?X/Q2fuDfciOe4zdsuzBUAZ/lFzQaMLi6tVWk6XsEXiaqnInsPgSvN2K9H2?=
 =?iso-8859-1?Q?EcF8yx/jjleGMHkyrIHUXP4UIEDQiK1HYXKAqPcKcOV4EFfPfiAiaXTGhG?=
 =?iso-8859-1?Q?5wPUNcIbvap6zMckzVRt0nFhlO0OqBYA4T+UP+ZMYhgYCrZS7iypyJxch3?=
 =?iso-8859-1?Q?O5yYvC2Xf+gUxRsJe+prCjwQdhVJHy4k1zkPjP0aNK1cLvQ6yhT4R7roOQ?=
 =?iso-8859-1?Q?0jRWaAlQEfE2hxDdFuI5iGeMOR6VDhYEcL/jggNpBSeqk1mmiNF4aIw1LF?=
 =?iso-8859-1?Q?uZjv21Pq2jm3pxRAPw5J1LjPSMwjWaCujS+cFP7ApCuvtNnNr5zeYPxEyh?=
 =?iso-8859-1?Q?fLXN7uHphMRgjE0PlQxj9bnq4iotkAV+RJoU4fHLBwTRNrmPJp1+MyqW57?=
 =?iso-8859-1?Q?+UjdAWgU1VfeFVidqQIHiAVbioiZSXV6pHviCn+G/x7ylQfOcDswFfWO8X?=
 =?iso-8859-1?Q?9xv/q/R3MFUoOSU30na9xOej79Hv1/oO+Ifxu8NkooAJybxNmvSc3p6Awk?=
 =?iso-8859-1?Q?HbOzAp/ndMURvnUwHHClC2yHIy4y+dIbBhEoRMRi5PnaBiFx5mLCGU6+2L?=
 =?iso-8859-1?Q?eBJOM9hPx7xV5MDmJjM2CDR1Xu4homsBYIdKHEq5SstE73Ymosu6Q47I60?=
 =?iso-8859-1?Q?wnd00vQnDPh1cjwXDLZmQOoO4Wh6LH6ry1QcLtLP7U3EwX4D0QxOaNLfEs?=
 =?iso-8859-1?Q?XPC4lJN32soyvnc8QQfjLOEvHFfe61V7NCYSYrdgKxDZgPDu/eaE2kxuXO?=
 =?iso-8859-1?Q?MSBljd6TP49nTWEWmddiweGTgTDLptIeeiJO2J5fV0m8ntWOdw1DoXgRWM?=
 =?iso-8859-1?Q?KrcQB+6aPhZMpxumMQK07ndrxwBpUMq7tkOvZAMfZdE500GsmA+LLCNplP?=
 =?iso-8859-1?Q?aG37hL/hrWngAPmXMzdxiTgMwLR4UU9vJsvSv23java7LMxDoCnC8sxNcu?=
 =?iso-8859-1?Q?h8UFD8xOB2sYiHSxE1DeK7Cr5MX8NavfJErpdlgfg5Po/NvsjE6hWfDLGK?=
 =?iso-8859-1?Q?mNNudpyVXZAdYmlpAasU5pDyytMBH7m0tYfDxVzascBm253F85dcJbIZ2B?=
 =?iso-8859-1?Q?JSEEp9dqItbtmtfK7B0GOP9LxTi0gEIUU7yv95c5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cf02e4-b09d-42c5-5256-08dad837aa90
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 09:44:42.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iumhPdar3Bw9e8RGj3iG3PC40Iotw18YqZJvS9gf4ox7Td8Mthc94LeTyG5MGKDIxSG/og8YRpYQ/+jqUnpDusjtEHBzOjsuH2Eq1ggHXUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7190
X-Proofpoint-GUID: BisYKlV9TYsSd8hmVu11UGmO3yaZ92BT
X-Proofpoint-ORIG-GUID: BisYKlV9TYsSd8hmVu11UGmO3yaZ92BT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_04,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
Thanks for your replies and suggestions.=0A=
=0A=
First 6.03 was indeed 6.0.3 the last stable at the time i did the measureme=
nts), so as suggested i redid the measurements with 6.1-rc8 (which seem a b=
it worse than 6.0.3).=0A=
=0A=
I also added the patch provided by Roman Gushchin (on line 6.1-rc8 p), whic=
h is indeed a consequent improvement on this test.=0A=
=0A=
I also added the variation measurement for minimum values, in addition to a=
verage measurements, since i have the feeling that using the minimum measur=
ement will show less variance compared to the average one, so, maybe better=
 for comparisons.=0A=
=0A=
Concerning the test case, obviously our application doesn't do 100 000 mque=
ue calls in a row, but still makes heavy use of them, and we saw the degrad=
ation in it.=0A=
=0A=
+-----------+---------------------------------+----------------------------=
----+----------------+=0A=
| kernel    | mqueue_rcv (ns)     variation   | mqueue_send (ns)   variatio=
n   |    getppid     |=0A=
| version   | min avg  max      min      avg  | min avg max       min     a=
vg  | (ns) variation |=0A=
+-----------+--------------------------+-----------------------------------=
----+----------------+=0A=
| 4.18.45   | 351 382 17533    base     base  | 383 410 13178     base    b=
ase | 149      base  |=0A=
| 5.8-good  | 380 392  7156   -7,63%  -2,55%  | 376 384  6225    1,86%   6,=
77% | 169   -11,83%  |=0A=
| 5.8-bad   | 524 530  5310  -33,02% -27,92%  | 512 519  8775  -25,20% -21,=
00% | 169   -11,83%  |=0A=
| 5.10      | 520 533  4078  -32,20% -28,33%  | 518 534  8108  -26,06% -23,=
22% | 167   -10,78%  |=0A=
| 5.15      | 431 444  8440  -18,56% -13,96%  | 425 437  6170   -9,88%  -6,=
18% | 171   -12,87%  |=0A=
| 6.0.3     | 474 614  3881  -25,95% -37,79%  | 482 693   931  -20,54% -40,=
84% | 171   -12,87%  |=0A=
| 6.1-rc8   | 496 509  8804  -29,23% -24,95%  | 493 512  5748  -22,31% -19,=
92% | 174   -14,37%  |=0A=
| 6.1-rc8 p | 377 381  6374   -6,90%   0,26%  | 339 343 13224   12,98%  19,=
53% | 174   -14,37%  |=0A=
+-----------+---------------------------------+----------------------------=
----+----------------+=0A=
=0A=
So, to summarize, the patch introduced in 5.14 and removed in 5.18 represen=
ted an optimization of this issue, not sure why it was removed again, but t=
he caching patch Roman provided brings performance almost to the point we w=
here in 4.18 (or even better in TX case), i wonder if a conjunction of both=
 would further optimize the mqueue performance.=0A=
=0A=
Friendly,=0A=
=0A=
Sven Luther=0A=
________________________________________=0A=
De : Roman Gushchin <roman.gushchin@linux.dev>=0A=
Envoy=E9 : mardi 6 d=E9cembre 2022 03:15=0A=
=C0 : Luther, Sven=0A=
Cc : linux-kernel@vger.kernel.org; regressions@lists.linux.dev; Roman Gushc=
hin; Andrew Morton; Christoph Lameter; Johannes Weiner; Michal Hocko; Shake=
el Butt; linux-mm@kvack.org; Vlastimil Babka; kernel-team@fb.com; Eric W. B=
iederman; Muchun Song; Waiman Long; Alexey Gladkov; Bonn, Jonas=0A=
Objet : Re: [Regression] mqueue performance degradation after "The new cgro=
up slab memory controller" patchset.=0A=
=0A=
CAUTION: This email comes from a non Wind River email account!=0A=
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.=0A=
=0A=
On Mon, Dec 05, 2022 at 02:55:48PM +0000, Luther, Sven wrote:=0A=
> #regzbot ^introduced 10befea91b61c4e2c2d1df06a2e978d182fcf792=0A=
>=0A=
> We are making heavy use of mqueues, and noticed a degradation of performa=
nce between 4.18 & 5.10 linux kernels.=0A=
>=0A=
> After a gross per-version tracing, we did kernel bisection between 5.8 an=
d 5.9=0A=
> and traced the issue to a 10 patches (of which 9 where skipped as they di=
dn't boot) between:=0A=
>=0A=
>=0A=
> commit 10befea91b61c4e2c2d1df06a2e978d182fcf792 (HEAD, refs/bisect/bad)=
=0A=
> Author: Roman Gushchin <guro@fb.com>=0A=
> Date:   Thu Aug 6 23:21:27 2020 -0700=0A=
>=0A=
>     mm: memcg/slab: use a single set of kmem_caches for all allocations=
=0A=
>=0A=
> and:=0A=
>=0A=
> commit 286e04b8ed7a04279ae277f0f024430246ea5eec (refs/bisect/good-286e04b=
8ed7a04279ae277f0f024430246ea5eec)=0A=
> Author: Roman Gushchin <guro@fb.com>=0A=
> Date:   Thu Aug 6 23:20:52 2020 -0700=0A=
>=0A=
>     mm: memcg/slab: allocate obj_cgroups for non-root slab pages=0A=
>=0A=
> All of them are part of the "The new cgroup slab memory controller" patch=
set:=0A=
>=0A=
>   https://lore.kernel.org/all/20200623174037.3951353-18-guro@fb.com/T/=0A=
>=0A=
> from Roman Gushchin, which moves the accounting for page level to the obj=
ect level.=0A=
>=0A=
> Measurements where done using the a test programmtest, which measures mix=
/average/max time mqueue_send/mqueue_rcv,=0A=
> and average for getppid, both measured over 100 000 runs. Results are sho=
wn in the following table=0A=
>=0A=
> +----------+--------------------------+-------------------------+--------=
--------+=0A=
> | kernel   |    mqueue_rcv (ns)       | mqueue_send (ns)        |    getp=
pid     |=0A=
> | version  | min avg  max   variation | min avg max   variation | (ns) va=
riation |=0A=
> +----------+--------------------------+-------------------------+--------=
--------+=0A=
> | 4.18.45  | 351 382 17533     base   | 383 410 13178     base  | 149    =
  base  |=0A=
> | 5.8-good | 380 392  7156   -2,55%   | 376 384  6225    6,77%  | 169   -=
11,83%  |=0A=
> | 5.8-bad  | 524 530  5310  -27,92%   | 512 519  8775  -21,00%  | 169   -=
11,83%  |=0A=
> | 5.10     | 520 533  4078  -28,33%   | 518 534  8108  -23,22%  | 167   -=
10,78%  |=0A=
> | 5.15     | 431 444  8440  -13,96%   | 425 437  6170   -6,18%  | 171   -=
12,87%  |=0A=
> | 6.03     | 474 614  3881  -37,79%   | 482 693   931  -40,84%  | 171   -=
12,87%  |=0A=
> +----------+--------------------------+-------------------------+--------=
---------=0A=
>=0A=
=0A=
Hi Sven!=0A=
=0A=
To prove a concept of local msg caching, I'm mastered a patch (attached bel=
ow).=0A=
In my test setup it seems to resolve most of the regression. Would you mind=
 to=0A=
give it a try? (It's only tested on my local vm, don't treat it as a produc=
tion=0A=
code). If it will fix the regression, I can invest more time into it and po=
st=0A=
it in an umpstreamble form.=0A=
=0A=
Here are my results (5 runs each):=0A=
=0A=
Original (current mm tree, 6.1+):=0A=
RX: 1122/1202/114001 1197/1267/26517 1109/1173/29613 1091/1165/54434 1091/1=
160/26302=0A=
TX: 1176/1255/38168  1252/1360/27683 1165/1226/41454 1145/1222/90040 1146/1=
214/26595=0A=
=0A=
No accounting:=0A=
RX: 984/1053/31268    1024/1091/39105 1018/1077/61515  999/1065/30423  1008=
/1060/115284=0A=
TX: 1020/1097/137690  1065/1143/31448 1055/1130/133278 1032/1106/52372 1043=
/1099/25705=0A=
=0A=
Patched:=0A=
RX: 1033/1165/38579 1030/1108/43703 1022/1114/25653 1008/1110/38462 1089/11=
36/29120=0A=
TX: 1047/1184/25373 1048/1116/25425 1034/1122/61275 1022/1121/24636 1105/11=
55/46600=0A=
=0A=
Thanks!=0A=
=0A=
--=0A=
=0A=
From 7742e074c25eb51d8e606585f0f8b06228d907f5 Mon Sep 17 00:00:00 2001=0A=
From: Roman Gushchin <roman.gushchin@linux.dev>=0A=
Date: Mon, 5 Dec 2022 18:13:15 -0800=0A=
Subject: [PATCH] ipc/mqueue: introduce msg cache=0A=
=0A=
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>=0A=
---=0A=
 ipc/mqueue.c  | 20 ++++++++++---=0A=
 ipc/msg.c     | 12 ++++----=0A=
 ipc/msgutil.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++----=0A=
 ipc/util.h    |  8 ++++--=0A=
 4 files changed, 101 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/ipc/mqueue.c b/ipc/mqueue.c=0A=
index 467a194b8a2e..5c6fec8e9701 100644=0A=
--- a/ipc/mqueue.c=0A=
+++ b/ipc/mqueue.c=0A=
@@ -131,6 +131,11 @@ struct ext_wait_queue {            /* queue of sleepin=
g tasks */=0A=
        int state;              /* one of STATE_* values */=0A=
 };=0A=
=0A=
+struct pcpu_msg_cache;=0A=
+struct msg_cache {=0A=
+       struct pcpu_msg_cache __percpu *pcpu_cache;=0A=
+};=0A=
+=0A=
 struct mqueue_inode_info {=0A=
        spinlock_t lock;=0A=
        struct inode vfs_inode;=0A=
@@ -152,6 +157,8 @@ struct mqueue_inode_info {=0A=
        /* for tasks waiting for free space and messages, respectively */=
=0A=
        struct ext_wait_queue e_wait_q[2];=0A=
=0A=
+       struct msg_cache msg_cache;=0A=
+=0A=
        unsigned long qsize; /* size of queue in memory (sum of all msgs) *=
/=0A=
 };=0A=
=0A=
@@ -368,6 +375,9 @@ static struct inode *mqueue_get_inode(struct super_bloc=
k *sb,=0A=
                mq_bytes =3D info->attr.mq_maxmsg * info->attr.mq_msgsize;=
=0A=
                if (mq_bytes + mq_treesize < mq_bytes)=0A=
                        goto out_inode;=0A=
+               ret =3D init_msg_cache(&info->msg_cache);=0A=
+               if (ret)=0A=
+                       goto out_inode;=0A=
                mq_bytes +=3D mq_treesize;=0A=
                info->ucounts =3D get_ucounts(current_ucounts());=0A=
                if (info->ucounts) {=0A=
@@ -531,9 +541,11 @@ static void mqueue_evict_inode(struct inode *inode)=0A=
=0A=
        list_for_each_entry_safe(msg, nmsg, &tmp_msg, m_list) {=0A=
                list_del(&msg->m_list);=0A=
-               free_msg(msg);=0A=
+               free_msg(msg, &info->msg_cache);=0A=
        }=0A=
=0A=
+       free_msg_cache(&info->msg_cache);=0A=
+=0A=
        if (info->ucounts) {=0A=
                unsigned long mq_bytes, mq_treesize;=0A=
=0A=
@@ -1108,7 +1120,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __=
user *u_msg_ptr,=0A=
=0A=
        /* First try to allocate memory, before doing anything with=0A=
         * existing queues. */=0A=
-       msg_ptr =3D load_msg(u_msg_ptr, msg_len);=0A=
+       msg_ptr =3D load_msg(u_msg_ptr, msg_len, &info->msg_cache);=0A=
        if (IS_ERR(msg_ptr)) {=0A=
                ret =3D PTR_ERR(msg_ptr);=0A=
                goto out_fput;=0A=
@@ -1170,7 +1182,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __=
user *u_msg_ptr,=0A=
        wake_up_q(&wake_q);=0A=
 out_free:=0A=
        if (ret)=0A=
-               free_msg(msg_ptr);=0A=
+               free_msg(msg_ptr, &info->msg_cache);=0A=
 out_fput:=0A=
        fdput(f);=0A=
 out:=0A=
@@ -1273,7 +1285,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __use=
r *u_msg_ptr,=0A=
                        store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {=0A=
                        ret =3D -EFAULT;=0A=
                }=0A=
-               free_msg(msg_ptr);=0A=
+               free_msg(msg_ptr, &info->msg_cache);=0A=
        }=0A=
 out_fput:=0A=
        fdput(f);=0A=
diff --git a/ipc/msg.c b/ipc/msg.c=0A=
index fd08b3cb36d7..fcc09f848490 100644=0A=
--- a/ipc/msg.c=0A=
+++ b/ipc/msg.c=0A=
@@ -287,7 +287,7 @@ static void freeque(struct ipc_namespace *ns, struct ke=
rn_ipc_perm *ipcp)=0A=
=0A=
        list_for_each_entry_safe(msg, t, &msq->q_messages, m_list) {=0A=
                percpu_counter_sub_local(&ns->percpu_msg_hdrs, 1);=0A=
-               free_msg(msg);=0A=
+               free_msg(msg, NULL);=0A=
        }=0A=
        percpu_counter_sub_local(&ns->percpu_msg_bytes, msq->q_cbytes);=0A=
        ipc_update_pid(&msq->q_lspid, NULL);=0A=
@@ -861,7 +861,7 @@ static long do_msgsnd(int msqid, long mtype, void __use=
r *mtext,=0A=
        if (mtype < 1)=0A=
                return -EINVAL;=0A=
=0A=
-       msg =3D load_msg(mtext, msgsz);=0A=
+       msg =3D load_msg(mtext, msgsz, NULL);=0A=
        if (IS_ERR(msg))=0A=
                return PTR_ERR(msg);=0A=
=0A=
@@ -954,7 +954,7 @@ static long do_msgsnd(int msqid, long mtype, void __use=
r *mtext,=0A=
 out_unlock1:=0A=
        rcu_read_unlock();=0A=
        if (msg !=3D NULL)=0A=
-               free_msg(msg);=0A=
+               free_msg(msg, NULL);=0A=
        return err;=0A=
 }=0A=
=0A=
@@ -1049,7 +1049,7 @@ static inline struct msg_msg *prepare_copy(void __use=
r *buf, size_t bufsz)=0A=
        /*=0A=
         * Create dummy message to copy real message to.=0A=
         */=0A=
-       copy =3D load_msg(buf, bufsz);=0A=
+       copy =3D load_msg(buf, bufsz, NULL);=0A=
        if (!IS_ERR(copy))=0A=
                copy->m_ts =3D bufsz;=0A=
        return copy;=0A=
@@ -1058,7 +1058,7 @@ static inline struct msg_msg *prepare_copy(void __use=
r *buf, size_t bufsz)=0A=
 static inline void free_copy(struct msg_msg *copy)=0A=
 {=0A=
        if (copy)=0A=
-               free_msg(copy);=0A=
+               free_msg(copy, NULL);=0A=
 }=0A=
 #else=0A=
 static inline struct msg_msg *prepare_copy(void __user *buf, size_t bufsz)=
=0A=
@@ -1256,7 +1256,7 @@ static long do_msgrcv(int msqid, void __user *buf, si=
ze_t bufsz, long msgtyp, in=0A=
        }=0A=
=0A=
        bufsz =3D msg_handler(buf, msg, bufsz);=0A=
-       free_msg(msg);=0A=
+       free_msg(msg, NULL);=0A=
=0A=
        return bufsz;=0A=
 }=0A=
diff --git a/ipc/msgutil.c b/ipc/msgutil.c=0A=
index d0a0e877cadd..8fe64bb3f48d 100644=0A=
--- a/ipc/msgutil.c=0A=
+++ b/ipc/msgutil.c=0A=
@@ -39,16 +39,65 @@ struct msg_msgseg {=0A=
        /* the next part of the message follows immediately */=0A=
 };=0A=
=0A=
+struct pcpu_msg_cache {=0A=
+       struct msg_msg *msg;=0A=
+       struct task_struct *curr;=0A=
+       size_t len;=0A=
+};=0A=
+=0A=
+struct msg_cache {=0A=
+       struct pcpu_msg_cache __percpu *pcpu_cache;=0A=
+};=0A=
+=0A=
 #define DATALEN_MSG    ((size_t)PAGE_SIZE-sizeof(struct msg_msg))=0A=
 #define DATALEN_SEG    ((size_t)PAGE_SIZE-sizeof(struct msg_msgseg))=0A=
=0A=
+int init_msg_cache(struct msg_cache *cache)=0A=
+{=0A=
+       cache->pcpu_cache =3D alloc_percpu(struct pcpu_msg_cache);=0A=
+       if (!cache->pcpu_cache)=0A=
+               return -ENOMEM;=0A=
=0A=
-static struct msg_msg *alloc_msg(size_t len)=0A=
+       return 0;=0A=
+}=0A=
+=0A=
+void free_msg_cache(struct msg_cache *cache)=0A=
+{=0A=
+       int cpu;=0A=
+=0A=
+       if (!cache->pcpu_cache)=0A=
+               return;=0A=
+=0A=
+       for_each_possible_cpu(cpu) {=0A=
+               struct pcpu_msg_cache *pc =3D per_cpu_ptr(cache->pcpu_cache=
, cpu);=0A=
+=0A=
+               if (pc->msg)=0A=
+                       free_msg(pc->msg, NULL);=0A=
+       }=0A=
+=0A=
+       free_percpu(cache->pcpu_cache);=0A=
+}=0A=
+=0A=
+static struct msg_msg *alloc_msg(size_t len, struct msg_cache *cache)=0A=
 {=0A=
        struct msg_msg *msg;=0A=
        struct msg_msgseg **pseg;=0A=
        size_t alen;=0A=
=0A=
+       if (cache) {=0A=
+               struct pcpu_msg_cache *pc;=0A=
+=0A=
+               msg =3D NULL;=0A=
+               pc =3D get_cpu_ptr(cache->pcpu_cache);=0A=
+               if (pc->msg && pc->curr =3D=3D get_current() && pc->len =3D=
=3D len) {=0A=
+                       msg =3D pc->msg;=0A=
+                       pc->msg =3D NULL;=0A=
+               }=0A=
+               put_cpu_ptr(cache->pcpu_cache);=0A=
+               if (msg)=0A=
+                       return msg;=0A=
+       }=0A=
+=0A=
        alen =3D min(len, DATALEN_MSG);=0A=
        msg =3D kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);=0A=
        if (msg =3D=3D NULL)=0A=
@@ -77,18 +126,19 @@ static struct msg_msg *alloc_msg(size_t len)=0A=
        return msg;=0A=
=0A=
 out_err:=0A=
-       free_msg(msg);=0A=
+       free_msg(msg, cache);=0A=
        return NULL;=0A=
 }=0A=
=0A=
-struct msg_msg *load_msg(const void __user *src, size_t len)=0A=
+struct msg_msg *load_msg(const void __user *src, size_t len,=0A=
+                        struct msg_cache *cache)=0A=
 {=0A=
        struct msg_msg *msg;=0A=
        struct msg_msgseg *seg;=0A=
        int err =3D -EFAULT;=0A=
        size_t alen;=0A=
=0A=
-       msg =3D alloc_msg(len);=0A=
+       msg =3D alloc_msg(len, cache);=0A=
        if (msg =3D=3D NULL)=0A=
                return ERR_PTR(-ENOMEM);=0A=
=0A=
@@ -111,7 +161,7 @@ struct msg_msg *load_msg(const void __user *src, size_t=
 len)=0A=
        return msg;=0A=
=0A=
 out_err:=0A=
-       free_msg(msg);=0A=
+       free_msg(msg, cache);=0A=
        return ERR_PTR(err);=0A=
 }=0A=
 #ifdef CONFIG_CHECKPOINT_RESTORE=0A=
@@ -166,10 +216,27 @@ int store_msg(void __user *dest, struct msg_msg *msg,=
 size_t len)=0A=
        return 0;=0A=
 }=0A=
=0A=
-void free_msg(struct msg_msg *msg)=0A=
+void free_msg(struct msg_msg *msg, struct msg_cache *cache)=0A=
 {=0A=
        struct msg_msgseg *seg;=0A=
=0A=
+       if (cache) {=0A=
+               struct pcpu_msg_cache *pc;=0A=
+               bool cached =3D false;=0A=
+=0A=
+               pc =3D get_cpu_ptr(cache->pcpu_cache);=0A=
+               if (!pc->msg) {=0A=
+                       pc->curr =3D get_current();=0A=
+                       pc->len =3D msg->m_ts;=0A=
+                       pc->msg =3D msg;=0A=
+                       cached =3D true;=0A=
+               }=0A=
+               put_cpu_ptr(cache->pcpu_cache);=0A=
+=0A=
+               if (cached)=0A=
+                       return;=0A=
+       }=0A=
+=0A=
        security_msg_msg_free(msg);=0A=
=0A=
        seg =3D msg->next;=0A=
diff --git a/ipc/util.h b/ipc/util.h=0A=
index b2906e366539..a2da266386aa 100644=0A=
--- a/ipc/util.h=0A=
+++ b/ipc/util.h=0A=
@@ -196,8 +196,12 @@ static inline void ipc_update_pid(struct pid **pos, st=
ruct pid *pid)=0A=
 int ipc_parse_version(int *cmd);=0A=
 #endif=0A=
=0A=
-extern void free_msg(struct msg_msg *msg);=0A=
-extern struct msg_msg *load_msg(const void __user *src, size_t len);=0A=
+struct msg_cache;=0A=
+extern int init_msg_cache(struct msg_cache *cache);=0A=
+extern void free_msg_cache(struct msg_cache *cache);=0A=
+extern void free_msg(struct msg_msg *msg, struct msg_cache *cache);=0A=
+extern struct msg_msg *load_msg(const void __user *src, size_t len,=0A=
+                               struct msg_cache *cache);=0A=
 extern struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst);=
=0A=
 extern int store_msg(void __user *dest, struct msg_msg *msg, size_t len);=
=0A=
=0A=
--=0A=
2.38.1=0A=
=0A=
