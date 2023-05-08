Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFC46FB35E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjEHPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjEHPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:01:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71918107;
        Mon,  8 May 2023 08:01:17 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24ded4b33d7so3174593a91.3;
        Mon, 08 May 2023 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683558077; x=1686150077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwuEFswjwM39alefSERoo8uDLiBlpgOGT7lCw+29x0M=;
        b=j3fCI18IFdDkCfixXqPyFMHXC11/ozVPiBVQ+btIvST69Q+FkYsDG2p47TdtUnMmeG
         xKsaO08e+ltVDvrSRYpPfcrC+8FBG5wMvxpPVNC9PTvJkVQcwbz8cOOtn6l5R4iMqMTd
         OAZlFN1FhJtYvrzEgg5gXq1hv6oFdZZjzBRqDtjeh6CgZRLH5KFHpQKxrNtftkQpaGXd
         /VihLM9z0KczXtgyMf25185dswV7PEx85kYC/EHiLsUKn6dp2fPUU7I1IhJznCtnIqN4
         vQuCwpnnArDsZ5J8Vjn14YMsaIu1k5BtN0AhN8CYPsmX75+j7Y+oNZxK2AkAO3pGVvP6
         HE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683558077; x=1686150077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwuEFswjwM39alefSERoo8uDLiBlpgOGT7lCw+29x0M=;
        b=fIJbmwwp7tXyUQJjULKBTwnxIv/BlXzv/p+wPaFZ98H84y7VJOCwyFIYNlGHkOVkgO
         kAVqxNNvXp0k+0lsZdvPZEcSx9tCIh09stf67l/Z/sIGWqGAeffr5bYm93XG8j3lTsWJ
         ZvP9iso7xSiuUXdYkeP1ozjBiK8isxbFAQfM1r7lsTXluXH0JQqaAqT2pte+cXWQD1c6
         9HKHU93R6kEW8V554aH2Iz2GaUqVs9plxoymV6KQMLYgUGw2DXDeqgTSuanjWhXi6nw8
         z6fMGdALsxOqRJ21KHtam+2sWlJwYMb5NCe6M1d5KqFDlGcf8MXFkziBtr4s04roSLq6
         CpsA==
X-Gm-Message-State: AC+VfDzRR4khOhVwiPWPFKXXahOsPsBx6n58jBw2yaPz55C3rzExcgaY
        FWnwY1YO6inRea7i321rIt8=
X-Google-Smtp-Source: ACHHUZ7X8/aecoEG354Z34PKQq/LvS3YTbQK2ojSvJMkJzjIifNYcQ5CdvSsG+MI6RNaGU9GZXwVlQ==
X-Received: by 2002:a17:90a:a798:b0:24e:3c23:9650 with SMTP id f24-20020a17090aa79800b0024e3c239650mr10308663pjq.44.1683558076595;
        Mon, 08 May 2023 08:01:16 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4d1:db5a:dbba:cd34])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a46cf00b0025069c8a151sm3078260pjg.53.2023.05.08.08.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:01:15 -0700 (PDT)
Date:   Mon, 8 May 2023 08:01:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Teng Qi <starmiku1207184332@gmail.com>
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: input: input: Fix possible sleep-in-atomic bug
 in input_alloc_absinfo()
Message-ID: <ZFkOuOmkIiYuQBpz@google.com>
References: <20230425074951.1042694-1-starmiku1207184332@gmail.com>
 <ZFBheCRW5fbzVK1V@google.com>
 <CALyQVay-_StW8ZghzF0DUp75UFZvssh-RcPC-DvHPgFLt0np=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALyQVay-_StW8ZghzF0DUp75UFZvssh-RcPC-DvHPgFLt0np=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 03:13:19PM +0800, Teng Qi wrote:
> Thank you for an alternative solution. I will take a closer look at the
> patch
> you CCed me on.
> However, I am still confused about why this cannot happen in practice.
> Could you provide more information?

The only call to input_abs_set_val() in the event processing code that
is running in an atomic context (under spinlock) is done for
ABS_MT_SLOT, and the call is protected by checks ensuring that
multitouch was set up properly for the device. This includes allocating
absinfo. Therefore while the code may trip up static analyzers the
problem will not happen in practice with the current code.

Thanks.

-- 
Dmitry
