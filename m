Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6A64AAA8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiLLWz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiLLWzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:55:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB39764A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:55:19 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so1585367pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/bBC+07xi7sOoDrZvjkOQQutNEAYfx1z9nkux49oEQ=;
        b=oWlC6TJVK+1bBmQrXNc4FJt5KjKFee9qfyLA67mwCymZIBpIQj2LyDDSY+q1rkNO3Q
         9LXKynhdR93R4cv0RyJKNg+efLlOK2QCmWWIA6kuYJL7cHrOoErC0A+Hod9AfE6fiL3c
         UvSsHHP8l91sbh13ElBqc4NdllmQBaNdBbGiXA25DnOLJrgEcxAadjHEj2F+WVFuTCRL
         H14X4pSCdKx1BdUe2+JPKPCJ4fFqYaBXf3lnqJQ3+gXRUNGd9XCY+HvWCvTeGKA6JSwb
         G5XGH5UMod/W+QfDoacMI/uROLV6N7oyyaOml8WYkJJTQGKO+0aP8oJgcv/0LUCDIRGW
         4y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/bBC+07xi7sOoDrZvjkOQQutNEAYfx1z9nkux49oEQ=;
        b=C2KvE1T8Et5kmxEPKJtTsr/jfjIZOLOHbQZNdY5JxiS0BS2UaCtV22RStss2FcKApN
         B7MXaZ0oGp9ZcAn4GyFjf12mM5IKo20vzpIBXbez72fOt/hr3OfOtqkL4X1sSqPg2v49
         l7GJUYPwFfdcHzIiQW2hEL2FDzc3u8AR17w1V7moCvgy/7WAVd9QEPg3q2DgXY0uJKBr
         5BJr5jFpPMRPVpYd3r08Y4RUb9c2QkQj3TYlYyF2yxiYdrDhgZLYQXfWSYA/e9LcK/bs
         Bcv/1J2GcvdwtzGodPH6BR2p4FA2JYaBGwiOBspAy13Ye5wVfqy0z2Sb6p7WG0Lq0E2a
         BPQg==
X-Gm-Message-State: ANoB5pkUZ25OaEDEWp4PlDR32EGpfuWJk4K5pS/JTyBPOwaOdZHHvyjM
        SIu0zBIAajj9tKeAv1Yafeg=
X-Google-Smtp-Source: AA0mqf5vY5yvF3P/2dTu80/kL6mlvK1TwW7f9rIi2rJtYHQFEzPYKbgh7YtBGvt8czMgVHNDcbbUyA==
X-Received: by 2002:a17:903:cd:b0:189:d0a2:5340 with SMTP id x13-20020a17090300cd00b00189d0a25340mr17545762plc.33.1670885718483;
        Mon, 12 Dec 2022 14:55:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b00174f7d10a03sm6962637plg.86.2022.12.12.14.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:55:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 12:55:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Check for null pointer return from
 get_work_pwq()
Message-ID: <Y5exVKEXe2vddXhP@slm.duckdns.org>
References: <20221208005344.25195-1-quic_johmoo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208005344.25195-1-quic_johmoo@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:53:44PM -0800, John Moon wrote:
> We've encountered a kernel panic with the following stack trace:
> 
> -> ret_from_fork
>  -> kthread
>   -> worker_thread
>    -> process_one_work
>     -> pwq_dec_nr_in_flight
>      -> pwq_activate_inactive_work
> 
> The issue was narrowed down to a null pointer dereference within
> pwq_activate_inactive_work() stemming from the return value of
> get_work_pwq() which may return NULL, but was not checked for
> null return prior to use.
> 
> While fixing the issue, other dereferences of get_work_pwq()'s
> return value were found without a null check.
> 
> Add null pointer checks to the calling functions that need them.

At that point the work item must have pwq assigned - see insert_work(), so
this can't be the root cause. It's just papering over a bug somewhere else
(e.g. the work item got freed or written over somehow).

Thanks.

-- 
tejun
