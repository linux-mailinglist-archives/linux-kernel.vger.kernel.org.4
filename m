Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C8D69C2C6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjBSVqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjBSVqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:46:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547401817C;
        Sun, 19 Feb 2023 13:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8BC5B80A4A;
        Sun, 19 Feb 2023 21:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25B4C433EF;
        Sun, 19 Feb 2023 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676843188;
        bh=3dp2VRTM0rgvICutBpNvI63cxeHrXXr97AsrP7/6Wkc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u7etGimJO+tqv0kZha74A5d5ZJ8bxMq2RQYnK+r8nmnEaDp1mS4EaUFX1D9ZtuNQa
         pRuGfdwnsZDt06ReZjMTWqk0wtD4+a+ThPFxR4FKIZjVHTWHzqKb/flbYw1TpvyVu1
         Ue8fortwOZHR5OGNYBV/362bQCgzHNAmu1vZsOZAWZeysUrmfiw+rGz+9dhdzDdbM2
         oLSv8gMA1MgNEByx0i0uM5G6pkJa+a22OMCRd7dXDNp388bF3aAA0aAI6MVkMGGh2F
         KQTTcG8m3ycxpHYBK9M3bbgpPBHw/HekkkPSiUgGVV72j2qMIi17NWYpMVYPtbEq2/
         u1sajKhCZcyhQ==
Message-ID: <06c77bca76cd5679c8cd459480621b7db21f3a7b.camel@kernel.org>
Subject: Re: [PATCH] tracing: Check for NULL field_name in
 __synth_event_add_val()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, ionut_n2001@yahoo.com
Date:   Sun, 19 Feb 2023 15:46:24 -0600
In-Reply-To: <20230218105921.12ddb86f@gandalf.local.home>
References: <20230218105921.12ddb86f@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Sat, 2023-02-18 at 10:59 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>=20
> It is possible that the field_name passed into
> __synth_event_add_val() can
> be NULL with the trace_state set to add_name (possibly set from a
> previous
> call), in which case it needs to be checked.

Hmm, I don't think this really is possible, see below...

>=20
> Cc: stable@vger.kernel.org
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D217053
> Fixes: 8dcc53ad956d2 ("tracing: Add synth_event_trace() and related
> functions")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>=20
> Tom, can you review this. Is there a legitimate case where you can
> have a
> previous call set "add_name" but the next call not require it? This
> patch
> assumes that it can't.
>=20

No, because this code just above it makes sure you can't mix add_name
with add_next.  Once add_name is set it will return -EINVAL if
field_name is ever null after that, and add_name will never be changed
once set:

       /* can't mix add_next_synth_val() with add_synth_val() */
        if (field_name) {
                if (trace_state->add_next) {
                        ret =3D -EINVAL;
                        goto out;
                }
                trace_state->add_name =3D true;
        } else {
                if (trace_state->add_name) {
                        ret =3D -EINVAL;
                        goto out;
                }
                trace_state->add_next =3D true;
        }


> =C2=A0kernel/trace/trace_events_synth.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/kernel/trace/trace_events_synth.c
> b/kernel/trace/trace_events_synth.c
> index 70bddb25d9c0..fa28c1da06d2 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -1982,6 +1982,10 @@ static int __synth_event_add_val(const char
> *field_name, u64 val,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0event =3D trace_state->ev=
ent;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (trace_state->add_name=
) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (!field_name) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -=
EINVAL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0}

So if add_name is set here, it must also mean that field_name can't be
null, because of the above.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < event->n_fields; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fie=
ld =3D event->fields[i];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(strcmp(field->name, field_name) =3D=3D 0)

And if field_name can't be null, then I don't see how this strcmp could
fail due to a null field_name.

So I don't see the need for this patch.  The bugzilla shows a compiler
warning when using -Wnonnull - could this just be a spurious gcc
warning?

Tom
