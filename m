Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7262A2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKOUTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiKOUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:19:20 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A72C665
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:19:17 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id g10so10309830qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg2p+d9BTb0sDApPTHD/FCt+oKLyPxzeDhZVVD2/bvE=;
        b=oiqPPIadrE290wPskdviykHavn9ie2jg0rNWMYK9DXxkRRR5tL5u9Kw+40VMQRXpmL
         YmsMd8l3Mf8tjrJkkcHRF6R+7wPaIJyTLZQgVBN63Q0ORPLENmAneLpIEkVzgZVCHc1q
         qP134upef1/dOr0KiaCmgyRw32zBGSUjIj+RW8EyhD6AmG1ALBAp5ZMZVVcqPW4k7oXl
         WyEiFqr8hYuwz3mxKQvX1R3J2/td4P/VwOnOpoJdILskAx2wLAZD4Gjqym6vT26ewMYN
         Bh6n0Hqs1KawTr8ny/W90JyNL9fLYsJP2bonXx6RViN23LL8IzNyWDH1WseVubeuw2eB
         mDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kg2p+d9BTb0sDApPTHD/FCt+oKLyPxzeDhZVVD2/bvE=;
        b=WnyneRyB+AaJ/KQowsJhqgWj6iseYwW6rLi+ATgImeqXIqoAE5o97L0Pke0OXDxG5H
         R0TbgRCIho2dg8cR3LWv1MAYEn25afgwAnj+ho8qy6Vtkbwi+2H/xcAOCrFV6DSdQxOV
         wfoo8sSNnAVcWLijLCRAhPOlJv1fvjf75kzP+TtmooFgLpmJyrepIXp4u4EMbGxqdqC6
         /2IYS3nBMgLsUu0eklWWHSTRV8pi9ozySn600jG8uEkvRFidRrOS9htt5kBDjNAOwl9N
         d+LmOJiJHWryviEShD589wE1x9noMu30pQSh+wbLkn9cnVXFpj4m6EVISWDkpntPPjku
         DDvA==
X-Gm-Message-State: ANoB5plYzGp1EPXvsazU1hAkCy9Rzu0TQrcBi+FTmlgJbr9I8UaarNN0
        gsqDVTgwfT7DwGeI6mMG9YP/5XWnZR2wM2uNqjJVC9wf8jVxuPG/
X-Google-Smtp-Source: AA0mqf4+NeFrs5IgilPztvEth+wuzXVCXKXZ6fBBFSO5bfaH4DFrSE079OowKhwnTee84fmxGXSVssJQy4r8nWe0Mms=
X-Received: by 2002:a05:620a:4895:b0:6ce:2d77:92d0 with SMTP id
 ea21-20020a05620a489500b006ce2d7792d0mr16761581qkb.713.1668543556542; Tue, 15
 Nov 2022 12:19:16 -0800 (PST)
MIME-Version: 1.0
References: <1668517207-11822-1-git-send-email-yangtiezhu@loongson.cn> <Y3PdlPVxobFMVYoX@google.com>
In-Reply-To: <Y3PdlPVxobFMVYoX@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 15 Nov 2022 20:19:05 +0000
Message-ID: <CACdoK4KEzd8w3pWjuGet-W3ZzAf+8uBpzngk_aX7_aBDYm4T5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Check argc first before "file" in do_batch()
To:     sdf@google.com
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 at 18:42, <sdf@google.com> wrote:
>
> On 11/15, Tiezhu Yang wrote:
> > If the parameters for batch are more than 2, check argc first can
> > return immediately, no need to use is_prefix() to check "file" with
> > a little overhead and then check argc, it is better to check "file"
> > only when the parameters for batch are 2.
>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Acked-by: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks
