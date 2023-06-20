Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E3737612
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFTU3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjFTU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:29:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3C19AE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:29:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b516978829so41466045ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687292955; x=1689884955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9ELUq3rJWL5sgo40NB2P+V6d1pA3XgW7pgmlamzmlM=;
        b=UvZQVlZS84/m3wV3wlFzhagqhFWBUDZ46Gy3jimB5RGHEVy2o3P56PUW8kbKz39Pz8
         fvfFbfbNGtmLDU0rKaEsK35wzyBCpdYhg6Qs3HZaw5VOU++7U+cxyo1JeYuGxG7D24GC
         ayNyOm5yNQrrs64EwOo5E58Kr7i3jU830En18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292955; x=1689884955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9ELUq3rJWL5sgo40NB2P+V6d1pA3XgW7pgmlamzmlM=;
        b=jWeVWAQKxT6kTFN2fK2wGgTM6i65tl5hlyUTEQOWpW6zqYjS6wspFFSikLIQJ18WXy
         51a5lkuaTu/ntd9d0j9uB5vdTG53/agK0x/nYI9cj7dkPh8V0dNFA59P+eT3zOxDhByj
         0kwqHVTEY08X8paXI5EszY8jvb7+z6wrUvBceSlz6Hbq36NKaFx+eV0AC/98GbkDd47M
         hXvszY8dnXFMjW5eLfme0cK6HzH1LrzZOJKGI3AjUr43YR3rrClguc1U/1liLxaBvIc7
         JbgAlKXvCG2G8QagC5Tb8d4J0aVvBdmH62qP2/LiQi6e3I3HJiiMCq99edczHYCyxrcM
         Cdng==
X-Gm-Message-State: AC+VfDw3+fwxr46eSGf6iP6TeaalWROISSBTgh/syDW0asYHMaWfhmmG
        Fjt23H0uf0PCbiDNRUek3ypL1Q==
X-Google-Smtp-Source: ACHHUZ7e240sChvlDd+PFC2zltR3tT++pyV+t6swp4zGp5p8LR6AxBH7sOI9UpTanPkq9zNlTqO53w==
X-Received: by 2002:a17:902:d489:b0:1af:d812:d27 with SMTP id c9-20020a170902d48900b001afd8120d27mr17881464plg.9.1687292955676;
        Tue, 20 Jun 2023 13:29:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001ae3f73b9c1sm2007982plg.101.2023.06.20.13.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:29:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     mhiramat@kernel.org, ebiggers@kernel.org, rostedt@goodmis.org,
        azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/boot: Replace strlcpy with strscpy
Date:   Tue, 20 Jun 2023 13:28:26 -0700
Message-Id: <168729290245.455922.11993639418267016143.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615180420.400769-1-azeemshaikh38@gmail.com>
References: <20230615180420.400769-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 18:04:20 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] tracing/boot: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/b1c38314f756

-- 
Kees Cook

