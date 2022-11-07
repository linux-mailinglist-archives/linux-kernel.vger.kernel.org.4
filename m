Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EFA61EAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiKGGML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGGMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:12:09 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30ABF58;
        Sun,  6 Nov 2022 22:12:07 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id 13so27375849ejn.3;
        Sun, 06 Nov 2022 22:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPuU0hi8uE8q7bgFrAs5k/BnugkiDikdtVxUAcn1Rec=;
        b=H4jcBXNhYT0nJBGgJg6w6mXiOWKxT+9yQznL+a5AmlG/ZqtrsNqGLJq6g6SRO2ezQQ
         HsORnxSSJrdboAOHh6X5wtIRWADdK2jfpdyJd9MeexJ4+qB/FWtiehLBgOfvMDTxucYM
         bs+LufVWgwBP4B0mfH/pdswePO81z2mpjbL9GyhJUGvLX4BEgrNBDVjtIjk5EYCvi1Wh
         FSzxqQgCalTH0M7Bbg4q3+f7jZnaJR/4m+EvaDcYrePnSILIs9sizSvSXHEK+iI5XSdu
         7CpuY3RyfogDfKsnkpYzDS9f0NscrezimTRtek/OMLgVUDRdW5/fSFWE/b+EQkDWKvoJ
         Pdyg==
X-Gm-Message-State: ANoB5pm+nqgE0c7lyw0khEJ1Tl8WGDjjbawBD5tqCG4081ALJQkRFmr7
        +go6kYSSFEKZnSi88TShYQE=
X-Google-Smtp-Source: AA0mqf4HIkH6+Ky8ihONOy9Q4MDe/SmrvynSJdaUXpiXx/xwU7NwiWqqece33B4bhf7VlgJDk3aQVw==
X-Received: by 2002:a17:906:4996:b0:7ae:6cb9:6c5c with SMTP id p22-20020a170906499600b007ae6cb96c5cmr1883918eju.695.1667801526085;
        Sun, 06 Nov 2022 22:12:06 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b007add28659b0sm2941437ejx.140.2022.11.06.22.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 22:12:05 -0800 (PST)
Message-ID: <34906659-94df-9de5-dcf7-0e787b7caf17@kernel.org>
Date:   Mon, 7 Nov 2022 07:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH] kbuild: pass objects instead of archives to linker
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kbuild@vger.kernel.org,
        Michael Matz <matz@suse.de>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20221102091308.11568-1-masahiroy@kernel.org>
 <CAMj1kXGzFEnUGkoD_JV6=mrKQ+eXLo=SYU8823mPezHZfY_FRQ@mail.gmail.com>
 <CAK7LNASjBm=WWpkSaL1+QuLokhnepUucvhYyP3CCeZYx6nOTHA@mail.gmail.com>
 <9fe8615c-fe31-ebf7-09bd-453fae189666@kernel.org>
 <CAK7LNATBuERrR4QvLzDNOw1TVmMP+2J=sJviihBdy8gF=CfA=w@mail.gmail.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNATBuERrR4QvLzDNOw1TVmMP+2J=sJviihBdy8gF=CfA=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 11. 22, 15:47, Masahiro Yamada wrote:
> Can I see your LTO implementation somewhere in public?

Sure:
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=lto

FWIW, I plan to send a v1 for comments soon as I finished the patch 
order, CCs and commit logs finally.

thanks,
-- 
js
suse labs

