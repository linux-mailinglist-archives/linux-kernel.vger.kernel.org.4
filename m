Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89936B9AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCNQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCNQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004B2A1890
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678810419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTub5Tj1a9SjAJvzuzhXIwaHvCPECuUOfZFLIrfSnkA=;
        b=C6VwycIW1qc3toa8jNV7RDDyKuldFe758NuKVz+F1NH3EyZnEAlUJasE/tC2dXlNx5BkAU
        dz+B+jdQ7g0TZZ/aW9pAk6rVc3z7DFTgTSzU+CYr5RFuqA4d5gYHVvxMPDp0FDkAsytPJO
        ndbEIxUQ2tkMVQrVec7x06/SOvcLtGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-AqMPBevaMkqzG0CLbGGuxQ-1; Tue, 14 Mar 2023 12:13:33 -0400
X-MC-Unique: AqMPBevaMkqzG0CLbGGuxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92D37811E6E;
        Tue, 14 Mar 2023 16:13:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAB10140EBF4;
        Tue, 14 Mar 2023 16:13:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230221170804.3267242-3-sshedi@vmware.com>
References: <20230221170804.3267242-3-sshedi@vmware.com> <20230221170804.3267242-1-sshedi@vmware.com>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        sshedi@vmware.com
Subject: Re: [ PATCH v4 3/6] sign-file: add support sign modules in bulk
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3754865.1678810411.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 14 Mar 2023 16:13:31 +0000
Message-ID: <3754866.1678810411@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> @@ -378,6 +385,16 @@ static int sign_file(int argc, char **argv, struct =
cmd_opts *opts)
>  	use_signed_attrs =3D PKCS7_NOATTR;
>  #endif
>  =

> +	for (i =3D 0; i < argc; i++) {
> +		module_name =3D argv[i];
> +
> +		if (bulk_sign) {
> +			ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
> +					"asprintf");
> +			if (!replace_orig)
> +				replace_orig =3D true;
> +		}
> +
>  	/* Open the module file */
>  	bm =3D BIO_new_file(module_name, "rb");
>  	ERR(!bm, "%s", module_name);
> @@ -486,6 +503,7 @@ static int sign_file(int argc, char **argv, struct c=
md_opts *opts)
>  	/* Finally, if we're signing in place, replace the original. */
>  	if (replace_orig)
>  		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
> +	}
>  =

>  	return 0;
>  }

This looks a bit weird (I know the next patch applies the indent).  I woul=
d
recommend putting the existing part of the loop body into its own function=
 -
say sign_one_file() - and then call that from the loop.

David


