Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BF6E759B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjDSIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjDSIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:47:10 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Apr 2023 01:46:22 PDT
Received: from us-smtp-delivery-110.mimecast.com (us-smtp-delivery-110.mimecast.com [170.10.133.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AF0AF37
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globallogic.com;
        s=mimecast20210517; t=1681893981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pmty6Z3i6AqK9upEu19BmaxMq1ZvTXOUGffgKfE2WKU=;
        b=kHg6+W+fpIkBKdBYCsGVGJjw5/M1VpFyrrD6DMC7ttNp6aRHIQfzfHVOPzdZiqoImXMCuN
        NaZZ1F6YA55DwHa7NNqZ+AZLXntbuM9KdnK2byzFXsx6BK0KBrF2Knak48fVulFm4ZmKlP
        /H824iRipfOLdk+0+OUcjYQ/4YOWuK/N+nLQ5JB/8zEM6ul63OdfVUSZmSDywnEVV7FcWh
        WJsOVo3MS4oaYoYNlNiB0kf98UrTWaVY9VTLt8MFEERyykc5G8an7qXsjW4Y4FoCKATcqR
        TDvd9Th7kjsWupplSkC6x8bR8RhTzRS5EtHMNsuzhiKH2USTNDsgl/K2q58RoA==
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-FbB6-GprPyeQqIX9P3bX-g-1; Wed, 19 Apr 2023 04:39:43 -0400
X-MC-Unique: FbB6-GprPyeQqIX9P3bX-g-1
Received: by mail-ed1-f69.google.com with SMTP id g21-20020a50d0d5000000b005067d6335c3so8164642edf.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893582; x=1684485582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBZ4v02+DP4JtA3av4tOJ+0lImTBUH0VfKBzwC3dXEg=;
        b=Nlly+u9o4a2PadULZEJpxLXZyjJjyDhTlswJFh7GeUtBNRsNRpklzP5jQ494r3UbQa
         6XuVHukVNZEb07iY66mE++Ikvwk1y9Zyhu17VSGRvB8nLIIp29lpkS82b4hOz8d9Jwit
         dF0meQWhoVq09Sne2R9jhdL7oSQdHp9eRDSADClFcyJ41f7FRaQPivzkCq1J20Zm1NqW
         ocgI5AhEvnXO0BwnQ2yy73kZhcfPcKPw7DRA+BTwNjFsbs3Jd/saF5Q2dcV+6w94hJhy
         VEm5Y6ulwx1C5rucLYOBIrcOOOuxZ1OmX3b56D4P2Fyk9uPczvcw8fDOKNv3TruSpk2s
         oxVw==
X-Gm-Message-State: AAQBX9dE2Z5+WfA8urnE82cNCuDttXW2eUaPHpA1DKOtm6MGD9lV0NTe
        rtJ0F4mmXRQZs7A9D/2fg/QEJEpOJ/JPFfHzIayyMEo3PPkvO3feI34i/uh140FCjVq7D7V8zfk
        2M4aAGivdWCg14RxWw+5LqGY=
X-Received: by 2002:a17:906:a945:b0:932:4255:5902 with SMTP id hh5-20020a170906a94500b0093242555902mr13761207ejb.76.1681893581963;
        Wed, 19 Apr 2023 01:39:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350aWKN12QTZg4c6/Skev4owyJrNvF9hpR+QceWVxjbOF/fFurjp7eUCHIdsLAXLyvcj6wPUIMg==
X-Received: by 2002:a17:906:a945:b0:932:4255:5902 with SMTP id hh5-20020a170906a94500b0093242555902mr13761177ejb.76.1681893581545;
        Wed, 19 Apr 2023 01:39:41 -0700 (PDT)
Received: from kbp1-ldl-a16430.synapse.com ([193.19.255.131])
        by smtp.gmail.com with ESMTPSA id d9-20020a170906640900b0094f58a85bc5sm4698590ejm.180.2023.04.19.01.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:39:41 -0700 (PDT)
From:   Sergii Piatakov <sergii.piatakov@globallogic.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Steffen Zachaeus <steffen.zachaeus@joynext.com>,
        Gotthard Voellmeke <gotthard.voellmeke@renesas.com>,
        Yaroslav Parkhomenko <yaroslav.parkhomenko@globallogic.com>,
        Sergii Piatakov <sergii.piatakov@globallogic.com>
Subject: [PATCH mm/cma] mm/cma: retry allocation of dedicated area on EBUSY
Date:   Wed, 19 Apr 2023 11:38:51 +0300
Message-Id: <20230419083851.2555096-1-sergii.piatakov@globallogic.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: globallogic.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes continuous page range can't be successfully allocated, because
some pages in the range may not pass the isolation test. In this case,
the CMA allocator gets an EBUSY error and retries allocation again (in
the slightly shifted range). During this procedure, a user may see
messages like:
    alloc_contig_range: [70000, 80000) PFNs busy
But in most cases, everything will be OK, because isolation test failure
is a recoverable issue and the CMA allocator takes care of it (retrying
allocation again and again).

This approach works well while a small piece of memory is allocated from
a big CMA region. But there are cases when the caller needs to allocate
the entire CMA region at once.

For example, when a module requires a lot of CMA memory and a region
with the requested size is binded to the module in the DTS file. When
the module tries to allocate the entire its own region at once and the
isolation test fails, the situation will be different than usual due to
the following:
 - it is not possible to allocate pages in another range from the CMA
   region (because the module requires the whole range from the
   beginning to the end);
 - the module (from the client's point of view) doesn't expect its
   request will be rejected (because it has its own dedicated CMA region
   declared in the DTS).

This issue should be handled on the CMA allocator layer as this is the
lowest layer when the reason for failure can be distinguished. Because
the allocator doesn't return an error code, but instead it just returns
a pointer (to a page structure). And when the caller gets a NULL it
can't realize what kind of problem happens inside (EBUSY, ENOMEM, or
something else).

To avoid cases when CMA region has enough room to allocate the requested
pages, but returns NULL due to failed isolation test it is proposed:
 - add a separate branch to handle cases when the entire region is
   requested;
 - as an initial solution, retry allocation several times (in the setup
   where the issue was observed this solution helps).

Signed-off-by: Sergii Piatakov <sergii.piatakov@globallogic.com>
---
 mm/cma.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index a7263aa02c92..37e2bc34391b 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -431,6 +431,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long c=
ount,
 =09unsigned long i;
 =09struct page *page =3D NULL;
 =09int ret =3D -ENOMEM;
+=09int retry =3D 0;
=20
 =09if (!cma || !cma->count || !cma->bitmap)
 =09=09goto out;
@@ -487,8 +488,26 @@ struct page *cma_alloc(struct cma *cma, unsigned long =
count,
=20
 =09=09trace_cma_alloc_busy_retry(cma->name, pfn, pfn_to_page(pfn),
 =09=09=09=09=09   count, align);
-=09=09/* try again with a bit different memory target */
-=09=09start =3D bitmap_no + mask + 1;
+
+=09=09/*
+=09=09 * The region has enough free space, but it can't be provided right =
now
+=09=09 * because the underlying layer is busy and can't perform allocation=
.
+=09=09 * Here we have different options depending on each particular case.
+=09=09 */
+
+=09=09if (!start && !offset && bitmap_maxno =3D=3D bitmap_count) {
+=09=09=09/*
+=09=09=09 * If the whole region is requested it means that:
+=09=09=09 *  - there is no room to retry the allocation in another range;
+=09=09=09 *  - most likely somebody tries to allocate a dedicated CMA regi=
on.
+=09=09=09 * So in this case we can just retry allocation several times wit=
h the
+=09=09=09 * same parameters.
+=09=09=09 */
+=09=09=09if (retry++ >=3D 5/*maxretry*/)
+=09=09=09=09break;
+=09=09} else
+=09=09=09/* In other cases try again with a bit different memory target */
+=09=09=09start =3D bitmap_no + mask + 1;
 =09}
=20
 =09trace_cma_alloc_finish(cma->name, pfn, page, count, align, ret);
--=20
2.25.1

