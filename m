Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE216099BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJXFWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJXFWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:22:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B5863F09
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:22:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p3so6638641pld.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkglCD++rBAhdxJENjRjV84ieq2zA95yE5d2YHv3MX0=;
        b=JiBw3jcj5dZjnLXiFYmma44ug6rDhKqzzO2PeInT/NL0kLYWKOAomexSB2z1lQL+CA
         c+x19Orgq18ANdKDFm60I4FNtW/2TzibSnc/tCubjhP8rVCWMzti4UMe285iZqliuvl0
         udO1sl4xsvMqikTC7S+p1trak7bUt1GuOZ+BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkglCD++rBAhdxJENjRjV84ieq2zA95yE5d2YHv3MX0=;
        b=W+Dz16YvT5mTAIBMP+oQhNAhRaGu13qfp6TQReuSi54oesmfQ3jga4V4urvEa0Og5p
         veOzafXp7ikCwyDb75pycdPdAlWqZzrby0TkbJit+KnTUuq4KuxdtmqFhr2cOJ0Q6mvB
         snYW/NqmyEOyGyFq8zOi8YT/0R9lZlm+CWv0aLdDY8bYliYd1v+Iwer7OvVO5Uu300rQ
         3Eylk7vLUGfOzFkP86Qxzdwjw42NKoAeePPzP36MMIgkai5JK/0BbPyQG2hwmSvwhYkm
         LYhZytZu+MG+RtzI+ZheaX6TjDX3/uKNJD8uR+24aPOadtiN/tRnt8tF4t5BC7iDnl/s
         NOSg==
X-Gm-Message-State: ACrzQf0VXh7AGXQ8U0qAKh29sDIGGWmQMH1OBxCZkq4uLuC16rBZfGla
        eVvmC4ZCPjiL/57KxfLxma/M7w==
X-Google-Smtp-Source: AMsMyM63AapOxi4cQFnaRsxgJpIJLodlUlAw26IgKyPUf7Uk5QLSRVJ5YYvF7MVj77tlMmuvRTVJqA==
X-Received: by 2002:a17:90b:11d4:b0:212:ee83:481 with SMTP id gv20-20020a17090b11d400b00212ee830481mr9470051pjb.36.1666588934331;
        Sun, 23 Oct 2022 22:22:14 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:7f0e:f6a4:8d85:37e4])
        by smtp.gmail.com with ESMTPSA id y26-20020aa79e1a000000b0056203db46ffsm8571912pfq.172.2022.10.23.22.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 22:22:13 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:22:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v2 01/38] serial: kgdboc: Lock console list in
 probe function
Message-ID: <Y1YhAA9T5edwFnu4@google.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/19 17:01), John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Unprotected list walks are not necessarily safe.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
