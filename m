Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A7D73E4EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjFZQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjFZQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D5E53
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687796665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M88iDxohfYLZx/lQ5sTYOhExo6Y7iJPea0+7FQ52tIo=;
        b=TqJosC7dm1WNJDJ8xXYF4Nr2AWQc/IraxBSDHNXs+JTTz+hFgOgusBqQTzDKabLW+bCl3x
        hhEyKGkU/iIyXwZ8x6DPacwBXnLWG6H5JTSodVrVL0hg/YqpLlv2XdFkxNOIgjN3b20wrr
        EF/Kt/lB/JorXWoW/1wc6B5NfJTqrjs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-81f8vvwxPbO15G9D98Vqww-1; Mon, 26 Jun 2023 12:24:17 -0400
X-MC-Unique: 81f8vvwxPbO15G9D98Vqww-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4009ad15222so6292141cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796657; x=1690388657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M88iDxohfYLZx/lQ5sTYOhExo6Y7iJPea0+7FQ52tIo=;
        b=U8eZDD7uaWbYKlmSuMvkqJf0xCnxP/Hsc+TE+XIp2w3ycxk4xqRErrzfknzz9MXdsm
         GplwxIPgszsoDAL7rB1U0mAH1arKgT8JHxUzaHiVh7iwSJzD+iOTL/0lL3oGS3HJ0wjD
         ioHD++3k7DqkYob/YdaUPumhlP8756+4CIyZajoIwv0fq/s50JAw1UKQYAs93K+qErqH
         IAWIVg59UCXEiv6oW8OWjgGLu8oyOFoT6d50qThxSy9IwahTpN/5xYYshObDyc97kaw7
         zyv7NchcUn2roj0E99c8rf0x1kz2eU1cljk4NBxA9FhreIJan4RavaOzmZYMww33t+jc
         xpVg==
X-Gm-Message-State: AC+VfDx2QbsZCJNVloq1wuRY6wqZYkwDYM2wy8UAnqe56FVGsxw7vRGj
        i86jSZq96uTLbvW85ZM9t+BDHdaMi2VpytQfl0c6fgnC+KmNUp7cwbW/kycK+2Q779HG2fOcBt9
        XofRPwoBFAWsZYK1HDW4hX2NB
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr35527809qvb.2.1687796657192;
        Mon, 26 Jun 2023 09:24:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4R0QRtpGrfPvRP2DuIGdbkV7qT3IU1NUe/AkmXM9tu1DsgQAh3p7xECtNJCQCeBPokdSVMTg==
X-Received: by 2002:a05:6214:5298:b0:62f:1283:6185 with SMTP id kj24-20020a056214529800b0062f12836185mr35527787qvb.2.1687796656947;
        Mon, 26 Jun 2023 09:24:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l15-20020ad4444f000000b0062439f05b87sm3352118qvt.45.2023.06.26.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:16 -0700 (PDT)
Date:   Mon, 26 Jun 2023 12:24:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 7/8] selftests/mm: Add -a to run_vmtests.sh
Message-ID: <ZJm7rzfCwtw7AnC4@x1n>
References: <20230623142936.268456-1-peterx@redhat.com>
 <20230623142936.268456-8-peterx@redhat.com>
 <1f81260b-f569-87b9-a100-f6cd65ee5a5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f81260b-f569-87b9-a100-f6cd65ee5a5f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:10:26AM +0200, David Hildenbrand wrote:
> On 23.06.23 16:29, Peter Xu wrote:
> > Allows to specify optional tests in run_vmtests.sh, where we can run time
> > consuming test matrix only when user specified "-a".
> 
> I'd have used something like "-e: extended tests that might be more
> time-consuming".

'-a' stands for "all" here, I worry '-e' may be misread into running "extra
tests only".

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks,

-- 
Peter Xu

