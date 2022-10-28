Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675C611974
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJ1Rlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJ1RlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:41:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2651E1C811B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 130so5359079pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8NloiYe1lI947z/kuU9N/qBx5gnL4a/AJy6ThcXGpmI=;
        b=TwMh5dqAQl3qF29ST1Xhenkz7aJtNH9N49FOBDqCoKrACJyXirXdBSkdopfUKN+D9V
         ufShJjcRushiA1/g/O+1M1YbBdAaoDtopjrMDjSGjOTeLA2Rcmv534pZfl2UUvqqKQOZ
         2imghwrMt74m5+qMo5n/psypmg52JZFu4GOZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NloiYe1lI947z/kuU9N/qBx5gnL4a/AJy6ThcXGpmI=;
        b=463qFqiuBLpzRUE+3q1fQZ8Q07rMh/6GLJmxU/WfCVXP4XbIwJA1P975IRVh4F9/fq
         KnTgGB42YNLFh9+a6T6XZqnYnAUWu8SnqudB7wU5YplUdh3V7wYPxbGKXU3ulsN/HfZW
         K6t/HcyGwjSUZS2wNHDWf/rjYyg3ZBz6mlqzo1THLxnqRu1g5NbpTXmeG2ksy51bAdmc
         ZShFM/XxUqfZJm8mi2OkjdvPPWPR4i7vQH99Zg4Q8aBl6TN2w5OX3DLoGoijYGufsP4A
         MOYHhsncZFX0y5bCUb45+CTAyOd1bYzvkfl9tqxECoxqMG7C395jsl5+BigUKT2h15mp
         HBFA==
X-Gm-Message-State: ACrzQf1+Xe5Wk1vDcCa4cK4n9R5TLCLE+Wdutk+CdT4CVKXpXSgWcHkO
        EjGmC8m+qj0avnrEHXoh67A7EQ==
X-Google-Smtp-Source: AMsMyM521Xl9kBvi2dw7EgeaAY4ocBvMoN9pObXwujIAjjuUsP6pjLBWLofjcBBLb3+TxoYjViUuXA==
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id a145-20020a621a97000000b00562558712d6mr255983pfa.37.1666978877669;
        Fri, 28 Oct 2022 10:41:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b00186b55e3cd6sm3407355plh.133.2022.10.28.10.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:41:17 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:41:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/4] x86/cfi: Boot time selection of CFI scheme
Message-ID: <202210281041.47141393C@keescook>
References: <20221027092812.185993858@infradead.org>
 <20221027092842.699804264@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027092842.699804264@infradead.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:28:15AM +0200, Peter Zijlstra wrote:
> Add the "cfi=" boot parameter to allow people to select a CFI scheme
> at boot time. Mostly useful for development / debugging.
> 
> Requested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
