Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39066C8752
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjCXVJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjCXVI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:08:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46561AC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:08:48 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id n2so2742226qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679692127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZYSl45E7I8TmQG6xCLCASJbgAmNgU5YvdQJCRnlNH0=;
        b=JUBGaUVK/La8wwrN4w4xRSlNBxZ0pPejgCdqJ3y4AHxZGSVNiJCsaLrofWgQKa1Xpq
         yYmCaQTZNXpi4Q8UvfjBD1am4gy74u/YHcx+g4J6sqUusQkzo/9qUwaehc5jNOqpQ9CP
         YOHl20YlEs6PomQ17P6V+im3EvLWVsByOamut2CpLdCzR0CK/UOBTLijcj7hJxddSH4Q
         qADoyF1o1lwpqnwGpmPqhvvZXqPrk6JSOTGbYrFoMcOkwfPToLt1wHXDGGHwG0UxAEFp
         TPmgtpk59KKCxAkrs+vbRR8FcfHVF3l4kSPK6D2LQKxotpWeofjkTYS83Zja99IhosXp
         HWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679692127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZYSl45E7I8TmQG6xCLCASJbgAmNgU5YvdQJCRnlNH0=;
        b=2x+phAuHHHrozhgBDkl+xgEyMoYR4s8MgZeckiUqt1gqlLZqmTGq5vkuAbC8y+9WlS
         N4x5QxZDBWkj+9VQfK5abr+zp+VuC4kglxPxT/7MiaRLhxq3bUzXaUNglUpNVB3iSOuD
         PzTjSzCSL0UG13dWYWKwfW3hIQatWNtHwLj0wTT0ayEVU2aibanbdc7NZq+qjfYCfIOu
         kc+5D0zb8VzDR9hQUjfxp2Kr1nlSaF/3t/I+uZVrXjuYALO4Jdz0H/N4AeF/B+LD2baN
         P513Yw2AIJwSwkMRi9P5O51igGHsIBbwAzeeebmo2VOOgIQ2WOa115gx216yfKSoj1Az
         htag==
X-Gm-Message-State: AO0yUKVKpTHSubumRMb7O+uYo17rSqf9TnOyhDj4VFdp4Df7+SrZsu7s
        BtfcUiqprEK6h06pDrevPNI=
X-Google-Smtp-Source: AK7set9uqPG1t8DehrMVe7a60hqqv9P9r1sxlU4Oat6c/JjueM+ps+JyaS2PsLcB24NZBWD6uxPmHA==
X-Received: by 2002:ac8:574f:0:b0:3c0:3b08:2d80 with SMTP id 15-20020ac8574f000000b003c03b082d80mr6849673qtx.63.1679692127617;
        Fri, 24 Mar 2023 14:08:47 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 123-20020a370381000000b00746a7945d87sm5402942qkd.52.2023.03.24.14.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 14:08:47 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: bcm: Use of_address_to_resource()
Date:   Fri, 24 Mar 2023 14:08:45 -0700
Message-Id: <20230324210845.3545793-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230319163125.224833-1-robh@kernel.org>
References: <20230319163125.224833-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023 11:31:25 -0500, Rob Herring <robh@kernel.org> wrote:
> Replace open coded parsing of "reg" with of_address_to_resource().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian
