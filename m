Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D962ED8B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbiKRGSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiKRGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:18:53 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B78DA65;
        Thu, 17 Nov 2022 22:18:52 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so3711215pjb.0;
        Thu, 17 Nov 2022 22:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BbW4p8RFPV/XstCpf93AAW2PsJ8T/vKT9bRPVeYt5nU=;
        b=HkQmnaVD1re96idehs/006JNQqCoje2HGo2cN1DvZwfvUas1D/XyJzg5l9seGaK8T4
         641tHA6JlB+xC+xHM+FFh7S6+kGYFzDgvdpk9xkIMv9uj/EpyEiItLkYWGJKuvvW7WJc
         DJ5qO6s1LC3QuXT9XSMlzjlKgp4K7OuDljyTGtL9NWmGNNvLv6kc6ZfKZ0VY8z984zkk
         ZAV2//heGdsL8xmcGaqrqhviQN5YU+zTftf2BP0yMX+NCWjMhEr1V5aRYaFkoHPptDnu
         jFlnQyVE30MdqiSGuCiuSp4lJyDj2BqxzldS/QiCzsaF/Jy6k3jYhUu6CgtCNWDWIIib
         1h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BbW4p8RFPV/XstCpf93AAW2PsJ8T/vKT9bRPVeYt5nU=;
        b=NMq/ayxtVwWjPGiX2/XQ8N/U5Xjv7/nep1+OjF+Ur8TThdj2vFqoxxcZf3G7buxAUV
         QRYgd5CLfEicAiIZ/g62XZJWTYnMAWku/S2S7jglLgUoIOI7O4A1sybTdNEaUJF6yIe0
         kR88YsbuuZMRVcDdsXnKq+6ECb3aN4dK+4qtpdLxttbfew+34+PpG5Z5PbiMS31Zx6Xq
         dRfwbGZUmedOSaleW+f4Hs97aJrK8w/xHYIdhvE+rgDDfCOsigE+m3t0co+46DAUi4eB
         M315OX826AjP0C1VE0ZUZf/2zIYvejerUPg0cHf+3X+Cb1SB7GJAF9O9tEwcU5j6mkJC
         mQ4w==
X-Gm-Message-State: ANoB5pkgHqhizr/j+3e8wdn3arsSA9KtJx26KZUt6FMKfXzoS+tRdbr0
        7P8I64jLNdn9g+cu9+Dbim5xS5C26Ik=
X-Google-Smtp-Source: AA0mqf6MrWpbUKG1ojX+2rDODHXh4zaKrgUFvUbBNBABd8ietMP8xOKChbDV341wfDqelkmU9nIomQ==
X-Received: by 2002:a17:90a:fa8d:b0:218:8666:e780 with SMTP id cu13-20020a17090afa8d00b002188666e780mr1672862pjb.3.1668752332105;
        Thu, 17 Nov 2022 22:18:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id g134-20020a62528c000000b005632f6490aasm800762pfb.77.2022.11.17.22.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:18:51 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:18:48 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] Input: max8997 - Convert to modern way to get a
 reference to a PWM
Message-ID: <Y3cjyGKIZN3moTh3@google.com>
References: <20221117073543.3790449-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117073543.3790449-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:35:43AM +0100, Uwe Kleine-König wrote:
> pwm_request() isn't recommended to be used any more because it relies on
> global IDs for the PWM which comes with different difficulties.
> 
> The new way to do things is to find the right PWM using a reference from
> the platform device. (This can be created either using a device-tree
> or a platform lookup table, see e.g. commit 5a4412d4a82f ("ARM: pxa:
> tavorevb: Use PWM lookup table") how to do this.)
> 
> There are no in-tree users, so there are no other code locations that need
> adaption.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied, thank you.

-- 
Dmitry
