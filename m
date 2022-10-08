Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968E65F8517
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJHLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 07:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:49:07 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC744F69D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 04:49:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x13so1792012qkg.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei9aPoTjAFXtz7ySkdPtJBjwdA7Np2ZW0Z506IUrl/Y=;
        b=NM//rUNuBpWNdqTDE1r/6bln9Ou3lkFmb31SRWJO8E6gmn2amnmQonFybF7IQJebat
         3v2vFnewU527o0CR1al2r0fRdXsoiJdC8z9nyLwv6CyqTkxVFb9xrCZJr5ZeKhybqPWZ
         GaWhWfjVbkGuV9aHJuCc7qXwvkoSFYM1EyM8ze7T3bQEN+CtBAYS20dyhuI4EQ3G5Bfx
         3iy1xXwkO642+c2FPc8CZDgp+Wegb/LoraSigXYOXRLOUInlwKepkgCtrAmaF+VAbwuT
         KHUAFTp+xYO3424TmdzS5vhwYB+M4t56U8x2CCDVGqJkHexQQKVPw2l83FqKSpTqdDhK
         ZuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ei9aPoTjAFXtz7ySkdPtJBjwdA7Np2ZW0Z506IUrl/Y=;
        b=1u+axwPASI9ApWCao4Q7VkKXyYgF6A7W3hDRfUGEyMPHkEL7J2iXSNk/UwZ2WjHnFj
         uSqVgHMv0wooIdtQzBoUW4TGrJM3yuY1biCJE17wUC7Oa/hJzY4rrPbIfWZ4a692C3Xb
         tByTCpRHaRIZ/CtK7ZHQUie2A9qiASUeqtkakc83FnEBmkre28vhR4+hJYuSUdUB5vQN
         LKUNRzIwo26PhE6f0dW6NFOJ8JFRipNe/cPINDOZmcxu6pc1f3k84HjCXYZlrR7opxkE
         cK1LQzroxncQnUWzctB2bO/I3TIGkofo1jj/0piAny9M5yFnxV6u/azTtpD1wnEab7Dg
         dhOQ==
X-Gm-Message-State: ACrzQf30v2oRQknbIM4UvQ1KUwuvItJZ6U4ZmLPVgvc+fvOxkIfsLhRZ
        Z5v2SuJjqRcM6bdRQsVAa/Vka1TVcQ==
X-Google-Smtp-Source: AMsMyM7aJ+sdGXP5JBDH2sX+xn98tk34jx4U8BCngNe+k17V8QX2GnRHhdXRoW4aeN9glGYKcUwl5A==
X-Received: by 2002:a05:620a:1272:b0:6cd:f04f:f114 with SMTP id b18-20020a05620a127200b006cdf04ff114mr6780664qkl.581.1665229745476;
        Sat, 08 Oct 2022 04:49:05 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id bv12-20020a05622a0a0c00b00393c2067ca6sm4217905qtb.16.2022.10.08.04.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 04:49:04 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8d1e:92ef:1fae:f206])
        by serve.minyard.net (Postfix) with ESMTPSA id 93ED1180015;
        Sat,  8 Oct 2022 11:49:03 +0000 (UTC)
Date:   Sat, 8 Oct 2022 06:49:02 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev
Subject: Re: [PATCH 1/3] ipmi: fix msg stack when IPMI is disconnected
Message-ID: <Y0FjriRusk0H4Fxp@minyard.net>
Reply-To: minyard@acm.org
References: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
 <20221007092617.87597-2-zhangyuchen.lcr@bytedance.com>
 <Y0CBbRqGPDU3g9hQ@minyard.net>
 <28367829-10e1-1a74-5572-ba01b8f8b716@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28367829-10e1-1a74-5572-ba01b8f8b716@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 09:36:16AM +0800, Yuchen Zhang wrote:
> > Also, the following is in start_kcs_transaction():
> > 
> > 	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
> > 		dev_warn(kcs->io->dev, "KCS in invalid state %d\n", kcs->state);
> > 		return IPMI_NOT_IN_MY_STATE_ERR;
> > 	}
> > 
> > You probably need to remove the (kcs->state != KCS_HOSED) part of this
> > now.  Would you agree?
> > 
> > -corey
> > 
> I agree. KCS_HOSED state should be an invalid state.

Can you make this change, run a quick test, and re-submit this one
patch?  With that, I can include this.

Thanks,

-corey
