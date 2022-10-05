Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C245F5D2E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJEXSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJEXSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:18:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A314385A90
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:18:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d10so453046pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Usj5iN5cemtFO03tRyeDJUMi4SFYYsF6bTitkecHHS8=;
        b=j3zs3KAEaPWgtX6tZgalJEuiwLIyUl87wkB3ggQ3onOc9jQvcWUCy4UsyHhAViS9Po
         RoUcQ27y39xLtVVRejuRGOGet6FgwPRsqMmW1ujK6WYDP9WuAnea1Kly4gTI8z493GKT
         spDHRGsm8FoJ9VFL5Aoaq7mpUvj1mCiB7WebTELx6wh80KBUoCbKeQkLsIRxZ8+xhlou
         vgbGEURTtLkw8uf1YQUbrfZlv5x6H4k40UrAU4QTMhZsMTJOJWyIExsOWqUqEzhRdknx
         qd6DCa/ZZMNo3EwrCq6aMo6gZwIDAOGcGuwVrI56dvy2oBQgragviesJgArek5ldbPBV
         n3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usj5iN5cemtFO03tRyeDJUMi4SFYYsF6bTitkecHHS8=;
        b=EBdV5rf1WhVX7zq3E0sqWzCr0DOjNNw5T+NApkSkAF5XhambdBv7pOHlg1pnQWAud0
         Jyxi6JXF46LxypjVdOIbvCSjYAG6vVYvlPQL2clT1qKtv+/gOaIv5xl1ViyLNMs1RqXc
         lejireVR/VKbgbbfRljqo0hgtPBxEzzDflCsgigZf4Ap77FXngEJ/okRI+LxeZPbrALS
         OQsMjla7AyAW9/Jis6lGWmbeYnYkpK+ElrgJuLNtY7QRmrsuHKLrZ/YlXK4yyGPlE1be
         GslX4k3wOjhlHItPo1oW4P2+APNsiypiI0G8CCjEQIhaFYHxEoGJBqWuH4CG84E5iy58
         +3pw==
X-Gm-Message-State: ACrzQf01+K83nSEU3zJdH0FaHu16iHfjhHFwvNdVx18t19JrBx3GF2l+
        lrqoPZVCs9XcRNcEJvuHcu2S7Q==
X-Google-Smtp-Source: AMsMyM7A7KvY6St4CE7qxKnv2asB2yszh7h9VQYoEoOkepexJamGw32aJRuayc+2elmBxqeTW1DCcg==
X-Received: by 2002:a63:5244:0:b0:434:a3b1:bbe8 with SMTP id s4-20020a635244000000b00434a3b1bbe8mr1880685pgl.57.1665011909956;
        Wed, 05 Oct 2022 16:18:29 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q19-20020a17090a2e1300b001fb1de10a4dsm262295pjd.33.2022.10.05.16.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 16:18:29 -0700 (PDT)
Date:   Wed, 5 Oct 2022 23:18:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: fix some comment typos
Message-ID: <Yz4QwcnhNTRAl68A@google.com>
References: <20220913091725.35953-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913091725.35953-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022, Miaohe Lin wrote:
> Fix some typos in comments.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
