Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA2625018
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKKCWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKKCWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:22:49 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C525E3F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:22:48 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id i10so964749ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jFmu26M8SbZRDoS5YncX03RVCQvtd0/Eme3Pt6/0vTc=;
        b=xBRf/feYYm+kp976WAg44FNvoeTwplJR6I58eU/V1agJIFpdM7o0hwUh0crrMTP+t5
         /69cFO0/olP3VleMRFP0d1ep7Y+WcocYnUE0AynnZV3aaafUVZaE63fyWa1UflBObeqP
         9C6/vVoWTTWSNSjr9S3xDu3TbNJqORZqoV+gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFmu26M8SbZRDoS5YncX03RVCQvtd0/Eme3Pt6/0vTc=;
        b=Xq5AmDnfETfN+egtDxg7MZH/fzarnBYAwXIKSKuwDe45xhBHHwCSEzcQkzw3vFi6G4
         pfCpAJTBysiIZIut4L/GXLtWa8wkQjgq0Ceh786eLclSm6bg9Zj9vTxwUT54O1mQ52Jh
         l8OzDbaSyv1+TJrSUhxJZ7uzOnvCAZWi8tY4Pjuo3c9xvSB226vmV+LxUkD1+od88D0W
         0iqJkiJFOJjGM6JeefP7zR/21tKPL4uSzy6sO+2/21121QAAe+m5UY9hmuC+8qZrMMB4
         HEc3c7kgWwR+bW9WfgE7A+wxX0EtPomBS1hhVJ0Vml+Es73pg0mWbb4fllV/AzMsedG8
         3xzA==
X-Gm-Message-State: ANoB5pmW9+7iQn00HNf2Ixhrh/sYv6gvie87cl+rI/9dcUKKsqikEm1a
        4UtNM4qOc3bHAi9rS0wPM/gKqc3QJwXYdkKU/HjO7w==
X-Google-Smtp-Source: AA0mqf6JlN0zqCrM0zok6UN2n7q/4i8TWD4tiOeQjLz1+mGyCJ9vrn6Imgul2AnfaLFZdIhpwzmeeQo9cLQq3ZRBi+I=
X-Received: by 2002:a17:906:6592:b0:7ae:9677:d8dd with SMTP id
 x18-20020a170906659200b007ae9677d8ddmr323080ejn.71.1668133367165; Thu, 10 Nov
 2022 18:22:47 -0800 (PST)
MIME-Version: 1.0
References: <20221110175959.3240475-1-joel@joelfernandes.org> <20221111093445.e195afe799822d5a7ffbaca4@kernel.org>
In-Reply-To: <20221111093445.e195afe799822d5a7ffbaca4@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 11 Nov 2022 02:22:36 +0000
Message-ID: <CAEXW_YRtiwrWsJ8hMGMa5bKKhT163+P3OzR0T0feQROjzSJ1hQ@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Dump instance traces into dmesg on ftrace_dump_on_oops
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:34 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 10 Nov 2022 17:59:59 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>
> > Currently ftrace only dumps the global trace buffer on an OOPs. For
> > debugging a production usecase, I'd like to dump instance traces as
> > well, into the kernel logs. The reason is we cannot use the global trace
> > buffer as it may be used for other purposes.
> >
> > This patch adds support for dumping the trace buffer instances along
> > with the global trace buffer.
> >
> > The instance traces are dumped first, and then the global trace buffer.
> >
>
> This looks good to me.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

 - Joel



  - Joel
