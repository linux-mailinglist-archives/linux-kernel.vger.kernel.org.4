Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4F70C8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjEVTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjEVTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:39:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F84102
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2981e3abso3535871b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784391; x=1687376391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2jEpAMn2sppJym9VTffGg66OqE+Owax2jsJobO+lpY=;
        b=GAhvMxLqlktEQWQhaTQzC0fI6WX0lWg5TOpNgoOFjFdrLDlZG5E7GmIAA1rSQCa89S
         vmhBNcre+8RDeFRCKiHq1mCkFwBYk1iukc1MhHJW0yHfX4mFq8sQAWmM2tgF+IOtfmMF
         BmcQ66ZNJNBl+QANYvaC5Vw6XN12vK60wnrpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784391; x=1687376391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2jEpAMn2sppJym9VTffGg66OqE+Owax2jsJobO+lpY=;
        b=AiAzRYJtUyOgZ1zsrAmwiXAqjzGa+/6pq+6F0CSoAp9NgmiuELTBKe7EBLZFYBPQIn
         4HyoxEAtkQeGNrH83rORoMvB3KtvD6zdWs/0lv36rtKcLNDk/zRWjHE0LUYiGwbxOvMe
         G+MKACLdDJITp1EIp40RcQwM0t3dEz3nOxVIlef7Xmz66Q/2yf74qKjCv1HE/rR0I2zX
         rOPobvba61X6GVGnTh94h55akKn/ENKz2werSFEA6XLKyloKWOGtC432GT22PJHAS4lu
         IOQITgXK35HTzxrk1g72SQ0QrxXfCsdox+HPjsegMy7pcYrH0abcNa2QKgFP55FPGonX
         3eaQ==
X-Gm-Message-State: AC+VfDx/U3S3ugdJmyIUe3QrfxMDSlrREKX8scJnM02iLXBvsIitQ0i7
        sRui4G2Ec93ju3/kP/jmA++Tmw==
X-Google-Smtp-Source: ACHHUZ7XfU8otOHEaRosJGVI4waVEHdxQa79hW26NIgI5Mt2wGy/s+FrfhQZE3HBm0GnospWfH/K6w==
X-Received: by 2002:a17:902:e80e:b0:1af:a058:cc2d with SMTP id u14-20020a170902e80e00b001afa058cc2dmr7655903plg.57.1684784391659;
        Mon, 22 May 2023 12:39:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090332c100b001a94a497b50sm5227419plr.20.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: qedi: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:41 -0700
Message-Id: <168478437625.244538.15778765475911379516.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517143509.1520387-1-azeemshaikh38@gmail.com>
References: <20230517143509.1520387-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 14:35:09 +0000, Azeem Shaikh wrote:
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

[1/1] scsi: qedi: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/66f7f4013aa9

-- 
Kees Cook

