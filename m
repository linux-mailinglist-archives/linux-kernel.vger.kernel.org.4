Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60773EE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjFZWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjFZWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:05:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B73C32
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:01:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98e39784a85so356260966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687816876; x=1690408876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4hqcaZFG4SkQyDioD67UaRG3sDwtH8eXvV9QXoJ/JhQ=;
        b=Zp5DJ78C/Ed59HL5pMiVliC1IWjahxraA7plMufmte4mjwWjik6jxNOvsfKSaIcQYo
         r0Lzh+8NhQo26DVuJw51/QuQaAiS7vqpAs8M86G4eR0+LR4XmthrrDr5XWXbR6IMHbjs
         edu4mc7U8jh9A+1vK3/pROhIXvabBO1F+7jn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687816876; x=1690408876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hqcaZFG4SkQyDioD67UaRG3sDwtH8eXvV9QXoJ/JhQ=;
        b=LBxQFMD5T5Hi5sLBkysKE2ZD7VLcTt2DnlgWLT8PgKJjgHzBrAhejAVmxWimQlEJmM
         oDQA2Y76BzCxnW3EV08+Kic6ZKvaLXqkp263YelSw9DglvOqXPGc2A08L6TRwQ2bspaD
         HlwYYw3OazKtKJfLfQ3xEH49qdttTecdEjznDbnZvyKXv53tmiPHkW8KuzBY8rWgPsZu
         qhJXqgsuNyrhNdFx2iw9xFxcDHgjeXcaV+tszJahljaeRZY0RBscb3/+Rg5NYVlfMynA
         6/CzJyFLkDNCE2LDrbCbJvOn9+MvsyFNm69gvsEtUNCqlU+x2yHTbgi+J9VQ7uJvFyQP
         nJtA==
X-Gm-Message-State: AC+VfDx4FB2hoRR5YJomJGFjtmDi5u07j4L50/1rx2prmJ/jPfqEKlMB
        Dhmwra0mdrAldQW5w87ki2rjcLkPwicbrRanFuAZX6Pw
X-Google-Smtp-Source: ACHHUZ6j7gUDepxR4ObYfVVEZExC867W7e4btWQYBMtB3GvY+/emthB5blgJKpILG/QkNkFBYeKnOg==
X-Received: by 2002:a17:907:94ce:b0:988:f2ad:73f3 with SMTP id dn14-20020a17090794ce00b00988f2ad73f3mr18852797ejc.32.1687816876157;
        Mon, 26 Jun 2023 15:01:16 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id lw24-20020a170906bcd800b0099027b40d88sm1996943ejb.88.2023.06.26.15.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 15:01:15 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so5308999a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:01:15 -0700 (PDT)
X-Received: by 2002:aa7:d9d7:0:b0:51d:914a:9f3d with SMTP id
 v23-20020aa7d9d7000000b0051d914a9f3dmr5578524eds.10.1687816875064; Mon, 26
 Jun 2023 15:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <168778150975.3634408.5562070824299155127.tglx@vps.praguecc.cz> <168778151644.3634408.18311962903658740097.tglx@vps.praguecc.cz>
In-Reply-To: <168778151644.3634408.18311962903658740097.tglx@vps.praguecc.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Jun 2023 15:00:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoVt9izQi2iA3F8PZbnmT+r4CcqaHp+FhEozSj2D=UFg@mail.gmail.com>
Message-ID: <CAHk-=wgoVt9izQi2iA3F8PZbnmT+r4CcqaHp+FhEozSj2D=UFg@mail.gmail.com>
Subject: Re: [GIT pull] x86/core for v6.5-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 05:14, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This conflicts with smp/core and x86/boot. The recommended ordering of
> merging these three branches is smp/core, x86/boot, x86/core.
>
> The x86/boot and final x86/core merge have both subtle conflicts. I've
> pushed out the following tags:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git merge_smp_core_x86_boot_for_6_5
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git merge_smp_core_x86_boot_x86_core_for_6_5
>
> for your conveniance to check against.

Bah. I read this after I had already done the merges in a different
order, and my result is a bit different from your merges.

All my differences seem to be benign, though. The main one seems to be
that I kept a preempt_disable/preempt_enable pair in
wakeup_secondary_cpu_via_init(), the others seem to be just comments
and declaration ordering changes.

Still, you might want to double-check the end result.

                   Linus
