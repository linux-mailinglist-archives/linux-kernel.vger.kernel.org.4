Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A39642495
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiLEI3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiLEI3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439E63E3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670228924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVyty3te32i4TFmWlZxfcZW44tS6pgKLpMbXjqfqHBg=;
        b=iNvYM0U0yvflwHsN/V5TIuQIALp8yyHIEthsvUqnrLZHIFXTGT0xiKAWROyjlSkM72Zj19
        CxqzlCSqh8HLoEb6eSfobIgNYlycQnRMbk7RPn7ctSRmwbgkIzKnLmq+FSzS1ZBysC4tNn
        IaKOwWkwMYEHWpr/NFJhbtufUQLIULc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-jifrcCAoMwKMVCfovEG-pQ-1; Mon, 05 Dec 2022 03:28:39 -0500
X-MC-Unique: jifrcCAoMwKMVCfovEG-pQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B17F85A588;
        Mon,  5 Dec 2022 08:28:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BDE92166B29;
        Mon,  5 Dec 2022 08:28:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221205123200.51539846cb9dd9dc158cc871@kernel.org>
References: <20221205123200.51539846cb9dd9dc158cc871@kernel.org> <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     dhowells@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <276024.1670228915.1@warthog.procyon.org.uk>
Date:   Mon, 05 Dec 2022 08:28:35 +0000
Message-ID: <276025.1670228915@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
> >  static const struct file_operations tracing_max_lat_fops;
> > +#endif
> 
> Oops, I missed this part. Why did you introduced this #ifdefs?

Because:

    #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
    static const struct file_operations tracing_max_lat_fops = {

in the same file.  You get something like an unused symbol warning otherwise
if neither config option is defined.

David

