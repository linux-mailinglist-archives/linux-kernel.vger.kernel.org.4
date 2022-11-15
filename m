Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B914629B38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKONxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238528AbiKONwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:52:54 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853428E00
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:52:27 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id y18so3011618uae.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P+oLe8m4JsBwN5p0lAPR+5zPDiV75uMFdS4+LeqtzPM=;
        b=hglPUSxYb8VugAgrBpcKiOxPSsVl2B87pO4L09Q1t2FXSTwVU5vtoweEsLguIUKVuE
         WH56RT72py3vZfCq5BmkusmHK6S6j6uEf+1fdwuYz4JPUKS71LhCQ1caG1E/M1NmzVei
         VN1gM5m+pLYim0QVnTZTAgKlwGlYflPsMRYhqsGhhjIjJhoqRf8GtvwStL9tP6iQoxx2
         4YMI4noHZK5JwbCoJkcbYT7jSsIl8WizArNK/Dv5JPFzILEZ3LXtsAPfcTX+gGlFNfTA
         SKy+cp7iQ9ig3SEkmnw9HnGTrDv+eQNxzdrFdT3x5zWsEUmT6IDob8jITY7ZFD6beiZ5
         ZfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+oLe8m4JsBwN5p0lAPR+5zPDiV75uMFdS4+LeqtzPM=;
        b=oyegWr1jniBltAGwh53MZpqd2OS0WXRaCeWzY7osNCSnkge+hkJBaX1KKrN49wP5T/
         MOZOSbMBf1cc1AXujaXMJFwXbHnWe0272YpDUq0+aFzOpc+SBjd+zre9Jr4bnHKO3ykE
         Fft4X2foyO9s4BvDws+uri6D4Q/ok55ONWXN1PA/i0do/A7DvcUTah72OuUdzldGSSM0
         wpQBragmfBW0uB6GdVdFJ/XHZRXYxSskuzdBlSFhrB6Bi07VwUVnsE5Z7eBzhzfP1Z9A
         9vjY6+C76qMs9i5zOiiYCqXYiy9gOCImV9QhxGRYTxNHzeyBKJCMTTUkMAoAHhy2F423
         j64A==
X-Gm-Message-State: ANoB5pkJb5y5HMlviVcPQdx0l/vacG2FOxGbwHexCIM5QUyTaYqBY1kW
        u0D9iFBq6rSYu3nTlq3wDPRuJGKu1KfOqolcwB65ng==
X-Google-Smtp-Source: AA0mqf5KtyZPTuevXaQKbRumSbUnofBE1AjlQJ8Tfiqj4nemFDG9ar99A+nJ1Lu4rJw4pQcf0Lz/ijjdyAgkYSKSq8w=
X-Received: by 2002:ab0:250d:0:b0:406:b37e:55dc with SMTP id
 j13-20020ab0250d000000b00406b37e55dcmr9495551uan.63.1668520346579; Tue, 15
 Nov 2022 05:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20221115091138.51614-1-wupeng58@huawei.com>
In-Reply-To: <20221115091138.51614-1-wupeng58@huawei.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 15 Nov 2022 05:52:15 -0800
Message-ID: <CABXOdTcDuugW7t=MV_1Cy2cbe6GC4dUn_=4VmrYHobLzx1uscA@mail.gmail.com>
Subject: Re: [PATCH -next] firmware: google: fix a NULL vs IS_ERR() check in cbmem_entry_probe()
To:     Peng Wu <wupeng58@huawei.com>
Cc:     jwerner@chromium.org, jrosenth@chromium.org,
        gregkh@linuxfoundation.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 1:14 AM Peng Wu <wupeng58@huawei.com> wrote:
>
> The devm_memremap() function returns error pointers on error,
> it doesn't return NULL.
>
> Fixes: 19d54020883c ("firmware: google: Implement cbmem in sysfs driver")
> Signed-off-by: Peng Wu <wupeng58@huawei.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/firmware/google/cbmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
> index 685f3070ce9d..88e587ba1e0d 100644
> --- a/drivers/firmware/google/cbmem.c
> +++ b/drivers/firmware/google/cbmem.c
> @@ -106,8 +106,8 @@ static int cbmem_entry_probe(struct coreboot_device *dev)
>         entry->mem_file_buf = devm_memremap(&dev->dev, dev->cbmem_entry.address,
>                                             dev->cbmem_entry.entry_size,
>                                             MEMREMAP_WB);
> -       if (!entry->mem_file_buf)
> -               return -ENOMEM;
> +       if (IS_ERR(entry->mem_file_buf))
> +               return PTR_ERR(entry->mem_file_buf);
>
>         entry->size = dev->cbmem_entry.entry_size;
>
> --
> 2.17.1
>
