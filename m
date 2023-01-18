Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6B672589
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjARRwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjARRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:51:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866A6166F7;
        Wed, 18 Jan 2023 09:51:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id dw9so35141786pjb.5;
        Wed, 18 Jan 2023 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDHhLmw2lvPRQMQgaRkj56iHk7Ag/W9folZLBRgME20=;
        b=YDLYQglZHEuKz6SHX1ePwX/C/6kU4vbUxIK9h7EUAF8eH3+8r1/Uh5CvTvbDegLV9a
         U4fD/1wb+D7MWt6q2SexWzF8lhI/ZLbEvQbeyuQu6/IFCdg/U0xHtc8nIL6b+ZgDyBwh
         8ZCmQcLJzCSp61U31Vq+++sisrvCqbrc1uA4zO7E1vFFO7WAu1u3javjhFE8WNC/ltIi
         CRKhlhpBmh1AFOqVB2aroJTK/pcPNlaStE60w4SP3HKgqO2pWVPy0XZ6ykQk8N9z/4mj
         xl2JdB/Y5BtvNZ3qTTRbPEzC6s8cz6rgWbEko7eXHQ6bdYv4kUmE5+W6vzSPKZahJSq6
         OzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDHhLmw2lvPRQMQgaRkj56iHk7Ag/W9folZLBRgME20=;
        b=1GxKXJqb9YqsxBg6Yw//0mNa/l4vu+Wf/c+wAXVvNCG6vy52B3bnWrGDtWspoLmx3t
         C0CvqDuZdXQUOqm221X+NNsfZ6RlZHwvME1bny6bb9P13FrtsL/PcPlcfkJfhTxYjAso
         UuZDgdWt3n//WtfywS+ELK5qmxnd9oroZVt9MEiQeZzZVfgylYxMe32K8966aBrOWmaI
         C3qMKEaY87M28TGF4z7dPCNlFuhx0Up3+F3Qz89O3LUcM62fpvwxcbWIYlTO+74Sbg8A
         aW5RUrryg09s1uA9/hdGH7ba8x0s7gxktzgTWqpQ3uOtbnpalVXZ52fhfD2+UoSNyJEL
         1QIA==
X-Gm-Message-State: AFqh2krReFAViZwtMu+GwlOBxSuGHWdmEbB2i8pPVX78OXchwj75Ct5F
        Nta7snBDXpzzNMd9x0m64aM=
X-Google-Smtp-Source: AMrXdXuN6G+O8YdCs8FX6bi6FXgFnISkqS3Es9damugwfBKNchWUJMmK3do5quQpYjrpWFoLLYmYkA==
X-Received: by 2002:a17:902:b788:b0:193:3678:dc3e with SMTP id e8-20020a170902b78800b001933678dc3emr6745801pls.21.1674064316961;
        Wed, 18 Jan 2023 09:51:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b00192f4fbdeb5sm9991775ple.102.2023.01.18.09.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:51:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 07:51:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Sandeep Dhavale <dhavale@google.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Add WQ_SCHED_FIFO
Message-ID: <Y8gxu7l8BUWewuMg@slm.duckdns.org>
References: <20230113210703.62107-1-nhuck@google.com>
 <Y8HI+42TxxlJxT6D@slm.duckdns.org>
 <CAJkfWY7vmvrU8sW3OWpSa9zygY=6e8BTTkktPe-VScdOcLL-sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJkfWY7vmvrU8sW3OWpSa9zygY=6e8BTTkktPe-VScdOcLL-sw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 01:00:00PM -0800, Nathan Huckleberry wrote:
> This sounds fine to me. How do you feel about a config flag to change
> the default WQ_HIGHPRI scheduler policy and a sysfs node to update the
> policy per workqueue?

Yeah, sounds fine to me.

Thanks.

-- 
tejun
