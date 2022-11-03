Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4569B617C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKCMcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:32:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15ABF40;
        Thu,  3 Nov 2022 05:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4E14B8277C;
        Thu,  3 Nov 2022 12:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A43EC433C1;
        Thu,  3 Nov 2022 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667478718;
        bh=KQLUDHFSpcXR73+ABRyCiieiASoreoHSgD8oxGMrEWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JnCyewCXLr57zeVcBtf8fvxW276yAO5YKRsvMDFiH+Ksy/YSOHqz8zZ6znO0OWk24
         VgaSthNgyE6BTCg7awfgee2TtxhAz/daCEZMmRx3uZsDsZQizcvBQ5R7KfjRaUOhWY
         3d5h3GcTS4cW3+jpVBBe+YzLUFUxIXP207nut42jwo+cfxLTRkCNeJLgpS5aHmX8Rv
         hR0E5nwjjm/ieqfzjQK/7A+FsTjxGrUjicBeiWIcCy/tWYQqXbzvx5juaMVNXdIphF
         3QzY+uTu8VpWpN4DmeTmeo3g13H2WgBucF2lq5K05hQxhLPC/JqGGM8xsE7NDZ/5e2
         PVSNKDfHVBuLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 803AC4034E; Thu,  3 Nov 2022 09:31:55 -0300 (-03)
Date:   Thu, 3 Nov 2022 09:31:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 0/3] tools/perf: Fix perf probe crash by clang DWARF5
 file
Message-ID: <Y2O0u2BqLH9XFCbD@kernel.org>
References: <166731050151.2100653.8202870942871353491.stgit@devnote3>
 <CAM9d7chbMQ5Zxn00-VTbvaarBu1rkWZopqQCxfQqFq0Cnr_C+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chbMQ5Zxn00-VTbvaarBu1rkWZopqQCxfQqFq0Cnr_C+A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 01, 2022 at 05:03:51PM -0700, Namhyung Kim escreveu:
> On Tue, Nov 1, 2022 at 6:48 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> > Here is the 2nd version of the patches for perf probe which improves the
> > robustness against clang DWARF5 file.
> >
> > Since the Clang generates a bit different DWARF5 file, the perf probe
> > crashes or failes to analyze it. There are actually fragile code against
> > it, so I fixed it ([1/3]) to avoid crash by SEGV. And make it accepts
> > Clang's DWARF5 file ([2/3],[3/3]).

> > Masami Hiramatsu (Google) (3):
> >       tools/perf: Fix to avoid crashing if DW_AT_decl_file is NULL
> >       tools/perf: Fix to use dwarf_attr_integrate for generic attr accessor
> >       tools/perf: Fix to get declared file name from clang DWARF5
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

