Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66E622063
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiKHXfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKHXfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:35:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9E528B1;
        Tue,  8 Nov 2022 15:35:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B49ED617D8;
        Tue,  8 Nov 2022 23:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26B2C433C1;
        Tue,  8 Nov 2022 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667950531;
        bh=hAtFAfVdiMhWghQ20wXujauJ3CNhPfxI4wMaXk06c7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q+KAC+UEamqmqDsoE7pph9YOK2v5vABXK/5EqjKKULl2sjQWbe7LL+GdpoPc+9Lhn
         7BSWEiStjXMEHLsr6wwb7CfQ78kBPhBN9uLy95NHr/8oIBsotjOmlrsvMIbT9rX8gZ
         Jfb3sVSpnqpqBco2z3FffR2GDviWDwzGGMhL3J9rI2wDINojBp9Gt4hT/DdB+jq7Xd
         TOHGiihErMwpckwKCU34MfJfJCrnbW4SHN+csGsCNGBaEg3geSH74ZdwdbzkMr1Luc
         OIbXwe4lk4cdfu0rnJVbZj8rJM+anM1NVM4qG4N3QD8L+lqSaogPTcbnmnbmFequwJ
         Vq6U/sgUnjoFA==
Date:   Wed, 9 Nov 2022 08:35:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tools/perf: Fix to get the DW_AT_decl_file and
 DW_AT_call_file as unsinged data
Message-Id: <20221109083526.b5f052f5ab8c9dd930df38f1@kernel.org>
In-Reply-To: <Y2rFS6CPfhIQhYUc@kernel.org>
References: <166761727445.480106.3738447577082071942.stgit@devnote3>
        <CAM9d7ci8YX22Bp31ZD9k31NFN6pP3fbPKpNDNZYnmdZiqav1Vg@mail.gmail.com>
        <Y2rFS6CPfhIQhYUc@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 18:08:27 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Nov 07, 2022 at 01:09:00PM -0800, Namhyung Kim escreveu:
> > Hi Masami,
> > 
> > On Fri, Nov 4, 2022 at 8:01 PM Masami Hiramatsu (Google)
> > <mhiramat@kernel.org> wrote:
> > >
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > Dwarf version 5 standard Sec 2.14 says that
> > >
> > >   Any debugging information entry representing the declaration of an object,
> > >   module, subprogram or type may have DW_AT_decl_file, DW_AT_decl_line and
> > >   DW_AT_decl_column attributes, each of whose value is an unsigned integer
> > >   constant.
> > >
> > > So it should be an unsigned integer data. Also, even though the standard
> > > doesn't clearly say the DW_AT_call_file is signed or unsigned, the
> > > elfutils (eu-readelf) interprets it as unsigned integer data and it is
> > > natural to handle it as unsigned integer data as same as DW_AT_decl_file.
> > > This changes the DW_AT_call_file as unsigned integer data too.
> > >
> > > Fixes: 3f4460a28fb2 ("perf probe: Filter out redundant inline-instances")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks, applied.

Thanks Namhyung and Arnaldo!

> 
> - Arnaldo
> 
>  
> > Thanks,
> > Namhyung
> > 
> > 
> > > ---
> > >  tools/perf/util/dwarf-aux.c |   21 ++++-----------------
> > >  1 file changed, 4 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > > index 30b36b525681..b07414409771 100644
> > > --- a/tools/perf/util/dwarf-aux.c
> > > +++ b/tools/perf/util/dwarf-aux.c
> > > @@ -315,19 +315,6 @@ static int die_get_attr_udata(Dwarf_Die *tp_die, unsigned int attr_name,
> > >         return 0;
> > >  }
> > >
> > > -/* Get attribute and translate it as a sdata */
> > > -static int die_get_attr_sdata(Dwarf_Die *tp_die, unsigned int attr_name,
> > > -                             Dwarf_Sword *result)
> > > -{
> > > -       Dwarf_Attribute attr;
> > > -
> > > -       if (dwarf_attr_integrate(tp_die, attr_name, &attr) == NULL ||
> > > -           dwarf_formsdata(&attr, result) != 0)
> > > -               return -ENOENT;
> > > -
> > > -       return 0;
> > > -}
> > > -
> > >  /**
> > >   * die_is_signed_type - Check whether a type DIE is signed or not
> > >   * @tp_die: a DIE of a type
> > > @@ -467,9 +454,9 @@ int die_get_data_member_location(Dwarf_Die *mb_die, Dwarf_Word *offs)
> > >  /* Get the call file index number in CU DIE */
> > >  static int die_get_call_fileno(Dwarf_Die *in_die)
> > >  {
> > > -       Dwarf_Sword idx;
> > > +       Dwarf_Word idx;
> > >
> > > -       if (die_get_attr_sdata(in_die, DW_AT_call_file, &idx) == 0)
> > > +       if (die_get_attr_udata(in_die, DW_AT_call_file, &idx) == 0)
> > >                 return (int)idx;
> > >         else
> > >                 return -ENOENT;
> > > @@ -478,9 +465,9 @@ static int die_get_call_fileno(Dwarf_Die *in_die)
> > >  /* Get the declared file index number in CU DIE */
> > >  static int die_get_decl_fileno(Dwarf_Die *pdie)
> > >  {
> > > -       Dwarf_Sword idx;
> > > +       Dwarf_Word idx;
> > >
> > > -       if (die_get_attr_sdata(pdie, DW_AT_decl_file, &idx) == 0)
> > > +       if (die_get_attr_udata(pdie, DW_AT_decl_file, &idx) == 0)
> > >                 return (int)idx;
> > >         else
> > >                 return -ENOENT;
> > >
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
