Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933486BE6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCQKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:38:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1326166E6;
        Fri, 17 Mar 2023 03:38:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so257289pjl.4;
        Fri, 17 Mar 2023 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679049482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8hDCM0BvKf6M/FAL95ch0TPHn3it9hzyPSQddz+nU0=;
        b=GJtPM8/YPgBYVMf80AQyvXk1icXvfz253xYaj492Oqj9f2Xr8BuRvMTxlCLMOSmO8g
         OCEW1pR4cPU0uHkc+1zLI6pyoWGyHHBUtNDyaF+WMoMWvSdJL7Rn+Qibiov1HLHS4ONj
         Czx4yL4EW31OFsTIOto0o5sbBjK+ihL9RO0CqhoSJgQqpj37oEH7AtNf28W6cwhIrbPB
         mxFFRjK0x+mOe21jz1SCANSA95F6etzIhzbGoCp7hnrtdQnUz+wn1E23XpDO0UouV7gz
         lVYhPrPS/D8FH1IVsBlsLYZLOqrQYO8+WGDSes8SeGxK9AKm2OtLgSUGWwTzQEdqprYd
         qelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679049482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8hDCM0BvKf6M/FAL95ch0TPHn3it9hzyPSQddz+nU0=;
        b=tZU671H3yiHkyR1RJucIpn+CtklUQGLMqkr3bweLThumzVxq+oU1uJV9BaWxPPZUBS
         t/xFJ1fvqdVu1iaC+984U+7u2ADcoyelXBixeAMtA4lg/vm9lQRsM/Ne7g01K7cFzUwg
         2FlT994WgKFoZ5fjzaddKxYThZfZfwLPRS2R5L6vz/Mt63Ipvtf4e0Ir/CEmTpEhIouy
         K6nIB2zFv6o0fnVgolzKyOq5RfpLog3Q+kl3SnJ6hc6AInCX/kOpZ2/VIT0mIjYDobqE
         U7EUbFQ6q1yzIxHBZZYsM/YY6BxvSUwswpG9lZ9Z4ZmYVhon+vCxG1t+RKtNfcOgWRK4
         FV2Q==
X-Gm-Message-State: AO0yUKV0Z5fZFqx+rtyl7HkI5jktq5nr4n2njJZQyH0iNLwDdaKo6ezi
        CJylNJlyCGE29rQytij+Y0s=
X-Google-Smtp-Source: AK7set9YMjnNmOUNgiio6BWh5Vvz0PBCktdEJQFGzWFOOCjDSSWLULlKx/hs+9jU8D/t+D0Jvb4nEQ==
X-Received: by 2002:a05:6a20:3d92:b0:be:da1c:df65 with SMTP id s18-20020a056a203d9200b000beda1cdf65mr8074412pzi.28.1679049482106;
        Fri, 17 Mar 2023 03:38:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id j19-20020aa783d3000000b005dca6f0046dsm1308934pfn.12.2023.03.17.03.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:38:01 -0700 (PDT)
Date:   Fri, 17 Mar 2023 03:37:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Denose <jdenose@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Denose <jdenose@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Takashi Iwai <tiwai@suse.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - Add quirk for Fujitsu Lifebook A574/H
Message-ID: <ZBRDBrLeRwrTboTl@google.com>
References: <20230303152623.45859-1-jdenose@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303152623.45859-1-jdenose@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:26:23AM -0600, Jonathan Denose wrote:
> Fujitsu Lifebook A574/H requires the nomux option to properly
> probe the touchpad, especially when waking from sleep.
> 
> Signed-off-by: Jonathan Denose <jdenose@google.com>

Applied, thank you.

-- 
Dmitry
