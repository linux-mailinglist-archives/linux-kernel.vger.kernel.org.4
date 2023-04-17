Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6A6E4B65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDQOX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDQOXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:23:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CE97
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:23:24 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7606ce9b213so197160839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681741404; x=1684333404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukxG8rL47DXmTEPNEM7X86Ipb6bwPVzrK7cHe2Lb2qs=;
        b=U0ht4vmCGmsB6h4fdiIqMz80pGdKhD5iaf0ag2N2DkkBvo9uLDU9/4pwwgVF9UPhxi
         OQEBsfE9DSdStH5VmMwJgS/tcDRJiW099umYXRYclyr7RHiJDn4l+f/y/s6mgtVpulJm
         lif7M4RUjj6ZMTGLJNnZwqH5n3ECRYGUnNWTfFZMFlH1BpKVpyOQX0u7Fe/YMDi9j/M8
         uY7VHbQRzSKuXGe5jGk/5kOtXyQLua2Z2j+cUjvkRC+qLnrhRQ4M362s3g/T1yo7+FQx
         LlHvmh/R0OyJbfWEvUbhAtSsrLa6vg58rIPkSFu7B2KQmTbw4A/9sE2VZ+GrZeTaEvp5
         K1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681741404; x=1684333404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukxG8rL47DXmTEPNEM7X86Ipb6bwPVzrK7cHe2Lb2qs=;
        b=bnfS3tT2ucbGlZ/9sBKHyFgKuntg3HkeQ++S9nZoqA6i40G8baOVaxvR01y6y2h6/l
         lmekc0a8IfY7vyd7d2iC7UGumFDbwN1qFUfHXXR5d5iGi1xRhkIwh4lIPOjYL3uChjEf
         +Udr3J21+MbI3rktO2ssE0MZlj+wPWiYwjKQZKBSFG8hv0BtSMGI97ZkhNOu9YQTEWUo
         oDje7yF7PJ4/MMN12MVCWUHl505s3gJdvpKsA+8oFLFJPyXxr2q3YDEc/RtQeB1gDIOM
         XLbjELWDkPOj7/4El7BrrIydSM4iA+PNAPQJIBiGwRLbZAkearQ5457AnedOaXSv+pyx
         /V9w==
X-Gm-Message-State: AAQBX9dEODrINZrXeDfiJ/97cw3I6o6s3ZdZeZjAs6KdBp4d8AxygZCn
        6wyeemtzVGUVB9s+7HUzes0nKa6nbG0=
X-Google-Smtp-Source: AKy350aZOj4fIlWX7GiGjElDWc0ee5AJCv0yDfqx3P8JVE9bjxE9fwLV9PGVgo/QNB4QCuGgIW2Fvw==
X-Received: by 2002:a92:d2c8:0:b0:32a:d851:37e6 with SMTP id w8-20020a92d2c8000000b0032ad85137e6mr4932472ilg.32.1681741403726;
        Mon, 17 Apr 2023 07:23:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c39-20020a023f67000000b0040f78e1941dsm2624070jaf.39.2023.04.17.07.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:23:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 17 Apr 2023 07:23:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc7
Message-ID: <dd2e633f-c151-43a2-b9eb-a4c9b6f90e2f@roeck-us.net>
References: <CAHk-=wjwK59PegTZb9r=EVuCPwbigcbbby5AwEboMBgykhL-KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwK59PegTZb9r=EVuCPwbigcbbby5AwEboMBgykhL-KA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 03:38:17PM -0700, Linus Torvalds wrote:
> Really not a lot in here, although there's a late cgroup cpuset fix
> that is a bit more involved than maybe I'd have liked at this point.
> But hey, even that isn't exactly huge.
> 
> Apart from the cgroup thing, it's all pretty normal, with m,ainly
> driver updates (gpu and networking leading the pack as usual, but
> there's block fixes and minor noise elsewhere too), with some arch
> updates, some selftests, and some packaging fixes.
> 
> Let's hope we have just one more calm week, and we'll have had a nice
> uneventful release cycle. Knock wood,
> 

No bad surprise here.

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Guenter
