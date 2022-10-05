Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6999E5F5B01
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiJEUbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJEUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:31:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DCC33362
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:31:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o21so131359ejm.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4DE+yenTrdnr13EVH7mfQImiu/cdfe1kOZixAAYiF78=;
        b=RVSv3DvD4T2iNQ4pozod2XCRoqU4Vs0tNASdbMkI2MpvK+bkSWk4CSD7CqbRRVrNeq
         JfY1zENhriRZ1uiMxJGPsctFYOYYy0H2tnMzJJgSOKE7dvJy4uRN6qczysqkhPguc0hl
         ySrPkJceRBTDDD+m/+TJmY9ZDuGF5ZlAPyAuA8nNZFWW5yLrLAixsCX20LF5FmoacAhs
         thGYJaL9b5flVXUCtt9IvPv2amQi5RBgM8NnV/PTVbZo15ygGB5V5NDBANajrDuJrpVX
         hvKyUI860je8DQr8MOhqYt0efZOuQ/+SPE+enAKd5IPeGK60eCKnmdMvs4dMRVSOb2SN
         kyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DE+yenTrdnr13EVH7mfQImiu/cdfe1kOZixAAYiF78=;
        b=WoSOywMP+yBID8X1DPiw4dffOySZKIbrV8r8vrxfeK3eozIkEoOTZ8+8CDL8WjlpLE
         W3Ws4DAAhOkz+eB3/nUnvApLsT3shIyg1jcc+eUNEmdxohCsXFtPikSZlS/1h71CM3Ap
         J70ixjAJNyNHbYgRUxxM7fYg+0d2HnHQAXFFx5XPEO3RYlcqfzyv8tDWMgWGHt3GO6fS
         WPfoB+ODldo6JOp3fz5Ky7MVeLQctHf5A5+2YmTxXQujcrwwFy3Htb1GspN3Mv01H9Cl
         ryaMvUrmwq2axvk71mAYjq1tJshMwZng3xxrWEXn3Z6mKElAE35ES1bm4O4DzpUx9VXc
         Z6uw==
X-Gm-Message-State: ACrzQf2vy8oN/zVgyJ1WvzkW/fRLQAMrxQ/tzw6L/6XaisCh2ljRnAkJ
        imbT8k6W/fHc8DNu0PAr5VXn4HuDkHqd7nS6pG9zqg==
X-Google-Smtp-Source: AMsMyM76ZKyKq6Q/2gzxMgEMZQp4rMBbSfUdiecWqIe36SAVMjJ5F1xB0TqZdCp4jf+Qr5jJwU+oN5U9SkCMHwlvbiQ=
X-Received: by 2002:a17:907:a04b:b0:78c:ffac:4bee with SMTP id
 gz11-20020a170907a04b00b0078cffac4beemr1085751ejc.631.1665001866644; Wed, 05
 Oct 2022 13:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171534.3576419-1-dlatypov@google.com> <20220722171534.3576419-2-dlatypov@google.com>
In-Reply-To: <20220722171534.3576419-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Oct 2022 16:30:55 -0400
Message-ID: <CAFd5g45KKS3dn2M6WPoRbDY+ejZ4GG=iyeNc5h9f8BDxrwc8jA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] kunit: drop test pointer in string_stream_fragment
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, Jul 22, 2022 at 1:15 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We already store the `struct kunit *test` in the string_stream object
> itself, so we need don't need to store a copy of this pointer in every
> fragment in the stream.
>
> Drop it, getting string_stream_fragment down the bare minimum: a
> list_head and the `char *` with the actual fragment.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
