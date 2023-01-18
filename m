Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A9670EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjARAs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjARArW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:47:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A6B1A944
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:33:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bj3so30939262pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0iE+dsh4waSmkn1MEyVbCkXwl8Bzu8QOsUC82XsApoo=;
        b=nhX1XkW/QhRJBX0p9KfNqzI69dq97378uAomMfbqO/sUnOOqkekQzxhYY6Wga3nRRB
         CguE7MqJXEndw2rnQ+hpif5cGc86PAgOmYHeP+1gpl3RZ9MD2zZBtrCaSKzZllsq6NCo
         +qNpJNTMZXMoAOgz1lQCJ8Sk6NQZ/d7Bvy+GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iE+dsh4waSmkn1MEyVbCkXwl8Bzu8QOsUC82XsApoo=;
        b=c4of8gLs96XhinTUsJZWos5pICIjE+QBGvFdnTRfcI/rciKubhJIo3n/Dtqtgdmxrs
         hqnPaV2YE3aLBnrlbOIMG8H8Z6Pr/5Np5r/wIXaGShPbHdUdwbYQc/AUCcoMjmgTEfH9
         f+XYzyNP1OVj7veN4ujrPh1PDHpYb7g/ALStw3akCXx7X6CTNJTvkxExK0R+dg2ljuup
         4WFFFoVU8MTDQL59aR+aNjMMrjkVr3K3briqO/D39RCuOOC9FyiNabvUgglhoNisHwJu
         I4N1wGPUMGQJLSXG5Ykd7MKNqKfV10aCPnkg8yRAleBBonEdkyESHM3jEzIF/VfhpwLs
         PGOg==
X-Gm-Message-State: AFqh2krUkvrKibMJJy6as05APCElZxhRmrf2V6kw8rfCI7QN/VgvSEe4
        gnf3807qOVh9BXJWwOdn4b+3Yw==
X-Google-Smtp-Source: AMrXdXvYsJbsaTkJBEfvmMG+FRPz7yazRrczJz1Q9HCXHHXXBn2kbs+qVV7l7BzaEm/PSsJZQAM5sQ==
X-Received: by 2002:a17:90a:5d87:b0:229:1fa9:6912 with SMTP id t7-20020a17090a5d8700b002291fa96912mr4798949pji.39.1674002008279;
        Tue, 17 Jan 2023 16:33:28 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090aeb1700b00219eefe47c7sm122235pjz.47.2023.01.17.16.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:33:27 -0800 (PST)
Date:   Wed, 18 Jan 2023 09:33:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        coverity-bot <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] printk: Use scnprintf() to print the message about the
 dropped messages on a console
Message-ID: <Y8c+UsCjTJP31MzD@google.com>
References: <20230117161031.15499-1-pmladek@suse.com>
 <87r0vsq1cq.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0vsq1cq.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/17 22:54), John Ogness wrote:
> On 2023-01-17, Petr Mladek <pmladek@suse.com> wrote:
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1530570 ("Memory - corruptions")
> > Fixes: c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")
> > Link: https://lore.kernel.org/r/202301131544.D9E804CCD@keescook
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
