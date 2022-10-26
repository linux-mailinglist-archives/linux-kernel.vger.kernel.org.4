Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6865D60D8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJZBSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiJZBR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:17:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13D0C34CF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 18:17:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h2so7217613pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0R/zuogst9d/iMbwGJahqQyG29x6cKUoOmr+NFwHscw=;
        b=CI1yQ/YQ/tnZzmgve848XpigUhg8RfAlohpGXwTPlL1rtvw+cEuQkOOqNoe4cJ5Nmn
         wOKRSCOiCCIJxQdierMy2Bb+V59SGh4lVxTYrVx6LTmEqWGsLsTEPDReqGvaXHfBZ4sN
         QjhppDIvzcNeXJ+GjtJhhSM5sKqXtbq8P7Iis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R/zuogst9d/iMbwGJahqQyG29x6cKUoOmr+NFwHscw=;
        b=6MT97Ax1v6yGff65ha4O9Vr7qm/mT/KvWe1WDTKSBZxtfmKrkdx/bU1V9SkEEOddQZ
         nAVnaxXEi4HwiTW4Y+tl9/VSL8DgZiawBaC1JRpKgbnO+KByjivP7SanpB+oR6vl/ADX
         eJfbdIPhZgmzmNKDQ/yFtbDwGJdhQubjnXn4S5WS8rR14QCUvFgYKeaheQQOkn82WnsE
         Z184N0BNVu9aCsLrMdu+zngnpjRJkuslomaadJfTOaWpehC2+Vnus/+YK5UlEI3tMWV0
         oWlYsM/crN0+yZ0OCTvc6nw8f9Y02Yyk2a/RlytTLmyz6VLPtQs9F8hKzr5WZoq7NsPr
         x+sA==
X-Gm-Message-State: ACrzQf12Y0k1UbXNzm1Ua9ohp+kc6Cb11+fQMJZ6PiAzpOkImbXNZNnf
        IA/E32qxNApZyCY2tJFkyzEMOQ==
X-Google-Smtp-Source: AMsMyM7Xro5ZU7+jhnQa/JNPDsQcNW9Uc99cbnu1rLZvco3Ob13wL1U0NxHdZxNRbtzgHPEN4QT4qQ==
X-Received: by 2002:a05:6a00:348b:b0:56c:35fb:8dab with SMTP id cp11-20020a056a00348b00b0056c35fb8dabmr4070124pfb.13.1666747071125;
        Tue, 25 Oct 2022 18:17:51 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:faf6:e503:6cac:3b53])
        by smtp.gmail.com with ESMTPSA id j18-20020a634a52000000b0042988a04bfdsm1840383pgl.9.2022.10.25.18.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 18:17:50 -0700 (PDT)
Date:   Wed, 26 Oct 2022 10:17:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     wangkailong@jari.cn
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        roman.gushchin@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] ext4: replace ternary operator with min()
Message-ID: <Y1iKuYLba/hingnG@google.com>
References: <5036013e.4.1840fa09d42.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5036013e.4.1840fa09d42.Coremail.wangkailong@jari.cn>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 22:51), wangkailong@jari.cn wrote:
[..]
> @@ -879,7 +879,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
>  
>  		err = oplock_break_pending(brk_opinfo, req_op_level);
>  		if (err)
> -			return err < 0 ? err : 0;
> +			return min(err, 0);
>  
>  		if (brk_opinfo->open_trunc) {
>  			/*
> @@ -913,7 +913,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
>  	} else {
>  		err = oplock_break_pending(brk_opinfo, req_op_level);
>  		if (err)
> -			return err < 0 ? err : 0;
> +			return min(err, 0);

Honestly, I don't know. My personal preference would be to keep it as is.
"return min(err, 0)" is a bit unusually looking code. Just my 2 cents.
