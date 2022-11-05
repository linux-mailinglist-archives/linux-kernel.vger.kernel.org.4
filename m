Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BBC61A6A8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKEBeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiKEBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:34:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4653FBAF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:34:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c25so8663831ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uCv2L/5NmoyXeeSSJaX37ApucqxdmMCa50oaENNkbOY=;
        b=dvrzj/Rm+yGMXfV9bAp7ZbfX7dPuQbrAvJzPTjlXVCp2PJFzZ6uKXKR5m9dRT9qQ9H
         C53lIgkb5+Yr9wCtsYgK3tjCVyOQccZjSRGFlgJMT5JfXyyuoT/D4ZUmvsDeL+2vu9o7
         yipjwtRZJhla5zdiqqzMS60c424Hto3hPX5Rf1qNOCWH5lpTKhZftjpWuhb9VfYD54pn
         14saGag6XFzT3cFkp6yYKsH4nTZE8m6EXjukcWdWqFC70HbmfXWC4FoVTfpCNT65qpVJ
         /aUamgZVHTyqTtsv1sJ9WvYqXTfV6RL6JncmZe6hD52cQ3bWQ0qgbKbY3MkHJvE0+SF4
         sCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCv2L/5NmoyXeeSSJaX37ApucqxdmMCa50oaENNkbOY=;
        b=gKQ6yIYgLC+iHUftwJt15JE3mSZchDGecB3wcUJTvqd4Z0ddJLE2l5ftJocBBEwADV
         aB27LPZzOHjBs+YwTMBHEPdMB7FCUlaK+HrCtdITh7kW7fEzumwHzd1Lulwp4QzpkrPV
         ZMjP1MPtOyggGEjGc4akCWdb4ENDCXsKjASdrmlSawBvKfjNRaUI5F2RCLRSKlO4ztJ9
         WJj04kwc1/Bxsyt+2jdvhhFJHXOPAmzdtuQleno0orOWyR9DaGMHxpD1NJY1XTQp7NQZ
         5tbXSpMiWVBYSuoUi2DpHB1h4TEM0L2LCDmZx5GKNI7jJhE/EF+J8FBjkrxBZISXDEyg
         wbLA==
X-Gm-Message-State: ACrzQf3Al0tgid2TiidWQjRRGrv6yBgPbPntoTukQPAYynzLtv72I0eT
        y/t15XMCNsPswUy+iIAW1p+fDJoQwKKWbTBa5r+5eQ==
X-Google-Smtp-Source: AMsMyM7Nc1dGedP4TeAa4OFAfArSvEgashoGkfPpAErOlP3m5TWN9LSDtd3pEkKk/EOjbVDiqJswtRNt0g0S6kxJMzY=
X-Received: by 2002:a2e:a163:0:b0:277:159b:4da2 with SMTP id
 u3-20020a2ea163000000b00277159b4da2mr14017621ljl.502.1667612050317; Fri, 04
 Nov 2022 18:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com> <20221104230040.2346862-5-dionnaglaze@google.com>
In-Reply-To: <20221104230040.2346862-5-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 4 Nov 2022 19:33:58 -0600
Message-ID: <CAMkAt6rS15hAWMYpZB_RxR3k+g1dPCK43rxRnv54+k=QgGqweQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] virt: sev-guest: interpret VMM errors from guest request
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
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

On Fri, Nov 4, 2022 at 5:01 PM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The GHCB specification states that the upper 32 bits of exitinfo2 are
> for the VMM's error codes. The sev-guest ABI has already locked in
> that the fw_err status of the input will be 64 bits, and that
> BIT_ULL(32) means that the extended guest request's data buffer was too
> small, so we have to keep that ABI.
>
> We can still interpret the upper 32 bits of exitinfo2 for the user
> anyway in case the request gets throttled. For safety, since the
> encryption algorithm in GHCBv2 is AES_GCM, we cannot return to user
> space without having completed the request with the current sequence
> number. If we were to return and the guest were to make another request
> but with different message contents, then that would be IV reuse.
>
> When throttled, the driver will reschedule itself and then try
> again after sleeping half its ratelimit time to avoid a big wait queue.
> The ioctl may block indefinitely, but that has always been the case
> when deferring these requests to the host.
>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Liam Merwick <liam.merwick@oracle.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Haowen Bai <baihaowen@meizu.com>
>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Peter Gonda <pgonda@google.com>
