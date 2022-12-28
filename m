Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44342657F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiL1QDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiL1QCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:02:40 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D29719285
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:02:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bs20so13193089wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jj57U2uI9msDNKTzmjpPKS0AnQ76SAjTHpihoUn6P3Y=;
        b=KDZp30dSv+s3qN4vPW6zvrh6DM4NtJiH35WJO/kWBKb++abBFrqGeuySYQdYBH3Vp6
         AnnPNW3GoUzAJg8aWWTBjYGxx/uHKBXsVuc8ZkgLAvRnLvWY47hmJq5pXeTOKZ3APoP1
         5l9yXZIjp2RFd+hamwWiwrRzIhC32FNr54SylOPdra1iOpOdE2P4YZZXwUPYnLOcCoIp
         5jEYOyhMiekv9oh3J3HUKi2KP6ZkbHruNOU17rIM3VXx9LN1AUkKdFqy6tQ+MkpwU5Tz
         nnrNPMfeQZEefpJvGB7bom02oxPaub9WHP4tNkFr/XPeNMajJnOf5Y3DBZImqged1Jcr
         ak7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jj57U2uI9msDNKTzmjpPKS0AnQ76SAjTHpihoUn6P3Y=;
        b=DSfp7UhCTRntIUiMD6uJyn5zC/jE9LcU3po03RFXBlKFKNLgLaCN025CAady5NVe3N
         NeiZtiwmVw3zlFF3F6EZOz2jhPztE49v4czmSgGSgWhxgdoJ6DCD16QTnbqbaasLMDo3
         lgJAW+oXb92prHXWSVbIbRzcAOYXlKXaTQv7FsMoXQTfF9tno6W4IB3l1DtIeIZB3C+w
         OJ672UlkVOTpnTmg831vJj0I7yhGi/Tz5AYAxG9G0LUeBMis6QamIRXTJSWZkV0UfPY4
         t6kXRvpEMkqaNdnw4QhNlWOTocfY98L6dK/tnjz/2S5c62CMK6Lm21tB0CB1CywXv7pL
         Z8lg==
X-Gm-Message-State: AFqh2kpiyo5Y6YELmvkGX2XPytKSNRHp3prkec2GdCcStBxQi569DpiO
        dMkYFZVRfwaEUXhcM3Fh9GT3WA==
X-Google-Smtp-Source: AMrXdXtf3ayrmWdF60L/lWpzJOj9QHgs8JOUuL+LYBksy1ySN1/nW5SQWt9by/aROEYptjng4I4vWg==
X-Received: by 2002:adf:f781:0:b0:242:1ba0:208b with SMTP id q1-20020adff781000000b002421ba0208bmr20609543wrp.64.1672243344740;
        Wed, 28 Dec 2022 08:02:24 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id h6-20020adffa86000000b0024246991121sm16166006wrr.116.2022.12.28.08.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 08:02:24 -0800 (PST)
Message-ID: <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
Date:   Wed, 28 Dec 2022 17:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        hpa@zytor.com, bp@alien8.de
References: <20221228143831.396245-1-Jason@zx2c4.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221228143831.396245-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 28/12/22 15:38, Jason A. Donenfeld wrote:
> The setup_data links are appended to the compressed kernel image. Since
> the kernel image is typically loaded at 0x100000, setup_data lives at
> `0x100000 + compressed_size`, which does not get relocated during the
> kernel's boot process.
> 
> The kernel typically decompresses the image starting at address
> 0x1000000 (note: there's one more zero there than the decompressed image
> above). This usually is fine for most kernels.
> 
> However, if the compressed image is actually quite large, then
> setup_data will live at a `0x100000 + compressed_size` that extends into
> the decompressed zone at 0x1000000. In other words, if compressed_size
> is larger than `0x1000000 - 0x100000`, then the decompression step will
> clobber setup_data, resulting in crashes.
> 
> Fix this by detecting that possibility, and if it occurs, put setup_data
> *after* the end of the decompressed kernel, so that it doesn't get
> clobbered.
> 
> One caveat is that this only works for images less than around 64
> megabytes, so just bail out in that case. This is unfortunate, but I
> don't currently have a way of fixing it.
> 
> Cc: x86@kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   hw/i386/x86.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 78cc131926..628fd2b2e9 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -1077,6 +1077,36 @@ void x86_load_linux(X86MachineState *x86ms,
>       }
>       fclose(f);
>   
> +    /* If a setup_data is going to be used, make sure that the bootloader won't
> +     * decompress into it and clobber those bytes. */
> +    if (dtb_filename || !legacy_no_rng_seed) {
> +        uint32_t payload_offset = ldl_p(setup + 0x248);
> +        uint32_t payload_length = ldl_p(setup + 0x24c);
> +        uint32_t target_address = ldl_p(setup + 0x258);

Nitpicking, can the Linux kernel add these magic values in
arch/x86/include/uapi/asm/bootparam.h? Or can we use
offsetof(setup_header) to get them?

> +        uint32_t decompressed_length = ldl_p(kernel + payload_offset + payload_length - 4);
> +
> +        uint32_t estimated_setup_data_length = 4096 * 16;
> +        uint32_t start_setup_data = prot_addr + kernel_size;
> +        uint32_t end_setup_data = start_setup_data + estimated_setup_data_length;
> +        uint32_t start_target = target_address;
> +        uint32_t end_target = target_address + decompressed_length;

Maybe we can simply use 'unsigned' type.

> +        if ((start_setup_data >= start_target && start_setup_data < end_target) ||
> +            (end_setup_data >= start_target && end_setup_data < end_target)) {
> +            uint32_t padded_size = target_address + decompressed_length - prot_addr;
> +
> +            /* The early stage can't address past around 64 MB from the original
> +             * mapping, so just give up in that case. */
> +            if (padded_size < 62 * 1024 * 1024)

You mention 64 but check for 62, is that expected? You can use the MiB
definitions to ease code review: 64 * MiB.

> +                kernel_size = padded_size;
> +            else {
> +                fprintf(stderr, "qemu: Kernel image too large to hold setup_data\n");
> +                dtb_filename = NULL;
> +                legacy_no_rng_seed = true;
> +            }
> +        }
> +    }
Fix looks good, glad you figured out the problem.

Regards,

Phil.
