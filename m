Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521266FD2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjEIWgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEIWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:36:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8F173D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:36:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aafa41116fso44976745ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683671800; x=1686263800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAUvYXFmkyCFk2bFrdDfZjD0FvyEnLowLmKsE/svUN8=;
        b=Oa1zYBCfL6x04TEB0lvreU5pTsjAhVPT1viHyMdG76reRogKSY+Eexe5f5732RTODN
         GXpGsRGJ3ofj7vGONTBtqvEvTcfssc0t+A+yHOwbVVlM5OB2jf1ELT2unAQIsBjN6Mql
         C+UDNdhSe6pvOVZiO3g8yk12Q/tS+cKKbTx+FPsdUVafPwkxzEZ/bDy00pbU4WjBgAMi
         mouwNNwSBr0chIwULJPC0DHpvkpPFBroTS15u/T7ZKGUdi/vZf998TO/atTy/DoILyiE
         IDRz+EwdeGcUeod3OVVsGJ2mLBlXCc68LQJvoGVAMRGioCcejI59vs2uagSJS7ti96yN
         v3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683671800; x=1686263800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAUvYXFmkyCFk2bFrdDfZjD0FvyEnLowLmKsE/svUN8=;
        b=Wyts1M3RmlXMrwzS2XszqfZRAoMvo/u6pqzXJ7jAw9DzF/m7u6fjiz276gKh3O2/2E
         JqeLKLLlJ9AH0pl2FhN156ke+mSNnx42HVZb9Jc7Bhg8ZSP+ijs7kG8+2/imO9ZENgbj
         qcnJ6Kgz8kKOK3A/IRwKEOUfgfYlsH5BbS7UfkXFx3rE3wYXOUbXX6tKJmQazdOExQOc
         PG7abHei0pQxXPBOCDSLSH+fDalBQYGHwfIn5XrkIb8eU78el5Er8dsbdStMNmUg5iI5
         Tuw7hc6kMPSQID350QVkq7fgWqCGAcwxYE6oi9ByH+6zZRKv859e+WvQn2Mkbv96GTEc
         JlEQ==
X-Gm-Message-State: AC+VfDwi2Ev7QCrhi19dKmGujnDVuOw6SzAqBTNcYP5na77bBQxVpGxv
        bt+rilc6BVxipFXwhjs7c64=
X-Google-Smtp-Source: ACHHUZ5uoTV3cp7K0mxneT7ipwFlUDe5DMEE+9Gj+jW6I+dVAPdxndUcmU/3ibv6Ol6OB+jIR+rgdg==
X-Received: by 2002:a17:902:7290:b0:1a9:7c6d:abb with SMTP id d16-20020a170902729000b001a97c6d0abbmr14189221pll.29.1683671799163;
        Tue, 09 May 2023 15:36:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jw9-20020a170903278900b001a1fe40a8dasm2119657plb.262.2023.05.09.15.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 15:36:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 12:36:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernfs: Prefer strscpy over strlcpy calls
Message-ID: <ZFrK9Vw9sbE6NSLi@slm.duckdns.org>
References: <20230509223036.3007500-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509223036.3007500-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 10:30:36PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated.
> Since strscpy() returns -E2BIG on truncate, we rely on
> strlen(src) to imitate strlcpy behavior.

The security angle is too hand wavy. If there are bugs in source string
handling, please identify and fix them. The performance claim is dubious too
given that in the vast majority of cases, we'd be copying the whole string.

I'm not necessarily against conversion if we're unifying the code base to
always use strscpy but the currently provided justifications don't seem
strong. I mean, if anything, we know for sure that code churns like this
have non-trivial chance of introducing new bugs.

Thanks.

-- 
tejun
