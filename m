Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C66349BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiKVWCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiKVWC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:02:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54740E4A;
        Tue, 22 Nov 2022 14:02:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f7so22517431edc.6;
        Tue, 22 Nov 2022 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kotx7AX+mwT6i3vVwmp53VI7mNBUsRUlYdaX0ddPLx4=;
        b=csJ/w3Z/BVCLiUCwgR+l0WjPTQ/6GzS+9Q2LmSS5lJUpp+EPqRZbkNHc3L3yHLoLvc
         PJ5Ox5jzhrlEWblaHV95o5322ojh06DK/41lht5fxhT535BzULuYEHTI4IHZpHUrbRpy
         LiPIUvAQ4XuS/Qu46TMwoXnyg3SATPM6bxy+3VF1t1tnehCp9EcIGPNHKam5Nfi/IJW6
         Z03ur3QObKCpMYnlagjKgebK18iOLw7hgD9Gqw+yDQekIwWmPnsNDJArvozTkr8+mxb8
         s2h679vzFZjyxUfa7sAcpFm+EesfZBpszAG/qryFwIpZR/dZaN2spDDeG/m1eyWnzTOv
         RKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kotx7AX+mwT6i3vVwmp53VI7mNBUsRUlYdaX0ddPLx4=;
        b=JKilmViSzVKB5mEcfEskY5E6VLCablSVsd2EpKzyQRqlqxAsioYZ3F2IIK4NMu1qcC
         DlXyQDCeoK98iZK25JFupecgVkMGl3CqoIomQmZkGw7HNDIc6YRSGd5HqoPtONMlcD6z
         riNPV/zJJdhLuAdeBu4RfklVNkSf+lpR0Hzmjra0TA1nz1g0yx/7fEUl7m1J3XfofiO0
         uAMiyf5Vz4Z/+JMhat/zM/yf1ONIBa02wJYktynNefS2ycSAmly1CNK/1LBirZlliYwD
         QOMQP6DU591EfKUlBfpDPm2/UAAGI+Bj3yoX/kRPA2hjiHV60m3IhrsHW4v7JgcmN7hD
         ZirQ==
X-Gm-Message-State: ANoB5pn7+SwPEMXtQETosziONwa/CnkzqsymJaENmMv0WiUa7mijFr+B
        4uY0m6XX9lXKj25oHBhi+VzRxNp+k8DrvggajmtY7BKk8tw=
X-Google-Smtp-Source: AA0mqf5MwCypCpSb5xvKaM+6KzLx3LYUZLVsA79BUKoD+pz0QKKYqS7eFmzlTpVcUJrhCmW/bK7blIP9Bn3ueMmFP04=
X-Received: by 2002:a05:6402:b84:b0:461:a89:8654 with SMTP id
 cf4-20020a0564020b8400b004610a898654mr23079847edb.212.1669154545695; Tue, 22
 Nov 2022 14:02:25 -0800 (PST)
MIME-Version: 1.0
References: <c797dc5e9248498918916a6eeedaa25de2196e8c.1669154149.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c797dc5e9248498918916a6eeedaa25de2196e8c.1669154149.git.christophe.jaillet@wanadoo.fr>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 22 Nov 2022 23:02:14 +0100
Message-ID: <CAFBinCAEwYaEvmGjen_LPO52BcyUFD2EKtzzzfZ1rMuVuihEqA@mail.gmail.com>
Subject: Re: [PATCH] crypto: amlogic - Save a few bytes of memory
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:57 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> There is no real point in allocating dedicated memory for the irqs array.
> MAXFLOW is only 2, so it is easier to allocated the needed space
> directly within the 'meson_dev' structure.
>
> This saves some memory allocation and avoids an indirection when using the
> irqs array.
..and it even fixes a missing devm_kcalloc error check

Personally I prefer this approach over a patch that was sent earlier today: [0]
Corentin, Christophe, what do you think?


Best regards,
Martin


[0] https://lore.kernel.org/linux-crypto/0df30bbf-3b7e-ed20-e316-41192bf3cc2b@linaro.org/T/#m6a45b44206c282f106d379b01d19027823c5d79b
