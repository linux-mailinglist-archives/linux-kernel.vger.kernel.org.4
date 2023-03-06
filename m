Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472F6AB9BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCFJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCFJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:26:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BF22A37
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:26:36 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id d6so5105312pgu.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS5KiEBdkP84BGnQ6/5iOZyFdcXCMIgjAhJqxheFdVI=;
        b=d28/xHamOitQpZI06o1t4Ge+zIRvobCMdI0yI0+Vry5PjTWFGNK3IM3UifTwS1Xir6
         x1EVy8lAg9qZrc6XEpcFA6LL/9B3Gc6EVUMfe8v/OTEp4R3mivUuLYo30RNSYcqeuHR8
         dhMsLKYXeV0ACqDnCzn2gtogIrgU/NQRGX/rHN98Hf3k0Y2s+2C2V2Peypkx/RajU4xx
         WOvu3ggXaNBNfqYJ8cmaEMIntVQt4mQ6xs8LiWDS1TO0ZI8tK4kkx236WsQjufgldx0R
         ISRynRVpppTkvO+yinoBie/PBPd/MxEYI0hv07DO9lpL2Wh40a23C3gDjPx7625EjdEI
         8dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS5KiEBdkP84BGnQ6/5iOZyFdcXCMIgjAhJqxheFdVI=;
        b=VVbdQfWeg1NAoUEYx7dQaK5V6tqJ+zaWw5InFN/wi6BZ1dhWxEhPi50thmOpHTiQ3r
         /uPDcqqmA7QT2ygx23HwpsZ6kbE4xKR1NI+9RXXo7GBmEFyhRGxSbCxFUuVstBdG0KLu
         enumJR1sOpygKpk+Xenb4cHKIhuQgtk98h/2LgsyupTzAQ53lX426KCTSWnDI2cGPIvB
         h/dwY+YBKSLbZeSVBJJR/q8q5CzwQSRVL0J5WA1JZ2ZFow37LN2iaUxRzYehwAfs49Ai
         8Mo0Iqy65Uv0xKEbJ01FULwALNwoz4lvM53FuBSDyCUWAJ32DwNuyPqkBSHpy3+kBC09
         bXFQ==
X-Gm-Message-State: AO0yUKVUxIGUKhQSehF52r6DasAwQqBqp6LnFoX8fxwL0K3FQ/Q8uf5p
        hj4b5i6F+BnNWLkwdPILdWC5iDTj0ZENG0K6AvPIIw==
X-Google-Smtp-Source: AK7set+EdoU4t0koGp9e1iwTWyveiUQh4Hb09pO2tFf0b2WbA+GUc5zOS8yZftzyYu4SEpJPLaNU9CpTPPFT+zfr70Q=
X-Received: by 2002:a63:135f:0:b0:503:130c:aca2 with SMTP id
 31-20020a63135f000000b00503130caca2mr4667186pgt.5.1678094796217; Mon, 06 Mar
 2023 01:26:36 -0800 (PST)
MIME-Version: 1.0
References: <20230302123440.1193507-1-lmb@isovalent.com> <2eb84f6e-d316-1a72-18ae-56b9cda97f8b@linux.dev>
In-Reply-To: <2eb84f6e-d316-1a72-18ae-56b9cda97f8b@linux.dev>
From:   Lorenz Bauer <lorenz.bauer@isovalent.com>
Date:   Mon, 6 Mar 2023 09:26:25 +0000
Message-ID: <CAN+4W8hX4V+VTMFjE-1WUVrpHoh1G_e07cTArL5W4AKwVNr0_w@mail.gmail.com>
Subject: Re: [PATCH] btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT,
 UNION, PTR
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Lorenz Bauer <lmb@isovalent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 12:16=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> lgtm. Could it be moved out of the for loop?

Yeah, that is possible I think, since we can only trigger the problem if

    return env_stack_push()

Is executed. I'll send a v2.

> Please add the test case described in the commit message to the prog_test=
s/btf.c.

Good point, I'll send this as a separate commit. Backporting patches
doesn't work well in my experience.

Thanks for your review!
Lorenz
