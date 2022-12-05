Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2B6426A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiLEK20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiLEKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF8634B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670235783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/IiMxsRH7sVvgFMnxDUmAoa10veOjjRDQNTjUGjy8I=;
        b=Boh3dcp0CJIvpo8mhoqMDc9tkMQkzWZ8hH2qX/pOJ7MfreNTpo47NKuXjVeM2dSrLgGzS9
        6Z15wDfHOvSsb+W5yOxkHstpS4z/d750V4Y1ltD4LFNtSXQ+ibnSUrh+DQxgYTWDq9iS1a
        tw/eE8iF0yXCcXwY3Htk1idWJZIeqAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-jfOpx6mRMWuO2CtE07WbIw-1; Mon, 05 Dec 2022 05:23:02 -0500
X-MC-Unique: jfOpx6mRMWuO2CtE07WbIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D9BC185A7AC;
        Mon,  5 Dec 2022 10:23:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F133940C6EC3;
        Mon,  5 Dec 2022 10:23:00 +0000 (UTC)
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
Content-ID: <382386.1670235778.1@warthog.procyon.org.uk>
Date:   Mon, 05 Dec 2022 10:22:58 +0000
Message-ID: <382387.1670235778@warthog.procyon.org.uk>
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

Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Could you remove that part from your printf checker macro, and
> apply the below patch?
> Since the printf macros are a kind of improvement but this part is an
> actual bug, need to be fixed on stable kernel too.

Sure.  Posted that as v2.

> From 2e993ec80d864677fd42d27f9d4ee01d7e63f8a4 Mon Sep 17 00:00:00 2001
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Mon, 5 Dec 2022 14:27:00 +0900
> Subject: [PATCH] tracing: Fix complicated dependency of
>  CONFIG_TRACER_MAX_TRACE
> 
> Both CONFIG_OSNOISE_TRACER and CONFIG_HWLAT_TRACER partially enables the
> CONFIG_TRACER_MAX_TRACE code, but that is complicated and has
> introduced a bug; It declares tracing_max_lat_fops data structure outside
> of #ifdefs, but since it is defined only when CONFIG_TRACER_MAX_TRACE=y
> or CONFIG_HWLAT_TRACER=y, if only CONFIG_OSNOISE_TRACER=y, that
> declaration comes to a definition(!).
> 
> To fix this issue, and do not repeat the similar problem, makes
> CONFIG_OSNOISE_TRACER and CONFIG_HWLAT_TRACER enables the
> CONFIG_TRACER_MAX_TRACE always. It has there benefits;
> - Fix the tracing_max_lat_fops bug
> - Simplify the #ifdefs
> - CONFIG_TRACER_MAX_TRACE code is fully enabled, or not.
> 
> Fixes: 424b650f35c7 ("tracing: Fix missing osnoise tracer on max_latency")
> Cc: stable@vger.kernel.org
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Tested-by: David Howells <dhowells@redhat.com>

