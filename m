Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E30636A74
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiKWUEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiKWUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:03:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75948D100
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:02:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n3so14501500wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1a8Z9yBYNURfKDuwWl2rtEpYmJYuipEp84stCPFPvg=;
        b=AsuGzkhGh4Z37L39phSE5G+ynaY50VlBGlLk55X0t4DYsygLu+/YGdW7Enz2Ic2DRz
         ij/WB5K1P8lug4GKBCPntRdatWqXkPLJ3RZiZ4BtX3FmyQDlEk84paHUHZ2m/Xscmcux
         AcnkV75Tq1ChMshRmKK+JGf+/PvM5BVxOOQvJwTfQvQv0qDBKeRVD9kqY7eqIxk5Kvr+
         XlRYUNTj991iOpatvmEjTwJTeZl6eLLsM+6CHRN0u/E5b7cfngpfGxTAWOjwWz+4iP1V
         WIjnGZcaxInFqQAyTfR+/GDxUzPDe0HBgv5TOo8oWsslU+WmdYYKdIxdqZv4nxWgXOb8
         SAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1a8Z9yBYNURfKDuwWl2rtEpYmJYuipEp84stCPFPvg=;
        b=hfX9X0coTqGb5kj5Kxe31jb2n29d2SOUlLyDMNqAN6BRZfUfMfCBhntzxodpIYz1E9
         z6jXRYHeCCEZNxsgQdkN8pCTriCGFOQQMC6x2SevIE1Xu2wYzsxLkNvKz0+jp2oUWkC2
         VaruPddTfpccuj9zIrN9rI9daaDRQtU3bOKNSercZLqQTpWV8F1KM7DtXZRCIS3mUiTS
         VHcy+LSYUnIbBsqAXAHC90YniDkm3WmIRECmZn9hC7zQJWTcPETvh16qqaaqs2Uo/15Y
         EKK4RM769b4dXLZmwhvEFFp65h9z/xnIu38CF25N0WQaBAB65lyBd4UoNwMduJDMOSLD
         RA3g==
X-Gm-Message-State: ANoB5pmufo2PgwWkE3ag0wdxGGBKp+peDt5Tg8opQGCzGXO+K0IXe37M
        vab37sMCffRxriUIyCmq4nmgQ1yLxNFadzhoW6wAOw==
X-Google-Smtp-Source: AA0mqf6XQDNkc/+mKfL9hB9/ZNn1061PzCIku9Wh1bJCuZu4v0HPgiPWAIZxZLZt29MamMeUnQJdJ4oJpwGRyDmZ+gU=
X-Received: by 2002:a5d:5d0f:0:b0:236:6f6f:8dd7 with SMTP id
 ch15-20020a5d5d0f000000b002366f6f8dd7mr7850823wrb.4.1669233755724; Wed, 23
 Nov 2022 12:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20221121234026.3037083-1-vipinsh@google.com> <20221121234026.3037083-2-vipinsh@google.com>
 <87edtvou0n.fsf@ovpn-194-185.brq.redhat.com> <Y30p8q0YB0+p1e+4@google.com>
In-Reply-To: <Y30p8q0YB0+p1e+4@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 23 Nov 2022 12:01:59 -0800
Message-ID: <CAHVum0f_+-qC2VRyj7njWmPec42h1TvUxHU=SmnpikuKafNnPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: x86: hyper-v: Use common code for hypercall
 userspace exit
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        dmatlack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Nov 22, 2022 at 11:58 AM Sean Christopherson <seanjc@google.com> wr=
ote:
>
> On Tue, Nov 22, 2022, Vitaly Kuznetsov wrote:
> > Vipin Sharma <vipinsh@google.com> writes:
> >
> > > Remove duplicate code to exit to userspace for hyper-v hypercalls and
> > > use a common place to exit.
> > >
> >
> > "No functional change intended." as it was suggested by Sean :-)
>
> Heh, I need to find a way to collect royalties.


Suffixed with a =C2=AE
