Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2105ECAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiI0RYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiI0RYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:24:03 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013007.outbound.protection.outlook.com [52.101.64.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68F61D13B2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRKo55vwENZVZwNJP/7B3Ab3MSY8KRXJdWUCAx+bDwc6HIQQ2PNtrONBuc5zYkAvZcsU8wxUTb/gQ9jYQx5SD/agxJ14FbqTSEldK5E9dGdSp42ZaepIIVdeC/dIXZpI8nsa0oUc2MXfGdcIJvVYNAao+G+Vj7MSA3WnRZ2ZwrcHZIEH+BLtgxdFTMYh76txeWZsy/+IDwsWEm8bdIFhIA2JZuWpPYs5OdkiXO9k1waMZVAHQI2ekQisoq2xIbF0tWD+KwsIytaHTJVJwNXsyQaeKqJFRKZ5xmomzW0V2ovEzwq0FrpM9iCwGrxS+SCJixXv6zOGluSq0u1qQba8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia6oM3AD6n2MmQdVK7h4A9DbQjU3HsPDYTkAldx9Fj8=;
 b=XwT6DApa8lfP0GOOm6S6YMlRPRW/BsP56y/SwQa0ULgQXc7SJGgtUruzLqG651WorwReO2p+N3erUuVlchjYsa5I25DkHfI0KA2XZEG/KZUNisrkeibcStV3/xeXqYgo3wIDwvNF02bVgkhOw4XzYUsoOG35dRHAHKDvXFwreJr6bqOpyg5g5thd2fErizcYE5E8o+Ar3jOrCXAUqJJKWoZbfnnxv4dO7ZgyuxAZLAbYIlXRFQFWJT3/895o1Nc7oDTZycntdY5E3cqBwoNMYMcRADKGSXwSZxBBVJQ8VRX+uYE8OaS31f+kzktyUgynRi+a2E3FoXnLkNLvHy6s+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia6oM3AD6n2MmQdVK7h4A9DbQjU3HsPDYTkAldx9Fj8=;
 b=E685+84anXhkc5YQhGuPwERgITtzly/QS/Hok0kXdx7FD9PaAupoyT1A5xr6l8h8oGTRomqGOOiArwZpBWHgmOGT13FtUPcjc4k8+5qcpvfrbcq7PAvSTrwC7ZWk90AaX1musI3a9EbZAhb+SmDv73bGubT6dj/rrRB/xGSZmXE=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM5PR0501MB3720.namprd05.prod.outlook.com (2603:10b6:4:7f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Tue, 27 Sep
 2022 17:23:59 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 17:23:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Chih-En Lin <shiyn.lin@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
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
Subject: Re: [RFC PATCH v2 1/9] mm: Add new mm flags for Copy-On-Write PTE
 table
Thread-Topic: [RFC PATCH v2 1/9] mm: Add new mm flags for Copy-On-Write PTE
 table
Thread-Index: AQHY0o4TGaHeGtC3e0eJKfLo70c0MK3zhr4A
Date:   Tue, 27 Sep 2022 17:23:58 +0000
Message-ID: <60437F8E-F4A6-4008-9385-F8DAA9C2EA5E@vmware.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-2-shiyn.lin@gmail.com>
In-Reply-To: <20220927162957.270460-2-shiyn.lin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DM5PR0501MB3720:EE_
x-ms-office365-filtering-correlation-id: 0bc8d02b-3576-4443-531d-08daa0ad1034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a2H7Nn5shmMwhKIAakeV22c9gDxwzIyhp/7j/xKWca4CTPn10bll12ybDyiE0ZcY+fcp1Doo5AdT+132CPsydAxmdnhzb/i5UGmIfa4ONAb+0gF4oLghbbRSJy2PdeckFpo3CL5R/rZVc7YIyKfnld6WEuKleIZ2aEfmsMl7l/iD6yMEp7Ics0JN/pXAgsRi8Y/7ylE8sYYQ5WbwhWLm/bPQkgO/MOqnIlsl4zM7oU73Z7W3t1w+H3Iymfa9tzHUBHfYv3j3aRRcOtklRb8krTCY6VZyIBJGfmywDCGBKSEZuHTWyQUkndeJsf8pLdvbg6d7s3dhnLxNGHbdgqCHpGmexLjdz2N14tEPt6CjrgheMhG31iNiDZZLhWsVyiwB/TURYTzdi1oSKRBYU9Xlo17HR1ZBFqsspbZ6zrzGno7XwrLSN4rTt1PkrDl5faAX8POyV00T0KB5JgXtyA9P7de/ish25HJdPUDHs1TdwC3XfaqSAZETpgIbfWEInFH4G3sqO7QKaz33/TxXDJ0YXaFgOqwtFskZUxqsx6+tMasax577VO7fKwGKnmbMIvWb2/rw0QyQSPtO5lWjuxYKgX62+JG8M3uViVXXSonNvPFk4qt46Y19rvCY1mFFD8pxn57V4Ugs2HvjrhI/1mkcxnvvMxa88m/kkSJu3IJ/Oy7XQAA23hhpf9DNVmPz1NIhHrW/81f/e2jBPqr8H6+NS1MhaiPC7YrWbE6HMoTMWuJlKZLvcpxFIoE0gmfK99U/ZImsssXh548W0GxjE0phLJlfCoILducGWsplNLvYZq2iIb0z/t7DTS12ESLicJasANJFqxDhlTgJWIHafoDl992d347maJVKQMXIoCxQz/g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(86362001)(66946007)(8936002)(478600001)(71200400001)(2906002)(6486002)(2616005)(33656002)(26005)(54906003)(36756003)(6916009)(6512007)(83380400001)(38100700002)(7406005)(5660300002)(6506007)(316002)(7416002)(122000001)(66446008)(4326008)(64756008)(186003)(53546011)(66556008)(38070700005)(76116006)(41300700001)(8676002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5o5szCXBurffgrjXk25+qPEjf9E9WcNGdjseuNKk/10Et50tUKvQc6pUVw9J?=
 =?us-ascii?Q?QbScBh35ZCJsJEBwxs/wM6z3P9SD0puIi0Uiv2QCGB8217OQEckHWG97qUP2?=
 =?us-ascii?Q?f6E8LhEyJe6AOUDUU1WooXWZL+Rd4OOS8EdWwnE3aly3T72UIN8CwsnwZpVi?=
 =?us-ascii?Q?hZM8gz+c13werF3V6Pvf8LdGNixLrmZDHlCBLkLRq9yIR6KgSAqcsnCBGSMV?=
 =?us-ascii?Q?wVIW8+/c2qpXe6Fi11dDaT9woLvCCWMOxBaf2czNEJNTFi9Li7HnBCE0lE/D?=
 =?us-ascii?Q?m5SRfX2/3hJUOw2EsuYUr3fIlFi3dNgrf0gTzMK750IfCtXcZAhCW5MtSxul?=
 =?us-ascii?Q?MojnUCmgNc2FR9YeNEZQ6LzBOx+CClfD8+A55WmsvY7HKPFcVpcWfqL1R/h4?=
 =?us-ascii?Q?O2vIHbeD+utJLroSyFTtUv4tfZBDMhxOTUSSgbD5QJ/rvc+pG50+GCbVIOuD?=
 =?us-ascii?Q?C0JjCxN4gnVKMAyZoVVQOh7yLgSEP/R/soiCyDjO0WSuhCmGOPe74RJ01+3e?=
 =?us-ascii?Q?NVwGCIVJ1/aDdHpHCH/qdSO5EXkjZbUnSGc6ydilqSPQ581oiGsYHzxgrtoA?=
 =?us-ascii?Q?f/BmtAmhmrPN99g3DZX63KVmVpziRTofpJaAQbABSz//CKBlCCGVLjCi2H1P?=
 =?us-ascii?Q?MmmWKWMFmNovu3HML8Idrb9aIUpRZ4ns5d8Py9Txn1sVbMm2sxUsec1VDhRm?=
 =?us-ascii?Q?cUe0C9cXcRdgDYAx8S1Dp1FRDi05qSzk2celspA2IjzlYNmyxyWbZVAa1aI6?=
 =?us-ascii?Q?MZjU4PAeHEsp2WDIRvAs7TeoGjRCibUZQDv0MV3mwHqutaOy75ILwjfNhbxL?=
 =?us-ascii?Q?ce9co6wr7XRw3wKOvohNJZe2EBDeLNgUrr0fSGuMd8bpy+XJ5y4CVHkddgxk?=
 =?us-ascii?Q?3sa21kc2Seueg/WH13ybFREVIlWr/aZNDCR+4TKUgMq2GmBOT+VfIlVUmSO6?=
 =?us-ascii?Q?ZgaFCwPjwo9Ook95I4lefHNdgG9lBbVgM91e3lABhbQH35WeqqJ73xEKdUqi?=
 =?us-ascii?Q?uUbt91tIw1hNcsl6yg/w8uTKiYNT5RXXkBHbfXIQRDg3qdyK6X1193ICnHQf?=
 =?us-ascii?Q?PX7aiZnVzYgZ14uj2nsDuQmNHor5gY0FmUqXcxKRIj+PuFaZaT+oJa3cwCPB?=
 =?us-ascii?Q?OZr8NYHiYfg22H3zpydfpefL+Ac+FOrXlIlYeQFQONPVAmQqc0iPUL7cxhaC?=
 =?us-ascii?Q?uIq+sdAWvhEum/rqzEz9Z0187Hyhx+B/JNR1bHNgHYlG6ofot1XWPeJEa3Ds?=
 =?us-ascii?Q?2ocaegSMQ/x1pKWOK21T8lBKoWz20dpB1siXTOQqSszHWXIROvJZX1Nv4gZa?=
 =?us-ascii?Q?kzvMzqzYY7ETYPsGh8D+4p9O6wMYBOKemF4RPLXTTKJI2FXvEADOme6Z2261?=
 =?us-ascii?Q?5UcujQp7K9v0CJ7ZyrjUX6g7nmI96pORFqENan0hBDazGAvT+ElpmG6hI3ZY?=
 =?us-ascii?Q?tsZ05S3MYPF0ZANtE2LJ+qv9d95kf7AXYeE/jvsvcRYJ6BcnmsN1R7HJ0oMX?=
 =?us-ascii?Q?pU6W+LborQbja8fU85HDOl2xJ/q7IWoDZ3P905Kf2l3ce2G7aijxW/Njtj/g?=
 =?us-ascii?Q?QHBenDvYHOyP2NKQ5v+QNivDoK/CuWCexN7bqyjh?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B99F900489A165439D11DB0ECE99866E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc8d02b-3576-4443-531d-08daa0ad1034
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 17:23:58.7372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2xNTBKKJcXDO8eJgwW8TOIOFhyr5JW56q+/BLcpACRCRHySKW0Hu7wq5Ve1z83X7jk9Hms8XHVKp7ywfCJ1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3720
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

> Add MMF_COW_PTE{, _READY} flags to prepare the subsequent
> implementation of Copy-On-Write for the page table.
>=20
> Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> ---
> include/linux/sched/coredump.h | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredum=
p.h
> index 4d0a5be28b70f..f03ff69c90c8c 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -84,7 +84,13 @@ static inline int get_dumpable(struct mm_struct *mm)
> #define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
> #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>=20
> +#define MMF_COW_PTE_READY	29
> +#define MMF_COW_PTE_READY_MASK	(1 << MMF_COW_PTE_READY)
> +
> +#define MMF_COW_PTE		30
> +#define MMF_COW_PTE_MASK	(1 << MMF_COW_PTE)

I am not sure how much sense it makes to put it in a separate patch, and it
is rather hard to understand the new flags without proper documentation and
comments.

