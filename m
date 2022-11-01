Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2496144D1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKAGuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKAGuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:50:08 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C13BC9E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:50:07 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so9344756wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/TlanoNX7lE0YMUkSvsZLUQrX4flVMuJ3MNTRvQeH0=;
        b=dg6LGn4DraeFQqqXR8NdGIEDp6L4e2SlJJDpi9pGxcKVsUNep+zU5sBMVBxB7Yn06P
         BdWRlnTt9SfK+HG85gkkjm997rVgmhf3vj8ZuJc/li+zD000owPZgc7/mrWRKKitTQR7
         omUXq5en65CAqKsq0QqWuMIWvclx1hTGwaawnX1RuT9SXGn0MBzfYESfMIvFAEtV9G6i
         h3l6km2CFXncGTxIC00dmDzM2nT07Ilv7hD1B7xaJ+Yp27VzlvcEmCz7nxn6bqtFJ0zm
         Zx/QvhUK9f/BaXPWy1zSGlfxAVt05MPKt9XaK7vHgjvNTyzICrC01aUclN/JcpFtdEF/
         V82Q==
X-Gm-Message-State: ACrzQf0ynrNDSsVNyA4psqLnznKtuyO4kKfHyNhmeFxXPKoUSSGbGZ7L
        tiiiWUvBd9H8SDqO0GcihNfUAHZ0LRbfXw==
X-Google-Smtp-Source: AMsMyM78j5JqLY0LLKjLKluZkHoi/rxNmRHVA/qWgCbqzxA90fHrmEwlJEXmmSVqzU5Eiu67ZaBF0w==
X-Received: by 2002:a05:600c:1e8b:b0:3c6:f6e5:c41d with SMTP id be11-20020a05600c1e8b00b003c6f6e5c41dmr21080972wmb.12.1667285405811;
        Mon, 31 Oct 2022 23:50:05 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id q9-20020adfdfc9000000b002366d1cc198sm9371772wrn.41.2022.10.31.23.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 23:50:05 -0700 (PDT)
Message-ID: <39ac78ea-1ee5-8911-1208-c56e57df7338@kernel.org>
Date:   Tue, 1 Nov 2022 07:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] x86/boot: robustify calling startup_{32,64}() from
 the decompressor code
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221031151047.167288-1-alexandr.lobakin@intel.com>
 <20221031151047.167288-2-alexandr.lobakin@intel.com>
 <0fcbedf6-3eb5-75cd-cdd9-24582f70cc64@kernel.org>
In-Reply-To: <0fcbedf6-3eb5-75cd-cdd9-24582f70cc64@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 11. 22, 7:47, Jiri Slaby wrote:
> Tested-by: Jiri Slaby <jirislaby@kernel.org>

FWIW that means: tested with gcc-lto which deliberately stores 
startup_64() randomly, not to the beginning of vmlinux.

-- 
js
suse labs

