Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44E6291E9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiKOGgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiKOGgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:36:17 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AA01F9DC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:36:12 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 129-20020a1c0287000000b003cfe48519a6so2661471wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lucaEfGhqe2TQcjXAWdO34ZK25H8iCuCpjwK71zIz9U=;
        b=dthSXHgyVghlAUAW1toa/SOdq3dLdhkGVLqxSd4h6Vy/nseNsUR4HKYg2wlum0HzL3
         +kt28KuovW3l2qggHtWcHBprF/IV3GxKVJUfWMIKMB61Kwu2DBXCBD5HEY3+QyDLbdEy
         J42PB92s7XUjr1+gxHq8OjQcu+jlXu5Cd7gZ2vshfzgGYviQFIIOEmCshc4LibYr2/5c
         tzxEwSH5Zsg7c8bUBaLdaPNmgNwXgMmU8iGHv4XkpmBvgKSlku8O6BtJSYW9CJv0UsX0
         cVfyScRYjNB/AZUNEgFrxvmryvFOsK4qgOMw3EdKZfliUsDnxMlqKnkyAUtRXCJSRM5v
         86ng==
X-Gm-Message-State: ANoB5pmu1szhdBKM/sgtNfJNwWTnV18fyJSEzxnhv35+g/PHDmg//pTF
        EwFudhyxqV27EAshPvefIsY=
X-Google-Smtp-Source: AA0mqf6yPeh2Gmls0gbrGh64Kf8VrDiLW4ZqbPJr0XGRyNrhx2elhx6qm45J1ADcyA36JVjfQBEuVQ==
X-Received: by 2002:a05:600c:89a:b0:3cf:ca91:7094 with SMTP id l26-20020a05600c089a00b003cfca917094mr324327wmp.24.1668494170478;
        Mon, 14 Nov 2022 22:36:10 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b003b492753826sm14536803wmb.43.2022.11.14.22.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 22:36:09 -0800 (PST)
Message-ID: <34ca6034-331c-7c6c-ddd4-f774dc8f22ce@kernel.org>
Date:   Tue, 15 Nov 2022 07:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/46] kbuild: pass jobserver to cmd_ld_vmlinux.o
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Martin Liska <mliska@suse.cz>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-3-jirislaby@kernel.org>
 <CAK7LNASUb0PLiZahw46c0qBUn_caMWm2SrtY1Hb8Vd7RzsAwzg@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAK7LNASUb0PLiZahw46c0qBUn_caMWm2SrtY1Hb8Vd7RzsAwzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 11. 22, 18:57, Masahiro Yamada wrote:
> On Mon, Nov 14, 2022 at 8:44 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>>
>> From: Jiri Slaby <jslaby@suse.cz>
>>
>> Until the link-vmlinux.sh split (cf. the commit below), the linker was
>> run with jobserver set in MAKEFLAGS. After the split, the command in
>> Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
>> is lost.
>>
>> Restore it as linkers working in parallel (namely gcc LTO) make a use of
>> it. Actually, they complain, if jobserver is not set:
>>    lto-wrapper: warning: jobserver is not available: '--jobserver-auth=' is not present in 'MAKEFLAGS'
>>
>> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)
> 
> 
> This Fixes is wrong since GCC LTO is not in upstream code.

Yup, this is a left-over. Now dropped from both.

thanks,
-- 
js

