Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86463D3B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiK3Kpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiK3Kpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A48C5EFA4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669805081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QpiS+lqB9/nD3c7h6a4WkksXWdpwbKquOlt3y6VqM1A=;
        b=aRZhrqHxqDflgA8trfPRC2qTDnLmvVEotOyK9JzY2K2YbaoqDaNkjOo+iTn27zvSVvCYKn
        TSTZJALy3DH2ki95tsRuQLP1YGQciUhna2K/FzrpG+KZc9wSrHNjpte5M357d1/iDwd8D2
        imLM+QbscZBEbkN1V5lbx/X/Z2Tw3JU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-0B0kZKdnMq6rQRzxcMBaLg-1; Wed, 30 Nov 2022 05:44:37 -0500
X-MC-Unique: 0B0kZKdnMq6rQRzxcMBaLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 519DE3C0F227;
        Wed, 30 Nov 2022 10:44:36 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5B642166B26;
        Wed, 30 Nov 2022 10:44:33 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 3/4] random: introduce generic vDSO getrandom()
 implementation
References: <20221129210639.42233-1-Jason@zx2c4.com>
        <20221129210639.42233-4-Jason@zx2c4.com>
Date:   Wed, 30 Nov 2022 11:44:30 +0100
In-Reply-To: <20221129210639.42233-4-Jason@zx2c4.com> (Jason A. Donenfeld's
        message of "Tue, 29 Nov 2022 22:06:38 +0100")
Message-ID: <878rjs7mcx.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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

* Jason A. Donenfeld:

> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 73eb622e7663..9ae4d76b36c7 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -109,6 +109,16 @@ struct vdso_data {
>  	struct arch_vdso_data	arch_data;
>  };
>  
> +/**
> + * struct vdso_rng_data - vdso RNG state information
> + * @generation:	a counter representing the number of RNG reseeds
> + * @is_ready:	whether the RNG is initialized
> + */
> +struct vdso_rng_data {
> +	unsigned long	generation;
> +	bool		is_ready;
> +};
> +

I don't think you can use a type like long here.  The header says this:

 * vdso_data will be accessed by 64 bit and compat code at the same time
 * so we should be careful before modifying this structure.

So the ABI must be same for 32-bit and 64-bit mode, and long isn't.

Thanks,
Florian

