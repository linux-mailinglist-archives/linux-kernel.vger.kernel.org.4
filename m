Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D356687CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjALXZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjALXY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:24:59 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B8625CE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:24:58 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i17so5279721ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhPs+38t8N3EH680V7YHANpRORT0aYGCh7p0Fkn2BAI=;
        b=fG4GbZyVdfCmXUqY5hS5XkbOTTIEDtjjqVnH11RywslEKwvGvGa5VpqSt0eLcj6IJG
         ImYGZWJUkahGo0GBnX/YQQJuTc0ielKfxjbODOM0akxJcJ5WDe73cueDgsYM9YuJIXo8
         QkT14Sm4O59GjQZ8SrYF7fgDAIRk/EQNqUX3CC6D93SoEvbTnP9FKDSC/cpTzs9p0r2x
         0wsGURFNpDVBNi5swfF40KNUHysel31WKyJKtdzrOTv2Q2ljvO/57MWEdrPsA481C61S
         WneCtZvXD7U4P/4g4c5v3nFt4GBFFyYXIubX4rNW4fPEZO5/0ICoPPqQ/qszmXVvj0no
         qwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhPs+38t8N3EH680V7YHANpRORT0aYGCh7p0Fkn2BAI=;
        b=lZDu5QgX9Mny426SPDZOPSEufDlU+BbIqPcawiyz1jJwmIc1nxUp2IOfuGKghZcm9g
         1ZeLNSKjiLjVDfHoiN9nGmyiaDsHs/ndRJf/z2GlNDiRWcbD4erEgPvQiDgKnP38ratD
         p0ifmpwypTj6fZURqTvxsNg+b2z5iqJRh1ka8YNHUD3g0qBtXZydOgTWnb3kGtdyv5qX
         0fXzGMFGFn4nB4w5+381Zcb6MCSAJMyVhImrps/gWhOmSvZoK7W63fmH+UBoKb1c4Umj
         aTwtJHbjr802Bkdic22sO7QrqhmLb+X2YOnL04EN+34+6Uv5YRol0gJ8BA+BCIVJ9uev
         1pcg==
X-Gm-Message-State: AFqh2koCYmp3LUNwMV3gXNy7KzbDTdWvxfYqh8ipcd1AdWxG5spyyTzF
        P+DTIHV+BYNt7NpDlnytiYe7Pg==
X-Google-Smtp-Source: AMrXdXs/q6biaY3OJcyqisY7aL5lr9U3a8916S3Mchaoa/8ifgqeAmVu5Lp0aR5TdMcoUZpn1v4IIA==
X-Received: by 2002:a92:b74c:0:b0:30d:a576:8342 with SMTP id c12-20020a92b74c000000b0030da5768342mr13444165ilm.11.1673565897239;
        Thu, 12 Jan 2023 15:24:57 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4a23:5fbb:9bb3:1279])
        by smtp.gmail.com with ESMTPSA id a6-20020a056e020e0600b0030edd1501a0sm165652ilk.74.2023.01.12.15.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:24:56 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:24:53 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] tracing: Add enabling of events to boot instances
Message-ID: <Y8CWxbg8NOh9MKSF@google.com>
References: <20230111145636.450953217@goodmis.org>
 <20230111145842.534011158@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111145842.534011158@goodmis.org>
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

On Wed, Jan 11, 2023 at 09:56:38AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add the format of:
> 
>   trace_instance=foo,sched:sched_switch,irq_handler_entry,initcall
> 
> That will create the "foo" instance and enable the sched_switch event
> (here were the "sched" system is explicitly specified), the
> irq_handler_entry event, and all events under the system initcall.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

You can add: 
Reviewed-by: Ross Zwisler <zwisler@google.com>
