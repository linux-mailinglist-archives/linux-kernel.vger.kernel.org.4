Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38BC60F8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiJ0NYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiJ0NYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0CF599
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83DF062312
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869C0C433C1;
        Thu, 27 Oct 2022 13:24:33 +0000 (UTC)
Date:   Thu, 27 Oct 2022 09:24:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix static function tracer not working
Message-ID: <20221027092444.3702378c@gandalf.local.home>
In-Reply-To: <20221027085343.2388485-1-suagrfillet@gmail.com>
References: <20221027085343.2388485-1-suagrfillet@gmail.com>
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

On Thu, 27 Oct 2022 16:53:43 +0800
Song Shuai <suagrfillet@gmail.com> wrote:

> Setting kernel command line parameter ftrace=function shows
> nothing on the kernel built with static ftrace.
> 
> In static ftrace, ftrace_nodyn_init should be executed before
> initializing tracers. While this commit `dbeafd0d6131` brings
> the initialization of function tracer forward from core_initcall
> where ftrace_nodyn_init still remains.
> 
> This patch puts ftrace_nodyn_init and ftrace_init together and
> makes function tracer works in static ftrace.

Sorry but NACK.

Static ftrace only exists for helping new architectures get dynamic ftrace
working. It is not, and never will be, considered the end product.

Really, I only keep it around as a stepping stone for full dynamic ftrace,
otherwise I would have removed it along time ago.

No generic code should ever be modified to satisfy static ftrace. Please
get dynamic ftrace functional, as that could be used in production
environments.

-- Steve
