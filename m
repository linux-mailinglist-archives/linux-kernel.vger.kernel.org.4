Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4304B7278DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjFHHb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjFHHbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:31:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506571FFA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:31:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so30525e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686209480; x=1688801480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87g/Pi+Xu07Ub0dymM1C1BRfTRU/yKYa/DAr34FHvz8=;
        b=oPA+9sJJdMdXsbev9YSi3SiSm2ZIqYn2qd3oymrV4pZ86OY5FZi24DS9+2KcyGRAdK
         BdYOSFxaSEW0HMMPZPt8EoN47jKiTb1uVWbn5FVXtvgV7HyNEXxcpSUZe/UROcCFS38u
         K/WPtSeUIfvmjJxH8GNjXN4sRDUg7tP69WWOvtCUNx0QW5WJPG2SWt9+wULwcYGHhjor
         b2tWR9tMwBsX4hiD0ZoxdtOZlBRouZs88VYpC5yHSQhezUeT05D4rr9JN+awq7BFw/H+
         a0wX+RotiLgzVz5R2NIt1Z8lalSzA+WjBwmHv81BgQdXM3VaxDagWD3ay/vgHq5zTKqq
         auaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686209480; x=1688801480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87g/Pi+Xu07Ub0dymM1C1BRfTRU/yKYa/DAr34FHvz8=;
        b=KEyK5UkC6eZLo5SzJ7o5Lr89829l7VcX9NLkoG1I06/FnkAmHJ0Z9Gn3/43TwLREB6
         gEN267d3tGTxTL9yYp/6Qwc8WQWOOfSwlONRcSlzAMtjK6W7AMIEloGmdwbNg6PDrq9e
         U8FS3K75cY3vUSAoFuw0Pr3O7qqvamoUWmoCraSNlzxxNhSuIW0sTtQERn0kyGphTJcJ
         Mzgme7bSgOqKuhK1bsASL9tWC9xp9qdLx2GTXCvvql5oRqlABwUXed2b3v7/VOAc1Ohm
         M6pRxo6okw8tss1v2xcstNguTa/PpcSF5BSoEoCwz+wQyTV7fPnnkeFvoW4jluqRat31
         Lv6Q==
X-Gm-Message-State: AC+VfDzHxxvhRqXhgX4gKUlr4rh1FoCLIMoIgtG9f3fd2MN5qGoX7ve/
        Z3+hR/RteO/rFjgXeU5dJLrVD+wwwLmijt43s7NgXw==
X-Google-Smtp-Source: ACHHUZ7ELdlD9jnH1dsTRoVai+B5bMm4dRKQ9K4DsjnWHafLoDk3UYW1VGcrMRQho2jeh6TMW3ih3O3Rh1Bf+L12Cp4=
X-Received: by 2002:a05:600c:3b2a:b0:3f7:ba55:d038 with SMTP id
 m42-20020a05600c3b2a00b003f7ba55d038mr116077wms.6.1686209479606; Thu, 08 Jun
 2023 00:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230608072903.3404438-1-lee@kernel.org>
In-Reply-To: <20230608072903.3404438-1-lee@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 8 Jun 2023 09:31:07 +0200
Message-ID: <CANn89iKtkzTKhmeK15BO4uZOBQJhQWgQkaUgT+cxo+BwxE6Ofw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
To:     Lee Jones <lee@kernel.org>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 9:29=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> In the event of a failure in tcf_change_indev(), u32_set_parms() will
> immediately return without decrementing the recently incremented
> reference counter.  If this happens enough times, the counter will
> rollover and the reference freed, leading to a double free which can be
> used to do 'bad things'.
>
> In order to prevent this, move the point of possible failure above the
> point where the reference counter is incremented.  Also save any
> meaningful return values to be applied to the return data at the
> appropriate point in time.
>
> This issue was caught with KASAN.
>
> Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_chang=
e for newly allocated struct")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Thanks Lee !

Reviewed-by: Eric Dumazet <edumazet@google.com>
