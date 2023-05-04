Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5176F71F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEDS1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjEDS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:27:54 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24EB2D5F;
        Thu,  4 May 2023 11:27:43 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9d8b2e1576so1155731276.2;
        Thu, 04 May 2023 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683224863; x=1685816863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8tWT+vX21YxVLjsYjF4+K5hr204YCQjlF07PCznWhQ=;
        b=jaE05pf56jkPfMZXJ7ufHmKM0XODi8PyIOsWMZ93xKYDAx/k1ioYI2XEGr50Sui9zL
         KkruEirAIMDmVmtxKM6kIq5CBoj11Uq6YXcH+XioR860ITa9wzRnsqQypTr0eJMarUaO
         4w7qB4oQe225YomfxAcnqHDn7RZZiDm6sE8U1Xj7xPszjMmXPiq8XcMyxXcGmCAxdt5d
         m8sm7lZOm4F0E1rF2S2kjmn2/YL6KFHvQWdUWF+FVo4kgFNWXy3DyjTmiv7tKXlD3AXK
         KoaKptxNt1rdu+dw5z+UFQWrcXyZvHl2nVX8btarR6tlNGy39JfUQQLkRT3CnvojKGHR
         NxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224863; x=1685816863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8tWT+vX21YxVLjsYjF4+K5hr204YCQjlF07PCznWhQ=;
        b=lu2jNpX3hadv3mjdr2NjFBMM3D1zoQM7OzruM9aFfC+mVN85fRmFxHX0GclQ6wcWWA
         2fCPsN1VWtVYe+GYzLKcXN/I0cAQ/xrnNbBnXkh+y/kCkPY4GmIM+h26z4CC+owrtMOS
         ZCDPxSzgyg9bHQc0dKsCHmr19hrY3r2pwMjNHke5zciZ4SJ/q1UbOLx8loDVUIDl+GNw
         +/YRsMb6MBcz4zAoVRRHmHjav+0cRDsAvWBPVk6nhntBY/9TvTZbj5mp5GzmYN/Kvn4n
         UIb/NPrOGMHj0r99HscOsa+ufGuujLLb59ofPBiZQUGHiHTXLxZsDvc/G4/fh08PsM/B
         kKIg==
X-Gm-Message-State: AC+VfDx+3onVc/n9e8+mU/fvb68JECmtIp6p6WS4u0iNGtH/q7cx4Ib9
        zjVS8Wu8JS6v2KJnxbN06vlrGJM8shksdJ5WVCnqSaRZxfAQVw==
X-Google-Smtp-Source: ACHHUZ4ZEWwpQ+xTlZOQA0iB//dJWSoEdq4wf1HrpMSq7UDmwBStHq/diWL0Is2zFqaLM9MN/uTkQDoFfZJySJ4b3VY=
X-Received: by 2002:a25:b319:0:b0:b96:7d4b:7aeb with SMTP id
 l25-20020a25b319000000b00b967d4b7aebmr938269ybj.34.1683224863248; Thu, 04 May
 2023 11:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230504181636.never.222-kees@kernel.org>
In-Reply-To: <20230504181636.never.222-kees@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 4 May 2023 20:27:32 +0200
Message-ID: <CANiq72nZNU-x_8ONmtzainxDUMedFT+FHww1xu9Ho07gxfAD9w@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add __counted_by macro
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Bill Wendling <morbo@google.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 8:16=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> + * Optional: future support coming in clang 17 and gcc 14

Should we just say:

    Optional: only supported since clang >=3D 17
    Optional: only supported since gcc >=3D 14

even if they are in the future? That way we avoid changing it later.
If somebody asks, you already say it it is in the future the commit
message, so it should be clear enough... :)

And if the compilers end up not supporting it on those versions for
some unexpected reason, well, we will need to fix the comment either
way.

(I can change it on my side if you prefer)

Thanks!

Cheers,
Miguel
