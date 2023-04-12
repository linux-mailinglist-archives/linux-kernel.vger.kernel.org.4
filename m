Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0356DE9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjDLDIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLDIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:08:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220E4C35
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:08:04 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so2228986pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681268883; x=1683860883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gid8gKpd6v8ppWBzwP53MDKvc3ToWVTc3wVleIln+w4=;
        b=GJxZ1508XGS4/QA61hJNc1kO9ZZYn/q9p6wXcLqgGm5dphPLS5pg5WMuFWTH6CxYhA
         Mnbf6caAkhcDZM8NrB9sMnxMp7C27Cojx1H6TA2obCUUHexgu/StJWzK1txCfh1Mza6t
         YfEvX+VwFiUG/ifQm4kcdB8s9lHOPUFei520I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681268883; x=1683860883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gid8gKpd6v8ppWBzwP53MDKvc3ToWVTc3wVleIln+w4=;
        b=DE8DgCkSY88CxCh1Il+yFajjPgt0cFRPyBIC0ZDrxRIBo4kk3FsJQmwODRX4lNJ6Ck
         2i+vEyGrxk5r5vtRGs0T3oYR7mx/5Cyo9vuCABQd1wy+D/9IYlJDpVHFy2+CJzbOK1r9
         3OiewCyNuYIbNDlaFlLHOEYrYP0cF5yCj73F614IpANeF3sOAIfJnU9Xyk3vqmLuxPrq
         A1oEvx/SwlwwonKgsXqQg4C2CpsI3Ua8BX/Q/V47LvnJV8ighRFFyUTTVmmJDPkqKWEb
         /ODWHHobq6TevhJn7cU1umxlPMrfHfQprfYoaNsbxIVGOMgF9Y9Oyf9RY4MB/BtBCZI5
         HXoQ==
X-Gm-Message-State: AAQBX9eccsxHBhg6RFt3Q774EiF6SHQebs6X8bx8UK+pqgtnrv3RIBuD
        W5E/L3VG4Y6AKLTK09d7kXRwCLuebK8lnDVqa1c=
X-Google-Smtp-Source: AKy350bDaKebh8BU9t07jkrMCy4/NmhwiNJ7Grrj0NxW/uiTKomOm6AKeQ+s78UC4mZmEwisTpnpjg==
X-Received: by 2002:a05:6a20:c323:b0:d9:d7f7:40d5 with SMTP id dk35-20020a056a20c32300b000d9d7f740d5mr907057pzb.36.1681268883474;
        Tue, 11 Apr 2023 20:08:03 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id j6-20020a62b606000000b0062e36fde14fsm10392177pff.194.2023.04.11.20.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 20:08:03 -0700 (PDT)
Date:   Wed, 12 Apr 2023 12:07:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] seq_buf: add seq_buf_do_printk() helper
Message-ID: <20230412030759.GD25053@google.com>
References: <20230411143852.868524-1-senozhatsky@chromium.org>
 <20230411224652.576dd18c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411224652.576dd18c@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/11 22:46), Steven Rostedt wrote:
> > Sometimes we use seq_buf to format a string buffer, which
> > we then pass to printk(). However, in certain situations
> > the seq_buf string buffer can get too big, exceeding the
> > PRINTKRB_RECORD_MAX bytes limit, and causing printk() to
> > truncate the string.
> > 
> > Add a new seq_buf helper. This helper prints the seq_buf
> > string buffer line by line, using \n as a delimiter,
> > rather than passing the whole string buffer to printk()
> > at once.
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Looks good to me. Want me to pull this in my tree, or do you have
> patches dependent on this?

Thanks, would be great if you can pull this in your tree. The MM
patches that Yosry is working on will be posted after the merge
window.
