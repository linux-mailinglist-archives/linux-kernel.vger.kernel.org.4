Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DEA733C70
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjFPWbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84330EA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686954649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9ymQeewtuah2yRIl5I+JcRwbiBaty41/wJFelw3mgY=;
        b=B64tS+Ju6woSBfX404RNtypefR8j95DIgVYJzAXDlk5reoIbE4rp7G76GakvjgRJUGc2sa
        cIZ/o6Dfi3h9ZuNAyEx342TdsKLRIT3Z/eyr/7nJrXJDexUdfgNT5g/MKjRpJwqQOPG883
        lcpyMZX30c6SDIHyRQlUrPsnMI0ekfQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-oIaXkHctNTWA7Ta8_FZlxQ-1; Fri, 16 Jun 2023 18:30:45 -0400
X-MC-Unique: oIaXkHctNTWA7Ta8_FZlxQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21E451C05EAA;
        Fri, 16 Jun 2023 22:30:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83D4248FB01;
        Fri, 16 Jun 2023 22:30:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230607204120.89416-1-vishal.moola@gmail.com>
References: <20230607204120.89416-1-vishal.moola@gmail.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] afs: Fix dangling folio ref counts in writeback
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <700315.1686954643.1@warthog.procyon.org.uk>
Date:   Fri, 16 Jun 2023 23:30:43 +0100
Message-ID: <700316.1686954643@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

>  					if (skips >= 5 || need_resched()) {
>  						*_next = start;
>  						_leave(" = 0 [%llx]", *_next);
> +						folio_batch_release(&fbatch);

This should go before the _leave().

>  						return 0;
>  					}

Looks okay otherwise.

David

