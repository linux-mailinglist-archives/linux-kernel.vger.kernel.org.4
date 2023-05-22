Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0270C8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjEVTk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjEVTkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:40:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2A186
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2533b600d35so5953224a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784395; x=1687376395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNAaP6+XJai6xtjlcDTjy2E1GXqny00MK+4AdCDW8Kw=;
        b=L917DgUI1lUgyek9XbVU7o1OIweneUJxrl1fmG22A4R2N0dOuIlkd7t+ZPQR8y3Z82
         4CFs4eiLChIkj9Edpopu1tfqfUswK3sOMN4/42tY8ztMEjG9PbtEDrOUs98Y5fRCsIKb
         FXECO0GZe+kqBr0kQLe7f7j2ldk4ljgK735w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784395; x=1687376395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNAaP6+XJai6xtjlcDTjy2E1GXqny00MK+4AdCDW8Kw=;
        b=dGuVGGiq14ZTqnek5MyKBxpZ2mWFjf3ITEM9WSkjKPCuY90F2olvNryNNS0H7AD9Gj
         sCIGvvd0b0ziRXHcNwR1cULfI1c/JwsFon+3zdejDgjyduiK1NP1EQOuXHrINbxPmFkM
         Jux2wfTen/WOJjba+yjZo1ICl3wq6GpaXY6G9rvsinShN4wntgr5ZfT+AGq/9R2ykSyH
         ZrKtbqRRPhW8akeFpYu8reffc4ZRjwNZ7Gpj4zvPmEpTg7ngYvhOrlfg9c3OC/vKzn45
         vYl6KuaxGmVLAzSRmKpU2bfGo7mZtUCTanZNUw+vCDEOY4HXbYlo72sm4Y8fk5AZ99WK
         3VIg==
X-Gm-Message-State: AC+VfDwO2DZpkV2zCKdBEf51eqRepH6ppbU5Klsctg/GphC+TWkO7KnL
        wh2XjWol3QDdKrOW5pLH5Y1NtvrU3Uj7RU4JRp8=
X-Google-Smtp-Source: ACHHUZ7XSGaVK8OAFHtgEWwhmN/dPCgY/hsNSkZ6wHyqo93wCVtLQOXdhbv7Nf33xNA7cZ9ma8oqXA==
X-Received: by 2002:a17:90a:70ce:b0:255:4f4c:368 with SMTP id a14-20020a17090a70ce00b002554f4c0368mr5138998pjm.27.1684784390970;
        Mon, 22 May 2023 12:39:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r13-20020a17090a940d00b0025352448ba9sm6234829pjo.0.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, tyreld@linux.ibm.com
Cc:     Kees Cook <keescook@chromium.org>, mpe@ellerman.id.au,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] scsi: ibmvscsi: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:40 -0700
Message-Id: <168478437624.244538.16463667694387498508.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
References: <20230517143409.1520298-1-azeemshaikh38@gmail.com>
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

On Wed, 17 May 2023 14:34:09 +0000, Azeem Shaikh wrote:
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

[1/1] scsi: ibmvscsi: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/015f6618194e

-- 
Kees Cook

