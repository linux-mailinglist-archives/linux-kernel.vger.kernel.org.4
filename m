Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AC73ADBB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjFWAVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFWAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:21:00 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48642126
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:20:59 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62ffc10180aso803686d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687479659; x=1690071659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeFZnrzPna49UZE25vJYisvtAwJL7R4Sr/A3b/wqS1c=;
        b=zCghMTvXKiKDWfVC5a6q5td9dywJhHw10iuOzrpr0HrRrHzD216//pgB1/FQNp896s
         EJYjlBcWzdkImusHUoSpaylmWWQM46JM+cFE3pYgPrtCVdDCpcQB3OfEPeY2Zjn4/jU9
         IzD33wgXutStPkjNRukGUGpuECCIjfv6nHITeJ1dCBAd1DsD5S0iA9HKmAmy271nqXGN
         xCx1Y72wRbK0kFmcst/EbYmgSEcT9LrtWCm2g7z0CGqZUfq15N3m/H/fARqNQJPtrnfT
         KXbVmtOEVNLtgRQoiQ/VCgpSeNGtZ1uh+dtKyYxURyHrc1msiPdwWH8stVr88LeKXmyj
         FuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687479659; x=1690071659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeFZnrzPna49UZE25vJYisvtAwJL7R4Sr/A3b/wqS1c=;
        b=DFkGXK+zjrLWIRCXh2iyoHk0lZSjw4rkXQqY9hUwmp4xD5sk9NBsOTlWXvnTr9qkvs
         uNWprt33ox2MgdNHjuKX0OcfB0Kni1a1QiZx6icy5+VEmuE3OawlBfLNFG8Kka6nUIc1
         pB0qSccAJTERF6IfAUf+AZf/bX+i1ygxumFeTTa2JH0rXEDq3ikbqwPfBztMD9rTfLf5
         M2RRzb1O0lYjRgGhUKudy8eBQlxdP9/QVIg2C2MZJ6E9IgSMZBcWkUUvSaYfi+Jzm+Mg
         0Yp0+D7rF1vqgjUcueGp80Fk7PXT2sg6ES3l7ur7K05y129s2kcFkvL3SO75VJXL7v8G
         tX7Q==
X-Gm-Message-State: AC+VfDwejG+VoRoeuzXUac6Rkpd1lKa6LKHVCZYKUs+9IcvDZ89W/z/K
        8b7i4KFYB7pGk060yVnkJiX/ufSdcychg3rF1H3TqewEcoJZQHb88GQ=
X-Google-Smtp-Source: ACHHUZ5J1uc/izzHKJQWqtx12FHwFpiP2xSWijmlkp59F4+9t+Fe9YmwpniQhbPWONk4J6YghjqYVYj6V+7+AjUTG5I=
X-Received: by 2002:a05:6214:b61:b0:630:22f7:37be with SMTP id
 ey1-20020a0562140b6100b0063022f737bemr15323809qvb.37.1687479658869; Thu, 22
 Jun 2023 17:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230622144218.860926475@infradead.org>
In-Reply-To: <20230622144218.860926475@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 22 Jun 2023 17:20:21 -0700
Message-ID: <CABCJKuc5MT9Zzc+ejeNJPgs2M33cZgJzy=OSzgXtU6w1KODOTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] x86/cfi: Fix FineIBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com, brgerst@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 7:50=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Hi!
>
> Alyssa reported a FineIBT issue (patch 6) which led to the discovery of
> a kCFI issue (patch 5) and a bunch of cleanups and enhancements (the
> rest).
>
> Backports can probably suffice with just the last two.
>
> Much thanks to Brian for the better ret_from_fork() cleanup.

This version looks even better, thanks!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
