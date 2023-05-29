Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59F7149D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjE2NEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjE2NDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:03:43 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D86E4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:03:40 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565aa2cc428so27494967b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685365419; x=1687957419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOGDHYdGQK7t/hA+cE8novKJysT3cGX//NvgFDoFqfU=;
        b=qrXNr4vZh8m1YRuJ7HWlrxf1+8gea/IdBqPmXgnd02OLNFXiPFVRyZvydHtXNq5DSe
         BRWX3TASk2pmqU6WDxbWibIl4BadONoPp5+PSfdBwC7nFpdzhEg/eHFv9WYXp/LUbTjN
         6ko1wlRwnt3sL1kc5lRLx6xGS4rQH1RxbjXfuUCddwMRIV6B2n5DxE3TW0oXqn8B1vFT
         2nw1sp991psgiLkKwFJBqlN9bO1l/IUc412T9BTR6lPyfXfXekoJdslivq69dMkIdm+/
         bBuQlGKr1ZojlFRMtS4WwWai6lVUYth8Dmq237CtyOLop7yZj6XtZdmAOptBA0wf97dM
         f1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685365419; x=1687957419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOGDHYdGQK7t/hA+cE8novKJysT3cGX//NvgFDoFqfU=;
        b=gCG75BwTvKdb3CRYgef3ZBONjUWVlvAI0Behy0GzstdORWlK2oUqhOGaPOOQIrk+gS
         du8jwA6bfOhWYWdY+rzWYHnD/PAvqdo+cGGZdHQ5nGIybp9mtqJr6ew1bRg/AMghi0Tg
         dA9bZ1r5zIv+mGmvwzmFOwWdc8e4RPd99WK6ic1AAMulIBpNJiMAnkqoUAOXiFFBZj52
         47/FMRhCteYeMSOpCWwvJUEMGkSrSg8BCUGq3U9u3JO347IllUMmuyOUOi332duwSWm8
         mKWTHwd08Uc2YYVfXi08wypAX+/eUXjTCV0GIbncZNt7sc5SFizltbZpsQALLxWoxPZ5
         5sJg==
X-Gm-Message-State: AC+VfDxB0kbpyLaPtDVKhayct8uWV92mpLexsiJe+cLBtJRuHY9iKp6t
        Z5HoCKwFUkT4cf5yUF/ofnhIqDTYhLkJGn4J0wqB8Q==
X-Google-Smtp-Source: ACHHUZ6TOMJItrg6UaVcj6LVDeDYGKLJHI3huaBgcjqWbzJK5s+TdWz7dhM7U33fdBViX1rfDnsa9gDANX6eKrKzX1g=
X-Received: by 2002:a0d:f106:0:b0:565:ba53:e79a with SMTP id
 a6-20020a0df106000000b00565ba53e79amr11580133ywf.45.1685365419471; Mon, 29
 May 2023 06:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230529025011.2806-1-xingtong_wu@163.com> <20230529025011.2806-2-xingtong_wu@163.com>
 <ZHSZ9cK78qc5QeZD@localhost>
In-Reply-To: <ZHSZ9cK78qc5QeZD@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 May 2023 15:03:28 +0200
Message-ID: <CACRpkdbiRsJqxVZPNLvLPK-MzEhyjSBGffuaTgP7tt40pGGoRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with other
 gpio pins
To:     simon.guinot@sequanux.org
Cc:     xingtong_wu@163.com, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, henning.schild@siemens.com,
        xingtong.wu@siemens.com
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

On Mon, May 29, 2023 at 2:27=E2=80=AFPM <simon.guinot@sequanux.org> wrote:

> It would be nice if a pin number found in the device datasheet could
> still be converted into a Linux GPIO number by adding the base of the
> first bank.

We actively discourage this kind of mapping because of reasons stated
in drivers/gpio/TODO: we want dynamic number allocation to be the
norm.

Yours,
Linus Walleij
