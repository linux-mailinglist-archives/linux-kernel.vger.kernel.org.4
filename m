Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819F66B9AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCNQLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjCNQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FAA60D64
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678810228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WFQ4h6uRJI1U3PZbEtDy6/P3+kKlAaAOuhGgzKO5dc=;
        b=fQ/FWY1aJByu3ki5M/zF9NbWU4VeJqAqgU/UqcUKMsRvfbsglWLWW5/6WgM5+XWJx8vXGO
        CBtzUhgZy3rvtlXdzzxt+tySUIDq7m+RSeZwqktPmrJf8LP4aqq5iGj25EMeAc4V+uqaFZ
        7B+khHWBVZcIausW7NlV7hIJnlQow4Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-VowcrTsPOwmosi6HpiR_Ig-1; Tue, 14 Mar 2023 12:10:25 -0400
X-MC-Unique: VowcrTsPOwmosi6HpiR_Ig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC275101A55E;
        Tue, 14 Mar 2023 16:10:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF1B4042AC2;
        Tue, 14 Mar 2023 16:10:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230221170804.3267242-2-sshedi@vmware.com>
References: <20230221170804.3267242-2-sshedi@vmware.com> <20230221170804.3267242-1-sshedi@vmware.com>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        sshedi@vmware.com
Subject: Re: [ PATCH v4 2/6] sign-file: move file signing logic to its own function
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3754749.1678810223.1@warthog.procyon.org.uk>
Date:   Tue, 14 Mar 2023 16:10:23 +0000
Message-ID: <3754750.1678810223@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shreenidhi Shedi <yesshedi@gmail.com> wrote:

> Keep the main function bare minimal and do less in main function.

I would recommend repeating the subject here and expanding on it.  You also
need to say what the goal is.

> +	char *hash_algo = opts->hash_algo;
> +	char *dest_name = opts->dest_name;
> +	char *private_key_name = opts->private_key_name;
> +	char *raw_sig_name = opts->raw_sig_name;
> +	char *x509_name = opts->x509_name;
> +	char *module_name = opts->module_name;

I suggest just using opts-> everywhere rather than copying everything out into
stack variables.

> +	OpenSSL_add_all_algorithms();
> +	ERR_load_crypto_strings();
> +	ERR_clear_error();

That would seem like it belongs in main().

> +	struct cmd_opts opts = {0};

It would be better to do "struct cmd_opts opts = {};"

David

