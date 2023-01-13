Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B703A66914E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbjAMIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjAMIiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:38:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B55167BDE;
        Fri, 13 Jan 2023 00:38:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so8609474pjl.0;
        Fri, 13 Jan 2023 00:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Le4OzCrJTjcWREAX5GsqhzvNgu01khW2mMnBXb1Hb8=;
        b=BGsVagyg+1VaNpAurpS8aw6MalGOG6+qGrL6hldi9mTH+WBlfFynTj1pRysBhUjt0U
         Vll7kmicQH4+6vFvFd5Fq50j2ckxDPG9PuoVvC0T72aNTMWvhRyXuhMwMltXWuIw7cvg
         CB5vnRxIfc3WBTZz4BU9U2/IP1F6KE5DRTIjb99b26ykf36UQoDbeV8eGI2TGmidVfJ7
         Fr8nfJYTothCtmGV7nGbeevLQLu+Ii3ycMUmVelUJ1HQObU8wfWrOyHdDhT4KoiTYDc+
         xzWi41/qJThN2Tu5RlfSnCm+Xqrm4VvjC+6GfC5rBRQjFKr6XAdtVHmrDVCIvADOn//f
         8cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Le4OzCrJTjcWREAX5GsqhzvNgu01khW2mMnBXb1Hb8=;
        b=zBesyJ9and78PE5ATqWqgbfGiM9mwEIM62YTr16mGFbVJzlmW6CVnZXQGiyDt7PcAP
         6/LiHUTWq/0KWVEKLyBZ+odUZsY2W0RE/bUQ7MF/rvEvjtiToA8a7k8SK81whZ7QlJ0o
         ngbThQYJlvik+L4XtP+UyGbSeL3wbXprXW1si/B7bb4mhfhD88TUHMliKbhUr/PE1/VF
         zPRmOXgB1Cy8GU5P9VkedihKTqwzp+Qsf4KSGqWqPuuDe/fvZfWVjpPpwgL6aPglk53E
         SRZ8hk3C97BGiVkuSpns0MYKy2+cbCdAQRHJYkmqW05jMCFQvhZ0ba5svfrKGHUjkFfM
         roOQ==
X-Gm-Message-State: AFqh2kqXV36lsLhtEIMVLkx1kjSY488IdIHOo158AChUQcZ+65FlFJFa
        9FMmGUzTjKNRy1cC6ZAJhA8=
X-Google-Smtp-Source: AMrXdXvenwjrK+ak/wohZ81pSnWcLGL06/TCgz77wVYs6WI7BWUUzgbVaWjB09tEmSjm4nuTvRzagw==
X-Received: by 2002:a17:902:ecce:b0:192:b16b:8e49 with SMTP id a14-20020a170902ecce00b00192b16b8e49mr66904544plh.43.1673599130970;
        Fri, 13 Jan 2023 00:38:50 -0800 (PST)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b00186e34524e3sm13519501ple.136.2023.01.13.00.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:38:49 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 527EB104D31; Fri, 13 Jan 2023 15:38:47 +0700 (WIB)
Date:   Fri, 13 Jan 2023 15:38:47 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] docs/mm: start filling out new structure
Message-ID: <Y8EYl5FNaA3Wa3So@debian.me>
References: <20230112091616.824565-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/adNa2uzkgbbK4dL"
Content-Disposition: inline
In-Reply-To: <20230112091616.824565-1-rppt@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/adNa2uzkgbbK4dL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 11:16:13AM +0200, Mike Rapoport wrote:
> Mike Rapoport (IBM) (3):
>   docs/core-api: DMA API: add page label to allow external references
>   docs/mm: Page Reclaim: add page label to allow external references
>   docs/mm: Physical Memory: add structure, introduction and nodes
>     description

I'd like to squash [1/3] and [2/3] to actual doc [3/3], for which the
latter contains cross-references to labels defined in the former.
Indeed, IMO, adding required reference labels in some other place when
writing the doc can be constituted as part of writing the doc itself.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--/adNa2uzkgbbK4dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8EYlgAKCRD2uYlJVVFO
ozOAAQCOO9PyOCL+/45iOOmafkfZN+/uO1FQJyep8cMrFPyJwwEAzJ++sxk0fUs0
/NJfqeX+lqpu8FQN8RPh78IUHxmmUwQ=
=Xlo5
-----END PGP SIGNATURE-----

--/adNa2uzkgbbK4dL--
