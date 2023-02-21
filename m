Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65D869DC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjBUImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjBUImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:42:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC424499
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:42:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z10so1079758ple.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YI26D55PbY+2SCSp5iPpOu79U0JYtHLSGJgmOgWcwA8=;
        b=V8rvDL7dW8XewaoG2VGXiiGBHwFQt9P5ELUng9qqXhfDiTLmShUdblvr++KSB6gMdY
         jJ7soAuCtse6XhJfGTPLCF4osD6hjpbongPx1LWfQvPe1OdQEce9xhd3gdntfFdfj0ek
         460x/8nMco4AJU1d3kozftfKNYnpaeW5VVsfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YI26D55PbY+2SCSp5iPpOu79U0JYtHLSGJgmOgWcwA8=;
        b=s9SrlHO/qGus4FwS6249LB+hd4BKoXAsMIpxd613NNVzRTyEmtbl18CDKD+ZfN6zGb
         DhsLumC0JAQja+TuNgi1c5gt8UxNfQp3eNBeRsPeB4EtVYw6PaYgXkK5qYdyAdh6o5/H
         5q2yFYg/FHMGVZSPdQYq2kva+hu0ZfUIF4nPqbMgHHdw6FfNxyuroY+ddhOVP4gZKqQa
         fpygwkqc7thAaAIT03+XTNz/7npysg/y9GX1JLgVpW3QaR0Gt5dKmaC+4JlBSPOSy+/Y
         vE7dDNT6WsD1KkOXOQi9uCupaTg5TXE4Pee+lcK5Lf2yRBSYlobAA25gzWSd8L9JDHAb
         k6fA==
X-Gm-Message-State: AO0yUKVol8LO1as9VNid/Mc2nrCZUBH+ERm/DnFspGs1cVyI3UNtaWxx
        ykbnTPT7mlgPshsyr1Hjnh9C7HuWhTRS11tB
X-Google-Smtp-Source: AK7set9OPsdHcq7FyxraFnhYRp+TrSDptPkOScDdeBBLlOOEAeB6y+e1VJE5qWP4SorqOB0IwxnEew==
X-Received: by 2002:a17:90b:1bca:b0:230:e771:e1b0 with SMTP id oa10-20020a17090b1bca00b00230e771e1b0mr5985136pjb.28.1676968922432;
        Tue, 21 Feb 2023 00:42:02 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id u4-20020a637904000000b004f22f5297bcsm3364840pgc.67.2023.02.21.00.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 00:42:02 -0800 (PST)
Date:   Tue, 21 Feb 2023 17:41:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Remove orphaned CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT
Message-ID: <Y/SD1smG/0eB9eJ/@google.com>
References: <5c19e248-1b6b-330c-7c4c-a824688daefe@tuyoix.net>
 <87r0ujs9id.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0ujs9id.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/21 09:39), John Ogness wrote:
> (Added the rest of the printk team CC.)
> 
> On 2023-02-20, Marc Aurèle La France <tsi@tuyoix.net> wrote:
> > After 93d102f094be9beab28e5afb656c188b16a3793b "printk: remove safe buffers",
> > CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT is no longer useful.  Remove it.
> >
> > This change is not eligible for stable@.
> >
> > Please Reply-To-All.
> >
> > Marc.
> >
> > Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
