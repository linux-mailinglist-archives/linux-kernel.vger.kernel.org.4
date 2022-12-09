Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29392648848
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLISPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLISPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:15:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B71A4338
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:15:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so5775478pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGtkhaHKIrr5OpNYU4T9L+BnCs/0pP1qyXvWMaI760s=;
        b=6iTO86Yg/c+D/tyDbB1/u7VSMypyassCrDFcKnXQLmk+pJtNANCaCBZuPVolwpgZPD
         5nhxxtWuGJ2hOBupmq8Zp03kmnFxZTPpg4ncChc9D84/DYQEhZ6L78LuSbF4rg7/5ML+
         PHzcnP+a9LvHU+6LbXtQRNYCgdeZZP4Rsn2bGT97VZ3TYa9w4c5m1P0JrOjGxKzzkyQx
         zYy0WDCkxyrXBY2SRUWDt5YZ5/rAOeHt7q/EmCpBIX4Qc8ulYIKshX6FTvXnyGFniucB
         qdAnrLLt90D1lPP44uJhr8AnfFHJDV6Hf/XTPtyy0NYDd3GXcJn9j1Z0KMbiKPaXD8y9
         y9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGtkhaHKIrr5OpNYU4T9L+BnCs/0pP1qyXvWMaI760s=;
        b=qqLwPlTIJrPaq+L6xqkQLCCiGKpMuSi7J7eHCICJcblBn50GyGouaGxjG+gpbp+BDx
         yt6/tZu3CnkmnmM3lUiqbo+WVHh8V103+DxqKI9TvEXdjbuvy3BMklhrhlNX/J27Fg/c
         b2A62JdnEkukHgyV0bb9608g1BXcNNsPKl9mQBD2f2vxXlSfIhN63unLeLy10akL6Iu+
         4iUKjoToXAgBWxRki+ZukeS9SJ6OThBOjEFEZ9kiOOSWeABmWfJup+wRCjbpzmv0/KgP
         iZ+ueHU8UiSOkPxl8WU8SxBa3ETbXxBs7M07KuiprMiy6kWjd0KSRWWzgAk2lbd38GjP
         GMvw==
X-Gm-Message-State: ANoB5pm30kDshebyk1nsTzrjfbhJ2FAIyvJ0RdBnXuP4chteWMVdR2zO
        HKFmeQCIQBvc/3LmBoZD/yeTTkj0rNbcKxfFm69z
X-Google-Smtp-Source: AA0mqf4XkzUN61EgDM5th316VM+D1Q3XG+pvsxXjlS+qJMhlXby8XRLO4K+xY63ljp1PmYb4MaI6gOJ3nG0Lf1RB7sE=
X-Received: by 2002:a17:90a:2f22:b0:219:8ee5:8dc0 with SMTP id
 s31-20020a17090a2f2200b002198ee58dc0mr31097837pjd.72.1670609714373; Fri, 09
 Dec 2022 10:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com>
In-Reply-To: <20221209160453.3246150-1-jeffxu@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 13:15:03 -0500
Message-ID: <CAHC9VhQ2P0rif2hiVGMGafWXQyZqPQc-yGQDEzjEehH1gzWgSA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> From: Jeff Xu <jeffxu@google.com>
>
> Since Linux introduced the memfd feature, memfd have always had their
> execute bit set, and the memfd_create() syscall doesn't allow setting
> it differently.
>
> However, in a secure by default system, such as ChromeOS, (where all
> executables should come from the rootfs, which is protected by Verified
> boot), this executable nature of memfd opens a door for NoExec bypass
> and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug [1=
]: cros_vm
> process created a memfd to share the content with an external process,
> however the memfd is overwritten and used for executing arbitrary code
> and root escalation. [2] lists more VRP in this kind.

...

> [1] https://crbug.com/1305411

Can you make this accessible so those of us on the public lists can
view this bug?  If not, please remove it from future postings and
adjust your description accordingly.

--=20
paul-moore.com
