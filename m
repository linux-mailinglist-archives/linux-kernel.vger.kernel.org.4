Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7BC6FF55D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbjEKPBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbjEKPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:00:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E5B76BB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THgTQkG/K43XHfuCqGOv1GDNtbex766PJ6p6nM7loaJtYzYZT8DlK8hmxz7h0KIxjKdzB3Ok/tJHE2LBSR9IZNfbWoHY/l2sa2uGUhv2a7VYXm64hCM0r64rHmAQ8dLD04/e7hdlETtrhpyRCVx8/zhwiCrLT2nQ5KA7ItnqdxiA/xAaGytXbST9Ikqc9tlKIUf+1GGy3v182T06W4KxsRIJhk8LvTbIFTwnU69pgrQjBeObqlfILw3GRf78m3Bg4DgdwKJPmxAgoQtr5wEz/hbOjgA5hA35qtPPCR7tpp6+ZeSF/bn+lbj6yDTsNE2VmxcCveO2phR1LvS1CvogLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urvz1WNn/nHcu24fj+6JLaKm/hNILSGT/guxrc1P2Rc=;
 b=llzt6oabP6q4CF6ej0Ifc0cj/KvIicK6eMaoP4GKUk837LrDUrm1WOS6OQhrNkMlkiaj4lSgdLVEGIhekkZO6CWUhCgv0De5KxRCBlwBGAGteEGvCE7yUl6qZZ23UNPPPSOmq3Y03TSSouxMfmdPZkX5OMp7RgKizJqfyTWsPiHHoHp3Kog5HojFsqMlWJ8lX9Xkb+kaZVv7m0TQSU/cPfv3TttcbP+t7nNRDZu/cFhFhx9C1Xm0HKhgyFNvMkpAsf09VusILGyaYdUTttOFGAg+NQJ5y7dAv5T23Zis982EiosVfV1ch3CPFb/dbMkVMeFBtIDtuQgnzh41cYDVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urvz1WNn/nHcu24fj+6JLaKm/hNILSGT/guxrc1P2Rc=;
 b=L7anaEW+JwfG8mSJdwMDId0X5qzNVlBBCKimVC9OXSNm9+G5hY+6/MCZMbLEpqaHcG4s9hBohNAhSzfpzQPVljOlAPrdQ4aX15OQ9ad7VOKWaRxxhfz7MpT4wh2awPkF4Eyc1N1XdGNV4qlFJvCNm/CzlpVs+vaTmcBw5d7X9k8j98FyxThea1IG/CziiByoVQE1UbSLIVVwsVgZXbE+2CNru5L3Af7OYRET3fyd2RBhuKvG6hWMSbMt0yYLd/d3QBO/2CQWVFzgQ4lXTwajhi0lgHpfUjWv5VEeHFIuCdzg0hb9U7oQN1PUpv2ytylu58eKtlCAJ8zD1IcxpjxOXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Thu, 11 May 2023 15:00:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8%5]) with mapi id 15.20.6387.018; Thu, 11 May 2023
 15:00:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Date:   Thu, 11 May 2023 11:00:37 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <F6BE4C55-EDF2-47DB-A1D3-F4DEA93E89D4@nvidia.com>
In-Reply-To: <20230511132113.80196-2-ryan.roberts@arm.com>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D94D5FF6-2CE0-4893-9617-3D665A4B1BB4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:207:3d::22) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfd9672-dfe2-4220-0867-08db52307bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6EePjXhatn/eUnL4NQ0lRF+zgKSM5ZUJo/g2l6V1Ca7ZFqTs3T1xCqxyRHDncOHlopNLIXkHE663gDrCLcD3rQDe7ldi32lt8oupA6TzidcIgBRxbbcFwcO6z1mga0319/j9OY6ZRTQVAoT+gLYnnIGuBKhRaiGzZH6zWAp44JaSdEFO8gFZYcvdzGiNAbuWeVbj6mZkaFe1umD841k5pTb7l8a4xi1hQVxsDGB/4Vg4MFmmUhkMyjGjHSG7aPaHKn+P91CQsIjbZkJkL9okxBkIpZGyW2WUrMHqKIVvWS8c/lDNe4gp3ysc/mdhqgpz3AxbcoyrHVqJ4bV21PhSzqzymwxBnnTPO3esnESMOQ0RgsvtwwK+kHz7XUFltYvNLDqBZnZBrMsXf/Gy+X/jmPrzqR/kGD+iKUF4Tzlou09K3PQxK0aGIRo0aeIGFeBhvsqfq0CRvqT4nchtsNA1+Hpd7x9/cc2hykD/s0l9w0t4hlJCQWo4pz5BL69lnMVuqY8BuSuq0sLQykyguSw2uz3bZyMSfxWGE1+LHgqQCinKo3KGGMuOBTooESuaDUCsYvauJhdX2NGUaG3kFs+p4VqPfD4BQcBpI5AcfT64dZT/sBdhc2z2Kl2WiR4jKmCtr2+o0Ldz2qHsDHPK1kiyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(5660300002)(38100700002)(33656002)(8676002)(235185007)(6916009)(4326008)(66946007)(2906002)(8936002)(66476007)(54906003)(66556008)(478600001)(6486002)(41300700001)(316002)(86362001)(6512007)(53546011)(6506007)(36756003)(186003)(26005)(83380400001)(2616005)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b+go3vNBM4EXdHsb64wopaL7HymsiRRd6nn5Kqx7pSq4uF/+/xx5uv66PKDv?=
 =?us-ascii?Q?fvcdYhFM7urulLSGjujEvOQI0OvFum/LhDPgYmH10QjGXhMvdjo+71c2Hphl?=
 =?us-ascii?Q?TOFGisv0EBsux0GiYZuFmIRL+37SsvOdkdVkw1TOzkKYtWl1Sha2rZE3JC9s?=
 =?us-ascii?Q?uibzJbAxbFHV39GZUVTPD89upd3yJuleKzOY9r9ciMGC+9d8Sa6su2T2PP3I?=
 =?us-ascii?Q?eOagUj0Y+8cqwOW5hKMGKeQTsHIHIve4JV0PhHl4CrUGncbA9PdSxXBJowEp?=
 =?us-ascii?Q?dtFTm01VgFaIKEa75uIdeaLJ0FEyhPL3mvU14aIINIS+aze1zrmAqDg37r9e?=
 =?us-ascii?Q?KEpxrF4lLIK6AX0L8ggm8irhcl9b0qqAhCs7yHW6exAvrgxmNET+ZlUMxJ5l?=
 =?us-ascii?Q?6QrfuTvefeGcVRWg8hGKruwK+0O+wRp5XD3HmkaOSxlelnrc3UAm24aZEQ7d?=
 =?us-ascii?Q?LbpDdiS15EyFgDXle/MIpHPuh42mQGUgpq8GfkFhMcZWHLb8BQg3+76DwymL?=
 =?us-ascii?Q?mE6DUN1GECBNe778dumzTlHG3KXqJgJs/N5lM7pxT69+JaWi+VHCMurzARmT?=
 =?us-ascii?Q?iwZmgk+kcMK2A13zkmKlnALCe0qP3G+gfNUDstE1OuONpx2u8y0REp3dQHf+?=
 =?us-ascii?Q?A2/oUK+3ecEO/pkw+rP+r/VM+Tgs9JRUsx38/Fcfrvb9YEIu6fUlhSMRei7g?=
 =?us-ascii?Q?xun5A5vJSxjAlDC+gxJb73Vsg+chBkf8oaEbegHfU4XRo8pC61D/8uZzlO7R?=
 =?us-ascii?Q?ONKpZIoDYe33ZVvCAwIU1y9HVMhcwBTz44w6Ij7YdClrN+hiFsDnsJeFTFxM?=
 =?us-ascii?Q?Mr4PeszmxMC2p+N8eyDkUWQvIVCgr1WkGw2uAiWg9bFmhIrkm1fTrrnT+12G?=
 =?us-ascii?Q?yYc7x+ZchU3IeIUQuc24EcA2qYcQLwCK6wnlXmhCznZQvF25Ng8MFYhYovfG?=
 =?us-ascii?Q?VT6cfIKpLmqiWzpFDU5MUJDd1CDrxZXxIQ116zSA4HDh3tHYdr8R7rr1gVO8?=
 =?us-ascii?Q?NizwwcxcNacTnw3G0TAYq64jONdTd0KOlE3aQrEFDF4y5w6D91ZAwwJlwe0Z?=
 =?us-ascii?Q?IrJ1E96VU23fN8xQt29EDcAjWsBVG84vTu2G4U+ARjLFTZlZuj8ooBeEBKAk?=
 =?us-ascii?Q?dotgcJqbvV8/z9nOYE1/rox9ZEom+I/ES4XAzXYl/NKBYNkYdXk1hXU45GGv?=
 =?us-ascii?Q?hqvttwwFtFsujMxN0hv4I4Jk9/pO45cmJtd0JD+hXLSL7BOYhVJCAr3axVnX?=
 =?us-ascii?Q?hRWSAoY+b3zP7dwA9DxZlkQvBAypLrzPcMZaL0QCsmF39OIBIpoBoSr4DArT?=
 =?us-ascii?Q?lhPZcSqlbXyWaEi0JG7gfqYN3z9szzooOsIS2XBEtfCN+sqSAUC3et+RHBMN?=
 =?us-ascii?Q?oAOZcSXW7Pc8ClVrFBI84VMKxqMpnbYMyK06YWR85+8gj5DE5ylz90Lb6ZQa?=
 =?us-ascii?Q?UKpllGU7RUp8R0uyZjuaj3n6Ca/mia27G0R7I1RUTNWxhxkqwDtRHRqaRWcF?=
 =?us-ascii?Q?nx37/3UlDZO4PPTn1idD4qzr6Pyxz0O14kPjFnlNObgsZrXB9g+oQ/GT4u/5?=
 =?us-ascii?Q?NTjSi/pKqraIL9AVB8g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfd9672-dfe2-4220-0867-08db52307bfc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:00:39.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4jHAB7JLbXGwdSVF6vehqOadKd+NxsEPj6ak2kMRZ1u84bqw2/s7y4+XZenGS6s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D94D5FF6-2CE0-4893-9617-3D665A4B1BB4_=
Content-Type: text/plain

On 11 May 2023, at 9:21, Ryan Roberts wrote:

> It is bad practice to directly set pte entries within a pte table.
> Instead all modifications must go through arch-provided helpers such as
> set_pte_at() to give the arch code visibility and allow it to validate
> (and potentially modify) the operation.
>
> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/vmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

--=_MailMate_D94D5FF6-2CE0-4893-9617-3D665A4B1BB4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmRdAxUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU+5UP/i37ECiLLZD+qY8M1rBwkBolnlLcFKQLwD+r
504Qaqn6yYeIvYF7SEedP6WzKyicGg1UzGQlzkTQVM0SqnwQjt1to0+AkneNfxp3
YA0hhJgjCYUMgXHwgkXjkRUD9xbzocvUrdh5WXdXio6ow+qP6lxfYIbBO0YLFgLh
a3JTn0Jd11BZR67BFkHsS4kPrk8bqGICVUHk8aXkND13MDFBjzs3gVSgE6uh8vhg
G/6nfFlUGN89ePhhOarnoawhC0OMo+trzHrfnxB6rO6WxvjaJGKhEiAqDe5/vOct
8UCeGyo9YRDigjjiUahdzMbfzZzoc7Nmk29a1k37+vAirJch7Tc8UoxY9k76CFY6
ofGCkX2bQQVmEIPaLsp5yJ0evifXzYBAWkmtOPymBDG+jsfX0yPQWslgkxwvNFiX
UklUs5swtp+CURgG3mGj+TOHpS3XDyHa8qynVVHYMFvL/cQGBXnZ4/I+DIQ0MQi8
Y12o858YYwC2EGMlKRLzVH70f0iW0MDIJT3+FXpNZS4aXFZsEj5K/bjIHhhAgVtK
PhW/D0n709fGAQ4ar3aXstn9wcTBAEoZAZLDWen7RATLhMphtNuLaHQjhAvJotJB
Q4ZLFsBbJD0jy3RLpcqmIDpbB/6BeVR0X4wJX7AJnYvMCgKSyz2S6tqIm8ANuniY
ymk3QsFU
=nJbe
-----END PGP SIGNATURE-----

--=_MailMate_D94D5FF6-2CE0-4893-9617-3D665A4B1BB4_=--
