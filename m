Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98ED67D450
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjAZShx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjAZShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:37:51 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8275596
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:37:48 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h17so2919647ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dcRaudD77ps2tJ9jHTnvXXElZ1owixbxfvsoTGRFNIU=;
        b=M+0CMNTIg0Zbwtx7DAIoA0pH6sAX8P9M/8Qnty+6d7pm+POQ1X5uCOr/LImAWI2Ib3
         +L+J6GalU6y+zzX8Wj2/ki03rA/CX5Xjh/sZDqLYzU9BI0WncKJN4rsQE7OZTfNvqtLZ
         6Xax2idTD/MPpLgCCHefwBK+9aiY1dYfu4JoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcRaudD77ps2tJ9jHTnvXXElZ1owixbxfvsoTGRFNIU=;
        b=Dy22eWsjm5rKIoEXPPWwKP5bZncPOPEIpA8nxBhQvD0iT0YwjkcDZr2M3OBNo3K1YS
         +OvvHeWfEaoHx1X4hQR8WNxekLIDCymCIXccmt3IZr/qRo+6GC4VZxXWTrNlDU2IsdMs
         /i0A35OofoJL8hmdW2gJRLipw3WLTmYJU/Xwk5uAjqatnn+piZ+eTSBaUrB1BDeok46G
         bKjQ7Loti8iZ0fnxHtU6U6v+zFOIfQ/7VCT4pOzGat4O9M4RrLTSeJDRvaM9/dKtehkf
         JNOwCYhZXWrriUpcaKbflthUqWl6oVugFk3OesMrFzostS3l/X52BSDyNk9PNMo0WOxZ
         tpzw==
X-Gm-Message-State: AFqh2kqSkoGIg8vC3I3cDommlDICXugDQoojR/ke+LcxUi43pWw6x/Iz
        Emqxs1MaBNXoXRnCZO69JZJDMCukh5GAGZJdEO08WA==
X-Google-Smtp-Source: AMrXdXt+2EMktC+O6WGOm8X9UlVzrWDmXIfbU7LTiWKNdnFuyytMNtWNNVRO+e9sHhPCPy/Q7ADrxg==
X-Received: by 2002:a05:651c:154e:b0:285:9c23:a15d with SMTP id y14-20020a05651c154e00b002859c23a15dmr12040968ljp.0.1674758266698;
        Thu, 26 Jan 2023 10:37:46 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z3-20020a05651c11c300b00287eb396f27sm124463ljo.7.2023.01.26.10.37.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:37:46 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id j15so1970545ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:37:46 -0800 (PST)
X-Received: by 2002:a17:907:3c26:b0:858:a4fa:a03d with SMTP id
 gh38-20020a1709073c2600b00858a4faa03dmr4359879ejc.82.1674757928104; Thu, 26
 Jan 2023 10:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wjJ2-ReHbDfLwjTVY=Sx=cFq+zNzp80ALQOb=V1+y0taQ@mail.gmail.com>
 <20230124110158.bwqu3v2evoa3ffw6@box.shutemov.name> <20230126144206.mebmtx5ku3qy6xf6@box.shutemov.name>
In-Reply-To: <20230126144206.mebmtx5ku3qy6xf6@box.shutemov.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Jan 2023 10:31:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgzQPbauyh+es+L74aveC2F=Az3C4ur+NpaR2W77czDDg@mail.gmail.com>
Message-ID: <CAHk-=wgzQPbauyh+es+L74aveC2F=Az3C4ur+NpaR2W77czDDg@mail.gmail.com>
Subject: Re: [PATCHv15 00/17] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 6:42 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I've asked around and if everything goes well it will be available early
> 2024.

Thanks. Good to have some kind of timeframe for it, even if tentative,

              Linus
