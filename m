Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A68970163F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjEMKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjEMKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:55:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A9626AC
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:55:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so4492985e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683975325; x=1686567325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n9KqRSgAneDCkexvD3zlz5zPC0F9IhJMVwUxz3g/N7Q=;
        b=MKgtZnhG1dwdo1oIcix+RIpcZ4adAIgFJRDPEeAndoTVTp0U3ku3rOxULHuXbvqYzM
         6RU9OooYtfamRo7SOT7sNfW1X906yBSRFkZWCVt/H57dMOgso97CWSgdSLInXlRgeRT6
         5ftIKlCcdphEd1iGmg8NiTCPsXrxEGqxER2BbHmkV+MefC5tsYtl3+nCGfxRKj2SK/0/
         6zWQ1nCPZogbZ/51+n80GwXkITgMSJ1vOVtbejdshkmHCp0ToNFsbZAS/E4UssiT0oDA
         cDO3lF3poIum1ifOM/qRKr4CbheiCgpGWD9N6cgjGTVoBc9VLilVs+AX3AUwdaoHWPnf
         Yp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683975325; x=1686567325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9KqRSgAneDCkexvD3zlz5zPC0F9IhJMVwUxz3g/N7Q=;
        b=hQdJmgMSjzeOupF3qNkI/O13LaN9i3q4TMTL1m8ecmKCN1/SBJTfmRqo6GVrSUt8H2
         wu2fXFMpCLruIsLVWJ6sAvA59CtZwozoNkbtQfBpsX6fv9Yb3uwmNTMUF7dWHVQacNqD
         OG86btczOmiCfqSIQrJftkfUw0Arve7nJUtvLHn7KiTqJPbcpPaLYpfy1fnbkllBiFqx
         YJIz7kAIDS8lK2riQnuPra8cRHfDcKJvxBdL3cxAEDSUY4sCbKCM3+g/6M05X5+uKLXK
         jDtHM7EwY8CsFrSDQNctCbZAshcS0p4AeOR3ShvvdlNY1xT33Z5iKUj4pg3HI1zyDnA6
         4LIw==
X-Gm-Message-State: AC+VfDwmUk0F/a5JE43wPesXzp0AN3E6+2GE+CtolVKjFy/qrZLnSkRN
        /ySjX8TUsMDAUBxn7/SSXQijbYE+Gg==
X-Google-Smtp-Source: ACHHUZ6L/Ha1/UBL3H1zBTRHNQ+yzmhL+/fvG9h4KZO6GuqAn1OE1zLEEFvF4F/JTXQLL4zknmQmZg==
X-Received: by 2002:a05:600c:46d3:b0:3f4:1848:4dff with SMTP id q19-20020a05600c46d300b003f418484dffmr19008481wmo.7.1683975324929;
        Sat, 13 May 2023 03:55:24 -0700 (PDT)
Received: from p183 ([46.53.248.206])
        by smtp.gmail.com with ESMTPSA id l11-20020a7bc34b000000b003f195d2f1a9sm31211773wmj.15.2023.05.13.03.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 03:55:24 -0700 (PDT)
Date:   Sat, 13 May 2023 13:55:22 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        lstoakes@gmail.com, liushixin2@huawei.com, david@redhat.com,
        bhe@redhat.com, azeemshaikh38@gmail.com, akpm@linux-foundation.org
Subject: Re: + procfs-replace-all-non-returning-strlcpy-with-strscpy.patch
 added to mm-nonmm-unstable branch
Message-ID: <39b334c4-48e3-47ec-ae31-adeff2bf4839@p183>
References: <20230511043449.99AE6C433EF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230511043449.99AE6C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 09:34:49PM -0700, Andrew Morton wrote:
> Subject: procfs: replace all non-returning strlcpy with strscpy
> strlcpy() reads the entire source buffer first.  This read may exceed the
> destination size limit.

> This is both inefficient and can lead to linear read overflows if a source string is not NUL-terminated [1].

This is funny. C strings are always NUL-terminated by definition.

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>

> --- a/fs/proc/kcore.c~procfs-replace-all-non-returning-strlcpy-with-strscpy
> +++ a/fs/proc/kcore.c
> @@ -419,7 +419,7 @@ static ssize_t read_kcore_iter(struct ki
>  		char *notes;
>  		size_t i = 0;
>  
> -		strlcpy(prpsinfo.pr_psargs, saved_command_line,
> +		strscpy(prpsinfo.pr_psargs, saved_command_line,
>  			sizeof(prpsinfo.pr_psargs));
>  
>  		notes = kzalloc(notes_len, GFP_KERNEL);
