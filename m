Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D741667CE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjAZO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjAZO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:27:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD31E1C3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:26:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y1so1960297wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fnkXpl0JXe5cdsKhRNEbh/HCtmKDAhmby37nYCIbO4=;
        b=GznaBx0nO92fihTvKdhBKVy1eMXnzSLw6ar8Mj/NvkFPqWDyPKzP6mOAMwarKo0uX+
         ZKzXL0fE8nbkh+2Ic1OiV6sD0/2L5AS6EPcAht944BNvOEEcbF65TYwwAvBzhK02Jo+l
         X+0LA9Ux4CKS+aCHXOsmXvFS3x//kHwPjNHm1LxflBXIPMx7siOG4zSy1KZD+v3AleSe
         WBLNVDAdo3cy8A97eNFeYtyzUO+IMIKVq16bjY6aB8VkkwtB9HQczm/rPy6krDsKNHe9
         dmIe5nbE0PPOomzD/yYZ7D1cgH+hZAN663OcUxo3xGh59EfIRMqNjfxECkprA/YzFrJh
         LKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fnkXpl0JXe5cdsKhRNEbh/HCtmKDAhmby37nYCIbO4=;
        b=69QvuJfDmIdj7HX0veat/YfoqMhf8RtFawL71EsLalCVqW1rNDDR6dv4qQD19XjXue
         uEWHoflQflTOVN/p8N4lkulGHgF6wQ0GxJrGss/uZtsueNFiXlrYa499O6EbXATXEl01
         P/sxoQeTXpGnsw4dXUod3lN8WMWfTTXhWGHvDjk7m5rZ0MAzJQBoBdt4BNmqe3b0DG/g
         K4kE/M1KRu1u/zfLB+0+vT+JP3kalFoEGpFkY+IV28mZX84c6+7JpDJL3pXjZ6dwlcY9
         0CYDiNPVqI+mPmTFKPguD/ULZnbD2Vu1t8+8hFQAycEieo2lgM7CuZp151X5k3L0dFpa
         Vj1w==
X-Gm-Message-State: AFqh2krCoTGa3GFAC6jakTJoA/bwZFvVKzErD7kbnkTuk/jIXsXwWmbb
        58qv1a3FN0JHlQ+ZQOJ85Aw=
X-Google-Smtp-Source: AMrXdXvL/g+6+cBxBcCMAuTxNV5bmRDYvLTpVidFlkrkzLoddDmsOb9brXJzxC2Eo7as9WFA+lAnWw==
X-Received: by 2002:a05:6000:1b8c:b0:2be:c5d:adc4 with SMTP id r12-20020a0560001b8c00b002be0c5dadc4mr32237963wru.13.1674743186940;
        Thu, 26 Jan 2023 06:26:26 -0800 (PST)
Received: from suse.localnet (host-79-44-17-213.retail.telecomitalia.it. [79.44.17.213])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm1439869wrx.115.2023.01.26.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:26:26 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Date:   Thu, 26 Jan 2023 15:26:24 +0100
Message-ID: <2334001.NG923GbCHz@suse>
In-Reply-To: <20230126141144.11042-1-fmdefrancesco@gmail.com>
References: <20230126141144.11042-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 26 gennaio 2023 15:11:44 CET Fabio M. De Francesco wrote:
> If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> address in order to fix this issue. Consensus has been reached on this
> solution.
>=20
> Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
> kunmap_flush_on_unmap() on an aligned-down to page address computed with
> the PTR_ALIGN_DOWN() macro.
>=20
> Cc: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Confirmed-by: Helge Deller <deller@gmx.de>
> Confirmed-by: Matthew Wilcox <willy@infradead.org>
> Fixes: f3ba3c710ac5 ("mm/highmem: Provide kmap_local*")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> I have (at least) two problems with this patch...
>=20
> 1) checkpatch.pl complains about the use of the non-standard
> "Confirmed-by" tags. I don't know how else I can give credit to Helge
> and Matthew. However, this is not the first time that I see non-standard
> tags in patches applied upstream (I too had a non-standard
> "Analysed-by" tag in patch which fixes a SAC bug). Any objections?
>=20
> 2) I'm not sure whether or not the "Fixes" tag is appropriate in this
> patch. Can someone either confirm or deny it?
>=20
>  include/linux/highmem-internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/highmem-internal.h
> b/include/linux/highmem-internal.h index 034b1106d022..e247c9ac4583 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -200,7 +200,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  static inline void __kunmap_local(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> -	kunmap_flush_on_unmap(addr);
> +	kunmap_flush_on_unmap(PTR_ALIGN_DOWN(addr, PAGE_SIZE));
>  #endif
>  }
>=20
> --
> 2.39.0

I just realized that I forgot to Cc Thomas Gleixner. Therefore, I think I'd=
=20
better add him to the list and resend this patch.=20

I'm doing it immediately, so please drop this.

Thanks,

=46abio=20



