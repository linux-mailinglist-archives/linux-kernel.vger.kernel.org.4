Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1276F4009
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEBJYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:24:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8599D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:23:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3062db220a3so1225311f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1683019437; x=1685611437;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPQ+I02M2Wh0nyZ6SBeHE4F+/b7hBFlIk7+0/isVN/4=;
        b=DaDBrBy5OTJ9rKXdMreBf3UswRW7Q9dli05QjI65HOAE7/XYwd89Zo5eMvMaRB0rZj
         j8EcYH78qwyYQ7YWWtjsu3ckMh+qLU/1KGbhSe3gjG/L8Yww77UCwNQ3scegS1CxdSPC
         02l6fhPmUsl6NnzUWFch+GKeqgsh40U2CgM7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683019437; x=1685611437;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPQ+I02M2Wh0nyZ6SBeHE4F+/b7hBFlIk7+0/isVN/4=;
        b=Rul2K7sMnAvC9Ni6ldRonPh+eXa1H/vsUqgyh6jxp82fjrC8fcnYVxE30gDSz1lmv7
         RHMQWwDvmK5kvGZVjkTTkrT0nxwxK9z2PUIVuKU8tNk+HnBh/OTLWClLA9Mxm1B6B2eF
         +kZhZ3euYhEGM+ShIrg/RAi6XECQdpgA6+pJ0yvy2YwwkSe/QoHYYuQRGzbtOuXHAOjM
         K7b8Np3ybrP3B/+pQdRzSFR9wWOyHvs6gywlisNJiVnBf8V6bQ2xB5mbiZjexRa1VYXI
         Aho43DFSnNL0n8RHvyHwL/xoslbV2FZLTP6+PmLDwQcKildbdVepzQIDu+Pe8dGB4j2Z
         fQlA==
X-Gm-Message-State: AC+VfDwWVsKFqIRWqXJPQY2cLwbijEIQ5FqpSHTEe16ku3S6WEniaF97
        SaqEjC/DKty8nvGoH7xF+dJN3g==
X-Google-Smtp-Source: ACHHUZ7EAQprDIPdbYv0+8b4Fzc4jpLZEmePL6HPVCd0PC1DNernb4NfvvKgYEOk9NNOnGQgiRAnug==
X-Received: by 2002:a05:6000:11c5:b0:2f5:83a8:a9a9 with SMTP id i5-20020a05600011c500b002f583a8a9a9mr11132749wrx.16.1683019437226;
        Tue, 02 May 2023 02:23:57 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c00d300b003f17eaae2c9sm34986717wmm.1.2023.05.02.02.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 02:23:56 -0700 (PDT)
Date:   Tue, 2 May 2023 10:23:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     calumlikesapplepie@gmail.com
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com,
        mj@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH v5 2/2] printk: console: Remove sysrq exception
Message-ID: <ZFDWrNRvJoJQeC91@chrisdown.name>
References: <cover.1682427812.git.chris@chrisdown.name>
 <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
 <ZEp9dXwHCYNPidjC@alley>
 <9531fc38cfebb5b4587967f6ec73d983fd9325ce.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9531fc38cfebb5b4587967f6ec73d983fd9325ce.camel@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Calum,

This patch is almost at completion and already changes the way kernel.printk 
works. I'm sure we'd all be happy to look at proposed changes in another 
patchset, but I'm not likely to add more changes to this one. In general, 
there's plenty of historical baggage in printk space, but changing it requires 
careful thought about API/ABI compatibility, new designs, and compatibility.

Thanks,

Chris
