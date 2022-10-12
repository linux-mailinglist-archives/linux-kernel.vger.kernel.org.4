Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67975FCEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJLXbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLXbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:31:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E31B792E8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 16:31:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu25so62194lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 16:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oVfzjJywpJ4GYbFJMqXBRtUkuMRGMygdtzhfFYhaojo=;
        b=aaH5lDtO91ywVHHYdmOfHL7xUWG7/eFKHgAbuU9PEmtFkFq+BxZRA4lv6oZLyvJWgQ
         t9QVrtipWZY4+uvfZ6afTID3CMSX1CKpE9Te0lhopse702/QvnRrVP0bUwFVxNn6jCWS
         DeseKmsgklxt0n5dUCYbyoJ8XQSzfJ3je2gYiQ7RnOycEvHcEgmmvLBD1nbefj9RP9Lh
         FxpJuyTrztRapcwUaY0su4uFFZNJTyu22Ww28nB+WYpSmagGQADxgM1jRHKRQFM5w5Uv
         8Tz9WORorRT++XkfYAUHK87VqBeTWV2LBscsxAk7rJAbP1MQjFkZTsFNF2A2Hln8gkGj
         uyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVfzjJywpJ4GYbFJMqXBRtUkuMRGMygdtzhfFYhaojo=;
        b=YJQgYeLt/sCA4N6NgGHWUBaFQU2kdMVGcvtFcw4iQpdFQGAI9spMlHk0Fu1yOKy5dI
         qaFyxmybCu2iAikIzB/yQ7ioar5H1AxN9Esy8PMWCLPQEfi6XoDwRdoi18AKONUQqvTp
         Je6gU+Kuzyus7ODpIEZPwjn7vJaKTsOYCNmbo27Sq8h7rn8BZSW+mucmJo+UZb3936vN
         +xZA3iJN7dvhI25pd7R5AEBQdK/pZzdUjK1SVuQLIfeuIlSol/xNCWDKIZrNLZWytOiw
         LZfjHCsQvujHlRu04jnRGXgy7oqaPQ3G27+MsKw0QJEOl4YSI3Crx4cxN7+z+t5IW6I4
         /PMw==
X-Gm-Message-State: ACrzQf0mz9If7vBEP42B/M8MpUKEY+vqXN55KCRwE6mP/nvX+g4I48Pj
        IxrfhIgjCTygMpyXzxa3WyOtFTdq6LwXHT55lopaqg==
X-Google-Smtp-Source: AMsMyM6mzIpOL6t7cpBb/jsaozpaiOS6m22ehW2HwHZdUf8YWU3nj/YGkK9OdeVi9hreGmmS0w5IorKfqw1Y8HjenwE=
X-Received: by 2002:a05:6512:70d:b0:4a2:2bd5:4694 with SMTP id
 b13-20020a056512070d00b004a22bd54694mr11666957lfs.313.1665617491441; Wed, 12
 Oct 2022 16:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221012002323.2015637-1-dionnaglaze@google.com>
In-Reply-To: <20221012002323.2015637-1-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 12 Oct 2022 17:31:19 -0600
Message-ID: <CAMkAt6qj-iHzk+FqCGh5z4EZHB9BzOfqES8RmjgYXs3CSg3CXQ@mail.gmail.com>
Subject: Re: [PATCH] virt/coco/sev-guest: Initialize err in handle_guest_request
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

On Tue, Oct 11, 2022 at 6:23 PM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The err variable may not be set in the call to snp_issue_guest_request,
> yet it is unconditionally written back to fw_err if fw_err is non-null.
> This is undefined behavior, and currently returns uninitialized kernel
> stack memory to user space.

Should this be fixed in: snp_issue_guest_request()? Since other
callers might make similar mistakes.

And currently we have:

static long snp_guest_ioctl(...)
{
..
  input.fw_err = 0xff;
..
}

Which I think is an attempt to make fw_err make sense if the FW is
never called, should we try to maintain that property?

>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>  drivers/virt/coco/sevguest/sevguest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> index 112c0458cbda..7a62bfc063fc 100644
> --- a/drivers/virt/coco/sevguest/sevguest.c
> +++ b/drivers/virt/coco/sevguest/sevguest.c
> @@ -307,7 +307,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>                                 u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>                                 u32 resp_sz, __u64 *fw_err)
>  {
> -       unsigned long err;
> +       unsigned long err = 0;
>         u64 seqno;
>         int rc;
>
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
