Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8E6D263D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjCaQwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjCaQvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206BC2442F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680281283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GXMLIZTguxo7CDhl2SCd0a0QstHDyet0kAuDTud61w=;
        b=aEfP3AgodQJXXClDdwnzrTmylY17ZfT0XfaRyNz1qiZY90xcH3kFu1olsCvHnup/UP6RoL
        NkLomIhQc/tDAoTsD5Tnbcg4rxMAXy+akW18nWOAwboxvkfcayQ7qy9Yd410z3Gmpr2I+c
        jiyaLzUVxQ9BBZreQAPOpyRB29IC4CE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-tSBLTyE3M9CIyLStFlPX1A-1; Fri, 31 Mar 2023 12:47:59 -0400
X-MC-Unique: tSBLTyE3M9CIyLStFlPX1A-1
Received: by mail-qt1-f200.google.com with SMTP id u22-20020a05622a011600b003dfd61e8594so14975790qtw.15
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281278; x=1682873278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GXMLIZTguxo7CDhl2SCd0a0QstHDyet0kAuDTud61w=;
        b=APkUyKvWK3WAenuIlAYdZXRtLEYBhc/cAMoxepfPFaMkhzAAWqTm9mrD2PZpCPGtyv
         yZaiHGkhFncTxnC9jAmla14eMANDLqDYtlc0dmOSulMlwSiPoz3AYPucdC+ffuoj/r2O
         cigoqj87h6Ucf/kv1rTUnyvbICScQGovYoftpYJY1EDKfZP715d2E/QNVcSXlaUcEQqO
         G0NxmHqmSXWfhOagjBeFnzDzT3zqs0vPGEtzkW9sbMgI8ILX84BfU5363b4FxcLexid5
         jORqIl/qfzDRrGblvHkmYSl6C6iezxkKbg1GtCDDFKslNzRf1l25ApA54bk37BY9myyl
         G60Q==
X-Gm-Message-State: AAQBX9cqoNSxBKTeu0ICmROfPFZT1JuHhEw/x96KsMROyWjWR/lAwWKd
        oNG1dk/1sXGS+jMTTxyd4bMJsW5TRUVueeo3JrK+e/Ckl6XBnmRS4c2i7FQNv8XSg7pAk4ewqpa
        HIbOS3C6bN9HHVltP4bLcALnG
X-Received: by 2002:a05:6214:409:b0:56c:222d:427a with SMTP id z9-20020a056214040900b0056c222d427amr43078360qvx.1.1680281278656;
        Fri, 31 Mar 2023 09:47:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350ap9fZlD473kbzc1HSP4KKY1YT3jk+Yzx3QBkns6++slf9+KTaBZ3+iJEsk6M5e/UgY0rxEUA==
X-Received: by 2002:a05:6214:409:b0:56c:222d:427a with SMTP id z9-20020a056214040900b0056c222d427amr43078316qvx.1.1680281278322;
        Fri, 31 Mar 2023 09:47:58 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id mb7-20020a056214550700b005dd8b934594sm723892qvb.44.2023.03.31.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:47:57 -0700 (PDT)
Date:   Fri, 31 Mar 2023 12:47:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 00/29] selftests/mm: Split / Refactor userfault test
Message-ID: <ZCcOvIJKR9lgoC43@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330155707.3106228-1-peterx@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:56:38AM -0400, Peter Xu wrote:
> UFFDIO_API (with syscall)... done
> UFFDIO_API (with /dev/userfaultfd)... done
> zeropage on anon... done
> zeropage on shmem... done
> zeropage on shmem-private... done
> zeropage-hugetlb on hugetlb... done
> zeropage-hugetlb on hugetlb-private... done
> pagemap on anon... pagemap on anon... pagemap on anon... done
> wp-unpopulated on anon... done
> minor on shmem... done
> minor on hugetlb... done
> minor-wp on shmem... done
> minor-wp on hugetlb... done
> minor-collapse on shmem... done
> sigbus on anon... sigbus on anon... done
> sigbus on shmem... sigbus on shmem... done
> sigbus on shmem-private... sigbus on shmem-private... done
> sigbus on hugetlb... sigbus on hugetlb... done
> sigbus on hugetlb-private... sigbus on hugetlb-private... done
> sigbus-wp on anon... sigbus-wp on anon... done
> sigbus-wp on shmem... sigbus-wp on shmem... done
> sigbus-wp on shmem-private... sigbus-wp on shmem-private... done
> sigbus-wp on hugetlb... sigbus-wp on hugetlb... done
> sigbus-wp on hugetlb-private... sigbus-wp on hugetlb-private... done
> events on anon... events on anon... done
> events on shmem... events on shmem... done
> events on shmem-private... events on shmem-private... done
> events on hugetlb... events on hugetlb... done
> events on hugetlb-private... events on hugetlb-private... done
> events-wp on anon... events-wp on anon... done
> events-wp on shmem... events-wp on shmem... done
> events-wp on shmem-private... events-wp on shmem-private... done
> events-wp on hugetlb... events-wp on hugetlb... done
> events-wp on hugetlb-private... events-wp on hugetlb-private... done

Oops, the sigbus/events test do not look right here..  I think I slightly
messed it up right before I post this set.

I'll squash below change into "selftests/mm: UFFDIO_API test" in the next
post to fix this up:

===8<===
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 9e7f7c7f2982..793931da5056 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -92,8 +92,10 @@ static void uffd_test_pass(void)
 }
 
 #define  uffd_test_start(...)  do {            \
+               printf("Testing ");             \
                printf(__VA_ARGS__);            \
                printf("... ");                 \
+               fflush(stdout);                 \
                uffd_test_acct.total++;         \
        } while (0)
===8<===

So it should look like:

===8<===
Testing UFFDIO_API (with syscall)... done
Testing UFFDIO_API (with /dev/userfaultfd)... done
Testing zeropage on anon... done
Testing zeropage on shmem... done
Testing zeropage on shmem-private... done
Testing zeropage-hugetlb on hugetlb... done
Testing zeropage-hugetlb on hugetlb-private... done
Testing pagemap on anon... done
Testing wp-unpopulated on anon... done
Testing minor on shmem... done
Testing minor on hugetlb... done
Testing minor-wp on shmem... done
Testing minor-wp on hugetlb... done
Testing minor-collapse on shmem... done
Testing sigbus on anon... done
Testing sigbus on shmem... done
Testing sigbus on shmem-private... done
Testing sigbus on hugetlb... done
Testing sigbus on hugetlb-private... done
Testing sigbus-wp on anon... done
Testing sigbus-wp on shmem... done
Testing sigbus-wp on shmem-private... done
Testing sigbus-wp on hugetlb... done
Testing sigbus-wp on hugetlb-private... done
Testing events on anon... done
Testing events on shmem... done
Testing events on shmem-private... done
Testing events on hugetlb... done
Testing events on hugetlb-private... done
Testing events-wp on anon... done
Testing events-wp on shmem... done
Testing events-wp on shmem-private... done
Testing events-wp on hugetlb... done
Testing events-wp on hugetlb-private... done
Userfaults unit tests: pass=34, skip=0, fail=0 (total=34)
===8<===

-- 
Peter Xu

