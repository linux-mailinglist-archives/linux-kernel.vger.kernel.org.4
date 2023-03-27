Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6D6CB0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC0VvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjC0VvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:51:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFDCD9;
        Mon, 27 Mar 2023 14:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E7CB81978;
        Mon, 27 Mar 2023 21:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAB4C4339B;
        Mon, 27 Mar 2023 21:51:01 +0000 (UTC)
Date:   Mon, 27 Mar 2023 17:50:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] Reduce synchronize_rcu() waiting time
Message-ID: <20230327175059.1e8584cc@gandalf.local.home>
In-Reply-To: <20230327174844.15305988@gandalf.local.home>
References: <20230321102748.127923-1-urezki@gmail.com>
        <IA1PR11MB617169A10E6DDE3C1168605D89819@IA1PR11MB6171.namprd11.prod.outlook.com>
        <ZBnKKZsSpI8aAk9W@pc636>
        <20230327174844.15305988@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 17:48:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> struct my_info {
> 	/* store state info here */
> };
> 
> int main(...) {
> 	struct tracecmd_input *handle;
> 	struct my_info info;
> 	char *file = argv[1];
> 
> 	handle = tracecmd_open(file);
> 
> 	tracecmd_follow_event(handle, "rcu", "rcu_batch_start",
> 			batch_start, &info);
> 
> 	tracecmd_follow_event(handle, "rcu", "rcu_batch_end",
> 			batch_end, &info);
> 
> 	tracecmd_follow_event(handle, "rcu", "rcu_invoke_callback",
> 			invoke_callback, &info);
> 
> 	tracecmd_iterate_events(handle, NULL, 0, NULL, NULL);
> 
> 	tracecmd_close(handle);
> }

BTW, none of this code was actually tested, so I may have some syntax
errors. I just did this straight from memory, as it's so easy ;-)

-- Steve
