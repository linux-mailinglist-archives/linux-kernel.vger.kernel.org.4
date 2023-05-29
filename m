Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159BB714766
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjE2JrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjE2JrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:47:24 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B8AE4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:46:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565a77af71fso25472757b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685353611; x=1687945611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fg7l0pNR7FThHmqLtZ6YBH5C7fRc1RqSQ3ugJhkFr8=;
        b=Wmg5YVD6I6fSYNbX6hPGzBsZ7OAkM1OFFXgtRww9MmP8jg7a3CG5Kx/l9yKf23qzEP
         4b3fJEJsWgXVwy7rjJdaDbl+EhIlsa74zp7PpFSOKUurVZEcxGujVNZthmrR2Q2K5/Wt
         kCnkg5nauhguAsKQa1IGlM08aCMOIFFXqTGj/aiQ73nOUhspQlNzGS7Rf1Vd1sOPAJc/
         WTDiosA6qHqwCbc7E+piNOJH+ulLcbF+TiRcROTyeX7FYyJVNO7K/IH038B34lDqOcd+
         0OiMzOrPcWRZsvZ4Wg3UQsKit78LqJd0yh5LQCG5Sdeh4b7CWcGjG5B0bwIjQXg6pdKA
         DZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685353611; x=1687945611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fg7l0pNR7FThHmqLtZ6YBH5C7fRc1RqSQ3ugJhkFr8=;
        b=Y1KQB3hantDVjEYt/3ZpbBcHC3aF9hMTS1Faopi+OqkqILg59OFYhNqHNSPyPz8xRI
         qbs5BZ7xYrrOlg9RWlwoAzTacMN8f1R6qYZZGdedjD40dIvIRrY2qfVycEwVp/PPdjqi
         7A/DYMXHp0hmgfoiKH1cAp2lXcTJ8EL9NOtK9d3FJGCRDJ13Hxo2SpO/hDQn8Z5/NL7d
         BtKO34tUubs3Tj8cUv1aAMkLIlIAJ0e+QQC4d7qgy0BHWDnirSnULaFWy8jJgbAVm9Uc
         Ysc9/yVrGCtQIuFpYGMbMXqmSoVzr7/mzMiO3Uk5P+9Ul/XV8oShWypTzEORaWoTdVg8
         BjqA==
X-Gm-Message-State: AC+VfDy9DWUtrkLb9m4OR9D+MPbeE42qB3m/l+hDXdBaFScGfCUGJozP
        BH0ttOJY8jiIHBA/o7N6wSRfJesZUFz02MTVMD6kyw==
X-Google-Smtp-Source: ACHHUZ4zW+/YL+uc9j89aajPoHscgmbgpaNpYdwnhQJLuHjSpupu2KwfTqiLBD40fhPYEcOkPA5IB039NtFMNY3c368=
X-Received: by 2002:a81:88c2:0:b0:565:c4af:1a90 with SMTP id
 y185-20020a8188c2000000b00565c4af1a90mr8775168ywf.40.1685353611447; Mon, 29
 May 2023 02:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <202305181658063480018@zte.com.cn>
In-Reply-To: <202305181658063480018@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 May 2023 11:46:40 +0200
Message-ID: <CACRpkdayo8ZOm8BJxPSt6g0n-auFsTV7m6RNP6XoqHTM2qRMPw@mail.gmail.com>
Subject: Re:  [PATCH linux-next] ARM: unwind: use ex_frame with CONFIG_UNWINDER_FRAME_POINTER
To:     guo.ziliang@zte.com.cn
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
        lihuafei1@huawei.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:58=E2=80=AFAM <guo.ziliang@zte.com.cn> wrote:

> From: guo ziliang <guo.ziliang@zte.com.cn>
>
> We define ex_frame with CONFIG_UNWINDER_FRAME_POINTER in struct stackfram=
e,
> struct stackframe
> {
>         ......
> #ifdef CONFIG_UNWINDER_FRAME_POINTER
>     bool ex_frame;
> #endif
> };
> but we just use ex_frame without CONFIG_UNWINDER_FRAME_POINTER in
> return_address() and unwind_frame().
> Maybe we should fix it.
>
> Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>

Looks reasonable:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Is it possible to create a .config which expose this problem?
Then mention in the commit message "if you select A and B
then compilation fails..."

Yours,
Linus Walleij
