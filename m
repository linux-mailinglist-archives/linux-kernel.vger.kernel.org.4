Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75D9651486
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiLSU6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiLSU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:57:57 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6422DF0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:57:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d10so5354447ilc.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDyNy+WaMMbT46Nu7xWJABOPqLJ4mBNBg4G6GLyPSyA=;
        b=KbhNEFItgqJpUb34PlBkSxussrLfWq638sk0HFl2FLNBYTaK/8B4hTsudLtq1bkC1w
         vw6Mr7C6FMx0V9UJAN8QRJjXtAVRsS8TGBOT5wg10yxC3S3lyss+1REqu2O661mXQsvS
         GhMwTohEAzhRfBnOPffbA8rBfCf3MI+2aQ93m3m48zG2Pi2C9W4eBEbbQ1XHOm3wy3Co
         2Pa7fSPzW6XYStHFMfwq9D1nABzUYP7WS7XSzJbojT+PG/EmyKDqIVBoTlN8rqJ9aBjZ
         WMUaHMyF4BODgsiwDuP18a2NdEZFL4LRWE5/PIE2lXJxqdegoOZ8cHXi7GUSgtRL76ED
         8dHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDyNy+WaMMbT46Nu7xWJABOPqLJ4mBNBg4G6GLyPSyA=;
        b=Ek6KpuA5oAtj6l1dUMqPFbVXGPqhmy1J2Wi5SxuhCtkCx0JLqg1FXxy0qKlpP6ir9+
         a6W0iUwU89mSX5m5gU/uO1fGqm/MsAXsDZQjWg4ZZx4w97MkO8c3MvvonqMUg2KBgd0i
         x+cpsrSy54XinTXwdmm6l0F6oG5Ucx2I09Jpq+h1HOfqB/Q+K846UNy/MKuiFHqLEW6e
         siFw5SFTkSUfC28nK/KTy3NuVk+NFGyqF5/omli2wC3nu2TPvG+cJ5ireAfBq07lr1HG
         0JDXHlZ8F8+2AlZtRp6c9GJT/hqiLUoTYOd9XlL43c+lbexT7dAr5wFx1piwlHFCKDsP
         7B9g==
X-Gm-Message-State: ANoB5pnyNPTIXHZPYRXHGT+fZl9fuKDUHcIKp1h3bEvcnp+V9y13PVkJ
        W5DvifQTWN/ZQNvtI6S0fUU8bQ==
X-Google-Smtp-Source: AA0mqf5AJOutoWTrKLNf0NtrR35QSZ3Fj/E2MBNWrinQOUSozCbfMplOw5BVmBmSUVTZpkqDzkVokw==
X-Received: by 2002:a92:cd4f:0:b0:303:410a:f2b3 with SMTP id v15-20020a92cd4f000000b00303410af2b3mr25223881ilq.13.1671483474816;
        Mon, 19 Dec 2022 12:57:54 -0800 (PST)
Received: from google.com ([2620:15c:183:200:6550:fd9a:e118:25dc])
        by smtp.gmail.com with ESMTPSA id b16-20020a026f50000000b003987df8bccdsm1856814jae.43.2022.12.19.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:57:54 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:57:50 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/selftests: Add test for event filtering on
 function name
Message-ID: <Y6DQTvOrHRZ8gjDz@google.com>
References: <20221219183106.518341498@goodmis.org>
 <20221219183214.075559302@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219183214.075559302@goodmis.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 01:31:08PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> With the new filter logic of passing in the name of a function to match an
> instruction pointer (or the address of the function), add a test to make
> sure that it is functional.
> 
> This is also the first test to test plain filtering. The filtering has
> been tested via the trigger logic, which uses the same code, but there was
> nothing to test just the event filter, so this test is the first to add
> such a case.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Ross Zwisler <zwisler@google.com>
