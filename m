Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0DB640CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiLBR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiLBR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:57:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB80AE4656
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:57:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jl24so5288147plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zY3dCAWELdIR2DelBbTfc6lFEbhpsLzNY6AlazDGnFA=;
        b=TNiqt/Kih3GZx9kIPNTjp3WWf8XyD37VkqSmW43jYzKujZYnrK1+ERI22E/XLgPcI1
         9KU+tO/9rBC8tBzWct1KILEdE4mq/vqJhwdyknhut45/inDh3FwIJmRtdKPD2u7/An81
         1thVoPdfOWFPHrEIuuocM9xjrFIp9eUY4eLW0S5v8eTVW+95lCb8o7mE9CGYQ1u0IE+h
         C5yNpm5nKYnNsW3IpNDe9VhVmA1Upmd/z/+74RpaY3+HIR/NKCpemTi7kZzAmUg7e2oq
         AH/0/GJZnBc+eglq6tl2XwTriaAorW5s2njZ4YIMOqkVB2xDBXSqBKkn/3Tkq/ZsgxzE
         6HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zY3dCAWELdIR2DelBbTfc6lFEbhpsLzNY6AlazDGnFA=;
        b=ETzv/2SUUeimiPMDgjO9+lO6WksOH0fd9vbSW75DIz9pT1G8UC0/ZhPkd3gwRvBACc
         HzQN9CiV5h1/YfgZmup4jD2hzfFFLNcnXJQYo9bPkmUuksSQzp0fXMQAM2+Txk4/f2s7
         2f/a+fZE9VwayUDxH+IMjk1HhFw1NjlZBBMXgzC5WlfFesLDhkSy3ZNy3vD+WeX8c7Y/
         syERIKlz3MPlZ/AWZY+CM87fufC4FfrwiZYw9Xd07MREU/1fRh13yfC3M95MvdFCSuTV
         ToU1kMs9o8zLDM5cfSa5n8I3VtmQ4aaXhJJtnpd9eTnQh/QfovIZACfkB7S0U+d+OY8Q
         BAlQ==
X-Gm-Message-State: ANoB5pk9kd6Dw0rRtY2kqAFB7N7NzCDxw7xabDD3LRIkO7Qs2LGDEY01
        KXmvNbNR7E69SnNwINp0cjEC5F9W5q/NDRmp
X-Google-Smtp-Source: AA0mqf58O7woVBSokxZVgVvn+h5vBTDUaQ0ygxOn4gX9GAEarjawBUzEeQttEWbZVmoSD2jloVnxYw==
X-Received: by 2002:a17:90a:df01:b0:219:720c:29cb with SMTP id gp1-20020a17090adf0100b00219720c29cbmr11756805pjb.76.1670003840234;
        Fri, 02 Dec 2022 09:57:20 -0800 (PST)
Received: from [2620:15c:29:203:130f:d231:f741:46ed] ([2620:15c:29:203:130f:d231:f741:46ed])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm5856624pln.139.2022.12.02.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:57:19 -0800 (PST)
Date:   Fri, 2 Dec 2022 09:57:19 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Matthew Wilcox <willy@infradead.org>
cc:     ye.xingchen@zte.com.cn, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: add TRANSPARENT_HUGEPAGE_NEVER for THP
In-Reply-To: <Y4kN9UAte0OQ6sGi@casper.infradead.org>
Message-ID: <4a78abbc-4c07-2208-1072-af6d342c3f1a@google.com>
References: <202211301651462590168@zte.com.cn> <Y4kN9UAte0OQ6sGi@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022, Matthew Wilcox wrote:

> On Wed, Nov 30, 2022 at 04:51:46PM +0800, ye.xingchen@zte.com.cn wrote:
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> > 
> > Sometimes we may need the /sys/kernel/mm/transparent_hugepage/enabled to
> > default as [never] at the first time.
> 
> What is going wrong with THP enabled that you need to disable it?
> 

That would be useful to know in addition to why this needs to be part of 
.config and not simply using the kernel command line option.
