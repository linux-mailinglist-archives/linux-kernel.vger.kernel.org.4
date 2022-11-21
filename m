Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEB632B44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKURnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKURnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:43:39 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F0C2C122;
        Mon, 21 Nov 2022 09:43:38 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1322d768ba7so14517646fac.5;
        Mon, 21 Nov 2022 09:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RVYmRlCIWUFfeVnOV5mudLBiIVI6uJJnon3FBZNLLUI=;
        b=jcz1PMWg/P6eUBxRDkxKc0yQD7GP7vplwKzu1inK0mhWJoI8/LloPny5bXkEwBymN5
         DE81ekBRjKVErsWjLKQIKkswXFOZa5bvoPUbkqafrlIq6oxhq6VQfXSUpSMoVBvgPJhu
         H/VFqb2KjN2B7qnEk/Xb9WoeNPDQiWVKGN4k9glKFGm56FT10T3L+0XhXw+y8E6X6vUq
         0tu2oeQYspe06D815oLeil6BWq1FGQ/ZliZhLtVcUuJjmYdwoXBDVO50HCGOwCbfIaOF
         8w7HZGRzCVQ3FAwz0vSJYuwzGAnJXKKtM4S5xKxO5rpbnC+9IQR3Q/uIGgWdXVhYcJev
         mBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVYmRlCIWUFfeVnOV5mudLBiIVI6uJJnon3FBZNLLUI=;
        b=vQdu379wv0eIS6YWT+Bi1sXTXVt+H7sxdhUomdCl06XLrm0Fv4FfCF88jNFlVZ7epT
         7zYQq7CrhbUYMRomVQW/Chbp6Jf3+1swAUbnHSbj/Ll3jxPQF0DALWxyC6IFgoPTzDPy
         ASAsYn5D4LkvnKD531IK+gC7Iifubd6U1B2XLTJysAEUpRAfbhwnfmuJKYdTz4DOg2dh
         +kPI0I+RQClG9HwivgY9zuWESBysmI+FekJfMMrvoeRi3nwbPTYrL9o7WjzjzoSXotS4
         h457nJ6tSV4FHgA6zk8yPpSJz0npArMCFrQtg948j82vE9sqBbybkOz4pt4kU+LgVi0N
         aIDA==
X-Gm-Message-State: ANoB5pltUhQqTSCoY+X1bivVEmQhs8XIcIFA7wTYb/Ouml/NBMVyl19b
        jKttzjyZPbFb2CPEbHDOJg1c7yUDB1XA7X1xpJs=
X-Google-Smtp-Source: AA0mqf74KkrNkY8BdaZc8j5XcGxfP6V3NbT9q1EO2RMtGv3fnMb3YyW9WSIaGDRpu2Sazq4MO0bHaAxzARnC7vzHCpg=
X-Received: by 2002:a05:6870:b07:b0:13b:d07f:f29d with SMTP id
 lh7-20020a0568700b0700b0013bd07ff29dmr2050631oab.96.1669052617328; Mon, 21
 Nov 2022 09:43:37 -0800 (PST)
MIME-Version: 1.0
References: <Y3soBt1jmXHUKhW9@mail.google.com>
In-Reply-To: <Y3soBt1jmXHUKhW9@mail.google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Nov 2022 12:43:25 -0500
Message-ID: <CADnq5_NAaX6t3r+J8qcEfL1-8SOunU9YR3HqohmuGTm_xBow+g@mail.gmail.com>
Subject: Re: [PATCH] [next] drm/amdgpu: Replace remaining 1-element array with flex-array
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        Slark Xiao <slark_xiao@163.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 21, 2022 at 2:26 AM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct GOP_VBIOS_CONTENT and refactor the
> rest of the code accordingly.
>
> Important to mention is that doing a build before/after this patch
> results in no functional binary output differences.
>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/238
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
>
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---
> This should be the last one-element array that had references in source
> code. Given the way it was used, no *.c code change was required.
>
> I will move on to the atombios.h in the radeon driver.
> ---
>  drivers/gpu/drm/amd/include/atombios.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
> index 4dc738c51771..b78360a71bc9 100644
> --- a/drivers/gpu/drm/amd/include/atombios.h
> +++ b/drivers/gpu/drm/amd/include/atombios.h
> @@ -9292,7 +9292,7 @@ typedef struct {
>
>  typedef struct {
>    VFCT_IMAGE_HEADER   VbiosHeader;
> -  UCHAR   VbiosContent[1];
> +  UCHAR   VbiosContent[];
>  }GOP_VBIOS_CONTENT;
>
>  typedef struct {
> --
> 2.37.3
>
