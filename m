Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7077376DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjFTV41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjFTV4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:56:25 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA751730
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:56:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so2889525a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687298184; x=1689890184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfPFecbkGQnl+lZbzEtCF3B0GD8CMvopuSef+xtXtws=;
        b=d+TmiCDlK3YlhE+l/jzqzrm6zC6N3UVVNGZR8/F4fQXBAID/AztjzN5u/hUbU8iMMf
         N97vnxsp3pdQaj3LYlzKDgSin95e59++FaJED2+f1TC8BFwBGXZyW4FcL+gTny82sgCn
         MUlhpMYlYscmhSnNtbGmxbbCguk7AV15asK24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298184; x=1689890184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfPFecbkGQnl+lZbzEtCF3B0GD8CMvopuSef+xtXtws=;
        b=CgJmeXsSX3V5PxB9+US1c177HkyJTRaLFU+AdNSkIODFo2sTw7f674RFhspznjNKZH
         7+3REJ8NYKPRswK+Se9lG/GPTif42L6xEZoWQrJJPiGNau2GwELZawequOu6XoHbl1Pg
         BKcLjbjMNNKeN+kZtU1ceZBrqor1V07QEkDo9LxY+aKI8rBZaxoNeEmVOsvFDrlB2I86
         mSYNBEsoLnZPJb3HZflZ/iPZ8T2PaoLT3XRj7IBG9JgFQCYZsdnl3qUUM6gVEbEP38Kz
         P51aobdK4I946nK/rZZ21w8UrvNy3IcTEa3N0jWpk3L8EJ34UoHMtcEtg/GcRFVUFgUW
         j/5w==
X-Gm-Message-State: AC+VfDwtEj9cmEcV/5nbtfgGORkIngTk3bS9uB2UBt6jLNp+b6X/CxFf
        zAKNuffat+eJdaTcnmnbTdusuQ==
X-Google-Smtp-Source: ACHHUZ5OKSfC4T12VYGmlam6MgcVnsQQO+vUPp4HzWWHoShZutpRi6s9CnMLA9BdO60c1xdc7OurcQ==
X-Received: by 2002:a05:6a20:9143:b0:122:6fd2:7a2a with SMTP id x3-20020a056a20914300b001226fd27a2amr3793205pzc.55.1687298183768;
        Tue, 20 Jun 2023 14:56:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u21-20020a62ed15000000b00660d80087a0sm1708300pfh.199.2023.06.20.14.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:56:23 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:56:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/2] x86/cfi: Fix ret_from_fork indirect calls
Message-ID: <202306201455.AF16F617A@keescook>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.127844423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615193722.127844423@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:35:47PM +0200, Peter Zijlstra wrote:
> The ret_from_fork stub does an indirect call to the kthread function,
> but only knows about Retpolines. Instead of making the asm more
> complicated, punt to C and let the compiler figure it out.
> 
> Specifically, this makes it a proper kCFI indirect call when needed (in
> fact, it is nearly impossible to code a kCFI indirect call in asm).
> 
> This was the only callsite that was still calling func()+0 on regular
> indirect functions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I worry this creates a calling gadget, but I don't think it really
counts since it's just converting between two prototypes. Regardless:

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
