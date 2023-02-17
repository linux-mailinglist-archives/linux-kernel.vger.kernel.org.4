Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26A69A921
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBQKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQKhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:37:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA68F6241A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:37:20 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j20so4092521edw.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7rE7bT9WEg/+TbqsUj9EwOlEC3od43qcgOlWqD+ziDg=;
        b=B5kHP7UnfBqJNd8H6FkzPzzeVotw1V3dJejxfiO3kuKOBJQ11PMaOvO3coZuCnpCp2
         AbTnOR+Bp/hWkeB5nE/8hvxx8RaEFqSpf8siz9tTZAZhiu8wPT4FS0zF1hA5Jq6RI/Cj
         j3FCX2MC/CTeOcM9GDu4B5Vl6WHxKTQvV1y2Bvq03zzRHgDs5BS+7q8yoiOU9/6gJDsg
         MkMjH+V8G4sTfpz02o1zug5qMNf1zIMGEFF3P1BWHFNMQ1b39Ypq+8OWUbEyreA+9BN5
         azcGxIaiNRfbzp6EMP3ca9BvVXRd5GKzRpYHaQIK7qdUY/KydGFfyy8VncfpFYPvvVgy
         rSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rE7bT9WEg/+TbqsUj9EwOlEC3od43qcgOlWqD+ziDg=;
        b=KpX0dDJ694ng3LA3LdXwjG8+TX+WbGqNhavRs9MiXsINgX/nacELLzQ3R62E26Sqve
         BuRrHzm+JwBi0vuycSW2P63k1euzC4oD5S6SKwR4H7MLGblt/wjOCbyg2U5EaxkqY19b
         eHE8z09pkcRkL+UCimbBD5+mAGR1411mg9yINhhScd7nlYpR5kdV3TwFoJ7ZOfpMFDpf
         3NbXGmesccA5Gik7C7rTm/BdHfuPLLT6nsekgae595jfI2K4kuPBAbcbyZAtzUGzMuz3
         KiGBczoq15o6crDuWPW5CDlcwyqn2nfPvWWlX/yOMnYLyjSBcQC2YwggY1arxALogaEp
         WkEw==
X-Gm-Message-State: AO0yUKU1yBeGSb1IhNGZUxRja13v4Sk3uY4ksB/VuDVg7yFGBOgUOJjR
        wg1zira1PySM7LPWMudqXqQ=
X-Google-Smtp-Source: AK7set/nio4nlFZ4oEa0H3lL26/vUGsioY7JyDCQbNeBl0ZNyDfqs4DYEkZV60gPWmOhlRKW6TE+Gg==
X-Received: by 2002:a17:906:5653:b0:8af:2d2e:5d31 with SMTP id v19-20020a170906565300b008af2d2e5d31mr8533699ejr.31.1676630239387;
        Fri, 17 Feb 2023 02:37:19 -0800 (PST)
Received: from sakura.myxoz.lan (81-230-97-204-no2390.tbcn.telia.com. [81.230.97.204])
        by smtp.gmail.com with ESMTPSA id ss17-20020a170907039100b008b1329cd4cdsm1957916ejb.190.2023.02.17.02.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:37:18 -0800 (PST)
Message-ID: <4a5c8cecb87735a6d697b3ff0da724cc73015669.camel@gmail.com>
Subject: Re: [PATCH v4 0/3] mm/khugepaged: fix khugepaged+shmem races
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Date:   Fri, 17 Feb 2023 11:37:17 +0100
In-Reply-To: <20230217085439.2826375-1-stevensd@google.com>
References: <20230217085439.2826375-1-stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.module_f37+15877+cf3308f9) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-17 at 17:54 +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
>=20
> Fix two races in khugepaged+shmem that cause issues with userfaultfd
> and
> lseek, respectively.
>=20
> v3 -> v4:
> =C2=A0- Base changes on mm-everything (fba720cb4dc0)
> =C2=A0- Add patch to refactor error handling control flow in collapse_fil=
e
> =C2=A0- Rebase userfaultfd patch with no significant logic changes
> =C2=A0- Different approach for fixing lseek race
> v2 -> v3:
> =C2=A0- Use XA_RETRY_ENTRY to synchronize with reads from the page cache
> =C2=A0=C2=A0 under the RCU read lock in userfaultfd fix
> =C2=A0- Add patch to fix lseek race
> v1 -> v2:
> =C2=A0- Different approach for userfaultfd fix
>=20
> David Stevens (3):
> =C2=A0 mm/khugepaged: refactor collapse_file control flow
> =C2=A0 mm/khugepaged: skip shmem with userfaultfd
> =C2=A0 mm/khugepaged: maintain page cache uptodate flag
>=20
> =C2=A0include/trace/events/huge_memory.h |=C2=A0=C2=A0 3 +-
> =C2=A0mm/khugepaged.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 263 +++++=
+++++++++++-----------
> --
> =C2=A02 files changed, 144 insertions(+), 122 deletions(-)
>=20

Might want to Cc this to the stable mailing list.
--=20
~miko
