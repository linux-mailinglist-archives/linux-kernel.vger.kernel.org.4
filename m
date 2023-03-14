Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1346B9A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCNQDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCNQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40090B256D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678809734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gTiQ//RyRLi76X7jSKyCpAyfYe9vbbQZH8ngsfv84X8=;
        b=UAwHSSxr1TcN3RGkMGe3hNEagWH15hytEtmeZ0p1jQvkeudOgafA6ao7EM7V9llbXU5k3m
        iS2aSn/A7eP/7w8eAjtlHbeB1oSrhDKch9Uf8qf91MGPyp2DO8/QwH1sb9IdbO41suX3JW
        YASO4/xlDqEIHF+xq2N2NpC937by2hU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-2WsvibyWNhuiGo_7x6Z-6w-1; Tue, 14 Mar 2023 12:02:10 -0400
X-MC-Unique: 2WsvibyWNhuiGo_7x6Z-6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1972E80280D;
        Tue, 14 Mar 2023 16:02:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5990C4042AC2;
        Tue, 14 Mar 2023 16:02:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230221170804.3267242-1-sshedi@vmware.com>
References: <20230221170804.3267242-1-sshedi@vmware.com>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        sshedi@vmware.com
Subject: Re: [ PATCH v4 1/6] sign-file: refactor argument parsing logic
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3754504.1678809728.1@warthog.procyon.org.uk>
Date:   Tue, 14 Mar 2023 16:02:08 +0000
Message-ID: <3754505.1678809728@warthog.procyon.org.uk>
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

Can you please include a cover note indicating what this series is about?

> - Use getopt_long_only for parsing input args
> - Use more easy to remember command line argument names

You're also adding a bunch of new flags.  I would recommend splitting that
into a separate patch.

> +	char *hash_algo = opts.hash_algo;
> +	char *dest_name = opts.dest_name;
> +	char *private_key_name = opts.private_key_name;
> +	char *raw_sig_name = opts.raw_sig_name;
> +	char *x509_name = opts.x509_name;
> +	char *module_name = opts.module_name;

I wonder if these should now be const char *.

> @@ -292,7 +381,6 @@ int main(int argc, char **argv)
>  		exit(3);
>  	}
>  #endif
> -
>  	/* Open the module file */
>  	bm = BIO_new_file(module_name, "rb");
>  	ERR(!bm, "%s", module_name);

Please don't remove that blank line - it separates two logically distinct
parts of the program.

David

