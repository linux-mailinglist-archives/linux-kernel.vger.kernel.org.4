Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF4F603931
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJSFWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJSFWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:22:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AE066A48
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:22:17 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f193so15301910pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kocDQ41ihAmuitVzJ8xQdE5x90nQK2sICAXeOnZPLSQ=;
        b=RmEWoRp0+cDaWIbo/cphJykhD1S6AqS84Ma7HrzQ0odFa8sWCzNhbYHoMBRzAieW44
         CJ0Y/TgQQKvTrx6hFj5shpn6frYhXmAmteT11Q3kooPAfAO6jlTBkuUhmAIU+vFIpR8J
         QFGhYYKvWyEfcFettM3Dho2p+n35NQs+lBciA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kocDQ41ihAmuitVzJ8xQdE5x90nQK2sICAXeOnZPLSQ=;
        b=M5Bqx5ABBHFmW2iNx3lD2oQJ8pTlaAJ5MUZP5R3cqH9AUvmX17sY/AeaXfgtLDV+r9
         Mjwdj4SAz8Z7DVYf0sXFqJ/AojQJm40p+j0Mf+5Giyy09zXGnI6TvtesOqhcXZatnypK
         Rwr6XwAz5jyetLP6/RYaUU1KurJKeo/+29Y+rSllReAiYneH6JSe3LTMmPvm/EaUdVpU
         qkF+693oGad45DqQdTMMs8i9kYnXjkvtA2nCrmSZbswm3+i5yo6Ly+I9iVhSUe03P1Js
         a10TUkz4VK08TpT65Dcm5ZOfrfX2gqcJdo0ZGWc0YWdsco+X86BDAsvxRs56IDuUKMzr
         I77A==
X-Gm-Message-State: ACrzQf0/1rxeHGgwpWhZo0+RPEI8p9YL2jI9WtSDpVRvEbuKz0vWqRNX
        C8KaduamYHr9e19MDvVvQYaQqg==
X-Google-Smtp-Source: AMsMyM5o7a0BMcahASnXPu9B4OXuCkw20NW7qxDGBBgn+3liqYmUZa84x4yA1WCjR3OyDeGAxS41VA==
X-Received: by 2002:a63:1e21:0:b0:43a:b17f:cd13 with SMTP id e33-20020a631e21000000b0043ab17fcd13mr5737681pge.553.1666156937403;
        Tue, 18 Oct 2022 22:22:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id qe2-20020a17090b4f8200b001fde655225fsm1104524pjb.2.2022.10.18.22.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:22:16 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:22:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210182220.B6247EF@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08E9DgGD0lPB85O@hirez.programming.kicks-ass.net>
 <20221018233148.lgoiis2tws7caw3l@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018233148.lgoiis2tws7caw3l@treble>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:31:48PM -0700, Josh Poimboeuf wrote:
> Is there a reason not to default to FineIBT if the hardware supports it?

I think it's a fine default. Given the behavioral differences, though,
I'd like to make it configurable.

> If we're going to give the user choices then my previous rant about
> documentation still applies:
> 
>   https://lkml.kernel.org/lkml/20220503220244.vyz5flk3gg3y6rbw@treble

Totally agreed. I would be happy to pen something if no one else is
interested.

-- 
Kees Cook
