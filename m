Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7315ECADC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiI0Ras (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiI0Ran (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:30:43 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11010005.outbound.protection.outlook.com [52.101.51.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0CDABF2E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhWqXq9kG5xazFhOfGYSs7JUakC6RdrsY/Z3E0oXyk9n7w5+xOAsB7onowtYjXPKb9C3Eq5ecQjQdPr+9iJjA/rBAg3g8oH6uaMA9q3YQHvM2J8jPvObHR6q3JQ289OwX19eOlz7vqBpIbhlRxE/QcLVG4HM/STFAO/LrQ4d+ZfPOd85k7vdPTrnUgDbMI6AG4mnkD17Afn1jBCySRh12r8CiE9vMAt+gMEojDMOeTKqk4t0n5J4+Y4zjXs+wlfSp7n5AuJk7/uElKmxSQ7GfuFSrQi9ksGPAfgFfRNibHh4bO9S8ydWCghDwfLrJEw3YJbaNS2cJ5Idf1TKwGRkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtzeYhySMjvQmHWlSL2i9vWhVHc1bGQZ0Az2MvwbdyI=;
 b=mqjMo4Z02KkES0e4H5n8Jp4io1j7tFoVOtBNx1wSapM6MbXLuLssH0YIs4uaLO4CxAgxFW0j22td9GjxMOD+nLcYoQ0VCfvZ06zzWIqrHsTX+0LACpLOjdn3gu/IIfSLRa4welvACQyw+FZHjiXKBy2jW7mn3fyLY22LeaijOJPEkm4t0ywP5ToqUKLWaazyayRr1RDgPIzmjQINB0tIVsjbZ6+mKRcY2XPwr8QHCeYznXK8xNC/A8e8asqjI0RpsdeJze/zvJYcuJelheI/em22UA358HjKS9+HgzvmDRrX5Ux4VnL2beTimzrPqfKHOWrvJBEkLqn9hSlu25JyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtzeYhySMjvQmHWlSL2i9vWhVHc1bGQZ0Az2MvwbdyI=;
 b=YBrwbxUZAUwGMRDqDN+kXT5+f9FCodgiQU58Lu5/nai9B/rGGhykeuWfQxuwoQehH3LQvAtwBaKGmvvJHpVMxu1M9AuIMpw3W16tur1GXru4xt0ivP4VCV1bdJ0lOXL+1HoDhJ3nDtCcqJ9lj4Qp/MK02s8OjpKKulls879iW/8=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN3PR05MB2418.namprd05.prod.outlook.com (2a01:111:e400:7bb4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.8; Tue, 27 Sep
 2022 17:30:39 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 17:30:39 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Chih-En Lin <shiyn.lin@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 3/9] mm, pgtable: Add ownership to PTE table
Thread-Topic: [RFC PATCH v2 3/9] mm, pgtable: Add ownership to PTE table
Thread-Index: AQHY0o4d02iFGEmJ0k6DfjGH6P+1aK3ziJsA
Date:   Tue, 27 Sep 2022 17:30:39 +0000
Message-ID: <2A6CA595-1F8D-4A83-9E85-E2C4392395CB@vmware.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-4-shiyn.lin@gmail.com>
In-Reply-To: <20220927162957.270460-4-shiyn.lin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BN3PR05MB2418:EE_
x-ms-office365-filtering-correlation-id: 03d62068-df04-48af-1884-08daa0adfeed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIjrtaumRzMS4VKWpzR+6dxRDOzW5kFvWyhNcahEHvKc+yKLITAHKg9acil8v+gInT5yZz3u8RzdBHi/0YoUowIdyqq9oNiZXSiLPRx7U7nl6TdpWd+GdlTUBWx0SElO1qFtYfiEnDjrC2esrhGZ27qWMkGQ+TFEhzBjtMFp+dKbcB4Us+Iv6XFzl9myz5LqRinJbxsL99QvahWt7xs4BJVpK0k2a4+2sf1jPEwzfL2X44j9mCrDgDa3s9miztz6DAun737VgdsbPGMMn1fZYq59oxynmnA5jcFEwhhmb2Trev5iocOxhzDSbUTS82N1B1OiftblvW4drJHH6sQWwseU39fDxx2YxBEl6hvTXXmf9vEl211rmMysZ3rCdVEFseS4/qVltCUlwpJsIj6NC/UGOmbaczUbKqJSy3oiSQeLVPzTOF08kF70cZx1PXBCIVeASLykT0LaBGFI4icLgcfuUv5RVUa8UgqBjUgpg2eCGNCPQCurTp8sWuh4dCe+MAjVm9CJN9zISVM+LxbA0jbwUtCsR9Vm/nA7UuLgIEmD5euZZbLUGa3Ug6wdhlwY0HOgW7OYqXw4KrlnALWnUK706dg2xJ9KEGX2HXcEqVKUt0Va/XcNmu4pAp5cvDqzcmigwUlod3u7JwSjxdTLJQy/wV5d0X2tC2TE/6zO06QWCYWP8AHJ5NsqLNrsj/L6+2RwVLbhg3D86DNjOdbjGD2dLAfYCF5J8L/gxPhHfEpB2ig2CK8B+wStoQ/gu5iHy5+jgwEFWN+uNY4QZWWMbSqTM1E2OwDbAl0tZsW4WTPeElidwtfyQ9ilSky6VyU71PFNwoFGH/GmiZ158P0x+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(7416002)(122000001)(2906002)(66556008)(64756008)(53546011)(7406005)(41300700001)(83380400001)(6506007)(76116006)(66946007)(6512007)(5660300002)(478600001)(38070700005)(8936002)(38100700002)(36756003)(6486002)(26005)(71200400001)(6916009)(186003)(54906003)(8676002)(86362001)(33656002)(316002)(4326008)(66446008)(66476007)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HMKA7SzJTN9FS1YIce3SKGZ3HoBsCoe1HY2gTKPJD0O9+xne+WBoPH1+RwtY?=
 =?us-ascii?Q?r2dhvtjCMrT2EJCzp22y0S1dY9bYGp66fCjyNgHMdJM9Xh17s2hOFf1gMqew?=
 =?us-ascii?Q?cHdDPAI6Avzg0Ik3wHgnz838j41LNfFqjk6KK9wo6IfD+4gxcQydAitkoXAE?=
 =?us-ascii?Q?jsXNZtKu8LtvoOiCu7OQHZTF/tBAu3QKOVgjysXBuX6ThFPNCDgG7Wpt1AjR?=
 =?us-ascii?Q?/CrftbSELFagxpwJSXoO5SpguBXw5UBTE/9H3XL43TvWgzLJkr9S2bLOu5jM?=
 =?us-ascii?Q?gifu+1bR2FBbG9CdjrMMyck5QXj/3Z5cWaQdjH9I2r9uASv8F2shhKFYis3e?=
 =?us-ascii?Q?mSbuIgZK9oaB7BAsPq/fSBVzJSpgoY3tVLaQFMbuOKtD0Zn+AL9GRtj/d/Tx?=
 =?us-ascii?Q?LBHBxKUjsDGc+dSmtSWQ08S7Tw0B2BSUIjxXVUez0Fca3TgExA4ujXiEdh39?=
 =?us-ascii?Q?8auaMopRn+4UMmZPuIqjEleoQEIeTQfxIY2cEv5WkYmDpwWJiio2cExTLNlW?=
 =?us-ascii?Q?L7/NIn2Fx52GD1qBzH2jHAa6i6XS2PLoJL/ssajWfe74Xqm3Ypwi0wMV7YRU?=
 =?us-ascii?Q?OBRWrFmFBVUEwl8ROmq8kwj39wC2DDlb5h92UA8oq9id+7sm5uAjgA668WGc?=
 =?us-ascii?Q?QIekjy5Uc4Hy60gQYFlxscsUqKuPZ+q/0uS+telGPEj2WjxWKPoq0HFRe3MA?=
 =?us-ascii?Q?d5AuJHSq/7xdI0j+v6FMsddJleaD7Hg71DCctshD8GcM6VWxXaoM77errgYZ?=
 =?us-ascii?Q?fo5tcZmDwRzRduXTqLVaAxEseUvqe7vkwvO9hch7+m7dJ//Er/BGCA2Z0wlt?=
 =?us-ascii?Q?TgLcx4gvhQ32uanF1cCkIsh5q1o1KeoJ318Zy7mtOaphrt9f97lStTyR5Die?=
 =?us-ascii?Q?8h7UozJdRxqlAVpf+ZNgsrUw/mAmYlV/sybXkEp6/lMaSBQjyqU4Pwmg0IE6?=
 =?us-ascii?Q?QZvga//3PivDU9lYUI4IztI2sJmfOsiLbhZQXujDTAe+y1/oMD1jj8QuEWxY?=
 =?us-ascii?Q?hXnwVf4x6HSpv2HCPR0ukIH9yVHqu9dyOY3Li893mXt3fGZbuVMOC3K2FKF5?=
 =?us-ascii?Q?o7leshHhQUVovMdZ+Xp93DqPIEO9Znp0kQH0igrvuwmBW3tzWvmVb6qfySjC?=
 =?us-ascii?Q?7vsTcT3J6v/I1kqp0dZ7I2pye/BHkSvTmbyB22gASHegdy9b/mRmOrkW7A+h?=
 =?us-ascii?Q?Ew2AlpAvEu7tdyQV1xvZ5GL9oLq343DfqtTu/KDYEeUA4vkKmz6d2ey2Tjd0?=
 =?us-ascii?Q?k/K+fyPRsfDJOZXNYbm+D5ugj7/2vnnwLJawbEBmDCzrL8A5veNLLIxcZZqK?=
 =?us-ascii?Q?mWNFFoS3e87sPCXU/lWjmu9f52onmf1ChGEt6MgF9gcFm9P4bnLlq16T5g67?=
 =?us-ascii?Q?F6n39hs3LdbWOAo9/PoWTcYPkFuz3tC+i7imBV2bGRgKvHz0CbQkk7vUyeqi?=
 =?us-ascii?Q?j+TcGkRu/zzRxF6b1qyK40D+YUyIadVqqjfG7fR3xnlopFMBNFLzkH518pUv?=
 =?us-ascii?Q?UyN1sj0/dHacB0h/Tfy087gS9MyXr2gbADhtEF4GGWkzuayFdsjJY6+HMf0/?=
 =?us-ascii?Q?QkorkbAduxtT6Olh2vfRmy9rEJQR+FnDYjMkExJ6?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FABEF823C97AF4886BD7FA075BAE33E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d62068-df04-48af-1884-08daa0adfeed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 17:30:39.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzcoKrnSSzIW5BXvaGXcuN9PS7rkWK1o/K8l2PX37pBrNrsAgRYl+XJV8UIK716IcBZOCA5NNY9gfRolMVe7HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR05MB2418
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27, 2022, at 9:29 AM, Chih-En Lin <shiyn.lin@gmail.com> wrote:

> Introduce the ownership to the PTE table. It uses the address of PMD
> index to track the ownership to identify which process can update
> their page table state from the COWed PTE table.
>=20
> Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> ---
> include/linux/mm.h       |  1 +
> include/linux/mm_types.h |  5 ++++-
> include/linux/pgtable.h  | 10 ++++++++++
> 3 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 21f8b27bd9fd3..965523dcca3b8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2289,6 +2289,7 @@ static inline bool pgtable_pte_page_ctor(struct pag=
e *page)
> 		return false;
> 	__SetPageTable(page);
> 	inc_lruvec_page_state(page, NR_PAGETABLE);
> +	page->cow_pte_owner =3D NULL;
> 	return true;
> }
>=20
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index cf97f3884fda2..42798b59cec4e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -152,7 +152,10 @@ struct page {
> 			struct list_head deferred_list;
> 		};
> 		struct {	/* Page table pages */
> -			unsigned long _pt_pad_1;	/* compound_head */
> +			union {
> +				unsigned long _pt_pad_1; /* compound_head */
> +				pmd_t *cow_pte_owner; /* cow pte: pmd */
> +			};
> 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> 			unsigned long _pt_pad_2;	/* mapping */
> 			union {
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index d03d01aefe989..9dca787a3f4dd 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -615,6 +615,16 @@ static inline int pte_unused(pte_t pte)
> }
> #endif
>=20
> +static inline void set_cow_pte_owner(pmd_t *pmd, pmd_t *owner)
> +{
> +	smp_store_release(&pmd_page(*pmd)->cow_pte_owner, owner);
> +}
> +
> +static inline bool cow_pte_owner_is_same(pmd_t *pmd, pmd_t *owner)
> +{
> +	return smp_load_acquire(&pmd_page(*pmd)->cow_pte_owner) =3D=3D owner;
> +}

Hiding synchronization primitives in such manner, and especially without
proper comments, makes it hard to understand what the ordering is supposed
to achieve.

