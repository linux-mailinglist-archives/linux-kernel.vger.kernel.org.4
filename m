Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F66DCC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDJVFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDJVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:05:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DFF1BC9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:05:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50489c7aaaeso1411435a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681160743; x=1683752743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0NfKXzvfN1t0yzQDyXp4Tt6S8OW8LWhha6YniOFGII=;
        b=cid0oD9qg3LCdEZ9sxXoOqS0JjtK9dp2CxQRy8Au/61Gxq/fjujN2okp7c3DHccUiT
         0rFEKISM5C9BKoSYD2QsFaqiyv4+fJIQPf3wPqFtSP0ZdvfWDrPzLowWpck4nyawM/L8
         CPk7KLM+DGBTgm9mU/f4o07x+ef+wRM8OBen0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160743; x=1683752743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0NfKXzvfN1t0yzQDyXp4Tt6S8OW8LWhha6YniOFGII=;
        b=4n5uAKF5M/HoFlw2diqQ/LEhwc4QDwtQnmPLplxuLHrAmTuS6xIoVIV2BvXrvpk2cB
         WY2iunnyB2MWLKyaE3QRxF2ZuPR2TFwN6rggFV/1CCh9kUrOQpoc98HXsZKc0uVgw6Ok
         BkYW12ZTvwR2Ig4+5kqSLqBgx1RWXrMMeA9AZM0hb1dVSYgwK09ahbECEkGpkGDfOsxD
         3dVoSIqQM13Qf348RhpqDysHWv79xhxqu9B548tkOQKsm1cJvBOyuxQ2Ow+RNq8OudZ7
         0CtdGZO/bvxF1M/SinBCZrB6ksO5wq5uv1shz+o/lEfuEG+VnD8vHyeWXITeFfxxHHde
         AuZg==
X-Gm-Message-State: AAQBX9cFhpcZmynmB68eTF7mSlcv3CtwP2EOVXNOna6CwdcbxOoz88dG
        8oPd7SmMMzP+WZ02AZFe+m2KrQ59vYkK9wW1/kxyow==
X-Google-Smtp-Source: AKy350bqp6kVoBXLyZPNXJ/p3ukhGTF35BstCI+OZ57dJYQS8eB37wBJcunDbLaCVYCQEQyHaT+gJQ==
X-Received: by 2002:aa7:ce0c:0:b0:501:caaf:1e5 with SMTP id d12-20020aa7ce0c000000b00501caaf01e5mr9777121edv.18.1681160742970;
        Mon, 10 Apr 2023 14:05:42 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 6-20020a508e46000000b005047847d3e5sm4159129edx.36.2023.04.10.14.05.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 14:05:42 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id sh8so15309565ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:05:42 -0700 (PDT)
X-Received: by 2002:a17:906:dac9:b0:933:1967:a984 with SMTP id
 xi9-20020a170906dac900b009331967a984mr3287571ejb.15.1681160741972; Mon, 10
 Apr 2023 14:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230410153917.1313858-1-pbonzini@redhat.com>
In-Reply-To: <20230410153917.1313858-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Apr 2023 14:05:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYktfscvihY0k6M=Rs=Xykx9G7=oT5uCy1A80zpmu1Jg@mail.gmail.com>
Message-ID: <CAHk-=wiYktfscvihY0k6M=Rs=Xykx9G7=oT5uCy1A80zpmu1Jg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 6.3-rc7
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        oliver.upton@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 8:39=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
>
> for you to fetch changes up to 0bf9601f8ef0703523018e975d6c1f3fdfcff4b9:
>
>   Merge tag 'kvmarm-fixes-6.3-3' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/kvmarm/kvmarm into HEAD (2023-04-06 13:34:19 -0400)

Nope, not at all.

You seem to have tagged the wrong commit. Instead of pointing to that
"kvmarm fixes" thing, it points to something entirely different.

Please double-check what happened.

                Linus
