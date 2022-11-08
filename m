Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A12062204F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKHX0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKHX0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD00554D9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667949912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mi+8/yG2AkmYuv7ZYdDMOOQ0yi94luJeVwqutgIMn6w=;
        b=eQ7Cu07zArXHDJExN9RBQuC2BvttQMP2LQPAwrfCCj3qrS9gLRdAB4e3DLcAoMXuBhDFCc
        m7KGI4AdZZ804AlDKOjF+Ds/eVQSbErvHIn+c1qybHVLnvgMPRKjFNafMwIEpjlY32R389
        qfYMs/wWvGw+0iFu/idBPCRQWxJNRzc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-nMF4z_RKNwacwH8JffDQXg-1; Tue, 08 Nov 2022 18:25:09 -0500
X-MC-Unique: nMF4z_RKNwacwH8JffDQXg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F300380673C;
        Tue,  8 Nov 2022 23:25:09 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 767F4492B05;
        Tue,  8 Nov 2022 23:25:08 +0000 (UTC)
Date:   Wed, 9 Nov 2022 07:25:05 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] vmcoreinfo: Warn if we exceed vmcoreinfo data size
Message-ID: <Y2rlUVGv6ua7tK/1@MiWiFi-R3L-srv>
References: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 at 01:50pm, Stephen Brennan wrote:
> Though vmcoreinfo is intended to be small, at just one page, useful
> information is still added to it, so we risk running out of space.
> Currently there is no runtime check to see whether the vmcoreinfo buffer
> has been exhausted. Add a warning for this case.
> 
> Currently, my static checking tool[1] indicates that a good upper bound
> for vmcoreinfo size is currently 3415 bytes, but the best time to add
> warnings is before the risk becomes too high.
> 
> [1] https://github.com/brenns10/kernel_stuff/blob/master/vmcoreinfosize/vmcoreinfosize.py
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  kernel/crash_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index a0eb4d5cf557..87ef6096823f 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
>  
>  	vmcoreinfo_size += r;
> +
> +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> +		  "vmcoreinfo data exceeds allocated size, truncating");
>  }

Yeah, sounds like a good idea. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

