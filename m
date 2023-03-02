Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6E6A795E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCBCM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBCMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:12:55 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39B134
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:12:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a2so5630858plm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 18:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5qWjjebaS8ZNiy0tfndu0a3n1OZOQNEe9NZS/ZbxG0=;
        b=NJNTqy0nG5IxdB77SFxIMOJQmBGgSQYyHw9FNP7RiCsztiE9fyqOaGsKEAYJiuT6E2
         qsRtDsS52odcPIiPU5q+xV6TfazrVRi94xwNvMXv7iq4snOHs+5tmD8/rhjkPflyJ50z
         dMMv1dHLlpnS/CksCdFLLenz5QMWKlamFhfRpr8UOrAZAR1OoIgD59O0RMzGgTCxwDRs
         ME3uREgG1hnaWYDHY7GHC8qSTPST4Nz1Q6IHuAzOzto55OSb3Op9qUUcBkyBr2F2H2qd
         Msi42QMljOqoilb3lppWfX/q5/zLEBBCLyalw/hww4rlxMZnylwbrRhXQa2qppWFeN7V
         NEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5qWjjebaS8ZNiy0tfndu0a3n1OZOQNEe9NZS/ZbxG0=;
        b=aEJ2U8+j6MxryAnK2oExkoRh3a9s+vgoHVat2M+FEwzWREztfktiBRWxuioZgetRul
         DG/PO2olyuw1nxabhe621acXoMnphKnzYkpHXJKEKfzfSdwh0omNUgiNIW025MUbai7C
         0MDim0ajZ2zjRfVZtLs1V//+nVxxnr7MK/ILdyS/IlgU66spAL0D/ogi8D2gVCMLTo1B
         5MridKldev6s42RKfQoskLtz3nNb/FBl2y8DsGH1Id9Xjr+Yz9TnZrHYmZf6guVmekZP
         8A/FRcbI31JczoS87mjspwoqWwwoj3cMFs7AL+BhsLPktQa88avify01ToXn6WVmru+P
         o5+g==
X-Gm-Message-State: AO0yUKXlLDHxHgyY5ko+RI+f447gmlZLs/70wPQpgmNQQ0OtcgEdcZsn
        OwVnsz2qYMhMGL5r0+VRZsPea+FPYbjoNvAoEO/wOKpOwhU36g==
X-Google-Smtp-Source: AK7set+zBdJ4knGpENVTrni4JAfcn+buNZWHrgevBDOdYKCUR0LmjRqu2xfYFElpdFd3eFv/VUqct79GLUWtQAAFSL4=
X-Received: by 2002:a17:90a:3c8f:b0:22c:89b:8e97 with SMTP id
 g15-20020a17090a3c8f00b0022c089b8e97mr218531pjc.1.1677723174108; Wed, 01 Mar
 2023 18:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20230226165321.24825-1-ammarfaizi2@gnuweeb.org> <20230226165321.24825-2-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230226165321.24825-2-ammarfaizi2@gnuweeb.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 2 Mar 2023 10:12:42 +0800
Message-ID: <CAJhGHyC1uM7yO6GNmRXf-wkVHKeKgqYg0ZZWNtjsb7b-XaNcrg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] workqueue: Simplify a pr_warn() call in wq_select_unbound_cpu()
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:53=E2=80=AFAM Ammar Faizi <ammarfaizi2@gnuweeb.o=
rg> wrote:
>
> Use pr_warn_once() to achieve the same thing. It's simpler.
>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---

For both of the patches

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks
Lai
