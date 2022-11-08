Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B95621A58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiKHRWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiKHRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:22:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD02634
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:22:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g62so14379022pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMk4PVCi8MpYMDkTe7xjdobh7931rVJKCrHxnRJEZ/s=;
        b=hH8t9+Espo0GrgedJ9kMDPtH/SwZJLvzS42Mpnzj25bSeGNKWC/KhRsX+Bk5RGBoYh
         GS89jcjEhdmZQCZmsXftPjQPRRk67Sp6/5ZHG3Enccq5LOmxhTx1Wil+jM384G6zHYUE
         HEAuY+LA8P/URl4U6jup79JIboPvC9ydZMpHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMk4PVCi8MpYMDkTe7xjdobh7931rVJKCrHxnRJEZ/s=;
        b=049WYBHR/03fOpP2OS8v8D4O8ffMpCTcikSS5FRRD8gYVtATWriz0o3R3wiAP3w82h
         aI5bA0NnWo231rBvum2rGCsiGC1LCCQrWHMtvM1LRucG4uBHF0gxyMJW4OPjEsXL7clx
         yV3FbxYp1mBEncf49geRX9/fmx4aFD9s3J5+K3bp3nuynzlx04r0mdlBzZMXUGTmxL0D
         3a4iM9POYj+IQDF8hNIuRGvWWQw+G3oB7vXT+AVgep76SgXTgRJUZ11uPiyY6nlPiuqJ
         mDo5jh3O5T9YcyLCmSZb+Qxy96+2+pWlkzlZ11IuouFHZ/tprjRz9CIJBaG6pCq/jh2H
         Bs5w==
X-Gm-Message-State: ACrzQf07bKeXSjXruc4TL7ZUEk4maSAdem8FeXWN3lVDxBh4DUxVlcxP
        qe/wEoziSI7TcVFN6KD+UVpXmPtfwsgbwg==
X-Google-Smtp-Source: AMsMyM4Ab4Kr0QUaf2x7BxJa/AITAVTNdya0GPA8aZCXQG+csEC+UsBcfir62wN3+d9ly4DUl+wEDQ==
X-Received: by 2002:a05:6a02:282:b0:439:7a97:ccd with SMTP id bk2-20020a056a02028200b004397a970ccdmr49560686pgb.297.1667928168583;
        Tue, 08 Nov 2022 09:22:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001869394a372sm7241421pla.201.2022.11.08.09.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:22:47 -0800 (PST)
Date:   Tue, 8 Nov 2022 09:22:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
Message-ID: <202211080922.8B4A9A16AA@keescook>
References: <20221107201317.324457-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107201317.324457-1-jannh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:13:17PM +0100, Jann Horn wrote:
> @Kees should this go through your tree? (After waiting a while for
> the inevitable bikeshedding on whether the default limit should be closer
> to 10000 or 2^31.)

Sure, yeah. I can take it.

-- 
Kees Cook
