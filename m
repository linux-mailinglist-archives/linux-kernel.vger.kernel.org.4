Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C175E54D8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiIUVAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIUVAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:00:41 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800359F77D;
        Wed, 21 Sep 2022 14:00:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE8B3536;
        Wed, 21 Sep 2022 21:00:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE8B3536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663794039; bh=7isKC+YSrGaask6vUXhGDpDQnw8IL3toZv6gUCLE72s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rEOiBVfntAQvQ1GXrONqpjs813fenB0/n52jEVdwxQ1YknIczxpIKHAmyjezOCPxg
         o1aKp2E2GraujCxZmQ+hGhSFbda0QsqNhQOj0OpcfE3Qbjo7lUgAz34y0IzS14BEK7
         JOzPWrqIVvpVOHqYgJS270Gv5p1JcGSp7WT7anNLntwFeqjh23hk5glbEAWcAbXpOT
         cafgxu3hHWtRwGBV2u/aggSOC6rIoQO9ks5ckVyCCqXdL3qziATkQ+9qvqzAih1iVR
         DdkkTgrwNZzHDyrnHRnsjtc8qduw3CAYr8++oGI0UC0Ho/9Rp4XqnEFZW6psFNuCEL
         mDFM0l/VGvb7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC] docs: Define c_paren_attributes for attributes with
 arguments
In-Reply-To: <20220902223507.2537469-1-keescook@chromium.org>
References: <20220902223507.2537469-1-keescook@chromium.org>
Date:   Wed, 21 Sep 2022 15:00:36 -0600
Message-ID: <87mtastpcb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> While Sphinx's "c_id_attributes" is needed for basic attributes, any
> attributes with arguments need to be defined in "c_paren_attributes"
> to avoid errors like:
>
> include/linux/fortify-string.h:116: warning: Function parameter or member '__builtin_strncpy' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '1' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '2' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '3' not described in '__diagnose_as'
>
> Move such attributes to "c_paren_attributes" and add __alloc_size
> and __diagnose_as to the list.

So which tree are those warnings coming from?  I can't reproduce them
with linux-next.

As Akira noted, the kernel-doc script is the source of those warnings,
so changing the Sphinx configuration is unlikely to help.  I think we
just need to teach kernel-doc to ignore those attributes.

Thanks,

jon
