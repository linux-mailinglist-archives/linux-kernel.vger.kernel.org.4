Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAABB5B4F94
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIKPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIKPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:12:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6C11822
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 08:12:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x1so6275416plv.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZcxumOMOxR8h0dhZ+ethDLl0FdJsx3OvZDg1SpCAq40=;
        b=a9W9mPQvUBOCJ+6Ik7k6JVXho46WN0XWo71pLbJ2u2kRHcsG/UqFFXkJuKDqyZNP5i
         eQb+/xp0SaGZXLSonyMFmGHso66NzbP3lWnNvONotX7P2v0aKul4tURdbxP2gzWgCQMM
         TSUE07wKNc4hZhsu8rzzzSOeCUmqNZaQEaw/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZcxumOMOxR8h0dhZ+ethDLl0FdJsx3OvZDg1SpCAq40=;
        b=5t0eQqj7R8V1HOJ0a479muYduAQau1gt+T0gV3BjlRM+AneGQ/gos9VBsa+PnjNfVm
         Pxgxt8mQ8uPmyS4yxsg3UkBqhzqoY2En7YZv4X+3D1OWGsPZ5S5UtvqWSv2MRDDBqYk1
         +4Km+kgtnd5ffPIVPtFjS1JqKZMLRPLXZxAqq7P2HtmjAl/7CiKIlSMUZRCBn+mR4zja
         Ni+D5IMHq+vEMRuAozcpp4p9C66XBKsRD1VKVOPNQIBDWCef2IGwVo6bWD3RbgW49pfC
         baFiT10fwTM/wBt9DVPyG9EY6X+F0GACaCcFLmv6UjL9H3DyOKo7KXNCUsfgNMRhRHbP
         IFrw==
X-Gm-Message-State: ACgBeo284K44eoJSdpPgTJZ54Kzd7HnSNOUzLo8dMP+3+55dVgDNSwTR
        9W46HFO8t56YOMb1wCj8ODGPbQ==
X-Google-Smtp-Source: AA6agR75NLnh0FEwXwA71OEbUMCL2lUEwtoOwNyM6CP2+MC20LBiQKeC846IXaZpTvD7Ul9Zk2yZLQ==
X-Received: by 2002:a17:90b:4a43:b0:202:7706:73d7 with SMTP id lb3-20020a17090b4a4300b00202770673d7mr16015103pjb.137.1662909156997;
        Sun, 11 Sep 2022 08:12:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i29-20020aa796fd000000b00538056de6ecsm3464959pfq.52.2022.09.11.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 08:12:36 -0700 (PDT)
Date:   Sun, 11 Sep 2022 08:12:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
Message-ID: <202209110810.F7352A26@keescook>
References: <YxAq2jYvGG8QOypu@gmail.com>
 <87czcfhsme.fsf@email.froward.int.ebiederm.org>
 <bdff6cf478fc29c80997a623a57dae5f@ispras.ru>
 <874jxkcfoa.fsf@email.froward.int.ebiederm.org>
 <da95e333b4c508ddf8130f8f2d2cbb92@ispras.ru>
 <YxjRx3+MipdFOudw@gmail.com>
 <20220908081003.sjuerd5wiyge4jos@wittgenstein>
 <87v8pxa51n.fsf@email.froward.int.ebiederm.org>
 <20220909075158.ed4linrpwwabxabl@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909075158.ed4linrpwwabxabl@wittgenstein>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 09:51:58AM +0200, Christian Brauner wrote:
> As stated above the proposed exec behavior we currently clearly emulate
> in userspace. So that part is fine.

It's not clear to me yet what the right solution is from this thread so
far... what's needed for v6.0 release (since we're quickly running out
of release candidates)?

-- 
Kees Cook
