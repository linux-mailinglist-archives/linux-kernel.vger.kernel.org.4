Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3737167FFE5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjA2PfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2PfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:35:05 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3CD166E0;
        Sun, 29 Jan 2023 07:35:04 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-15085b8a2f7so12317020fac.2;
        Sun, 29 Jan 2023 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAW/0dKcTw7BVpRe+bs3ROH4E8ys5V9CO0c3+7rucWc=;
        b=dYxxOYlSai05NFWZcejIX8EQMxqqmwO+agw+UWiI4TnO4z0hDnM+VhwuGG79L3ZAh3
         8MsDpiOX9xcd5cm6Vmc4m1SKYJRR0s+svr9blyN53jC7tm436aZDIIX67UAru3yZYcq3
         jMzINfl1ggNJ/dUq+7FVxDFzo3JfMjY2vrDq2Co/Zfochyqsi8F8BsrJXUHBU4CN9Hgo
         8BHuKdmr1FHBKwK6OIT8ZHmRhOhxfvyjLyt3af8b3aKfaCE3urtLlbuOsRwIluM3EGN8
         NL0ZvUIC8WBxwgCPIAvyIJlzoOdsg6GkIb0/V/LHKKrR6Gt/hnNZGDF95Z6q1VJ9el6F
         33nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAW/0dKcTw7BVpRe+bs3ROH4E8ys5V9CO0c3+7rucWc=;
        b=7UdmYbk2bOW1iDQb0qJkAZciyxZv8yzuRzW1aVJ2kUqx+aucLlcxfTehwelygq8RV9
         dF0aDWXAmtFDWXFCYK+GC1JRYsvgbujiIwQBhnGu9WOjG/VdU/bkNH1SXGGcTXWqwMfn
         yUoMtW1iua553zJ7Na3r1tKK3PzCLeM/LvsaLhZ9j6iWdOJVZxNx5FK1/ASEdRdN4Hgp
         aanjUMXwLDphJvGeiHq+lTjV+Zf0mqrGR5AYldvhL9OCcRibcD8/FkO0Oz+NCyhTfEk+
         K6qvbXj1qqJ15sodQfNKkwVrZuNiiW3b99gJ5tNaM9tBjLfux5TVzXR7xv9ff/DMoc/z
         Od3g==
X-Gm-Message-State: AO0yUKUZOzuvsZF2Qf+35HeP9/LZiN8d0o0I9OQ7RvTU/ftIcfE+1NkJ
        NyP2JwHz6XlFOU3SEsXvjbSty8OyW6A=
X-Google-Smtp-Source: AK7set+cJiNCyBASSKzOQh2xW1ka5voMHGqF9m5B/XtdsTrTh66xTPbOSECC4aa+RcS/8L9DgcecTw==
X-Received: by 2002:a05:6870:170b:b0:163:7e0a:eec9 with SMTP id h11-20020a056870170b00b001637e0aeec9mr4735094oae.2.1675006503523;
        Sun, 29 Jan 2023 07:35:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id my11-20020a056870698b00b00143ae7d4ccesm4244441oab.45.2023.01.29.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 07:35:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Jan 2023 07:35:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] module: replace module_layout with module_memory
Message-ID: <20230129153501.GA304461@roeck-us.net>
References: <20230126233606.1317794-1-song@kernel.org>
 <20230127204011.GA45594@roeck-us.net>
 <Y9XaVtrNOxTGRJMJ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9XaVtrNOxTGRJMJ@bombadil.infradead.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 06:30:46PM -0800, Luis Chamberlain wrote:
> On Fri, Jan 27, 2023 at 12:40:11PM -0800, Guenter Roeck wrote:
> > That is the only failure reported by my test system.
> 
> I thought your rig does some form of boot / runtime tests too?
> 

Here are the detailed results:

Build results:
	total: 155 pass: 154 fail: 1
Failed builds:
	powerpc:ppc32_allmodconfig
Qemu test results:
	total: 504 pass: 504 fail: 0

It does run boot tests, but it doesn't test module functionality
(it doesn't try to load modules).

Guenter
