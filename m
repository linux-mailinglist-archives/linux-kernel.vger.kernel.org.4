Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A141668A0E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjBCRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBCRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:54:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EDE32521
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:54:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z1so5995039plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9RKTKl/Bb3c4duHC9Bqed53UuuEJJvB8k+GUCNePruY=;
        b=HQ0vQysX1kKI8O+PparDZ35dBYNpcFDWtsPkazH7LUJi2OaBa11iyQ9FQsErdO66dx
         1UzzputCQRuAr/bCctGzAZwa0d+aDQ1lgiTzHsFutD6VgNmqAwFcIqJ3F8Tcxz5a8QLk
         /pYo5xZE+h1m4VZPPnBgpQttdWfm3JlDR1S2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RKTKl/Bb3c4duHC9Bqed53UuuEJJvB8k+GUCNePruY=;
        b=jGkVE/8yXdkFHnljqLVANLTTUHx1SDwqSFa/j74HyD8Dm9+vXbGaGryhgWt3KcihGe
         DEF78N7Ho3hZWY7f4q9FoHbajDlUmag8+kzVmjmid2g/1KeIyNkxYRN6dtmcDpc+n91v
         QXsssrZpCfUSMJBH+6NL6lzzSo1PS2XqoKzC19pTHyqupCSw5UldAnGeQSJcXhpRzSvD
         vGtiPcrvVoWsKrMQOVl+y8ukcF0hnRNDWlfu+kA2JglsuYJR4B3UPHGixV8fES3mLoX0
         9DhQTa/o0y5gbXK/qW2i7xZKmfKhb2AUwBnfkw3AtYgXeugu4kLWq66um1BPBWdla+rm
         CazA==
X-Gm-Message-State: AO0yUKVlEbAlktrgrxXZjKNDvuIsqk35rFtIiuu+9A4fIrkoYeq++y50
        0ojdDRjPwhf0b2l3u3FCE4rLFQ==
X-Google-Smtp-Source: AK7set/EmLEgIMfPrEdynvHAK1GlETqG/9g9kQULpuLqRZcPGdmTTgRxZ2UAdRqjHzv/ZYrfp0Ow/w==
X-Received: by 2002:a05:6a20:8420:b0:bc:246c:9be4 with SMTP id c32-20020a056a20842000b000bc246c9be4mr15305808pzd.45.1675446840510;
        Fri, 03 Feb 2023 09:54:00 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a637805000000b004c974bb9a4esm1737998pgc.83.2023.02.03.09.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:53:59 -0800 (PST)
Message-ID: <63dd4a37.630a0220.e4652.35de@mx.google.com>
X-Google-Original-Message-ID: <202302031752.@keescook>
Date:   Fri, 3 Feb 2023 17:53:59 +0000
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] xfs: Replace one-element arrays with
 flexible-array members
References: <Y9xiYmVLRIKdpJcC@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xiYmVLRIKdpJcC@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 07:24:50PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in structures xfs_attr_leaf_name_local and
> xfs_attr_leaf_name_remote.
> 
> The only binary differences reported after the changes are all like
> these:
> 
> fs/xfs/libxfs/xfs_attr_leaf.o
> _@@ -435,7 +435,7 @@
>       3b8:      movzbl 0x2(%rbx),%eax
>       3bc:      rol    $0x8,%bp
>       3c0:      movzwl %bp,%ebp
> -     3c3:      lea    0x2(%rax,%rbp,1),%ebx
> +     3c3:      lea    0x3(%rax,%rbp,1),%ebx
>       3c7:      call   3cc <xfs_attr_leaf_entsize+0x8c>
>                         3c8: R_X86_64_PLT32     __tsan_func_exit-0x4
>       3cc:      or     $0x3,%ebx
> _@@ -454,7 +454,7 @@
>       3ea:      movzbl 0x8(%rbx),%ebx
>       3ee:      call   3f3 <xfs_attr_leaf_entsize+0xb3>
>                         3ef: R_X86_64_PLT32     __tsan_func_exit-0x4
> -     3f3:      add    $0xa,%ebx
> +     3f3:      add    $0xb,%ebx
>       3f6:      or     $0x3,%ebx
>       3f9:      add    $0x1,%ebx
>       3fc:      mov    %ebx,%eax
> 
> similar changes in fs/xfs/scrub/attr.o and fs/xfs/xfs.o object files.

I usually turn off the sanitizers for the A/B build comparisons to make
it easier to read the results. It looks like it _grew_ in size here,
though?

> And the reason for this is because of the round_up() macro called in
> functions xfs_attr_leaf_entsize_remote() and xfs_attr_leaf_entsize_local(),
> which is compensanting for the one-byte reduction in size (due to the
> flex-array transformation) of structures xfs_attr_leaf_name_remote and
> xfs_attr_leaf_name_local. So, sizes remain the same before and after
> changes.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/251
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

If xfstests pass, this seems good to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
