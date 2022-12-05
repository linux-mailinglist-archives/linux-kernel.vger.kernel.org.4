Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6E642AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiLEPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiLEPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:06:14 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DE81D331
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:06:13 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5COMKZ016646;
        Mon, 5 Dec 2022 07:05:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=9oZU5ASQ0uwFxgOk5zqSZw0J0WuMTOGtgLUnulZtSSQ=;
 b=huo+7ojduj3dYjz0sOspFWF7DkzIonpQm5l9fA3uFExvINyoDDI/ykAVcNIH91iKi+LL
 qDGMV7s2+QUHZimhHZ5b0kWyPx08XKCZn7wjeQVYkUFyJm3Lrm4jfUk3QEvjghvboH4W
 aXGitX9a8fT7Drl1Y1JSgbdYrhtXjGPRudQCzZZthNxpd3rg51gtkkH7GbqN22zwzQ7t
 U+KQDL5AQprv1XAQi/LydaVEg5F2XoAUqCcGVHDHoJ655m5RJqtAnmMaKQmHJPNcsQAJ
 uxARMDfqESD6eroFAxD5w6UQhknynky+alHT7Asiaj3aU0hq7UX4KWZ6VSOtI3hFyhGL UQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3m82m6sedt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 07:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT0XZ1rGD/6dE89NejcGDCwsAPZAsoZx11XrHxroA8iut5Al78BNKVbkxJwv33y46Vah18K6zY650h+x27wlunZAZMhU9lMH1axV/5j5OakOr+QFSRWRrWArr2ogrJOlqpaflksS8CY7b0fr0YK0TgxZulSR9s/FQrmqyl3Okc9KgPTgPX1b4aZ+QrP1qOdWtLOKDJ6fmOejCZyCdq68oxdoU2FfXBNYbsrE35fFyukgIKAUmDQVhgI9qC3CgN0YgCg6gMuUWGr0T1Aoq7UBIqZRUWxdqec3MnLG+Gnps6kwbMgEMN459JXphR+0oKUFfPoZAlk//JErB9NZGQUiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oZU5ASQ0uwFxgOk5zqSZw0J0WuMTOGtgLUnulZtSSQ=;
 b=oNUSsIhcVhnzZ+tiGwb9rB0n7YSUEd7s7sTuElns5LkAj3OB3th70ErSmMbAtaULfvrzgPskSdqKjeq7+hLSrWsYD1xcg7EyUGauj6MOtvHjyK84+ST5bpuTqvRE/gkK9823btayCms9cgu6TKREBfYBhkA//uestVmFs0/oUFZ++HcUDIGQlP+7nS+elnDpYncHA5OAAVvqI4aVbMXvWJW92EX0bZI4qsTGMagEVgj6c/h38mTTAtqGdmu8hg9CIodIke/B3IW5Nh6IMOby7GOVGFcNXtMRzhFXrq/MJHMLiWwp9ZPH5eoyELWm+prolBzRBDGaDOJllFPIrNOHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 15:05:45 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::f05a:5750:9d7b:7f92]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::f05a:5750:9d7b:7f92%3]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 15:05:45 +0000
From:   "Luther, Sven" <Sven.Luther@windriver.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Gushchin <guro@fb.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
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
Thread-Index: AQHZCLlPJRgR3N+NBE2RcqkRsyxPQa5fZIEr
Date:   Mon, 5 Dec 2022 15:05:45 +0000
Message-ID: <PH0PR11MB56260B78ED0C1255D7B5EE21E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
References: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB562641BC03630B4B7A227FD7E9189@PH0PR11MB5626.namprd11.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5626:EE_|PH0PR11MB5144:EE_
x-ms-office365-filtering-correlation-id: 360020ef-2bb2-43f9-163d-08dad6d22f6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jn1Ct6MdyuWFR63ySE4XHBMyEhtJc0OW7LM7/kQst1+0LexpP0/gGOnB6t3SHLiB1BaujNwoS1eEoX3XAbO+gTpCbD/Xt9WHTk2Dur3O8Gw2p5GvqQHfn14KfsYDOToOOFlcqxJXN/DTplL5XR9TX8CapTzPCzASDPWFe2yid1x8EUmS+KxPhTBA4RfztjubIb7Ffrdige29w02l7y0HaFnkBwmZm19IScQmsV/XnFZoX19ywpD56nFajiGN1t0m124LvZcvE7GxYINJXAv7gsR4HKrd5AopzXQYsAz9cgiEHcsTu3ZDdhTd+HuaKAdJHfXzEuWFKMY37F7s0PG8yJqA1Gp/LSiy1bFpuq8aC3eZKCzvUEc1t/VHxqiZXuuAEyKKiXGOeEo4d1GiXP+EjfSO2apEsscgd8L0SJL8jjbKc5eOIAHu0s9Gli+5630sGuRJi7BPp2eDcxpItIQYZwFzVLxphL/ZS0X2gVbfDOx02klQqCsuevUlgTpa+PDyuudvqCo7iw3N6VVYIhBy1jRu59mH+DdckhHP34wGPNb7IDOzpSfL9MG0xglJ47UyZUR+eRtg4S1Oot91Y6fLNxWdBqkJFyjVT1wUquqJolG9qjtEUoe23sU6HZe4u7pS5H+8/kbAoM9TndFPGKu78nCeW+bo23AHibcgV/f/vtTHdnpGySDEsZjE4ka3OHSoRj77Rx9U6DiXXm+ZEPFdxgtNb2pHZRjhAbQlBTAZ/ZIOYgV/ZBJogTyv3NmELB63TfGpdscB/167wJfk2PYj87jkr2eCf9xdjYdrFq7gnis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(451199015)(122000001)(38100700002)(83380400001)(33656002)(86362001)(38070700005)(7416002)(64756008)(76116006)(66946007)(8936002)(2906002)(4326008)(66446008)(66476007)(41300700001)(91956017)(8676002)(66556008)(52536014)(5660300002)(55016003)(7696005)(6506007)(9686003)(186003)(71200400001)(107886003)(2940100002)(316002)(54906003)(110136005)(478600001)(966005)(40140700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xES4riISQNIFXCFr5+uOtpGQdsQz3WjW/I0/JYTmyq4dlu16XwwhPJT4/T?=
 =?iso-8859-1?Q?c9hsd75+We+c5NFF0uFZQtQDoFPbZ4zqzlF9x5Lo2m7KRVmxjgt46eucmk?=
 =?iso-8859-1?Q?LeDII0FSnPJv0A4P2PvposyHG5DhLkPxwfnSVX41MVUIAEw00vEDa2Q+c/?=
 =?iso-8859-1?Q?PRdCvyGuhuWIq484GpLXNL66B9XwdVfP4XjHiBCiYLGfhi+RanOa13LdJf?=
 =?iso-8859-1?Q?IPJDfCcpOtyVAfXLDsdwZl0RlCsJQmkcgrxGcKOP70kOFibGg51pn10Tc7?=
 =?iso-8859-1?Q?bvI69s463c6gQEifaDzh8Izz04pSG3U02+acQGnUcC3Fsp4NouwugO8cNQ?=
 =?iso-8859-1?Q?pXngBrbJINm67VTWCO/OLLlaveLgrU7Jg7+YxUhA0TaxJBRivJj+NMSt1s?=
 =?iso-8859-1?Q?CkfUwE/SiGllMh1qWSQEY+SZTq/6eZyJg3cNZhp6c7+fadiHUtFFu885Gf?=
 =?iso-8859-1?Q?flq4k+AZnA4isS/bnAQIMu3HKbNktKSwI9FTPCoj60tBvkYydyZ7poXc0j?=
 =?iso-8859-1?Q?vkLRO7Gt5s5OIkv4EbijQsvtNriIhIKRLn48NWL/ISNKcWtgFvNg9BhmXp?=
 =?iso-8859-1?Q?CEHH/sfEjbMjCF8k45+dTPVQu8IR5FcisPN0bn/2PX1ndO965658ikyYlX?=
 =?iso-8859-1?Q?mmEprYYOUlqea0mZW/kMCxEY3yeRXzqXgxSGw5guUSbYVoDON2NKsBTiM/?=
 =?iso-8859-1?Q?AMcgKT3aQ0HiKzKTV+5Vu3MvVeZAewk1I53nWYzTmp/tPGBkJHJTMOwyly?=
 =?iso-8859-1?Q?aT/hG6mIZ/JVe3SDdd1ZXZ9nc9/6F9V59wVmK9Mg2o0620GNV8vu8y+L5A?=
 =?iso-8859-1?Q?ih2aKDZGNRygmHcrPtjQ+pCR9Hr2L985EjO8NLAQ0Da30tieuw6Wwkzi9w?=
 =?iso-8859-1?Q?enszgNMogrZnTTC6N/PUbolwNkaKRFhnPcL0T+HcbKW8HeC6i8o8F2cuEA?=
 =?iso-8859-1?Q?JTa1N9fmTpYbNx1coQ6pSWHcaI1FAlaKrA0QiSqr1zVDaSPHAv3FFhq3vW?=
 =?iso-8859-1?Q?0fCnShuTqP0JQ/0MQzrWPKcVQKe4lPXDflObqVRjv7OOlaNO8wVXztLUeZ?=
 =?iso-8859-1?Q?jQiKcEbwQgMy9PV09fnj+9bfpKYeojvCeQ8KkevMhiZfBHeTY16UEya4mU?=
 =?iso-8859-1?Q?5qb12eCWcEmMy5l4CEBbkGXNupnU8DR2uletzNfR8ytBLbwRl9UOEe2vSX?=
 =?iso-8859-1?Q?JJpD0r+h3DelOftXITgcBiqO8PxoFxX85lpxr/7kvCRiyaBJF4RVsKveWd?=
 =?iso-8859-1?Q?TdpO/zBUC9x69cBMBw89lGCsBpgmFTnOWQyJ2e2To2IutdRLOFJi/AN/8X?=
 =?iso-8859-1?Q?yfnBMEEho0I/3+II+dDogv1L4uSD1LzEzCSN5zHZ9VmBzQBIOa1oG4ekvS?=
 =?iso-8859-1?Q?7A/VnJy3LCvvUsUp6rcutuLlr8T4GoSTCeMUuCDC3jTopdt6g5OrxO7a5T?=
 =?iso-8859-1?Q?E5UJkX0zl56Pg/2ZivcG7kzYoMbuDDoVT5MzpQWwFegZTB72qPUw3hwwRv?=
 =?iso-8859-1?Q?3i6qHYErNsfbRKz0fqWb50YxpmiIfPsx0KUDsA48d05iER+VMMK78bMnZ3?=
 =?iso-8859-1?Q?xwmgoKVwdEZdB8tHsJPTnHx0Q/2vmntUGgBcsSd5g31AK/zYynRtWpnZT2?=
 =?iso-8859-1?Q?qckUQbfy7DsHIxrDryUoye936WSV8qNt4awOMLgzQ/c0hkEV1wbsUBJKn4?=
 =?iso-8859-1?Q?v/Yk057Lf3TEydmIfL1ArNjrNcWC8BATNl1t+XQl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360020ef-2bb2-43f9-163d-08dad6d22f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 15:05:45.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cmQJM5kEXy35HZukydO0bvBgiXZ/hwjurAw9lYcejoVO6je6uXCNg6pYA3UDTFzvL0XzZyc8kESApM2iUDldo4ax1ueTq3KyS+/cZCZrkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-Proofpoint-ORIG-GUID: -dlORvRCC8Djz7qQb5QhseNM_ZbKW4F-
X-Proofpoint-GUID: -dlORvRCC8Djz7qQb5QhseNM_ZbKW4F-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212050124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#regzbot ^introduced 10befea91b61c4e2c2d1df06a2e978d182fcf792=0A=
=0A=
We are making heavy use of mqueues, and noticed a degradation of performanc=
e between 4.18 & 5.10 linux kernels.=0A=
=0A=
After a gross per-version tracing, we did kernel bisection between 5.8 and =
5.9=0A=
and traced the issue to a 10 patches (of which 9 where skipped as they didn=
't boot) between:=0A=
=0A=
=0A=
commit 10befea91b61c4e2c2d1df06a2e978d182fcf792 (HEAD, refs/bisect/bad)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:27 2020 -0700=0A=
=0A=
    mm: memcg/slab: use a single set of kmem_caches for all allocations=0A=
=0A=
and:=0A=
=0A=
commit 286e04b8ed7a04279ae277f0f024430246ea5eec (refs/bisect/good-286e04b8e=
d7a04279ae277f0f024430246ea5eec)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:20:52 2020 -0700=0A=
=0A=
    mm: memcg/slab: allocate obj_cgroups for non-root slab pages=0A=
=0A=
All of them are part of the "The new cgroup slab memory controller" patchse=
t:=0A=
=0A=
  https://lore.kernel.org/all/20200623174037.3951353-18-guro@fb.com/T/=0A=
=0A=
from Roman Gushchin, which moves the accounting for page level to the objec=
t level.=0A=
=0A=
Measurements where done using the a test programmtest, which measures mix/a=
verage/max time mqueue_send/mqueue_rcv,=0A=
and average for getppid, both measured over 100 000 runs. Results are shown=
 in the following table=0A=
=0A=
+----------+--------------------------+-------------------------+----------=
------+=0A=
| kernel   |    mqueue_rcv (ns)       | mqueue_send (ns)        |    getppi=
d     |=0A=
| version  | min avg  max   variation | min avg max   variation | (ns) vari=
ation |=0A=
+----------+--------------------------+-------------------------+----------=
------+=0A=
| 4.18.45  | 351 382 17533     base   | 383 410 13178     base  | 149      =
base  |=0A=
| 5.8-good | 380 392  7156   -2,55%   | 376 384  6225    6,77%  | 169   -11=
,83%  |=0A=
| 5.8-bad  | 524 530  5310  -27,92%   | 512 519  8775  -21,00%  | 169   -11=
,83%  |=0A=
| 5.10     | 520 533  4078  -28,33%   | 518 534  8108  -23,22%  | 167   -10=
,78%  |=0A=
| 5.15     | 431 444  8440  -13,96%   | 425 437  6170   -6,18%  | 171   -12=
,87%  |=0A=
| 6.03     | 474 614  3881  -37,79%   | 482 693   931  -40,84%  | 171   -12=
,87%  |=0A=
+----------+--------------------------+-------------------------+----------=
-------=0A=
=0A=
Below you will find the following appendices:=0A=
=0A=
  - raw GOOD bisect results=0A=
  - raw BAD bisect results=0A=
  - test code source code=0A=
  - bisect results=0A=
=0A=
Friendly,=0A=
=0A=
Sven Luther=0A=
=0A=
GOOD bisect results:=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
# uname -a=0A=
Linux axxiax86-64 5.8.0-5-286e04b8ed7a04279ae277f0f024430246ea5eec-good #1 =
SMP PREEMPT Fri Jul 29 11:01:19 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux=0A=
# ./mqtest=0A=
RX: 380/392/7156=0A=
TX: 376/384/6225=0A=
Accumulated time for 100000 getppid, 16924653ns=0A=
Average time per getppid: 169ns=0A=
# ./mqtest=0A=
RX: 383/397/6300=0A=
TX: 377/385/8258=0A=
Accumulated time for 100000 getppid, 16915580ns=0A=
Average time per getppid: 169ns=0A=
# ./mqtest=0A=
RX: 385/397/7690=0A=
TX: 377/385/4244=0A=
Accumulated time for 100000 getppid, 16922910ns=0A=
Average time per getppid: 169ns=0A=
=0A=
BAD bisect results:=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
# uname -a=0A=
Linux axxiax86-64 5.8.0-5-10befea91b61c4e2c2d1df06a2e978d182fcf792-bad #1 S=
MP PREEMPT Fri Jul 29 11:01:19 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux=0A=
# ./mqtest=0A=
RX: 524/530/5310=0A=
TX: 512/519/8775=0A=
Accumulated time for 100000 getppid, 16921865ns=0A=
Average time per getppid: 169ns=0A=
# ./mqtest=0A=
RX: 520/525/8204=0A=
TX: 514/522/7420=0A=
Accumulated time for 100000 getppid, 16931493ns=0A=
Average time per getppid: 169ns=0A=
# ./mqtest=0A=
RX: 520/525/8128=0A=
TX: 512/519/5340=0A=
Accumulated time for 100000 getppid, 16921535ns=0A=
Average time per getppid: 169ns=0A=
=0A=
=0A=
Test programm:=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
#include <stdio.h>=0A=
#include <string.h>=0A=
#include <stdlib.h>=0A=
#include <stdint.h>=0A=
#include <sys/types.h>=0A=
#include <unistd.h>=0A=
#include <errno.h>=0A=
#include <time.h>=0A=
#include <mqueue.h>=0A=
=0A=
struct sysc_meas {=0A=
        int64_t min;=0A=
        int64_t max;=0A=
        int64_t sum;=0A=
        int64_t count;=0A=
};=0A=
=0A=
static inline uint64_t __cputime_get(void)=0A=
{=0A=
        unsigned long l, h;=0A=
=0A=
        asm volatile("rdtsc" : "=3Da" (l), "=3Dd" (h));=0A=
=0A=
        return ((uint64_t) h << 32) | l;=0A=
}=0A=
=0A=
static inline int64_t __cputime_ns(uint64_t cputime)=0A=
{=0A=
        /* Note, it is assumed thatTSC clock is 2.2G */=0A=
        return (cputime * 5) / 11;=0A=
}=0A=
=0A=
static inline uint64_t __cputime_get_ns()=0A=
{=0A=
        return __cputime_ns(__cputime_get());=0A=
}=0A=
=0A=
static void sysc_meas_init(struct sysc_meas *sm)=0A=
{=0A=
        sm->min =3D INT64_MAX;=0A=
        sm->max =3D INT64_MIN;=0A=
        sm->sum =3D sm->count =3D 0;=0A=
}=0A=
static void sysc_meas_add(struct sysc_meas *sm, int64_t value)=0A=
{=0A=
        if (value > sm->max)=0A=
                sm->max =3D value;=0A=
        if (value < sm->min)=0A=
                sm->min =3D value;=0A=
        sm->sum +=3D value;=0A=
        sm->count++;=0A=
}=0A=
static void sysc_mq(uint32_t count)=0A=
{=0A=
        int fd;=0A=
        struct mq_attr mq_attr;=0A=
        uint64_t ts;=0A=
        struct sysc_meas sm_tx, sm_rx;=0A=
        char dummy[256];=0A=
=0A=
        if (!count)=0A=
                return;=0A=
=0A=
        mq_unlink("/sysc_mq");=0A=
=0A=
        memset(&mq_attr, 0, sizeof(mq_attr));=0A=
        mq_attr.mq_maxmsg =3D 10;=0A=
        mq_attr.mq_msgsize =3D=0A=
                sizeof(dummy);=0A=
=0A=
        fd =3D mq_open("/sysc_mq", O_RDWR | O_NONBLOCK | O_CREAT, 0666, &mq=
_attr);=0A=
        if (fd < 0) {=0A=
                printf("ERROR: unable to create MQ, %d\n", -errno);=0A=
                exit(-1);=0A=
        }=0A=
=0A=
        sysc_meas_init(&sm_rx);=0A=
        sysc_meas_init(&sm_tx);=0A=
=0A=
        dummy[0] =3D 0;=0A=
        dummy[sizeof(dummy) - 1] =3D 0;=0A=
=0A=
        while (count--) {=0A=
                ts =3D __cputime_get();=0A=
                mq_send(fd, dummy, sizeof(dummy), 0);=0A=
                sysc_meas_add(&sm_tx, __cputime_get() - ts);=0A=
                ts =3D __cputime_get();=0A=
                mq_receive(fd, dummy, sizeof(dummy), NULL);=0A=
                sysc_meas_add(&sm_rx, __cputime_get() - ts);=0A=
        }=0A=
=0A=
        mq_close(fd);=0A=
        mq_unlink("/sysc_mq");=0A=
=0A=
        printf("RX: %ld/%ld/%ld\n", __cputime_ns(sm_rx.min),=0A=
               __cputime_ns(sm_rx.sum / sm_rx.count),=0A=
               __cputime_ns(sm_rx.max));=0A=
=0A=
        printf("TX: %ld/%ld/%ld\n", __cputime_ns(sm_tx.min),=0A=
               __cputime_ns(sm_tx.sum / sm_tx.count),=0A=
               __cputime_ns(sm_tx.max));=0A=
}=0A=
int main(int argc, char *argv[])=0A=
{=0A=
        uint32_t loops =3D 100000, cnt;=0A=
        uint64_t ts_a, ts_b, acc =3D 0;=0A=
=0A=
        if (argc > 1)=0A=
                loops =3D strtoul(argv[1], (char **)NULL, 0);=0A=
        cnt =3D loops;=0A=
        sysc_mq(loops);=0A=
        while (loops--) {=0A=
                ts_a =3D __cputime_get();=0A=
                (void)getppid();=0A=
                ts_b =3D __cputime_get();=0A=
                acc +=3D (ts_b - ts_a);=0A=
        }=0A=
        printf("Accumulated time for %d getppid, %luns\n",=0A=
               cnt, __cputime_ns(acc));=0A=
        printf("Average time per getppid: %luns\n", (__cputime_ns(acc)/cnt)=
);=0A=
=0A=
        exit (0);=0A=
}=0A=
=0A=
Complete bisect result:=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
commit 10befea91b61c4e2c2d1df06a2e978d182fcf792 (HEAD, refs/bisect/bad)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:27 2020 -0700=0A=
=0A=
    mm: memcg/slab: use a single set of kmem_caches for all allocations=0A=
=0A=
commit 15999eef7f25e2ea6a1c33f026166f472c5714e9 (refs/bisect/skip-15999eef7=
f25e2ea6a1c33f026166f472c5714e9)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:24 2020 -0700=0A=
=0A=
    mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()=
=0A=
=0A=
commit c7094406fcb7cdf4fe1de8893f0613b75349773d (refs/bisect/skip-c7094406f=
cb7cdf4fe1de8893f0613b75349773d)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:20 2020 -0700=0A=
=0A=
    mm: memcg/slab: deprecate slab_root_caches=0A=
=0A=
commit 272911a4ad18c48f8bc449a5db945a54987dd687 (refs/bisect/skip-272911a4a=
d18c48f8bc449a5db945a54987dd687)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:17 2020 -0700=0A=
=0A=
    mm: memcg/slab: remove memcg_kmem_get_cache()=0A=
=0A=
commit d797b7d05405c519f7b62ea69a75cea1883863b2 (refs/bisect/skip-d797b7d05=
405c519f7b62ea69a75cea1883863b2)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:14 2020 -0700=0A=
=0A=
    mm: memcg/slab: simplify memcg cache creation=0A=
=0A=
commit 9855609bde03e2472b99a95e869d29ee1e78a751 (refs/bisect/skip-9855609bd=
e03e2472b99a95e869d29ee1e78a751)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:10 2020 -0700=0A=
=0A=
    mm: memcg/slab: use a single set of kmem_caches for all accounted alloc=
ations=0A=
=0A=
commit 0f876e4dc55db5fafef774917fd66e1373c0f390 (refs/bisect/skip-0f876e4dc=
55db5fafef774917fd66e1373c0f390)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:06 2020 -0700=0A=
=0A=
    mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h=0A=
=0A=
commit 4330a26bc4527f1d8918c398ebc983574f761cca (refs/bisect/skip-4330a26bc=
4527f1d8918c398ebc983574f761cca)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:21:03 2020 -0700=0A=
=0A=
    mm: memcg/slab: deprecate memory.kmem.slabinfo=0A=
=0A=
commit f2fe7b09a52bc898ec030d4fa6f78725439c7c2c (refs/bisect/skip-f2fe7b09a=
52bc898ec030d4fa6f78725439c7c2c)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:20:59 2020 -0700=0A=
=0A=
    mm: memcg/slab: charge individual slab objects instead of pages=0A=
=0A=
 commit 964d4bd370d559d9bd8e4abc139e85d2753956fb (refs/bisect/skip-964d4bd3=
70d559d9bd8e4abc139e85d2753956fb)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:20:56 2020 -0700=0A=
=0A=
    mm: memcg/slab: save obj_cgroup for non-root slab objects=0A=
=0A=
commit 286e04b8ed7a04279ae277f0f024430246ea5eec (refs/bisect/good-286e04b8e=
d7a04279ae277f0f024430246ea5eec)=0A=
Author: Roman Gushchin <guro@fb.com>=0A=
Date:   Thu Aug 6 23:20:52 2020 -0700=0A=
=0A=
    mm: memcg/slab: allocate obj_cgroups for non-root slab pages=0A=
=0A=
