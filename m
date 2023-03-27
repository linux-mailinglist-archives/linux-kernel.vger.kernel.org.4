Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49F36C9A44
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 05:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC0Dij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0Dig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:38:36 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008573C02
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:38:34 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5419d4c340aso145537937b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 20:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679888314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vcb55Ou7uI2TRw8K+yKQzYFPLlfYdsQrebeh+xvrZrk=;
        b=Xhwelrp33lw+/YO1lHe6aGe5TWTXloyGkabpNRqN3Rk8CUgY/KYfqMUDSfVKflPw0t
         mNoIv+qNdz4blRvRlJbz0MLK7xjInspU76GCYb7f9D2P7+tJV8hEe+lSYE8sJcBsZSeL
         imyV9WdF/HRWUpwfI9nC+y+mj+iwK2+0w6ejoLyGlmvBpVZS+7BvNykj3qTvxNgupjie
         ZG0aSnmkWLi3Gd6RjGDOYqzG8vXo+FC1VK1w/XL7dFQEsYhVri9ECcW5NRHcnTsiy1Y1
         UD0PRb560xNPrxfy/0xRPMXZ4HJbJuuDsSckcNbKA7k9NV0WpBtFwKEKbijtBJIru4gn
         810w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679888314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcb55Ou7uI2TRw8K+yKQzYFPLlfYdsQrebeh+xvrZrk=;
        b=Uth1akBpAAAIpBOIyVX3TP149rlRb0EfqB3eGGfIj3iL5N0eqDlBUUN76JrPLSbuhx
         QSih7xQEJHCtBwekCwKRNV3cE+0C/VCVW6hVX5qHsEScKT2M8VnXvdvSHVqtqKCo27iU
         Vdg2nglEo7erBCeyI0K6iTaiZbuc+hAwlYtKobwtcZ0txqLYGFRX3edU5r9x7YypB4v9
         JtDMr7n/BCQ3CEC3jHAn2C/d35sJV7A7PuX+QBRNUQorqCYBBn4xBDvjlSgPyiABiJ6/
         sSXyrAmLcEx/ZMy1CuLoow4MVQu0HwglOlyuHvxxpUFyd5O4eF0vXRSTC//orWkVonN2
         2YQA==
X-Gm-Message-State: AAQBX9fXsQ4DfuUyCfZbyhJA1HHOkt9xzVXSnzSOiETO9VHebv1v0abe
        4xbSO+GqeEFboNCiovIoUXHjgCrIryU=
X-Google-Smtp-Source: AKy350avJPFQFYmD6EmuUCIoUW8XxB61IMu5d6kTftyX2je+OU8n6lyg3gH1+4SzJhFV0KoUkWu6Dg==
X-Received: by 2002:a0d:d94a:0:b0:544:b871:bcb0 with SMTP id b71-20020a0dd94a000000b00544b871bcb0mr9498263ywe.12.1679888314191;
        Sun, 26 Mar 2023 20:38:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 192-20020a810fc9000000b00545c373f7c0sm963988ywp.139.2023.03.26.20.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 20:38:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 26 Mar 2023 20:38:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com
Subject: Re: Change of behaviour when console=null and ttynull driver is used
Message-ID: <ccf51347-d00e-43cf-9d6f-1a3190a87e14@roeck-us.net>
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <ZBRiRu7hlwxSKHBg@alley>
 <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
 <ZB281JxlZtKSkJoJ@alley>
 <CAHk-=wheQYsUiKmJnqR3qGrjjh8z7b2ov4rZzHLHJS+VJT9aLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wheQYsUiKmJnqR3qGrjjh8z7b2ov4rZzHLHJS+VJT9aLQ@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 04:20:16PM -0700, Linus Torvalds wrote:
> On Fri, Mar 24, 2023 at 8:08 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > I need an advice whether to revert the commit 3cffa06aeef7ece30f
> > ("printk/console: Allow to disable console output by using
> > console="" or console=null").
> 
> I think it's too late to revert it by now. It sounds like people who
> were affected are either chrome developers that already changed their
> setup, or embedded people who similarly have already reacted to it.
> 

Autually, our (non-)solution was to revert the patches in question in
all ChromeOS branches.

> This went into 5.11, it's ancient history by now, so reverting it
> would likely just cause more issues.
> 
Agreed. Maybe we'll find a better solution at some point, but for now
we'll just keep the reverts in ChromeOS.

Guenter
