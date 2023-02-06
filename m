Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34968CAE5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjBFX7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBFX7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:59:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2F23DAA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:59:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id iy2so3800167plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 15:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgJ0cVNYo8bXFzsgph6t79HhuWm/IIHs9m1ZnHY/01U=;
        b=sqMPC8I4TKBEWXaUc8VIUZR4/aG3oQB6L14UtUogKoxYRvQKnyqkW/f8OrXKQ7OmFp
         1dTU1b853tEGID37onDY+7WbFkVzCulate0Nk8ClhxNFerF/+OMjrIWH9uL2bPeobh4v
         1yzEv8zUrfb7KZ/g4BVw0vma426u/+pb6HYIVdgNNI8yY5yFE4F0a9U5+bKdLy1TcLTz
         m/2ynIU6ZzgyqaXIDww6kwgtLr0bDlk+/NjbDP/gkT3CRII7fth6WvksaA+ZO4IWcycQ
         NgbfdfvSl48D2gyk2S4IMC0tvuaZoBNGh0kWrrQV3UyJWfGjUa3ym3GxLLSVQvs2WH3h
         fzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgJ0cVNYo8bXFzsgph6t79HhuWm/IIHs9m1ZnHY/01U=;
        b=6gbma6RxRR7aZcZ5xMX+fkHh6b9tRidNHs9qHHOPUk3T2cgzjwffsq/V/tCB/V3O2C
         AebdGznaP/DXmeYzer+YiP9cnoeWqiwcXULNlRX0MTjuhjZXI1itX3YcPkVyL+D0+RB9
         TXxNaUFHpTOvtcjaY7Yv7nYaGvCz2nxCw4dg1xmlKWH94Rr7qcFZt0d9f/IVZ9hRD2zb
         EL6dzZmucQDc+vn/BkA9T4pMCys7xnOaS0aFkiijWqsUhpywZJ9Inz2j9mRINrNwz3pk
         YU9JEFl27nGOuT/k7brMDvOqRvH+3VaFfmx912aShoxY1SpDEnh4tqR4Oil7YWraiuSS
         agxQ==
X-Gm-Message-State: AO0yUKW7plHtJE4cRl/2H6nhLJ2SyP3bxdNpgXhdlSYgjbp6Na/zrjgD
        Td8cUWsajoPwiVLVMoZ6+Oa05A==
X-Google-Smtp-Source: AK7set/GFxUZa9+pN6v1nrcdICrPOicRXUP56G3VOaAZlV5DsSAPyPlTHwrOxDB5POP7UbhlPhDqeg==
X-Received: by 2002:a17:902:db09:b0:196:1462:3276 with SMTP id m9-20020a170902db0900b0019614623276mr664747plx.46.1675727958457;
        Mon, 06 Feb 2023 15:59:18 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902edd000b001966308ca0dsm7553082plk.167.2023.02.06.15.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:59:18 -0800 (PST)
Date:   Mon, 6 Feb 2023 15:59:14 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 4/5] KVM: x86/mmu: Remove
 handle_changed_spte_dirty_log()
Message-ID: <Y+GUUr/UE0V0WsrR@google.com>
References: <20230203192822.106773-1-vipinsh@google.com>
 <20230203192822.106773-5-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203192822.106773-5-vipinsh@google.com>
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

On Fri, Feb 03, 2023 at 11:28:21AM -0800, Vipin Sharma wrote:
> Remove handle_changed_spte_dirty_log() as there is no code flow which
> sets leaf SPTE writable and hit this path.

Heh, way too vague again. e.g. This needs to explain how make_spte()
marks pages are dirty when constructing new SPTEs for the TDP MMU.
