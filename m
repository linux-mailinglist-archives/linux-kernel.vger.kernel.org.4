Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8074F375
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjGKPbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjGKPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:30:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004A10D4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:30:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3331424b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689089457; x=1691681457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AB4WL7G42oNiLPinEF1S7UK/vVdMZYxzgwOZQk/W3rA=;
        b=QfLh8g6zkkjGje4Nkn6oUW4ZaefLRK2HEZ2eZcRtWTEHxCHx9fDBo5/zxCJVY08jWY
         QZLL3KbhGz0XCWbDj7pidjGNtTABQVc2WFXfBcTbD27o71VNLkkjAs1n3CYXRPocZGoL
         xz+iXsBZ9Gja9AHNKU96fBiQgDcDIZtpyQMNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089457; x=1691681457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB4WL7G42oNiLPinEF1S7UK/vVdMZYxzgwOZQk/W3rA=;
        b=ep+gjq7uA+VDyPY+Vtr2ymMya18XVvT37JEkoko7Xk/R5KgfZBimlGS8RCUrJh5kRc
         rD2MeeJdYhY3TwyitiyLP+k9WdLi8DCjPXRD9/3y2oC8IgUqQfn5JEs3gHZPpCgTIfEz
         ivuuksGF7gZfhhlLKJel13vZ3f+ikITLH9WUV+7eX3Ypzs4nKKTMEtvyMObfxtOEzwE9
         qddKuA4hnGOfD0wPJm//D9lAysurA6/0HNKldgKaxBCnlXjkgWZn/IP1+Ujbf/tE189B
         ZbR7LvYTvmUflgPBE1rUTr1IAAP3W4LbSIwkdT6rilBmTrzBDhkeL+XVYoSwGp+HlgVa
         rKrQ==
X-Gm-Message-State: ABy/qLagG7g5s0m6JrS+EIYXqF7BsnA87SdKw8R6kEc066OGHdZOS4JG
        H+FAwG/rPMrgk7fifzRFchdEqg==
X-Google-Smtp-Source: APBJJlELFDJht4fu4ad0o7YpMjcMcQ1iiWzdkUnd3rZjW92oc9wa58jbA1COg5cHc65kt0cigMPguQ==
X-Received: by 2002:a05:6a20:387:b0:12d:53ad:f55a with SMTP id 7-20020a056a20038700b0012d53adf55amr10824701pzt.55.1689089456870;
        Tue, 11 Jul 2023 08:30:56 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id n19-20020aa79053000000b0067b643b814csm1903125pfo.6.2023.07.11.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:30:56 -0700 (PDT)
Date:   Wed, 12 Jul 2023 00:30:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 4/5] printk: Add per-console suspended state
Message-ID: <20230711153052.GF12154@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/10 15:51), John Ogness wrote:
> Currently the global @console_suspended is used to determine if
> consoles are in a suspended state. Its primary purpose is to allow
> usage of the console_lock when suspended without causing console
> printing. It is synchronized by the console_lock.
> 
> Rather than relying on the console_lock to determine suspended
> state, make it an official per-console state that is set within
> console->flags. This allows the state to be queried via SRCU.
> 
> Remove @console_suspended. Console printing will still be avoided
> when suspended because console_is_usable() returns false when
> the new suspended flag is set for that console.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
