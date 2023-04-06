Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5C6D8B9A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDFATD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDFATA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:19:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6411659E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:18:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c060d7cdfso17095667b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680740339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWlTF2KX/SLscX0Kn9NLj6T2D2vSbjVY278n3hbFYjY=;
        b=Su2D1+qUf7Ph7eETWK8SAUW7jHWbOHfiOGnPWly+EXs6AMreGK9jAxeB1sMb/OMOPY
         kb81oTWVp7qPJ2XaqWMTwg/It/LOWezEc3rfAp0sKBaL+3W33vnN2uAad8mK04NnX8v1
         wgAS00fxMs0Eaz+vby2VZhRvD404NTgE/9a45xFXzFfTi/U2c5pggtcuLB/TcYR1JJDC
         xNKoRnTU0wNG29j38mxAbaJJb0Ufgh/SdVrwZsC3vIzS1COrjLhtGDoK464jKbYW9zC+
         TYvQ2qipOJbnx1veLjZWyA5PJ0blbodGz5ZfUzySMc7nrWDz1f4UI9YX21mBsZcMeCPm
         Hr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680740339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWlTF2KX/SLscX0Kn9NLj6T2D2vSbjVY278n3hbFYjY=;
        b=gdEHaetBFOBeuCthizW8Afp3inS9qQCoymvXkBmIOBuDVY99jAvM1wmK1lZa69FB9h
         lX0vYH2ROhqdvfFnBcEggsnlX3ggmmTf5AM/6Eo9/rXYK/scAJrMR6qRcG5idX5A5VZj
         Yl73HR57Xb5HrBo1GtjqnkYi4ilafIZnGwgDnzrUn7ZjmvffExTOF+iW7Sz9n+05Mbtk
         CNEmr2ADkgUZw2IXWvY0zkKPJgweIx1JkG3NGAqOVyd9Ofsx5hlfAYZV2jGgINUw06K7
         eBd970VTqLOG+PHwcY/M3EzBtYnOOBlUmcTC/VZEhFrVPE9zmrSrXaE9XZtJqpo5DZMr
         rpig==
X-Gm-Message-State: AAQBX9d8V7wgyS09UdLZb7eEenJ4hvcY7PRJMAu4uVKMQhluAAgCSYNn
        ziHJJnI2Y320b8ChRTXUxAJm32s+KaU=
X-Google-Smtp-Source: AKy350bQ3fIfLy6btCgwToPkUIzYS2FCVZiNU6H5A1yDmDhqpOXUJ575ykKtCBiZenPiKTLxHQxC0TT3qII=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:12c7:b0:b26:884:c35e with SMTP id
 j7-20020a05690212c700b00b260884c35emr835123ybu.4.1680740339147; Wed, 05 Apr
 2023 17:18:59 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:18:20 -0700
In-Reply-To: <20230405101350.259000-1-gehao@kylinos.cn>
Mime-Version: 1.0
References: <20230405101350.259000-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <168074029572.706923.3161914837229872289.b4-ty@google.com>
Subject: Re: [RESEND PATCH] kvm/selftests: Close opened file descriptor in stable_tsc_check_supported()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        shuah@kernel.org, dmatlack@google.com, coltonlewis@google.com,
        vipinsh@google.com, Hao Ge <gehao@kylinos.cn>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, gehao618@163.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 18:13:50 +0800, Hao Ge wrote:
> Close the "current_clocksource" file descriptor before
> returning or exiting from stable_tsc_check_supported()
> in vmx_nested_tsc_scaling_test
> 
> 

Applied to kvm-x86 selftests, thanks!

[1/1] kvm/selftests: Close opened file descriptor in stable_tsc_check_supported()
      https://github.com/kvm-x86/linux/commit/771214507387

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
