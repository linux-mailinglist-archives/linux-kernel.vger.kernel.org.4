Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7515F3D14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJDHO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJDHOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:14:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99094DEEE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:14:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m3so17588726eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8lUiUrJnUBbr2TetiSbk2ULFX/npuKxk7xCCUT6/pmk=;
        b=l6HQGIuIAIT7P8HWAiTV0NOzg4gTn+gHR5DnvM1MRmzZkJ3s+pb5y9ZSVlkB2/ZP9T
         odApFGDtbC9fKQu1LU4mCnM8T4ADyMjVVwczHsH93Qkc2lKnobbO6IkHyQXelq47YcId
         TV8T0fnw0WLaOafvkNLktD2VSZcWBs9Fzr3h0VpYtw0rEkw5OAq48SN4kES7EecebeZg
         DDuzgCF9QvI8aQSh/F9Xbq5zQbf+ESJMXjMoBgj93jpJbvCoyDZTExrLxmUh0T4HSq7d
         B2ZiltXhQUK/vtXRuTCQ9qwGwUTFKcXl2/xAPoFjkyx+AW2S6ivvMUAWV9Cr89uilrcG
         SujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8lUiUrJnUBbr2TetiSbk2ULFX/npuKxk7xCCUT6/pmk=;
        b=Ro31C7YmtnrwbfhjNSjQR/dIGP9HlII0o6op07kachVqvlBxXXZeccLiN+zYmQMuVA
         EXdlmN7Yawesb09hJHSSOTIlo8j3Ry0Q2wUy2acn0vu9GRvy9WyqVHKdUCVwbRm9T+tU
         Yj6Rie9DbewfgOw8A4Stjlulx2tmp6+tjN+eJ6l5MiKA2zpNg4LmNjf2TxfzId+/qTA2
         WfLwKtp3MPons+mMmDJ5aAHEVC3Q1uAchBiuibpW9oL8sDamLYgQzUsMasU+xoff8C9L
         aRGpViP3aI0ES6ljzS/uvIjTNJ29TYfU1JsvPezjsE+q8XQYNa2V9KdORFAjIJ4Zsl39
         xm1w==
X-Gm-Message-State: ACrzQf2wvbgR2EJFxS4Z7RD9+DAhHrpouQQSIQZulGHE5w0mVrtNwZSc
        CEVpZhHHmFZ8fMdcaZw9cBnQs8IcVTot3NTRxjfuEg==
X-Google-Smtp-Source: AMsMyM7EBy4VOsG7D/5qITmjKJmrweVpeNFearcT/8xnrgcZPvj6nuOkdydX0Mw78iZ5czGOZncDmx95bg8jVMf7kxo=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr22078723edb.133.1664867689182; Tue, 04
 Oct 2022 00:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-12-jay.xu@rock-chips.com>
In-Reply-To: <20220920103108.23074-12-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 09:14:38 +0200
Message-ID: <CACRpkdZSCamhBD-M8CkZt6B3N9c2Jo_D3kwgOykj8+VJ_otYGQ@mail.gmail.com>
Subject: Re: [PATCH 11/20] gpio/rockchip: add of_node for gpiochip
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     heiko@sntech.de, brgl@bgdev.pl, andriy.shevchenko@linux.intel.com,
        robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> The Rockchip GPIO driver will probe before pinctrl and has no parent dt
> node, lack of the of_node will cause the driver probe failure.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

> +#ifdef CONFIG_OF_GPIO
> +       gc->of_node = of_node_get(bank->dev->of_node);
> +#endif

Any introduction of of_node_get() needs to be balanced with a
corresponding of_node_put().

Yours,
Linus Walleij
