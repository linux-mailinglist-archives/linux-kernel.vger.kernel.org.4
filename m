Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8F5ECBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiI0R7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiI0R7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:59:20 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE731E05F1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzI7Mk72PAe4SuBr6XSaAgHPK5RyqWjnA5GhxzDx3SX75SHcUuDCQ0vLkDvy84xs/Czy+WgbN1sAhaCnKD9lYGamW+GiUdHNwNOaV0AZJp9YxUL5EkTgS5qqZaYAOSOPiB7tq7zKP6nXYC89Pg14lBAksYv34UAP/KJ8r7hmS9n3FtGJ3S2JOp6A3XIEqV6UMZsoW3nsIx+S6czWfsRKfMN5ZFln7YduLWL78oTVZZGbM9PgyKrBeg2ZuIDv489Lh00rlccoJuK9VkVzGRRETN5oH60DwIhgRlhx2Ko1MqH++iIdMSwwb0jCG2pKEkZxOGMxm62UloYsF2at8/nNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqXhcRYOIqdPcYLN0G1RCe+WywpfSyvJ3JMQUm6V78U=;
 b=EojWbPzaCK34gbI4PurtxiqLMLmcN58QdvaVh2bJYyu1kPidAy6bl3+yN7VEy8WB5ycUQr8FAh/ni+vZI45jt4AcucfWAmgy0uhKL9hPQIEzSCki5VAylb+a38kB0Rc16AtWkxAsxGWVpIPVEA5vOICt/AEwJmKHy9G2fSkcY8zJ9E4Vm3G136d0eYEwQ99cXyYME2zU/GquEOBjMgit+lh3BhlgcEc/tFDaalI1bgh3HwMAwKTDhgUF27/ryDufUwXurnCLGH4eH5BAzLvz0ABuFd12v+jDgBjdqVDk5eoprdD5seQqLYz+ygYrJ8C4cLeGN8luYKYHjGRwFp46/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqXhcRYOIqdPcYLN0G1RCe+WywpfSyvJ3JMQUm6V78U=;
 b=LbB44jAM4WecmDYc2QIJaS7pZWJcMi6RGGEbD2BY6QKQokgKa2BVnoow+5bA7VMw+DtVYN4kqNmfJvBF3ZvlCN0wjPF+zXQkknFzl9aXPt5PClYnCzRmhOuY3Hew12ESqV5AzgScjKUcHpqckK93aJmzY5OZ7hQuY8S9uRf4LeE=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MN2PR05MB6944.namprd05.prod.outlook.com (2603:10b6:208:18d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.11; Tue, 27 Sep
 2022 17:59:16 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 17:59:16 +0000
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
Subject: Re: [RFC PATCH v2 5/9] mm, pgtable: Add a refcount to PTE table
Thread-Topic: [RFC PATCH v2 5/9] mm, pgtable: Add a refcount to PTE table
Thread-Index: AQHY0o4iCb7noslDKUGe08SM0U1/R63zkJmA
Date:   Tue, 27 Sep 2022 17:59:16 +0000
Message-ID: <8C7248F0-55E4-4813-9167-C8CD2D02F1D0@vmware.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-6-shiyn.lin@gmail.com>
In-Reply-To: <20220927162957.270460-6-shiyn.lin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|MN2PR05MB6944:EE_
x-ms-office365-filtering-correlation-id: ad29cf66-03e9-4c57-d2af-08daa0b1fe58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqAAKkWoP5NZkb+JSWq92uCD9b+Q8Wz/doAvJEyhgVYNZd2mZBHD39Ru7TdeVIwCpsB5GxGdE53yRjjBYDTHUrvJnHOX5pQGOomX3fu+5YbgQB090xhCdFvN9TjVFra8fZAHgQ65HqmqwOZcFACezdfzHqPRfAACnCHn4lDrHiTrAZrauuClSQ2mfugQcF1N6M54Ii+jVDWJjHiF9rHAsPggpnSwm11ao0CndKuq/cJdXjh+wIAPv+XvISOcOoNZ6jkmfC6tfnlxl0A/RTaf8x/Zy0NQVOvIzaLH+sNLtbbYn05EzKUKbn7qZGgm5y4SCGseqCb4qKlDguoZh7zr3b6o94Ut+u0caKWQQKm6836HyO+QuLVZ1sND0cYxp13CKeMkl723rZ0nJKiAbPu/jf/fGTNosG3yi9TJGr6qi1bGgDLlrfIW66C2n1yOlp86FafR2CiTzQc0j2tYz7Rz8t7Fyqz1pjNPKkEhOL99YpUKSAhbIQt7zPKhJqasfsE9BUiw4sidadgXhmL7srN30l79H9XY2jjRKUX9Hd/SiSw2Kt7euk5XGob9u7pxs/jQf0KeBc3nbGjpVL12IgV4T1Pm1rYlExQT3QjCCn2FJgPRJy38t0csn8ehJjiUEkSkLpHyKBOB+PFXeGQuAlzZGGUuTyV+d1GckSxAiDl5wk7utOhzCbvkWEPae1qQvh7NjJrZCv1lQapIpD5WrCdvkv4RJxE07+Ne39z9K9l8SNxSrSNy2zLgVjP4HhleEjCC4igDCy1KjqE5H4ufo9YbactVVdIcy7LyhVSw/PmtAk4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(53546011)(186003)(2616005)(36756003)(6486002)(26005)(54906003)(316002)(6512007)(122000001)(6506007)(64756008)(478600001)(38100700002)(33656002)(6916009)(71200400001)(86362001)(38070700005)(7406005)(76116006)(66476007)(5660300002)(66446008)(41300700001)(4326008)(66556008)(8676002)(7416002)(2906002)(8936002)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YbtszomyIM+FXZS5IQ92p/CaDdtIEOIyMb98i8XMg7USbcO5gADr+9d1WAtR?=
 =?us-ascii?Q?SRJTMPjfhfQTH5SXuJN2EEEDW4AmHP/jj1I6QworD/He8ahJzbs1HJO9ibB1?=
 =?us-ascii?Q?dqkgyk9SUxwTSbb5knFUrtoC3ySGAVofMm6iRLaRTH288V83fQNXi62j9U8L?=
 =?us-ascii?Q?3xpLDd0bl04uKt26Sov4XxYbzlNqIpG7DqSPJDF3YKAxlACBNw9ZFR10hQvS?=
 =?us-ascii?Q?XUeFUYi+Z3wyn6ixTxSDlMW0J/74yJLd1PEROf6pVjlY37MRDWueNBfidtc4?=
 =?us-ascii?Q?eZrrCtBo9zdlZMIvD8pGCHn8Tmf9WPP+u7NIlV5SsNhb5Cea7ATAEISsHtnd?=
 =?us-ascii?Q?3mIn3lJDk48xcNa9UGmaN2W6BmSsxe1qM/SzKEtQvk0Ro4YCtB3doPeJ6BMz?=
 =?us-ascii?Q?kzGeEqQe2Hmtcch1Ju3yWJYlxrCw2n3cCy6XwElpmFuHeJ0aiEfHmK3gjsnS?=
 =?us-ascii?Q?adKqalLsYVGSX8BGWGcOecrMY7TKDcPE4GD9aW75oIvBCZV+ABlOUiOLJC4H?=
 =?us-ascii?Q?hjw0NYmDC5Vz5DdPKgVQRH4dQ/B0/Cu9LSOf2Pf7HPyPx/JTxFyroqZu7tSK?=
 =?us-ascii?Q?FQc/CmIY0ZLJfzmYLKxQtboD8m/XkGJg0uUuqZjo04ppUwETi0Rm+NycxMcb?=
 =?us-ascii?Q?oENQx4WcNuRJYrgFIh0uiqRBt6oqudieGDxFgD1bZK25powGEMrRIp/fbSlu?=
 =?us-ascii?Q?82Q3tgk3Fxo1sXsniYV+GF02/PIm1LZs95+YCMjsW89AeDpl3+2bBtxTMxgQ?=
 =?us-ascii?Q?GIXZowD7Xh8xhL4/GS47XsiLljp5g82otoFzK8Uh16FOXfShz21tzZycdirJ?=
 =?us-ascii?Q?8nX9j5NDMj6RXUV9q+PmBegLU/E0rS9cNRfQfMGBU77c309k5md3JSOjuyjv?=
 =?us-ascii?Q?777a54WOY8QYDziGFEAYWMVN8JkA6hqPEbg9O0+R5B0JsHG9NXOq466WEBVy?=
 =?us-ascii?Q?iV/+PQwPM7wCviTBV/DzIvmHhGzmI4jyMnfEQY2LYiYHZY0pRg3U2v37MfAG?=
 =?us-ascii?Q?GvamFvfYM9D9wrdIJEJScq33P0WfCLlHf8p9s2bFegcgm5cVtIMu/dhLOOMp?=
 =?us-ascii?Q?OFc31bCYNHVGPpf5pJ+IbWRL60Ff+Y1azJsf9t8rFZMG0JJ0N+kf6bq3P39Q?=
 =?us-ascii?Q?NTF69aGo9A/emfhjnn8hCNnA/mhvftJCFtlKBd+lSll7DkvmpRiBliHf0uVL?=
 =?us-ascii?Q?km3H6DcxrFHcdZ1/Vj68KVL4XXEhpJmE5gI4PbfG/s3x4a0sU/3g5f6v6TVI?=
 =?us-ascii?Q?nI8SLhZqhYOsAW+hLa0fn0GOGW++mwieeWwbaOQNJA9HEjbt/IUtHzrK1FIP?=
 =?us-ascii?Q?wEdGE0N2PSeg18TDgX7QgAJugQnlUsZyBM9kapOxI4FQgUtu8hSY1eQBFOch?=
 =?us-ascii?Q?IRmhKurmLsRFSxP5b//v+GQdXFR1CY3EjHHW8ZO6cVd8DxeeSYud4Ffey+Qz?=
 =?us-ascii?Q?7aBC9kM49b1hyENmQNM1Or5JRX1zC3Hkj2L+MA1/CRwrBBDHl1G2YY4i29H/?=
 =?us-ascii?Q?hocwd5HzaY5jrI9hsr8OKNuJ8v+m5STYNeWBKR8dbSfyaIlwdQPRPRRMZWyV?=
 =?us-ascii?Q?WVkCC7tiS9gWNLEQKpAg2bYd3/jTUh6l/F/WxmLc?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E223F6012C9A341910FA66A9FAE7922@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad29cf66-03e9-4c57-d2af-08daa0b1fe58
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 17:59:16.2610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bURh3q1Ede9Ob6RLQPIWRC46ToOLd4yuKJ/D+ZPEly/DzPMEZ4GB3Eb1b9YIvVQ+ugK/HCcS0lLN9vUsVT/4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6944
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

> Reuse the _refcount in struct page for the page table to maintain the
> number of process references to COWed PTE table. Before decreasing the
> refcount, it will check whether refcount is one or not for reusing
> shared PTE table.
>=20
> Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> ---
> include/linux/mm.h      |  1 +
> include/linux/pgtable.h | 28 ++++++++++++++++++++++++++++
> mm/memory.c             |  1 +
> 3 files changed, 30 insertions(+)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 965523dcca3b8..bfe6a8c7ab9ed 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2290,6 +2290,7 @@ static inline bool pgtable_pte_page_ctor(struct pag=
e *page)
> 	__SetPageTable(page);
> 	inc_lruvec_page_state(page, NR_PAGETABLE);
> 	page->cow_pte_owner =3D NULL;
> +	set_page_count(page, 1);
> 	return true;
> }
>=20
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 25c1e5c42fdf3..8b497d7d800ed 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -9,6 +9,7 @@
> #ifdef CONFIG_MMU
>=20
> #include <linux/mm_types.h>
> +#include <linux/page_ref.h>
> #include <linux/bug.h>
> #include <linux/errno.h>
> #include <asm-generic/pgtable_uffd.h>
> @@ -628,6 +629,33 @@ static inline bool cow_pte_owner_is_same(pmd_t *pmd,=
 pmd_t *owner)
> 	return smp_load_acquire(&pmd_page(*pmd)->cow_pte_owner) =3D=3D owner;
> }
>=20
> +static inline int pmd_get_pte(pmd_t *pmd)
> +{
> +	return page_ref_inc_return(pmd_page(*pmd));
> +}
> +
> +/*
> + * If the COW PTE refcount is 1, instead of decreasing the counter,
> + * clear write protection of the corresponding PMD entry and reset
> + * the COW PTE owner to reuse the table.
> + * But if the reuse parameter is false, do not thing. This help us
> + * to handle the situation that PTE table we already handled.
> + */
> +static inline int pmd_put_pte(struct vm_area_struct *vma, pmd_t *pmd,
> +			      unsigned long addr, bool reuse)
> +{
> +	if (!page_ref_add_unless(pmd_page(*pmd), -1, 1) && reuse) {
> +		cow_pte_fallback(vma, pmd, addr);

Is there some assumption that pmd_get_pte() would not be called between the
page_ref_add_unless() and cow_pte_fallback()?

Hard to know without comments or context.=
