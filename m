Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8021B74F41F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjGKPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGKPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:53:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7BFB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:53:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3133678b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689090836; x=1691682836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cNKZT0w/ttrTTuQnq2pupPxaZ8+d56ppimt6LWSmTY=;
        b=I7NZ7oudXfX7DjTOHGibnmEqu5Y6r8jhwGNq5nuByp5Cm8CzCU+gBB6L8H3wfxEBLH
         PCkIik1Ed0RTDeFUuIdLGcrQrp8GWBfKtwRkSFpJawxZhaTPedElAPQxXBeihxdL+vKe
         wuwPQtwSgiId3KLkKrEBCOCzZMeONSlUH1xrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090836; x=1691682836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cNKZT0w/ttrTTuQnq2pupPxaZ8+d56ppimt6LWSmTY=;
        b=aOtbZqbh/MVlTtWyj1eAxaMQGBNlhIucUQa/0ReeRJESXWGfQ65FWy1s5HWunnujhp
         /M7b78vmcIpLZTM7Z0aem6IVoKomYQl0T1Sz7R0RYQe+/WW5QzNLobrLNGNuF88/FjuZ
         5wo2iBJPoMGNIWLciPgQEz01+1HpsdRgZwYxodtB3Tb4OdY/HfdehzqlXiP1O9WZ4IJD
         3oZ+2/YxTnbkyxefbRijr15c97mzbU8O+VAZ28TUcyFAuLSLkzkId5eymmGxUT067H/E
         Toz2UWzE7+hwRCTm8eHOTa2kp9dBKfeMG2XSaiYPTCakUvdKzx0yqwr3pQLo/QYeBjsR
         P5zw==
X-Gm-Message-State: ABy/qLaCDJ6AWv1Ar4v3SZA1t7YNI+YfkH4O76lZqE/8vPbTFbYaGA5w
        WQz2FdnJ43SnD/+z1i8n58IQBg==
X-Google-Smtp-Source: APBJJlEHiRUlipZEYAc51ylR+oPacMfWIOIrJlTW8swND/ECBm1TJ7EYHrvDwuWGBCO4tdrgDY7W6w==
X-Received: by 2002:a17:902:c212:b0:1b8:5bb4:8230 with SMTP id 18-20020a170902c21200b001b85bb48230mr12101183pll.50.1689090836550;
        Tue, 11 Jul 2023 08:53:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709026ac500b001b8918da8d1sm2100722plt.80.2023.07.11.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:53:56 -0700 (PDT)
Date:   Tue, 11 Jul 2023 08:53:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Ungerer <gerg@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com, brauner@kernel.org
Subject: Re: [PATCH v2 2/2] riscv: support the elf-fdpic binfmt loader
Message-ID: <202307110852.E093C93F@keescook>
References: <20230711130754.481209-1-gerg@kernel.org>
 <20230711130754.481209-3-gerg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711130754.481209-3-gerg@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:07:54PM +1000, Greg Ungerer wrote:
> Add support for enabling and using the binfmt_elf_fdpic program loader
> on RISC-V platforms. The most important change is to setup registers
> during program load to pass the mapping addresses to the new process.
> 
> One of the interesting features of the elf-fdpic loader is that it
> also allows appropriately compiled ELF format binaries to be loaded on
> nommu systems. Appropriate being those compiled with -pie.
> 
> Signed-off-by: Greg Ungerer <gerg@kernel.org>

ELF stuff looks fine to me. If the RISC-V folks are happy with the rest,
this looks good.

Acked-by: Kees Cook <keescook@chromium.org>

Please feel free to carry this in the RISC-V tree. If you'd rather it go
via execve tree, please let me know. :)

-Kees

-- 
Kees Cook
