Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D36D5FBDBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJKWST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKWSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:18:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B537FE67
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:18:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g28so14780859pfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOz+D3qN+D5XSjeZhjdEZw1Edyfh9x16KWqNTlE6IJw=;
        b=Aa/p5F9DamtX4hyjG7/mfBjsXWBhWtLfgJ3dAjOuAUZ3O+iUldUtQFsGg6WqSMXu8a
         4+uh+1HwwGH6E9Cpwy4+aptXNfuwe45Cq3ozyLW4VPrFHbTrSzKMSow3QHPc6zoSHeOP
         o0J6gK1GRjNWF2b/sVBVesfl6JM9CPEB4UAIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOz+D3qN+D5XSjeZhjdEZw1Edyfh9x16KWqNTlE6IJw=;
        b=l5uIurp/flQPMx4XNwK/QKyn8z2Ch8xmBPv1XsPZ/ghbK6YY6Hp0z969vpysMVLp1h
         ecy0O4k+S6RIWETf33o3Pk0uSP9yVZWOyNB98MiaNR3fTKRuCRmpd60AYyUD/kTJ9QUt
         SSXitXXWXuhvri4Tzp4c8+S41f1GIi8TFDdWMVRxNGVgMIzzD2pCKJee72yRiTc8JIpC
         4oyGI0wAhPb/RDxE/cEEFO2iPaEduNGL9GY7DfJMQ2W2eC07UXyh9GGjmaGW66RSksAh
         BQSOQpb1FGzRi2+HpFw4KG+lKN8fqgeIOkpVjkKNPUpt2UXecGpQBsBw6zxavc4Ysae3
         h0RQ==
X-Gm-Message-State: ACrzQf2G9tu4KmJkpF9raebRez/MiIip7nFBySlsEICn+XYJc6CRDa+b
        Q92O5JANAe8NLnmONxhXD+EF8nZsi/k/DQ==
X-Google-Smtp-Source: AMsMyM7zgBTOsL0p7tJMXcEjncw8aWga9QOJV3/IxOX8GSssbmu2xYJXxhXT/zqSz6TG49A5FGiRPw==
X-Received: by 2002:a63:1a4c:0:b0:43b:e648:a7a4 with SMTP id a12-20020a631a4c000000b0043be648a7a4mr23134321pgm.7.1665526695285;
        Tue, 11 Oct 2022 15:18:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709027e0d00b00172973d3cd9sm9112009plm.55.2022.10.11.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:18:14 -0700 (PDT)
Date:   Tue, 11 Oct 2022 15:18:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <202210111518.A6E8A0FD@keescook>
References: <202210111305.743F591@keescook>
 <Y0XQsqdRzlrSpgOh@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XQsqdRzlrSpgOh@mail.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 09:23:14AM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated. So, replace one-element array with
> fixed size array member in struct dlm_ls, and refactor the rest of the
> code, accordingly.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/228
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
