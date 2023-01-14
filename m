Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413F366AA5D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjANJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjANJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:19:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C3F5BBF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:19:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x10so31398684edd.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4wF31Zn0fJ2wO3Kv6MXFyGye9tMen3WH0Ib0Ut7QG4=;
        b=YRF4k2HYYvG9OI+ATjBWOaWvoyaZ4kBfbuYxwZN0MzTb/p4hXAj1ZtUupOJp9CPyaI
         QTbbOKFXeda86cqhM3uqSLcjT5s91zZ9eOEWIIURVNKhFapvtILTvbS7Gf/OvshxyRNx
         NkSTOyg7aXvHna0vQcuoFI35O03QIczhiFVpEgnIGufMcnw8X89eRyZ7NGCbUvRLIaV4
         DG1StSYvF5OEf/AkHHxZcMYCb962BNL4s3P1ArWZooWHNR6bZnJM+zBHs+ntyYg38O0X
         DUk8ydZhegx2uHIgzKTSPDpxdStlQPjA6WVf5ax8QMKdOZRNEyzZ1dOiwjZy3kIajl09
         HQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4wF31Zn0fJ2wO3Kv6MXFyGye9tMen3WH0Ib0Ut7QG4=;
        b=yCH+S/BpQVMvQtU2ieDZLyFmSgKGO4MUKsugyJd1kzQ3ldmnLCzmwIoxqno6jbtOkt
         kGF0zGH/jY57QittqjFXimf/lAm4fFGqKdsZfMvXAv7laEOEatukzVt6GaULRdALSBJ8
         Ko1HY2nwZLlNxGahFrqPzoHTKJ8dbyyGTtjgTdfJmw+wMzszbZAcu1yaElWkEzS2bhQ5
         xzqjdS3jMQEmCZxgzbuNKPLORaYiEF7ziR87f2D46z75thdlY5pIcqENczHsi4kr4AHP
         rCG41/e5UJdICFA3MNzLb5eMySRn0l8Cc0nPGH/wvN4nGW6SYjV57k1B+fD7uVq0+bf9
         zwaQ==
X-Gm-Message-State: AFqh2koT8Ugt19tMImkY7cXtAceV+R1Uv4po2tY+hV9/0U93hmlUt/A7
        INzO+q0HP87upTDJMbsb7BcVBZjdxHM=
X-Google-Smtp-Source: AMrXdXvZlIZcINkvEV7g/Sn6v6dOsDIyKhbiGZckYU/xtjE4MUnOCCztTaU2eCLuF1okggJhuPdY6g==
X-Received: by 2002:a05:6402:291a:b0:48b:c8de:9d1a with SMTP id ee26-20020a056402291a00b0048bc8de9d1amr39739160edb.37.1673687982727;
        Sat, 14 Jan 2023 01:19:42 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id w5-20020a50fa85000000b00491c819d6d2sm9075298edr.44.2023.01.14.01.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 01:19:41 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 14 Jan 2023 10:19:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Daniel Verkamp <dverkamp@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: also disable FSRM if ERMS is disabled
Message-ID: <Y8JzrLuJ0EJRPFGQ@gmail.com>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <1b184587-128d-e5cc-67e9-1d27feb87213@kernel.org>
 <Y7VlZsaWz4/b6Phf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7VlZsaWz4/b6Phf@zn.tnic>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Jan 04, 2023 at 08:43:51AM +0100, Jiri Slaby wrote:
> > Let me resurrect this thread... Our customer has an AMD CPU which has indeed
> > both capabilities under normal circumstances. But they have a cool UEFI BIOS
> > too. They say:
> > 
> > """
> > In AMD platform, while disalbe ERMS(Enhanced Rep MOVSB/STOSB) in UEFI
> > (system setup -> processor -> Enhanced Rep MOVSB/STOSB), the OS can't boot
> > normally.
> 
> Any particular reason they're disabling ERMS?
> 
> What do they set FSRM to?

Nevertheless both Jiri and Daniel are making a valid argument: our x86 
memcpy routines should not behave in an undefined fashion, *regardless* of 
what CPUID environment we are in.

As practice has shown, both on virtual and on bare metal firmware can screw 
things up enough so that the memcpy routines crash under Linux but under no 
other OS...

So while you are technically correct that these are firmware bugs, I'm in 
favor of robustifying our x86 memcpy routines against these bugs. Silently 
not booting, where no other OS fails to boot, is poor form IMO.

Thanks,

	Ingo
