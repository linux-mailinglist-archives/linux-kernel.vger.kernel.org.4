Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED84621E37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKHVIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHVIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:08:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406451AF0F;
        Tue,  8 Nov 2022 13:08:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D060061777;
        Tue,  8 Nov 2022 21:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1817EC433C1;
        Tue,  8 Nov 2022 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667941710;
        bh=3GlHu5yvHpYryUxh56d4Wb/AASxB0UBpxBfH92jwobc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVcd8Dym0GlpOtjERCRf/ewP9h45ZaL2OATHfkgK6RQCHDjuwwZk8D9qcuFEWmMH7
         AQ776103W7cI0ZBVyOGaJhTPbA2H9je6TdvOW1v+gPTy4stZWMz4jORWU1qMVvBnHp
         qROV7J555ykUQGJSqu33mwCvQn5b8X0DWlW1/shf5uhvdw9ZHmn3E7a8QSNFo5x1lk
         +T0FDRSu9i22qxlTwbSMG/ksqHChIf8arA43NU7xbCX/RftfBwmZPDxplhtpxvQZra
         BFRrF9Fg2SSD2Un4ek53cj0H74wk5thcuwDJxliaTElAYV3u3voam2hFpLMplpeRx+
         cGHCe39elP11g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82F304034E; Tue,  8 Nov 2022 18:08:27 -0300 (-03)
Date:   Tue, 8 Nov 2022 18:08:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tools/perf: Fix to get the DW_AT_decl_file and
 DW_AT_call_file as unsinged data
Message-ID: <Y2rFS6CPfhIQhYUc@kernel.org>
References: <166761727445.480106.3738447577082071942.stgit@devnote3>
 <CAM9d7ci8YX22Bp31ZD9k31NFN6pP3fbPKpNDNZYnmdZiqav1Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci8YX22Bp31ZD9k31NFN6pP3fbPKpNDNZYnmdZiqav1Vg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 07, 2022 at 01:09:00PM -0800, Namhyung Kim escreveu:
> Hi Masami,
> 
> On Fri, Nov 4, 2022 at 8:01 PM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Dwarf version 5 standard Sec 2.14 says that
> >
> >   Any debugging information entry representing the declaration of an object,
> >   module, subprogram or type may have DW_AT_decl_file, DW_AT_decl_line and
> >   DW_AT_decl_column attributes, each of whose value is an unsigned integer
> >   constant.
> >
> > So it should be an unsigned integer data. Also, even though the standard
> > doesn't clearly say the DW_AT_call_file is signed or unsigned, the
> > elfutils (eu-readelf) interprets it as unsigned integer data and it is
> > natural to handle it as unsigned integer data as same as DW_AT_decl_file.
> > This changes the DW_AT_call_file as unsigned integer data too.
> >
> > Fixes: 3f4460a28fb2 ("perf probe: Filter out redundant inline-instances")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/dwarf-aux.c |   21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 30b36b525681..b07414409771 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -315,19 +315,6 @@ static int die_get_attr_udata(Dwarf_Die *tp_die, unsigned int attr_name,
> >         return 0;
> >  }
> >
> > -/* Get attribute and translate it as a sdata */
> > -static int die_get_attr_sdata(Dwarf_Die *tp_die, unsigned int attr_name,
> > -                             Dwarf_Sword *result)
> > -{
> > -       Dwarf_Attribute attr;
> > -
> > -       if (dwarf_attr_integrate(tp_die, attr_name, &attr) == NULL ||
> > -           dwarf_formsdata(&attr, result) != 0)
> > -               return -ENOENT;
> > -
> > -       return 0;
> > -}
> > -
> >  /**
> >   * die_is_signed_type - Check whether a type DIE is signed or not
> >   * @tp_die: a DIE of a type
> > @@ -467,9 +454,9 @@ int die_get_data_member_location(Dwarf_Die *mb_die, Dwarf_Word *offs)
> >  /* Get the call file index number in CU DIE */
> >  static int die_get_call_fileno(Dwarf_Die *in_die)
> >  {
> > -       Dwarf_Sword idx;
> > +       Dwarf_Word idx;
> >
> > -       if (die_get_attr_sdata(in_die, DW_AT_call_file, &idx) == 0)
> > +       if (die_get_attr_udata(in_die, DW_AT_call_file, &idx) == 0)
> >                 return (int)idx;
> >         else
> >                 return -ENOENT;
> > @@ -478,9 +465,9 @@ static int die_get_call_fileno(Dwarf_Die *in_die)
> >  /* Get the declared file index number in CU DIE */
> >  static int die_get_decl_fileno(Dwarf_Die *pdie)
> >  {
> > -       Dwarf_Sword idx;
> > +       Dwarf_Word idx;
> >
> > -       if (die_get_attr_sdata(pdie, DW_AT_decl_file, &idx) == 0)
> > +       if (die_get_attr_udata(pdie, DW_AT_decl_file, &idx) == 0)
> >                 return (int)idx;
> >         else
> >                 return -ENOENT;
> >

-- 

- Arnaldo
