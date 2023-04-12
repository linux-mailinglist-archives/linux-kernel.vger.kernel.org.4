Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6656DEFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDLI7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjDLI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AA89023
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681289898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRSll74NCcd80urM44e9yQtcqSB/U/f7M6z7OELxB1I=;
        b=GmbOr7o3bFEyQURGSvHY4orEkxPEo94b4P1DUQHmrE45CL6xOcgT6qP4Ci5lYWixumiPXl
        mz1OLTjr4aGGZIOqOyvmepAFx7NdXCAdLcdPffA3SejmQpidm+Jj0Vd36Z5ysTnk+Z6e9y
        qyP4+5qxs6SvvVi/Y+xRyvbMumAzBOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-LH9WPCJYMiu87mbV_DbrZQ-1; Wed, 12 Apr 2023 04:41:10 -0400
X-MC-Unique: LH9WPCJYMiu87mbV_DbrZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6881385C6E4;
        Wed, 12 Apr 2023 08:41:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 887D41121320;
        Wed, 12 Apr 2023 08:41:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <93f2614e-4521-8bc8-2eca-e7ad03e7e399@redhat.com>
References: <93f2614e-4521-8bc8-2eca-e7ad03e7e399@redhat.com> <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: find_get_page() VS pin_user_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37778.1681288767.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Wed, 12 Apr 2023 09:41:07 +0100
Message-ID: <37946.1681288867@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> I suspect that find_get_page() is not the kind of interface you want to use
> for the purpose you describe. find_get_page() is a wrapper around
> pagecache_get_page() and seems more like a helper for implementing an fs
> (looking at the users and the fact that it only considers pages that are in
> the pagecache).

Btw, at some point we're going to need public functions to get extra pins on
pages.  vmsplice() should be pinning the pages it pushes into a pipe - so all
pages in a pipe should probably be pinned - and anyone who splices a page out
of a pipe and retains it (skbuffs spring strongly to mind) should also get a
pin on the page.

So should all pages held by an skbuff be pinned rather than ref'd?  I have a
patch to use the bottom two bits of an skb frag's page pointer to keep track
of whether the page it points to is ref'd, pinned or neither, but if we can
make it pin/not-pin them, I only need one bit for that.

David

