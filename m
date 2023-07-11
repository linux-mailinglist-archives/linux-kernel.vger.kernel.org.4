Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF1674E3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGKBsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGKBrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:47:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56C4A4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq1C86amgCw5hkQVyqkJBryWV9JCl2OuZUuZlCW0c6uImET5a2dd2XMEJe+/k1AExmv4MbWDYvK4oABKj9VsfxCSkRpu4TSIZsdK2aEkyVYD+lSDwZqtb+2pFHC1RDuobEO4pRbBJofUrgY3rkSS5kxw/Hlhoz5zYApqMrQpdya4eALODfsWJ8uia3GJWiP2dosRxq3nSB+3oewShsCtBL3t94DZrYK4+FG3RF28HhOR/MyG+nvcT/x6ylQT1PaMelgbUwD4I0lZ/Oo0RgnAe9bq5iWhrcelKuEwcOWijl9PYGEkcmin+lMVfcLBpYGcOnqxp1fNrjYkhiYttNzYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBWQZsDOtXuk08s4pWql4IMoVFmyl6Si30x2ajHCXOc=;
 b=USnHdbaBKDNFGYz9R1FXG2V1X7tn92ALOSvyG8IOpP+e725E4wVeDRHaT+kTcaNNgdkm9Auu5XRIiqq4SCOsk+EzBLCK9RzWA5X57F4dnNYwGS8q7Me1u5MCb+guptmGWueuGRiCs/STIgqpOoP2P3v5wNvlRWpC93ZI9go/XeIwLkHizKi99G+ZVZoTAA8LjNaAC3w/PHXjfy5J/YpQPHZUIl1xzlmbCdml8kGBOHF31r+Kspe9NuPFVa4eQ20PdlsbUrc+aYx6hoJwiVjjGBVj9cX20qOh0aWrU/0uY1ZPm7eathqbsH34LuOtrC5k069o6kq7MYUHi3msYpmZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBWQZsDOtXuk08s4pWql4IMoVFmyl6Si30x2ajHCXOc=;
 b=PEdINXXWrlHgQGRfgbf7/03hOw0wwlA6Jrjt0Z5YOKVTlQqCfJ2xiaAi73KiSGBAKwhoGzn2UYN+I4+68Yi5ApAypb50JeRhbfx2I6/rwrobEPCeiEJCqXJdJEqvRLGugnnM4Pr3pgdw7Yg3lYLoT7BZKUA/IieuHtET/6anXDszMZjaKdhkdWuuK52zNduBZKvCFzY0bsS/zWQilpfCT/3lOJ4e4UbR+Xjp6clisIL/lYDaUkJNZT4oOc8SOAJXcVlsqCZLCxJee8i6/FNOHvOX58DhwTfx+Wg9XN+Fkgq1J/UU40ZMwJ68ff6UzivOz5hXGt5BHcQQH/q1AaIReg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Tue, 11 Jul 2023 01:47:50 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 01:47:50 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 06/32] mm/page_vma_mapped: delete bogosity in
 page_vma_mapped_walk()
Date:   Mon, 10 Jul 2023 21:47:46 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <7457B947-0099-4388-80AC-0C933C7A0531@nvidia.com>
In-Reply-To: <87475a22-e59e-2d8b-d78a-df376d314bd@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <87475a22-e59e-2d8b-d78a-df376d314bd@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_93CD7DB0-6739-4F9C-ACD8-0693978C808B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: f67ed6c6-55a3-4981-876b-08db81b0d57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxpIX5fwcFCTUIF29lhGUHwidDrRg/PwZPvHqiiqAeMLSSTSg5s9sV5ShONbqCQ/yWkCA0EAlxHlfR2OLDZZeNRIS/2YzraQf64ypUr3/FlcgPmF/cgwGtmfVrLxSmzEHVL3jul4HExqNoXNe4XgEfjX4Oguuvi7JSyOsg1IfiBzGaY+N47HeAAmyVybcYkFXdVboBKDQhzAlNBfVfsftLGyJKYHRqZRGwbPBvifYfH6aJWTtSv9gIGEcGkSyoNMOy6yF2YY/KpW2gVPSpcEMO0JJKplErs9LJEIiSG4FwOrv3XI7WEMIEbsGDM83JcdJGahLL2jtCluGcK8pVCK0CXnVzQo4iVnhN61IMIDrR2JpY+P6Hg+CkZBmN9oiGk01WW7ygAm7BNbgGXbop57GOAiH1eYFPlg+0Nr2h/mr8SntDAvVL08+NOkHLmrE7tZLfP4A5D/982i/IclX9dx1AABC/K7xfO5eYQ5129mjZnJnhV9ZrXwLO7v9aisUdhDHCV86gzuJ5zxVopcJkpX+ehGeorE+ptlos2atzyegoiGW5YLhCGYAFx8IZXEMHArPn8j4gFaoumjb3MizBA83XQIPm2gk1kQw/dxgpnzIrPepHvrQEaFSptat/V1u6VKb5TOU1PLoz+cx7Z22rOysw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(36756003)(33656002)(86362001)(38100700002)(478600001)(6666004)(54906003)(6486002)(6512007)(8676002)(8936002)(5660300002)(235185007)(7416002)(7406005)(2906002)(316002)(6916009)(4326008)(66946007)(66556008)(66476007)(41300700001)(2616005)(26005)(6506007)(53546011)(83380400001)(186003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CHr61cm7myP3qXz2O2+Qt2ehxcvxMKnXtZIWODC3jU0HtMpTjGHcDFoHZI6a?=
 =?us-ascii?Q?/tvTDRP9I3yGaladJvWgOqMh9gpxXKqnR/a5TtjDsrtrxupaJVGVZjjZZCCq?=
 =?us-ascii?Q?RcMusxaIUsQGR9Nx8PumQMrYvJ3WaHn9h5bKPEE7lD8xHalsrQAQTHesTZe2?=
 =?us-ascii?Q?cFAu/Y2mGQF4ivQ2hFfRcW4eqWE1TiHRyXXlh9ePlDFc0ipZPALOnq15yofK?=
 =?us-ascii?Q?U679YnuSOkUTfiJwEwCMZjRnhclz6ttwFPZWy0zfSbieGkUr5whLnqOCp71t?=
 =?us-ascii?Q?h433/1JOB3yrdyvUxQMUeh9A8A2lwzzaGETQvZDh4zsy/iZ/QjEY8qTJ3fQI?=
 =?us-ascii?Q?06rcKXRL47+Z8/hdqf06WUYV0DWOht4AdtLoiU7lyI9E66eBec9O89CUSdOv?=
 =?us-ascii?Q?XGmr/Drl6BUMKEpj1s14NsIcBn5XXGTeLJmzYlLl0hA29Dty+CqIdboqnI13?=
 =?us-ascii?Q?iqyRnQ1ZvRyv4ItM+iCgzImN2ONqT7BUu5jCTwAeOJffyiIkAxrDyCF61ZAD?=
 =?us-ascii?Q?EXvlzb0KhbwOIx0KG7pptO8LtwMHpg/+gmzbvEMgH/L1KaYhuKN/YZOVm7eh?=
 =?us-ascii?Q?RIwaIfirnSfaRRZ9AEyjxA5+2LorpprtYh//AvYbhvYP/OVhcPTP66NuasWl?=
 =?us-ascii?Q?J6+In+LHCUN2gqlYlaoqHXYWf6pjyd3ZNeQTYyXLBxXCkzs7PB4KvzaPvqVP?=
 =?us-ascii?Q?pgzyVVixGbnwF4/GDV60IDtcQCQZfRLbA08shWwFN/pruhEhl96lsvD0Jd7n?=
 =?us-ascii?Q?lwSNwqgzC0J9cO4lXCwJ1Yv0ILmdiwjtZteb84xSBlCRq+o6E2qyKpNHNWjg?=
 =?us-ascii?Q?0oP8xrpXgjJyPbnQwjZ7To/nzlHf/OcOfMJvhlsz/NWbazAdFuB1wK6C8ToA?=
 =?us-ascii?Q?fv3XHyNB/PsZpyDC54RQ8ePUc74lvhIXo542GalF4YXP014wRU3ToOmbgEZ3?=
 =?us-ascii?Q?OjzVV8rq+i9Vf3AFSV3EWRFUpBc0v3fH+SvkUlaEG4uSJGbYMx8hglIhtbJP?=
 =?us-ascii?Q?hULBuZBKI81MF13wk4VkixjqyETZEHbErvQQe77JC0G9R98x3vGUnVQS4SpF?=
 =?us-ascii?Q?K9PLJBjiwAd7TH4FE5M9jCZsSWlvIBllKJAyVP1W3OqpWD7pGy1JlynKpUxi?=
 =?us-ascii?Q?Xy9oE2sEKKqLHf91A/4fnElRyNjOBJgjalP5SG4oeQQNnim4Zv7ZDtyc17vi?=
 =?us-ascii?Q?u7pL2jxHnZwz5K/FseKYySCp8R0Y7QtY6hp3telsTF/WoDOacSBNYHs1w4qa?=
 =?us-ascii?Q?No6zSGXOOx4aD4/dE8sZmGg6fF4gDIE2PbmQJfyLdpwBTp2RYHVp45RtfQRP?=
 =?us-ascii?Q?+WXKKT21r1kEdFsEtHRrfj79Tx1u1Gonr5Ng/xbj8Xmjw7enE4Hw9JlytZ7H?=
 =?us-ascii?Q?gJkmJ0To61hkM5cwpOd7T9q77RWPRHK1s0bazwuRhGGUlK6rxFBmwqUDuqMq?=
 =?us-ascii?Q?ynJNOfiAAZpwDMAKSBSKw76NPdhyfJZEEbEGKsMTN92S0KO4Fdu8qJiJbcRi?=
 =?us-ascii?Q?JzNoPgmfwG0Gsl3lmNzYlgq9wyamRdRGDIdj8s5HIzyGuYclSCR40BwHZDSp?=
 =?us-ascii?Q?3Q++3iFQ9N7kGkBp3Ko=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67ed6c6-55a3-4981-876b-08db81b0d57f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:47:50.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPguD5wgw6JqKNAP2HzWchFUR2eANshfnwiO8AE7P1bbXekOexkXV64x1yetmix1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_93CD7DB0-6739-4F9C-ACD8-0693978C808B_=
Content-Type: text/plain

On 8 Jun 2023, at 21:12, Hugh Dickins wrote:

> Revert commit a7a69d8ba88d ("mm/thp: another PVMW_SYNC fix in
> page_vma_mapped_walk()"): I was proud of that "Aha!" commit at the time,
> but in revisiting page_vma_mapped_walk() for pte_offset_map() failure,
> that block raised a doubt: and it now seems utterly bogus.  The prior
> map_pte() has taken ptl unconditionally when PVMW_SYNC: I must have
> forgotten that when making the change.  It did no harm, but could not
> have fixed a BUG or WARN, and is hard to reconcile with coming changes.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_93CD7DB0-6739-4F9C-ACD8-0693978C808B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmSstMIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUmBEP/1B5HvECkI+h2Ht7Q9zGQrFXkswG0mkBs+Jj
rrU9Q9snk78RC9cOwyjQz0Ep8vWrsWBoPxLaKlOrCDE9lVP5dON3456n1ZZjmM9o
UZ0GfQzRTl1VJSK5lfhjJjN833tU9K7xip9TD29rDW4mGik7XLPyJnnwzdXOcvXQ
ghs36zOy2zsBx4y6/iAm6OL+EaiVaZEHuB1PWYfPhsiHzZTlBEiSIAKq6l0FL4n1
IDyLLevaw1aIMzq/s2II24C0Ckserau6OvfE6MLv60oSMIJH6PhSCb1xxP6iN9+V
ovWx8YvqquwAPqSO6GEr/x3uw4Z8i8rwvEm2VzF0oo3rYc0kFhNAm7EmExoCkaLN
0UjrkwD7Kv7ioBwzSkH2qqJKhpL5GHSMh93gDh72QKOdKBjR2SX88MVhX4L4Shy9
YZ9dM4/h01nVdE4Nb71utUagHhajCib6RLjwItIcsWuoLczF5GRfZJpMPkUCarXT
xdexLuUx43PAP5tA9gOyn8etW89Qk7YwKZKRyhWcoSvqnQFGfbyJ0v243k4UmD9G
y21pG9+epV3ngHv08SGovQPLvQUDtGpxD6NAGDSezmP1q8gIkjOcID7X4FFokwac
/wsI26ED/+IRpEbS2Lpfq0jy59C5WU5HJpkgoVI/V4PO+Yaze0tVgXESnXxWrnmZ
+9BiaxGE
=mvP+
-----END PGP SIGNATURE-----

--=_MailMate_93CD7DB0-6739-4F9C-ACD8-0693978C808B_=--
