Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3C718F14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjEaXkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaXkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:40:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8392812C;
        Wed, 31 May 2023 16:40:51 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba8374001abso190191276.2;
        Wed, 31 May 2023 16:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685576450; x=1688168450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Ip848C4+PX4sdvUZ6qA+ntR4dfPFEEj72E1ynrboE=;
        b=pmbEWlVHe2mnM0kY4kuCc8OnetP493gSGJbXzI0xxIWrd9LL1PS2D18wAYrEiMStCL
         kSECDoiKsGntGM8Qe/H2nkvREyJNry15290+xo6UUF35/UPatbv6uJYbVG75Wk1ONQIB
         AhH3qjpWVy+4GBZzEN8xgxZQj/Tkd9S/nyJOfXlCLlVtdAyGu1P4o2u717AiWZHW+c19
         D9CZ3d2bRgmD/JPI/4xt4fIi70g3/Nf8LyKL9Sezm1/8Wh3MZW0c52CUJ3wOBk5cjZHV
         36lw14neIoDR3GRB63G/ON1Kt5h0Y3kUvJYPlfYKlmBByDCkTwVXClzuw4iAC0VK+B4k
         MDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576450; x=1688168450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9Ip848C4+PX4sdvUZ6qA+ntR4dfPFEEj72E1ynrboE=;
        b=Dqg/CBuRzZNuXM0AHkq6DrY+YB35Cz9c2FpxH1axsu4GSRcik6bwNVJaUH9JvdX3wW
         if5cZ/5ApIbMehY4J1C6sNAcDVITHelMmLZky/f27f9Xs396/L4FCA/WMkMARVdC/L1t
         LSqfuL2eXzS2cqI1uvwvjX4Mthi1j/fCh00YuX4HlBPpFkOeModRBo6gdxuyih1xTpwO
         sM+svSWbi+gpii3ygoVq4vbhF2OEU+ybN7GZSBqUerMmTaL9xCTrUDvrKZNUinIYAD1W
         viqyPsVEYieylUxb5vGyqCwvo+uvtOhDB3WUX+GmZT6ouaSMDWuyKd7ZgUInR1b/kE/5
         BEgQ==
X-Gm-Message-State: AC+VfDxOAOs3o10saDSOl4SlpKRG6g97O5m8XYOcJcx6pEbAJxvJ42TL
        5AL1APjvi5rPxUqTcShk/Q8=
X-Google-Smtp-Source: ACHHUZ6hg+BzE3S+Lb8Ii8mZm+C3Ly8o+bGGFHw0M9DuMbORKjj6D6SrCydAYiE87Dhw9g1FQVOWtA==
X-Received: by 2002:a25:be04:0:b0:bab:f4bb:9402 with SMTP id h4-20020a25be04000000b00babf4bb9402mr7628265ybk.46.1685576450666;
        Wed, 31 May 2023 16:40:50 -0700 (PDT)
Received: from localhost ([2405:6581:d4e0:1600:c494:2aca:bc01:6f7b])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001b0358848b0sm1957355plb.161.2023.05.31.16.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 16:40:49 -0700 (PDT)
Date:   Thu, 1 Jun 2023 08:40:47 +0900
From:   Nick Hastings <nicholaschastings@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 1036530@bugs.debian.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZHfa/wQlaVCeUC22@xps>
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps>
 <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com>
 <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com>
 <ZHQhPcKUF76Kplwm@xps>
 <ZHUt9xQKCwCflvVC@xps>
 <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
 <ZHWfMBeAONerAJmd@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHWfMBeAONerAJmd@xps>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Nick Hastings <nicholaschastings@gmail.com> [230530 16:01]:
> 
> * Mario Limonciello <mario.limonciello@amd.com> [230530 13:00]:
<snip>
> > As you're actually loading nouveau, can you please try nouveau.runpm=0 on
> > the kernel command line?
> 
> I'm not intentionally loading it. This machine also has intel graphics
> which is what I prefer. Checking my
> /etc/modprobe.d/blacklist-nvidia-nouveau.conf
> I see:
> 
> blacklist nvidia
> blacklist nvidia-drm
> blacklist nvidia-modeset
> blacklist nvidia-uvm
> blacklist ipmi_msghandler
> blacklist ipmi_devintf
> 
> So I thought I had blacklisted it but it seems I did not. Since I do not
> want to use it maybe it is better to check if the lock up occurs with
> nouveau blacklisted. I will try that now.

I blacklisted nouveau and booted into a 6.1 kernel:
% uname -a
Linux xps 6.1.0-9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.27-1 (2023-05-08) x86_64 GNU/Linux

It has been running without problems for nearly two days now:
% uptime
 08:34:48 up 1 day, 16:22,  2 users,  load average: 1.33, 1.26, 1.27

Regards,

Nick.

