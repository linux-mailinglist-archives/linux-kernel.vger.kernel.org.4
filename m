Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A06062A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJTOQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJTOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:15:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528117587
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E5B0B82765
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8E1C433D6;
        Thu, 20 Oct 2022 14:15:45 +0000 (UTC)
Date:   Thu, 20 Oct 2022 10:15:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Chen <chensong_2000@189.cn>
Cc:     mingo@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, xiehuan09@gmail.com
Subject: Re: [PATCH] trace/ring_buffer: remove unused arguments
Message-ID: <20221020101549.06e3fa5b@gandalf.local.home>
In-Reply-To: <1666274811-24138-1-git-send-email-chensong_2000@189.cn>
References: <1666274811-24138-1-git-send-email-chensong_2000@189.cn>
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

On Thu, 20 Oct 2022 22:06:51 +0800
Song Chen <chensong_2000@189.cn> wrote:

> As a argument, event has nothing to do with either
> ring_buffer_unlock_commit or rb_commit and cleaning
> it up has no side effect.

OK, so this is because of a389d86f7fd0 ("ring-buffer: Have nested events
still record running time stamp") which removed the usage of event in rb_commit():

 static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
                      struct ring_buffer_event *event)
 {
        local_inc(&cpu_buffer->entries);
-       rb_update_write_stamp(cpu_buffer, event);
        rb_end_commit(cpu_buffer);
 }


I guess this doesn't hurt.

-- Steve

> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  include/linux/ring_buffer.h          |  3 +--
>  kernel/trace/ring_buffer.c           | 12 +++++-------
>  kernel/trace/ring_buffer_benchmark.c |  2 +-
>  kernel/trace/trace.c                 |  2 +-
>  4 files changed, 8 insertions(+), 11 deletions(-)
