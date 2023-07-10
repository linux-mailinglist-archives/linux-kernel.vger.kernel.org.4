Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131FB74DDF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGJTJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjGJTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:09:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA8197;
        Mon, 10 Jul 2023 12:08:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso2626444b3a.2;
        Mon, 10 Jul 2023 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689016118; x=1691608118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=77ESo+mXQZMKUv5L1rvuRc9WevoEZXkKvJL5dtJqM2g=;
        b=T6ILPwYedE0tokAxd7LajggVlqTJKJToaCelZOxD0Je7/JLlL4+1pav3rTVQ+aWLua
         rxwIGbyA6FXGuVGiKHcmwBRbhTi6Whrkwr+1ml5UUKtYDI7tB5eOskKDnLbT0heRYdtt
         04wuJUy3c8Nx8JjwDW9GcCjPmYgl4tAVUl1dSlgOvmG40ePRH9hsvKKTsq0Y134prd8n
         RE7ENSMG0OZBYASgf/99KTGc+YVsvF9Wt5n+Qi7bG3jnc8PK220lMfLWElMuHvE8dK+0
         F+/FedLFa1ftAJ59x6BL07moKyN+s/gZb7/bJlQ+UyP7LBIynCVqpikjDyPLfWLXdhu7
         uCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689016118; x=1691608118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77ESo+mXQZMKUv5L1rvuRc9WevoEZXkKvJL5dtJqM2g=;
        b=KnoRh1YemGx6gdhautK739d0k497sVhm1yx6uBk1h9GDOstk5/rypiSK+n2Af6ObBa
         AE1P50hoZ8Ufp5m7xtMrm1/fqeUUZuD4oE3KPan7/CleCRvt+k7QyVV1hhUQnLw3fvX1
         tTAD/ZbyaQzK6cFJbuAxu1HkbF1vLM0kYQQ7Lms3VeuPb5C3U5mTytkewrMw1Hxbtd4S
         HVnI/cfcBUByLOgfoVlXvpOtrKQvyPPty7zPXiLvmH85rjhTdIt5fFXSrN1pOWvTOaZM
         dIDSNwN6mh11+XqvJANkagJhqTcjVDzH0T5jcwIDpCiskHAouY5JQbDE9bCA0oUrxydc
         M5QA==
X-Gm-Message-State: ABy/qLaA13z/hV87P8O5DWdMV/iQLTswOBm9NMBQpUPDo28Ii6CpNaVy
        W/gBBt2waVDAG0jVu1mE9Us=
X-Google-Smtp-Source: APBJJlGWM7ALaRlz1U51mZdUoj6hcr1VKgAFrwi46DdoS15uNE2L5mQz9N9Sa3+Ot5ktsTcEQq+Y7w==
X-Received: by 2002:a05:6a20:3d90:b0:126:9f02:da6f with SMTP id s16-20020a056a203d9000b001269f02da6fmr12814353pzi.14.1689016118281;
        Mon, 10 Jul 2023 12:08:38 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:96bf:7e77:39eb:7a23])
        by smtp.gmail.com with ESMTPSA id x7-20020a62fb07000000b0067ab572c72fsm139512pfm.84.2023.07.10.12.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:08:38 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:08:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-input@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tegra-kbc - use devm_platform_ioremap_resource
Message-ID: <ZKxXM7O653L1Tk0B@google.com>
References: <20230709134109.182418-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709134109.182418-1-martin@kaiser.cx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 03:41:08PM +0200, Martin Kaiser wrote:
> devm_platform_get_and_ioremap_resource maps a resource and returns its
> physical address. If we don't need the physical address, we should call
> devm_platform_ioremap_resource instead.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thank you.

-- 
Dmitry
