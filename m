Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E7D630BC2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 05:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiKSEL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 23:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiKSELB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 23:11:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD669E94A;
        Fri, 18 Nov 2022 20:10:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y10so5023847plp.3;
        Fri, 18 Nov 2022 20:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYpcDOJfodrsXL7K8gUKnRBne0m8YjW/xpNBqmi9ICU=;
        b=SdWLDvPlCE/d1s5i2o//GpCZPHL1Muamna4Kmmqen1aocsjGNasTkJcEx5l1X96bcQ
         LBp4JyqEpbxx3xAWTq4YEI+CtccUeSxmKYbFExPswOypNBGdf+jv0Qrgkl6RkCHCR0pl
         bGbJbC+qe+gOJlbGLC5YwuvQJh52JQh7T9OTQOH/TqmWj389T8KTzsF/aAj+5piFOJSd
         MD28hMx3yBgTkS7FQOeEEio8KG/TKbr6LAnRuLZu/c/IgzDYbaVYsGovxEk2ehMkGZvv
         3uPIiZTNrZxmqrCET3ioE3L8R1+3nd58xjTBP56j3v9G19bk+eOHeK5GwbCvUpombQ9z
         1nbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYpcDOJfodrsXL7K8gUKnRBne0m8YjW/xpNBqmi9ICU=;
        b=p8pOxKvouw4SRjUB2spT1RfX1zJL2tTUl2EfpWwHoQvrhcO12mTVt4YLyMxRMxvnt3
         8c8zrmxyMIpIUcPH2cbLcQuFroLkaxPKEJihnvGa5OAoGXkmU8FcwfN8a7itBd6md4Au
         UfhsXku+yFsbF0Q+RF0KPIiPgzXFLHPNNCYPazpDd63ke2Dwzx4QaCiq05sn0Gai3mwx
         DDfuWTXrg7oi/LMnyI5eY7omr0DvfSN2KMdwX3tDBADp7kSOky4Y111JlEZpw2f6cbVQ
         ewiT6DbzHMDPd97lbMft2UQjpmbDsJoBWsW0JUfg3357JFxC7sU8xToGGwuT8038dvIb
         0SKw==
X-Gm-Message-State: ANoB5pnStA5IMp1fqfwFe94F2QhS27eyKDuh2COi+cYTYVVdEUXVlzhS
        0CIKmq/1O5VhzS//kAJqBgs=
X-Google-Smtp-Source: AA0mqf7xmMLhyAVAojMS8sA21zZByg8HH4uipalwhW611N4r57jb2M4QTY6aianvHVUIaRqMlRXJqg==
X-Received: by 2002:a17:902:bc43:b0:189:1e5:8424 with SMTP id t3-20020a170902bc4300b0018901e58424mr2358884plz.156.1668831019524;
        Fri, 18 Nov 2022 20:10:19 -0800 (PST)
Received: from debian.me (subs32-116-206-28-33.three.co.id. [116.206.28.33])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090a951400b001fb1de10a4dsm3136996pjo.33.2022.11.18.20.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 20:10:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9B2F810131E; Sat, 19 Nov 2022 11:10:15 +0700 (WIB)
Date:   Sat, 19 Nov 2022 11:10:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peter Xu <peterx@redhat.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Cannot parse struct or union error on mm-everything
Message-ID: <Y3hXJ0D+qAwfpm7B@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PYM4qzxBlogO0qIF"
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PYM4qzxBlogO0qIF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

I found a new htmldocs warning on mm-everything:

WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-versi=
on 2.4.4 -internal ./include/linux/mm_types.h' failed with return code 1

Checking the header with './scripts/kernel-doc -v -none=20
=2E/include/linux/mm_types.h', I got the full error:

include/linux/mm_types.h:255: info: Scanning doc for struct encoded_page
include/linux/mm_types.h:268: error: Cannot parse struct or union!
include/linux/mm_types.h:287: info: Scanning doc for struct folio
include/linux/mm_types.h:917: info: Scanning doc for typedef vm_fault_t
include/linux/mm_types.h:924: info: Scanning doc for enum vm_fault_reason
include/linux/mm_types.h:1028: info: Scanning doc for enum fault_flag
1 errors

The culprit is encoded_page struct, which is null struct (nonexistent type)
with kernel-doc comments:

/**
 * struct encoded_page - a nonexistent type marking this pointer
 *
 * An 'encoded_page' pointer is a pointer to a regular 'struct page', but
 * with the low bits of the pointer indicating extra context-dependent
 * information. Not super-common, but happens in mmu_gather and mlock
 * handling, and this acts as a type system check on that use.
 *
 * We only really have two guaranteed bits in general, although you could
 * play with 'struct page' alignment (see CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
 * for more.
 *
 * Use the supplied helper functions to endcode/decode the pointer and bits.
 */
struct encoded_page;

The struct is introduced by d57ab372568585 ("mm: introduce 'encoded' page
pointers with embedded extra bits").

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--PYM4qzxBlogO0qIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3hXIgAKCRD2uYlJVVFO
oy9GAQD3dc8vDZO0faWCSOEfGMQxg+GSElZME4FKGFeSY/aM3AD/XhEPWkai/23w
f2c8afnHyGooLCnMQc86vQeg4WM13gY=
=da30
-----END PGP SIGNATURE-----

--PYM4qzxBlogO0qIF--
