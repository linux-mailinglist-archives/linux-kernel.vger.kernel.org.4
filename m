Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6702C6643AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbjAJOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbjAJOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:51:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCCC5F56;
        Tue, 10 Jan 2023 06:51:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC1A6173B;
        Tue, 10 Jan 2023 14:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38026C433EF;
        Tue, 10 Jan 2023 14:51:39 +0000 (UTC)
Date:   Tue, 10 Jan 2023 09:51:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/rtla: Explicitly list libtraceevent dependency
Message-ID: <20230110095137.18168c29@gandalf.local.home>
In-Reply-To: <20230110144536.knepnpxsp4mw67no@carbon.lan>
References: <20230110131805.16242-1-dwagner@suse.de>
        <42d1e999-79a6-94dc-cc88-77520ddce068@kernel.org>
        <20230110140814.2yz4if2e2fasnu7t@carbon.lan>
        <94fd6fb5-c87a-b02e-40bc-b2e2c99529d5@kernel.org>
        <20230110144536.knepnpxsp4mw67no@carbon.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 15:45:36 +0100
Daniel Wagner <dwagner@suse.de> wrote:

> Just to clarify, the generated pkg file by Meson is adding the libtraceevent
> dependency in the private section. So this part should be okay. I would be
> surprised if Meson would get this wrong at this point.

No that's incorrect.

There's many interfaces that require the libtraceevent header files to work
with libtracefs. Anything that uses libtracefs must also use libtraceevent,
as libtracefs is really just an extension of libtraceevent.

> 
> $ cat .build/meson-private/libtracefs.pc
> prefix=/tmp/trace-cmd
> includedir=${prefix}/include
> libdir=${prefix}/lib64
> 
> Name: libtracefs
> Description: Manage trace fs
> URL: https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
> Version: 1.6.3
> Requires.private: libtraceevent >=  1.7.0

This is incorrect.

-- Steve

> Libs: -L${libdir} -ltracefs
> Cflags: -I${includedir}/libtracefs

