Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5920264AAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiLLW4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiLLW4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:56:46 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7428EFAD3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:56:45 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id i20so3821103qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8mEmq1TOCdcLkvwi7h0bWvKKSezBj3+7L378LKaC2k=;
        b=fj64Yg6BlqBdDqLJhtbjCUR02i1p6U7T+U2dMNoJ58M2Q67qQ2Nz8m4qljQ61qo0cC
         os4ZkXoOBNw+RHpa+YyBxksPqs6fjlF6eCxTnwKnscNWkauaXaig1/asay3jnzDLs3G0
         Iwbh5B/E+pjy/3Dneuc6ifuG3YrzSUZkWN2oz/N5YPqJnp+k3AFaSj/hTLe/4dW17bWU
         FPPh3h6M6EEGVDBtb936+MNm7S+VcEMK0ImvkArB5Nfpb/owg1pw2BJ7WCMnxt/u3B8X
         NUg5y9z1kHfDt0P0jLcYfnMZx8RQbgTyLTFOCzHN06xQ3fU8LsuYXvTjNSIKVMlYnyU3
         /pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8mEmq1TOCdcLkvwi7h0bWvKKSezBj3+7L378LKaC2k=;
        b=WLKfGJUUIfNlm4BlDfN9ADd/zaXK0xlisOYiZajLg27dFtAKnyBLHfo2Ye59ELIWyU
         NbjTA/JKWZORJScxYO3ATQ/TXIgf0lybxbaePJe4gRemy1s1snz8VL0tgcvexnyqoTVW
         E9EJaMdwbC9UgXRHw+wnwDaZlNMaIdFqORdPqsKaY0puQQ7OVgu3PbLqvgdZGEC8A5/5
         Y5BG5FhP5+bHXADONWdrKv4fqS/jLRmjgcQGL4l0gmLvogultZsKPva9Y2FKKayub5II
         Ce7sDmL6yu4UkgIdDigkspHNt/pfexJRHw8+eGpJLHMqYypItDTVdOsK/SycKiFkIQUO
         QnFg==
X-Gm-Message-State: ANoB5pnbYk9rsDQtqSO3oyrtUfaA5xcfHwwso+UsZaGoBs3Ve1UbVXum
        faY3B5LjdwmAaqEJKWvOug8=
X-Google-Smtp-Source: AA0mqf71bpN1A1MYzCOgoGuCNOZQP44guWDurvhwgSsi8H67hhQ7tKPKCLET1wfOS8U0zCIcxTtaYQ==
X-Received: by 2002:ac8:6b47:0:b0:39c:da20:616 with SMTP id x7-20020ac86b47000000b0039cda200616mr1166271qts.32.1670885804551;
        Mon, 12 Dec 2022 14:56:44 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006fef157c8aesm6779977qko.36.2022.12.12.14.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:56:43 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Ray Jui <rjui@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: BCM63xx: remove useless goto statement
Date:   Mon, 12 Dec 2022 14:56:41 -0800
Message-Id: <20221212225641.1647957-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206170913.3316205-1-dario.binacchi@amarulasolutions.com>
References: <20221206170913.3316205-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Dec 2022 18:09:13 +0100, Dario Binacchi <dario.binacchi@amarulasolutions.com> wrote:
> Between the 'goto out' statement and the 'out' label there are no other
> statements, so it is useless to check the return value of the
> bcm63xx_pmb_power_on_cpu() function. Then, let's remove the statements
> that are unnecessarily executed.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian
