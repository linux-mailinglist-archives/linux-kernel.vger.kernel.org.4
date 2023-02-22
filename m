Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8445769F952
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBVQwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBVQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:51:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EFF38B6A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:51:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id k14so9881783lfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8a+6i/8kWloQPBl29m7e9d5jTRMV0KvfLP6PWCz06A=;
        b=iFCDSGes+2EvEYKVfe1X4fB4LlWwoKAScLJfZxDzkgown1bZad2MSFQFV27vrcQkcW
         LdWwzZaQl4DHh2qG4P2oG0qhBaxmBFg9zVAIbKDb5bDX1yROn/TCt6bIVUsp32HwcGp+
         XFnyAZti8+3gxddbyIqTV4nAOUQC1HktdRqtQ/J8EO/AxNeeY/Ix0CTup6lZT8ADdglf
         N8mfVh+RZo/KwUgYhL7LEpcXy2DdOvj21ll5/yUgWfp9A00S1DPelBIHaEmAElS8ULZj
         GE/LTFBpZ+jN7CE0m/W90aSUhOQ/pAYRSB//PXGA+3CuUppCgIaS81gEk8kUXd82cvbX
         b13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8a+6i/8kWloQPBl29m7e9d5jTRMV0KvfLP6PWCz06A=;
        b=yOGmACDZpf2ISFFjBnonormCaD/Vh1kbwc5+WHFmEk39DKb7nR8Rc7bereLzuXcdRz
         3Al79MY4gzrbgIimFCJryI9GjFLWPyTATgvnnYV2IUS7XZX6zMQHxNOOjQ9mV3fCYi2y
         SNhRUJMKtHzwsqb3sw2Kmt98ulJ1Moq/Zu+0VUXScrWzYYbOvb2F3PO9vvfWd/nRnPxl
         WQGl1wuc8Yh81DxK/DUgjhqu5uNe+JE0mpRsDB16NQ07Y2SbN50NmLsOFVmMl03pR7Yq
         KzG/0e1NPsKV3bBwu5Yt87xxZCEQ3skBxUJESAsEG7PiSxEsXa+cdFYVdivOSi07SJzZ
         SLzw==
X-Gm-Message-State: AO0yUKWcRf3LPPQx3GDCFQdWDI+eUKvgIVFdzgNmyEw11ekIf0zo3KRb
        drEDNgYgyOKJj1dNZ4OrwHx3ib1Dv1643UoSjPBMZ02eVoJY0fCY374=
X-Google-Smtp-Source: AK7set+a0qMW+s6yEhzLNtGP+lyaAJ1ls3bkDAJHzNZ+mynszom6vOWyjRCymhG7pMasmKizrvNdcleHniso67ihKGA=
X-Received: by 2002:a19:c209:0:b0:4d5:ca43:703d with SMTP id
 l9-20020a19c209000000b004d5ca43703dmr2891742lfc.0.1677084715742; Wed, 22 Feb
 2023 08:51:55 -0800 (PST)
MIME-Version: 1.0
References: <2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee.1677083979.git.thomas.lendacky@amd.com>
In-Reply-To: <2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee.1677083979.git.thomas.lendacky@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 22 Feb 2023 09:51:44 -0700
Message-ID: <CAMkAt6pqyOqVd_etLVfwrihEoc6XtS+BaVsV8x934rr4LmOCgw@mail.gmail.com>
Subject: Re: [RESEND PATCH] virt/sev-guest: Return -EIO if certificate buffer
 is not large enough
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Larry Dewey <larry.dewey@amd.com>
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

On Wed, Feb 22, 2023 at 9:39 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> Commit 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest
> driver") changed the behavior associated with the return value when the
> caller does not supply a large enough certificate buffer. Prior to the
> commit a return value of -EIO was returned. Now a return value of 0 is
> returned. This breaks the established ABI with the user.
>
> Change the code to detect the buffer size error and return -EIO.
>
> Fixes: 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest driver")
> Reported-by: Larry Dewey <larry.dewey@amd.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

My bad. I wasn't testing the return value in this case.

Should Boris take this patch into the retry series?

> ---
>  drivers/virt/coco/sev-guest/sev-guest.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 4ec4174e05a3..7b4e9009f335 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -377,9 +377,26 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>                 snp_dev->input.data_npages = certs_npages;
>         }
>
> +       /*
> +        * Increment the message sequence number. There is no harm in doing
> +        * this now because decryption uses the value stored in the response
> +        * structure and any failure will wipe the VMPCK, preventing further
> +        * use anyway.
> +        */
> +       snp_inc_msg_seqno(snp_dev);
> +
>         if (fw_err)
>                 *fw_err = err;
>
> +       /*
> +        * If an extended guest request was issued and the supplied certificate
> +        * buffer was not large enough, a standard guest request was issued to
> +        * prevent IV reuse. If the standard request was successful, return -EIO
> +        * back to the caller as would have originally been returned.
> +        */
> +       if (!rc && err == SNP_GUEST_REQ_INVALID_LEN)
> +               return -EIO;
> +

Why not set 'ret = -EIO' and use disable_vmpck directly? That seems
more clear to me instead of failing on the next call.

>         if (rc) {
>                 dev_alert(snp_dev->dev,
>                           "Detected error from ASP request. rc: %d, fw_err: %llu\n",
> @@ -395,9 +412,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>                 goto disable_vmpck;
>         }
>
> -       /* Increment to new message sequence after payload decryption was successful. */
> -       snp_inc_msg_seqno(snp_dev);
> -
>         return 0;
>
>  disable_vmpck:
> --
> 2.39.1
>
