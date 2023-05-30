Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B2A715441
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjE3DvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjE3DvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:51:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90548D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 20:51:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-256531ad335so2159541a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 20:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685418663; x=1688010663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdSfaMnDPST0yDYLJSRYlzRuDvLWC1Vb40RxZnWTJJg=;
        b=sMB3GVXIvnhuv1DLz+sWWRPtx/uMxhQZ5eOPyTSUzLPgAzS0zrGCZvTZ7ZfZcKSfSL
         jozrTBPVK8ZdkPEGOTvB1zRJxeuFhaEUPE2h0YyhFRKlf+hqKKMJgn06y5kpNbiNNNP5
         3kM1aGpXQbgBc7H3S6k3rTK7KOtWM8mPOqyUXF13XQLxOMTigWfVecURObLq//zHuQbN
         2t+nAVfnlOqEBUTy8vCHE8Y/KkBOif7GxWmhV2awX29pn99ALYaM/RL3Szi2cNug/69G
         xHn6uz6fXluT7ct80gePDHXtY8OpvFfjbwsSm/hzVPD8I1/elZbvXj4abOqaerlE8rwJ
         jyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685418663; x=1688010663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdSfaMnDPST0yDYLJSRYlzRuDvLWC1Vb40RxZnWTJJg=;
        b=LW9nR3CYI77Pa0iFimBbnjMcakOE+SAnWOF4Jr7APIkRHTJIU/8+lo7MP2Jpz/YnRJ
         bvqC1sxv41U7rjGZ8t4s7K4sko1xbgcQ08mMDXIujMhvlc8M+u5w22zFL7x+4r27yAhB
         YsC4ssnNRPjBb7JAZEu2aEREuabFLE1JoNpnohERUzThd+LWgOpgPFwRJ6V7RhIfBWuf
         tmPK9TUp0q6knv6MsAk5Zrhm6OQZGa5ZvC1KkgcrKghmWPv+jPmsquoZlN3lp278AO2E
         ZoLKhXEV2xCeC2RpEvkblqv13J9gm79+N74UAxhtvWFrX/cJjkScz5HBNOhHbA0/XVPE
         S1Sw==
X-Gm-Message-State: AC+VfDxFKqeelCCUhSCw2CffezNijFRVdAqiyWqMGX0qCVFxQiRSN49y
        w8rPK+qaFigEMMq/2kaSvHEYyOqZXOQ=
X-Google-Smtp-Source: ACHHUZ7XVDki8DqkeubhoJtRERxWaQHLk4SCz22MgopWVgl7R4Ve74BEkesCe8JsM/BfbvDy+s8dew==
X-Received: by 2002:a17:902:ec8b:b0:1b0:4b65:79db with SMTP id x11-20020a170902ec8b00b001b04b6579dbmr1213007plg.63.1685418662981;
        Mon, 29 May 2023 20:51:02 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d68200b001b03842ab78sm3825471ply.89.2023.05.29.20.51.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 May 2023 20:51:02 -0700 (PDT)
Date:   Tue, 30 May 2023 11:59:12 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH v3 5/6] erofs: use struct lockref to replace handcrafted
 approach
Message-ID: <20230530115912.0000195a.zbestahu@gmail.com>
In-Reply-To: <20230529123727.79943-1-hsiangkao@linux.alibaba.com>
References: <2fa6114d-9de2-9a0d-ae89-c012914bf682@linux.alibaba.com>
        <20230529123727.79943-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 20:37:27 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Let's avoid the current handcrafted lockref although `struct lockref`
> inclusion usually increases extra 4 bytes with an explicit spinlock if
> CONFIG_DEBUG_SPINLOCK is off.
> 
> Apart from the size difference, note that the meaning of refcount is
> also changed to active users. IOWs, it doesn't take an extra refcount
> for XArray tree insertion.
> 
> I don't observe any significant performance difference at least on
> our cloud compute server but the new one indeed simplifies the
> overall codebase a bit.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
