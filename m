Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46E68AAAD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjBDOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBDOt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:49:28 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F511653;
        Sat,  4 Feb 2023 06:49:26 -0800 (PST)
Date:   Sat, 4 Feb 2023 08:49:11 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675522164;
        bh=+iTHfkfAqDhl9s1HhmjZ+Y7a963hdigzz6u9+d6JjAQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=K/uDBxsX4KOWULg4aUe5C21x7zd7bF/UNsofGRKx6jVVFVRHG2/xJDAgLcmkAa9FE
         kN9oH40DEKixX04L86t3Tfk6gwaB5Peh6QHFbd85kW57Jmr7xz30Dkxa+lQtzmL6pe
         1bVX8y761MOkcRmHAumBtSbGCHHu2yP5IgMAzI08=
From:   linux@weissschuh.net
To:     Jason Baron <jbaron@akamai.com>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Message-ID: <c0b009e8-0b12-4605-83fa-ceb3cb27922f@weissschuh.net>
In-Reply-To: <04311d93-7cb4-bf0b-dfa7-162a38b42583@akamai.com>
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net> <20221223-dyndbg-filename-v1-3-cbf8543009a1@weissschuh.net> <04311d93-7cb4-bf0b-dfa7-162a38b42583@akamai.com>
Subject: Re: [PATCH 3/3] dyndbg: add source filename to prefix
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <c0b009e8-0b12-4605-83fa-ceb3cb27922f@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,


Feb 3, 2023 10:45:49 Jason Baron <jbaron@akamai.com>:

> Hi Thomas,
>
> Thanks for this series, this series is fine with me:
> Acked-by: Jason Baron <jbaron@akamai.com>

Thanks!

> Your comment about making the output more relatable to the control file m=
ade me think if we should try and make the logged output look more like the=
 control file:
>
> # cat /proc/dynamic_debug/control
> # filename:lineno [module]function flags format
>
> So for your example, I think that would look like:
>
> [=C2=A0=C2=A0 71.802212] lib/test_dynamic_debug.c:103 do_cats: test_dd: d=
oing categories
> [=C2=A0=C2=A0 71.802227] lib/test_dynamic_debug.c:123 do_levels: doing le=
vels
>
> But even if we think it looks better, there maybe too many dependencies o=
n the current output format...

I agree on both points.

An alternative could be a new flag that prints the
full format from the control file.
The control file even has a format header that
tools could use to parse out the fields, making it
extensible.

Not sure it's worth it though.
And it should be in addition to this series in my
opinion.

Thomas

> Thanks,
>
> -Jason
>
> On 1/29/23 9:01 PM, Thomas Wei=C3=9Fschuh wrote:
>> Printing the line number without the file is of limited usefulness.
>> Knowing the filename also makes it also easier to relate the logged
>> information to the controlfile.
>> Example:
>> =C2=A0=C2=A0=C2=A0=C2=A0 # modprobe test_dynamic_debug
>> =C2=A0=C2=A0=C2=A0=C2=A0 # echo 'file test_dynamic_debug.c =3Dpfsl' > /p=
roc/dynamic_debug/control
>> =C2=A0=C2=A0=C2=A0=C2=A0 # echo 1 > /sys/module/test_dynamic_debug/param=
eters/do_prints
>> =C2=A0=C2=A0=C2=A0=C2=A0 # dmesg | tail -2
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 71.802212] do_cats:lib/test_dynam=
ic_debug.c:103: test_dd: doing categories
>> =C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=A0 71.802227] do_levels:lib/test_dyn=
amic_debug.c:123: test_dd: doing levels
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> ---
>> =C2=A0 Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
>> =C2=A0 include/linux/dynamic_debug.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 4 +++-
>> =C2=A0 lib/dynamic_debug.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
>> =C2=A0 3 files changed, 10 insertions(+), 3 deletions(-)
>> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documen=
tation/admin-guide/dynamic-debug-howto.rst
>> index faa22f77847a..f9fa8163fba6 100644
>> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
>> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
>> @@ -216,13 +216,14 @@ The flags are::
>> =C2=A0=C2=A0=C2=A0 t=C2=A0=C2=A0=C2=A0 Include thread ID, or <intr>
>> =C2=A0=C2=A0=C2=A0 m=C2=A0=C2=A0=C2=A0 Include module name
>> =C2=A0=C2=A0=C2=A0 f=C2=A0=C2=A0=C2=A0 Include the function name
>> +=C2=A0 s=C2=A0=C2=A0=C2=A0 Include the source file name
>> =C2=A0=C2=A0=C2=A0 l=C2=A0=C2=A0=C2=A0 Include line number
>> =C2=A0=C2=A0=C2=A0 For ``print_hex_dump_debug()`` and ``print_hex_dump_b=
ytes()``, only
>> =C2=A0 the ``p`` flag has meaning, other flags are ignored.
>> =C2=A0 -Note the regexp ``^[-+=3D][flmpt_]+$`` matches a flags specifica=
tion.
>> -To clear all flags at once, use ``=3D_`` or ``-flmpt``.
>> +Note the regexp ``^[-+=3D][fslmpt_]+$`` matches a flags specification.
>> +To clear all flags at once, use ``=3D_`` or ``-fslmpt``.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debug messages during Boot Process
>> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug=
.h
>> index 41682278d2e8..0c77105d583c 100644
>> --- a/include/linux/dynamic_debug.h
>> +++ b/include/linux/dynamic_debug.h
>> @@ -37,10 +37,12 @@ struct _ddebug {
>> =C2=A0 #define _DPRINTK_FLAGS_INCL_FUNCNAME=C2=A0 (1<<2)
>> =C2=A0 #define _DPRINTK_FLAGS_INCL_LINENO=C2=A0=C2=A0=C2=A0 (1<<3)
>> =C2=A0 #define _DPRINTK_FLAGS_INCL_TID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (1<<4)
>> +#define _DPRINTK_FLAGS_INCL_SOURCENAME (1<<5)
>> =C2=A0=C2=A0=C2=A0 #define _DPRINTK_FLAGS_INCL_ANY=C2=A0=C2=A0=C2=A0=C2=
=A0 \
>> =C2=A0=C2=A0=C2=A0 (_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FU=
NCNAME |\
>> -=C2=A0=C2=A0=C2=A0 _DPRINTK_FLAGS_INCL_LINENO=C2=A0 | _DPRINTK_FLAGS_IN=
CL_TID)
>> +=C2=A0=C2=A0=C2=A0 _DPRINTK_FLAGS_INCL_LINENO=C2=A0 | _DPRINTK_FLAGS_IN=
CL_TID |\
>> +=C2=A0=C2=A0=C2=A0 _DPRINTK_FLAGS_INCL_SOURCENAME)
>> =C2=A0=C2=A0=C2=A0 #if defined DEBUG
>> =C2=A0 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
>> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
>> index e96ea427d8af..fa7418e35197 100644
>> --- a/lib/dynamic_debug.c
>> +++ b/lib/dynamic_debug.c
>> @@ -92,6 +92,7 @@ static const struct { unsigned flag:8; char opt_char; =
} opt_array[] =3D {
>> =C2=A0=C2=A0=C2=A0 { _DPRINTK_FLAGS_PRINT, 'p' },
>> =C2=A0=C2=A0=C2=A0 { _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
>> =C2=A0=C2=A0=C2=A0 { _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
>> +=C2=A0=C2=A0 { _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
>> =C2=A0=C2=A0=C2=A0 { _DPRINTK_FLAGS_INCL_LINENO, 'l' },
>> =C2=A0=C2=A0=C2=A0 { _DPRINTK_FLAGS_INCL_TID, 't' },
>> =C2=A0=C2=A0=C2=A0 { _DPRINTK_FLAGS_NONE, '_' },
>> @@ -836,6 +837,9 @@ static char *__dynamic_emit_prefix(const struct _dde=
bug *desc, char *buf)
>> =C2=A0=C2=A0=C2=A0 if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos +=3D snprintf(buf + pos, =
remaining(pos), "%s:",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 desc->function);
>> +=C2=A0=C2=A0 if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos +=3D snprintf(buf + pos, remai=
ning(pos), "%s:",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 trim_prefix(desc->filename));
>> =C2=A0=C2=A0=C2=A0 if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos +=3D snprintf(buf + pos, =
remaining(pos), "%d:",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 desc->lineno);
>>

