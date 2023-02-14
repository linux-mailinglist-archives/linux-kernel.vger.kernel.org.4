Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7F6969E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjBNQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjBNQjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:39:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D9B29165
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676392708;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ec0y1A9K9VMILgkzXIsX3b9pefqAOVahaZCdNLPYtvg=;
        b=K5V5wCb9/iLSvCxj+TaIfjdX2rhHsGNd12qlE1oORExrkLFPvbXCNTMQMIHPcP5YlOWPiS
        hXE/bGVo5KFvO4HbZI9clWIp+N3YtlUxzcSqoWKaTtMa6/6UUIfTZG8Svp8LSLn4K4eoJq
        0RM+z8kXxYBKSrpDAJBeIOR6Vezsb90=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-wpBAjnwxOvOprRueIkVsmw-1; Tue, 14 Feb 2023 11:38:25 -0500
X-MC-Unique: wpBAjnwxOvOprRueIkVsmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA6B63848C3B;
        Tue, 14 Feb 2023 16:38:23 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4AD640C945A;
        Tue, 14 Feb 2023 16:38:19 +0000 (UTC)
Date:   Tue, 14 Feb 2023 16:38:17 +0000
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
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH RFC 6/7] Revert "x86: return modified setup_data only if
 read as memory, not as file"
Message-ID: <Y+u4+U28Ldnw5JFj@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230208211212.41951-1-mst@redhat.com>
 <20230208211212.41951-7-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208211212.41951-7-mst@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
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

On Wed, Feb 08, 2023 at 04:12:51PM -0500, Michael S. Tsirkin wrote:
> This reverts commit e935b735085dfa61d8e6d276b6f9e7687796a3c7.
> 
> Fixes: e935b73508 ("x86: return modified setup_data only if read as memory, not as file")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/nvram/fw_cfg.h | 22 -------------------
>  hw/i386/x86.c             | 46 +++++++++------------------------------
>  hw/nvram/fw_cfg.c         | 12 +++++-----
>  3 files changed, 16 insertions(+), 64 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

