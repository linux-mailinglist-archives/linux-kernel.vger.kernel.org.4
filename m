Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA986CB339
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjC1BhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjC1Bgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:36:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D44211E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:36:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x15so9432993pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679967407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5rU1zAjYFSwcXFX5d8wsUybaO2I96ZSpOzEekLgzi0=;
        b=G+ns6DDry4Sxh4Z7vBZneZxdbhi8GEqoznGQ4iK5W0VmFZ7iCCZWuo6KArpI0uPNHB
         mNFhdwhwF2v0h1N4JXQvJI76Cq1EWwPQwAlp4tzGVncesuV7Dvv4+zPHrw8v5hLqeLr6
         EDJC8wajzKzkfFfNzFOLKDf7osQeQvZb8L3Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5rU1zAjYFSwcXFX5d8wsUybaO2I96ZSpOzEekLgzi0=;
        b=gpoyP5oWFzVC3vnFLMQ9rUfaXaXa4WRQX2SHVwm1smPXVKe/bKdHil86lU19HMVKhg
         hYsP+Nigx6PTWZ9UKz355j4g6aHw1rl8MjHfVT0njibbpFLQIWusGSIQWTFWI6Lw15Q5
         8jIq4wRvD+ZLiSFvv4XSK/ccl+2yn69Q/49K1HQJb7rTukC5ufPLMxITdrbbo6ajb2S5
         gKdSVfNfwBG6loljBELs4pWgdWXxLezIV0iwGypXQNWqwBdPC6HdJHRCO+/n6cYJ2swR
         VqVu6H8t5+2qIk1lXwI0OVYC8QZg0Co6zyB/sbNiilrimkT1WYMzmH9RjcjasPynLT3v
         Lu/Q==
X-Gm-Message-State: AO0yUKUnoi6jOXNPYb64wULjvpdVgSzHX7/0EEBbItzgBzyE5WDaiU27
        RmTnSDWbR5U+mMnMhp5utNrBlw==
X-Google-Smtp-Source: AK7set96wrGuMuK64ITHlX0P+riOYFt/IqB1B2TIaWdtTGxPf6v1+7wTq3EWl21LSp2yaFzr+mzP+g==
X-Received: by 2002:a05:6a20:4890:b0:da:90e5:fc17 with SMTP id fo16-20020a056a20489000b000da90e5fc17mr12543194pzb.13.1679967406994;
        Mon, 27 Mar 2023 18:36:46 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id w11-20020a63474b000000b005134fc049d7sm3034063pgk.31.2023.03.27.18.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 18:36:46 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:36:42 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] lib/vsprintf: Use isodigit() for the octal number
 check
Message-ID: <20230328013642.GF3269998@google.com>
References: <20230327142721.48378-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327142721.48378-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/27 17:27), Andy Shevchenko wrote:
> 
> Use isodigit() to test the octal number instead of homegrown approach.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
