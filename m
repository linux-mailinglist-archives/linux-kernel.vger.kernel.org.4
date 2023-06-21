Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3569B738EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjFUSdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:33:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA841A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:33:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-66615629689so5253014b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687372400; x=1689964400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMCcSs/LNtvhK0BXk5UBwN4S171el/6E9/JAkRmkQ14=;
        b=HdwxOHbSoqUwOb6scyLytVCNBpr1vwNnQT2D/hW5FKgqNmiGZBEUds0gb7Mwid3xVY
         1EVF6TIlDX37MMcT1uuuEKRQMF7BlHM+djkdvHuJnJlP97NE5a1yHBHKxcdlP1JLWij5
         95LAF3n+A/3JrQmWPhQu/6H9+TM2x6GB51clo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687372400; x=1689964400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMCcSs/LNtvhK0BXk5UBwN4S171el/6E9/JAkRmkQ14=;
        b=UZZ/bzm7yuvhEplgdAqggv0lCIAe1FOdBd65F73xn0fls0UJvLkLdF1s6RceHho6sv
         ur1+zQrBJCF9RWigYrU44OILVEOM4j6FUQzsYB4hY6mEowp875dziaU1VkRpXSokkLk2
         UwuPGOzsxdrF8b449OGrXR0B6AUFsH1d2NT++XyMqDLbHgUCfkYOB2Vg8m5aUtz4LVax
         8eWCkspdlp5KFt4IYS+kFmj7QwbIaEobqp637FgdH3sPFk6+xp/vvwdflt0KwpIeqTKY
         W9Obce5UQH7PJAvzVwonqpVdfxLR57aWa0Q3m6LAYOFV57Xkk8RTk1pDMgq9rIksuGGA
         hgbA==
X-Gm-Message-State: AC+VfDwKZHUNAy/iqxdxuVBiWN+/3OHsRzm082B6gTXlLNAFJ5zHe3Rw
        YQYztj8SeCwvxdw2w1mIVZuWsA==
X-Google-Smtp-Source: ACHHUZ61VuRGcNyIdsoeKxEP9I9ve0zzxwyEYeiTSUjX+SCoV/75jyc7NFgMI0GbksiCPhqa3pmwdg==
X-Received: by 2002:a05:6a20:244a:b0:10e:440:6d36 with SMTP id t10-20020a056a20244a00b0010e04406d36mr19792675pzc.1.1687372400488;
        Wed, 21 Jun 2023 11:33:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e20-20020a62ee14000000b00665a76a8cfasm3193283pfi.194.2023.06.21.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:33:19 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:33:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi: bfa: fix function pointer type mismatch for
 state machines
Message-ID: <202306211131.18885FF471@keescook>
References: <20230616092233.3229414-1-arnd@kernel.org>
 <20230616092233.3229414-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616092233.3229414-2-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:22:10AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The bfa driver is full of state machines and a generic abstraction layer
> for them. This relies on casting function pointers, but that is no longer
> allowed when CONFIG_CFI_CLANG is enabled and causes a huge number of
> warnings like:
> 
> drivers/scsi/bfa/bfad.c:169:3: error: cast from 'void (*)(struct bfad_s *, enum bfad_sm_event)' to 'bfa_sm_t' (aka 'void (*)(void *, int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>                 bfa_sm_set_state(bfad, bfad_sm_created);
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Rework the mechanism to no longer require the function pointer casts,
> by having separate types for each individual state machine. This in
> turn requires moving the enum definitions for each state machine
> into the header files in order to define the typedef.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for all this! It's a lot of mechanical changes, but looks correct
to me. One nit below...

Reviewed-by: Kees Cook <keescook@chromium.org>

> [...]
>  static void
> -bfad_sm_uninit(struct bfad_s *bfad, enum bfad_sm_event event);
> +bfad_sm_uninit(struct bfad_s *bfad, enum bfad_sm_event);
>  static void
> -bfad_sm_created(struct bfad_s *bfad, enum bfad_sm_event event);
> +bfad_sm_created(struct bfad_s *bfad, enum bfad_sm_event);
>  static void
> -bfad_sm_initializing(struct bfad_s *bfad, enum bfad_sm_event event);
> +bfad_sm_initializing(struct bfad_s *bfad, enum bfad_sm_event);
>  static void
> -bfad_sm_operational(struct bfad_s *bfad, enum bfad_sm_event event);
> +bfad_sm_operational(struct bfad_s *bfad, enum bfad_sm_event);
>  static void
> -bfad_sm_stopping(struct bfad_s *bfad, enum bfad_sm_event event);
> +bfad_sm_stopping(struct bfad_s *bfad, enum bfad_sm_event);
>  static void
> -bfad_sm_failed(struct bfad_s *bfad, enum bfad_sm_event event);
> +bfad_sm_failed(struct bfad_s *bfad, enum bfad_sm_event);
>  static void
> -bfad_sm_fcs_exit(struct bfad_s *bfad, enum bfad_sm_event event);
> +bfad_sm_fcs_exit(struct bfad_s *bfad, enum bfad_sm_event);

This bit doesn't seem needed? i.e. why remove the prototype's argument
names?

-- 
Kees Cook
