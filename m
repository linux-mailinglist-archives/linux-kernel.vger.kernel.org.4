Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863674F417
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjGKPvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGKPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:51:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B6EF0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:51:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso3358028b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689090699; x=1691682699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0Eo8sEWwi+QlL6TwKCEAUf0c6tdOFvYOKUGXKFLpnI=;
        b=VEHl1YDonMq0agfdUsVKQhxo8RItH5aI7RFQLbPPlyzgiEZLoC2QTbgKfhaUAXb0Xs
         mt2OV6GTXYF+7hq2+LNiL0/ACbBpJ/nlAWB7DJdT+a6lnDl//ZGmngeWOxRP9eIddcv/
         F7Yri1Yx+qPeciVnr2KrQ5EVMTSFWvZEHVvVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090699; x=1691682699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0Eo8sEWwi+QlL6TwKCEAUf0c6tdOFvYOKUGXKFLpnI=;
        b=LTnXaIkWTbU2LeXOVYKLbrZ5QIMceZZoWQuRRrWgtXTZCL9rldOilhHRkFZiMKG8Hc
         tegNRpifjWMbvIocL51YG4PxkIDuvDibt7bX0uCuV+60Xu6XNAw4YgEcDCrDp2UgO5+q
         hjG3nCjeFT3QIJuyKhW7mFpr2lXQ8Ni2+OC/+4676Awpkx6g3qodjKXbyqGkqj+37HOg
         kvsFNPIcF5KRWqrTnFGDPriZv0AdY4WyM/wUMBUUCe8BGweNbUcxpFKuy69RQYUGffQk
         km57aRCMQKESzJ9tILyYvUw2xn9nlIv2PRBHiZbH8DNp2kHI/mwYMAsyIVP76YoeuEmV
         /wkg==
X-Gm-Message-State: ABy/qLaBhXXJ/MUqTK7RAwogqELfM3rSD+81HvzlyvikQhFNgFCAWGkd
        S4suHx5lF+HrWN72RKhPzlp5Xi+IA3HWEmisdBo=
X-Google-Smtp-Source: APBJJlFNryFmhWoGlqCtUbbFGrpblHly2Pt7q3F0N7u90O+eVHxQGOhARPP/AvkikwP6Li4cyHQmng==
X-Received: by 2002:a05:6a00:22cd:b0:674:1dde:4c59 with SMTP id f13-20020a056a0022cd00b006741dde4c59mr14931253pfj.28.1689090699562;
        Tue, 11 Jul 2023 08:51:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x13-20020aa784cd000000b00682a61fa525sm1934182pfn.91.2023.07.11.08.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:51:39 -0700 (PDT)
Date:   Tue, 11 Jul 2023 08:51:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Ungerer <gerg@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com, brauner@kernel.org
Subject: Re: [PATCH v2 1/2] binfmt_elf_fdpic: support 64-bit systems
Message-ID: <202307110851.7F2EB003@keescook>
References: <20230711130754.481209-1-gerg@kernel.org>
 <20230711130754.481209-2-gerg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711130754.481209-2-gerg@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:07:53PM +1000, Greg Ungerer wrote:
> The binfmt_flat_fdpic code has a number of 32-bit specific data
> structures associated with it. Extend it to be able to support and
> be used on 64-bit systems as well.
> 
> The new code defines a number of key 64-bit variants of the core
> elf-fdpic data structures - along side the existing 32-bit sized ones.
> A common set of generic named structures are defined to be either
> the 32-bit or 64-bit ones as required at compile time. This is a
> similar technique to that used in the ELF binfmt loader.
> 
> For example:
> 
>   elf_fdpic_loadseg is either elf32_fdpic_loadseg or elf64_fdpic_loadseg
>   elf_fdpic_loadmap is either elf32_fdpic_loadmap or elf64_fdpic_loadmap
> 
> the choice based on ELFCLASS32 or ELFCLASS64.
> 
> Signed-off-by: Greg Ungerer <gerg@kernel.org>

This looks good an is consistent with what the regular ELF loader does
with the sized types.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
