Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47D1733C8E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjFPWo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFPWoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514D30FF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686955420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JjuNB3M0x6wmc/rCftnD/RZjrZ9C6lu11ccy1EvZSpI=;
        b=dvjXDnaolH1O6h00HFPGT8gaySpPN1f38hPNcu2/0l6Wpmdw4APFv6ozUdZvlQ3kPxagoO
        lwrr9WHwzjZ7LbFqfXysZ/6j3yaRv011Vjo66H3k3ipOI6YETf2YHThSRWtjfZ3foxWKXV
        9X3OESzTFD+VmkcrWYBy8oeXrfycxfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-ZUsXOHxYOfmbiBa5I12h0Q-1; Fri, 16 Jun 2023 18:43:39 -0400
X-MC-Unique: ZUsXOHxYOfmbiBa5I12h0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AA7785A5A6;
        Fri, 16 Jun 2023 22:43:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DE30C0004C;
        Fri, 16 Jun 2023 22:43:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230607204120.89416-2-vishal.moola@gmail.com>
References: <20230607204120.89416-2-vishal.moola@gmail.com> <20230607204120.89416-1-vishal.moola@gmail.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] afs: Fix waiting for writeback then skipping folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <702197.1686955411.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 23:43:31 +0100
Message-ID: <702198.1686955411@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Moola (Oracle) <vishal.moola@gmail.com> wrote:

> +					goto try_again;
>  				} else {
>  					start += folio_size(folio);

The "else" is then redundant.

David

