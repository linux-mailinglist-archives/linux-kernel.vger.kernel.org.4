Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3470C8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjEVTka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjEVTjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:39:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1283B3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d3e5e5980so3904029b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15lSZRZhXLomY0U2NRYU9uW0smeWq7pcEslVONXUi3w=;
        b=lultQqiUKak9FMfr0vvzZAvgIXLahXbv5eD+ktyGdatLnupmEkRIwq1R7iynCFDvLF
         d4V/iTwrrsjmy80BI5rWes1qfOx6WerIwlALEf6vtMklt0JtxgI6EkCX/c9fLAGYnUg4
         FOpegxkkgYbK2Fg7VNn3VDHsWLoR8IeuaLj4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15lSZRZhXLomY0U2NRYU9uW0smeWq7pcEslVONXUi3w=;
        b=EwjmCW2qAoGE00EDYjq5cBjGHrNxuHP7xElX1YMlWr32PShKaPqZAkXD3zAf3qxQjK
         acpokIvjGqT+c0L8nxmRGd5BFDT0HSBysUwCN4smb3CZe01SEkTffEEMS2y+1V6Hkslv
         FeYuc1AxPQrOEdJj4X9A3+e1cEELxFQVe9wAH8AAtXcKbwb31duKfKNQ+9icOuZhrUMv
         CQsBKd3BJV+ABUou1XFQ0de0WzaEDw6RcwAZeeXBrcnSdmFKi5bRn5YL0mvT4hLxZraS
         PJLSQWXKaH0Y7H7OrCi06YTr27jFy1mtKSqc9DQPHBDGZX3CdNN7mVV/gIkSaTSdox67
         63CQ==
X-Gm-Message-State: AC+VfDyYEMYZQ02+qxp7LMo1SsONFZQrIFdN/QU/SNBtsf/T7u+tRQg1
        femsPTvWHk3k0H5iJUNiNdGHVA==
X-Google-Smtp-Source: ACHHUZ4kzfOePZUuovzfabT8AgRib6y/nHwVGmMvBg8fdTKcPNszB02HKZi7Ot66DeoLW/DPcx7wKw==
X-Received: by 2002:a05:6a20:549d:b0:10b:bf0e:3bda with SMTP id i29-20020a056a20549d00b0010bbf0e3bdamr3899463pzk.2.1684784387947;
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i24-20020aa787d8000000b0064d3e4c7658sm4602374pfo.96.2023.05.22.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, teigland@redhat.com, ccaulfie@redhat.com
Cc:     Kees Cook <keescook@chromium.org>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dlm: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:34 -0700
Message-Id: <168478437619.244538.1491421946258356417.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
References: <20230510221237.3509484-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 22:12:37 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dlm: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/30ad0627f169

-- 
Kees Cook

