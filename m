Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE256426B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiLEKav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLEKat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC30B867
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670236192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phOwtpixfGU37TofD4pPByNZ2ZF8uqxHGHVZJ4vEjkM=;
        b=J2hF+6AbPNGSPKiuaVkXZAywrQjtoyBdv019YHTNWjEAdjcEHNMTuE7qQWg6cqpidZXjMe
        6w4LmbnEcnuepnwwi1LSCwVo/CKW4BsBULBxgobjg4QdwM7uM9uCFvNr0D4PGOvQgZIUBW
        fUWubOh67JKgyklrS4neNsK1PxD8LCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-OlIu11UkP4C84hCVocjUqg-1; Mon, 05 Dec 2022 05:29:50 -0500
X-MC-Unique: OlIu11UkP4C84hCVocjUqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D854B8630C6;
        Mon,  5 Dec 2022 10:29:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5340140C6EC3;
        Mon,  5 Dec 2022 10:29:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221205180617.9b9d3971cbe06ee536603523@kernel.org>
References: <20221205180617.9b9d3971cbe06ee536603523@kernel.org> <20221205123200.51539846cb9dd9dc158cc871@kernel.org> <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk> <276025.1670228915@warthog.procyon.org.uk>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     dhowells@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <382776.1670236186.1@warthog.procyon.org.uk>
Date:   Mon, 05 Dec 2022 10:29:46 +0000
Message-ID: <382777.1670236186@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, do you know how to deal with:

	add_ftrace_export(struct trace_export **list, struct trace_export *export)

being called by:

	add_ftrace_export(&ftrace_exports_list, export);

but ftrace_exports_list has an __rcu annotation, so the list argument in the
former should have an __rcu annotation in it somewhere too.

OTOH - there's only one user of add_trace_export() and add_ftrace_export(), so
can they be collapsed into register_ftrace_export()?

David

