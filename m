Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E862560AFED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiJXP7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiJXP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:58:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587D15625C;
        Mon, 24 Oct 2022 07:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14DDDB80EE4;
        Mon, 24 Oct 2022 14:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCB7C433D6;
        Mon, 24 Oct 2022 14:35:13 +0000 (UTC)
Date:   Mon, 24 Oct 2022 10:35:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [kbuild-all] Re: include/trace/trace_events.h:261:16: error:
 function 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for
 'gnu_printf' format attribute
Message-ID: <20221024103524.43e13ab3@gandalf.local.home>
In-Reply-To: <ed665ca3-fa87-fee6-7284-9aed257264e4@intel.com>
References: <202210212134.QTpb11ug-lkp@intel.com>
        <20221021101026.1708a426@gandalf.local.home>
        <ed665ca3-fa87-fee6-7284-9aed257264e4@intel.com>
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

On Mon, 24 Oct 2022 15:26:00 +0800
"Chen, Rong A" <rong.a.chen@intel.com> wrote:

> On 10/21/2022 10:10 PM, Steven Rostedt wrote:
> > On Fri, 21 Oct 2022 22:07:17 +0800
> > kernel test robot <lkp@intel.com> wrote:
> >   
> >> Hi Steven,
> >>
> >> FYI, the error/warning still remains.  
> > 
> >    WONT FIX
> > 
> > I thought we already discussed getting rid of this warning?  
> 
> Hi Steve,
> 
> Sorry for the noise, the bot doesn't ignore this warning with prefix 
> 'error:', we will fix it.

Ug. Let me guess, is this compiled with -Werror?

Because a warning about a macro that may or may not create printf
formatting, where gcc thinks it needs a gcc printf attribute and warns
about it, is not something to fail the build on.

For any build that fails on warnings, that specific warning needs to be
silenced.

I mean, "-Werror=suggest-attribute=format", really?

-- Steve

> >   
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   e35184f321518acadb681928a016da21a9a20c13
> >> commit: c7c37bb87590886e08d24dec53089f74b89f5fbb tracing/iwlwifi: Use the new __vstring() helper
> >> date:   3 months ago
> >> config: x86_64-sof-customedconfig-edison-defconfig
> >> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> >> reproduce (this is a W=1 build):
> >>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7c37bb87590886e08d24dec53089f74b89f5fbb
> >>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>          git fetch --no-tags linus master
> >>          git checkout c7c37bb87590886e08d24dec53089f74b89f5fbb
> >>          # save the config file
> >>          mkdir build_dir && cp config build_dir/.config
> >>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/intel/iwlwifi/
> >>
> >> If you fix the issue, kindly add following tag where applicable
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>     In file included from include/trace/define_trace.h:102,
> >>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:71,
> >>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
> >>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
> >>     drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'trace_event_get_offsets_iwlwifi_dbg':  
> >>>> include/trace/trace_events.h:261:16: error: function 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]  
> >>       261 |         struct trace_event_raw_##call __maybe_unused *entry;            \
> >>           |                ^~~~~~~~~~~~~~~~
> >>     include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
> >>        40 |         DECLARE_EVENT_CLASS(name,                              \
> >>           |         ^~~~~~~~~~~~~~~~~~~
> >>     drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:49:1: note: in expansion of macro 'TRACE_EVENT'
> >>        49 | TRACE_EVENT(iwlwifi_dbg,
> >>           | ^~~~~~~~~~~
