Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD6770C8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjEVTkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjEVTj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:39:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2778B18F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae851f2a7dso25671705ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784390; x=1687376390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXaL9dlHiKAWAhbj1etQPCvf7dMzBz97/ah3yQwMB6g=;
        b=gpoq1bHzwlKS0iPW5k3t8e7bBhtTtRx0pYG/1AYIumv9bP7LU7vzTmv5vFfXH1drXd
         FdbjXVUfztD3qECHwfpWjSZLWiQONT4xGMAkugw9xTAzr1R+a3U5KuknPl9d5CFJidqr
         3IhLk1mlMqjJUkJkGq6L0ayNJXNAP3JA3bfdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784390; x=1687376390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXaL9dlHiKAWAhbj1etQPCvf7dMzBz97/ah3yQwMB6g=;
        b=EIcup8uHEajXxUo73ecXZujZSG4o38IRTgXtp4fnNNK3TwimoS9VEGF8IdsoJJj2SX
         6mtnHPuKP9vurNMYUuNO586DDnQ/sED9cpQa1pbpM3/dsBsQKeCuB9H2H3aqr8w9ivO6
         9SyGx2Y7Z1KELtFDs69SZx46TTT1bhfhBLQDco7Hv1KIVHPxqe6MSCDcCjYsxDcKoGnG
         DCJwO3zDcvnY22XRp9OrFfaqRp5As0JknJtL1p3+aYQj1cxUxkR8FZD0M8QYWXP0uoN5
         t3UHeaxF4n2vGnS9akYeeu8EKF9tLEJGfr3YcxRO342i17UXIjAZivroCHGrMa3miLyT
         IzoQ==
X-Gm-Message-State: AC+VfDwbtEClDZLikGfBeKKhz2PTYijDJCtv3GNTsR0DEQGeSVN6SZcL
        6YOv2IaYROupdueLjyeRh9LPtg==
X-Google-Smtp-Source: ACHHUZ5VIiMuHu+1y0eouyzj3q+4VKQ8xUtRKBhL4r1JwoLQxR5w8tpqBRw8gj/5ob3Z7R875tYTXg==
X-Received: by 2002:a17:903:452:b0:1af:cbdb:9772 with SMTP id iw18-20020a170903045200b001afcbdb9772mr34695plb.18.1684784390635;
        Mon, 22 May 2023 12:39:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170902a98c00b001a6388ce38bsm5183579plb.240.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2i: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:39 -0700
Message-Id: <168478437625.244538.13691044123707581954.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517143130.1519941-1-azeemshaikh38@gmail.com>
References: <20230517143130.1519941-1-azeemshaikh38@gmail.com>
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

On Wed, 17 May 2023 14:31:30 +0000, Azeem Shaikh wrote:
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

[1/1] scsi: bnx2i: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/91f1887a1420

-- 
Kees Cook

