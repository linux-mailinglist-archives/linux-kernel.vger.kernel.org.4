Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E61772CA91
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbjFLPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbjFLPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176E10F7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686584678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=03Uv8p5M7gEkdkNdSPyShEzWZ6NYMd5z8nkRrTJAMPo=;
        b=FeEk1W1veFezITsBgt9tp7FUs4IbFxfGEl6ulNBys5bSlABei25ACfCbfuj+aO13t796fy
        Z29bds4O+0SlpFFr4e3G82fe0QLfeEr8kuIRNB46H/ST5jltvB0OPtkChhJKeQPaLMcgNV
        oLcPRb4RMh5ueQ2URQvcBRDs+pRb77M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-26wjdDJJMDicMIQ0bGewog-1; Mon, 12 Jun 2023 11:44:37 -0400
X-MC-Unique: 26wjdDJJMDicMIQ0bGewog-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7f2d9a660so17709635e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686584676; x=1689176676;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03Uv8p5M7gEkdkNdSPyShEzWZ6NYMd5z8nkRrTJAMPo=;
        b=bdT0P9kbK3B+6/UDF/2HqXP9Xc7Pu4v8c+m0pdgD4E5fIMN9dEWaybstEQG9SRXT3I
         WHwa91zisAvkZmJJz0sgQqixlIZz8r88ePQ28yS0EYXAl08ZsT+SKkpefXppzbNG1IGL
         45iFvrbmKwKQTNaJ6EbpEvYrJJ8px2Bndhy2gUebK+Bsv6NYDZwHVOJL6wP9bc9M24PN
         U2RO+Nbjw76gVBQOL8LscVK9o+vFkcACfBe2pmcPv+0V5LiQaweyLnaIZ4l8PiRZJ6IZ
         /Ji2zHBMYNDI/epGbM6Z2eRycG9FPCZY4Z5Ef/dRKBXf5peKMyMJ91uHkvXXRBFkppvD
         oiaA==
X-Gm-Message-State: AC+VfDzQQW0H/rGaTjRIvlvgITEGAyITLeyTTVuA42T0fZdlAPEizt8v
        zxnN2N9UTJfA6Bc+O/3IhgiXWydpP5R122PIiTDL/sLz14wrHFg7zP3tKKgDB2WYCHSErQ+K4lt
        gUxvlydjAI2X5Jc1I1SMYm6vQ
X-Received: by 2002:a7b:c40a:0:b0:3f8:648:bba with SMTP id k10-20020a7bc40a000000b003f806480bbamr6931481wmi.8.1686584676467;
        Mon, 12 Jun 2023 08:44:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FI4Pwq0RUxTT3pNIr4YUH59cE+pcVu7iXi0Bb9mxYOjQmH9+JAQ3num+d8SybuhV+6pZhXQ==
X-Received: by 2002:a7b:c40a:0:b0:3f8:648:bba with SMTP id k10-20020a7bc40a000000b003f806480bbamr6931459wmi.8.1686584676188;
        Mon, 12 Jun 2023 08:44:36 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b003f7ba52eeccsm11810463wmj.7.2023.06.12.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:44:35 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tom Rix <trix@redhat.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] sched/fair: rename variable cpu_util eff_util
In-Reply-To: <20230611122535.183654-1-trix@redhat.com>
References: <20230611122535.183654-1-trix@redhat.com>
Date:   Mon, 12 Jun 2023 16:44:34 +0100
Message-ID: <xhsmhilbsy9b1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/23 08:25, Tom Rix wrote:
> cppcheck reports
> kernel/sched/fair.c:7436:17: style: Local variable 'cpu_util' shadows outer function [shadowFunction]
>   unsigned long cpu_util;
>                 ^
>
> Clean this up by renaming the variable to eff_util
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

