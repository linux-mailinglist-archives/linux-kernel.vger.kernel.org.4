Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB173AC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjFVWFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVWFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:05:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DBF1BE1;
        Thu, 22 Jun 2023 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1687471481; x=1688076281; i=georgmueller@gmx.net;
 bh=Duee4IHsvqsOZrFYxTThyaj1WAdJHZ0zDPuyT5Olkbw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EKAcIDj3DALBZ6ughPPBIgctYVu3rqtN9xDZc5c39CQZ3Q6PlZv7diyWWKQn2qJhOe/zmvF
 d4E5uu1q4og+iJ+7Uxj10fQCogczGmoAbul6oahYM4AAIG/qM1ONh93H3UKc1dWdwW/VhtD8B
 k/HYgHKX55v3eGVLfRWV1LJJQAWrFfXaRRIqolkQ0nl1FH1+d9y16WKROvQ+C2RLVYf9T+X2O
 gHxVhHIptb3YPpLFcSgF/55wgMQZvrOjOjydofnzq++n/DL3QhwgP7CQ5S15w5n6kVm8PPQs8
 XaizzTgbxkgWouSc5c5k7UiXPeUyXycQGYR9/FoZSsS0WoLL1dFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.15.55] ([109.104.53.29]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1pyYFq3UZS-015n5L; Fri, 23
 Jun 2023 00:04:40 +0200
Message-ID: <ae2b7129-a651-1066-0400-d16998ca250d@gmx.net>
Date:   Fri, 23 Jun 2023 00:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] perf probe: read DWARF files from the correct CU
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     regressions@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230615200147.664346-3-georgmueller@gmx.net>
From:   =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>
In-Reply-To: <20230615200147.664346-3-georgmueller@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CGzNQA5VKVg8/XNmIu8EvM5cgqaAQMV8CHz0wbKjkk2KM5vx08Z
 gwpdv+WpRTMxgAXYJNWOsJgUPNgpn6rOzaXctEj7sEZCuus3yOuaN/zivjcRHB2RpB8F9/h
 ZAtbHzfDv6MGtvs0Z4IPexWrE5+X18flr2+cY2g+6a2HaJqbqcnNoGwne3RW1dvHl3+c6Lo
 tPX11XlrimG9eO7PXUyJA==
UI-OutboundReport: notjunk:1;M01:P0:pt4aDP4iPyE=;k666ZWdw+6F94Sr4d3fbsbj/jee
 WlfQHA5S9WU/ymkmaGWXMO4b+Xe4bh7+x61dgl3jPdD+L3oRmGZbRpRx68/+EjudNOGV5t7Hv
 JaBvRrEoXL/HZcSVKl598ChkYwfUwa2H/PkDXVwVQHaCr8IEekLMrIh+5bJTxe18QcH0krenW
 UNidUmFpOyivLfC5KSqsnjGJLheV6haiI1p7eYR/UjB/gFOufG1bJxUxe9tUJoDzmI1Oo6jZ1
 FL6fN1+rcNRe3izOXP952WdwsJOqHtBlPOK45AFFk+dlFuBfudTa+1TVBAP4TOUoRWCIgoNCH
 pmn2ful/Sqm3oWk72BOLWBLWiJkDvYQhDyAfusbWyY8Osrzl/y6HMND17t/gSWBZUrZp3R5NI
 ubPJmLZlquKjoDvfKSaQIz53VSy64NkDNrZ/YNIFcqKpsXQWRkTybgwRAw2l/Rt/F8cfsTsDZ
 Z2xOLXIs4I7MzI3h/+ak18GZ9iuQwBcXIqbwQCdnWGGC/8Ndi+BLZI2YGjRgYrDF5FQkydJ9j
 nHzhkbyxroWFIR1NrxjX1guLbh8DVetFtoYzA1Ckvs4rVZ4QlyIaHcPTK159bO3qpVqZNBZ7T
 T7zLgVVgk9AtgtnMBpl9BYd1CEqCGtN2Uo9m56kqsYOtmaxudwq0tzoAEFvkle9W8VxHGk46D
 stwyYDXjQjpbUM3Qmd/JAD8oDt9j1OR2Xcl21wBkRcaVFXOKPWtDpSFWB3FHUBYPmBoHm582U
 dMfSK8aJiiZUJI/iUpNzOLK9phq9ElWDkKUssDeIJkKSnbsklf1j4Q0JQZcH4bUUuvOktrXxq
 JcTwnSAO4tzdVainsMt3KdlEnHXzWskoOkb7UuJvq1WsQFCLFgUwikEet1EoJhAnGs7+Ufii/
 KxsW/KF3iz2Fwvool7n1JuE6RzApD0UcGsJ1hVk/SbSsPwZWunLfNFCyfxwia8IsI3oh2P0gg
 X+SOg0i4uT/ZU/a2khkjbBqNsYE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Am 15.06.23 um 22:01 schrieb Georg M=C3=BCller:
> After switching from dwarf_decl_file() to die_get_decl_file(), it is not
> possible to add probes for certain functions of certain binaries:
>
>   $ perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
>   A function DIE doesn't have decl_line. Maybe broken DWARF?
>   A function DIE doesn't have decl_line. Maybe broken DWARF?
>   Probe point 'match_unit_removed' not found.
>      Error: Failed to add events.
>
> The problem is that die_get_decl_file() uses the wrong CU to search for
> the file. elfutils commit e1db5cdc9f has some good explanation for this:
>
>      dwarf_decl_file uses dwarf_attr_integrate to get the DW_AT_decl_fil=
e
>      attribute. This means the attribute might come from a different DIE
>      in a different CU. If so, we need to use the CU associated with the
>      attribute, not the original DIE, to resolve the file name.
>
> This patch uses the same source of information as elfutils: use attribut=
e
> DW_AT_decl_file and use this CU to search for the file.
>
> Fixes: dc9a5d2ccd5c ("perf probe: Fix to get declared file name from cla=
ng DWARF5")
> Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
> Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx=
.net/
> ---
>   tools/perf/util/dwarf-aux.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index b07414409771..137b3ed9897b 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -478,8 +478,10 @@ static const char *die_get_file_name(Dwarf_Die *dw_=
die, int idx)
>   {
>   	Dwarf_Die cu_die;
>   	Dwarf_Files *files;
> +	Dwarf_Attribute attr_mem;
>
> -	if (idx < 0 || !dwarf_diecu(dw_die, &cu_die, NULL, NULL) ||
> +	if (idx < 0 || !dwarf_attr_integrate(dw_die, DW_AT_decl_file, &attr_me=
m) ||
> +	    !dwarf_cu_die(attr_mem.cu, &cu_die, NULL, NULL, NULL, NULL, NULL, =
NULL) ||
>   	    dwarf_getsrcfiles(&cu_die, &files, NULL) !=3D 0)
>   		return NULL;
>
> --
> 2.41.0
>


Just a question regarding the patch:
Should I also add a testcase to show the issue or is this enough? It can b=
e
reproduced quite simple with two .c files and one .h file, the same test a=
s the
one added in elfutils with commit e1db5cdc9f, compiled with the same three=
 steps
as in the comment of the shell script, but without "-flto":

https://sourceware.org/git/?p=3Delfutils.git;a=3Dcommitdiff;h=3De1db5cdc9f=
230f8de4df1a0f38dca69b283ee57a

Best regards,
Georg
