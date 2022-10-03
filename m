Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5F5F3767
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJCVAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJCVAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:00:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A62F017
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:00:38 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c7so10673031pgt.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=HLHdFxoJHk5RJojcM4EF6YsKjsuNbBptwhJEME2CxZk=;
        b=H4nriSy95wk6Qjxo385ChG3lW6IR50a3hRFZgLW/U4eSlUw9UHf7JiaJfu8T750lgf
         I60xaN+8fYvIuZ6Eo+f63T6Wr2/DQq01d/tTLMTLMgZzjEU0BgurmruMu+IRBF3IRPtS
         ciCASHG2v74dN+99t8uKYgORu5psgSTC1lmQD23ChB27JRFaGrl39VKORh9+plhS9JiB
         aSvsxgl+CAsIPkpLXk159jRiYhY1ANxqr8iDUBp5i3obisXEgxD27wG8SKygixYpWfeK
         LujI1EJ2Qnw9kGaXtQymZzYtltsjrsBt2UAj1vh2DHHH62R3yTkoDXGiGq88g64l7bwS
         Yqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HLHdFxoJHk5RJojcM4EF6YsKjsuNbBptwhJEME2CxZk=;
        b=jrcBoZMCqtHb+9IGwK9/Fq40Efh47lsaqBJ9D7E82rizeCoCMYZIPc1YF1w81ay0nI
         MxVBQHxtHaP1WGOWIADNX3uwDZoPqIcXYlHTWuz3/mGUfNTRjoqBmSwZkp7xT3orPM9f
         OD0VDKz7KdJMm/rI8S3+ZsXATm2xI1zsPK0YNiOQQ9W+1zlKGnM4RUyktZBqEq6g1ZSE
         eG5DnfPtZ0Oby8HXj3iVijG5/+uKdRo9pfSY1VmJbPWOZSX6kUeC9YqASLtVsK907Ism
         h931YrPhHm1og5oI4SgH+yNrEKP/KXFyIXyd7ZLpbGMpzUlbOa8XBYwtrZiusn53HM5e
         jdTA==
X-Gm-Message-State: ACrzQf3G0XCcf0iHSODR9YxdlwQ2SLBG9YwETUi4k89MK9cjX+Vdm49d
        tQ5k7jlm2AJuZumrv/bf8Bs=
X-Google-Smtp-Source: AMsMyM7vgqQKCY6Yuu8k4Ya6DEkma/pgiSnECZBHfwhpHKA51cT6YTqEXiiEyPJC/CFmbwtjgI7udQ==
X-Received: by 2002:a05:6a00:1747:b0:55c:b475:5f74 with SMTP id j7-20020a056a00174700b0055cb4755f74mr17723187pfc.68.1664830837787;
        Mon, 03 Oct 2022 14:00:37 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00177faf558b5sm7366289plg.250.2022.10.03.14.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 14:00:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/3] mm/hugetlb: Fix race condition of uffd missing/minor
 handling
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221003155630.469263-2-peterx@redhat.com>
Date:   Mon, 3 Oct 2022 14:00:36 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BBCFE41B-9ABB-49C1-BDC7-EAF07964A6FF@gmail.com>
References: <20221003155630.469263-1-peterx@redhat.com>
 <20221003155630.469263-2-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 3, 2022, at 8:56 AM, Peter Xu <peterx@redhat.com> wrote:

>=20
> +			 */
> +			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
> +				ret =3D hugetlb_handle_userfault(
> +				    vma, mapping, idx, flags, haddr,
> +				    address, VM_UFFD_MISSING);
> +			else
> +				/* Retry the fault */
> +				ret =3D 0;

Might be unrelated, but at least for the sake of consistency if not
potential GUP issues, don=E2=80=99t you want to return VM_FAULT_RETRY ?

