Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5939C69FDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBVV10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBVV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:27:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76524391F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:27:23 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id d10so1444828pgt.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTTPkpp8HiEDZfin9IXmA/ivbYPnpkr3GltvteYe5Ic=;
        b=OY0nLNi548oPHpKpzfOspnlIb0GAb5kMphdhpyLClWJ0I3sCl7pWw3CLSNyzW9W3eA
         FMySXA5wh3kKCqKJmKuiTjobqS/7Hg/yKifOWfT1tpawy96n5A9YfGxBZMpq75zUcEEB
         v3oMoXYzMulv+Kv0FAv465kLC8UB2O9Z/OJ8kVJajiFUuLZelmTpVw4aPirysT1edKL/
         pz8LCudDDc0sC0qnyw25mB4Iml9v/i/FPBtVGRIHvzzv3J1Wu+qbdhhH/2ol6ykOBkZR
         CUIz2F0SiyhZOFsTQ5M+7kzvW1jK3SMqxXmAlZujYXSnB6p/pHLv3sXbki/hptPvNYuV
         Td7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTTPkpp8HiEDZfin9IXmA/ivbYPnpkr3GltvteYe5Ic=;
        b=JFCIsyhmoqyUOa6A7mG7hW0sKlDzquWwuX/PE/+/0dplla8OyrnIHXMUdF0CcHq/c6
         LggvvDvpl6FiQGHbvbOATh4TX5WxlnaTzUHuzOSAbMClzU3pBkuZL4uuTCT4wRP1VqPV
         8cDlHRzjD8sETNxZQk4biJmvVpAjXrDq91T3V6ysmFjQQiICPxo4Jdfg+p9EiWlv5f+z
         9p5CFwPuUzPWcQe86WgbRP947UbBp7aQ03uW4opOvYUpgjbqFyS5EHvmgE+0BlYqffmS
         YZ9aSgjYgrr2ALxhclc516eHygLWoyvEsP4WiNeae18MFG4d8sKpmJY8x5SCECmbBnQX
         NEIA==
X-Gm-Message-State: AO0yUKXCEv+jgAaq0ZgZi7+/bgAT0vgPejx82nFlN3gCSKniVsjBGt2+
        cHlpjbfoWG3dhFBo/8YSF/QPyu5dBLVhaA==
X-Google-Smtp-Source: AK7set9ZZEJgNaG5IeCRPfBRxSBDWkzFtylZ7vm2qLu65zcaf05II6bf0CTwIj2CuRXH1vMofEUG7Q==
X-Received: by 2002:a62:4e8e:0:b0:5d6:4ef8:8c6f with SMTP id c136-20020a624e8e000000b005d64ef88c6fmr2532880pfb.34.1677101242966;
        Wed, 22 Feb 2023 13:27:22 -0800 (PST)
Received: from thinkstation.cmpxchg8b.net ([76.133.164.192])
        by smtp.gmail.com with ESMTPSA id p10-20020a62ab0a000000b005a8a9950363sm6942239pff.105.2023.02.22.13.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:26:58 -0800 (PST)
Date:   Wed, 22 Feb 2023 13:26:37 -0800
From:   Tavis Ormandy <taviso@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/aIjUr78yd9U+wl@thinkstation.cmpxchg8b.net>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic>
 <Y/Xc+yMzI83WZ4V1@zn.tnic>
 <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com>
 <Y/Xp73KJe3c/1jrn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Xp73KJe3c/1jrn@zn.tnic>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 11:09:51AM +0100, Borislav Petkov wrote:
> On Wed, Feb 22, 2023 at 09:38:09AM +0000, Andrew Cooper wrote:
> > This sounds suspiciously like an errata which was fixed with a ucode
> > update last year.
> 
> Yes, it looks like it.
> 
> Alternatively, you can try booting with "clearcpuid=xsaves" - that
> should take care of your observation too but yeah, you should rather
> update your microcode.
> 

Thanks - confirmed, it *doesn't* repro with 0x8301055, but does repro
with 0x830104d.

Annoyingly, I thought I was using the most recent microcode, but it seems
like there is some bug and debian wasn't applying it at boot.

That seems like a scary errata :-/

Tavis.

-- 
 _o)            $ lynx lock.cmpxchg8b.com
 /\\  _o)  _o)  $ finger taviso@sdf.org
_\_V _( ) _( )  @taviso
