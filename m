Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490DA604B32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiJSPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiJSPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:23:55 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC6159A3C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:17:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h203so14743200iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lR37deZKNU5Be7h3TBsGdgcjlJNR46E/i6VUguoyMGE=;
        b=fpWRUuz0qeQwE/crI8+Z1+LKSJEVutrlKCAzgevYCuouLZnyGQAJghMwNjLr3dvpi/
         9HHgC+/4WGc3sKCltcR6yGfmpjcnAYIFBx4+9wsGikuYr7F8jO1kvfn9IvegxPLJWlqk
         Y3ps8Er6jvLYGTf1gsCtYHRBIOg/ADo7N/0HjsI++HU6YlGX2Z92IivEu9OYBVsuspSf
         gVmUbCbdIFOHi1xAyCiE9Up5PQPV179M7svUESyrWfuQksfN8RQDBujtoYX/Bbscm8o8
         R6Coz/GBl34ryBtmUIQs//oW2DsJBuKMJGfzH8H14w4EYR16Diz6dx9cIzY4ixDtDZlZ
         svCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR37deZKNU5Be7h3TBsGdgcjlJNR46E/i6VUguoyMGE=;
        b=as2H1rIxRzom4DPjndCZFC+fXMSyy0TXG4dXRxwxEqxvfmQP/kYh+Gm8O1DWkChXrP
         WEOY5OdV1UxG3wgWkh9Ta/Js1IrHkE0DW0aLLEoOzuN2S+7zBLmMpSuzBxITbLA2xwZZ
         dD5jdL134gcSf0UY7XWQNK5VxABF7zXXi22mCt+aDC+lIyxhb4wvi160xA8+uWLKJZjA
         RQHRgQf6KhKaass2gRL7o3MGXMu4wBmyYIzOyIsjq2/tVhjEr3a0LvfEV9hJ8YlVKMWN
         Wteglt2DdDojZ2nNk5VJSn6nFskAdZufoap4bMd4UEQws7A/NlnEeBCIG0gcxv13B0pa
         o4og==
X-Gm-Message-State: ACrzQf3tyuHi/LVz9my3blYxf2389PFYj40IOO72hJJLYji4bDuAKBgk
        BfytusgHsHMvGqqHR2bFk7yxccsml3r9Rry2SWLeT8wx8Vs=
X-Google-Smtp-Source: AMsMyM4AjU19OWGElpPwLkd4fL/Nm7vYRHpJ49AZEOLMnGtrix9QpITCEoX8rwjRZrzIhCp4tSA+OlOVgx+INbKZhd4=
X-Received: by 2002:a05:6638:4113:b0:363:f47e:7efd with SMTP id
 ay19-20020a056638411300b00363f47e7efdmr7053834jab.264.1666192623084; Wed, 19
 Oct 2022 08:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de> <20221019145600.1282823-4-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-4-john.ogness@linutronix.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Oct 2022 17:16:48 +0200
Message-ID: <CANiq72mu-NQG=Ufs4Cc2baj7EzJr9jSt2t-Dkbs0-kVxm_p8ew@mail.gmail.com>
Subject: Re: [PATCH printk v2 03/38] printk: Prepare for SRCU console list protection
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 4:56 PM John Ogness <john.ogness@linutronix.de> wrote:
>
>  .clang-format           |  1 +

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
