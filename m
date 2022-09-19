Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1535A5BC142
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiISCJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiISCJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:09:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3110E18E13;
        Sun, 18 Sep 2022 19:09:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so4731706pjh.3;
        Sun, 18 Sep 2022 19:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=3v36Zt64TunF3kbYmT58DofeaeMqqtA4ouhjWhjl7lY=;
        b=d3v4bg3UAuGDRHbVn+rmoemyYJa4N3jL2imNkJX90oAg6R4JpI/cDJOLYrPbUSYgjV
         Prw2nNxWkw63VVLIflyfz7rG8ErJU+KxoCtE2dx5q7Xf9e2qPZnJi1X262/390Vuza8T
         cmZi/VOPMS8bCjpdf/QxL40QIlt9zGz9ucDS76ylqr1qj6DpVbhwZHyiapNryI03mGyp
         EyJ/l+nwn4cCUjT4xVum3Ebw97DQ6FO8zL32U1O9FQnHaxZAZzp3JOq9HXKjlmy3hPk/
         g61bo3usivd39HizVqOcoAujrptDbK4B6F10rN+KaX9lwHIRXMH3Nd6YrWgbNsseTNYR
         KHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3v36Zt64TunF3kbYmT58DofeaeMqqtA4ouhjWhjl7lY=;
        b=4Jvi1oQpw3HkfY5NG+jvMMIs41kufsYd/SS1vd75BZbJQcbWI1iWqV/A2HPZ3aM2i0
         KCszs31JYnGOLGkRljyG8O2koIJfvB4JoFPuA4PgjdhenkgAFdDCfY1w+qKvI4KhpnAl
         gHhUoB1R3kmHW0AP4124Pc2oN/zrrU5/83QzO9JB36VtAj9Y+IOdS22ZLdAFDY7PbRDV
         4eAUX+DuX7XIhYv/kw8z7r839N3qcJnUE5JOO5eUxostZoN2Hvxhn/1z+1HYZpRaxSxb
         S0zK9wLQ1VcJjR5km6Jg078fEkO1Pe2htrK2R+wew9S/rKB1llYeJ7SLheNyboiUtw4Q
         w4rw==
X-Gm-Message-State: ACrzQf0TgMLHE3UHvqmEyTLF/IFE7Yv8uIxmkctt4JBIPBx/L6bCIEgm
        oWWqL4zNzrv+JLrJRhrCLzk=
X-Google-Smtp-Source: AMsMyM5DuNnCVfMMlnq5nOkhIz4hCz1UEMx3AUk/IWv/J55k6bVpk+dE8T73dilHPz/4T83YXovkaQ==
X-Received: by 2002:a17:90b:35cf:b0:202:6f3d:53a7 with SMTP id nb15-20020a17090b35cf00b002026f3d53a7mr17969210pjb.63.1663553343360;
        Sun, 18 Sep 2022 19:09:03 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id c6-20020a634e06000000b0043941566481sm11343214pgb.39.2022.09.18.19.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 19:09:03 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A9410101A98; Mon, 19 Sep 2022 09:08:59 +0700 (WIB)
Date:   Mon, 19 Sep 2022 09:08:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH mm-unstable v15 00/14] Multi-Gen LRU Framework
Message-ID: <YyfPO8rVujtUzEwt@debian.me>
References: <20220918080010.2920238-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FZxmQtoS2Tn1HQRT"
Content-Disposition: inline
In-Reply-To: <20220918080010.2920238-1-yuzhao@google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FZxmQtoS2Tn1HQRT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 18, 2022 at 01:59:57AM -0600, Yu Zhao wrote:
> base-commit: 6cf215f1d5dac59a5a09514138ca37aed2719d0a

Hmm, there is no such commit on mm tree, not even on linux-next, so I
can't apply this series for testing.

The base commit is on what tree? Or I have to wait for rebasing this
series on top of latest mm-unstable.

--=20
An old man doll... just what I always wanted! - Clara

--FZxmQtoS2Tn1HQRT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYyfPMgAKCRD2uYlJVVFO
o4fsAQDbhpYeZ+rwK+dnLi93l14DegafDTFra0UaKlsts06U1gEAyAs2rS2qROhs
l2++piY2jaOc0CAFvCqHCuJR9tfd4gY=
=GwOJ
-----END PGP SIGNATURE-----

--FZxmQtoS2Tn1HQRT--
