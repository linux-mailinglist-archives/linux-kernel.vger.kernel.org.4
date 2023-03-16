Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB66BC783
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCPHnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCPHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:43:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A109F9EF43;
        Thu, 16 Mar 2023 00:43:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso5189343pjf.0;
        Thu, 16 Mar 2023 00:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678952605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QLlBEUgeLAqwMMEZyGWn7gzXwT9sGa0xB2v33G8aaM=;
        b=lNxqMGYb+8is1IsgAvHvY2r2VbhdeeaGaYEXfupKAKbzKMw6djVpWbTqOjYfQ/GDH3
         tMYqNWGq4KwiqDIcVZiawObecvGV9p1L0KHWOJBH5j9mdlROYUZAZrlmW0Ahcdx1GtMx
         q3PJgUKwSNL4rlQq1lextGObopObI7hLpLf8qwqBDhS0+a+15jsmVLltx2nDx5CWB4vH
         zH/aN1kkXJHw0c4ID6LYyzs4kctYbBX9nvD1p3dSUA5HblgSAYoN96FdlnckyCR50xwF
         CVEFJSKf8tBDTgfRtS989r92ppJC5+PZkuZSZm8ZAHOkCwKdJ4++rgUhOg6+a422B7rc
         yr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QLlBEUgeLAqwMMEZyGWn7gzXwT9sGa0xB2v33G8aaM=;
        b=O/BYSJ3S9uUaoInCF7sSJdkAARVqs2O8DwNc93T+4VNR5uOWdxIfKMErNnTxLtB1gO
         UZ6h84cGjGRyapjxTbexmYf/IawD8WPVYNWBiTC9ak1SGxWOkm9dQxZ5ZxgADvSCoeHX
         Qx4HdtZgB1mMe/m37Cb17T7D5cnorZvDl89SAq1QwRhsft+fFRyM1aVhF83vIa8i9j6m
         tJKUHiBT3R281B0fSmpJP+8Nd1sZkeNyGFltyeOaobKi6cpEPiA+3QA5QfmA+S7NIQrA
         1H2bxEMRm/2/sDksTv+d/OfRiUkOg2/Q4ps8+7sveeqVE4kXJ0Ysxve9RsAWrmJDYszN
         72ug==
X-Gm-Message-State: AO0yUKUuTMjqrR/4NLfQzsY5khU2Ux/q829FpuaR5gBGkgqA5e75+Vpt
        tMsUluVJSTV4bxfmG+bV90covQtnaGJcCg==
X-Google-Smtp-Source: AK7set+wO+rOlcF3ePhUVRDUK/vSGdPPrSJYH9IYAOwKnaL2wtFmtExOpORweaUtdshx//2BcBQ9EQ==
X-Received: by 2002:a05:6a20:5495:b0:d5:1c74:27af with SMTP id i21-20020a056a20549500b000d51c7427afmr3622745pzk.29.1678952605002;
        Thu, 16 Mar 2023 00:43:25 -0700 (PDT)
Received: from kazuki-mac ([2400:4051:ea3:5910::789])
        by smtp.gmail.com with ESMTPSA id 7-20020aa79247000000b00582f222f088sm4762318pfp.47.2023.03.16.00.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 00:43:24 -0700 (PDT)
From:   Kazuki H <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki H <kazuki@kazuki-mac>
Date:   Thu, 16 Mar 2023 16:43:18 +0900
To:     linux-pm@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Kazuki H <kazukih0205@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuidle: Don't pass any values to
 cpuidle_not_available
Message-ID: <20230316074318.hrdstgqvtywz4qho@kazuki-mac>
References: <linux-pm@vger.kernel.org>
 <20230316063712.33353-1-kazukih0205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316063712.33353-1-kazukih0205@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this, I messed it up.
