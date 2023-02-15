Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2D6977C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjBOIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjBOIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:04:14 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C434C15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:04:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id co8so14390877wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0PNomvRj7hf1yb3zjFxN+WA4g/LrO9vhkLpkP8esTM=;
        b=K5P7VFpsmNGVSMEHcKncWSY2Fyox5+JfcV4KxPmF6FeGwQTOaN2s8Kr4zheVvZiokx
         n0fiqernPCWkuLa/OdKZZevuOyiETys43P2kbQ5DA/gk3W5lMJ6uUI5RPb5iM+1mjogC
         wFC6zERt6FxTUxWqMIQFg1g5Xst4wnqiqjJvU0CguXp1miyjtHpf9ev8cgitbRjptVca
         EQEfxT5Tp805hQVvfb7VUSgU1WgfEocYqIIsbvEOl/udLz3j9iYsrIolw4NW191hoGlu
         fgN4Hien2b00pSBQZLr8lOsQCTL8moYxf2ZIqwsjmBt5mkRojQWru/QZ/dtQBuKzJuR4
         GmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0PNomvRj7hf1yb3zjFxN+WA4g/LrO9vhkLpkP8esTM=;
        b=Hpb2bsP54SKBigNi5T+n8tldAm6Via8R6iANU5otAO+mNoCVLDClBCrn+5KmbjvYpK
         hNS0qRGpqZeOIVT3Ynzw6gU70ozOucLaiuvo2VvHMF/qheY9WmU5TXPGOLhxQ5hOspuW
         M9XUqXkhQ+hvBJAPSZ1HeO7rXap9Kd5EFJD/8V9Sj1pwJ8/JJ5R+4KTIOZZQwyEJtGbl
         pzwoybQtXzmUv0mzNcEtjMaYmpCoJ/GOKPosyOAei9LRBKzL/vVnJtFKwK+qWddHGG7z
         OTJLpPZzm0s6+7MiFAxJ2ADLF3yA3Sw8vJVQ0FuAn4SP+Cjzfjj+5YxvNEpKpBuqnY7Q
         Xhow==
X-Gm-Message-State: AO0yUKXagy6qYJBPcW5qm4zOYI2nmSpYesDYwnozszCHr6amRZqAqL8W
        Pg0SVCP8jjO8a4WoGwAlo4bT+A==
X-Google-Smtp-Source: AK7set8SY/K8xTB04Sftv5CRmwP0Eb7wShb0AJguVdTk29FcDZHSC8AB5hhDs77ckn8H3ZLmnvnT2w==
X-Received: by 2002:a05:6000:120e:b0:2c5:63df:1171 with SMTP id e14-20020a056000120e00b002c563df1171mr773187wrx.19.1676448252171;
        Wed, 15 Feb 2023 00:04:12 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c47d500b003db0bb81b6asm1284781wmo.1.2023.02.15.00.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 00:04:11 -0800 (PST)
Date:   Wed, 15 Feb 2023 09:04:10 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
Message-ID: <20230215080410.65zbhimqbs2kbmod@orel>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-3-evan@rivosinc.com>
 <Y+wedUsNEfWsKU5I@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+wedUsNEfWsKU5I@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:51:17PM +0000, Conor Dooley wrote:
> Hey Evan,
> 
> Just as a preface, I'm reviewing this lot from a position of ignorance
> on what glibc wants so I'll refrain from commenting on call itself.
> I figure that since the commentary has kinda died on the sysfs front &
> Palmer seems to be still into the syscall stuff, that we're pushing on
> with this approach...

If I can find time (that's a big if, atm) I'd be willing to do a sysfs
prototype just for comparison/benchmarking purposes, even if the chances
it gets merged are low. But, time...

Thanks,
drew
