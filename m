Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF38C7149DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjE2NIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2NIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:08:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97795DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:08:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bacfc573647so4800004276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685365700; x=1687957700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcfiTZPtP7etMoAj5rhVwzR0pkqULNXNoi7SCQr5KE0=;
        b=wL2X1XUedYKAd4rGQNtr4By8DJg85sKNz9BG6Cldss3B4Tp724vYkNEZrTf+qnq0hk
         NdcIgHYJVqFt7R1aaBgIayRJHQqi4oKZ5h0zbye6JScY08ldwvEGCjggyFbuf5ZeCBwu
         4CGRTWVsAio16mWesayxZY2ShBn2v+o1MV6VlyLywRjIFG6o3UJGRX1YM8O3WXZfK5lc
         ZzsUwerwdbFuVQbgwkfXlMf8ldoKlAHk6NZRvjpYmSZGkvK+auNMPWd4SvxaWTPE3RTz
         2/ZwDpPtWEHGPl7A1XotbNRDgCl8iFazVLurtvZcCAljGAt6yGNSvWmclMVSZkYuS7xt
         /NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685365700; x=1687957700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcfiTZPtP7etMoAj5rhVwzR0pkqULNXNoi7SCQr5KE0=;
        b=MiJxeaJkOdjQIxpN8owAM9wzj3NgXT5E96VsbfEAr+d7JjVW4cGVPzPkm9pEqb7nH8
         of6YprRW9Rghp7M4GULOOzye9dTXyFVF4xxw4SVT2fczydb7CQ95kVe/Slo2gu8TTL0Z
         b887JxsRc3xdwvrwhpsrPdGJqoyqT9UFLzc4g1CRd8lMfCZsvquE7jFhpBO5HK67hOBz
         ZLd1i3XmfyotbGRlFxsCNs9RaG36OJI4y1e4HubRdjAFtG53LwkilrvEDkqNOoXiVwaY
         HE+EJLPAUq9CvyUdAS9gxyn+NBNHnaLkbWu7b8fU21RJ1gnWTWom65h2izS3bqUkEJkj
         zDuA==
X-Gm-Message-State: AC+VfDwYhvugrJgyrBMP6c/+i9+8w1nLF6PXaVKNA/raD6nsBccng4ae
        aiAsYsD7uLpoQAxW+RrIgiOjjqfuuyjJ+YjxNSWi7sVCDWxHM9Bd
X-Google-Smtp-Source: ACHHUZ6iJl12DOewm365BK23X0xc3YAPULN7ZD2nNthz7A31iNZGRaRnKXpLRXbV9PE7NYBop5T+OPIXZSisxhdUeiQ=
X-Received: by 2002:a0d:eac8:0:b0:565:9ff5:5be9 with SMTP id
 t191-20020a0deac8000000b005659ff55be9mr11317320ywe.0.1685365699613; Mon, 29
 May 2023 06:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230519170716.3459-1-sensor1010@163.com>
In-Reply-To: <20230519170716.3459-1-sensor1010@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 May 2023 15:08:08 +0200
Message-ID: <CACRpkdam7DgxNp19MY7KY+JTV6ENVYhz90xBkDPrfLLNtGhNWQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/pinctrl.c : Remove redundant clearing of IRQ_TYPE_SENSE_MASK
To:     Lizhe <sensor1010@163.com>
Cc:     lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, May 19, 2023 at 7:08=E2=80=AFPM Lizhe <sensor1010@163.com> wrote:

> Before executing microchip_sgpio_irq_set_type(),
> type has already been cleared IRQ_TYPE_SENSE_MASK, see __irq_set_trigger(=
).
>
> Signed-off-by: Lizhe <sensor1010@163.com>

Looks correct to me so patch applied.

Yours,
Linus Walleij
