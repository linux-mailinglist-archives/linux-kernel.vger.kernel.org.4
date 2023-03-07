Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3516AE4B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCGP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCGP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CCBF94A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d7tFpiKXqynWtvnyoZW3Uouf3NrvbrWsNMhlga+8JZ4=;
        b=aXUK6NjPoiUC0SDQROBg/1tkRMN/7WDsOWWrWHHLUhUU8Wqf+VCioBE6D01Y/dHIx6MCXg
        nWUQvb8fQP5C4v5k4deJtzcLDRet4/GGR3nWbQRKBZH19ZOf51+qbwh/La2ANhY//lICRP
        Nid8znsNtDhqNl7vOMsN8cV/VFJoMSE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-ywwVfhjON9epUEti2xvDbA-1; Tue, 07 Mar 2023 10:27:20 -0500
X-MC-Unique: ywwVfhjON9epUEti2xvDbA-1
Received: by mail-qk1-f198.google.com with SMTP id dw26-20020a05620a601a00b0074300c772c0so7578334qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202824;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7tFpiKXqynWtvnyoZW3Uouf3NrvbrWsNMhlga+8JZ4=;
        b=wjMoL3CDlS9YZafX3Oeqt9mQNQ2zHJbia2G0UB1SNztXjiihWZL8/rAWB985BnCwMm
         HXwEW2tslkApIxnhcxNd0cY9yqKkPFzxMALTMJE6MtI+H+LTcCS4/10SR3zf/ycwD4hy
         4Yj5FxGS1EZj0739OUMmrdoX0IdnCfMb72RuFW0osMLoBQP/eGhyyRaiP03R9XvV1SCO
         5qlNwi0+xOK1kALW99W4CLI5+eFOrCi7BfW+9bcWcS+HGH2EnL9Byok03St2WWLAlePm
         gZkZA7NHhwmTKFr/dbRm3w0eWJ1pf9Qo2DEnYar0mSLf4anIBm/ElsX0Zo8gxTnCIphX
         N1iw==
X-Gm-Message-State: AO0yUKUj2yrCp0Y5PQHu6TwjINvFF+TOjaRxes0FFKYimKCBbIoKSyii
        ciumpsrT5b022qBi/1D2Sg5Y0pHCzuB//B+WTx6WAUYp6zuHXj12XNZi0lx5Ci8Fbl/kP1a02Cm
        sGXdXFd44P5L7lagQ65OVf2l3
X-Received: by 2002:a05:622a:134b:b0:3b6:3260:fa1d with SMTP id w11-20020a05622a134b00b003b63260fa1dmr24994776qtk.45.1678202824725;
        Tue, 07 Mar 2023 07:27:04 -0800 (PST)
X-Google-Smtp-Source: AK7set9E77kRVz6L/w5+ZV6JnWce7W5sJvJS0bvPmMpm2NcunH+obLSA1UxzvjjWrf8oYrOuYT2pSA==
X-Received: by 2002:a05:622a:134b:b0:3b6:3260:fa1d with SMTP id w11-20020a05622a134b00b003b63260fa1dmr24994738qtk.45.1678202824456;
        Tue, 07 Mar 2023 07:27:04 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v25-20020ac87499000000b003bfc0cca1b7sm9718293qtq.49.2023.03.07.07.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:27:03 -0800 (PST)
Subject: Re: [PATCH bpf-next] bpf: Increase size of BTF_ID_LIST without
 CONFIG_DEBUG_INFO_BTF again
To:     Nathan Chancellor <nathan@kernel.org>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, ndesaulniers@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
References: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <58eb6412-9d32-1175-94fa-af620ab80f4e@redhat.com>
Date:   Tue, 7 Mar 2023 07:26:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/7/23 7:14 AM, Nathan Chancellor wrote:
> After commit 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and
> bpf_dynptr_slice_rdwr"), clang builds without CONFIG_DEBUG_INFO_BTF
> warn:
>
>    kernel/bpf/verifier.c:10298:24: warning: array index 16 is past the end of the array (that has type 'u32[16]' (aka 'unsigned int[16]')) [-Warray-bounds]
>                                       meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
>                                                       ^                  ~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared here
>    BTF_ID_LIST(special_kfunc_list)
>    ^
>    include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
>    #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
>                              ^
>    1 warning generated.
>
> A warning of this nature was previously addressed by
> commit beb3d47d1d3d ("bpf: Fix a BTF_ID_LIST bug with
> CONFIG_DEBUG_INFO_BTF not set") but there have been new kfuncs added
> since then.
>
> Quadruple the size of the CONFIG_DEBUG_INFO_BTF=n definition so that
> this problem is unlikely to show up for some time.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1810
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This has a better commit message, let's use this one.

FWIW, gcc 13 -Warray-bounds, did not catch this.

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
>   include/linux/btf_ids.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 3a4f7cd882ca..00950cc03bff 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
>   
>   #else
>   
> -#define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
> +#define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
>   #define BTF_ID(prefix, name)
>   #define BTF_ID_FLAGS(prefix, name, ...)
>   #define BTF_ID_UNUSED
>
> ---
> base-commit: 36e5e391a25af28dc1f4586f95d577b38ff4ed72
> change-id: 20230307-bpf-kfuncs-warray-bounds-c2040e8ee7ee
>
> Best regards,

