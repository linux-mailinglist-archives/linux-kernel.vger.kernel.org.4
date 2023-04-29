Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BB6F2263
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347152AbjD2CVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 22:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjD2CVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 22:21:08 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54421FDB;
        Fri, 28 Apr 2023 19:21:07 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-549d9c2935fso329124eaf.2;
        Fri, 28 Apr 2023 19:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682734867; x=1685326867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+VbzhKX8KyWXXSbsbGtVXK/3HSJI8EHHi0iaF6HDus0=;
        b=ku47PZtJcy5ST8LFXA0TA3wTiFinOlI0dsiopX2V20ErUzUGQo2sBs2NsB6CiOo/lE
         5cwWh+mMqvjeSlrxHpB0VEBO6F+0Omgbyk/K8710zsE3XZL4kRlswv0wnaI59vIUf583
         s7l7BGVJBa4nIkiH8d2r62/scAQgR1uKptXg/LFMH0gU5DALVj9/B/EXtGzIcVEVT4P4
         JYvs7chDtttmwsUMXhd19C3OIKZrS6lvo0ZLBbBRzyaB8eDPN+lhCCpHxyyckJwn3oLV
         HFplcWB4hTwhKgptePg/ORFeM/wijSLFOgv/frCojt2f92exbdg6JOM9+m5FKVDUctRI
         sbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682734867; x=1685326867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VbzhKX8KyWXXSbsbGtVXK/3HSJI8EHHi0iaF6HDus0=;
        b=Q0dxq8oLKCashDqphudm5x7vjPyG3yXcGAjyjqd07CSgBHt1+KNnHqmp0QZzFQ8JEm
         SfurRu6IRSnl32AHwTQ/5pwWsF5SmlWK6MA5tP9jlTqP1mbN9VFaBLWZWsQF7Sen2+jt
         a29qRSept2BiF9BGk5NsYSEXYmJQcXHVZTNYrsLhoewVxHHQJF6xIPjDyJF9uMMGF72R
         R5MRU/aTXPQdbwyaoQchcCCFYr6+ND9Z9P0n2LmDdtD4AsPVG0HZEEK53VIKxdEOSZv8
         D69WG5Xvt419Sb1JENDCpEsD6/pZn/j79bYDAvoPRESFz7q/XkxyE2w0rPLLahNMRhc0
         IhaQ==
X-Gm-Message-State: AC+VfDxqwZfhZrPJUzigE666AXqH6Lb96UU2Py2Gjg5kDGuVV0gozZdy
        ugiry9RnW68HB8u3JlgeP8uk8NBzf/gf/97dX1q0LNFkzt7rmNyB
X-Google-Smtp-Source: ACHHUZ4cK6msl+fxsDnYGrxVu2eYinhbV3XpH73egvC18FRJoj84xzVx85iB70tF1pQu0dLjVzbT5p4nT4tOzNHo2dA=
X-Received: by 2002:a54:4490:0:b0:38d:61e9:12cd with SMTP id
 v16-20020a544490000000b0038d61e912cdmr3655317oiv.21.1682734866902; Fri, 28
 Apr 2023 19:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230428110058.1516119-1-letrhee@nsr.re.kr> <20230428110058.1516119-2-letrhee@nsr.re.kr>
 <20230428232938.GB3150@sol.localdomain>
In-Reply-To: <20230428232938.GB3150@sol.localdomain>
From:   Letrhee <letrhee@gmail.com>
Date:   Sat, 29 Apr 2023 11:20:54 +0900
Message-ID: <CAFiNs_rFYp9L_AB1x+dkRg+oUF1uGKxDm5qQqAaoK1AcS=45AQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: LEA block cipher implementation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dongsoo Lee <letrhee@nsr.re.kr>, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <abc@test.nsr.re.kr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for taking the time to review the implementation. I
appreciate your feedback and will respond to other reviews soon.

As you mentioned, I agree that using loop unrolling in generic C code
can be unnecessary and make it difficult to verify against the
original paper. Additionally, I acknowledge that the submitted code
may lack sufficient comments.

I'll follow your suggestion and re-implement the code.

Thank you again for your review.
