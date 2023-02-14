Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF06969CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjBNQhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjBNQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:37:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B9D2BF2A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676392582;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFACX1G5R1lrRlAY7oUxw5aaMyGQvkT6aAKErJogHLY=;
        b=Ch0tRaPY4NU8gwMGPeEruPfeD9vdfrXlpUnOau0AqLno9JfC4jFL3Aww84yO1m/bYq4qeg
        8knGx12rg+1f47D2vS4/HtpaoFKMij1w5IseIhWOBmIW1KdpzcdkrVsE88T5J0hvxJx9pQ
        fzIaBaju0yiqY8BAb6VQuEqMoqfLmdo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-apJ7pUDiNeqQKMI599MErA-1; Tue, 14 Feb 2023 11:36:19 -0500
X-MC-Unique: apJ7pUDiNeqQKMI599MErA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B11052806064;
        Tue, 14 Feb 2023 16:36:17 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 732D82026D68;
        Tue, 14 Feb 2023 16:36:13 +0000 (UTC)
Date:   Tue, 14 Feb 2023 16:36:10 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Sergio Lopez <slp@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH RFC 1/7] Revert "x86: don't let decompressed kernel image
 clobber setup_data"
Message-ID: <Y+u4enkQpuBX1iWS@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230208211212.41951-1-mst@redhat.com>
 <20230208211212.41951-2-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208211212.41951-2-mst@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:12:27PM -0500, Michael S. Tsirkin wrote:
> This reverts commit eac7a7791bb6d719233deed750034042318ffd56.
> 
> Fixes: eac7a7791b ("x86: don't let decompressed kernel image clobber setup_data")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/i386/microvm.h |  5 ++--
>  include/hw/nvram/fw_cfg.h |  9 -------
>  hw/i386/microvm.c         | 15 ++++-------
>  hw/i386/x86.c             | 52 ++++++++++++++++++---------------------
>  hw/nvram/fw_cfg.c         |  9 -------
>  5 files changed, 31 insertions(+), 59 deletions(-)


Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

