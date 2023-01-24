Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44642679CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjAXO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjAXO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:56:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9BA86BB;
        Tue, 24 Jan 2023 06:56:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id be8so2075306plb.7;
        Tue, 24 Jan 2023 06:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7vLA0Le7UBWDYEC2iHr4cZFMxWAnzSF6jXWlket4OM=;
        b=dbi55NIwAgeLWWUGUNzlG4N7Mxi2fvh5A/y98QKv1NRC+hCiFnCwhOA3jtC2Vg9yFe
         BFojyl5kZoX0iMl447XqIYQo6O8FHNHJXEHQl3T4sfAyAdpqB+WEMk5V//dU1h8wJi07
         8sPa4IdLK5ZyOQ1C9BSzO/l9b+aTaO6kynrUcKk1rU8oURdBRG8HQFUqZUEYFM3pn+cx
         62Vyfc9sfPv0Ne6q5Rwb1RABB6Hr/9xaxj95v8BoJic5SjWJIcfCKMtkumCmhGSdQ4B3
         C0kF3/j96pntuGVr5CYQ1qDs8IQgIlyjzevFlLJhf/PZxkxDY81yNX26fCqR+XUjGETq
         ya3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7vLA0Le7UBWDYEC2iHr4cZFMxWAnzSF6jXWlket4OM=;
        b=bJYxNf3YnYPijPbU2jLcTvy6fdEWKrm1nNfhTEYqbcrGC/ezIx5ki8UGJVZlnIKC+W
         Itg/GUfOGcAPAG4xIXE9ilHD2GEOeVAkSlgrL6z7mUD6Q1Br9lUpOToQ9MAjJTUDNnmP
         XAlq/JtauamQNQE/xTYOwmhdVDyDcFevdUiMPFo19fZJpB5zCIIIHLdVY/BG/JORhNUz
         14FQJv8VnitVO3NtyQZgKjMyF0NkHhe/uB/82v4fm83ufUDrNyCRx9tzy/5XHxSplFht
         6zAbZtMh6fySqcA4DWl7V0uUhyQff9pgvIWag2lQ5iDBv/3VQIrb7fiVIUmmsYG7ZS4n
         hh5g==
X-Gm-Message-State: AFqh2koRFr+EttXLzia8Iadh2YwFAtAsWibuJB617nqkoWtunP8lmrAL
        rsCrwU5LLpBkxhOxtPFPCSA=
X-Google-Smtp-Source: AMrXdXufkFKjJ3gMFQZBW3eMJfBv3aEGcmvRXg0TXCwWKEE4fqRgmxcfdK1xfHaS2UhFfScqQN/apw==
X-Received: by 2002:a17:90b:3b83:b0:22b:b375:ec3f with SMTP id pc3-20020a17090b3b8300b0022bb375ec3fmr15567329pjb.21.1674572217729;
        Tue, 24 Jan 2023 06:56:57 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id s18-20020a656912000000b0049f2c7e59f5sm1536522pgq.27.2023.01.24.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:56:57 -0800 (PST)
Date:   Tue, 24 Jan 2023 22:56:48 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: Add device tree for Xiaomi
 Mi Pad 5 Pro
Message-ID: <Y8/xsGGUXXqzXOHO@Gentoo>
References: <20230124135318.10023-1-lujianhua000@gmail.com>
 <20230124135318.10023-2-lujianhua000@gmail.com>
 <8b2b3457-37db-3a32-dfca-3b1bc74f3dd9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2b3457-37db-3a32-dfca-3b1bc74f3dd9@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:31:14PM +0100, Krzysztof Kozlowski wrote:
> On 24/01/2023 14:53, Jianhua Lu wrote:
[..]
> 
Thanks for your review. I will send new version patches soon.
