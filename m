Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04F73A5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFVQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFVQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:14:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B8199E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:14:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b549e81cecso26572985ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687450459; x=1690042459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0FbDlfDxURlDXYEi38TcdTGclJW1LEzUZRr4Kw0XLs=;
        b=Np1jwQwnFpdlbUFnPpVBOrewXW9ExPYci8ShZZuNUoVBC34MoYoQUfl6IgqkDQsROF
         fuIWNovw4cWxSRsatLQDzkvKDjAbJ955QSnMG8OguGnASNGAsMHTE6/ZHKcFoJ6OKsGL
         246YVXImIzEFM1e2snp3uvUAqWpk5yS3aVSPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450459; x=1690042459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0FbDlfDxURlDXYEi38TcdTGclJW1LEzUZRr4Kw0XLs=;
        b=LAkiGHpQ9jl9nkkyxR+YUz1golVjMOQ6Y5c4rAT7kAPqq9s4Zfh52TNlh4CEoy7TTs
         pBHD1G5O1cMSY1Oha5njpmkP4tMLEgjFAKdlhLH+o4b6c/+iiyNf8aA1nMIz2OHV2yyt
         uSKsr8ucNOR0GM0cHvWK98U2cijSGjkLyFUP3vLksdL8whM0DGNAujs27viXy+6pZbyv
         z7sSSwkuzyMPexRlw7De0ZOQRcvL/qf0HQR9tFaEqp5tOa6IA5e1ZT/DaQm1t95kynqj
         S0/CW+9F5V90tqO/q9D3+nfG5Hxavw2bXF/fpHAbNbgyjGxek/PMuuMXS/t9yg3qWbiT
         dkyA==
X-Gm-Message-State: AC+VfDxDzazZ298ExG4aDuHo2Rf9woGL92Ocsbk1UDD5QssqbmPF/vYF
        MElclDfdWgpVhlaZvNy/otyZDw==
X-Google-Smtp-Source: ACHHUZ52inhU/E+BWcOqnh7p9sHYuGDBp27alNqN8E/eV6LbwF4dxbHIyl2TQzURk0xaAmIq45BYbg==
X-Received: by 2002:a17:903:18e:b0:1ae:4c3b:bb0b with SMTP id z14-20020a170903018e00b001ae4c3bbb0bmr12964602plg.5.1687450459311;
        Thu, 22 Jun 2023 09:14:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b001b55aab3301sm5588503plg.130.2023.06.22.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:14:18 -0700 (PDT)
Date:   Thu, 22 Jun 2023 09:14:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com, brgerst@gmail.com
Subject: Re: [PATCH v2 0/6] x86/cfi: Fix FineIBT
Message-ID: <202306220913.2482F76F@keescook>
References: <20230622144218.860926475@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622144218.860926475@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 04:42:18PM +0200, Peter Zijlstra wrote:
> Alyssa reported a FineIBT issue (patch 6) which led to the discovery of
> a kCFI issue (patch 5) and a bunch of cleanups and enhancements (the
> rest).
> 
> Backports can probably suffice with just the last two.
> 
> Much thanks to Brian for the better ret_from_fork() cleanup.
> 
> Tested using llvm-16 on an Alderlake with both FineIBT and kCFI.

Thanks! This looks really nice. For the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
