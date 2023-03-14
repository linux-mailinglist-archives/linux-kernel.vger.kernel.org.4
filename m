Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126866BA2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCNWxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCNWxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:53:01 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FA510411;
        Tue, 14 Mar 2023 15:53:00 -0700 (PDT)
Message-Id: <8621e53ca50226823b1ee6c1ec9d40ce.pc.crab@mail.manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1678834375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfTmHuG7/JVkukj6i9UvqcVneAXUFxJc9BrAXcIEPfA=;
        b=tEVGR4CpZY6tuUOTQ+3sKHsqALva5ESHJluPSSoqSsI0dXFvQZro05N1h/xvBmw2W71ipD
        n/bt4/sGwgCgve2usmycJaqjlobl5cnG9qnK+jumdZoginAwg6GcwMmd1tEST6UU/FdpAT
        V0z0CZAOmzJv+T9HuAcs+9FvBCVLOhJlDCZxA+NIfb0xXFTdVEyXSMRJSk8zu5GFeusn9w
        /pPZnDRX780vT1JMZBaz0DyzJxVy1kvlES6NnnI/9hvoGSLSVuut53xCd4KHlIpqZU99RG
        yYD9JV8ey82aMiUkNfWjg70xKGtSmSlZb9MQWh4/fWmHuUdEWx8bwcOmt/fMtQ==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1678834375; a=rsa-sha256;
        cv=none;
        b=irWPiCIKBmyUp/1SgHmr27JoNn+cRe6BWTFWBeaWgKShG3kcum929GJ1JWT9yhB1qh1LC9
        QYTdtvQoHWMiFUhlwfOT8tfzESQ9ixVy/pTpfkFJtaHkE3o+A8+fZcIptLJaAXml/nnAev
        cHOiqAiBwxbx0Fgaz+N0JH+6W/rsFzns6hqlnHUoK7yKtXB9eM+3yf0rtRU3TU/epNhCNB
        7B6iPfE4z45/+Q0gm2fvPsW2u8cWbDStCHl89r8Jit56F2EVXXqDpYArEHNRnlwnM2ksQ4
        uRR1VBNdP84FBbPeTlXDOTY8J8PDTUDgDarTALGpMok7HdvMvDYa/MQFsTvPmw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1678834375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfTmHuG7/JVkukj6i9UvqcVneAXUFxJc9BrAXcIEPfA=;
        b=HHNOdTIrWMStj6EtyFNq+tmH8Uc/RD1UGUqPD0NTxnJ8fVPAuTlhouw26AfWasZAGshT5C
        INLA7884qP/NYT2whmwTIH+gvLz+uIPEUFkvxsczbw0AhSspkiLUY98GirkY70BUtRnrdt
        PsSegNawVvpUNuBnTNWsv7bkK9lAo8Fdk9KYzLp5uaX2tEDo72TTzzzc7hIBivoKorlBJL
        6QUS4+7Bsq3VEQl2s6+ZVsJVet21x57JzBOnqApPi7+wJPLdLW8HAtsEC1fBr56A3Lg74h
        bB3YBIgWLoan8BmWoeUnOCnnV0cdff3t0sc1vst9D9pu9/2H5FiOZYjzchJJFQ==
From:   Paulo Alcantara <pc@manguebit.com>
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steve French <smfrench@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v18 08/15] cifs: Use generic_file_splice_read()
In-Reply-To: <20230314220757.3827941-9-dhowells@redhat.com>
References: <20230314220757.3827941-1-dhowells@redhat.com>
 <20230314220757.3827941-9-dhowells@redhat.com>
Date:   Tue, 14 Mar 2023 19:52:49 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Make cifs use generic_file_splice_read() rather than doing it for itself.
>
> As a consequence, filemap_splice_read() no longer needs to be exported.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Steve French <smfrench@gmail.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>
> Notes:
>     ver #18)
>      - Split out from change to generic_file_splice_read().
>
>  fs/cifs/cifsfs.c |  8 ++++----
>  fs/cifs/cifsfs.h |  3 ---
>  fs/cifs/file.c   | 16 ----------------
>  mm/filemap.c     |  1 -
>  4 files changed, 4 insertions(+), 24 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
