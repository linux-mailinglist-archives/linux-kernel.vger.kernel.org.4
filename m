Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9A0712B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjEZRQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjEZRQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:16:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B386F2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:16:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so907400b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685121407; x=1687713407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tt/68vR6SyeC2sLBcDQmwXBv1ANp28ndmxJPUsWE9hM=;
        b=LnkvrIlQ8Tok1eY3MzXaVX3kUwG4iQ/TiKFyN8pB9xmQgyIk1TWe7Rhr0DTtyZlcDs
         eVfyKux69riINbAJ3ut36H1rVoRrwRJT4yCWqFMFjVVbBMYEs2dxvwSjolS7rd4aewK5
         xwaoXlV1TqZNJcLRm1EvoAdemOvEOa/ETWhKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121407; x=1687713407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt/68vR6SyeC2sLBcDQmwXBv1ANp28ndmxJPUsWE9hM=;
        b=XOmAAv1nNh/qENxBncZlCTslj56OVbiBRC2/MUXSVWaccDrz4EzfQrjs4beiFTFHB1
         VslhJGt5lQOXP7+eD+rAd7cKKo20+uSd/v7HdnQieyifx/mpgcyzNCDG8u1MVDxiEroQ
         aGuG1ya1dNiHdIEibZ6ETGAIUj6hVwqP0K/QJwVV71Id2+ddra9ACxd72HgQFJzXmu3S
         JSSlbhhMbCpL+amAvvcP4oaVfdDLvfU6egFuHOAfFW/RPiSmabi7N51+p4VKquiUQIxA
         SlTo2BKiLtfnzz3EiWHO+2dDNtmSIuFbYxIkWn4xk64E+Onk3dEh7awKTujsxFYYLXJN
         fI+w==
X-Gm-Message-State: AC+VfDyo97GrcllsoIXfx+vtCQAv87md0bhesEm++HjPahJjZST5cKSZ
        NSh7ab4VtQttQeE4uCDIs/XCwQ==
X-Google-Smtp-Source: ACHHUZ5x1UtHJq0vBgeGLgQxf+Iim5Mb2xwowdl86d42mrNau8iDDUGU9hQVFxLDmRhXDrvIjkEZwQ==
X-Received: by 2002:a17:903:10c:b0:1ac:8062:4f0b with SMTP id y12-20020a170903010c00b001ac80624f0bmr2720843plc.59.1685121407089;
        Fri, 26 May 2023 10:16:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b001aaecc0b6ffsm3490147plq.160.2023.05.26.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:16:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     ojeda@kernel.org, keescook@chromium.org
Cc:     qing.zhao@oracle.com, morbo@google.com, llvm@lists.linux.dev,
        trix@redhat.com, linux-kernel@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, gustavoars@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
Date:   Fri, 26 May 2023 10:16:29 -0700
Message-Id: <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517190841.gonna.796-kees@kernel.org>
References: <20230517190841.gonna.796-kees@kernel.org>
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

On Wed, 17 May 2023 12:08:44 -0700, Kees Cook wrote:
> In an effort to annotate all flexible array members with their run-time
> size information, the "element_count" attribute is being introduced by
> Clang[1] and GCC[2] in future releases. This annotation will provide
> the CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE features the ability
> to perform run-time bounds checking on otherwise unknown-size flexible
> arrays.
> 
> [...]

FYI, applied to for-next/hardening:

[1/1] Compiler Attributes: Add __counted_by macro
      https://git.kernel.org/kees/c/86a76e91cbab

-- 
Kees Cook

